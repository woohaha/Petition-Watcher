#!/bin/bash

getVote(){
	curl -o /tmp/$timeStamp $1 >/dev/null 2>&1|| exit 1
	cat /tmp/$timeStamp | grep -Poh '(?<=num-block2\">).*(?=</div>)' | sed 's/,//g'
}

echo -n 'Watching Petition: '
echo $1|awk -F "/" '{print $5}' |sed 's/-/\ /g'
votePrevious=0
while [ 1 ];do
	timeStamp=$(date +%H%M%N)
	votesNow=$(getVote $1)
	echo -n "$votesNow votes"
	voteRate=$(($votesNow-$votePrevious))
	echo ", $voteRate votes per min"
	votePrevious=$votesNow
	rm /tmp/$timeStamp
	sleep 60
done
	
