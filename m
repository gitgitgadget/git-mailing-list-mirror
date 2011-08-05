From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] bisect: cleanup whitespace errors in git-bisect.sh.
Date: Fri,  5 Aug 2011 21:31:30 +1000
Message-ID: <1312543891-11079-2-git-send-email-jon.seymour@gmail.com>
References: <1312543891-11079-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 13:32:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpIdH-0004Uc-DJ
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 13:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab1HELbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 07:31:49 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37760 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab1HELbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 07:31:48 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so3511413iye.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F/I9ZRmSvjyx7iqQPxiGODJcq7/w+nJiT0Ji1ge7xtM=;
        b=ch85yazUxICsv+Piejz6tsbHKW43RJPZwyq1bKsMAspV7HtIwjIUwahBoDXPNf727q
         mB884cGubhFAPqDLVY3Lux4iVaQGbkQl3h8IOqqVsoP7Bwwtr2YNA8pOu4YJmmwrPwe1
         sA5+Cx8hSe04px0zfsubmSGXNukspafFWDpY4=
Received: by 10.231.47.136 with SMTP id n8mr1659756ibf.19.1312543907787;
        Fri, 05 Aug 2011 04:31:47 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id es17sm757930ibb.54.2011.08.05.04.31.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 04:31:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.360.geebb0f
In-Reply-To: <1312543891-11079-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178790>

All leading whitespace is now encoded with tabs.

After this patch, the following is true:

	RAW=$(cat git-bisect.sh | md5sum) &&
	ROUNDTRIP=$(cat git-bisect.sh | expand -i - | unexpand --first-only - | md5sum) &&
	LEADING=$(sed -n "/^  */p" < git-bisect.sh | wc -l) &&
	test $RAW = $ROUNDTRIP &&
	test $LEADING = 0 &&
	test -z "$(git diff -w HEAD~1 HEAD)"

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |  268 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 134 insertions(+), 134 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b9c18dd..f5d9ede 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -2,27 +2,27 @@
 
 USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
-        print this long help message.
+	print this long help message.
 git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
-        reset bisect state and start bisection.
+	reset bisect state and start bisection.
 git bisect bad [<rev>]
-        mark <rev> a known-bad revision.
+	mark <rev> a known-bad revision.
 git bisect good [<rev>...]
-        mark <rev>... known-good revisions.
+	mark <rev>... known-good revisions.
 git bisect skip [(<rev>|<range>)...]
-        mark <rev>... untestable revisions.
+	mark <rev>... untestable revisions.
 git bisect next
-        find next bisection to test and check it out.
+	find next bisection to test and check it out.
 git bisect reset [<commit>]
-        finish bisection search and go back to commit.
+	finish bisection search and go back to commit.
 git bisect visualize
-        show bisect status in gitk.
+	show bisect status in gitk.
 git bisect replay <logfile>
-        replay bisection log.
+	replay bisection log.
 git bisect log
-        show bisect log.
+	show bisect log.
 git bisect run <cmd>...
-        use <cmd>... to automatically bisect.
+	use <cmd>... to automatically bisect.
 
 Please use "git help bisect" to get the full man page.'
 
@@ -55,7 +55,7 @@ bisect_autostart() {
 			# TRANSLATORS: Make sure to include [Y] and [n] in your
 			# translation. The program will only accept English input
 			# at this point.
-	    gettext "Do you want me to do it for you [Y/n]? " >&2
+			gettext "Do you want me to do it for you [Y/n]? " >&2
 			read yesno
 			case "$yesno" in
 			[Nn]*)
@@ -74,38 +74,38 @@ bisect_start() {
 	#
 	has_double_dash=0
 	for arg; do
-	    case "$arg" in --) has_double_dash=1; break ;; esac
+		case "$arg" in --) has_double_dash=1; break ;; esac
 	done
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
 	mode=''
 	while [ $# -gt 0 ]; do
-	    arg="$1"
-	    case "$arg" in
-	    --)
-		shift
-		break
+		arg="$1"
+		case "$arg" in
+		--)
+			shift
+			break
 		;;
-	    --no-checkout)
-		mode=--no-checkout
-		shift ;;
-	    --*)
-		die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
-	    *)
-		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
-		    test $has_double_dash -eq 1 &&
+		--no-checkout)
+			mode=--no-checkout
+			shift ;;
+		--*)
+			die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
+		*)
+			rev=$(git rev-parse -q --verify "$arg^{commit}") || {
+			    test $has_double_dash -eq 1 &&
 			die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
-		    break
-		}
-		case $bad_seen in
-		0) state='bad' ; bad_seen=1 ;;
-		*) state='good' ;;
+			    break
+			}
+			case $bad_seen in
+			0) state='bad' ; bad_seen=1 ;;
+			*) state='good' ;;
+			esac
+			eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
+			shift
+			;;
 		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
-		shift
-		;;
-	    esac
 	done
 
 	#
@@ -207,18 +207,18 @@ check_expected_revs() {
 }
 
 bisect_skip() {
-        all=''
+	all=''
 	for arg in "$@"
 	do
-	    case "$arg" in
-            *..*)
-		revs=$(git rev-list "$arg") || die "$(eval_gettext "Bad rev input: \$arg")" ;;
-            *)
-                revs=$(git rev-parse --sq-quote "$arg") ;;
-	    esac
-            all="$all $revs"
-        done
-        eval bisect_state 'skip' $all
+		case "$arg" in
+		*..*)
+			revs=$(git rev-list "$arg") || die "$(eval_gettext "Bad rev input: \$arg")" ;;
+		*)
+			revs=$(git rev-parse --sq-quote "$arg") ;;
+		esac
+		all="$all $revs"
+	done
+	eval bisect_state 'skip' $all
 }
 
 bisect_state() {
@@ -316,7 +316,7 @@ bisect_next() {
 	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
 	res=$?
 
-        # Check if we should exit because bisection is finished
+	# Check if we should exit because bisection is finished
 	test $res -eq 10 && exit 0
 
 	# Check for an error in the bisection process
@@ -355,12 +355,12 @@ bisect_reset() {
 	case "$#" in
 	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
 	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null || {
-	       invalid="$1"
-	       die "$(eval_gettext "'\$invalid' is not a valid commit")"
-	   }
-	   branch="$1" ;;
+			invalid="$1"
+			die "$(eval_gettext "'\$invalid' is not a valid commit")"
+		}
+		branch="$1" ;;
 	*)
-	    usage ;;
+		usage ;;
 	esac
 	if ! test -f "$GIT_DIR/BISECT_HEAD"
 	then
@@ -418,65 +418,65 @@ bisect_replay () {
 }
 
 bisect_run () {
-    bisect_next_check fail
-
-    while true
-    do
-      command="$@"
-      eval_gettext "running \$command"; echo
-      "$@"
-      res=$?
-
-      # Check for really bad run error.
-      if [ $res -lt 0 -o $res -ge 128 ]; then
-	  (
-	    eval_gettext "bisect run failed:
+	bisect_next_check fail
+
+	while true
+	do
+		command="$@"
+		eval_gettext "running \$command"; echo
+		"$@"
+		res=$?
+
+		# Check for really bad run error.
+		if [ $res -lt 0 -o $res -ge 128 ]; then
+			(
+				eval_gettext "bisect run failed:
 exit code \$res from '\$command' is < 0 or >= 128" &&
-	    echo
-	  ) >&2
-	  exit $res
-      fi
-
-      # Find current state depending on run success or failure.
-      # A special exit code of 125 means cannot test.
-      if [ $res -eq 125 ]; then
-	  state='skip'
-      elif [ $res -gt 0 ]; then
-	  state='bad'
-      else
-	  state='good'
-      fi
-
-      # We have to use a subshell because "bisect_state" can exit.
-      ( bisect_state $state > "$GIT_DIR/BISECT_RUN" )
-      res=$?
-
-      cat "$GIT_DIR/BISECT_RUN"
-
-      if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
-		> /dev/null; then
-	  (
-	      gettext "bisect run cannot continue any more" &&
-	      echo
-	  ) >&2
-	  exit $res
-      fi
-
-      if [ $res -ne 0 ]; then
-	  (
-	      eval_gettext "bisect run failed:
+				echo
+			) >&2
+			exit $res
+		fi
+
+		# Find current state depending on run success or failure.
+		# A special exit code of 125 means cannot test.
+		if [ $res -eq 125 ]; then
+			state='skip'
+		elif [ $res -gt 0 ]; then
+			state='bad'
+		else
+			state='good'
+		fi
+
+		# We have to use a subshell because "bisect_state" can exit.
+		( bisect_state $state > "$GIT_DIR/BISECT_RUN" )
+		res=$?
+
+		cat "$GIT_DIR/BISECT_RUN"
+
+		if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
+			> /dev/null; then
+			(
+				gettext "bisect run cannot continue any more" &&
+				echo
+			) >&2
+			exit $res
+		fi
+
+		if [ $res -ne 0 ]; then
+			(
+				eval_gettext "bisect run failed:
 'bisect_state \$state' exited with error code \$res" &&
-	      echo
-	  ) >&2
-	  exit $res
-      fi
+				echo
+			) >&2
+			exit $res
+		fi
 
-      if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null; then
-	  gettext "bisect run success"; echo
-	  exit 0;
-      fi
+		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null; then
+			gettext "bisect run success"; echo
+			exit 0;
+		fi
 
-    done
+	done
 }
 
 bisect_log () {
@@ -486,33 +486,33 @@ bisect_log () {
 
 case "$#" in
 0)
-    usage ;;
+	usage ;;
 *)
-    cmd="$1"
-    shift
-    case "$cmd" in
-    help)
-        git bisect -h ;;
-    start)
-        bisect_start "$@" ;;
-    bad|good)
-        bisect_state "$cmd" "$@" ;;
-    skip)
-        bisect_skip "$@" ;;
-    next)
-        # Not sure we want "next" at the UI level anymore.
-        bisect_next "$@" ;;
-    visualize|view)
-	bisect_visualize "$@" ;;
-    reset)
-        bisect_reset "$@" ;;
-    replay)
-	bisect_replay "$@" ;;
-    log)
-	bisect_log ;;
-    run)
-        bisect_run "$@" ;;
-    *)
-        usage ;;
-    esac
+	cmd="$1"
+	shift
+	case "$cmd" in
+	help)
+		git bisect -h ;;
+	start)
+		bisect_start "$@" ;;
+	bad|good)
+		bisect_state "$cmd" "$@" ;;
+	skip)
+		bisect_skip "$@" ;;
+	next)
+		# Not sure we want "next" at the UI level anymore.
+		bisect_next "$@" ;;
+	visualize|view)
+		bisect_visualize "$@" ;;
+	reset)
+		bisect_reset "$@" ;;
+	replay)
+		bisect_replay "$@" ;;
+	log)
+		bisect_log ;;
+	run)
+		bisect_run "$@" ;;
+	*)
+		usage ;;
+	esac
 esac
-- 
1.7.6.354.g7f57d
