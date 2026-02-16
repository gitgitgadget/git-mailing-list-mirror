Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA13148B4
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259946; cv=none; b=T2MDAdAb867zW98kcAAvL9Onk46ih8cFfDxBtzd/d8Y0vtfiTv4gvuVlA0H++yPMgT/tqR1f/J7Z2LYqdEthlIjUFa80Liw7Omh9JiM4hUHzl+5/Ix0udM8ITDq6VN2NaqedNoR1UjP9NW65GKcmLBCcutI5lMOQ2GEwZJF5mzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259946; c=relaxed/simple;
	bh=qH9hURhk9bzgDR2RQA/JWam/dp2kbMpTGs/mtFl7CDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfbggxL9xmOhMHPiJsl2XUF4sf0FSIkb3CHHnf0bpNoJkFYI0MU7Yjubs6uZSlLYIfx4ugWo63U9S7qkS/bJ267Dx/PkRfVP5vx+LWl3Qj6vZM1W1y9ScBMgbBsn5rNgPTK8lONvbh/3bWTQjtJ86gdiOPKR8dULSQxemU7TcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUnQh9gt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUnQh9gt"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-436309f1ad7so2762795f8f.3
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771259943; x=1771864743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fORZYa3EIJPUqjoUZOJoySJeJlBTda15WxX7J0JBMQ4=;
        b=QUnQh9gtgRjK2xt9dDxn76HIf4QqdSd/ncjHLLCZaOxR3+NEiQk95toINM5xIGkMgM
         8mgS3wbFKcspuG9COLazsDv0HS6N8DX+TbRm5dAc1JEj6Mnz/2pveGMPUnpg1E3AnaR1
         T4qJNJkRu+msCa1YSZbWIWa/dSULr8b90+v2n2EQ+4qPEemHX4IisaIrC0Vy7TTBVw+P
         v98VMRw8/oP1pxvY6YGfkdffwtxoajv177x9o08ZcHhgmMayy3W8C9DY2vMTgV2H0krx
         RXU0vtGzOGNaVq7DEWGG7WJD0KJ2j+var4y6s2sRI6/D2UH1XPIuWONZyB45mjnRVpac
         u/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771259943; x=1771864743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fORZYa3EIJPUqjoUZOJoySJeJlBTda15WxX7J0JBMQ4=;
        b=ppqQ4aHABLzWc7RRTSrv8f29iYqWZTRHRRxJpRyeQVjMoWnLVMHXJO0HNDXZ4BqUji
         LcTqDnwSmDuzo+ssyZIey+rwavLV0vbljWHFLoUy1C1XmObfATS9X9DD4PnGLG3rGtKU
         ZxS7qkuWX9HUh+Xjlaqo3ksX2QWeXZQWkg0if0EQvBHtZiRs7xOiJnjbjKNBlqnFka8M
         ynWtmfLBXDLIfmv6LZKV27J6ayCCr6lDO7EeYIWMcN4xEvAPPsLmp+apbfmbHHQHH6k8
         qVUblsWEfQy1uikK4UB7FP/x7etvcSSoL5jLTSoPnRlloy0lx//tY7MpWeUVLpp6UJ9G
         8nlw==
X-Gm-Message-State: AOJu0YxF6PSkI3+DtH2HboQuL656k+GNM8DKYcFs93maQZYx42G7YMrc
	sVe9/2MmZPT1X+myRQkuc3TwB7D/lvS6jT0TT7boOTYY63FDzHhBKzYy
X-Gm-Gg: AZuq6aL+cyA4VbB34uZv+8HSPYhFEKtQVUP4qGqR4EK3KVbMDtAUE35lwY0AMEggsEs
	2DzrEOZJWl4dElKctqxDIsJ72JfsjHR2B+GR+l4k45+8Z+EiQUGGippLYiAXCahnvOW/vm8CFTr
	zWjN/i9a6yDO6CfYjlCPzI3RPokmftbbXt3o5rpoilIOWZBNCpNgDF3CVL92+BDOLlUPfpo3ppk
	trh9ozH3+qJaYg3/G/6f0c+FhFiQL7rGkEdVIN1Qb9cIA5ywafov20lwGC68KOpuL5t9WPI8Gxz
	2HZK6LtbH9KfBVWPDf5pi08Vhh7rR71agO2QW3dxkn5z+yfiyNf1b2zRA71jVahqf/UGAr0idhd
	B5ZDEgtKygxhfnCpqEQQ6ur5g+Ln2VwWAihvj8wFOXQOyJwVkClkwMUhSUkBdDjCXOfblrlMpYV
	0G3+RxaIO0uPAfKA==
X-Received: by 2002:a05:6000:18a7:b0:437:6dac:458a with SMTP id ffacd0b85a97d-4379dbb080dmr13685178f8f.57.1771259943239;
        Mon, 16 Feb 2026 08:39:03 -0800 (PST)
Received: from ubuntu ([102.88.77.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abe3b3sm33202962f8f.18.2026.02.16.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:39:02 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v7 2/3] environment: stop using core.sparseCheckout globally
Date: Mon, 16 Feb 2026 17:38:26 +0100
Message-Id: <7d33f1ef0f8182893d63d49b350984025ab757d4.1771258573.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1771258573.git.belkid98@gmail.com>
References: <cover.1771258573.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value `core.sparseCheckout` is parsed in
`git_default_core_config()` and stored globally in
`core_apply_sparse_checkout`. This could cause it to be overwritten
by another repository when different Git repositories run in the same
process.

Move the parsed value into `struct repo_config_values` in the_repository
to retain current behaviours and move towards libifying Git.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/backfill.c        |  3 ++-
 builtin/clone.c           |  4 +++-
 builtin/grep.c            |  2 +-
 builtin/mv.c              |  3 ++-
 builtin/sparse-checkout.c | 31 ++++++++++++++++++++-----------
 builtin/worktree.c        |  3 ++-
 dir.c                     |  4 +++-
 environment.c             |  4 ++--
 environment.h             |  2 +-
 sparse-index.c            |  7 +++++--
 unpack-trees.c            |  3 ++-
 wt-status.c               |  4 +++-
 12 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..9b2ca57b6a 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -129,6 +129,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 			 N_("Restrict the missing objects to the current sparse-checkout")),
 		OPT_END(),
 	};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_backfill_usage, options);
@@ -139,7 +140,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	repo_config(repo, git_default_config, NULL);
 
 	if (ctx.sparse < 0)
-		ctx.sparse = core_apply_sparse_checkout;
+		ctx.sparse = cfg->apply_sparse_checkout;
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
diff --git a/builtin/clone.c b/builtin/clone.c
index b19b302b06..9ba08b86ae 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -617,13 +617,15 @@ static int git_sparse_checkout_init(const char *repo)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int result = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);
 
 	/*
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
-	core_apply_sparse_checkout = 1;
+	cfg->apply_sparse_checkout = 1;
 
 	cmd.git_cmd = 1;
 	if (run_command(&cmd)) {
diff --git a/builtin/grep.c b/builtin/grep.c
index 53cccf2d25..207d340548 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -482,7 +482,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 *	"forget" the sparse-index feature switch. As a result, the index
 	 *	of these submodules are expanded unexpectedly.
 	 *
-	 * 2. "core_apply_sparse_checkout"
+	 * 2. "config_values_private_.apply_sparse_checkout"
 	 *	When running `grep` in the superproject, this setting is
 	 *	populated using the superproject's configs. However, once
 	 *	initialized, this config is globally accessible and is read by
diff --git a/builtin/mv.c b/builtin/mv.c
index d43925097b..2215d34e31 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -238,6 +238,7 @@ int cmd_mv(int argc,
 	struct hashmap moved_dirs = HASHMAP_INIT(pathmap_cmp, NULL);
 	struct strbuf pathbuf = STRBUF_INIT;
 	int ret;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	repo_config(the_repository, git_default_config, NULL);
 
@@ -572,7 +573,7 @@ int cmd_mv(int argc,
 		rename_index_entry_at(the_repository->index, pos, dst);
 
 		if (ignore_sparse &&
-		    core_apply_sparse_checkout &&
+		    cfg->apply_sparse_checkout &&
 		    core_sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..7f3317841e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -61,9 +61,10 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 	struct pattern_list pl;
 	char *sparse_filename;
 	int res;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!cfg->apply_sparse_checkout)
 		die(_("this worktree is not sparse"));
 
 	argc = parse_options(argc, argv, prefix,
@@ -399,12 +400,14 @@ static int set_config(struct repository *repo,
 }
 
 static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	/* If not specified, use previous definition of cone mode */
-	if (*cone_mode == -1 && core_apply_sparse_checkout)
+	if (*cone_mode == -1 && cfg->apply_sparse_checkout)
 		*cone_mode = core_sparse_checkout_cone;
 
 	/* Set cone/non-cone mode appropriately */
-	core_apply_sparse_checkout = 1;
+	cfg->apply_sparse_checkout = 1;
 	if (*cone_mode == 1 || *cone_mode == -1) {
 		core_sparse_checkout_cone = 1;
 		return MODE_CONE_PATTERNS;
@@ -416,9 +419,10 @@ static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 static int update_modes(struct repository *repo, int *cone_mode, int *sparse_index)
 {
 	int mode, record_mode;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	/* Determine if we need to record the mode; ensure sparse checkout on */
-	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
+	record_mode = (*cone_mode != -1) || !cfg->apply_sparse_checkout;
 
 	mode = update_cone_mode(cone_mode);
 	if (record_mode && set_config(repo, mode))
@@ -684,6 +688,7 @@ static int modify_pattern_list(struct repository *repo,
 	int result;
 	int changed_config = 0;
 	struct pattern_list *pl = xcalloc(1, sizeof(*pl));
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	switch (m) {
 	case ADD:
@@ -699,9 +704,9 @@ static int modify_pattern_list(struct repository *repo,
 		break;
 	}
 
-	if (!core_apply_sparse_checkout) {
+	if (!cfg->apply_sparse_checkout) {
 		set_config(repo, MODE_ALL_PATTERNS);
-		core_apply_sparse_checkout = 1;
+		cfg->apply_sparse_checkout = 1;
 		changed_config = 1;
 	}
 
@@ -796,9 +801,10 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 	};
 	struct strvec patterns = STRVEC_INIT;
 	int ret;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!cfg->apply_sparse_checkout)
 		die(_("no sparse-checkout to add to"));
 
 	repo_read_index(repo);
@@ -905,9 +911,10 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 			 N_("toggle the use of a sparse index")),
 		OPT_END(),
 	};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!cfg->apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
 	reapply_opts.cone_mode = -1;
@@ -960,6 +967,7 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	size_t worktree_len;
 	int force = 0, dry_run = 0, verbose = 0;
 	int require_force = 1;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	struct option builtin_sparse_checkout_clean_options[] = {
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
@@ -969,7 +977,7 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!cfg->apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to clean directories"));
 	if (!core_sparse_checkout_cone)
 		die(_("must be in a cone-mode sparse-checkout to clean directories"));
@@ -1033,9 +1041,10 @@ static int sparse_checkout_disable(int argc, const char **argv,
 		OPT_END(),
 	};
 	struct pattern_list pl;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	/*
-	 * We do not exit early if !core_apply_sparse_checkout; due to the
+	 * We do not exit early if !repo->config_values.apply_sparse_checkout; due to the
 	 * ability for users to manually muck things up between
 	 *   direct editing of .git/info/sparse-checkout
 	 *   running read-tree -m u HEAD or update-index --skip-worktree
@@ -1061,7 +1070,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
 	pl.use_cone_patterns = 0;
-	core_apply_sparse_checkout = 1;
+	cfg->apply_sparse_checkout = 1;
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..90e56ab495 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -440,6 +440,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf sb_name = STRBUF_INIT;
 	struct worktree **worktrees, *wt = NULL;
 	struct ref_store *wt_refs;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	worktrees = get_worktrees();
 	check_candidate_path(path, opts->force, worktrees, "add");
@@ -536,7 +537,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * If the current worktree has sparse-checkout enabled, then copy
 	 * the sparse-checkout patterns from the current worktree.
 	 */
-	if (core_apply_sparse_checkout)
+	if (cfg->apply_sparse_checkout)
 		copy_sparse_checkout(sb_repo.buf);
 
 	/*
diff --git a/dir.c b/dir.c
index b00821f294..026d8516a9 100644
--- a/dir.c
+++ b/dir.c
@@ -1551,7 +1551,9 @@ enum pattern_match_result path_matches_pattern_list(
 
 int init_sparse_checkout_patterns(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout)
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
+	if (!cfg->apply_sparse_checkout)
 		return 1;
 	if (istate->sparse_checkout_patterns)
 		return 0;
diff --git a/environment.c b/environment.c
index 4b5c701e80..390af1ce54 100644
--- a/environment.c
+++ b/environment.c
@@ -74,7 +74,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
@@ -546,7 +545,7 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.sparsecheckout")) {
-		core_apply_sparse_checkout = git_config_bool(var, value);
+		cfg->apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -761,4 +760,5 @@ int git_default_config(const char *var, const char *value,
 void repo_config_values_init(struct repo_config_values *cfg)
 {
 	cfg->attributes_file = NULL;
+	cfg->apply_sparse_checkout = 0;
 }
diff --git a/environment.h b/environment.h
index dfc31b794d..2e24160322 100644
--- a/environment.h
+++ b/environment.h
@@ -88,6 +88,7 @@ struct repository;
 struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
+	int apply_sparse_checkout;
 };
 
 struct repo_config_values *repo_config_values(struct repository *repo);
@@ -171,7 +172,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
diff --git a/sparse-index.c b/sparse-index.c
index 76f90da5f5..386be1d6f1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -152,7 +152,9 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
+	if (!cfg->apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
@@ -670,7 +672,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout ||
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+	if (!cfg->apply_sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index f38c761ab9..998a1e6dc7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1888,6 +1888,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	struct pattern_list pl;
 	int free_pattern_list = 0;
 	struct dir_struct dir = DIR_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (o->reset == UNPACK_RESET_INVALID)
 		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
@@ -1924,7 +1925,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->prefix)
 		update_sparsity_for_prefix(o->prefix, o->src_index);
 
-	if (!core_apply_sparse_checkout || !o->update)
+	if (!cfg->apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..6609b37cad 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1763,8 +1763,10 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 {
 	int skip_worktree = 0;
 	int i;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
+	if (!cfg->apply_sparse_checkout ||
+	    r->index->cache_nr == 0) {
 		/*
 		 * Don't compute percentage of checked out files if we
 		 * aren't in a sparse checkout or would get division by 0.
-- 
2.34.1

