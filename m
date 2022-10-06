Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52662C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 15:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiJFPBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJFPBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 11:01:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F5EABF3F
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 08:01:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay36so1234234wmb.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYOhMczcjq5QwLgeAHTtPo9DzIkPaIYV3y1YK0rnxg4=;
        b=ULCokJAtTk62ulRAYb78mdfCRhtF3LGlyml3f0CuSkr3GOmfsVsxuBG5LeSvl+YBLK
         r+sF28vmOYHsxglbYYCpqyqeD02c/XDa2BHZYs5qDTyqzxdQshJql4WJXx2OAvcs3iZ9
         MYPCtMCDGGMSf/CsT0TbnPG8WpxGuA4xHgagQ9RQdOWOZbAwxOkaNBpOC/DCSmjv6tXW
         cDqdYFN11XXIIJFc+S6hEfGfMC0VQoqDOniIzAXjvBs5ncKpziTm8PGIO0j1fYKkQX0e
         olZYiZt2ePHE4YmEWppoQUFWmoASG3TKT+pvK2WxClhMKbdOVtUEr8yczysErLEB+tU0
         U4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYOhMczcjq5QwLgeAHTtPo9DzIkPaIYV3y1YK0rnxg4=;
        b=4yOwz3kuyqEDUvm/0tEsqelrDa0MzalI8XsOrc6RWVGQsFB+Pdx8i9GCQLT6UOa1Fw
         0iRvoOGpHJc4/QrVmUaBiH89OnEWwMU0UDqM9fHJLbD/WT+Rk6K5vAtzgoYEpRKAmy5L
         QdLoKeAexvSnKmEhYaFWmv47lBo6omAWtICuTzBFeOHZp0A9Z7DRQggkWr0a/JUmr+3V
         ALCLRxqc3T3B+4wHrumNE54mIZOxc4XNN2llst6hpZtRX4N2Yldh/OKGj+6VxH6nbFvI
         Q6tQcDWDvydWgYkPad1kSIbXkAsaKrDm3sJG/7Kor88JG95L5cvCE7JuUiTMabhuu0im
         iEHA==
X-Gm-Message-State: ACrzQf0n1sOwMpLLJ0KVJgEhplNHtew1QBkWzRrBUUhbCeENKGlzKZBA
        FmnXB0viIo/WcXTwFXkTsYBbkQ2fCjw=
X-Google-Smtp-Source: AMsMyM5dSARL8ojjahqp1I015bgC6IAHvviSifw/pPQQNCq7+rBHPC457VxyLw/4E8Q1hvzAcDRa/w==
X-Received: by 2002:a05:600c:3c82:b0:3b5:60a6:c80f with SMTP id bg2-20020a05600c3c8200b003b560a6c80fmr104110wmb.199.1665068480315;
        Thu, 06 Oct 2022 08:01:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5606000000b00228d52b935asm18615803wrv.71.2022.10.06.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:01:19 -0700 (PDT)
Message-Id: <c0d955c2d1fa234ad2e4a8aad467b991030ccf47.1665068476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 15:01:16 +0000
Subject: [PATCH 3/3] [RFC] test_todo: allow [verbose] test as the command
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

For simplicity test_todo() allows verbose to precede any valid
command.  As POSIX specifies that a return code greater than one is an
error rather than a failed test we take care not to hide that.

I'm in two minds about this patch. Generally it is better to use one
of our test helpers such as test_cmp() rather than calling test
directly.  There are so few instances of test being used within
test_expect_failure() (the conversions here are not exhaustive but
there are not many more) that it would probably be better to convert
the tests by using the appropriate helper rather than supporting
calling test as the command to test_todo().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t0000-basic.sh        | 20 +++++++++++++++++---
 t/t0050-filesystem.sh   |  4 ++--
 t/t3903-stash.sh        | 12 ++++++------
 t/test-lib-functions.sh | 17 +++++++++++------
 4 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index db5c2059eb5..93d3930d9f6 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -198,6 +198,14 @@ test_expect_success 'subtest: test_todo allowed arguments' '
 		"echo a >a && test_todo grep --invalid-option b <a"
 	test_expect_success "test_todo detects ! grep errors" \
 		"echo a >a && test_todo ! grep --invalid-option -v b <a"
+	test_expect_success "test_todo accepts test" \
+		"test_todo test -z a"
+	test_expect_success "test_todo detects test errors" \
+		"test_todo test a xxx b"
+	test_expect_success "test_todo skips verbose and accepts good command" \
+		"test_todo verbose test -z a"
+	test_expect_success "test_todo skips verbose and rejects bad command" \
+		"test_todo verbose false"
 	test_done
 	EOF
 	check_sub_test_lib_test acceptable-test-todo <<-\EOF
@@ -213,9 +221,15 @@ test_expect_success 'subtest: test_todo allowed arguments' '
 	> #	echo a >a && test_todo grep --invalid-option b <a
 	> not ok 8 - test_todo detects ! grep errors
 	> #	echo a >a && test_todo ! grep --invalid-option -v b <a
-	> # still have 4 known breakage(s)
-	> # failed 4 among remaining 4 test(s)
-	> 1..8
+	> not ok 9 - test_todo accepts test # TODO known breakage
+	> not ok 10 - test_todo detects test errors
+	> #	test_todo test a xxx b
+	> not ok 11 - test_todo skips verbose and accepts good command # TODO known breakage
+	> not ok 12 - test_todo skips verbose and rejects bad command
+	> #	test_todo verbose false
+	> # still have 6 known breakage(s)
+	> # failed 6 among remaining 6 test(s)
+	> 1..12
 	EOF
 '
 
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 325eb1c3cd0..16b933a4c8d 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -100,7 +100,7 @@ test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
 	test_cmp expected actual
 '
 
-test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
+test_expect_success CASE_INSENSITIVE_FS 'add (with different case)' '
 	git reset --hard initial &&
 	rm camelcase &&
 	echo 1 >CamelCase &&
@@ -108,7 +108,7 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
 	git ls-files >tmp &&
 	camel=$(grep -i camelcase tmp) &&
 	test $(echo "$camel" | wc -l) = 1 &&
-	test "z$(git cat-file blob :$camel)" = z1
+	test_todo test "z$(git cat-file blob :$camel)" = z1
 '
 
 test_expect_success "setup unicode normalization tests" '
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 376cc8f4ab8..afc5b4126f3 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -556,7 +556,7 @@ test_expect_success 'unstash must re-create the file' '
 	test bar = "$(cat file)"
 '
 
-test_expect_failure 'stash directory to file' '
+test_expect_success 'stash directory to file' '
 	git reset --hard &&
 	mkdir dir &&
 	echo foo >dir/file &&
@@ -567,12 +567,12 @@ test_expect_failure 'stash directory to file' '
 	git stash save "directory to file" &&
 	test_path_is_dir dir &&
 	test foo = "$(cat dir/file)" &&
-	test_must_fail git stash apply &&
-	test bar = "$(cat dir)" &&
+	test_todo test_must_fail git stash apply &&
+	test_todo test bar = "$(cat dir)" &&
 	git reset --soft HEAD^
 '
 
-test_expect_failure 'stash file to directory' '
+test_expect_success 'stash file to directory' '
 	git reset --hard &&
 	rm file &&
 	mkdir file &&
@@ -581,8 +581,8 @@ test_expect_failure 'stash file to directory' '
 	test_path_is_file file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	test_path_is_file file/file &&
-	test foo = "$(cat file/file)"
+	test_todo test_path_is_file file/file &&
+	test_todo test foo = "$(cat file/file)"
 '
 
 test_expect_success 'giving too many ref arguments does not modify files' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index aee10bd0706..068a0702809 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1010,8 +1010,8 @@ list_contains () {
 # with env, the env and its corresponding variable settings will be
 # stripped before we we test the command being run.
 #
-# test_todo() allows "grep" or any of the assertions beginning test_
-# such as test_cmp in addition the commands allowed by
+# test_todo() allows "grep", "test" or any of the assertions beginning
+# test_ such as test_cmp in addition the commands allowed by
 # test_must_fail().
 
 test_must_fail_acceptable () {
@@ -1019,6 +1019,11 @@ test_must_fail_acceptable () {
 	name="$1"
 	shift
 
+	if test "$name" = "todo" && test "$1" = "verbose"
+	then
+		shift
+	fi
+
 	if test "$1" = "env"
 	then
 		shift
@@ -1051,7 +1056,7 @@ test_must_fail_acceptable () {
 		fi
 		return 1
 		;;
-	grep|test_*)
+	grep|test|test_*)
 		if test "$name" = "todo"
 		then
 			test_todo_command_="$1"
@@ -1133,7 +1138,7 @@ test_must_fail_helper () {
 		return 1
 	else
 		case "$test_todo_command_" in
-		grep)
+		grep|test)
 			if test $exit_code -ne 1
 			then
 			       echo >&4 "test_todo: $test_todo_command_ error: $*"
@@ -1158,8 +1163,8 @@ test_must_fail_helper () {
 #	'
 #
 # This test will fail if "git foo" fails or err is unexpectedly empty.
-# test_todo can be used with "git", "grep" or any of the "test_*"
-# assertions such as test_cmp().
+# test_todo can be used with "git", "grep", "test" or any of the
+# "test_*" assertions such as test_cmp().
 
 test_todo () {
 	if test "$test_todo_" = "test_expect_failure"
-- 
gitgitgadget
