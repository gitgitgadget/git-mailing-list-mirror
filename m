Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CD3C433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BC260EE9
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347244AbhIXPlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347127AbhIXPkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F078DC061760
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w29so28657280wra.8
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AzidAS6MbWAOoKEfuahayUmddDa6ZB/n3FslfgwPM8U=;
        b=cuTPzerP/Ddqij2m5tqJfA5RpqUKKzPJdRSyQ/a4nBnLnNi9l+JY0PplNynoGaF226
         AYgT/scw44fi0p6ptqQt6ek2FJGLPXc8/kIL/1rsPjSpZ8SWT5KwQzE/aPeGF1BwHvaJ
         Uljxf0G4EUcAZgdpVlgjjNQD5gQwTUd8Wm1ffpWXsN/SauxBjXyVgQTMLHROXZjJw17H
         SMXBIVGzPMrP4YHub0bCLQOHTiupRsPzsBXCkHNLWiM9ulLJ/CP3ilXCzhI8Ra+og76M
         szShF+nnYIc2WkW9d56FhH4vH6Gu2J2gC+eX1f0dWzScha49mwY0xulOHavKXYR7m0FM
         Z14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AzidAS6MbWAOoKEfuahayUmddDa6ZB/n3FslfgwPM8U=;
        b=VsMOtFUw4DajTM7g1k/yZF8UPRj5InY4oVMgeIsDOyMHTVZBji3AcLOk114fo3JhLX
         OPDQkOnHkMFH8Ua2nsn2cwQ4OPyWtkuW1oOGKaSMR6f4RhKNpzouPeGvNAIaMnyn9HJg
         lEjVXQzVpptDi1if1u/lnCKc0fVvUu7lhfDuNHF2++gC6CHV9umCIVwT3Z1t0KiIgwCh
         e8PCxxziO5kxFCP574RLNrG/hjk2kg9E96/eQfGabXap7kBZc0Qi/99kvt0/PSRBlGXp
         J7VfaYvRZWM97hQl46a3o/91Y9xLdU03Z1SK+mSUWqKUNsVps559ZQHHDb+DgZtGPI3C
         7kyw==
X-Gm-Message-State: AOAM531HXv3UsgON9LMtEzLU3smHEaMbClGN1NwtS5ZY49SF7/velHxl
        t7AZfG9REbzmagtp9dBBhzEG6EUxllc=
X-Google-Smtp-Source: ABdhPJxMrsRLUv86jIcdVzgG6pZXg0oIFdze5kGAker6ENUM/d+mNRICehRcxPucRMMMW78XeRSs0Q==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr11955025wru.336.1632497958560;
        Fri, 24 Sep 2021 08:39:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm6714843wro.62.2021.09.24.08.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:18 -0700 (PDT)
Message-Id: <e3a749e3182b07f2b219ff40f16e38868d0ba283.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:06 +0000
Subject: [PATCH v4 05/13] add: fail when adding an untracked sparse file
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

The add_files() method in builtin/add.c takes a set of untracked files
that are being added by the input pathspec and inserts them into the
index. If these files are outside of the sparse-checkout cone, then they
gain the SKIP_WORKTREE bit at some point. However, this was not checked
before inserting into the index, so these files are added even though we
want to avoid modifying the index outside of the sparse-checkout cone.

Add a check within add_files() for these files and write the advice
about files outside of the sparse-checkout cone.

This behavior change modifies some existing tests within t1092. These
tests intended to document how a user could interact with the existing
behavior in place. Many of these tests need to be marked as expecting
failure. A future change will allow these tests to pass by adding a flag
to 'git add' that allows users to modify index entries outside of the
sparse-checkout cone.

The 'submodule handling' test is intended to document what happens to
directories that contain a submodule when the sparse index is enabled.
It is not trying to say that users should be able to add submodules
outside of the sparse-checkout cone, so that test can be modified to
avoid that operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            | 14 +++++++++
 t/t1092-sparse-checkout-compatibility.sh | 37 ++++++++++++++++++------
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 88a6c0c69fb..8ea9cae0e7a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -443,6 +443,7 @@ static void check_embedded_repo(const char *path)
 static int add_files(struct dir_struct *dir, int flags)
 {
 	int i, exit_status = 0;
+	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
 
 	if (dir->ignored_nr) {
 		fprintf(stderr, _(ignore_error));
@@ -456,6 +457,11 @@ static int add_files(struct dir_struct *dir, int flags)
 	}
 
 	for (i = 0; i < dir->nr; i++) {
+		if (!path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
+			string_list_append(&matched_sparse_paths,
+					   dir->entries[i]->name);
+			continue;
+		}
 		if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
@@ -464,6 +470,14 @@ static int add_files(struct dir_struct *dir, int flags)
 			check_embedded_repo(dir->entries[i]->name);
 		}
 	}
+
+	if (matched_sparse_paths.nr) {
+		advise_on_updating_sparse_paths(&matched_sparse_paths);
+		exit_status = 1;
+	}
+
+	string_list_clear(&matched_sparse_paths, 0);
+
 	return exit_status;
 }
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 7edc2060221..17525ff13fc 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -301,8 +301,6 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
-# NEEDSWORK: This documents current behavior, but is not a desirable
-# behavior (untracked files are handled differently than tracked).
 test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
@@ -312,7 +310,9 @@ test_expect_success 'add outside sparse cone' '
 	test_sparse_match test_must_fail git add folder1/a &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
-	test_sparse_match git add folder1/newfile
+	test_sparse_match test_must_fail git add folder1/newfile &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/newfile
 '
 
 test_expect_success 'commit including unstaged changes' '
@@ -343,7 +343,11 @@ test_expect_success 'commit including unstaged changes' '
 	test_all_match git status --porcelain=v2
 '
 
-test_expect_success 'status/add: outside sparse cone' '
+# NEEDSWORK: Now that 'git add folder1/new' fails, the changes being
+# attempted here fail for the sparse-checkout and sparse-index repos.
+# We must enable a way for adding files outside the sparse-checkout
+# done, even if it is by an optional flag.
+test_expect_failure 'status/add: outside sparse cone' '
 	init_repos &&
 
 	# folder1 is at HEAD, but outside the sparse cone
@@ -368,10 +372,11 @@ test_expect_success 'status/add: outside sparse cone' '
 	test_sparse_match test_must_fail git add --refresh folder1/a &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
+	test_sparse_match test_must_fail git add folder1/new &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/new &&
 
-	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
-	test_sparse_match git add folder1/new &&
-
+	# NEEDSWORK: behavior begins to deviate here.
 	test_all_match git add . &&
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git commit -m folder1/new &&
@@ -527,7 +532,7 @@ test_expect_success 'merge, cherry-pick, and rebase' '
 # Right now, users might be using this flow to work through conflicts,
 # so any solution should present advice to users who try this sequence
 # of commands to follow whatever new method we create.
-test_expect_success 'merge with conflict outside cone' '
+test_expect_failure 'merge with conflict outside cone' '
 	init_repos &&
 
 	test_all_match git checkout -b merge-tip merge-left &&
@@ -541,12 +546,18 @@ test_expect_success 'merge with conflict outside cone' '
 	test_all_match git status --porcelain=v2 &&
 
 	# 2. Add the file with conflict markers
+	# NEEDSWORK: Even though the merge conflict removed the
+	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
+	# warn that this is a problematic add.
 	test_all_match git add folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
 	# 3. Rename the file to another sparse filename and
 	#    accept conflict markers as resolved content.
 	run_on_all mv folder2/a folder2/z &&
+	# NEEDSWORK: This mode now fails, because folder2/z is
+	# outside of the sparse-checkout cone and does not match an
+	# existing index entry with the SKIP_WORKTREE bit cleared.
 	test_all_match git add folder2 &&
 	test_all_match git status --porcelain=v2 &&
 
@@ -555,7 +566,7 @@ test_expect_success 'merge with conflict outside cone' '
 	test_all_match git rev-parse HEAD^{tree}
 '
 
-test_expect_success 'cherry-pick/rebase with conflict outside cone' '
+test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 	init_repos &&
 
 	for OPERATION in cherry-pick rebase
@@ -572,11 +583,17 @@ test_expect_success 'cherry-pick/rebase with conflict outside cone' '
 		test_all_match git status --porcelain=v2 &&
 
 		# 2. Add the file with conflict markers
+		# NEEDSWORK: Even though the merge conflict removed the
+		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
+		# warn that this is a problematic add.
 		test_all_match git add folder1/a &&
 		test_all_match git status --porcelain=v2 &&
 
 		# 3. Rename the file to another sparse filename and
 		#    accept conflict markers as resolved content.
+		# NEEDSWORK: This mode now fails, because folder2/z is
+		# outside of the sparse-checkout cone and does not match an
+		# existing index entry with the SKIP_WORKTREE bit cleared.
 		run_on_all mv folder2/a folder2/z &&
 		test_all_match git add folder2 &&
 		test_all_match git status --porcelain=v2 &&
@@ -654,6 +671,7 @@ test_expect_success 'clean' '
 test_expect_success 'submodule handling' '
 	init_repos &&
 
+	test_sparse_match git sparse-checkout add modules &&
 	test_all_match mkdir modules &&
 	test_all_match touch modules/a &&
 	test_all_match git add modules &&
@@ -663,6 +681,7 @@ test_expect_success 'submodule handling' '
 	test_all_match git commit -m "add submodule" &&
 
 	# having a submodule prevents "modules" from collapse
+	test_sparse_match git sparse-checkout set deep/deeper1 &&
 	test-tool -C sparse-index read-cache --table >cache &&
 	grep "100644 blob .*	modules/a" cache &&
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
-- 
gitgitgadget

