Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EDAC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiGLNHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGLNHM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA673B4BD2
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so5178400wma.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B2UUSkn8ScIFAe2WU+SPqQszPoZhEEitNoSzZ6/SYFg=;
        b=MmIvAlYsGbE5o2HWWSVsSpILrra1q+bVzO90inbqf0e3luVYilOlo4bcAoEHh08XZN
         AYMgRf3G7GhrNUHSSSzwCIL7UCTvfP1TK7eFnxR/zIKINxf1cXCpBYZZRG1GrDAnBDid
         WHeT/14UKtjaAL0FQzdTSFcyW19K9w1Dc1FKswpimeRnfwF/pZ18GjBjAgjhrBFs+4NU
         Aruzf22xRbTXl5w+OFvx0TxG0ZRi5WQAZQKKHiG9q6iiiMr4WENwO5TdXslitAQ6wpwu
         wDfunlY5dwTa7AbcO9lzXvX1id738XpxjgBXNnv97GRHya5pJrrbMywhyCVYgocWRzGF
         /51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B2UUSkn8ScIFAe2WU+SPqQszPoZhEEitNoSzZ6/SYFg=;
        b=6wharE3f1uGSPj4NJYHsodKjn6c8HjEaFr/YES/1yDEKHkL8VEgcg3PhuzPB2jp737
         9dlZIQgYsym82eGtXROL7989gks0jgAiS5/49YWWNw62bGCe9nBGkhkSN3rfJQzMU43w
         O32ZhOl4OBiQxxL6zrqjxtrZSydS77KghrnwRcxgP8dS0KTqEUAe+ihHUE5s85BUMxHR
         /wm3mrk3uQJGbB295kpOGs9WwLqzU1ENkIsRtizM2r1XIYJVuFT/IpWu9H1RBZ5SJ+km
         i09I8C+qDERasq14ThXWkG31VRlFHGaWUkluXL4W4tFHcNVBOjH1jvUaArRMO8istbnC
         4PDQ==
X-Gm-Message-State: AJIora9HUjkleSyNxrekVVWAyK3+vLejxBPoBs3qknaU5cfVqrl2wQQA
        En43qSN5rYyAiMpRM6BUDFBxN99FhCA=
X-Google-Smtp-Source: AGRyM1ug4IKWAUGndOLKJ/iIXg/HE3mmTiOlHfnJp0b01DEG+DR2VjR8K4ZwzerGsKGCAyZ30Or1rg==
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id d9-20020a05600c34c900b003a050729abemr3722538wmq.8.1657631229932;
        Tue, 12 Jul 2022 06:07:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b003a2cf1ba9e2sm9865084wmb.6.2022.07.12.06.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:08 -0700 (PDT)
Message-Id: <9e53a27017ac18eefef2c077a905efecab07861d.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:06:54 +0000
Subject: [PATCH v4 01/12] t2407: test bisect and rebase as black-boxes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The tests added by d2ba271aad0 (branch: check for bisects and rebases,
2022-06-14) modified hidden state to verify the branch_checked_out()
helper. While this indeed checks that the method implementation is _as
designed_, it doesn't show that it is _correct_. Specifically, if 'git
bisect' or 'git rebase' change their back-end for preserving refs, then
these tests do not demonstrate that drift as a bug in
branch_checked_out().

Modify the tests in t2407 to actually rely on a paused bisect or rebase.
This requires adding the !SANITIZE_LEAK prereq for tests using those
builtins. The logic is still tested for leaks in the final test which
does set up that back-end directly for an error state that should not be
possible using Git commands.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t2407-worktree-heads.sh | 57 +++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index b6be42f74a2..100ab286d5c 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -7,13 +7,18 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 test_expect_success 'setup' '
 	test_commit init &&
-	git branch -f fake-1 &&
-	git branch -f fake-2 &&
 
 	for i in 1 2 3 4
 	do
+		git checkout -b conflict-$i &&
+		echo "not I" >$i.t &&
+		git add $i.t &&
+		git commit -m "will conflict" &&
+
+		git checkout - &&
 		test_commit $i &&
 		git branch wt-$i &&
+		git branch fake-$i &&
 		git worktree add wt-$i wt-$i || return 1
 	done &&
 
@@ -44,26 +49,26 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	done
 '
 
-test_expect_success 'refuse to overwrite: worktree in bisect' '
-	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
+	test_when_finished git -C wt-4 bisect reset &&
 
-	touch .git/worktrees/wt-4/BISECT_LOG &&
-	echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
+	# Set up a bisect so HEAD no longer points to wt-4.
+	git -C wt-4 bisect start &&
+	git -C wt-4 bisect bad wt-4 &&
+	git -C wt-4 bisect good wt-1 &&
 
-	test_must_fail git branch -f fake-2 HEAD 2>err &&
-	grep "cannot force update the branch '\''fake-2'\'' checked out at.*wt-4" err
+	test_must_fail git branch -f wt-4 HEAD 2>err &&
+	grep "cannot force update the branch '\''wt-4'\'' checked out at.*wt-4" err
 '
 
-test_expect_success 'refuse to overwrite: worktree in rebase' '
-	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase' '
+	test_when_finished git -C wt-2 rebase --abort &&
 
-	mkdir -p .git/worktrees/wt-3/rebase-merge &&
-	touch .git/worktrees/wt-3/rebase-merge/interactive &&
-	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-merge/head-name &&
-	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-merge/onto &&
+	# This will fail part-way through due to a conflict.
+	test_must_fail git -C wt-2 rebase conflict-2 &&
 
-	test_must_fail git branch -f fake-1 HEAD 2>err &&
-	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
+	test_must_fail git branch -f wt-2 HEAD 2>err &&
+	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
@@ -77,24 +82,24 @@ test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in bisect' '
-	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
+	test_when_finished git -C wt-4 bisect reset &&
 
-	touch .git/worktrees/wt-4/BISECT_LOG &&
-	echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
+	# Set up a bisect so HEAD no longer points to wt-4.
+	git -C wt-4 bisect start &&
+	git -C wt-4 bisect bad wt-4 &&
+	git -C wt-4 bisect good wt-1 &&
 
-	test_must_fail git fetch server +refs/heads/fake-2:refs/heads/fake-2 2>err &&
+	test_must_fail git fetch server +refs/heads/wt-4:refs/heads/wt-4 2>err &&
 	grep "refusing to fetch into branch" err
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in rebase' '
-	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
+	test_when_finished git -C wt-3 rebase --abort &&
 
-	mkdir -p .git/worktrees/wt-4/rebase-merge &&
-	touch .git/worktrees/wt-4/rebase-merge/interactive &&
-	echo refs/heads/fake-1 >.git/worktrees/wt-4/rebase-merge/head-name &&
-	echo refs/heads/fake-2 >.git/worktrees/wt-4/rebase-merge/onto &&
+	# This will fail part-way through due to a conflict.
+	test_must_fail git -C wt-3 rebase conflict-3 &&
 
-	test_must_fail git fetch server +refs/heads/fake-1:refs/heads/fake-1 2>err &&
+	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
 	grep "refusing to fetch into branch" err
 '
 
-- 
gitgitgadget

