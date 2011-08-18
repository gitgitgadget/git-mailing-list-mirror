From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/4] mergetool--lib: Make style consistent with git
Date: Thu, 18 Aug 2011 00:23:45 -0700
Message-ID: <1313652227-48545-3-git-send-email-davvid@gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:24:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtwxb-0005MS-U9
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab1HRHYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 03:24:12 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:33028 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab1HRHYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 03:24:09 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so3440638iye.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 00:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2csqovCAw8LNQjhQA2GZDPAmXuRMducGMA8mQUaQYfY=;
        b=m8z9WhAHSrKgwKGTu3v/1m6xP0qTiyHI0IUL4FyhId5vwRoTdAf4x5JR/Lym2+eSHY
         oyFCjC/mcOx/J/YPlFE/RerniXpyz6ipr7Pr5hW5ila9mJ4eBzMA2VVKyOu+8Q/dauWl
         wmcITK2GhX3d20SUCve978mWB1BLvytXlZX7c=
Received: by 10.42.168.132 with SMTP id w4mr441578icy.390.1313652248712;
        Thu, 18 Aug 2011 00:24:08 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id hq1sm1677692icc.14.2011.08.18.00.24.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 00:24:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.476.g57292
In-Reply-To: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179574>

Use the predominant conditional style where "then" appears
alone on the line after the test expression.
Remove spaces after ">" output redirections.
Remove unnecessary parentheses around the kdiff3 commands.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh |  153 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 100 insertions(+), 53 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 91f90ac..03cfb19 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -32,10 +32,12 @@ translate_merge_tool_path () {
 }
 
 check_unchanged () {
-	if test "$MERGED" -nt "$BACKUP"; then
+	if test "$MERGED" -nt "$BACKUP"
+	then
 		status=0
 	else
-		while true; do
+		while true
+		do
 			echo "$MERGED seems unchanged."
 			printf "Was the merge successful? [y/n] "
 			read answer
@@ -53,17 +55,20 @@ valid_tool () {
 	kdiff3 | meld | opendiff | p4merge | tkdiff | vimdiff | vimdiff2 | xxdiff)
 		;; # happy
 	kompare)
-		if ! diff_mode; then
+		if ! diff_mode
+		then
 			return 1
 		fi
 		;;
 	tortoisemerge)
-		if ! merge_mode; then
+		if ! merge_mode
+		then
 			return 1
 		fi
 		;;
 	*)
-		if test -z "$(get_merge_tool_cmd "$1")"; then
+		if test -z "$(get_merge_tool_cmd "$1")"
+		then
 			return 1
 		fi
 		;;
@@ -72,12 +77,14 @@ valid_tool () {
 
 get_merge_tool_cmd () {
 	# Prints the custom command for a merge tool
-	if test -n "$1"; then
+	if test -n "$1"
+	then
 		merge_tool="$1"
 	else
 		merge_tool="$(get_merge_tool)"
 	fi
-	if diff_mode; then
+	if diff_mode
+	then
 		echo "$(git config difftool.$merge_tool.cmd ||
 		        git config mergetool.$merge_tool.cmd)"
 	else
@@ -97,9 +104,11 @@ run_merge_tool () {
 
 	case "$1" in
 	araxis)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
-			if $base_present; then
+			if $base_present
+			then
 				"$merge_tool_path" -wait -merge -3 -a1 \
 					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
 					>/dev/null 2>&1
@@ -115,9 +124,11 @@ run_merge_tool () {
 		fi
 		;;
 	bc3)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
-			if $base_present; then
+			if $base_present
+			then
 				"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
 					-mergeoutput="$MERGED"
 			else
@@ -130,9 +141,11 @@ run_merge_tool () {
 		fi
 		;;
 	diffuse)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
-			if $base_present; then
+			if $base_present
+			then
 				"$merge_tool_path" \
 					"$LOCAL" "$MERGED" "$REMOTE" \
 					"$BASE" | cat
@@ -146,9 +159,11 @@ run_merge_tool () {
 		fi
 		;;
 	ecmerge)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
-			if $base_present; then
+			if $base_present
+			then
 				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
 					--default --mode=merge3 --to="$MERGED"
 			else
@@ -162,8 +177,10 @@ run_merge_tool () {
 		fi
 		;;
 	emerge)
-		if merge_mode; then
-			if $base_present; then
+		if merge_mode
+		then
+			if $base_present
+			then
 				"$merge_tool_path" \
 					-f emerge-files-with-ancestor-command \
 					"$LOCAL" "$REMOTE" "$BASE" \
@@ -181,9 +198,11 @@ run_merge_tool () {
 		fi
 		;;
 	gvimdiff|vimdiff)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
-			if $base_present; then
+			if $base_present
+			then
 				"$merge_tool_path" -f -d -c "wincmd J" \
 					"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
 			else
@@ -198,7 +217,8 @@ run_merge_tool () {
 		fi
 		;;
 	gvimdiff2|vimdiff2)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
 			"$merge_tool_path" -f -d -c "wincmd l" \
 				"$LOCAL" "$MERGED" "$REMOTE"
@@ -210,36 +230,39 @@ run_merge_tool () {
 		fi
 		;;
 	kdiff3)
-		if merge_mode; then
-			if $base_present; then
-				("$merge_tool_path" --auto \
+		if merge_mode
+		then
+			if $base_present
+			then
+				"$merge_tool_path" --auto \
 					--L1 "$MERGED (Base)" \
 					--L2 "$MERGED (Local)" \
 					--L3 "$MERGED (Remote)" \
 					-o "$MERGED" \
 					"$BASE" "$LOCAL" "$REMOTE" \
-				> /dev/null 2>&1)
+				>/dev/null 2>&1
 			else
-				("$merge_tool_path" --auto \
+				"$merge_tool_path" --auto \
 					--L1 "$MERGED (Local)" \
 					--L2 "$MERGED (Remote)" \
 					-o "$MERGED" \
 					"$LOCAL" "$REMOTE" \
-				> /dev/null 2>&1)
+				>/dev/null 2>&1
 			fi
 			status=$?
 		else
-			("$merge_tool_path" --auto \
+			"$merge_tool_path" --auto \
 				--L1 "$MERGED (A)" \
 				--L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
-			> /dev/null 2>&1)
+			>/dev/null 2>&1
 		fi
 		;;
 	kompare)
 		"$merge_tool_path" "$LOCAL" "$REMOTE"
 		;;
 	meld)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
 			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
@@ -248,9 +271,11 @@ run_merge_tool () {
 		fi
 		;;
 	opendiff)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
-			if $base_present; then
+			if $base_present
+			then
 				"$merge_tool_path" "$LOCAL" "$REMOTE" \
 					-ancestor "$BASE" \
 					-merge "$MERGED" | cat
@@ -264,7 +289,8 @@ run_merge_tool () {
 		fi
 		;;
 	p4merge)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
 			$base_present || >"$BASE"
 			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
@@ -274,8 +300,10 @@ run_merge_tool () {
 		fi
 		;;
 	tkdiff)
-		if merge_mode; then
-			if $base_present; then
+		if merge_mode
+		then
+			if $base_present
+			then
 				"$merge_tool_path" -a "$BASE" \
 					-o "$MERGED" "$LOCAL" "$REMOTE"
 			else
@@ -288,7 +316,8 @@ run_merge_tool () {
 		fi
 		;;
 	tortoisemerge)
-		if $base_present; then
+		if $base_present
+		then
 			touch "$BACKUP"
 			"$merge_tool_path" \
 				-base:"$BASE" -mine:"$LOCAL" \
@@ -300,9 +329,11 @@ run_merge_tool () {
 		fi
 		;;
 	xxdiff)
-		if merge_mode; then
+		if merge_mode
+		then
 			touch "$BACKUP"
-			if $base_present; then
+			if $base_present
+			then
 				"$merge_tool_path" -X --show-merged-pane \
 					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
 					-R 'Accel.Search: "Ctrl+F"' \
@@ -327,16 +358,20 @@ run_merge_tool () {
 		;;
 	*)
 		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
-		if test -z "$merge_tool_cmd"; then
-			if merge_mode; then
+		if test -z "$merge_tool_cmd"
+		then
+			if merge_mode
+			then
 				status=1
 			fi
 			break
 		fi
-		if merge_mode; then
+		if merge_mode
+		then
 			trust_exit_code="$(git config --bool \
 				mergetool."$1".trustExitCode || echo false)"
-			if test "$trust_exit_code" = "false"; then
+			if test "$trust_exit_code" = "false"
+			then
 				touch "$BACKUP"
 				( eval $merge_tool_cmd )
 				check_unchanged
@@ -353,13 +388,16 @@ run_merge_tool () {
 }
 
 guess_merge_tool () {
-	if merge_mode; then
+	if merge_mode
+	then
 		tools="tortoisemerge"
 	else
 		tools="kompare"
 	fi
-	if test -n "$DISPLAY"; then
-		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
+	if test -n "$DISPLAY"
+	then
+		if test -n "$GNOME_DESKTOP_SESSION_ID"
+		then
 			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
@@ -380,7 +418,8 @@ guess_merge_tool () {
 	for i in $tools
 	do
 		merge_tool_path="$(translate_merge_tool_path "$i")"
-		if type "$merge_tool_path" > /dev/null 2>&1; then
+		if type "$merge_tool_path" >/dev/null 2>&1
+		then
 			echo "$i"
 			return 0
 		fi
@@ -393,12 +432,14 @@ guess_merge_tool () {
 get_configured_merge_tool () {
 	# Diff mode first tries diff.tool and falls back to merge.tool.
 	# Merge mode only checks merge.tool
-	if diff_mode; then
+	if diff_mode
+	then
 		merge_tool=$(git config diff.tool || git config merge.tool)
 	else
 		merge_tool=$(git config merge.tool)
 	fi
-	if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
+	if test -n "$merge_tool" && ! valid_tool "$merge_tool"
+	then
 		echo >&2 "git config option $TOOL_MODE.tool set to unknown tool: $merge_tool"
 		echo >&2 "Resetting to default..."
 		return 1
@@ -408,26 +449,31 @@ get_configured_merge_tool () {
 
 get_merge_tool_path () {
 	# A merge tool has been set, so verify that it's valid.
-	if test -n "$1"; then
+	if test -n "$1"
+	then
 		merge_tool="$1"
 	else
 		merge_tool="$(get_merge_tool)"
 	fi
-	if ! valid_tool "$merge_tool"; then
+	if ! valid_tool "$merge_tool"
+	then
 		echo >&2 "Unknown merge tool $merge_tool"
 		exit 1
 	fi
-	if diff_mode; then
+	if diff_mode
+	then
 		merge_tool_path=$(git config difftool."$merge_tool".path ||
 		                  git config mergetool."$merge_tool".path)
 	else
 		merge_tool_path=$(git config mergetool."$merge_tool".path)
 	fi
-	if test -z "$merge_tool_path"; then
+	if test -z "$merge_tool_path"
+	then
 		merge_tool_path="$(translate_merge_tool_path "$merge_tool")"
 	fi
 	if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
-	! type "$merge_tool_path" > /dev/null 2>&1; then
+		! type "$merge_tool_path" >/dev/null 2>&1
+	then
 		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as"\
 		         "'$merge_tool_path'"
 		exit 1
@@ -439,7 +485,8 @@ get_merge_tool () {
 	# Check if a merge tool has been configured
 	merge_tool=$(get_configured_merge_tool)
 	# Try to guess an appropriate merge tool if no tool has been set.
-	if test -z "$merge_tool"; then
+	if test -z "$merge_tool"
+	then
 		merge_tool="$(guess_merge_tool)" || exit
 	fi
 	echo "$merge_tool"
-- 
1.7.6.476.g57292
