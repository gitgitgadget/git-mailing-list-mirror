From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 20/23] test: git test cleanups.
Date: Sat, 23 Apr 2011 17:22:49 +1000
Message-ID: <1303543372-77843-21-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:25:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXDC-0005Iv-AS
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab1DWHYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:49 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44129 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1DWHYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:47 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so585772pvg.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=uIFd1zf7M8nz+O2kvNXHYKtYFqonf+b9cc3HIXxnmSI=;
        b=k84pTJcjihpaeL2/tZtbEOH/5clGKhOSppEEt4cauegHNTkXTPf0gnyhLJrcPLE96Y
         hjT+KLT4m/YajE+GyL84Wd38y2HG73r43Ll0dNE/rbDzcYQOj2Sbdf+N6FI6jlqAbWBq
         nu5+ecSV9o7KD1lr4uarzBGU6nfVoY/sOd8QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZvDF8neoakn89F70jFyilcACnHt0iyspu6T4TapczioH9AdUcEpSCQwrH09+kc+9JO
         XffRp6cXz5M26oCZBBpBzmwpjNw34ufrH8FuGDTr+j/FuLo7xmuW0SdLS88dplZmb20y
         7ESjOI05v4B/gDwJLjXhc43Mi0dIMaTgxTkRE=
Received: by 10.142.248.38 with SMTP id v38mr329484wfh.15.1303543487026;
        Sat, 23 Apr 2011 00:24:47 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171973>

---
 Documentation/git-test.txt |   48 +++++++++++++++++++++---------------------
 git-conditions-lib.sh      |    4 +-
 git-test-lib.sh            |   11 +++++----
 t/t1520-test.sh            |   50 ++++++++++++++++++++++----------------------
 4 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index b7c3161..4fa765b 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -7,7 +7,7 @@ git-test - evaluates one or more conditions about the state of the git working t
 
 SYNOPSIS
 --------
-The git test API is available in the form of a command and also as a shell library. 
+The git test API is available in the form of a command and also as a shell library.
 
 COMMAND SYNOPSIS
 ----------------
@@ -27,28 +27,28 @@ DESCRIPTION
 `git test` provides a uniform, extensible API for evaluating various conditions that
 pertain to the state of a git working tree, index and repository.
 
-Specified conditions are evaluated from left to right. If any condition evaluates to false, 
-the command conditionally prints a diagnostic message to stderr and sets a 
-non-zero status code. Otherwise, sets a status code of zero. 
+Specified conditions are evaluated from left to right. If any condition evaluates to false,
+the command conditionally prints a diagnostic message to stderr and sets a
+non-zero status code. Otherwise, sets a status code of zero.
 
 The message used to report a assertion failure may be overidden by specifying the --message option.
 
-Diagnostic output resulting from an assertion failure may be suppressed with the -q option. 
-Note that the -q option does not suppress diagnostic output that results from the failure to 
+Diagnostic output resulting from an assertion failure may be suppressed with the -q option.
+Note that the -q option does not suppress diagnostic output that results from the failure to
 successfully parse the arguments that configure the test API.
 
-The `assert` and `test_condition` functions differ according to how they handle failing conditions. 
+The `assert` and `test_condition` functions differ according to how they handle failing conditions.
 
-The `assert` function behaves like the test command but assertion failures will cause 
+The `assert` function behaves like the test command but assertion failures will cause
 the current shell to exit with a non-zero status code. To prevent this occurring, invoke
 the `assert` function within a subshell or use the `test_condition` function instead.
 
 The `test_condition` function will not exit the current shell in the event that an assertion failure
-is detected nor will it generate diagnostic relating to an assertion failure to stderr. 
+is detected nor will it generate diagnostic relating to an assertion failure to stderr.
 
-Note, however, that `test_condition` may still exit the current shell with a non-zero status code 
-if it is unable to successfully parse the arguments presented to it. Callers who need to protect 
-against this possibility either guarantee that the required arguments are available or 
+Note, however, that `test_condition` may still exit the current shell with a non-zero status code
+if it is unable to successfully parse the arguments presented to it. Callers who need to protect
+against this possibility either guarantee that the required arguments are available or
 imbed calls to `test_condition` within a subshell.
 
 The `require_condition_libs` function may be used to include any condition libs listed
@@ -77,7 +77,7 @@ CONDITIONS
 '--detached'|'--not-detached'::
 	Tests if the head is (not) detached.
 '--branch-exists'|'--not-branch-exists branch'::
-        Tests if the specified branch does (not) exist.				    
+	Tests if the specified branch does (not) exist.
 '--tag-exists'|'--not-tag-exists tag'::
         Tests if the specified tag does (not) exist.
 '--ref-exists'|'--not-ref-exists tag'::
@@ -95,15 +95,15 @@ CONDITIONS
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
-The library of conditions that the assert API can process may be extended by 
-adding functions of the form check_\{dehyphenated_condition_name\}_N to the 
-shell environment, where \{dehyphenated_condition_name\} is the result of 
-replacing any occurrence of \'-\' in the condition name with \'_\' and 
+The library of conditions that the assert API can process may be extended by
+adding functions of the form check_\{dehyphenated_condition_name\}_N to the
+shell environment, where \{dehyphenated_condition_name\} is the result of
+replacing any occurrence of \'-\' in the condition name with \'_\' and
 N is the number of arguments that need to be passed to the function.
 
-For example, suppose you are writing a script, foo.sh, that includes the git test library 
-and that you want to add a new, 1-argument, condition, foo-X to the library of 
-conditions that can be tested by the git testion framework. 
+For example, suppose you are writing a script, foo.sh, that includes the git test library
+and that you want to add a new, 1-argument, condition, foo-X to the library of
+conditions that can be tested by the git testion framework.
 
 ---------
 #/bin/sh
@@ -133,8 +133,8 @@ executes without generating any output on stdout. The resulting
 state will then be interpreted as condition evaluation failure
 rather than an assertion failure.
 
-To make such conditions available to the git test command line, put the 
-function in a file called ~/foo-lib,sh add a reference 
+To make such conditions available to the git test command line, put the
+function in a file called ~/foo-lib,sh add a reference
 to the library to the git configuration, like so:
 
 ---------
@@ -163,9 +163,9 @@ git test --not-staged --not-unstaged && git reset --hard another-commit
 -----------
 . $(git --exec-path)/git-test-lib
 assert --not-staged   	      	                              # die if there are any staged files
-assert --message "there are staged files" --not-staged	      # die with an alternative message 
+assert --message "there are staged files" --not-staged	      # die with an alternative message
                                                               # if there are any staged files
-test_condition --not-staged || echo "there are staged files"  # check whether there are staged files, 
+test_condition --not-staged || echo "there are staged files"  # check whether there are staged files,
                                                               # but do not die if there are
 -----------
 
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index ec9b516..8933321 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -141,13 +141,13 @@ check_reachable_2()
 	first=$(git rev-parse --quiet --verify "$1" 2>/dev/null) || die "'$1' is not a commit"
 	second=$(git rev-parse --quiet --verify "$2" 2>/dev/null) || die "'$2' is not a commit"
 	if test "$first" = "$second" \
-                -o -z "$(git rev-list -n1 "$first" ^"$second")" 
+	    -o -z "$(git rev-list -n1 "$first" ^"$second")"
 	then
 		echo "'$1' is reachable from '$2'."
 	else
 		echo "'$1' is not reachable from '$2'."
 		false
-	fi     
+	fi
 }
 
 check_tree_same_2()
diff --git a/git-test-lib.sh b/git-test-lib.sh
index 159cea6..e0395eb 100644
--- a/git-test-lib.sh
+++ b/git-test-lib.sh
@@ -34,7 +34,7 @@ require_lib()
 require_condition_libs() {
 	eval $(
 		git config --get-all condition.lib | while read lib
-		do 
+		do
 			echo "require_lib \"$lib\" \;"
 		done	
 	)
@@ -42,7 +42,7 @@ require_condition_libs() {
 
 assertion_failed() {
 	rc=$1
-	shift 
+	shift
 	message="${MESSAGE:-$*}"
 	if ! ${QUIET:-false}
 	then
@@ -98,6 +98,7 @@ impl() {
 		shift
 		case $word in
 			--message)
+			test $# -gt 0 || die "--message requires the following argument to be a message"
 			MESSAGE=$1
 			shift
 			continue
@@ -106,7 +107,7 @@ impl() {
 				test $# -gt 0 || die "can't shift 1 argument for --include option"
 				test -f "$1" || die "'$1' must be a file"
 				require_lib "$1"
-				shift 
+				shift
 				continue
 			;;
 			-q)
@@ -143,7 +144,7 @@ impl() {
 
 		exprs="${exprs}${exprs:+ }${negation}${negation:+ }$word $try check_${dehyphenated}_$try $args"
 
-	done 
+	done
 
 	set -- $exprs
 	while test $# -gt 0
@@ -158,7 +159,7 @@ impl() {
 		word=$1
 		nargs=$2
 		shift 2
-		message=$(eval $negation "$@") 
+		message=$(eval $negation "$@")
 		rc=$?
 		if test $rc -ne 0
 		then
diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index 1db3598..3e0571b 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -46,7 +46,7 @@ test_expect_assertion_failure()
 {
 	test=$1
 	message=$2
-	shift 
+	shift
 	test_expect_success $1 \
 "
 	! actual_message=$(git test "$@" 1>&2) &&
@@ -62,11 +62,11 @@ test_expect_assertion_failure()
 
 test_expect_success 'setup' \
 '
-	git add test-assertions-lib.sh empty-assertions-lib.sh && 
+	git add test-assertions-lib.sh empty-assertions-lib.sh &&
 	test_commit base &&
 	test_commit A &&
 	git checkout A^1 &&
-	test_commit B && 
+	test_commit B &&
 	git checkout master &&
 	test_merge M B &&
 	echo C >> B.t &&
@@ -85,7 +85,7 @@ test_expect_success 'setup' \
 	git checkout A^0 -- &&
 	test_commit G &&
 	git checkout master &&
-	git reset --hard D     
+	git reset --hard D
 '
 
 test_expect_success 'git test # no arguments' \
@@ -194,7 +194,7 @@ test_expect_success 'git test --not-unstaged' \
 
 test_expect_success 'git test --unstaged # when there are unstaged files' \
 '
-	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	test_when_finished "git reset --hard HEAD && git checkout master" &&
 	git checkout -f M^0 &&
 	git stash apply --index STASH_UNSTAGED &&
 	git test --unstaged
@@ -202,7 +202,7 @@ test_expect_success 'git test --unstaged # when there are unstaged files' \
 
 test_expect_success 'git test --not-unstaged # when there are unstaged files - should fail' \
 '
-	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	test_when_finished "git reset --hard HEAD && git checkout master" &&
 	git checkout -f M^0 &&
 	git stash apply --index STASH_UNSTAGED &&
 	test_must_fail git test --not-unstaged
@@ -210,7 +210,7 @@ test_expect_success 'git test --not-unstaged # when there are unstaged files - s
 
 test_expect_success 'git test --unstaged # when there are only staged files' \
 '
-	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	test_when_finished "git reset --hard HEAD && git checkout master" &&
 	git checkout -f M^0 &&
 	git stash apply --index STASH_STAGED &&
 	git test --not-unstaged
@@ -228,7 +228,7 @@ test_expect_success 'git test --not-staged' \
 
 test_expect_success 'git test --staged # when there are staged files' \
 '
-	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	test_when_finished "git reset --hard HEAD && git checkout master" &&
 	git checkout -f M^0 &&
 	git stash apply --index STASH_STAGED &&
 	git test --staged
@@ -236,7 +236,7 @@ test_expect_success 'git test --staged # when there are staged files' \
 
 test_expect_success 'git test --not-staged # when there are staged files - should fail' \
 '
-	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	test_when_finished "git reset --hard HEAD && git checkout master" &&
 	git checkout -f M^0 &&
 	git stash apply --index STASH_STAGED &&
 	test_must_fail git test --not-staged
@@ -244,7 +244,7 @@ test_expect_success 'git test --not-staged # when there are staged files - shoul
 
 test_expect_success 'git test --staged # when there are only unstaged files' \
 '
-	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	test_when_finished "git reset --hard HEAD && git checkout master" &&
 	git checkout -f M^0 &&
 	git stash apply --index STASH_UNSTAGED &&
 	git test --not-staged
@@ -262,14 +262,14 @@ test_expect_success 'git test --not-untracked' \
 
 test_expect_success 'git test --untracked # when there are untracked files' \
 '
-	test_when_finished "git clean -fd" && 
+	test_when_finished "git clean -fd" &&
 	:> untracked &&
 	git test --untracked
 '
 
 test_expect_success 'git test --not-untracked # when there are untracked files - should fail' \
 '
-	test_when_finished "git clean -fd" && 
+	test_when_finished "git clean -fd" &&
 	:> untracked &&
 	test_must_fail git test --not-untracked
 '
@@ -286,14 +286,14 @@ test_expect_success 'git test --detached # should fail' \
 
 test_expect_success 'git test --not-detached # when detached, should fail' \
 '
-	test_when_finished "git checkout -f master" && 
+	test_when_finished "git checkout -f master" &&
 	git checkout HEAD^0 &&
 	test_must_fail git test --not-detached
 '
 
 test_expect_success 'git test --detached # when detached' \
 '
-	test_when_finished "git checkout -f master" && 
+	test_when_finished "git checkout -f master" &&
 	git checkout HEAD^0 &&
 	git test --detached
 '
@@ -413,7 +413,7 @@ test_expect_success 'same' \
    git test \
       --same master HEAD \
       --not-same D D1 \
-      --not-same C D 
+      --not-same C D
 '
 
 test_expect_success 'clean' \
@@ -424,7 +424,7 @@ test_expect_success 'clean' \
        --not-detached \
        --not-untracked \
        --not-rebasing \
-       --not-conflicted 
+       --not-conflicted
 '
 
 test_expect_success 'existence' \
@@ -439,7 +439,7 @@ test_expect_success 'existence' \
        --tag-exists D \
        --not-tag-exists N \
        --not-tag-exists master \
-       --not-branch-exists A 
+       --not-branch-exists A
 '
 
 test_expect_success 'git test --conflicted # should fail' \
@@ -454,17 +454,17 @@ test_expect_success 'git test --not-conflicted' \
 
 test_expect_success 'git test --conflicted' \
 '
-	test_when_finished "git reset --hard HEAD" && 
+	test_when_finished "git reset --hard HEAD" &&
         ! git merge F &&
-	git test --conflicted 
+	git test --conflicted
 	
 '
 
 test_expect_success 'git test --not-conflicted # should fail when there are conflcted files' \
 '
-	test_when_finished "git reset --hard HEAD" && 
+	test_when_finished "git reset --hard HEAD" &&
         ! git merge F &&
-	test_must_fail git test --not-conflicted 
+	test_must_fail git test --not-conflicted
 	
 '
 
@@ -482,12 +482,12 @@ test_expect_success 'git test --rebasing' \
 '
 	test_when_finished "
 		git reset --hard HEAD &&
-		git checkout -f master && 
+		git checkout -f master &&
 		git branch -D rebase
-	" && 
+	" &&
         git branch rebase F &&
         ! git rebase --onto D F~1 F
-	git test --rebasing 
+	git test --rebasing
 	
 '
 
@@ -497,7 +497,7 @@ test_expect_success 'git test --not-rebasing' \
 		git reset --hard HEAD &&
 		git checkout -f master &&
 		git branch -D rebase
-	" && 
+	" &&
         git branch rebase F &&
         ! git rebase --onto D F~1 F
 	test_must_fail git test --not-rebasing
-- 
1.7.5.rc1.23.g7f622
