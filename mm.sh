#!/bin/env bash
get() {
	link=$(curl -s https://mehlmanmedical.com/?s="$1" | grep --only-match "https://mehlmanmedical.com/hy-usmle-q-$1-[^/]*/" | head -n 1)
	echo "opening the $link"
	curl -s "$link" -o temp.html
	grep -A 20 "<div class=\"entry-content\">" temp.html  | grep "<p>" | sed 's/<p>//g; s/<\/p>//g'
	grep -A 20 "<div class=\"entry-content\">" temp.html  | grep "radio" | grep --only-match -E ">[^<]*</span></div>$" | sed 's/<\/span><\/div>//g'
}
clear
get $1
rm temp.html
