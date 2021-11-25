Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96B7C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353564AbhKYIob (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353354AbhKYImb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:42:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467AC06175A
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so9883699wrr.8
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VXX2CU3k0Z32m3gnSDBpkEW1vXu+aZ0opDUrWO9BhnM=;
        b=ci6ICVkVlde59Yr2X2oiK+88spNTXnRER4E0BQGZroF2r8eFeOOJPey5FWY0FlC7pZ
         DAI2+lwkiHS2cj23EawWPtmFcqY2OUyAzoh32PcCjexAKFEImLxWorPIz5TayfzLzM6k
         Vn/nZbOj/tNdpC3QenZbgJrgdSwy7NMpwsulEXEsTkeCXo3d9JLMNLTLMbmxgdFPTDqx
         7ymcs1243DuU5NnXXTCQO1opARK9D+KnQ17FJJFv3TtKtgG01rB+Q3xV/lpk603tkQJ7
         U4h2QjB9i+OI/AAUX4DdoMf4cQikxKlrtk3m4RSjUthSL2oTuQquap9B9NekY4tv9GPT
         nEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VXX2CU3k0Z32m3gnSDBpkEW1vXu+aZ0opDUrWO9BhnM=;
        b=H9WExw3LRTxTdnB9r8rxJjroGfhSOdNAlZJRYymX184vVqLevQzCXCBRkodWwngT1f
         FWBpM4tirCBP49MRxXKjtwX2HgQGHl0XUO9yQm/9rNPYvKyd3DPsZIVsdleSBfVmzV/u
         C2d0hvYgHplRheEExbCWDqaomQFqLbpEsAzhrrPO1cGKmkNgJ6//sGcnxf3jxAOxtz4s
         yWarIT/sXy8rowpKOp0KQC1kAXqGJnZ0H9ABizk6WKNxViS7PmBf5lSsmHZ8Ssh3mA/v
         M+QPj0m1nKLcdXrDsHns+Phn5dJJYs2pvDnBtbTsl1fA7VeemvszlOWFp/km4FPliSwg
         v90w==
X-Gm-Message-State: AOAM533gIJvAB/EralDWZCE9iMS/GRr1q1QMp93hOwhDyKajlpTzTrjj
        fX8kHy55rB3gB4kUDigsKQI/SBGlGXA=
X-Google-Smtp-Source: ABdhPJyCSl5U+U1iejJrN7322gYP0qOd9/Aco4gEZjABLtuLdkrF2qc2GIDsdXNgT105EBysgmpLGg==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr4927930wrs.291.1637829558661;
        Thu, 25 Nov 2021 00:39:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm2198431wrp.8.2021.11.25.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:18 -0800 (PST)
Message-Id: <38a120f5c0379daabc1f9730039ff7166037410d.1637829556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:08 +0000
Subject: [PATCH v2 1/9] t2501: add various tests for removing the current
 working directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Numerous commands will remove empty working directories, especially if
they are in the way of placing needed files.  That is normally fine, but
removing the current working directory can cause confusion for the user
when they run subsequent commands.  For example, after one git process
has removed the current working directory, git status/log/diff will all
abort with the message:

    fatal: Unable to read current working directory: No such file or directory

Since there are several code paths that can result in the current
working directory being removed, add several tests of various different
codepaths that check for the behavior we would instead like to see.
This include a number of new error messages that we will be adding in
subsequent commits as we implement the desired checks.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 255 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 255 insertions(+)
 create mode 100755 t/t2501-cwd-empty.sh

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
new file mode 100755
index 00000000000..5dfb456a691
--- /dev/null
+++ b/t/t2501-cwd-empty.sh
@@ -0,0 +1,255 @@
+#!/bin/sh
+
+test_description='Test handling of the current working directory becoming empty'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit init &&
+	mkdir subdir &&
+	test_commit subdir/file &&
+
+	git branch fd_conflict &&
+
+	mkdir -p foo/bar &&
+	test_commit foo/bar/baz &&
+
+	git revert HEAD &&
+	git tag reverted &&
+
+	git checkout fd_conflict &&
+	git rm subdir/file.t &&
+	echo not-a-directory >dirORfile &&
+	git add dirORfile &&
+	git commit -m dirORfile
+'
+
+test_expect_failure 'checkout does not clean cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_path_is_dir foo/bar &&
+
+	(
+		cd foo &&
+		git checkout init &&
+		cd ..
+	) &&
+	test_path_is_missing foo/bar/baz &&
+	test_path_is_missing foo/bar &&
+	test_path_is_dir foo
+'
+
+test_expect_failure 'checkout fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+
+		test_must_fail git checkout fd_conflict 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'reset --hard does not clean cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_path_is_dir foo/bar &&
+
+	(
+		cd foo &&
+		git reset --hard init &&
+		cd ..
+	) &&
+	test_path_is_missing foo/bar/baz &&
+	test_path_is_missing foo/bar &&
+	test_path_is_dir foo
+'
+
+test_expect_failure 'reset --hard fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+
+		test_must_fail git reset --hard fd_conflict 2>../error &&
+		grep "Refusing to remove.*the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'merge does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	(
+		cd subdir &&
+		git merge fd_conflict
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'merge fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+		test_must_fail git merge fd_conflict 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'cherry-pick does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	(
+		cd subdir &&
+		git cherry-pick fd_conflict
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'cherry-pick fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+		test_must_fail git cherry-pick fd_conflict 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'rebase does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	(
+		cd subdir &&
+		git rebase foo/bar/baz fd_conflict
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'rebase fails if cwd needs to be removed' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+		test_must_fail git rebase foo/bar/baz fd_conflict 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'revert does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	(
+		cd subdir &&
+		git revert subdir/file
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'revert fails if cwd needs to be removed' '
+	git checkout fd_conflict &&
+	git revert HEAD &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+		test_must_fail git revert HEAD 2>../error &&
+		grep "Refusing to remove the current working directory" ../error
+	) &&
+
+	test_path_is_dir dirORfile
+'
+
+test_expect_failure 'rm does not remove cwd incidentally' '
+	test_when_finished "git reset --hard" &&
+	git checkout foo/bar/baz &&
+
+	(
+		cd foo &&
+		git rm bar/baz.t
+	) &&
+
+	test_path_is_missing foo/bar/baz &&
+	test_path_is_missing foo/bar &&
+	test_path_is_dir foo
+'
+
+test_expect_failure 'apply does not remove cwd incidentally' '
+	test_when_finished "git reset --hard" &&
+	git checkout foo/bar/baz &&
+
+	(
+		cd subdir &&
+		git diff subdir/file init | git apply
+	) &&
+
+	test_path_is_missing subdir/file.t &&
+	test_path_is_dir subdir
+'
+
+test_expect_failure 'clean does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir empty &&
+	mkdir untracked &&
+	>untracked/random &&
+	(
+		cd untracked &&
+		git clean -fd -e warnings :/ >../warnings &&
+		grep "Refusing to remove current working directory" ../warnings
+	) &&
+
+	test_path_is_missing empty &&
+	test_path_is_missing untracked/random &&
+	test_path_is_dir untracked
+'
+
+test_expect_failure 'stash does not remove cwd incidentally' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir untracked &&
+	>untracked/random &&
+	(
+		cd untracked &&
+		git stash --include-untracked &&
+		git status
+	) &&
+
+	test_path_is_missing untracked/random &&
+	test_path_is_dir untracked
+'
+
+test_done
-- 
gitgitgadget

