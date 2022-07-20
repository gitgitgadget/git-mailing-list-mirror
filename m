Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D2CC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiGTVWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGTVW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB45599D3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so2021170wmm.4
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6b+UXhvpYJ8Bb9/vTHQ5J513hdENgrcWhymVXXjxM+Y=;
        b=is9GmBNLY6Ig30covK+EYDk1dh/oBnT7lQNrovLVM2+rih4CHE+a9wpmUBsp8l8QM7
         YlqP6MtxaMSmLYuoXucoDUEQnvpoXDDzqsy6CtfNSaN4jQ6tWXPEdrMvpRaDNkLvAVZU
         Q0Kn1RQTks2z8W5g2tZIba8XwcJorj0IOIEUHpZQc8RcWos3Nv66REG0wOb5CW3sr6JY
         bFR5NI1CvtdEP+6T14vYPOk8ovC5uRNdfab6tEt/o3A1ZwY+8KkgzB9bUuFsWX504GWH
         oLrb40ZJ1bRObdFE6OyBFrnrJdNIipQNGxdLlNzgULZS7Ogsqe+s2HX9AEQ4KYDOk+tF
         b9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6b+UXhvpYJ8Bb9/vTHQ5J513hdENgrcWhymVXXjxM+Y=;
        b=PQ10QnUNXSjWOnLEFLjCX/zZ+m429Kl2uXIjXZDgHnV84CGYy0VzRz+liSnSRIrfyM
         jCQTRBZ1ZCAe0n37VQ0QIF/RxF69Z3cbYgegMisefrk7EE9kqZFUrBoJYnAFyMjkJtZm
         i95OL2U3OXza6rk6YpBj0LVohHb0+rhciDHzp3EH7hemArBOugGGVw7qEUUpaa4A6rXV
         Bh6LpTtzp60SKL9equse91KaxZ5vjqijR+QVXNNOqW0Os+gRLxvZ//QGvrGH+dmDVF2i
         PBBnnrH1qB50sWEOnDxTBAkcrb0CQMU/S3qnKpfBEtjoSppCGe3a21EnkWacsNLPcj3e
         TEVA==
X-Gm-Message-State: AJIora/6lwbLM4XD7/Ath4Q9C24yRG0NUaur2NHVvB5jwkdKbq0vxJfc
        gmAKSd+oV8iZd/jIK1qSD5IkzSPrHC4S3A==
X-Google-Smtp-Source: AGRyM1u9S//G2PkdZSp2emYxKnJHCFhhMDr8orhJdu/h6S7b4VBKfJeZq66B/RpLO26BeqGLIeac/w==
X-Received: by 2002:a05:600c:1f16:b0:3a3:214c:a85e with SMTP id bd22-20020a05600c1f1600b003a3214ca85emr5521117wmb.95.1658352139570;
        Wed, 20 Jul 2022 14:22:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/14] test-lib: have the "check" mode for SANITIZE=leak consider leak logs
Date:   Wed, 20 Jul 2022 23:21:49 +0200
Message-Id: <patch-v2-11.14-8cc6ab390db-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
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

    ./t6407-merge-binary.sh

Will exit successfully, now we'll get an error and an informative
message on:

    GIT_TEST_SANITIZE_LEAK_LOG=true ./t6407-merge-binary.sh

Even better, as noted in the updated t/README we'll now error out when
combined with the "check" mode:

    GIT_TEST_PASSING_SANITIZE_LEAK=check \
    GIT_TEST_SANITIZE_LEAK_LOG=true \
	./t4058-diff-duplicates.sh

Why do we miss these leaks? Because:

 * We have leaks inside "test_expect_failure" blocks, which by design
   will not distinguish a "normal" failure from an abort() or
   segfault. See [1] for a discussion of it shortcomings.

 * We have "git" invocations outside of "test_expect_success",
   e.g. setup code in the main body of the test, or in test helper
   functions that don't use &&-chaining.

 * Our tests will otherwise catch segfaults and abort(), but if we
   invoke a command that invokes another command it needs to ferry the
   exit code up to us.

   Notably a command that e.g. might invoke "git pack-objects" might
   itself exit with status 128 if that "pack-objects" segfaults or
   abort()'s. If the test invoking the parent command(s) is using
   "test_must_fail" we'll consider it an expected "ok" failure.

 * run-command.c doesn't (but probably should) ferry up such exit
   codes, so for e.g. "git push" tests where we expect a failure and an
   underlying "git" command fails we won't ferry up the segfault or
   abort exit code.

 * We have gitweb.perl and some other perl code ignoring return values
   from close(), i.e. ignoring exit codes from "git rev-parse" et al.

 * We have in-tree shellscripts like "git-merge-one-file.sh" invoking
   git commands, they'll usually return their own exit codes on "git"
   failure, rather then ferrying up segfault or abort() exit code.

   E.g. these invocations in git-merge-one-file.sh leak, but aren't
   reflected in the "git merge" exit code:

	src1=$(git unpack-file $2)
	src2=$(git unpack-file $3)

   That case would be easily "fixed" by adding a line like this after
   each assignment:

	test $? -ne 0 && exit $?

   But we'd then in e.g. "t6407-merge-binary.sh" run into
   write_tree_trivial() in "builtin/merge.c" calling die() instead of
   ferrying up the relevant exit code.

Let's remove "TEST_PASSES_SANITIZE_LEAK=true" from tests we
were falsely marking as leak-free.

In the case of t6407-merge-binary.sh it was marked as leak-free in
9081a421a6d (checkout: fix "branch info" memory leaks,
2021-11-16). I'd previously removed other bad
"TEST_PASSES_SANITIZE_LEAK=true" opt-ins in the series merged in
ea05fd5fbf7 (Merge branch 'ab/keep-git-exit-codes-in-tests',
2022-03-16). The case of t1060-object-corruption.sh is more subtle,
and will be discussed in a subsequent commit.

1. https://lore.kernel.org/git/cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README                     | 15 +++++++
 t/t1060-object-corruption.sh |  1 -
 t/t6407-merge-binary.sh      |  1 -
 t/test-lib.sh                | 80 ++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index e13063195e5..2f439f96589 100644
--- a/t/README
+++ b/t/README
@@ -385,6 +385,12 @@ GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
 "dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
 make logs +machine-readable.
 
+With GIT_TEST_SANITIZE_LEAK_LOG=true we'll look at the leak logs
+before exiting and exit on failure if the logs showed that we had a
+memory leak, even if the test itself would have otherwise passed. This
+allows us to catch e.g. missing &&-chaining. This is especially useful
+when combined with "GIT_TEST_PASSING_SANITIZE_LEAK", see below.
+
 GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
 will run to completion faster, and result in the same failing
 tests. The only practical reason to run
@@ -393,6 +399,15 @@ combine it with "GIT_TEST_SANITIZE_LEAK_LOG=true". If we stop at the
 first failing test case our leak logs won't show subsequent leaks we
 might have run into.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=(true|check) will not catch all memory
+leaks unless combined with GIT_TEST_SANITIZE_LEAK_LOG=true. Some tests
+run "git" (or "test-tool" etc.) without properly checking the exit
+code, or git will invoke itself and fail to ferry the abort() exit
+code to the original caller. When the two modes are combined we'll
+look at the "test-results/$TEST_NAME.leak/trace.*" files at the end of
+the test run to see if had memory leaks which the test itself didn't
+catch.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 5b8e47e346c..e8a58b15897 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -2,7 +2,6 @@
 
 test_description='see how we handle various forms of corruption'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # convert "1234abcd" to ".git/objects/12/34abcd"
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
index 5785eaf08dc..227a7efa241 100644
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
@@ -1191,6 +1202,66 @@ test_atexit_handler () {
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
+See the logs at \"%s.*\";
+those logs are reproduced below." \
+	       "$new" "$old" "$file"
+}
+
+check_test_results_san_file_ () {
+	if test -z "$TEST_RESULTS_SAN_FILE"
+	then
+		return
+	fi &&
+	local old="$TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP" &&
+	local new="$(nr_san_dir_leaks_)" &&
+
+	if test $new -le $old
+	then
+		return
+	fi &&
+	local out="$(sanitize_leak_log_message_ "$new" "$old" "$TEST_RESULTS_SAN_FILE")" &&
+	say_color error "$out" &&
+	if test "$old" != 0
+	then
+		echo &&
+		say_color error "The logs include output from past runs to avoid" &&
+		say_color error "that remove 'test-results' between runs."
+	fi &&
+	say_color error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
+
+	if test -n "$passes_sanitize_leak" && test "$test_failure" = 0
+	then
+		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, exit non-zero!" &&
+		invert_exit_code=t
+	elif test -n "$passes_sanitize_leak"
+	then
+		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, and we're failing for other reasons too..." &&
+		invert_exit_code=
+	elif test -n "$sanitize_leak_check" && test "$test_failure" = 0
+	then
+		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
+		invert_exit_code=
+	elif test -n "$sanitize_leak_check"
+	then
+		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
+		invert_exit_code=t
+	else
+		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
+		invert_exit_code=t
+	fi
+}
+
 test_done () {
 	# Run the atexit commands _before_ the trash directory is
 	# removed, so the commands can access pidfiles and socket files.
@@ -1270,6 +1341,8 @@ test_done () {
 			error "Tests passed but test cleanup failed; aborting"
 		fi
 
+		check_test_results_san_file_ "$test_failure"
+
 		if test -z "$skip_all" && test -n "$invert_exit_code"
 		then
 			say_color warn "# faking up non-zero exit with --invert-exit-code"
@@ -1286,6 +1359,8 @@ test_done () {
 		say_color error "# failed $test_failure among $msg"
 		say "1..$test_count"
 
+		check_test_results_san_file_ "$test_failure"
+
 		if test -n "$invert_exit_code"
 		then
 			_invert_exit_code_failure_end_blurb
@@ -1465,6 +1540,7 @@ then
 
 	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
 	then
+		sanitize_leak_check=t
 		if test -n "$invert_exit_code"
 		then
 			BAIL_OUT "cannot use --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=check"
@@ -1490,6 +1566,10 @@ then
 		fi &&
 		TEST_RESULTS_SAN_FILE="$TEST_RESULTS_SAN_DIR/$TEST_RESULTS_SAN_FILE_PFX"
 
+		# In case "test-results" is left over from a previous
+		# run: Only report if new leaks show up.
+		TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP=$(nr_san_dir_leaks_)
+
 		# Don't litter *.leak dirs if there was nothing to report
 		test_atexit "rmdir \"$TEST_RESULTS_SAN_DIR\" 2>/dev/null || :"
 
-- 
2.37.1.1064.gc96144cf387

