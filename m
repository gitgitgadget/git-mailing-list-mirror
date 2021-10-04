Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC59C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE2D60F9C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhJDBNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhJDBNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:13:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C5C061780
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so11120683wra.12
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vDgAb/pbxKTQjzPx5caxkUI2+Wq7EcLF6LSJOfzTZrQ=;
        b=NXBmQASEA3AbC4hguQ5xJSVk3aP5mAnZmmvYRUAE+9UPHgLqYzs7aPGTnYs1Vwgiru
         Ow/veWRGuGc4HELMUL5I960WMqpDJygO5QYZBiSd19d3kfuqLzDZUMXhWKBHGaR2dQcp
         54mHU0GlrbvW7ggvxgYBvo/eMLSYWgJYpALcNFGLwvcTzFFCPbMvr/BXjGZb3JQgvv5S
         CIApibb/90anHiL+kU2+sK1Q1Qsnm3zOzXJr9CkM4MAi/7RAVXawuScR6V2+J4eaAB2X
         p1VYqtTw1+BhC5ueB1XwZ2V4Q89I3iqs7TNcJr9tdfpWeeXuTeO4c4R/IC4KHQUhO4Qq
         A0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDgAb/pbxKTQjzPx5caxkUI2+Wq7EcLF6LSJOfzTZrQ=;
        b=2/YGdd7d3CQ+ncbXhgoxU+EJ2ERzvbq8r4aP1WpDs1swDBqjAC2Nun9lDbY40Eucu4
         /qobymqPXGD/8jMB751dOj6pAS8Qp1I4cX+dX9mJkA+nmCTrMgLCdPOKW9kMN9aDhOIb
         //zOnbgdUNhS1lGkkiT3F1MvE+sfAJWrJcJ5lqPjlhOKs7m6s5VdSZBDW0Fe48l42i+R
         CTDgXDBnN88eqe4F5ydlxcIRUVg100OYpmE3nsk8RTCKfCNdDdVDZbGXMhOjntgFZ/xJ
         DTrk4nt+oRHdie60T64tS+UX3VZLf4mxoQXUh5DVeXOUK3/lXlrxdVn0ivJAcqjEx3FI
         s1Lw==
X-Gm-Message-State: AOAM5318O4gjB6sA5LVolpQFx9EoTYZ/f+IX8rdkqb63v4QXh+urRhy4
        +rcGcm/W7rLdCrouJ4l92/PBbNJChBbYag==
X-Google-Smtp-Source: ABdhPJwpzcS5kAtqi57KVeTEnC0ojVXK+LkBaSBMKSrCuxTojHaYWeLHcCzT2bJiXiQWJun/219oDA==
X-Received: by 2002:adf:ef10:: with SMTP id e16mr10746567wro.46.1633309922772;
        Sun, 03 Oct 2021 18:12:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 01/10] t2500: add various tests for nuking untracked files
Date:   Mon,  4 Oct 2021 03:11:50 +0200
Message-Id: <RFC-patch-v4-01.10-3a3203beee6-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
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
2.33.0.1404.g83021034c5d

