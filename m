Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6F2C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbiGSVGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiGSVFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3347BB6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e15so18157750wro.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkHtDR/5wGqidUqc4dDU7HK5yGCozUsneF1Ico9KACA=;
        b=nMn2CXneFt/rgfb3WOAF8Rl6oI2qOnXOQuyk/Q9nCz91uOKGIt2loPl9sOCMUCKHiN
         0jA6SOkNnDhF6VZeMqyoJ5mTsfZSit4KR9RcE1aw5LHr7vL+2K3tVgBYwiKFFnqrW+q3
         ohFcGRksjlwKd5gBsG+4HEfhaFFaCfnQxcpZRsWGLMmJ72goEezusHQ0kMNQNPuq+KA8
         uv1QEhLyHLlmodbNW6coHgznw4T9Sy+cbF1tuGyg2TPjZZPSlf2QXdlhN5s78/YcVjTx
         48u+2kySSjOCyzirJMbe0I48AMBVkD0AmJg9g2vM1jCFB483vQdEk22TG7LQtq490QcC
         XcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkHtDR/5wGqidUqc4dDU7HK5yGCozUsneF1Ico9KACA=;
        b=vP7ihrN2Uu+XEAvY+vQWO+u/PpuUyjtX15orqhS0Fc+fLSgnHoUjA6TsPgLMaQvvMt
         W3DVvOT0tgbR2xkCV8KQhHB8pPv/KVXOrYxQLcOSzJIxkHLUhMlcNqiVK/Sxsjj9bEmp
         +yrQDgMP0b+mA7N2Ccn0UT2PjWGXYYD3irS9Qw0oivl1wNdeV7s8Yr5yPbW4RjtmMEVX
         cGKEYIC81vvn60oRRn10u95KNi89nekYT/93wH4HNX6nPNPn3fGIxaYut1yrBHrsvM9H
         vxLaDmjaWRqRAO8sKJBHrUCq+2aJdgLbdTU7M178MqBBSpoLH82QKnOaf4EvJ/nnJjk3
         VMXw==
X-Gm-Message-State: AJIora8C6NCs36ZmxTcVtXAojyMXJiysxTykwqdTlxkMRKaGJMQ8z+yE
        fcq/a2EN7R9Mw3JTrx0xXqrZrKCaqCjLkw==
X-Google-Smtp-Source: AGRyM1soydllwZ2qBdZ3H8zJ+DHGwzfPte+Vj/+OTMgaVr6K+XRqYlbFRZzv8oPLqHVJ1t6muH+FhA==
X-Received: by 2002:a05:6000:1d83:b0:21e:229f:be69 with SMTP id bk3-20020a0560001d8300b0021e229fbe69mr8250587wrb.713.1658264740645;
        Tue, 19 Jul 2022 14:05:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] test-lib: have the "check" mode for SANITIZE=leak consider leak logs
Date:   Tue, 19 Jul 2022 23:05:22 +0200
Message-Id: <patch-08.10-afbb7e19195-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in previous on-list discussions[1] we have various tests that
will falsely report being leak-free because we're missing the relevant
exit code from LSAN as summarized below.

We should fix those issues, but in the meantime and as an additional
sanity check we can and should consider our own ASAN logs before
reporting that a test is leak-free.

Before this compiling with SANITIZE=leak and running:

    ./t4058-diff-duplicates.sh

Will exit successfully, now we'll get an error and an informative
message on:

    GIT_TEST_SANITIZE_LEAK_LOG=true ./t4058-diff-duplicates.sh

And even more useful, we'll now either error or exit successfully on
this command, depending on whether or not the test has labeled itself
leak-free with TEST_PASSES_SANITIZE_LEAK=true or not.

    GIT_TEST_SANITIZE_LEAK_LOG=true GIT_TEST_PASSING_SANITIZE_LEAK=check ./t4058-diff-duplicates.sh

Why do we miss these leaks in the first place? As initially noted in
[1] (and discussed downthread) the reasons are:

 * Our tests will (mostly) catch segfaults and abort(), but if we
   invoke a command that invokes another command it needs to ferry the
   exit code up to us.

   Notably a command that e.g. might invoke "git pack-objects" might
   itself exit with status 128 if that "pack-objects" segfaults or
   abort()'s. If the test invoking the parent command(s) is using
   "test_must_fail" we'll consider it an expected "ok" failure.

 * run-command.c notably does not do that, so for e.g. "git push"
   tests where we expect a failure and an underlying "git" command
   fails we won't ferry up the segfault or abort exit code.

 * We have gitweb.perl and some other perl code ignoring return values
   from close(), i.e. ignoring exit codes from "git rev-parse" et al.

 * We have in-tree shellscripts like "git-merge-one-file.sh" invoking
   git commands, and if they fail returning "1", not ferrying up the
   segfault or abort() exit code, or simply ignoring the exit codes(s)
   entirely, e.g. these invocations in git-merge-one-file.sh leak, but
   aren't reflected in the "git merge" exit code:

	src1=$(git unpack-file $2)
	src2=$(git unpack-file $3)

   That case would be easily "fixed" by adding a line like this after
   each assignment:

	test $? -ne 0 && exit $?

   But we'd then in e.g. "t6407-merge-binary.sh" run into
   write_tree_trivial() in "builtin/merge.c" calling die() instead of
   ferrying up the relevant exit code.

Let's remove "TEST_PASSES_SANITIZE_LEAK=true" from the one test we
were falsely marking as leak-free, marked as such in my
9081a421a6d (checkout: fix "branch info" memory leaks,
2021-11-16). I'd previously removed other bad
"TEST_PASSES_SANITIZE_LEAK=true" opt-ins in the series merged in
ea05fd5fbf7 (Merge branch 'ab/keep-git-exit-codes-in-tests',
2022-03-16).

1. https://lore.kernel.org/git/cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README                | 10 ++++++
 t/t6407-merge-binary.sh |  1 -
 t/test-lib.sh           | 72 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 7b7082386ae..fa16822cde9 100644
--- a/t/README
+++ b/t/README
@@ -381,12 +381,22 @@ without errors a failure (by providing "--invert-exit-code"). Thus the
 there's a 1=1 mapping between "TEST_PASSES_SANITIZE_LEAK=true" and
 those tests that pass under "SANITIZE=leak".
 
+The "check" mode is especially useful if combined with
+GIT_TEST_SANITIZE_LEAK_LOG=true.
+
 GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
 "test-results/$TEST_NAME.leak/trace.*" files. Useful in combination
 with "GIT_TEST_PASSING_SANITIZE_LEAK" to check if we're falsely
 reporting a test as "passing" with SANITIZE=leak due to ignored exit
 codes.
 
+When GIT_TEST_SANITIZE_LEAK_LOG=true is set we'll look at the
+"test-results/$TEST_NAME.leak/trace.*" files at the end of the test
+run in combination with the "TEST_PASSES_SANITIZE_LEAK" and
+GIT_TEST_PASSING_SANITIZE_LEAK=check setting to see if we'll fail a
+test leaked, but which the test run itself didn't catch due to ignored
+or missed exit codes.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 0753fc95f45..e8a28717cec 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -5,7 +5,6 @@ test_description='ask merge-recursive to merge binary files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 747bf6c50e5..a670c8808b1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -309,6 +309,7 @@ TEST_RESULTS_SAN_FILE_PFX=trace
 TEST_RESULTS_SAN_DIR_SFX=leak
 TEST_RESULTS_SAN_FILE=
 TEST_RESULTS_SAN_DIR="$TEST_RESULTS_DIR/$TEST_NAME.$TEST_RESULTS_SAN_DIR_SFX"
+TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP=
 TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
@@ -316,6 +317,16 @@ case "$TRASH_DIRECTORY" in
  *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
 esac
 
+# Utility functions using $TEST_RESULTS_* variables
+nr_san_dir_leaks_ () {
+	# stderr piped to /dev/null because the directory may have
+	# been "rmdir"'d already.
+	find "$TEST_RESULTS_SAN_DIR" \
+		-type f \
+		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
+	wc -l
+}
+
 # If --stress was passed, run this test repeatedly in several parallel loops.
 if test "$GIT_TEST_STRESS_STARTED" = "done"
 then
@@ -1191,6 +1202,58 @@ test_atexit_handler () {
 	teardown_malloc_check
 }
 
+sanitize_leak_log_message_ () {
+	local new="$1" &&
+	local old="$2" &&
+	local file="$3" &&
+
+	printf "With SANITIZE=leak at exit we have %d leak logs, but started with %d
+
+This means that we have a blindspot where git is leaking but we're
+losing the exit code somewhere, or not propagating it appropriately
+upwards!
+
+See the logs at \"%s.*\"" \
+	       "$new" "$old" "$file"
+}
+
+check_test_results_san_file_ () {
+	if test -z "$TEST_RESULTS_SAN_FILE"
+	then
+		return
+	fi
+	local old="$TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP" &&
+	local new="$(nr_san_dir_leaks_)" &&
+
+	if test $new -le $old
+	then
+		return
+	fi
+	local out="$(sanitize_leak_log_message_ "$new" "$old" "$TEST_RESULTS_SAN_FILE")" &&
+	say_color error "$out" &&
+
+	if test -n "$passes_sanitize_leak" && test "$test_failure" = 0
+	then
+		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, exit non-zero!"
+		invert_exit_code=t
+	elif test -n "$passes_sanitize_leak"
+	then
+		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, and we're failing for other reasons too..."
+		invert_exit_code=
+	elif test -n "$sanitize_leak_check" && test "$test_failure" = 0
+	then
+		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check"
+		invert_exit_code=
+	elif test -n "$sanitize_leak_check"
+	then
+		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check"
+		invert_exit_code=t
+	else
+		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!"
+		invert_exit_code=t
+	fi
+}
+
 test_done () {
 	# Run the atexit commands _before_ the trash directory is
 	# removed, so the commands can access pidfiles and socket files.
@@ -1266,6 +1329,8 @@ test_done () {
 			error "Tests passed but test cleanup failed; aborting"
 		fi
 
+		check_test_results_san_file_ "$test_failure"
+
 		if test -z "$skip_all" && test -n "$invert_exit_code"
 		then
 			say_color warn "# faking up non-zero exit with --invert-exit-code"
@@ -1279,6 +1344,8 @@ test_done () {
 		exit 0 ;;
 
 	*)
+		check_test_results_san_file_ "$test_failure"
+
 		if test $test_external_has_tap -eq 0
 		then
 			say_color error "# failed $test_failure among $msg"
@@ -1460,6 +1527,7 @@ then
 
 	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
 	then
+		sanitize_leak_check=t
 		if test -n "$invert_exit_code"
 		then
 			BAIL_OUT "cannot use --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=check"
@@ -1485,6 +1553,10 @@ then
 		fi &&
 		TEST_RESULTS_SAN_FILE="$TEST_RESULTS_SAN_DIR/$TEST_RESULTS_SAN_FILE_PFX"
 
+		# In case "test-results" is left over from a previous
+		# run: Only report if new leaks show up.
+		TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP=$(nr_san_dir_leaks_)
+
 		# Don't litter *.leak dirs if there was nothing to report
 		test_atexit "rmdir \"$TEST_RESULTS_SAN_DIR\" 2>/dev/null || :"
 
-- 
2.37.1.1062.g385eac7fccf

