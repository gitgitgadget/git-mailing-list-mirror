Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6DC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297E3610E8
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhI0Qfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhI0Qfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A870C061714
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r23so27666814wra.6
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2ME/dZ4fzArIJqmFKq/Lz334GlShsg34B/tWiC3aR9w=;
        b=fvXENtXaRSB0nbwwrKZPZyviConFeRfaidyrkOsYUVZOk2SlswUgZZQ3uiTQHHzAGb
         s7u3+o//pEXWH9yVtjAHRH+sbEsu8o3coj7YQkCGnpQ0lwl9K74eu1f8/HJiDNuMcVfB
         CdWtTWiWIJ3wcgEmqjdLRhqrX6nrBRemTxmojoKf7aXs7DkmrJx/Hn80dFSbHJDHd1bI
         EcK1Cwwtr+bwTuWLlZ02fxh6/Hypd+ux6uMZEMtcFnZyXT1+hzUBDqTp21XCOsooZV+t
         76q+g++4SKOAzjg37qkRf3cGkl8JdTgu21Rp719UXtDPw6uSG04rSDpobP2fSaI1s0Lm
         CUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2ME/dZ4fzArIJqmFKq/Lz334GlShsg34B/tWiC3aR9w=;
        b=FarJn3z74fHuIhbl9tfJ+VQkhLCivfys3Lpv6SELXrMfBZznjzaM+X8iAVN/3kcxRr
         3jSnJziydavFJFSPw9iTrNZe9kVIfMB+9HYZxJbOHiR/tCMOhpne28B0VEiE0Xi9qmsp
         mDYejvT/TpJ2AzkqofTnONKXbSwe5Hlqx8ZwOwuni6O3X5gnm6NHu0P4sYl6zONJLons
         GuhPUz5dEwPapnliF2/S6dEAbZiPZ95K+9qyZgOMue5CeJdNnMYf2PhvRkShLW6Zv6mN
         Q6cyd9jNxUm4HAmDlGp6YW8b2v8oCPucU3OcQhYlTPotpsWxko6gv6TeWr1xTEVXAZqV
         WNsQ==
X-Gm-Message-State: AOAM530LOdatcbaSfZ0QrZz0qTWW1XGngN9Ea9cSy9uUeZ166aoAfTfK
        FIcp2aT+XSLfjZlyHR0S5RjP+5raXDE=
X-Google-Smtp-Source: ABdhPJze+isU98dey4uj0YTQH5jxwd/TanpBKB19zhaAQN/a/IolEdraoJRwnVPvknD3RUvi8tIqxw==
X-Received: by 2002:a05:6000:1809:: with SMTP id m9mr952720wrh.396.1632760430218;
        Mon, 27 Sep 2021 09:33:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm4066wmp.26.2021.09.27.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:49 -0700 (PDT)
Message-Id: <66270ffc74ecf4f2ce0ebc7379be84d5470c82ef.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:38 +0000
Subject: [PATCH v3 01/11] t2500: add various tests for nuking untracked files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Noting that unpack_trees treats reset=1 & update=1 as license to nuke
untracked files, I looked for code paths that use this combination and
tried to generate testcases which demonstrated unintentional loss of
untracked files and directories.  I found several.

I also include testcases for `git reset --{hard,merge,keep}`.  A hard
reset is perhaps the most direct test of unpack_tree's reset=1 behavior,
but we cannot make `git reset --hard` preserve untracked files without
some migration work.

Also, the two commands `checkout --force` (because of the --force) and
`read-tree --reset` (because it's plumbing and we need to keep it
backward compatible) were left out as we expect those to continue
removing untracked files and directories.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2500-untracked-overwriting.sh | 244 +++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100755 t/t2500-untracked-overwriting.sh

diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
new file mode 100755
index 00000000000..2412d121ea8
--- /dev/null
+++ b/t/t2500-untracked-overwriting.sh
@@ -0,0 +1,244 @@
+#!/bin/sh
+
+test_description='Test handling of overwriting untracked files'
+
+. ./test-lib.sh
+
+test_setup_reset () {
+	git init reset_$1 &&
+	(
+		cd reset_$1 &&
+		test_commit init &&
+
+		git branch stable &&
+		git branch work &&
+
+		git checkout work &&
+		test_commit foo &&
+
+		git checkout stable
+	)
+}
+
+test_expect_success 'reset --hard will nuke untracked files/dirs' '
+	test_setup_reset hard &&
+	(
+		cd reset_hard &&
+		git ls-tree -r stable &&
+		git log --all --name-status --oneline &&
+		git ls-tree -r work &&
+
+		mkdir foo.t &&
+		echo precious >foo.t/file &&
+		echo foo >expect &&
+
+		git reset --hard work &&
+
+		# check that untracked directory foo.t/ was nuked
+		test_path_is_file foo.t &&
+		test_cmp expect foo.t
+	)
+'
+
+test_expect_success 'reset --merge will preserve untracked files/dirs' '
+	test_setup_reset merge &&
+	(
+		cd reset_merge &&
+
+		mkdir foo.t &&
+		echo precious >foo.t/file &&
+		cp foo.t/file expect &&
+
+		test_must_fail git reset --merge work 2>error &&
+		test_cmp expect foo.t/file &&
+		grep "Updating .foo.t. would lose untracked files" error
+	)
+'
+
+test_expect_success 'reset --keep will preserve untracked files/dirs' '
+	test_setup_reset keep &&
+	(
+		cd reset_keep &&
+
+		mkdir foo.t &&
+		echo precious >foo.t/file &&
+		cp foo.t/file expect &&
+
+		test_must_fail git reset --merge work 2>error &&
+		test_cmp expect foo.t/file &&
+		grep "Updating.*foo.t.*would lose untracked files" error
+	)
+'
+
+test_setup_checkout_m () {
+	git init checkout &&
+	(
+		cd checkout &&
+		test_commit init &&
+
+		test_write_lines file has some >filler &&
+		git add filler &&
+		git commit -m filler &&
+
+		git branch stable &&
+
+		git switch -c work &&
+		echo stuff >notes.txt &&
+		test_write_lines file has some words >filler &&
+		git add notes.txt filler &&
+		git commit -m filler &&
+
+		git checkout stable
+	)
+}
+
+test_expect_failure 'checkout -m does not nuke untracked file' '
+	test_setup_checkout_m &&
+	(
+		cd checkout &&
+
+		# Tweak filler
+		test_write_lines this file has some >filler &&
+		# Make an untracked file, save its contents in "expect"
+		echo precious >notes.txt &&
+		cp notes.txt expect &&
+
+		test_must_fail git checkout -m work &&
+		test_cmp expect notes.txt
+	)
+'
+
+test_setup_sequencing () {
+	git init sequencing_$1 &&
+	(
+		cd sequencing_$1 &&
+		test_commit init &&
+
+		test_write_lines this file has some words >filler &&
+		git add filler &&
+		git commit -m filler &&
+
+		mkdir -p foo/bar &&
+		test_commit foo/bar/baz &&
+
+		git branch simple &&
+		git branch fooey &&
+
+		git checkout fooey &&
+		git rm foo/bar/baz.t &&
+		echo stuff >>filler &&
+		git add -u &&
+		git commit -m "changes" &&
+
+		git checkout simple &&
+		echo items >>filler &&
+		echo newstuff >>newfile &&
+		git add filler newfile &&
+		git commit -m another
+	)
+}
+
+test_expect_failure 'git rebase --abort and untracked files' '
+	test_setup_sequencing rebase_abort_and_untracked &&
+	(
+		cd sequencing_rebase_abort_and_untracked &&
+		git checkout fooey &&
+		test_must_fail git rebase simple &&
+
+		cat init.t &&
+		git rm init.t &&
+		echo precious >init.t &&
+		cp init.t expect &&
+		git status --porcelain &&
+		test_must_fail git rebase --abort &&
+		test_cmp expect init.t
+	)
+'
+
+test_expect_failure 'git rebase fast forwarding and untracked files' '
+	test_setup_sequencing rebase_fast_forward_and_untracked &&
+	(
+		cd sequencing_rebase_fast_forward_and_untracked &&
+		git checkout init &&
+		echo precious >filler &&
+		cp filler expect &&
+		test_must_fail git rebase init simple &&
+		test_cmp expect filler
+	)
+'
+
+test_expect_failure 'git rebase --autostash and untracked files' '
+	test_setup_sequencing rebase_autostash_and_untracked &&
+	(
+		cd sequencing_rebase_autostash_and_untracked &&
+		git checkout simple &&
+		git rm filler &&
+		mkdir filler &&
+		echo precious >filler/file &&
+		cp filler/file expect &&
+		git rebase --autostash init &&
+		test_path_is_file filler/file
+	)
+'
+
+test_expect_failure 'git stash and untracked files' '
+	test_setup_sequencing stash_and_untracked_files &&
+	(
+		cd sequencing_stash_and_untracked_files &&
+		git checkout simple &&
+		git rm filler &&
+		mkdir filler &&
+		echo precious >filler/file &&
+		cp filler/file expect &&
+		git status --porcelain &&
+		git stash push &&
+		git status --porcelain &&
+		test_path_is_file filler/file
+	)
+'
+
+test_expect_failure 'git am --abort and untracked dir vs. unmerged file' '
+	test_setup_sequencing am_abort_and_untracked &&
+	(
+		cd sequencing_am_abort_and_untracked &&
+		git format-patch -1 --stdout fooey >changes.mbox &&
+		test_must_fail git am --3way changes.mbox &&
+
+		# Delete the conflicted file; we will stage and commit it later
+		rm filler &&
+
+		# Put an unrelated untracked directory there
+		mkdir filler &&
+		echo foo >filler/file1 &&
+		echo bar >filler/file2 &&
+
+		test_must_fail git am --abort 2>errors &&
+		test_path_is_dir filler &&
+		grep "Updating .filler. would lose untracked files in it" errors
+	)
+'
+
+test_expect_failure 'git am --skip and untracked dir vs deleted file' '
+	test_setup_sequencing am_skip_and_untracked &&
+	(
+		cd sequencing_am_skip_and_untracked &&
+		git checkout fooey &&
+		git format-patch -1 --stdout simple >changes.mbox &&
+		test_must_fail git am --3way changes.mbox &&
+
+		# Delete newfile
+		rm newfile &&
+
+		# Put an unrelated untracked directory there
+		mkdir newfile &&
+		echo foo >newfile/file1 &&
+		echo bar >newfile/file2 &&
+
+		# Change our mind about resolutions, just skip this patch
+		test_must_fail git am --skip 2>errors &&
+		test_path_is_dir newfile &&
+		grep "Updating .newfile. would lose untracked files in it" errors
+	)
+'
+
+test_done
-- 
gitgitgadget

