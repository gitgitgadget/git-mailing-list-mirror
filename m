From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 08/31] rebase: align variable names
Date: Sun,  6 Feb 2011 13:43:37 -0500
Message-ID: <1297017841-20678-9-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:46:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9ch-0004j0-6J
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab1BFSqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:03 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab1BFSqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:00 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ZjAsyY7pbAN1TsN4ob27Mty8YeZ43UXUfjdiKxM13uE=;
        b=kGSx+GpwPk3ay5jkV1mewmK4uVdHwMeA+5naCfGuUgD9PcBGX23tYE4gd2HoRAlwLB
         i0kri9jhTMrotJvSzw/1dS7tcb9tWgMRSCDK9HlsvdOKSlc7mOGWAmx2VK65HIuSLvJr
         3YsmqpO0MgzaDxDHJsUlQKHf4g2xxlqM8zhB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ORMxPBiasBB78yBLKRTxWahXwu3LcJo5EnD5IcD3QVXfhmh/loYybvZOAMwpCIOuY4
         4Ivxfd0haMvKMeExm7pq/Sfs05SuFo5Dr7/siul89MbKSo8EUdX054kNPEanPhyzrsTp
         22IkxP6/KCoORcao5YFpAtTZcqV28ylxAmY5A=
Received: by 10.224.80.143 with SMTP id t15mr13302395qak.41.1297017959975;
        Sun, 06 Feb 2011 10:45:59 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.45.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:45:58 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166167>

git-rebase--interactive.sh will soon be sourced from
git-rebase.sh. Align the names of variables used in these scripts to
prepare for that.

Some names in git-rebase--interactive.sh, such as "author_script" and
"amend", are currently used in their upper case form to refer to a
file and in their lower case form to refer to something else. In these
cases, change the name of the existing lower case variable and
downcase the name of the variable that refers to the file.

Currently, git-rebase.sh uses mostly lower case variable names, while
git-rebase--interactive.sh uses mostly upper case variable names. For
consistency, downcase all variables, not just the ones that will be
shared between the two script files.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Changes since v1:

 * As suggested by Thomas, downcase *all* variables, so that the end
   result looks consistent.

 git-rebase--interactive.sh |  480 ++++++++++++++++++++++----------------------
 git-rebase.sh              |   32 ++--
 2 files changed, 256 insertions(+), 256 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 824f4f3..2fa348b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -36,22 +36,22 @@ autosquash         move commits that begin with squash!/fixup! under -i
 . git-sh-setup
 require_work_tree
 
-DOTEST="$GIT_DIR/rebase-merge"
+dotest="$GIT_DIR/rebase-merge"
 
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
 # the lines are processed, they are removed from the front of this
-# file and written to the tail of $DONE.
-TODO="$DOTEST"/git-rebase-todo
+# file and written to the tail of $done.
+todo="$dotest"/git-rebase-todo
 
 # The rebase command lines that have already been processed.  A line
 # is moved here when it is first handled, before any associated user
 # actions.
-DONE="$DOTEST"/done
+done="$dotest"/done
 
 # The commit message that is planned to be used for any changes that
 # need to be committed following a user interaction.
-MSG="$DOTEST"/message
+msg="$dotest"/message
 
 # The file into which is accumulated the suggested commit message for
 # squash/fixup commands.  When the first of a series of squash/fixups
@@ -61,34 +61,34 @@ MSG="$DOTEST"/message
 # is appended to the file as it is processed.
 #
 # The first line of the file is of the form
-#     # This is a combination of $COUNT commits.
-# where $COUNT is the number of commits whose messages have been
+#     # This is a combination of $count commits.
+# where $count is the number of commits whose messages have been
 # written to the file so far (including the initial "pick" commit).
 # Each time that a commit message is processed, this line is read and
 # updated.  It is deleted just before the combined commit is made.
-SQUASH_MSG="$DOTEST"/message-squash
+squash_msg="$dotest"/message-squash
 
 # If the current series of squash/fixups has not yet included a squash
 # command, then this file exists and holds the commit message of the
 # original "pick" commit.  (If the series ends without a "squash"
 # command, then this can be used as the commit message of the combined
 # commit without opening the editor.)
-FIXUP_MSG="$DOTEST"/message-fixup
+fixup_msg="$dotest"/message-fixup
 
-# $REWRITTEN is the name of a directory containing files for each
-# commit that is reachable by at least one merge base of $HEAD and
-# $UPSTREAM. They are not necessarily rewritten, but their children
+# $rewritten is the name of a directory containing files for each
+# commit that is reachable by at least one merge base of $head and
+# $upstream. They are not necessarily rewritten, but their children
 # might be.  This ensures that commits on merged, but otherwise
 # unrelated side branches are left alone. (Think "X" in the man page's
 # example.)
-REWRITTEN="$DOTEST"/rewritten
+rewritten="$dotest"/rewritten
 
-DROPPED="$DOTEST"/dropped
+dropped="$dotest"/dropped
 
 # A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE that will be used for the commit that is currently
 # being rebased.
-AUTHOR_SCRIPT="$DOTEST"/author-script
+author_script="$dotest"/author-script
 
 # When an "edit" rebase command is being processed, the SHA1 of the
 # commit to be edited is recorded in this file.  When "git rebase
@@ -96,24 +96,24 @@ AUTHOR_SCRIPT="$DOTEST"/author-script
 # will be amended to the HEAD commit, but only provided the HEAD
 # commit is still the commit to be edited.  When any other rebase
 # command is processed, this file is deleted.
-AMEND="$DOTEST"/amend
+amend="$dotest"/amend
 
 # For the post-rewrite hook, we make a list of rewritten commits and
 # their new sha1s.  The rewritten-pending list keeps the sha1s of
 # commits that have been processed, but not committed yet,
 # e.g. because they are waiting for a 'squash' command.
-REWRITTEN_LIST="$DOTEST"/rewritten-list
-REWRITTEN_PENDING="$DOTEST"/rewritten-pending
-
-PRESERVE_MERGES=
-STRATEGY=
-ONTO=
-VERBOSE=
-OK_TO_SKIP_PRE_REBASE=
-REBASE_ROOT=
-AUTOSQUASH=
-test "$(git config --bool rebase.autosquash)" = "true" && AUTOSQUASH=t
-NEVER_FF=
+rewritten_list="$dotest"/rewritten-list
+rewritten_pending="$dotest"/rewritten-pending
+
+preserve_merges=
+strategy=
+onto=
+verbose=
+ok_to_skip_pre_rebase=
+rebase_root=
+autosquash=
+test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+force_rebase=
 
 GIT_CHERRY_PICK_HELP="\
 hint: after resolving the conflicts, mark the corrected paths
@@ -125,7 +125,7 @@ warn () {
 }
 
 output () {
-	case "$VERBOSE" in
+	case "$verbose" in
 	'')
 		output=$("$@" 2>&1 )
 		status=$?
@@ -144,7 +144,7 @@ commit_message () {
 }
 
 run_pre_rebase_hook () {
-	if test -z "$OK_TO_SKIP_PRE_REBASE" &&
+	if test -z "$ok_to_skip_pre_rebase" &&
 	   test -x "$GIT_DIR/hooks/pre-rebase"
 	then
 		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
@@ -155,10 +155,10 @@ run_pre_rebase_hook () {
 }
 
 
-ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
+orig_reflog_action="$GIT_REFLOG_ACTION"
 
 comment_for_reflog () {
-	case "$ORIG_REFLOG_ACTION" in
+	case "$orig_reflog_action" in
 	''|rebase*)
 		GIT_REFLOG_ACTION="rebase -i ($1)"
 		export GIT_REFLOG_ACTION
@@ -168,16 +168,16 @@ comment_for_reflog () {
 
 last_count=
 mark_action_done () {
-	sed -e 1q < "$TODO" >> "$DONE"
-	sed -e 1d < "$TODO" >> "$TODO".new
-	mv -f "$TODO".new "$TODO"
-	count=$(sane_grep -c '^[^#]' < "$DONE")
-	total=$(($count+$(sane_grep -c '^[^#]' < "$TODO")))
-	if test "$last_count" != "$count"
+	sed -e 1q < "$todo" >> "$done"
+	sed -e 1d < "$todo" >> "$todo".new
+	mv -f "$todo".new "$todo"
+	new_count=$(sane_grep -c '^[^#]' < "$done")
+	total=$(($new_count+$(sane_grep -c '^[^#]' < "$todo")))
+	if test "$last_count" != "$new_count"
 	then
-		last_count=$count
-		printf "Rebasing (%d/%d)\r" $count $total
-		test -z "$VERBOSE" || echo
+		last_count=$new_count
+		printf "Rebasing (%d/%d)\r" $new_count $total
+		test -z "$verbose" || echo
 	fi
 }
 
@@ -193,22 +193,22 @@ make_patch () {
 	*)
 		echo "Root commit"
 		;;
-	esac > "$DOTEST"/patch
-	test -f "$MSG" ||
-		commit_message "$1" > "$MSG"
-	test -f "$AUTHOR_SCRIPT" ||
-		get_author_ident_from_commit "$1" > "$AUTHOR_SCRIPT"
+	esac > "$dotest"/patch
+	test -f "$msg" ||
+		commit_message "$1" > "$msg"
+	test -f "$author_script" ||
+		get_author_ident_from_commit "$1" > "$author_script"
 }
 
 die_with_patch () {
-	echo "$1" > "$DOTEST"/stopped-sha
+	echo "$1" > "$dotest"/stopped-sha
 	make_patch "$1"
 	git rerere
 	die "$2"
 }
 
 die_abort () {
-	rm -rf "$DOTEST"
+	rm -rf "$dotest"
 	die "$1"
 }
 
@@ -228,11 +228,11 @@ do_with_author () {
 pick_one () {
 	ff=--ff
 	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
-	case "$NEVER_FF" in '') ;; ?*) ff= ;; esac
+	case "$force_rebase" in '') ;; ?*) ff= ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
-	test -d "$REWRITTEN" &&
+	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	if test -n "$REBASE_ROOT"
+	if test -n "$rebase_root"
 	then
 		output git cherry-pick "$@"
 		return
@@ -253,20 +253,20 @@ pick_one_preserving_merges () {
 	esac
 	sha1=$(git rev-parse $sha1)
 
-	if test -f "$DOTEST"/current-commit
+	if test -f "$dotest"/current-commit
 	then
 		if test "$fast_forward" = t
 		then
 			while read current_commit
 			do
-				git rev-parse HEAD > "$REWRITTEN"/$current_commit
-			done <"$DOTEST"/current-commit
-			rm "$DOTEST"/current-commit ||
+				git rev-parse HEAD > "$rewritten"/$current_commit
+			done <"$dotest"/current-commit
+			rm "$dotest"/current-commit ||
 			die "Cannot write current commit's replacement sha1"
 		fi
 	fi
 
-	echo $sha1 >> "$DOTEST"/current-commit
+	echo $sha1 >> "$dotest"/current-commit
 
 	# rewrite parents; if none were rewritten, we can fast-forward.
 	new_parents=
@@ -280,9 +280,9 @@ pick_one_preserving_merges () {
 		p=$(expr "$pend" : ' \([^ ]*\)')
 		pend="${pend# $p}"
 
-		if test -f "$REWRITTEN"/$p
+		if test -f "$rewritten"/$p
 		then
-			new_p=$(cat "$REWRITTEN"/$p)
+			new_p=$(cat "$rewritten"/$p)
 
 			# If the todo reordered commits, and our parent is marked for
 			# rewriting, but hasn't been gotten to yet, assume the user meant to
@@ -301,10 +301,10 @@ pick_one_preserving_merges () {
 				;;
 			esac
 		else
-			if test -f "$DROPPED"/$p
+			if test -f "$dropped"/$p
 			then
 				fast_forward=f
-				replacement="$(cat "$DROPPED"/$p)"
+				replacement="$(cat "$dropped"/$p)"
 				test -z "$replacement" && replacement=root
 				pend=" $replacement$pend"
 			else
@@ -333,18 +333,18 @@ pick_one_preserving_merges () {
 			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
 
 			# redo merge
-			author_script=$(get_author_ident_from_commit $sha1)
-			eval "$author_script"
-			msg="$(commit_message $sha1)"
+			author_script_content=$(get_author_ident_from_commit $sha1)
+			eval "$author_script_content"
+			msg_content="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			if ! do_with_author output \
-				git merge $STRATEGY -m "$msg" $new_parents
+				git merge $strategy -m "$msg_content" $new_parents
 			then
-				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
+				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
 			fi
-			echo "$sha1 $(git rev-parse HEAD^0)" >> "$REWRITTEN_LIST"
+			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
 			output git cherry-pick "$@" ||
@@ -365,46 +365,46 @@ nth_string () {
 }
 
 update_squash_messages () {
-	if test -f "$SQUASH_MSG"; then
-		mv "$SQUASH_MSG" "$SQUASH_MSG".bak || exit
-		COUNT=$(($(sed -n \
+	if test -f "$squash_msg"; then
+		mv "$squash_msg" "$squash_msg".bak || exit
+		count=$(($(sed -n \
 			-e "1s/^# This is a combination of \(.*\) commits\./\1/p" \
-			-e "q" < "$SQUASH_MSG".bak)+1))
+			-e "q" < "$squash_msg".bak)+1))
 		{
-			echo "# This is a combination of $COUNT commits."
+			echo "# This is a combination of $count commits."
 			sed -e 1d -e '2,/^./{
 				/^$/d
-			}' <"$SQUASH_MSG".bak
-		} >"$SQUASH_MSG"
+			}' <"$squash_msg".bak
+		} >"$squash_msg"
 	else
-		commit_message HEAD > "$FIXUP_MSG" || die "Cannot write $FIXUP_MSG"
-		COUNT=2
+		commit_message HEAD > "$fixup_msg" || die "Cannot write $fixup_msg"
+		count=2
 		{
 			echo "# This is a combination of 2 commits."
 			echo "# The first commit's message is:"
 			echo
-			cat "$FIXUP_MSG"
-		} >"$SQUASH_MSG"
+			cat "$fixup_msg"
+		} >"$squash_msg"
 	fi
 	case $1 in
 	squash)
-		rm -f "$FIXUP_MSG"
+		rm -f "$fixup_msg"
 		echo
-		echo "# This is the $(nth_string $COUNT) commit message:"
+		echo "# This is the $(nth_string $count) commit message:"
 		echo
 		commit_message $2
 		;;
 	fixup)
 		echo
-		echo "# The $(nth_string $COUNT) commit message will be skipped:"
+		echo "# The $(nth_string $count) commit message will be skipped:"
 		echo
 		commit_message $2 | sed -e 's/^/#	/'
 		;;
-	esac >>"$SQUASH_MSG"
+	esac >>"$squash_msg"
 }
 
 peek_next_command () {
-	sed -n -e "/^#/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$TODO"
+	sed -n -e "/^#/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$todo"
 }
 
 # A squash/fixup has failed.  Prepare the long version of the squash
@@ -414,24 +414,24 @@ peek_next_command () {
 # messages, effectively causing the combined commit to be used as the
 # new basis for any further squash/fixups.  Args: sha1 rest
 die_failed_squash() {
-	mv "$SQUASH_MSG" "$MSG" || exit
-	rm -f "$FIXUP_MSG"
-	cp "$MSG" "$GIT_DIR"/MERGE_MSG || exit
+	mv "$squash_msg" "$msg" || exit
+	rm -f "$fixup_msg"
+	cp "$msg" "$GIT_DIR"/MERGE_MSG || exit
 	warn
 	warn "Could not apply $1... $2"
 	die_with_patch $1 ""
 }
 
 flush_rewritten_pending() {
-	test -s "$REWRITTEN_PENDING" || return
+	test -s "$rewritten_pending" || return
 	newsha1="$(git rev-parse HEAD^0)"
-	sed "s/$/ $newsha1/" < "$REWRITTEN_PENDING" >> "$REWRITTEN_LIST"
-	rm -f "$REWRITTEN_PENDING"
+	sed "s/$/ $newsha1/" < "$rewritten_pending" >> "$rewritten_list"
+	rm -f "$rewritten_pending"
 }
 
 record_in_rewritten() {
 	oldsha1="$(git rev-parse $1)"
-	echo "$oldsha1" >> "$REWRITTEN_PENDING"
+	echo "$oldsha1" >> "$rewritten_pending"
 
 	case "$(peek_next_command)" in
 	squash|s|fixup|f)
@@ -443,8 +443,8 @@ record_in_rewritten() {
 }
 
 do_next () {
-	rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" || exit
-	read -r command sha1 rest < "$TODO"
+	rm -f "$msg" "$author_script" "$amend" || exit
+	read -r command sha1 rest < "$todo"
 	case "$command" in
 	'#'*|''|noop)
 		mark_action_done
@@ -472,9 +472,9 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		echo "$sha1" > "$DOTEST"/stopped-sha
+		echo "$sha1" > "$dotest"/stopped-sha
 		make_patch $sha1
-		git rev-parse --verify HEAD > "$AMEND"
+		git rev-parse --verify HEAD > "$amend"
 		warn "Stopped at $sha1... $rest"
 		warn "You can amend the commit now, with"
 		warn
@@ -497,47 +497,47 @@ do_next () {
 		esac
 		comment_for_reflog $squash_style
 
-		test -f "$DONE" && has_action "$DONE" ||
+		test -f "$done" && has_action "$done" ||
 			die "Cannot '$squash_style' without a previous commit"
 
 		mark_action_done
 		update_squash_messages $squash_style $sha1
-		author_script=$(get_author_ident_from_commit HEAD)
-		echo "$author_script" > "$AUTHOR_SCRIPT"
-		eval "$author_script"
+		author_script_content=$(get_author_ident_from_commit HEAD)
+		echo "$author_script_content" > "$author_script"
+		eval "$author_script_content"
 		output git reset --soft HEAD^
 		pick_one -n $sha1 || die_failed_squash $sha1 "$rest"
 		case "$(peek_next_command)" in
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			do_with_author output git commit --no-verify -F "$SQUASH_MSG" ||
+			do_with_author output git commit --no-verify -F "$squash_msg" ||
 				die_failed_squash $sha1 "$rest"
 			;;
 		*)
 			# This is the final command of this squash/fixup group
-			if test -f "$FIXUP_MSG"
+			if test -f "$fixup_msg"
 			then
-				do_with_author git commit --no-verify -F "$FIXUP_MSG" ||
+				do_with_author git commit --no-verify -F "$fixup_msg" ||
 					die_failed_squash $sha1 "$rest"
 			else
-				cp "$SQUASH_MSG" "$GIT_DIR"/SQUASH_MSG || exit
+				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
 				rm -f "$GIT_DIR"/MERGE_MSG
 				do_with_author git commit --no-verify -e ||
 					die_failed_squash $sha1 "$rest"
 			fi
-			rm -f "$SQUASH_MSG" "$FIXUP_MSG"
+			rm -f "$squash_msg" "$fixup_msg"
 			;;
 		esac
 		record_in_rewritten $sha1
 		;;
 	x|"exec")
-		read -r command rest < "$TODO"
+		read -r command rest < "$todo"
 		mark_action_done
 		printf 'Executing: %s\n' "$rest"
 		# "exec" command doesn't take a sha1 in the todo-list.
 		# => can't just use $sha1 here.
-		git rev-parse --verify HEAD > "$DOTEST"/stopped-sha
+		git rev-parse --verify HEAD > "$dotest"/stopped-sha
 		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
 		status=$?
 		if test "$status" -ne 0
@@ -563,42 +563,42 @@ do_next () {
 		warn "Unknown command: $command $sha1 $rest"
 		if git rev-parse --verify -q "$sha1" >/dev/null
 		then
-			die_with_patch $sha1 "Please fix this in the file $TODO."
+			die_with_patch $sha1 "Please fix this in the file $todo."
 		else
-			die "Please fix this in the file $TODO."
+			die "Please fix this in the file $todo."
 		fi
 		;;
 	esac
-	test -s "$TODO" && return
+	test -s "$todo" && return
 
 	comment_for_reflog finish &&
-	HEADNAME=$(cat "$DOTEST"/head-name) &&
-	OLDHEAD=$(cat "$DOTEST"/head) &&
-	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
-	NEWHEAD=$(git rev-parse HEAD) &&
-	case $HEADNAME in
+	headname=$(cat "$dotest"/head-name) &&
+	oldhead=$(cat "$dotest"/head) &&
+	shortonto=$(git rev-parse --short $(cat "$dotest"/onto)) &&
+	newhead=$(git rev-parse HEAD) &&
+	case $headname in
 	refs/*)
-		message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO" &&
-		git update-ref -m "$message" $HEADNAME $NEWHEAD $OLDHEAD &&
-		git symbolic-ref HEAD $HEADNAME
+		message="$GIT_REFLOG_ACTION: $headname onto $shortonto" &&
+		git update-ref -m "$message" $headname $newhead $oldhead &&
+		git symbolic-ref HEAD $headname
 		;;
 	esac && {
-		test ! -f "$DOTEST"/verbose ||
-			git diff-tree --stat $(cat "$DOTEST"/head)..HEAD
+		test ! -f "$dotest"/verbose ||
+			git diff-tree --stat $(cat "$dotest"/head)..HEAD
 	} &&
 	{
-		test -s "$REWRITTEN_LIST" &&
-		git notes copy --for-rewrite=rebase < "$REWRITTEN_LIST" ||
+		test -s "$rewritten_list" &&
+		git notes copy --for-rewrite=rebase < "$rewritten_list" ||
 		true # we don't care if this copying failed
 	} &&
 	if test -x "$GIT_DIR"/hooks/post-rewrite &&
-		test -s "$REWRITTEN_LIST"; then
-		"$GIT_DIR"/hooks/post-rewrite rebase < "$REWRITTEN_LIST"
+		test -s "$rewritten_list"; then
+		"$GIT_DIR"/hooks/post-rewrite rebase < "$rewritten_list"
 		true # we don't care if this hook failed
 	fi &&
-	rm -rf "$DOTEST" &&
+	rm -rf "$dotest" &&
 	git gc --auto &&
-	warn "Successfully rebased and updated $HEADNAME."
+	warn "Successfully rebased and updated $headname."
 
 	exit
 }
@@ -618,11 +618,11 @@ skip_unnecessary_picks () {
 		# fd=3 means we skip the command
 		case "$fd,$command" in
 		3,pick|3,p)
-			# pick a commit whose parent is current $ONTO -> skip
+			# pick a commit whose parent is current $onto -> skip
 			sha1=${rest%% *}
 			case "$(git rev-parse --verify --quiet "$sha1"^)" in
-			"$ONTO"*)
-				ONTO=$sha1
+			"$onto"*)
+				onto=$sha1
 				;;
 			*)
 				fd=1
@@ -637,11 +637,11 @@ skip_unnecessary_picks () {
 			;;
 		esac
 		printf '%s\n' "$command${rest:+ }$rest" >&$fd
-	done <"$TODO" >"$TODO.new" 3>>"$DONE" &&
-	mv -f "$TODO".new "$TODO" &&
+	done <"$todo" >"$todo.new" 3>>"$done" &&
+	mv -f "$todo".new "$todo" &&
 	case "$(peek_next_command)" in
 	squash|s|fixup|f)
-		record_in_rewritten "$ONTO"
+		record_in_rewritten "$onto"
 		;;
 	esac ||
 	die "Could not skip unnecessary pick commands"
@@ -650,17 +650,17 @@ skip_unnecessary_picks () {
 # check if no other options are set
 is_standalone () {
 	test $# -eq 2 -a "$2" = '--' &&
-	test -z "$ONTO" &&
-	test -z "$PRESERVE_MERGES" &&
-	test -z "$STRATEGY" &&
-	test -z "$VERBOSE"
+	test -z "$onto" &&
+	test -z "$preserve_merges" &&
+	test -z "$strategy" &&
+	test -z "$verbose"
 }
 
 get_saved_options () {
-	test -d "$REWRITTEN" && PRESERVE_MERGES=t
-	test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
-	test -f "$DOTEST"/verbose && VERBOSE=t
-	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
+	test -d "$rewritten" && preserve_merges=t
+	test -f "$dotest"/strategy && strategy="$(cat "$dotest"/strategy)"
+	test -f "$dotest"/verbose && verbose=t
+	test -f "$dotest"/rebase-root && rebase_root=t
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
@@ -699,7 +699,7 @@ rearrange_squash () {
 		esac
 		printf '%s\n' "$pick $sha1 $message"
 		used="$used$sha1 "
-		while read -r squash action msg
+		while read -r squash action msg_content
 		do
 			case " $used" in
 			*" $squash "*) continue ;;
@@ -709,13 +709,13 @@ rearrange_squash () {
 			+*)
 				action="${action#+}"
 				# full sha1 prefix test
-				case "$msg" in "$sha1"*) emit=1;; esac ;;
+				case "$msg_content" in "$sha1"*) emit=1;; esac ;;
 			*)
 				# message prefix test
-				case "$message" in "$msg"*) emit=1;; esac ;;
+				case "$message" in "$msg_content"*) emit=1;; esac ;;
 			esac
 			if test $emit = 1; then
-				printf '%s\n' "$action $squash $action! $msg"
+				printf '%s\n' "$action $squash $action! $msg_content"
 				used="$used$squash "
 			fi
 		done <"$1.sq"
@@ -747,17 +747,17 @@ while test $# != 0
 do
 	case "$1" in
 	--no-verify)
-		OK_TO_SKIP_PRE_REBASE=yes
+		ok_to_skip_pre_rebase=yes
 		;;
 	--verify)
-		OK_TO_SKIP_PRE_REBASE=
+		ok_to_skip_pre_rebase=
 		;;
 	--continue)
 		is_standalone "$@" || usage
 		get_saved_options
 		comment_for_reflog continue
 
-		test -d "$DOTEST" || die "No interactive rebase running"
+		test -d "$dotest" || die "No interactive rebase running"
 
 		# Sanity check
 		git rev-parse --verify HEAD >/dev/null ||
@@ -771,26 +771,26 @@ do
 		then
 			: Nothing to commit -- skip this
 		else
-			. "$AUTHOR_SCRIPT" ||
+			. "$author_script" ||
 				die "Cannot find the author identity"
-			amend=
-			if test -f "$AMEND"
+			current_head=
+			if test -f "$amend"
 			then
-				amend=$(git rev-parse --verify HEAD)
-				test "$amend" = $(cat "$AMEND") ||
+				current_head=$(git rev-parse --verify HEAD)
+				test "$current_head" = $(cat "$amend") ||
 				die "\
 You have uncommitted changes in your working tree. Please, commit them
 first and then run 'git rebase --continue' again."
 				git reset --soft HEAD^ ||
 				die "Cannot rewind the HEAD"
 			fi
-			do_with_author git commit --no-verify -F "$MSG" -e || {
-				test -n "$amend" && git reset --soft $amend
+			do_with_author git commit --no-verify -F "$msg" -e || {
+				test -n "$current_head" && git reset --soft $current_head
 				die "Could not commit staged changes."
 			}
 		fi
 
-		record_in_rewritten "$(cat "$DOTEST"/stopped-sha)"
+		record_in_rewritten "$(cat "$dotest"/stopped-sha)"
 
 		require_clean_work_tree "rebase"
 		do_rest
@@ -801,17 +801,17 @@ first and then run 'git rebase --continue' again."
 		comment_for_reflog abort
 
 		git rerere clear
-		test -d "$DOTEST" || die "No interactive rebase running"
+		test -d "$dotest" || die "No interactive rebase running"
 
-		HEADNAME=$(cat "$DOTEST"/head-name)
-		HEAD=$(cat "$DOTEST"/head)
-		case $HEADNAME in
+		headname=$(cat "$dotest"/head-name)
+		head=$(cat "$dotest"/head)
+		case $headname in
 		refs/*)
-			git symbolic-ref HEAD $HEADNAME
+			git symbolic-ref HEAD $headname
 			;;
 		esac &&
-		output git reset --hard $HEAD &&
-		rm -rf "$DOTEST"
+		output git reset --hard $head &&
+		rm -rf "$dotest"
 		exit
 		;;
 	--skip)
@@ -820,18 +820,18 @@ first and then run 'git rebase --continue' again."
 		comment_for_reflog skip
 
 		git rerere clear
-		test -d "$DOTEST" || die "No interactive rebase running"
+		test -d "$dotest" || die "No interactive rebase running"
 
 		output git reset --hard && do_rest
 		;;
 	-s)
 		case "$#,$1" in
 		*,*=*)
-			STRATEGY="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
+			strategy="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
 		1,*)
 			usage ;;
 		*)
-			STRATEGY="-s $2"
+			strategy="-s $2"
 			shift ;;
 		esac
 		;;
@@ -839,29 +839,29 @@ first and then run 'git rebase --continue' again."
 		# we use merge anyway
 		;;
 	-v)
-		VERBOSE=t
+		verbose=t
 		;;
 	-p)
-		PRESERVE_MERGES=t
+		preserve_merges=t
 		;;
 	-i)
 		# yeah, we know
 		;;
 	--no-ff)
-		NEVER_FF=t
+		force_rebase=t
 		;;
 	--root)
-		REBASE_ROOT=t
+		rebase_root=t
 		;;
 	--autosquash)
-		AUTOSQUASH=t
+		autosquash=t
 		;;
 	--no-autosquash)
-		AUTOSQUASH=
+		autosquash=
 		;;
 	--onto)
 		shift
-		ONTO=$(parse_onto "$1") ||
+		onto=$(parse_onto "$1") ||
 			die "Does not point to a valid commit: $1"
 		;;
 	--)
@@ -872,27 +872,27 @@ first and then run 'git rebase --continue' again."
 	shift
 done
 
-test -z "$REBASE_ROOT" -a $# -ge 1 -a $# -le 2 ||
-test ! -z "$REBASE_ROOT" -a $# -le 1 || usage
-test -d "$DOTEST" &&
+test -z "$rebase_root" -a $# -ge 1 -a $# -le 2 ||
+test ! -z "$rebase_root" -a $# -le 1 || usage
+test -d "$dotest" &&
 	die "Interactive rebase already started"
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-if test -z "$REBASE_ROOT"
+if test -z "$rebase_root"
 then
-	UPSTREAM_ARG="$1"
-	UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
-	test -z "$ONTO" && ONTO=$UPSTREAM
+	upstream_arg="$1"
+	upstream=$(git rev-parse --verify "$1") || die "Invalid base"
+	test -z "$onto" && onto=$upstream
 	shift
 else
-	UPSTREAM=
-	UPSTREAM_ARG=--root
-	test -z "$ONTO" &&
-	die "You must specify --onto when using --root"
+	upstream=
+	upstream_arg=--root
+	test -z "$onto" &&
+		die "You must specify --onto when using --root"
 fi
-run_pre_rebase_hook "$UPSTREAM_ARG" "$@"
+run_pre_rebase_hook "$upstream_arg" "$@"
 
 comment_for_reflog start
 
@@ -904,76 +904,76 @@ then
 		die "Could not checkout $1"
 fi
 
-HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
-mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
+head=$(git rev-parse --verify HEAD) || die "No HEAD?"
+mkdir "$dotest" || die "Could not create temporary $dotest"
 
-: > "$DOTEST"/interactive || die "Could not mark as interactive"
-git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
-	echo "detached HEAD" > "$DOTEST"/head-name
+: > "$dotest"/interactive || die "Could not mark as interactive"
+git symbolic-ref HEAD > "$dotest"/head-name 2> /dev/null ||
+	echo "detached HEAD" > "$dotest"/head-name
 
-echo $HEAD > "$DOTEST"/head
-case "$REBASE_ROOT" in
+echo $head > "$dotest"/head
+case "$rebase_root" in
 '')
-	rm -f "$DOTEST"/rebase-root ;;
+	rm -f "$dotest"/rebase-root ;;
 *)
-	: >"$DOTEST"/rebase-root ;;
+	: >"$dotest"/rebase-root ;;
 esac
-echo $ONTO > "$DOTEST"/onto
-test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
-test t = "$VERBOSE" && : > "$DOTEST"/verbose
-if test t = "$PRESERVE_MERGES"
+echo $onto > "$dotest"/onto
+test -z "$strategy" || echo "$strategy" > "$dotest"/strategy
+test t = "$verbose" && : > "$dotest"/verbose
+if test t = "$preserve_merges"
 then
-	if test -z "$REBASE_ROOT"
+	if test -z "$rebase_root"
 	then
-		mkdir "$REWRITTEN" &&
-		for c in $(git merge-base --all $HEAD $UPSTREAM)
+		mkdir "$rewritten" &&
+		for c in $(git merge-base --all $head $upstream)
 		do
-			echo $ONTO > "$REWRITTEN"/$c ||
+			echo $onto > "$rewritten"/$c ||
 				die "Could not init rewritten commits"
 		done
 	else
-		mkdir "$REWRITTEN" &&
-		echo $ONTO > "$REWRITTEN"/root ||
+		mkdir "$rewritten" &&
+		echo $onto > "$rewritten"/root ||
 			die "Could not init rewritten commits"
 	fi
 	# No cherry-pick because our first pass is to determine
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
-	MERGES_OPTION=
-	first_after_upstream="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
+	merges_option=
+	first_after_upstream="$(git rev-list --reverse --first-parent $upstream..$head | head -n 1)"
 else
-	MERGES_OPTION="--no-merges --cherry-pick"
+	merges_option="--no-merges --cherry-pick"
 fi
 
-SHORTHEAD=$(git rev-parse --short $HEAD)
-SHORTONTO=$(git rev-parse --short $ONTO)
-if test -z "$REBASE_ROOT"
-	# this is now equivalent to ! -z "$UPSTREAM"
+shorthead=$(git rev-parse --short $head)
+shortonto=$(git rev-parse --short $onto)
+if test -z "$rebase_root"
+	# this is now equivalent to ! -z "$upstream"
 then
-	SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
-	REVISIONS=$UPSTREAM...$HEAD
-	SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
+	shortupstream=$(git rev-parse --short $upstream)
+	revisions=$upstream...$head
+	shortrevisions=$shortupstream..$shorthead
 else
-	REVISIONS=$ONTO...$HEAD
-	SHORTREVISIONS=$SHORTHEAD
+	revisions=$onto...$head
+	shortrevisions=$shorthead
 fi
-git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
+git rev-list $merges_option --pretty=oneline --abbrev-commit \
 	--abbrev=7 --reverse --left-right --topo-order \
-	$REVISIONS | \
+	$revisions | \
 	sed -n "s/^>//p" |
 while read -r shortsha1 rest
 do
-	if test t != "$PRESERVE_MERGES"
+	if test t != "$preserve_merges"
 	then
-		printf '%s\n' "pick $shortsha1 $rest" >> "$TODO"
+		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
 	else
 		sha1=$(git rev-parse $shortsha1)
-		if test -z "$REBASE_ROOT"
+		if test -z "$rebase_root"
 		then
 			preserve=t
 			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
 			do
-				if test -f "$REWRITTEN"/$p -a \( $p != $ONTO -o $sha1 = $first_after_upstream \)
+				if test -f "$rewritten"/$p -a \( $p != $onto -o $sha1 = $first_after_upstream \)
 				then
 					preserve=f
 				fi
@@ -983,43 +983,43 @@ do
 		fi
 		if test f = "$preserve"
 		then
-			touch "$REWRITTEN"/$sha1
-			printf '%s\n' "pick $shortsha1 $rest" >> "$TODO"
+			touch "$rewritten"/$sha1
+			printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
 		fi
 	fi
 done
 
 # Watch for commits that been dropped by --cherry-pick
-if test t = "$PRESERVE_MERGES"
+if test t = "$preserve_merges"
 then
-	mkdir "$DROPPED"
+	mkdir "$dropped"
 	# Save all non-cherry-picked changes
-	git rev-list $REVISIONS --left-right --cherry-pick | \
-		sed -n "s/^>//p" > "$DOTEST"/not-cherry-picks
+	git rev-list $revisions --left-right --cherry-pick | \
+		sed -n "s/^>//p" > "$dotest"/not-cherry-picks
 	# Now all commits and note which ones are missing in
 	# not-cherry-picks and hence being dropped
-	git rev-list $REVISIONS |
+	git rev-list $revisions |
 	while read rev
 	do
-		if test -f "$REWRITTEN"/$rev -a "$(sane_grep "$rev" "$DOTEST"/not-cherry-picks)" = ""
+		if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$dotest"/not-cherry-picks)" = ""
 		then
 			# Use -f2 because if rev-list is telling us this commit is
 			# not worthwhile, we don't want to track its multiple heads,
 			# just the history of its first-parent for others that will
 			# be rebasing on top of it
-			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$DROPPED"/$rev
+			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
 			short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
-			sane_grep -v "^[a-z][a-z]* $short" <"$TODO" > "${TODO}2" ; mv "${TODO}2" "$TODO"
-			rm "$REWRITTEN"/$rev
+			sane_grep -v "^[a-z][a-z]* $short" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
+			rm "$rewritten"/$rev
 		fi
 	done
 fi
 
-test -s "$TODO" || echo noop >> "$TODO"
-test -n "$AUTOSQUASH" && rearrange_squash "$TODO"
-cat >> "$TODO" << EOF
+test -s "$todo" || echo noop >> "$todo"
+test -n "$autosquash" && rearrange_squash "$todo"
+cat >> "$todo" << EOF
 
-# Rebase $SHORTREVISIONS onto $SHORTONTO
+# Rebase $shortrevisions onto $shortonto
 #
 # Commands:
 #  p, pick = use commit
@@ -1034,18 +1034,18 @@ cat >> "$TODO" << EOF
 #
 EOF
 
-has_action "$TODO" ||
+has_action "$todo" ||
 	die_abort "Nothing to do"
 
-cp "$TODO" "$TODO".backup
-git_editor "$TODO" ||
+cp "$todo" "$todo".backup
+git_editor "$todo" ||
 	die_abort "Could not execute editor"
 
-has_action "$TODO" ||
+has_action "$todo" ||
 	die_abort "Nothing to do"
 
-test -d "$REWRITTEN" || test -n "$NEVER_FF" || skip_unnecessary_picks
+test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
-output git checkout $ONTO || die_abort "could not detach HEAD"
-git update-ref ORIG_HEAD $HEAD
+output git checkout $onto || die_abort "could not detach HEAD"
+git update-ref ORIG_HEAD $head
 do_rest
diff --git a/git-rebase.sh b/git-rebase.sh
index d689aad..dfde62f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -36,13 +36,13 @@ cd_to_toplevel
 
 LF='
 '
-OK_TO_SKIP_PRE_REBASE=
-RESOLVEMSG="
+ok_to_skip_pre_rebase=
+resolvemsg="
 When you have resolved this problem run \"git rebase --continue\".
 If you would prefer to skip this patch, instead run \"git rebase --skip\".
 To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
-unset newbase
+unset onto
 strategy=recursive
 strategy_opts=
 do_merge=
@@ -86,7 +86,7 @@ continue_merge () {
 	then
 		echo "You still have unmerged paths in your index"
 		echo "did you forget to use git add?"
-		die "$RESOLVEMSG"
+		die "$resolvemsg"
 	fi
 
 	cmt=`cat "$merge_dir/current"`
@@ -96,7 +96,7 @@ continue_merge () {
 		then
 			echo "Commit failed, please do not call \"git commit\""
 			echo "directly, but instead do one of the following: "
-			die "$RESOLVEMSG"
+			die "$resolvemsg"
 		fi
 		if test -z "$GIT_QUIET"
 		then
@@ -139,11 +139,11 @@ call_merge () {
 		;;
 	1)
 		git rerere $allow_rerere_autoupdate
-		die "$RESOLVEMSG"
+		die "$resolvemsg"
 		;;
 	2)
 		echo "Strategy: $rv $strategy failed, try another" 1>&2
-		die "$RESOLVEMSG"
+		die "$resolvemsg"
 		;;
 	*)
 		die "Unknown exit code ($rv) from command:" \
@@ -199,7 +199,7 @@ is_interactive () {
 }
 
 run_pre_rebase_hook () {
-	if test -z "$OK_TO_SKIP_PRE_REBASE" &&
+	if test -z "$ok_to_skip_pre_rebase" &&
 	   test -x "$GIT_DIR/hooks/pre-rebase"
 	then
 		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} ||
@@ -234,10 +234,10 @@ while test $# != 0
 do
 	case "$1" in
 	--no-verify)
-		OK_TO_SKIP_PRE_REBASE=yes
+		ok_to_skip_pre_rebase=yes
 		;;
 	--verify)
-		OK_TO_SKIP_PRE_REBASE=
+		ok_to_skip_pre_rebase=
 		;;
 	--continue|--skip|--abort)
 		test $total_argc -eq 1 || usage
@@ -245,7 +245,7 @@ do
 		;;
 	--onto)
 		test 2 -le "$#" || usage
-		newbase="$2"
+		onto="$2"
 		shift
 		;;
 	-M|-m|--m|--me|--mer|--merg|--merge)
@@ -359,7 +359,7 @@ continue)
 		finish_rb_merge
 		exit
 	fi
-	git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+	git am --resolved --3way --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
 	exit
 	;;
@@ -378,7 +378,7 @@ skip)
 		finish_rb_merge
 		exit
 	fi
-	git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
+	git am -3 --skip --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
 	exit
 	;;
@@ -425,7 +425,7 @@ then
 	unset root_flag
 	upstream_arg="$upstream_name"
 else
-	test -z "$newbase" && die "--root must be used with --onto"
+	test -z "$onto" && die "--root must be used with --onto"
 	unset upstream_name
 	unset upstream
 	root_flag="--root"
@@ -433,7 +433,7 @@ else
 fi
 
 # Make sure the branch to rebase onto is valid.
-onto_name=${newbase-"$upstream_name"}
+onto_name=${onto-"$upstream_name"}
 case "$onto_name" in
 *...*)
 	if	left=${onto_name%...*} right=${onto_name#*...} &&
@@ -554,7 +554,7 @@ then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 		--src-prefix=a/ --dst-prefix=b/ \
 		--no-renames $root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
+	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
 	ret=$?
 	test 0 != $ret -a -d "$apply_dir" &&
-- 
1.7.4.rc2.33.g8a14f
