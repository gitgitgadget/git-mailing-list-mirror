Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388B8C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 15:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJFPB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiJFPBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 11:01:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F5AE202
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 08:01:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so1094676wmb.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCXboyvyUW+ZS9pW2eDzzGWkdP/eMiqxpyCoOXN9g8U=;
        b=G8rEsyuI30VngbROKH6V73AlmNZqF/LqYD0AxHTD64TNlDQiR5aUXxGqOBW7VMtgJc
         WBd/eLM1mWEEhJTirjfLz73yYNfWBWWb/A9QYFxzKifX0O9Joy659mE+8SjD/SObbqJF
         wZ8rQiZ8RwCCip5iGf9Wgcmi/ds4neTexNTZ2HVOZaIZNAESINQjBriOXh95Etrgjuu1
         i/htLl9AUePCNJGZrw7uuJ+Is0UtkW2H7I0gahB8N+sIIc6D7BdX5mlYfmi4M1fc19oA
         qK93APXMc0/QmZom5Bo724cTZMqV9WbxwguyYNZof2iZvieRpx1ne12FvLO7S9tBJmjp
         uNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCXboyvyUW+ZS9pW2eDzzGWkdP/eMiqxpyCoOXN9g8U=;
        b=s0kNLU6Z8loeiiwp5VBVcG2bR38kOTyM2pzn5Y13Aro0x63X3ZVzS4mZloheOzbH5x
         Sfke+MKJJS9r1dh24XqPLIsprYwEB2gHFbhcH7NXKc94KP9rkek26aQK2+etKaPtfpsB
         hFVsEqwl+isu2ILVXuZhzDsRAkj/0dSQbhqCrB6uRtwA5I3NShtm6xwLD/xHZgccWSy1
         IDSXY2Ip89uW/XthGcumcNd68TUBiNs8ywGoC03f8qysvVhUchaoLLNCO0nbDlH5aSs9
         cVwiMo8JjJ+EYfkNV6Y95QNeFtg1nDx65kPvi+6E7eaU5zde3mVnR7DJ00t40CglVA4V
         aBYw==
X-Gm-Message-State: ACrzQf1iUnkq3HXjAazHwjoa7Ps9bwKtOjuVYTDvOsUsOSercoVWw+Sy
        aQHQZ4HIez1UzLZNd8zOYG2wI//lH0M=
X-Google-Smtp-Source: AMsMyM6vRdj8IYmGVb610wyLi1FpZpCXuGoc0XpSBAPHiCRA4Z6sFHwWFWXECFyCk38ABwXXt6bHng==
X-Received: by 2002:a05:600c:524b:b0:3b4:8c0c:f3b6 with SMTP id fc11-20020a05600c524b00b003b48c0cf3b6mr7542251wmb.50.1665068478353;
        Thu, 06 Oct 2022 08:01:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6b03000000b0022860e8ae7csm11108006wrw.77.2022.10.06.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:01:18 -0700 (PDT)
Message-Id: <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 15:01:14 +0000
Subject: [PATCH 1/3] [RFC] tests: add test_todo() to mark known breakages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

test_todo() is intended as a fine grained replacement for
test_expect_failure(). Rather than marking the whole test as failing
test_todo() is used to mark individual failing commands within a
test. This approach to writing failing tests allows us to detect
unexpected failures that are hidden by test_expect_failure().

Failing commands are reported by the test harness in the same way as
test_expect_failure() so there is no change in output when migrating
from test_expect_failure() to test_todo(). If a command marked with
test_todo() succeeds then the test will fail. This is designed to make
it easier to see when a command starts succeeding in our CI compared
to using test_expect_failure() where it is easy to fix a failing test
case and not realize it.

test_todo() is built upon test_expect_failure() but accepts commands
starting with test_* in addition to git. As our test_* assertions use
BUG() to signal usage errors any such error will not be hidden by
test_todo().

This commit coverts a few tests to show the intended use of
test_todo().  A limitation of test_todo() as it is currently
implemented is that it cannot be used in a subshell.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/README                        |  12 +++
 t/t0000-basic.sh                |  64 ++++++++++++++
 t/t3401-rebase-and-am-rename.sh |  12 +--
 t/t3424-rebase-empty.sh         |   6 +-
 t/t3600-rm.sh                   |   8 +-
 t/test-lib-functions.sh         | 147 +++++++++++++++++++++++---------
 6 files changed, 194 insertions(+), 55 deletions(-)

diff --git a/t/README b/t/README
index 979b2d4833d..642aeab80b4 100644
--- a/t/README
+++ b/t/README
@@ -892,6 +892,10 @@ see test-lib-functions.sh for the full list and their options.
 
  - test_expect_failure [<prereq>] <message> <script>
 
+   Where possible new tests should use test_expect_success and mark
+   the individual failing commands with test_todo (see below) rather
+   than using test_expect_failure.
+
    This is NOT the opposite of test_expect_success, but is used
    to mark a test that demonstrates a known breakage.  Unlike
    the usual test_expect_success tests, which say "ok" on
@@ -902,6 +906,14 @@ see test-lib-functions.sh for the full list and their options.
    Like test_expect_success this function can optionally use a three
    argument invocation with a prerequisite as the first argument.
 
+ - test_todo <command>
+
+   This is used to mark commands that should succeed but do not due to
+   a known issue. The test will be reported as a known failure if the
+   issue still exists and won’t cause -i (immediate) to stop. If the
+   command unexpectedly succeeds then the test will be reported as a
+   failing. test_todo cannot be used in a subshell.
+
  - test_debug <script>
 
    This takes a single argument, <script>, and evaluates it only
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 502b4bcf9ea..52362ad3dd3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -141,6 +141,70 @@ test_expect_success 'subtest: a passing TODO test' '
 	EOF
 '
 
+test_expect_success 'subtest: a failing test_todo' '
+	write_and_run_sub_test_lib_test failing-test-todo <<-\EOF &&
+	test_false () {
+		false
+	}
+	test_expect_success "passing test" "true"
+	test_expect_success "known todo" "test_todo test_false"
+	test_done
+	EOF
+	check_sub_test_lib_test failing-test-todo <<-\EOF
+	> ok 1 - passing test
+	> not ok 2 - known todo # TODO known breakage
+	> # still have 1 known breakage(s)
+	> # passed all remaining 1 test(s)
+	> 1..2
+	EOF
+'
+
+test_expect_success 'subtest: a passing test_todo' '
+	write_and_run_sub_test_lib_test_err passing-test-todo <<-\EOF &&
+	test_true () {
+		true
+	}
+	test_expect_success "pretend we have fixed a test_todo breakage" \
+		"test_todo test_true"
+	test_done
+	EOF
+	check_sub_test_lib_test passing-test-todo <<-\EOF
+	> not ok 1 - pretend we have fixed a test_todo breakage
+	> #	test_todo test_true
+	> # failed 1 among 1 test(s)
+	> 1..1
+	EOF
+'
+
+test_expect_success 'subtest: test_todo allowed arguments' '
+	write_and_run_sub_test_lib_test_err acceptable-test-todo <<-\EOF &&
+	# This an acceptable command for test_todo but not test_must_fail
+	test_true () {
+		  return 0
+	}
+	test_expect_success "test_todo skips env and accepts good command" \
+		"test_todo env Var=Value git --invalid-option"
+	test_expect_success "test_todo skips env and rejects bad command" \
+		"test_todo env Var=Value false"
+	test_expect_success "test_todo test_must_fail accepts good command" \
+		"test_todo test_must_fail git --version"
+	test_expect_success "test_todo test_must_fail rejects bad command" \
+		"test_todo test_must_fail test_true"
+	test_done
+	EOF
+	check_sub_test_lib_test acceptable-test-todo <<-\EOF
+	> not ok 1 - test_todo skips env and accepts good command # TODO known breakage
+	> not ok 2 - test_todo skips env and rejects bad command
+	> #	test_todo env Var=Value false
+	> not ok 3 - test_todo test_must_fail accepts good command # TODO known breakage
+	> not ok 4 - test_todo test_must_fail rejects bad command
+	> #	test_todo test_must_fail test_true
+	> # still have 2 known breakage(s)
+	> # failed 2 among remaining 2 test(s)
+	> 1..4
+	EOF
+'
+
 test_expect_success 'subtest: 2 TODO tests, one passin' '
 	write_and_run_sub_test_lib_test partially-passing-todos <<-\EOF &&
 	test_expect_failure "pretend we have a known breakage" "false"
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index f18bae94507..cc5da9f5afe 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -52,7 +52,7 @@ test_expect_success 'rebase --interactive: directory rename detected' '
 	)
 '
 
-test_expect_failure 'rebase --apply: directory rename detected' '
+test_expect_success 'rebase --apply: directory rename detected' '
 	(
 		cd dir-rename &&
 
@@ -63,8 +63,8 @@ test_expect_failure 'rebase --apply: directory rename detected' '
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
 
-		test_path_is_file y/d &&
-		test_path_is_missing x/d
+		test_todo test_path_is_file y/d &&
+		test_todo test_path_is_missing x/d
 	)
 '
 
@@ -84,7 +84,7 @@ test_expect_success 'rebase --merge: directory rename detected' '
 	)
 '
 
-test_expect_failure 'am: directory rename detected' '
+test_expect_success 'am: directory rename detected' '
 	(
 		cd dir-rename &&
 
@@ -97,8 +97,8 @@ test_expect_failure 'am: directory rename detected' '
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
 
-		test_path_is_file y/d &&
-		test_path_is_missing x/d
+		test_todo test_path_is_file y/d &&
+		test_todo test_path_is_missing x/d
 	)
 '
 
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 5e1045a0afc..b7cae260759 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -34,15 +34,15 @@ test_expect_success 'setup test repository' '
 	git commit -m "Five letters ought to be enough for anybody"
 '
 
-test_expect_failure 'rebase (apply-backend)' '
-	test_when_finished "git rebase --abort" &&
+test_expect_success 'rebase (apply-backend)' '
+	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -B testing localmods &&
 	# rebase (--apply) should not drop commits that start empty
 	git rebase --apply upstream &&
 
 	test_write_lines D C B A >expect &&
 	git log --format=%s >actual &&
-	test_cmp expect actual
+	test_todo test_cmp expect actual
 '
 
 test_expect_success 'rebase --merge --empty=drop' '
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index e74a318ac33..fa7831c0674 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -790,7 +790,7 @@ test_expect_success SYMLINKS 'rm across a symlinked leading path (no index)' '
 	test_path_is_file e/f
 '
 
-test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index)' '
+test_expect_success SYMLINKS 'rm across a symlinked leading path (w/ index)' '
 	rm -rf d e &&
 	mkdir d &&
 	echo content >d/f &&
@@ -798,10 +798,10 @@ test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index)' '
 	git commit -m "d/f exists" &&
 	mv d e &&
 	ln -s e d &&
-	test_must_fail git rm d/f &&
-	git rev-parse --verify :d/f &&
+	test_todo test_must_fail git rm d/f &&
+	test_todo git rev-parse --verify :d/f &&
 	test -h d &&
-	test_path_is_file e/f
+	test_todo test_path_is_file e/f
 '
 
 test_expect_success 'setup for testing rm messages' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c6479f24eb5..8978709b231 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -802,6 +802,7 @@ test_expect_failure () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
+		test_todo_=test_expect_failure
 		test -n "$test_skip_test_preamble" ||
 		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
 		if test_run_ "$2" expecting_failure
@@ -825,9 +826,15 @@ test_expect_success () {
 	then
 		test -n "$test_skip_test_preamble" ||
 		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
+		test_todo_=test_expect_success
 		if test_run_ "$2"
 		then
-			test_ok_ "$1"
+			if test "$test_todo_" = "todo"
+			then
+				test_known_broken_failure_ "$1"
+			else
+				test_ok_ "$1"
+			fi
 		else
 			test_failure_ "$@"
 		fi
@@ -999,10 +1006,18 @@ list_contains () {
 }
 
 # Returns success if the arguments indicate that a command should be
-# accepted by test_must_fail(). If the command is run with env, the env
-# and its corresponding variable settings will be stripped before we
-# test the command being run.
+# accepted by test_must_fail() or test_todo(). If the command is run
+# with env, the env and its corresponding variable settings will be
+# stripped before we we test the command being run.
+#
+# test_todo() allows any of the assertions beginning test_ such as
+# test_cmp in addition the commands allowed by test_must_fail().
+
 test_must_fail_acceptable () {
+	local name
+	name="$1"
+	shift
+
 	if test "$1" = "env"
 	then
 		shift
@@ -1023,12 +1038,96 @@ test_must_fail_acceptable () {
 	git|__git*|test-tool|test_terminal)
 		return 0
 		;;
+	test_might_fail|test_todo|test_when_finished)
+		return 1
+		;;
+	test_must_fail)
+		if test "$name" = "todo"
+		then
+			shift
+			test_must_fail_acceptable must_fail "$@"
+			return $?
+		fi
+		return 1
+		;;
+	test_*)
+		test "$name" = "todo"
+		return $?
+		;;
 	*)
 		return 1
 		;;
 	esac
 }
 
+test_must_fail_helper () {
+	test_must_fail_name_="$1"
+	shift
+	case "$1" in
+	ok=*)
+		_test_ok=${1#ok=}
+		shift
+		;;
+	*)
+		_test_ok=
+		;;
+	esac
+	if ! test_must_fail_acceptable $test_must_fail_name_ "$@"
+	then
+		echo >&7 "test_$test_must_fail_name_: only 'git' is allowed: $*"
+		return 1
+	fi
+	"$@" 2>&7
+	exit_code=$?
+	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
+	then
+		echo >&4 "test_$test_must_fail_name_: command succeeded: $*"
+		return 1
+	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
+	then
+		return 0
+	elif test $exit_code -gt 129 && test $exit_code -le 192
+	then
+		echo >&4 "test_$test_must_fail_name_: died by signal $(($exit_code - 128)): $*"
+		return 1
+	elif test $exit_code -eq 127
+	then
+		echo >&4 "test_$test_must_fail_name_: command not found: $*"
+		return 1
+	elif test $exit_code -eq 126
+	then
+		echo >&4 "test_$test_must_fail_name_: valgrind error: $*"
+		return 1
+	fi
+
+	return 0
+} 7>&2 2>&4
+
+# This is used to mark commands that should succeed but do not due to
+# a known issue. Marking the individual commands that fail rather than
+# using test_expect_failure allows us to detect any unexpected
+# failures. As with test_must_fail if the command is killed by a
+# signal the test will fail. If the command unexpectedly succeeds then
+# the test will also fail. For example:
+#
+#	test_expect_success 'test a known failure' '
+#		git foo 2>err &&
+#		test_todo test_must_be_empty err
+#	'
+#
+# This test will fail if "git foo" fails or err is unexpectedly empty.
+# test_todo can be used with "git" or any of the "test_*" assertions
+# such as test_cmp().
+
+test_todo () {
+	if test "$test_todo_" = "test_expect_failure"
+	then
+		BUG "test_todo_ cannot be used inside test_expect_failure"
+	fi
+	test_todo_=todo
+	test_must_fail_helper todo "$@" 2>&7
+} 7>&2 2>&4
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #
@@ -1061,43 +1160,7 @@ test_must_fail_acceptable () {
 #    ! grep pattern output
 
 test_must_fail () {
-	case "$1" in
-	ok=*)
-		_test_ok=${1#ok=}
-		shift
-		;;
-	*)
-		_test_ok=
-		;;
-	esac
-	if ! test_must_fail_acceptable "$@"
-	then
-		echo >&7 "test_must_fail: only 'git' is allowed: $*"
-		return 1
-	fi
-	"$@" 2>&7
-	exit_code=$?
-	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
-	then
-		echo >&4 "test_must_fail: command succeeded: $*"
-		return 1
-	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
-	then
-		return 0
-	elif test $exit_code -gt 129 && test $exit_code -le 192
-	then
-		echo >&4 "test_must_fail: died by signal $(($exit_code - 128)): $*"
-		return 1
-	elif test $exit_code -eq 127
-	then
-		echo >&4 "test_must_fail: command not found: $*"
-		return 1
-	elif test $exit_code -eq 126
-	then
-		echo >&4 "test_must_fail: valgrind error: $*"
-		return 1
-	fi
-	return 0
+	test_must_fail_helper must_fail "$@" 2>&7
 } 7>&2 2>&4
 
 # Similar to test_must_fail, but tolerates success, too.  This is
@@ -1114,7 +1177,7 @@ test_must_fail () {
 # Accepts the same options as test_must_fail.
 
 test_might_fail () {
-	test_must_fail ok=success "$@" 2>&7
+	test_must_fail_helper might_fail ok=success "$@" 2>&7
 } 7>&2 2>&4
 
 # Similar to test_must_fail and test_might_fail, but check that a
-- 
gitgitgadget

