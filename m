Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F84BC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834016124F
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347250AbhIXPlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347139AbhIXPkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BFC061762
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r23so3403501wra.6
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=532IdcFlp9qd27qq2wqz0WCGxlV3AiMKH+CnhnbNt4Q=;
        b=GlWuasQbdZmmajy/4Ttft7MwDy9lysh74xyKpld+ZOd40s1RN0f2ud84xX66T/yObN
         eaDg8fSax/5wZwcNJrlW0WcrjdjgIODtd8ZLf6SJMzypv3nYLHxAOI7G9Wb6T+i8SsiJ
         Ab2wkNcD/SND3DfPxxyliR3Kd/yX60wt81QfWSSmIFmIpy1L14GnskJFM9DQJNcyEvS8
         15t8YdScrZjHlKYMTnb04yUZ+qwbt+/YgDlqRjo9IBPno7NBakMtLzEUfFb5Z/s8vWIA
         Shne0xqooEkw+hS3DCh2CM0kh8U9HQ/J24VbQQz+se+RQ8VL7n5qeQPg8Tx6zXwRdnk+
         St/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=532IdcFlp9qd27qq2wqz0WCGxlV3AiMKH+CnhnbNt4Q=;
        b=tN83hXX21LEd9YNr9QdGFvr0t52Zfj+GXyS1ZuyCFpPtSzkSz8yiHcQMAqac4oMqyj
         OHSs56wRbSfYLRgLHsTiFFO7bLF+S58vD+XIlM4tA+bIBjYBppDqLOsV+wj5uj4CxofP
         6lkCrAe0tIdpaQF9P56NyTKZMN07FmBmZC51JX/yaAB+B9aLMDDptWC8IXtnjY4vDlUJ
         0t6B34WYndwfRAa+d8uJOYvzCeN+nYepNtuZYo4ouTqHehD/RyzajQ69rSmy6M5GW1oi
         yNMxBiuWULdRudqZoggxQieTY4dmIX4BIYcOSctpSKNQr3C6YzYT9F7sqmQXuGZu1F2N
         k3Bw==
X-Gm-Message-State: AOAM53103a1e8pUeJMxHsJXAVaZ2CK2GB5W4gZWM5Wv3f14sr4cMcvZ3
        GlgJxLGyWpktirnHf7hPKi7kwn0LJfk=
X-Google-Smtp-Source: ABdhPJyOJEh+GWKYMRbu9glbxfKpC5r1QfYrmPPCPrFWA4PYEkpKCEadYI4+FBg4k+qU9uvIExx5/w==
X-Received: by 2002:a1c:1d86:: with SMTP id d128mr2820906wmd.142.1632497959131;
        Fri, 24 Sep 2021 08:39:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm8522672wrt.28.2021.09.24.08.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:18 -0700 (PDT)
Message-Id: <2c5c834bc9fb42aeaff7befbba477aec727184c0.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:07 +0000
Subject: [PATCH v4 06/13] add: skip tracked paths outside sparse-checkout cone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When 'git add' adds a tracked file that is outside of the
sparse-checkout cone, it checks the SKIP_WORKTREE bit to see if the file
exists outside of the sparse-checkout cone. This is usually correct,
except in the case of a merge conflict outside of the cone.

Modify add_pathspec_matched_against_index() to be more careful about
paths by checking the sparse-checkout patterns in addition to the
SKIP_WORKTREE bit. This causes 'git add' to no longer allow files
outside of the cone that removed the SKIP_WORKTREE bit due to a merge
conflict.

With only this change, users will only be able to add the file after
adding the file to the sparse-checkout cone. A later change will allow
users to force adding even though the file is outside of the
sparse-checkout cone.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            |  4 ++++
 pathspec.c                               |  5 +++--
 t/t1091-sparse-checkout-builtin.sh       |  4 +++-
 t/t1092-sparse-checkout-compatibility.sh | 19 ++++++++++++-------
 t/t3705-add-sparse-checkout.sh           | 12 ++++++++++++
 5 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8ea9cae0e7a..09c3fad6321 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -94,6 +94,10 @@ static void update_callback(struct diff_queue_struct *q,
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
+
+		if (!path_in_sparse_checkout(path, &the_index))
+			continue;
+
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
diff --git a/pathspec.c b/pathspec.c
index 44306fdaca2..ddeeba79114 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -39,7 +39,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 		return;
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
+		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
+		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
 			continue;
 		ce_path_match(istate, ce, pathspec, seen);
 	}
@@ -70,7 +71,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		if (ce_skip_worktree(ce))
+		if (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate))
 		    ce_path_match(istate, ce, pathspec, seen);
 	}
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 71236981e64..af99ae81b1d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -406,7 +406,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	git -C unmerged sparse-checkout disable
 '
 
-test_expect_success 'sparse-checkout reapply' '
+test_expect_failure 'sparse-checkout reapply' '
 	git clone repo tweak &&
 
 	echo dirty >tweak/deep/deeper2/a &&
@@ -438,6 +438,8 @@ test_expect_success 'sparse-checkout reapply' '
 	test_i18ngrep "warning.*The following paths are unmerged" err &&
 	test_path_is_file tweak/folder1/a &&
 
+	# NEEDSWORK: We are asking to update a file outside of the
+	# sparse-checkout cone, but this is no longer allowed.
 	git -C tweak add folder1/a &&
 	git -C tweak sparse-checkout reapply 2>err &&
 	test_must_be_empty err &&
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 17525ff13fc..062b42f2c10 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -546,10 +546,9 @@ test_expect_failure 'merge with conflict outside cone' '
 	test_all_match git status --porcelain=v2 &&
 
 	# 2. Add the file with conflict markers
-	# NEEDSWORK: Even though the merge conflict removed the
-	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
-	# warn that this is a problematic add.
-	test_all_match git add folder1/a &&
+	test_sparse_match test_must_fail git add folder1/a &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
 	# 3. Rename the file to another sparse filename and
@@ -558,7 +557,9 @@ test_expect_failure 'merge with conflict outside cone' '
 	# NEEDSWORK: This mode now fails, because folder2/z is
 	# outside of the sparse-checkout cone and does not match an
 	# existing index entry with the SKIP_WORKTREE bit cleared.
-	test_all_match git add folder2 &&
+	test_sparse_match test_must_fail git add folder2 &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder2/z &&
 	test_all_match git status --porcelain=v2 &&
 
 	test_all_match git merge --continue &&
@@ -586,7 +587,9 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		# NEEDSWORK: Even though the merge conflict removed the
 		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
 		# warn that this is a problematic add.
-		test_all_match git add folder1/a &&
+		test_sparse_match test_must_fail git add folder1/a &&
+		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+		test_sparse_unstaged folder1/a &&
 		test_all_match git status --porcelain=v2 &&
 
 		# 3. Rename the file to another sparse filename and
@@ -595,7 +598,9 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		# outside of the sparse-checkout cone and does not match an
 		# existing index entry with the SKIP_WORKTREE bit cleared.
 		run_on_all mv folder2/a folder2/z &&
-		test_all_match git add folder2 &&
+		test_sparse_match test_must_fail git add folder2 &&
+		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+		test_sparse_unstaged folder2/z &&
 		test_all_match git status --porcelain=v2 &&
 
 		test_all_match git $OPERATION --continue &&
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index b2d798662ee..be6809eed23 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -158,6 +158,18 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
 	git ls-files --error-unmatch dense_entry
 '
 
+test_expect_success 'git add fails outside of sparse-checkout definition' '
+	test_when_finished git sparse-checkout disable &&
+	test_commit a &&
+	git sparse-checkout init &&
+	git sparse-checkout set a &&
+	echo >>sparse_entry &&
+
+	git update-index --no-skip-worktree sparse_entry &&
+	test_must_fail git add sparse_entry &&
+	test_sparse_entry_unstaged
+'
+
 test_expect_success 'add obeys advice.updateSparsePath' '
 	setup_sparse_entry &&
 	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
-- 
gitgitgadget

