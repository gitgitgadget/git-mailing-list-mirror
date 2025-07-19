Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7D79CF
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883921; cv=none; b=CSqygN2+wMgBLMZG/iHFeZ6RDSRqiI79E8MJbj9o2pipQ1kiezZOUqbckm/DJ5JyDLZmIYCD//94JAcs/h9ofaA8wJlz8YhTQHZLcrsc0rXjOqhjkD2Xl6XiCJfxpeTaescQkDd6FS8vbsvFYbPLMAWysAeO2C1QggGq+Is0b2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883921; c=relaxed/simple;
	bh=JMTdDs4C/H6s/VVUedrKLBM4QQnZRL67B4T9gwh9v3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrLW79FPJsP2y/rimruFtnoJD5+qTA100Hwsf0Pl2zQ4gqdUMaSQLzuNsk9XkEjSibjqvDQ+c44mfsfqlhU/w6LpCbQemCGNj3gJbtUnN6rZP7b0fNUgIbGnZ1cTPbZhmb8yBr4peXKaFJ/PIZBV1bUFnpzH7sksqa7Txe83zG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7EfFc1M; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7EfFc1M"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31c84b8052so2809210a12.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 17:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752883918; x=1753488718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B56MyLt3cDPYA5DyheMSweT+9ZFyU5X/wiAwkyQuC74=;
        b=P7EfFc1MAz98whI7gtFx728qqaxpZmtY5euwUxlMqGWopSg7cbt7tGFXHdYhZ3/HPG
         hn/tkKLzX7val2M2qyDGeSeXgMrKwhFJHk48M6Qb3+HT3QHxxVjKG2CO376ABHzsues7
         W1vLj6DvpA+yDp6G2VBnOy2cCmgreu/Cf4LKUAhNuOAzcShp5+1ETIct5JuawX7+FTj+
         nsnDQ6l/aqrX01/VB5xNVi5mWsAJc84iResQsnNhMSBScaL/VERE+hirEk6WuZBo9Nau
         FZGdAZTWVrqnmrPYDkhbH2TX4IUFbQx2AwHBTRck2p8F/OgNFhbJRdPPETbho//6HEtf
         EV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752883918; x=1753488718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B56MyLt3cDPYA5DyheMSweT+9ZFyU5X/wiAwkyQuC74=;
        b=RhqqTkCVX8CPSTd3mxglpZUGxkarfwd0UhTtZk8sHJMNTVZqskFysmCuoGIvxKnKvK
         TNe4wXHcD8+gBWzVD3DOUj4IKrUkRxXn2CZ5tyJb5A9C+q8NutQYv1nrO8BPtX3o0a9K
         omBj1CFA9fgIofRi4B5/BW2ed5bHHSqgxAVlNVSRnu6FwqC3T4Kmhndu70OkdrheSX4x
         y8GB5POC/0W+HDAuo+T6SR7npezxrc+OrYoqPBUjgEiFctggE5M3GBJRHWQy7+gClfo+
         8T5BP6V4Ddim3yGRyp9jQrJSNDnDT8UfaDhK2LwGbhp/OLDGpOcY4ptJaMzBaa7bw6AJ
         f2NA==
X-Forwarded-Encrypted: i=1; AJvYcCXKg5em/KOF02H4VtX3anYIMYP7ZAncn5ZX8J6LgrN4ci0Zu2ZG7w5DP5I7APDRNQMEvhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWT7IVVRLMOEN3wHG7TtJ4+tvazogWJVMZURlwIYr/ymNQAgDL
	Q6ySds8+nErDmsoOxJAfcq1TKSqbqv/KzY5yOfL79iFidGgJOioAmxm+
X-Gm-Gg: ASbGnctqOmo58hB696zsR3dlOy5lBNlhgiJI/PKtN3OxHNlQUxJbEQBlj1Gi3Sm5Qmr
	dEVAKa22K4VHqHrgbbiU52gdRUia27OldXYcwNAzDbGvxBioLPSMJS28114NP1J6YMo3akea6Z/
	rkhPu4Oca+AdlUP9x3zdv5WBKZfy0cyEo11OB5JPnZf2II4bNiosvKgMSqCN6xkN67q3yWmXfFQ
	OlZkYY6zTM4QxuIMvNFzuqepk3Xr/74/KUGTDF+4O3ot93//AtX1PyQ1+bRBZLzRq4Z2wx9aWv9
	AF6tuCSdKnzkA3mHV946C4DRjcLCM1TgKTR0Si8y7xsl+TJO+Sg/xixgzpj/r08COFyCGqj1h+S
	KsE/rItea8VBI3K5P3Zvgw4SkfsJCvD8OZyg=
X-Google-Smtp-Source: AGHT+IGIeEzjrzi/v+W5HbDB8nOjnkQlVlbpBClhSY2mmDtkBtXRPYoVZUbeVl0jRVMgbGYcEC09EA==
X-Received: by 2002:a17:90b:2584:b0:311:df4b:4b81 with SMTP id 98e67ed59e1d1-31caf8ef446mr11556450a91.25.1752883918363;
        Fri, 18 Jul 2025 17:11:58 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3d5e765sm1964268a91.0.2025.07.18.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 17:11:57 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	ben.knoble@gmail.com
Subject: [GSOC PATCH v6 1/3] environment: move access to "core.sparsecheckout" into repo_settings
Date: Sat, 19 Jul 2025 05:41:26 +0530
Message-ID: <d0e2042b3061320fac8a8fdf9043c6ab4dbed5a2.1752882401.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752882401.git.ayu.chandekar@gmail.com>
References: <cover.1752882401.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setting "core.sparsecheckout" is stored in the global
`core_apply_sparse_checkout` and is populated in config.c. Refactor the
code to store it in the variable `sparse_checkout` in the struct
`repo_settings`.

Call `prepare_repo_settings()` where necessary to ensure the `struct
repo_settings` is initialized before use:
- In "builtin/backfill.c", "builtin/mv.c" and "builtin/clone.c" call
  `prepare_repo_settings()` since their respective `cmd_*()` functions
  did not call it earlier.
- In "dir.c", the function using 'settings.sparse_checkout' is invoked
  in multiple files that do not call `prepare_repo_settings()`, hence
  add a call directly to that function.
- In "sparse-index.c", remove a call to `prepare_repo_settings()`
  from the function `is_sparse_index_allowed()` as it is called
  everytime before the function is called, and add a call to
  `prepare_repo_settings()` inside `convert_to_sparse()`, as it is
  used widely without having a call to `prepare_repo_settings()`
  before and relies on the setting.
- In "wt-status.c", call `prepare_repo_settings()` before accessing
  the setting because the function using it is commonly used.

Avoid reduntant calls to `prepare_repo_settings()` where it is already
present:
- In "builtin/worktree.c", it is already invoked in `cmd_worktree()`
  before the setting is accessed.
- In "unpack-tress.c", the function accessing the setting already calls
  it.

This also allows us to remove the definition `#define
USE_THE_REPOSITORY_VARIABLE` from the file 'builtin/backfill.c'.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/backfill.c        |  7 ++-----
 builtin/clone.c           |  3 ++-
 builtin/grep.c            |  2 +-
 builtin/mv.c              |  4 ++--
 builtin/sparse-checkout.c | 21 ++++++++++-----------
 builtin/worktree.c        |  2 +-
 config.c                  |  5 -----
 dir.c                     |  3 ++-
 environment.c             |  1 -
 environment.h             |  1 -
 repo-settings.c           |  1 +
 repo-settings.h           |  1 +
 sparse-index.c            |  6 +++---
 unpack-trees.c            |  2 +-
 wt-status.c               |  3 ++-
 15 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 80056abe47..48b2518743 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -1,6 +1,3 @@
-/* We need this macro to access core_apply_sparse_checkout */
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "git-compat-util.h"
 #include "config.h"
@@ -137,9 +134,9 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 			     0);
 
 	repo_config(repo, git_default_config, NULL);
-
+	prepare_repo_settings(repo);
 	if (ctx.sparse < 0)
-		ctx.sparse = core_apply_sparse_checkout;
+		ctx.sparse = repo->settings.sparse_checkout;
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
diff --git a/builtin/clone.c b/builtin/clone.c
index 6d08abed37..6b6d429fd8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -619,11 +619,12 @@ static int git_sparse_checkout_init(const char *repo)
 	int result = 0;
 	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);
 
+	prepare_repo_settings(the_repository);
 	/*
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
-	core_apply_sparse_checkout = 1;
+	the_repository->settings.sparse_checkout = 1;
 
 	cmd.git_cmd = 1;
 	if (run_command(&cmd)) {
diff --git a/builtin/grep.c b/builtin/grep.c
index 39273d9c0f..fbad1a72a2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -481,7 +481,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 *	"forget" the sparse-index feature switch. As a result, the index
 	 *	of these submodules are expanded unexpectedly.
 	 *
-	 * 2. "core_apply_sparse_checkout"
+	 * 2. "settings.sparse_checkout"
 	 *	When running `grep` in the superproject, this setting is
 	 *	populated using the superproject's configs. However, once
 	 *	initialized, this config is globally accessible and is read by
diff --git a/builtin/mv.c b/builtin/mv.c
index 07548fe96a..43ed2e3d0a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -570,9 +570,9 @@ int cmd_mv(int argc,
 						       &st,
 						       0);
 		rename_index_entry_at(the_repository->index, pos, dst);
-
+		prepare_repo_settings(the_repository);
 		if (ignore_sparse &&
-		    core_apply_sparse_checkout &&
+		    the_repository->settings.sparse_checkout &&
 		    core_sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1bf01591b2..8329d29a27 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -62,7 +62,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 	int res;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->settings.sparse_checkout)
 		die(_("this worktree is not sparse"));
 
 	argc = parse_options(argc, argv, prefix,
@@ -397,11 +397,11 @@ static int set_config(enum sparse_checkout_mode mode)
 
 static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 	/* If not specified, use previous definition of cone mode */
-	if (*cone_mode == -1 && core_apply_sparse_checkout)
+	if (*cone_mode == -1 && the_repository->settings.sparse_checkout)
 		*cone_mode = core_sparse_checkout_cone;
 
 	/* Set cone/non-cone mode appropriately */
-	core_apply_sparse_checkout = 1;
+	the_repository->settings.sparse_checkout = 1;
 	if (*cone_mode == 1 || *cone_mode == -1) {
 		core_sparse_checkout_cone = 1;
 		return MODE_CONE_PATTERNS;
@@ -415,7 +415,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 	int mode, record_mode;
 
 	/* Determine if we need to record the mode; ensure sparse checkout on */
-	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
+	record_mode = (*cone_mode != -1) || !the_repository->settings.sparse_checkout;
 
 	mode = update_cone_mode(cone_mode);
 	if (record_mode && set_config(mode))
@@ -695,9 +695,9 @@ static int modify_pattern_list(struct strvec *args, int use_stdin,
 		break;
 	}
 
-	if (!core_apply_sparse_checkout) {
+	if (!the_repository->settings.sparse_checkout) {
 		set_config(MODE_ALL_PATTERNS);
-		core_apply_sparse_checkout = 1;
+		the_repository->settings.sparse_checkout = 1;
 		changed_config = 1;
 	}
 
@@ -793,7 +793,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->settings.sparse_checkout)
 		die(_("no sparse-checkout to add to"));
 
 	repo_read_index(the_repository);
@@ -902,7 +902,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->settings.sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
 	reapply_opts.cone_mode = -1;
@@ -935,7 +935,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	struct pattern_list pl;
 
 	/*
-	 * We do not exit early if !core_apply_sparse_checkout; due to the
+	 * We do not exit early if !sparse_checkout; due to the
 	 * ability for users to manually muck things up between
 	 *   direct editing of .git/info/sparse-checkout
 	 *   running read-tree -m u HEAD or update-index --skip-worktree
@@ -961,11 +961,10 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
 	pl.use_cone_patterns = 0;
-	core_apply_sparse_checkout = 1;
+	the_repository->settings.sparse_checkout = 1;
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
-	prepare_repo_settings(the_repository);
 	the_repository->settings.sparse_index = 0;
 
 	if (update_working_directory(&pl))
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2dceeeed8b..a3a1bb00e3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -536,7 +536,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * If the current worktree has sparse-checkout enabled, then copy
 	 * the sparse-checkout patterns from the current worktree.
 	 */
-	if (core_apply_sparse_checkout)
+	if (the_repository->settings.sparse_checkout)
 		copy_sparse_checkout(sb_repo.buf);
 
 	/*
diff --git a/config.c b/config.c
index 095a17bd42..da76bf4fde 100644
--- a/config.c
+++ b/config.c
@@ -1607,11 +1607,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.sparsecheckout")) {
-		core_apply_sparse_checkout = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.sparsecheckoutcone")) {
 		core_sparse_checkout_cone = git_config_bool(var, value);
 		return 0;
diff --git a/dir.c b/dir.c
index 02873f59ea..01d7574c09 100644
--- a/dir.c
+++ b/dir.c
@@ -1516,7 +1516,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 int init_sparse_checkout_patterns(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout)
+	if (!istate->repo->settings.sparse_checkout)
 		return 1;
 	if (istate->sparse_checkout_patterns)
 		return 0;
@@ -1539,6 +1539,7 @@ static int path_in_sparse_checkout_1(const char *path,
 	enum pattern_match_result match = UNDECIDED;
 	const char *end, *slash;
 
+	prepare_repo_settings(istate->repo);
 	/*
 	 * We default to accepting a path if the path is empty, there are no
 	 * patterns, or the patterns are of the wrong type.
diff --git a/environment.c b/environment.c
index 7c2480b22e..3a21629f86 100644
--- a/environment.c
+++ b/environment.c
@@ -63,7 +63,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
diff --git a/environment.h b/environment.h
index 3d806ced6e..1e1e83fff1 100644
--- a/environment.h
+++ b/environment.h
@@ -159,7 +159,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
diff --git a/repo-settings.c b/repo-settings.c
index 195c24e9c0..c3aa92c065 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -84,6 +84,7 @@ void prepare_repo_settings(struct repository *r)
 		      &r->settings.pack_use_bitmap_boundary_traversal,
 		      r->settings.pack_use_bitmap_boundary_traversal);
 	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
+	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.sparse_checkout, 0);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repo-settings.h b/repo-settings.h
index d477885561..95900784f1 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -68,6 +68,7 @@ struct repo_settings {
 	unsigned long big_file_threshold;
 
 	char *hooks_path;
+	int sparse_checkout;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
diff --git a/sparse-index.c b/sparse-index.c
index 5634abafaa..c9e5a5efe1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -150,7 +150,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
@@ -172,7 +172,6 @@ int is_sparse_index_allowed(struct index_state *istate, int flags)
 		/*
 		 * Only convert to sparse if index.sparse is set.
 		 */
-		prepare_repo_settings(istate->repo);
 		if (!istate->repo->settings.sparse_index)
 			return 0;
 	}
@@ -196,6 +195,7 @@ int is_sparse_index_allowed(struct index_state *istate, int flags)
 
 int convert_to_sparse(struct index_state *istate, int flags)
 {
+	prepare_repo_settings(istate->repo);
 	/*
 	 * If the index is already sparse, empty, or otherwise
 	 * cannot be converted to sparse, do not convert.
@@ -668,7 +668,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout ||
+	if (!istate->repo->settings.sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index f38c761ab9..2e6d3f98f7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->prefix)
 		update_sparsity_for_prefix(o->prefix, o->src_index);
 
-	if (!core_apply_sparse_checkout || !o->update)
+	if (!repo->settings.sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
diff --git a/wt-status.c b/wt-status.c
index 454601afa1..8651134bcb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1773,7 +1773,8 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 	int skip_worktree = 0;
 	int i;
 
-	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
+	prepare_repo_settings(r);
+	if (!r->settings.sparse_checkout || r->index->cache_nr == 0) {
 		/*
 		 * Don't compute percentage of checked out files if we
 		 * aren't in a sparse checkout or would get division by 0.
-- 
2.49.0

