Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54683C433FE
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiCQKPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiCQKOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC1CDD954
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r6so6641403wrr.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udWjC6vMFs9v4mXs8DYmwYz5wAeEwnXCWnBN0gUDlUg=;
        b=m8ezQKW6DHe/L/Bn44GncZEkdUmxNOqX3Mudiwr2S61HMdLftN8zFKQLfgwyhdTK/V
         JmE4K7FHgp6c9hvFM+vw3UdhgX0+5ha7gSCb0bZstBDLmSVVK1zELEuq6u5425yfVQKE
         eiZ77UmoQ3EYo5FAIvVZ8WHCva0XF7q1/F69Bl0Io1HJDeRQoQgrEfE7VbHs4hj82hPh
         YsVOlExs8dlE0rWx4uVJMIky2HHOksvqyDSox74PQheOellLUxR2QEA7nSHxRSoEuyo0
         /TGroAEUMQlWSXo3A7dV7lvt5O+jR2uECaeiUBIOyTvPXkfj5P+Cs+LTxy1Td1gTGtt6
         4S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udWjC6vMFs9v4mXs8DYmwYz5wAeEwnXCWnBN0gUDlUg=;
        b=Hz7hlrwo6Tmdur/KUhnyKeRRTt3bm1BbCmKKr00X+JZojISjWdFAipO5GxGAVo/a71
         wwHNFtMbn07KSZ3I/+ZEuXH9TYZIyeRK8VCBnmYp90kUI1RYC2NUHTuwRxJrM8iDe8A/
         EVkgqGZ9ouzxL1KzKrd/txY+xqwd/yGK5Ak5YsLszo7jwoA8M9weeJLli5tpsICvMnCY
         X8xeRZlGgRlIsYxikmi/T+SSXz3LgVcLXbGltM25s8C9jdz1gM++Dbwq+LMyE2FxovDD
         K00qlqwJHrLjipJpSTt5Xyq7cni58FgXmHk4MaqBpkKf03Eoufu007Qqc9Cn+p4n7Wef
         RScA==
X-Gm-Message-State: AOAM531hOAMnF8Q5c/dLOXBoAgooXJ5JQcl3RDnVl463KQcTYH0fPTAu
        jTxmt5gKFDlQNEOuOeip3V0iXyqZZTg=
X-Google-Smtp-Source: ABdhPJz3W/sZwBPlgzkGZAN+NSKePLN7ky68YLaz6rbG145U5bTLPtQWODRJOQnYC7LFUc4v7fa2mQ==
X-Received: by 2002:adf:f8c6:0:b0:203:ea86:2558 with SMTP id f6-20020adff8c6000000b00203ea862558mr1795831wrq.60.1647512012945;
        Thu, 17 Mar 2022 03:13:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/13] tests: extend "test_hook" for "rm" and "chmod -x", convert "$HOOK"
Date:   Thu, 17 Mar 2022 11:13:16 +0100
Message-Id: <patch-v3-11.13-f541b0b2d70-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the "test_hook" function to take options to disable and remove
hooks. Using the wrapper instead of getting the path and running
"chmod -x" or "rm" will make it easier to eventually emulate the same
behavior with config-based hooks.

Not all of these tests need that new mode, but since the rest are
either closely related or use the same "$HOOK" pattern let's convert
them too.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2400-worktree-add.sh                       |   5 +-
 t/t5543-atomic-push.sh                        |   5 +-
 t/t5571-pre-push-hook.sh                      |  38 +++--
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 150 +++++++++---------
 t/t7504-commit-msg-hook.sh                    |  43 +++--
 t/t7505-prepare-commit-msg-hook.sh            |  43 +++--
 t/t7520-ignored-hook-warning.sh               |  11 +-
 t/test-lib-functions.sh                       |  24 +++
 8 files changed, 162 insertions(+), 157 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 43139af08fc..2f564d533d0 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -559,10 +559,7 @@ test_expect_success 'git worktree --no-guess-remote option overrides config' '
 '
 
 post_checkout_hook () {
-	gitdir=${1:-.git}
-	test_when_finished "rm -f $gitdir/hooks/post-checkout" &&
-	mkdir -p $gitdir/hooks &&
-	write_script $gitdir/hooks/post-checkout <<-\EOF
+	test_hook -C "$1" post-checkout <<-\EOF
 	{
 		echo $*
 		git rev-parse --git-dir --show-toplevel
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index bfee461861e..90676365471 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -164,10 +164,7 @@ test_expect_success 'atomic push obeys update hook preventing a branch to be pus
 	) &&
 	(
 		cd upstream &&
-		HOOKDIR="$(git rev-parse --git-dir)/hooks" &&
-		HOOK="$HOOKDIR/update" &&
-		mkdir -p "$HOOKDIR" &&
-		write_script "$HOOK" <<-\EOF
+		test_hook update <<-\EOF
 			# only allow update to main from now on
 			test "$1" = "refs/heads/main"
 		EOF
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index 96d6ecc0af7..a11b20e3782 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -6,16 +6,11 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-# Setup hook that always succeeds
-HOOKDIR="$(git rev-parse --git-dir)/hooks"
-HOOK="$HOOKDIR/pre-push"
-mkdir -p "$HOOKDIR"
-write_script "$HOOK" <<EOF
-cat >actual
-exit 0
-EOF
-
 test_expect_success 'setup' '
+	test_hook pre-push <<-\EOF &&
+	cat >actual
+	EOF
+
 	git config push.default upstream &&
 	git init --bare repo1 &&
 	git remote add parent1 repo1 &&
@@ -28,15 +23,16 @@ test_expect_success 'setup' '
 	git push parent1 HEAD:foreign &&
 	test_cmp expect actual
 '
-write_script "$HOOK" <<EOF
-cat >actual
-exit 1
-EOF
 
 COMMIT1="$(git rev-parse HEAD)"
 export COMMIT1
 
 test_expect_success 'push with failing hook' '
+	test_hook pre-push <<-\EOF &&
+	cat >actual &&
+	exit 1
+	EOF
+
 	test_commit two &&
 	cat >expect <<-EOF &&
 	HEAD $(git rev-parse HEAD) refs/heads/main $(test_oid zero)
@@ -55,13 +51,13 @@ test_expect_success '--no-verify bypasses hook' '
 COMMIT2="$(git rev-parse HEAD)"
 export COMMIT2
 
-write_script "$HOOK" <<'EOF'
-echo "$1" >actual
-echo "$2" >>actual
-cat >>actual
-EOF
-
 test_expect_success 'push with hook' '
+	test_hook --setup pre-push <<-\EOF &&
+	echo "$1" >actual
+	echo "$2" >>actual
+	cat >>actual
+	EOF
+
 	cat >expect <<-EOF &&
 	parent1
 	repo1
@@ -136,7 +132,9 @@ test_expect_success 'set up many-ref tests' '
 '
 
 test_expect_success 'sigpipe does not cause pre-push hook failure' '
-	echo "exit 0" | write_script "$HOOK" &&
+	test_hook --clobber pre-push <<-\EOF &&
+	exit 0
+	EOF
 	git push parent1 "refs/heads/b/*:refs/heads/b/*"
 '
 
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index 606d8d0f089..ad1eb64ba0d 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -7,37 +7,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-HOOKDIR="$(git rev-parse --git-dir)/hooks"
-PRECOMMIT="$HOOKDIR/pre-commit"
-PREMERGE="$HOOKDIR/pre-merge-commit"
-
-# Prepare sample scripts that write their $0 to actual_hooks
-test_expect_success 'sample script setup' '
-	mkdir -p "$HOOKDIR" &&
-	write_script "$HOOKDIR/success.sample" <<-\EOF &&
-	echo $0 >>actual_hooks
-	exit 0
-	EOF
-	write_script "$HOOKDIR/fail.sample" <<-\EOF &&
-	echo $0 >>actual_hooks
-	exit 1
-	EOF
-	write_script "$HOOKDIR/non-exec.sample" <<-\EOF &&
-	echo $0 >>actual_hooks
-	exit 1
-	EOF
-	chmod -x "$HOOKDIR/non-exec.sample" &&
-	write_script "$HOOKDIR/require-prefix.sample" <<-\EOF &&
-	echo $0 >>actual_hooks
-	test $GIT_PREFIX = "success/"
-	EOF
-	write_script "$HOOKDIR/check-author.sample" <<-\EOF
-	echo $0 >>actual_hooks
-	test "$GIT_AUTHOR_NAME" = "New Author" &&
-	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
-	EOF
-'
-
 test_expect_success 'root commit' '
 	echo "root" >file &&
 	git add file &&
@@ -96,10 +65,16 @@ test_expect_success '--no-verify with no hook (merge)' '
 	test_path_is_missing actual_hooks
 '
 
+setup_success_hook () {
+	test_when_finished "rm -f actual_hooks expected_hooks" &&
+	echo "$1" >expected_hooks &&
+	test_hook "$1" <<-EOF
+	echo $1 >>actual_hooks
+	EOF
+}
+
 test_expect_success 'with succeeding hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
-	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
-	echo "$PRECOMMIT" >expected_hooks &&
+	setup_success_hook "pre-commit" &&
 	echo "more" >>file &&
 	git add file &&
 	git commit -m "more" &&
@@ -107,9 +82,7 @@ test_expect_success 'with succeeding hook' '
 '
 
 test_expect_success 'with succeeding hook (merge)' '
-	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
-	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
-	echo "$PREMERGE" >expected_hooks &&
+	setup_success_hook "pre-merge-commit" &&
 	git checkout side &&
 	git merge -m "merge main" main &&
 	git checkout main &&
@@ -117,17 +90,14 @@ test_expect_success 'with succeeding hook (merge)' '
 '
 
 test_expect_success 'automatic merge fails; both hooks are available' '
-	test_when_finished "rm -f \"$PREMERGE\" \"$PRECOMMIT\"" &&
-	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	test_when_finished "git checkout main" &&
-	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
-	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
+	setup_success_hook "pre-commit" &&
+	setup_success_hook "pre-merge-commit" &&
 
 	git checkout conflicting-a &&
 	test_must_fail git merge -m "merge conflicting-b" conflicting-b &&
 	test_path_is_missing actual_hooks &&
 
-	echo "$PRECOMMIT" >expected_hooks &&
+	echo "pre-commit" >expected_hooks &&
 	echo a+b >conflicting &&
 	git add conflicting &&
 	git commit -m "resolve conflict" &&
@@ -135,8 +105,7 @@ test_expect_success 'automatic merge fails; both hooks are available' '
 '
 
 test_expect_success '--no-verify with succeeding hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
-	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
+	setup_success_hook "pre-commit" &&
 	echo "even more" >>file &&
 	git add file &&
 	git commit --no-verify -m "even more" &&
@@ -144,8 +113,7 @@ test_expect_success '--no-verify with succeeding hook' '
 '
 
 test_expect_success '--no-verify with succeeding hook (merge)' '
-	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
-	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
+	setup_success_hook "pre-merge-commit" &&
 	git branch -f side side-orig &&
 	git checkout side &&
 	git merge --no-verify -m "merge main" main &&
@@ -153,10 +121,19 @@ test_expect_success '--no-verify with succeeding hook (merge)' '
 	test_path_is_missing actual_hooks
 '
 
+setup_failing_hook () {
+	test_when_finished "rm -f actual_hooks" &&
+	test_hook "$1" <<-EOF
+	echo $1-failing-hook >>actual_hooks
+	exit 1
+	EOF
+}
+
 test_expect_success 'with failing hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
-	cp "$HOOKDIR/fail.sample" "$PRECOMMIT" &&
-	echo "$PRECOMMIT" >expected_hooks &&
+	setup_failing_hook "pre-commit" &&
+	test_when_finished "rm -f expected_hooks" &&
+	echo "pre-commit-failing-hook" >expected_hooks &&
+
 	echo "another" >>file &&
 	git add file &&
 	test_must_fail git commit -m "another" &&
@@ -164,8 +141,7 @@ test_expect_success 'with failing hook' '
 '
 
 test_expect_success '--no-verify with failing hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
-	cp "$HOOKDIR/fail.sample" "$PRECOMMIT" &&
+	setup_failing_hook "pre-commit" &&
 	echo "stuff" >>file &&
 	git add file &&
 	git commit --no-verify -m "stuff" &&
@@ -173,9 +149,8 @@ test_expect_success '--no-verify with failing hook' '
 '
 
 test_expect_success 'with failing hook (merge)' '
-	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
-	cp "$HOOKDIR/fail.sample" "$PREMERGE" &&
-	echo "$PREMERGE" >expected_hooks &&
+	setup_failing_hook "pre-merge-commit" &&
+	echo "pre-merge-commit-failing-hook" >expected_hooks &&
 	git checkout side &&
 	test_must_fail git merge -m "merge main" main &&
 	git checkout main &&
@@ -183,8 +158,8 @@ test_expect_success 'with failing hook (merge)' '
 '
 
 test_expect_success '--no-verify with failing hook (merge)' '
-	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
-	cp "$HOOKDIR/fail.sample" "$PREMERGE" &&
+	setup_failing_hook "pre-merge-commit" &&
+
 	git branch -f side side-orig &&
 	git checkout side &&
 	git merge --no-verify -m "merge main" main &&
@@ -192,9 +167,18 @@ test_expect_success '--no-verify with failing hook (merge)' '
 	test_path_is_missing actual_hooks
 '
 
+setup_non_exec_hook () {
+	test_when_finished "rm -f actual_hooks" &&
+	test_hook "$1" <<-\EOF &&
+	echo non-exec >>actual_hooks
+	exit 1
+	EOF
+	test_hook --disable "$1"
+}
+
+
 test_expect_success POSIXPERM 'with non-executable hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
-	cp "$HOOKDIR/non-exec.sample" "$PRECOMMIT" &&
+	setup_non_exec_hook "pre-commit" &&
 	echo "content" >>file &&
 	git add file &&
 	git commit -m "content" &&
@@ -202,8 +186,7 @@ test_expect_success POSIXPERM 'with non-executable hook' '
 '
 
 test_expect_success POSIXPERM '--no-verify with non-executable hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
-	cp "$HOOKDIR/non-exec.sample" "$PRECOMMIT" &&
+	setup_non_exec_hook "pre-commit" &&
 	echo "more content" >>file &&
 	git add file &&
 	git commit --no-verify -m "more content" &&
@@ -211,8 +194,7 @@ test_expect_success POSIXPERM '--no-verify with non-executable hook' '
 '
 
 test_expect_success POSIXPERM 'with non-executable hook (merge)' '
-	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
-	cp "$HOOKDIR/non-exec.sample" "$PREMERGE" &&
+	setup_non_exec_hook "pre-merge" &&
 	git branch -f side side-orig &&
 	git checkout side &&
 	git merge -m "merge main" main &&
@@ -221,8 +203,7 @@ test_expect_success POSIXPERM 'with non-executable hook (merge)' '
 '
 
 test_expect_success POSIXPERM '--no-verify with non-executable hook (merge)' '
-	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
-	cp "$HOOKDIR/non-exec.sample" "$PREMERGE" &&
+	setup_non_exec_hook "pre-merge" &&
 	git branch -f side side-orig &&
 	git checkout side &&
 	git merge --no-verify -m "merge main" main &&
@@ -230,10 +211,18 @@ test_expect_success POSIXPERM '--no-verify with non-executable hook (merge)' '
 	test_path_is_missing actual_hooks
 '
 
+setup_require_prefix_hook () {
+	test_when_finished "rm -f expected_hooks" &&
+	echo require-prefix >expected_hooks &&
+	test_hook pre-commit <<-\EOF
+	echo require-prefix >>actual_hooks
+	test $GIT_PREFIX = "success/"
+	EOF
+}
+
 test_expect_success 'with hook requiring GIT_PREFIX' '
-	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks success" &&
-	cp "$HOOKDIR/require-prefix.sample" "$PRECOMMIT" &&
-	echo "$PRECOMMIT" >expected_hooks &&
+	test_when_finished "rm -rf actual_hooks success" &&
+	setup_require_prefix_hook &&
 	echo "more content" >>file &&
 	git add file &&
 	mkdir success &&
@@ -245,9 +234,8 @@ test_expect_success 'with hook requiring GIT_PREFIX' '
 '
 
 test_expect_success 'with failing hook requiring GIT_PREFIX' '
-	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks fail" &&
-	cp "$HOOKDIR/require-prefix.sample" "$PRECOMMIT" &&
-	echo "$PRECOMMIT" >expected_hooks &&
+	test_when_finished "rm -rf actual_hooks fail" &&
+	setup_require_prefix_hook &&
 	echo "more content" >>file &&
 	git add file &&
 	mkdir fail &&
@@ -259,13 +247,23 @@ test_expect_success 'with failing hook requiring GIT_PREFIX' '
 	test_cmp expected_hooks actual_hooks
 '
 
+setup_require_author_hook () {
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	echo check-author >expected_hooks &&
+	test_hook pre-commit <<-\EOF
+	echo check-author >>actual_hooks
+	test "$GIT_AUTHOR_NAME" = "New Author" &&
+	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
+	EOF
+}
+
+
 test_expect_success 'check the author in hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
-	cp "$HOOKDIR/check-author.sample" "$PRECOMMIT" &&
+	setup_require_author_hook &&
 	cat >expected_hooks <<-EOF &&
-	$PRECOMMIT
-	$PRECOMMIT
-	$PRECOMMIT
+	check-author
+	check-author
+	check-author
 	EOF
 	test_must_fail git commit --allow-empty -m "by a.u.thor" &&
 	(
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index bba58f04806..a39de8c1126 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -54,15 +54,11 @@ test_expect_success '--no-verify with no hook (editor)' '
 
 '
 
-# now install hook that always succeeds
-HOOKDIR="$(git rev-parse --git-dir)/hooks"
-HOOK="$HOOKDIR/commit-msg"
-mkdir -p "$HOOKDIR"
-cat > "$HOOK" <<EOF
-#!/bin/sh
-exit 0
-EOF
-chmod +x "$HOOK"
+test_expect_success 'setup: commit-msg hook that always succeeds' '
+	test_hook --setup commit-msg <<-\EOF
+	exit 0
+	EOF
+'
 
 test_expect_success 'with succeeding hook' '
 
@@ -98,11 +94,11 @@ test_expect_success '--no-verify with succeeding hook (editor)' '
 
 '
 
-# now a hook that fails
-cat > "$HOOK" <<EOF
-#!/bin/sh
-exit 1
-EOF
+test_expect_success 'setup: commit-msg hook that always fails' '
+	test_hook --clobber commit-msg <<-\EOF
+	exit 1
+	EOF
+'
 
 commit_msg_is () {
 	test "$(git log --pretty=format:%s%b -1)" = "$1"
@@ -176,8 +172,12 @@ test_expect_success 'merge bypasses failing hook with --no-verify' '
 	commit_msg_is "Merge branch '\''main'\'' into newbranch"
 '
 
+test_expect_success 'setup: commit-msg hook made non-executable' '
+	git_dir="$(git rev-parse --git-dir)" &&
+	chmod -x "$git_dir/hooks/commit-msg"
+'
+
 
-chmod -x "$HOOK"
 test_expect_success POSIXPERM 'with non-executable hook' '
 
 	echo "content" >file &&
@@ -212,13 +212,12 @@ test_expect_success POSIXPERM '--no-verify with non-executable hook (editor)' '
 
 '
 
-# now a hook that edits the commit message
-cat > "$HOOK" <<'EOF'
-#!/bin/sh
-echo "new message" > "$1"
-exit 0
-EOF
-chmod +x "$HOOK"
+test_expect_success 'setup: commit-msg hook that edits the commit message' '
+	test_hook --clobber commit-msg <<-\EOF
+	echo "new message" >"$1"
+	exit 0
+	EOF
+'
 
 test_expect_success 'hook edits commit message' '
 
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index e39c809ca42..2128142a61c 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -47,25 +47,19 @@ test_expect_success 'with no hook' '
 
 '
 
-# set up fake editor for interactive editing
-cat > fake-editor <<'EOF'
-#!/bin/sh
-exit 0
-EOF
-chmod +x fake-editor
-
-## Not using test_set_editor here so we can easily ensure the editor variable
-## is only set for the editor tests
-FAKE_EDITOR="$(pwd)/fake-editor"
-export FAKE_EDITOR
+test_expect_success 'setup fake editor for interactive editing' '
+	write_script fake-editor <<-\EOF &&
+	exit 0
+	EOF
 
-# now install hook that always succeeds and adds a message
-HOOKDIR="$(git rev-parse --git-dir)/hooks"
-HOOK="$HOOKDIR/prepare-commit-msg"
-mkdir -p "$HOOKDIR"
-echo "#!$SHELL_PATH" > "$HOOK"
-cat >> "$HOOK" <<'EOF'
+	## Not using test_set_editor here so we can easily ensure the editor variable
+	## is only set for the editor tests
+	FAKE_EDITOR="$(pwd)/fake-editor" &&
+	export FAKE_EDITOR
+'
 
+test_expect_success 'setup prepare-commit-msg hook' '
+	test_hook --setup prepare-commit-msg <<\EOF
 GIT_DIR=$(git rev-parse --git-dir)
 if test -d "$GIT_DIR/rebase-merge"
 then
@@ -103,7 +97,7 @@ else
 fi
 exit 0
 EOF
-chmod +x "$HOOK"
+'
 
 echo dummy template > "$(git rev-parse --git-dir)/template"
 
@@ -265,10 +259,11 @@ test_expect_success 'with hook and editor (cherry-pick)' '
 	test "$(git log -1 --pretty=format:%s)" = merge
 '
 
-cat > "$HOOK" <<'EOF'
-#!/bin/sh
-exit 1
-EOF
+test_expect_success 'setup: commit-msg hook that always fails' '
+	test_hook --setup --clobber prepare-commit-msg <<-\EOF
+	exit 1
+	EOF
+'
 
 test_expect_success 'with failing hook' '
 
@@ -296,9 +291,9 @@ test_expect_success 'with failing hook (merge)' '
 	git checkout -B other HEAD@{1} &&
 	echo "more" >> file &&
 	git add file &&
-	rm -f "$HOOK" &&
+	test_hook --remove prepare-commit-msg &&
 	git commit -m other &&
-	write_script "$HOOK" <<-EOF &&
+	test_hook --setup prepare-commit-msg <<-\EOF &&
 	exit 1
 	EOF
 	git checkout - &&
diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warning.sh
index 634fb7f23a0..dc57526e6f1 100755
--- a/t/t7520-ignored-hook-warning.sh
+++ b/t/t7520-ignored-hook-warning.sh
@@ -5,10 +5,7 @@ test_description='ignored hook warning'
 . ./test-lib.sh
 
 test_expect_success setup '
-	hookdir="$(git rev-parse --git-dir)/hooks" &&
-	hook="$hookdir/pre-commit" &&
-	mkdir -p "$hookdir" &&
-	write_script "$hook" <<-\EOF
+	test_hook --setup pre-commit <<-\EOF
 	exit 0
 	EOF
 '
@@ -19,20 +16,20 @@ test_expect_success 'no warning if hook is not ignored' '
 '
 
 test_expect_success POSIXPERM 'warning if hook is ignored' '
-	chmod -x "$hook" &&
+	test_hook --disable pre-commit &&
 	git commit --allow-empty -m "even more" 2>message &&
 	test_i18ngrep -e "hook was ignored" message
 '
 
 test_expect_success POSIXPERM 'no warning if advice.ignoredHook set to false' '
 	test_config advice.ignoredHook false &&
-	chmod -x "$hook" &&
+	test_hook --disable pre-commit &&
 	git commit --allow-empty -m "even more" 2>message &&
 	test_i18ngrep ! -e "hook was ignored" message
 '
 
 test_expect_success 'no warning if unset advice.ignoredHook and hook removed' '
-	rm -f "$hook" &&
+	test_hook --remove pre-commit &&
 	test_unconfig advice.ignoredHook &&
 	git commit --allow-empty -m "even more" 2>message &&
 	test_i18ngrep ! -e "hook was ignored" message
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6c9c61c79c2..a027f0c409e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -562,9 +562,15 @@ write_script () {
 #	Overwrite an existing <hook-name>, if it exists. Implies
 #	--setup (i.e. the "test_when_finished" is assumed to have been
 #	set up already).
+#    --disable
+#	Disable (chmod -x) an existing <hook-name>, which must exist.
+#    --remove
+#	Remove (rm -f) an existing <hook-name>, which must exist.
 test_hook () {
 	setup= &&
 	clobber= &&
+	disable= &&
+	remove= &&
 	indir= &&
 	while test $# != 0
 	do
@@ -579,6 +585,12 @@ test_hook () {
 		--clobber)
 			clobber=t
 			;;
+		--disable)
+			disable=t
+			;;
+		--remove)
+			remove=t
+			;;
 		-*)
 			BUG "invalid argument: $1"
 			;;
@@ -592,6 +604,18 @@ test_hook () {
 	git_dir=$(git -C "$indir" rev-parse --absolute-git-dir) &&
 	hook_dir="$git_dir/hooks" &&
 	hook_file="$hook_dir/$1" &&
+	if test -n "$disable$remove"
+	then
+		test_path_is_file "$hook_file" &&
+		if test -n "$disable"
+		then
+			chmod -x "$hook_file"
+		elif test -n "$remove"
+		then
+			rm -f "$hook_file"
+		fi &&
+		return 0
+	fi &&
 	if test -z "$clobber"
 	then
 		test_path_is_missing "$hook_file"
-- 
2.35.1.1384.g7d2906948a1

