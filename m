Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D933C1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 17:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeCURoy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 13:44:54 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34177 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeCURov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 13:44:51 -0400
Received: by mail-pf0-f175.google.com with SMTP id j20so2269165pfi.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MP5vvhOrXw/ffc0zYFZGhMiXM7AiA4CtBYoU6oTOUqs=;
        b=o5XTuhngUxNs60Dh1qOMSeuKIXFh6Vc8/pKL2rI+a9t9VRwU5gsd9C8rfpX4S4tkQH
         ndRd/5aPnGMI0FqH+x8WzJIToxt/xkT01Ep+ovufZHlDxrtHS6UFofcLhnj7mWweNDaN
         SkS9ACZrTUYX7P0moUpgmU6M6I8yvCcwzzcdhuBCuv47QzHjWqajfJQCKRTReUl7ccMM
         nJc128aDlQH3pYGHx5UnWYML9RHS4XlHzviqN4gjn62WjjldGP2J7aw1tNvee7lS+llZ
         NzPU2S7X8QACKv93zdua5uNcDx4ndnrdu/6+4IzR82WenfdOmHwatNqX2o2ADGW6j7W1
         NM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MP5vvhOrXw/ffc0zYFZGhMiXM7AiA4CtBYoU6oTOUqs=;
        b=A646csYA33iqqb6+E/ttxIaj9uCoFdfsOZ0TXmPXez1G3H9dsD/GLAkuAuky0K7uxI
         /e5zgLkDFon489mAloYbTwJqYDU3psDbKPjSJ9sw05KTJCDhRWoAdQRnJsTKb0gcPMxx
         pWMipH3r7hl/6IZmvTpkJdknqtYQwpLPeSEOykTMkBANf8Bdl62GWiTuXlMzVwIYFXnm
         WoaG+N/xmuLJLVVmsXBvzpGjaruYtlhpm4Tz6ReWy/T0aMi3V4T3tXRSbq/ssIi5AUx0
         Vi5PQxWpfXXuscCzovfphV0KczjctrZQea3vaCInA525Jom3u8BLWdlaEuxthqjIglZH
         AhtA==
X-Gm-Message-State: AElRT7FDnjv1q+SGYJf2ghTOIeGxQ26gerjFIsMURgBTphpivJ/wZBor
        TtWThYo23bpRSN7bPHZ1e9PqdbQB4XE=
X-Google-Smtp-Source: AG47ELtr5uc70iAgxR7Sbl3Q1WIVE+kcl9v1EVJX9nTNnoI+Gi1tAaKEY5J4cs2v9tf7PdLUTaydfw==
X-Received: by 10.98.54.65 with SMTP id d62mr15056200pfa.52.1521654290084;
        Wed, 21 Mar 2018 10:44:50 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id x3sm8172453pgv.86.2018.03.21.10.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 10:44:48 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v2 1/1] rebase-interactive: Add git_rebase__interactive__preserve_merges
Date:   Wed, 21 Mar 2018 10:44:38 -0700
Message-Id: <c169a69be3c61fd1e90eaf79febccef2afdfbd3b.1521653702.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521653702.git.wink@saville.com>
References: <cover.1521653702.git.wink@saville.com>
In-Reply-To: <cover.1521653702.git.wink@saville.com>
References: <CAPig+cSm3kHF_hTRKutCCNsY82sE3xZfXJkQsKi+zedq9rdnPw@mail.gmail.com> <cover.1521653702.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor git_rebase__interactive__preserve_merges out of
git_rebase__interactive resulting in fewer conditionals making
both routines are simpler.

Changed run_specific_rebase in git-rebase to dispatch to the appropriate
function after sourcing git-rebase--interactive.
---
 git-rebase--interactive.sh | 469 +++++++++++++++++++++++++--------------------
 git-rebase.sh              |  16 +-
 2 files changed, 273 insertions(+), 212 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 331c8dfea..65ff75654 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1,5 +1,7 @@
-# This shell script fragment is sourced by git-rebase to implement
-# its interactive mode.  "git rebase --interactive" makes it easy
+#!/bin/sh
+# This shell script fragment is sourced by git-rebase--interactive
+# and git-rebase--interactive--preserve-merges in support of the
+# interactive mode.  "git rebase --interactive" makes it easy
 # to fix up commits in the middle of a series and rearrange commits.
 #
 # Copyright (c) 2006 Johannes E. Schindelin
@@ -7,6 +9,7 @@
 # The original idea comes from Eric W. Biederman, in
 # https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
 #
+
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
 # the lines are processed, they are removed from the front of this
@@ -125,6 +128,19 @@ comment_for_reflog () {
 	esac
 }
 
+setup_reflog_action () {
+	comment_for_reflog start
+
+	if test ! -z "$switch_to"
+	then
+		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
+		output git checkout "$switch_to" -- ||
+			die "$(eval_gettext "Could not checkout \$switch_to")"
+
+		comment_for_reflog start
+	fi
+}
+
 last_count=
 mark_action_done () {
 	sed -e 1q < "$todo" >> "$done"
@@ -274,7 +290,8 @@ pick_one () {
 
 	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
 	case "$force_rebase" in '') ;; ?*) ff= ;; esac
-	output git rev-parse --verify $sha1 || die "$(eval_gettext "Invalid commit name: \$sha1")"
+	output git rev-parse --verify $sha1 ||
+		die "$(eval_gettext "Invalid commit name: \$sha1")"
 
 	if is_empty_commit "$sha1"
 	then
@@ -287,8 +304,8 @@ pick_one () {
 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 			"$strategy_args" $empty_args $ff "$@"
 
-	# If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
-	# previous task so this commit is not lost.
+	# If cherry-pick dies it leaves the to-be-picked commit unrecorded.
+	# Reschedule previous task so this commit is not lost.
 	ret=$?
 	case "$ret" in [01]) ;; *) reschedule_last_action ;; esac
 	return $ret
@@ -307,17 +324,15 @@ pick_one_preserving_merges () {
 	esac
 	sha1=$(git rev-parse $sha1)
 
-	if test -f "$state_dir"/current-commit
+	if test -f "$state_dir"/current-commit && test "$fast_forward" = t
 	then
-		if test "$fast_forward" = t
-		then
-			while read current_commit
-			do
-				git rev-parse HEAD > "$rewritten"/$current_commit
-			done <"$state_dir"/current-commit
-			rm "$state_dir"/current-commit ||
-				die "$(gettext "Cannot write current commit's replacement sha1")"
-		fi
+		while read current_commit
+		do
+			git rev-parse HEAD > "$rewritten"/$current_commit
+		done <"$state_dir"/current-commit
+		rm "$state_dir"/current-commit ||
+		    die "$(gettext \
+			"Cannot write current commit's replacement sha1")"
 	fi
 
 	echo $sha1 >> "$state_dir"/current-commit
@@ -337,10 +352,10 @@ pick_one_preserving_merges () {
 		if test -f "$rewritten"/$p
 		then
 			new_p=$(cat "$rewritten"/$p)
-
-			# If the todo reordered commits, and our parent is marked for
-			# rewriting, but hasn't been gotten to yet, assume the user meant to
-			# drop it on top of the current HEAD
+			# If the todo reordered commits, and our parent is
+			# marked for rewriting, but hasn't been gotten to yet,
+			# assume the user meant to drop it on top of the
+			# current HEAD
 			if test -z "$new_p"
 			then
 				new_p=$(git rev-parse HEAD)
@@ -379,7 +394,7 @@ pick_one_preserving_merges () {
 		then
 			# detach HEAD to current parent
 			output git checkout $first_parent 2> /dev/null ||
-				die "$(eval_gettext "Cannot move HEAD to \$first_parent")"
+			   die "$(eval_gettext "Cannot move HEAD to \$first_parent")"
 		fi
 
 		case "$new_parents" in
@@ -553,7 +568,7 @@ do_next () {
 	pick|p)
 		comment_for_reflog pick
 
-		mark_action_done
+		mark_action_done $sha1 "$rest"
 		do_pick $sha1 "$rest"
 		record_in_rewritten $sha1
 		;;
@@ -637,7 +652,7 @@ you are able to reword the commit.")"
 		read -r command rest < "$todo"
 		mark_action_done
 		eval_gettextln "Executing: \$rest"
-		"${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
+		"${SHELL:-/bin/sh}" -c "$rest" # Actual execution
 		status=$?
 		# Run in subshell because require_clean_work_tree can die.
 		dirty=f
@@ -743,37 +758,38 @@ get_missing_commit_check_level () {
 	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
 }
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
-#
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
-git_rebase__interactive () {
+init_basic_state () {
+	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
+	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
+	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
-case "$action" in
-continue)
-	if test ! -d "$rewritten"
-	then
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-			--continue
-	fi
-	# do we have anything to commit?
-	if git diff-index --cached --quiet HEAD --
-	then
-		# Nothing to commit -- skip this commit
+	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
+	write_basic_state
+}
 
-		test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
-		rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
-		die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
-	else
-		if ! test -f "$author_script"
+# Initiate an action which is first parameter.
+# Returns 0 if the action was able to complete
+# or 1 if further processing is required.
+initiate_action () {
+	case $1 in
+	continue)
+		if test ! -d "$rewritten"
+		then
+			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+				--continue
+		fi
+		# do we have anything to commit?
+		if git diff-index --cached --quiet HEAD --
 		then
-			gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-			die "$(eval_gettext "\
+			# Nothing to commit -- skip this commit
+			test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
+			rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
+			die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
+		else
+			if ! test -f "$author_script"
+			then
+				gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
+				die "$(eval_gettext "\
 You have staged changes in your working tree.
 If these changes are meant to be
 squashed into the previous commit, run:
@@ -788,137 +804,231 @@ In both cases, once you're done, continue with:
 
   git rebase --continue
 ")"
-		fi
-		. "$author_script" ||
-			die "$(gettext "Error trying to find the author identity to amend commit")"
-		if test -f "$amend"
-		then
-			current_head=$(git rev-parse --verify HEAD)
-			test "$current_head" = $(cat "$amend") ||
-			die "$(gettext "\
-You have uncommitted changes in your working tree. Please commit them
-first and then run 'git rebase --continue' again.")"
-			do_with_author git commit --amend --no-verify -F "$msg" -e \
-				${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
+			fi
+			. "$author_script" ||
+				die "$(gettext "Error trying to find the author identity to amend commit")"
+			if test -f "$amend"
+			then
+				current_head=$(git rev-parse --verify HEAD)
+				test "$current_head" = $(cat "$amend") ||
+				die "$(gettext "\
+You have uncommitted changes in your working tree.
+Please commit them first and then run:
+    'git rebase --continue' again.")"
+				do_with_author git commit --amend --no-verify \
+				    -F "$msg" \
+				    -e ${gpg_sign_opt:+"$gpg_sign_opt"} \
+				    $allow_empty_message ||
 				die "$(gettext "Could not commit staged changes.")"
-		else
-			do_with_author git commit --no-verify -F "$msg" -e \
-				${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
+			else
+				do_with_author git commit --no-verify \
+				    -F "$msg" \
+				    -e ${gpg_sign_opt:+"$gpg_sign_opt"} \
+				    $allow_empty_message ||
 				die "$(gettext "Could not commit staged changes.")"
+			fi
 		fi
-	fi
 
-	if test -r "$state_dir"/stopped-sha
-	then
-		record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
-	fi
+		if test -r "$state_dir"/stopped-sha
+		then
+			record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
+		fi
 
-	require_clean_work_tree "rebase"
-	do_rest
-	return 0
-	;;
-skip)
-	git rerere clear
+		require_clean_work_tree "rebase"
+		do_rest
+		return 0 # done
+		;;
+	skip)
+		git rerere clear
 
-	if test ! -d "$rewritten"
-	then
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-			--continue
-	fi
-	do_rest
-	return 0
-	;;
-edit-todo)
-	git stripspace --strip-comments <"$todo" >"$todo".new
-	mv -f "$todo".new "$todo"
-	collapse_todo_ids
-	append_todo_help
-	gettext "
+		if test ! -d "$rewritten"
+		then
+			exec git rebase--helper ${force_rebase:+--no-ff} \
+				$allow_empty_message --continue
+		fi
+		do_rest
+		return 0 # done
+		;;
+	edit-todo)
+		git stripspace --strip-comments <"$todo" >"$todo".new
+		mv -f "$todo".new "$todo"
+		collapse_todo_ids
+		append_todo_help
+		gettext "
 You are editing the todo file of an ongoing interactive rebase.
 To continue rebase after editing, run:
     git rebase --continue
 
+	" | git stripspace --comment-lines >>"$todo"
+
+		git_sequence_editor "$todo" ||
+			die "$(gettext "Could not execute editor")"
+		expand_todo_ids
+
+		exit
+		;;
+	show-current-patch)
+		exec git show REBASE_HEAD --
+		;;
+	*)
+		return 1 # continue
+		;;
+	esac
+}
+
+# Complete the action
+complete_action() {
+
+	test -s "$todo" || echo noop >> "$todo"
+	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
+	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
+
+	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
+	todocount=${todocount##* }
+
+	cat >>"$todo" <<EOF
+
+$comment_char $(eval_ngettext \
+	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
+	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
+	"$todocount")
+EOF
+
+	append_todo_help
+	gettext "
+However, if you remove everything, the rebase will be aborted.
+
 " | git stripspace --comment-lines >>"$todo"
 
+	if test -z "$keep_empty"
+	then
+		printf '%s\n' "$comment_char \
+		    $(gettext "Note that empty commits are commented out")" \
+		    >>"$todo"
+	fi
+
+	has_action "$todo" ||
+		return 2
+
+	cp "$todo" "$todo".backup
+	collapse_todo_ids
 	git_sequence_editor "$todo" ||
-		die "$(gettext "Could not execute editor")"
+		die_abort "$(gettext "Could not execute editor")"
+
+	has_action "$todo" ||
+		return 2
+
+	git rebase--helper --check-todo-list || {
+		ret=$?
+		checkout_onto
+		exit $ret
+	}
+
 	expand_todo_ids
 
-	exit
-	;;
-show-current-patch)
-	exec git show REBASE_HEAD --
-	;;
-esac
+	test -d "$rewritten" || test -n "$force_rebase" ||
+	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
+	die "Could not skip unnecessary pick commands"
 
-comment_for_reflog start
+	checkout_onto
 
-if test ! -z "$switch_to"
-then
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-	output git checkout "$switch_to" -- ||
-		die "$(eval_gettext "Could not checkout \$switch_to")"
+	if test -z "$rebase_root" && test ! -d "$rewritten"
+	then
+		require_clean_work_tree "rebase"
+		exec git rebase--helper ${force_rebase:+--no-ff} \
+			$allow_empty_message --continue
+	else
+		do_rest
+	fi
+}
 
-	comment_for_reflog start
-fi
+git_rebase__interactive () {
+	initiate_action "$action"
+	ret=$?
+	if test $ret = 0; then
+		return 0
+	fi
+
+	setup_reflog_action
+	init_basic_state
+
+	merges_option="--no-merges --cherry-pick"
+
+	shorthead=$(git rev-parse --short $orig_head)
+	shortonto=$(git rev-parse --short $onto)
+	if test -z "$rebase_root"
+		# this is now equivalent to ! -z "$upstream"
+	then
+		shortupstream=$(git rev-parse --short $upstream)
+		revisions=$upstream...$orig_head
+		shortrevisions=$shortupstream..$shorthead
+	else
+		revisions=$onto...$orig_head
+		shortrevisions=$shorthead
+	fi
+
+	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
+	    die "$(gettext "Could not generate todo list")"
+
+	complete_action
+}
+
+git_rebase__interactive__preserve_merges () {
+	initiate_action "$action"
+	ret=$?
+	if test $ret == 0; then
+		return 0
+	fi
 
-orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
-mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
-rm -f "$(git rev-parse --git-path REBASE_HEAD)"
+	setup_reflog_action
+	init_basic_state
 
-: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
-write_basic_state
-if test t = "$preserve_merges"
-then
 	if test -z "$rebase_root"
 	then
 		mkdir "$rewritten" &&
 		for c in $(git merge-base --all $orig_head $upstream)
 		do
 			echo $onto > "$rewritten"/$c ||
-				die "$(gettext "Could not init rewritten commits")"
+			    die "$(gettext "Could not init rewritten commits")"
 		done
 	else
 		mkdir "$rewritten" &&
 		echo $onto > "$rewritten"/root ||
 			die "$(gettext "Could not init rewritten commits")"
 	fi
+
 	# No cherry-pick because our first pass is to determine
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
 	merges_option=
-else
-	merges_option="--no-merges --cherry-pick"
-fi
-
-shorthead=$(git rev-parse --short $orig_head)
-shortonto=$(git rev-parse --short $onto)
-if test -z "$rebase_root"
-	# this is now equivalent to ! -z "$upstream"
-then
-	shortupstream=$(git rev-parse --short $upstream)
-	revisions=$upstream...$orig_head
-	shortrevisions=$shortupstream..$shorthead
-else
-	revisions=$onto...$orig_head
-	shortrevisions=$shorthead
-fi
-if test t != "$preserve_merges"
-then
-	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
-		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
-	die "$(gettext "Could not generate todo list")"
-else
+
+	shorthead=$(git rev-parse --short $orig_head)
+	shortonto=$(git rev-parse --short $onto)
+	if test -z "$rebase_root"
+		# this is now equivalent to ! -z "$upstream"
+	then
+		shortupstream=$(git rev-parse --short $upstream)
+		revisions=$upstream...$orig_head
+		shortrevisions=$shortupstream..$shorthead
+	else
+		revisions=$onto...$orig_head
+		shortrevisions=$shorthead
+	fi
+
+	# The 'rev-list .. | sed'
+	#   requires %m to parse; where as the the instruction
+	#   requires %H to parse
 	format=$(git config --get rebase.instructionFormat)
-	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
 	git rev-list $merges_option --format="%m%H ${format:-%s}" \
 		--reverse --left-right --topo-order \
 		$revisions ${restrict_revision+^$restrict_revision} | \
 		sed -n "s/^>//p" |
 	while read -r sha1 rest
 	do
-
-		if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
+		if test -z "$keep_empty" \
+			&& is_empty_commit $sha1 \
+			&& ! is_merge_commit $sha1
 		then
 			comment_out="$comment_char "
 		else
@@ -928,7 +1038,8 @@ else
 		if test -z "$rebase_root"
 		then
 			preserve=t
-			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
+			for p in $(git rev-list --parents -1 $sha1 | \
+				cut -d' ' -s -f2-)
 			do
 				if test -f "$rewritten"/$p
 				then
@@ -944,11 +1055,7 @@ else
 			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
 		fi
 	done
-fi
 
-# Watch for commits that been dropped by --cherry-pick
-if test t = "$preserve_merges"
-then
 	mkdir "$dropped"
 	# Save all non-cherry-picked changes
 	git rev-list $revisions --left-right --cherry-pick | \
@@ -961,76 +1068,18 @@ then
 		if test -f "$rewritten"/$rev &&
 		   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
 		then
-			# Use -f2 because if rev-list is telling us this commit is
-			# not worthwhile, we don't want to track its multiple heads,
-			# just the history of its first-parent for others that will
-			# be rebasing on top of it
-			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
+			# Use -f2 because if rev-list is telling us this commit
+			# is not worthwhile, we don't want to track its
+			# multiple heads, just the history of its first-parent
+			# for others that will be rebasing on top of it.
+			git rev-list --parents -1 $rev | \
+				cut -d' ' -s -f2 > "$dropped"/$rev
 			sha1=$(git rev-list -1 $rev)
-			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
+			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2"
+			mv "${todo}2" "$todo"
 			rm "$rewritten"/$rev
 		fi
 	done
-fi
-
-test -s "$todo" || echo noop >> "$todo"
-test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
-
-todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
-todocount=${todocount##* }
-
-cat >>"$todo" <<EOF
-
-$comment_char $(eval_ngettext \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
-	"$todocount")
-EOF
-append_todo_help
-gettext "
-However, if you remove everything, the rebase will be aborted.
-
-" | git stripspace --comment-lines >>"$todo"
-
-if test -z "$keep_empty"
-then
-	printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
-fi
-
-
-has_action "$todo" ||
-	return 2
-
-cp "$todo" "$todo".backup
-collapse_todo_ids
-git_sequence_editor "$todo" ||
-	die_abort "$(gettext "Could not execute editor")"
-
-has_action "$todo" ||
-	return 2
-
-git rebase--helper --check-todo-list || {
-	ret=$?
-	checkout_onto
-	exit $ret
-}
-
-expand_todo_ids
-
-test -d "$rewritten" || test -n "$force_rebase" ||
-onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-die "Could not skip unnecessary pick commands"
-
-checkout_onto
-if test -z "$rebase_root" && test ! -d "$rewritten"
-then
-	require_clean_work_tree "rebase"
-	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-		--continue
-fi
-do_rest
 
+	complete_action
 }
-# ... and then we call the whole thing.
-git_rebase__interactive
diff --git a/git-rebase.sh b/git-rebase.sh
index a1f6e5de6..b32282f4c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -196,8 +196,20 @@ run_specific_rebase () {
 		export GIT_EDITOR
 		autosquash=
 	fi
-	. git-rebase--$type
-	ret=$?
+	if test "$type" = interactive
+	then
+		. git-rebase--interactive
+		if test "$preserve_merges" = t
+		then
+			git_rebase__interactive__preserve_merges
+		else
+			git_rebase__interactive
+		fi
+		ret=$?
+	else
+		. git-rebase--$type
+		ret=$?
+	fi
 	if test $ret -eq 0
 	then
 		finish_rebase
-- 
2.16.2

