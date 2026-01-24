Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67C4503B
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769257298; cv=none; b=rXj7Ex1XNGmUPgPsgvuk4EpV3FAQOys4sqqHx2cKkHsi9xtwgzFR0wSgVX1iax51LD4Z2ysXmBuPdZKE4BcCdb+Gb/Zg2ian5dMASkhktywEs+x29JK9FTJ2GVbfmtTQ4nvBT8GHBYPRJuHVPfcLl5WkQgq0uVPryvcJoIiAyVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769257298; c=relaxed/simple;
	bh=F8kpzBlaJOhb20aXT+7azk1r1k6uzBE+O/J5xXeyGko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1ZVmitKFoCl/GAxenkg5lHyLnF7ve1rABdKR8ECA+QHZSM7HebNld16Xg9JdSjOsOEXD9eQO5vsfTnzRkZGvOX9jQP6X9PDWRh55JyevCgTUz17cT5wJlqoQU8TCfTnAjdZDyGI3FDpzoAq5k2NMNF0XG9hjKAs2FCIRbBNtE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqVA6BYO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqVA6BYO"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4359249bbacso2658331f8f.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 04:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769257294; x=1769862094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRZxtugjx8XvDCjo0iXQBNuTr2/9MGkfRyPSv7WxEUQ=;
        b=DqVA6BYOpigeewAfEqYcPjihpouCLqgibMh2A2SKrQQgoDmQcE6h7S31VoSoc3eMQE
         tSvR8EYoKyPTTQcqQWqkk/+MZmHl2rAlLTwFeYRRHhIjAHqf3lBlvWS6O1ESV3ohBU4j
         ZSG4hLORj0ACgNKj8Ahcsc576+NXPH7jaRRhEf/loXXLnSpPpfTYBsyZOeIp8CLkIQB7
         3SZ55wvXuRmO8/raj0ZK+0wR5oGT0+RfgBXzoaYQD4lPks6jzkBXgC+xCqfI1o84BN3I
         m7S79djkXdFGUwqbzc76PvPpS51JQX8BEwtQXbBviX6d5XrNHrAyRv2wEKgpIfkXUJkx
         4Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769257294; x=1769862094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRZxtugjx8XvDCjo0iXQBNuTr2/9MGkfRyPSv7WxEUQ=;
        b=rHcdFGslum61fRmsTyGDfKaqW7H4f1fBcjtET6G7XWRnV5FTAr6o16hcw9amkUZitn
         fxu8vyCqKeF2alfjPC5p75hbkQyIXyoUSOg5djY0JIrTYwxwLJDK3FjEExo/3hf5mZ3u
         CpIbW1p7CyObu0qNLOaByjz3btCE+HH8/4L8OPopRqQRPfGmXgFOk5rmPRQWD+8y7/0d
         SYo3Jj3ILXO0jWsQGF9jHgkiqF6ns3fz9xJw+XNmFFLMHB13ri7fQtcqLqqaxlvexnkR
         4G6dSfpR9vSw6cfKaft9shHVefNFp209Qs9O4+KPzFX6w/deS3LX6F9+kfwxS24vKATo
         cA5g==
X-Gm-Message-State: AOJu0Yw2VCveqCY2uxK8k/KmzYYXtPCrrO4va9tyTaq37V/VElo0GSj0
	XJaNIlKJtrox6HZ+CHQBkLo0DyuePTAbXwvPaaGV+FqqxcYrOtT1xz3G
X-Gm-Gg: AZuq6aKNXqEa6fA0R+KVG9HCNY6LGHkgUHSc7oEnXrx8pODlL8AOqgvW5OPieyT6o7m
	RLxt2vfZEETmUbm1SbC9sf64KbRPkUzEUcAKllMcfDYPHOfwo2wlq62iU4XJZmpwd9LlizhxbA8
	SuR7X44tBArhdyp06sf/RDU1SmhC7V7qirKnzf2qifN9eJJO3JooFLZZ8HYJu6pCirmVfLAPvBp
	wR90HbjZSYH/dPkugxjYwXsSQRn748REnLXW1rEofzn4yqcU59TFoKaXVLgCGjL65drLUvFOa0I
	Gg4txXQFPdtLxyPxsyS+J+tk2GkQkUhxi9bKeboaDRayAyqXEQ6MV18inRi/0xUwBnAqJxn341c
	bEui6F9BSp0MbIrckbHe6MVP1U25rCE2SVcZ1eXqKGi4EbzbGw2sfHnkn19SA/F358cfmtmx7V7
	3bJw==
X-Received: by 2002:a05:600c:3209:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-48047068ca3mr100660595e9.6.1769257294429;
        Sat, 24 Jan 2026 04:21:34 -0800 (PST)
Received: from ubuntu ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e71503sm15536092f8f.25.2026.01.24.04.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 04:21:33 -0800 (PST)
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
Subject: [Outreachy PATCH v5 2/3] environment: stop using core.sparseCheckout globally
Date: Sat, 24 Jan 2026 13:21:12 +0100
Message-Id: <5e56e1cc4172cfff9e917a068184e102aa70bf1d.1769256839.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769256839.git.belkid98@gmail.com>
References: <cover.1769256839.git.belkid98@gmail.com>
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
 builtin/backfill.c        |  2 +-
 builtin/clone.c           |  2 +-
 builtin/grep.c            |  2 +-
 builtin/mv.c              |  2 +-
 builtin/sparse-checkout.c | 23 ++++++++++++-----------
 builtin/worktree.c        |  2 +-
 dir.c                     |  2 +-
 environment.c             |  4 ++--
 environment.h             |  2 +-
 sparse-index.c            |  6 ++++--
 unpack-trees.c            |  2 +-
 wt-status.c               |  3 ++-
 12 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..d8cc13aaa4 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -139,7 +139,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	repo_config(repo, git_default_config, NULL);
 
 	if (ctx.sparse < 0)
-		ctx.sparse = core_apply_sparse_checkout;
+		ctx.sparse = the_repository->config_values.apply_sparse_checkout;
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
diff --git a/builtin/clone.c b/builtin/clone.c
index b19b302b06..ee0736b634 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -623,7 +623,7 @@ static int git_sparse_checkout_init(const char *repo)
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
-	core_apply_sparse_checkout = 1;
+	the_repository->config_values.apply_sparse_checkout = 1;
 
 	cmd.git_cmd = 1;
 	if (run_command(&cmd)) {
diff --git a/builtin/grep.c b/builtin/grep.c
index 53cccf2d25..4b5a96703a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -482,7 +482,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 *	"forget" the sparse-index feature switch. As a result, the index
 	 *	of these submodules are expanded unexpectedly.
 	 *
-	 * 2. "core_apply_sparse_checkout"
+	 * 2. "config_values.apply_sparse_checkout"
 	 *	When running `grep` in the superproject, this setting is
 	 *	populated using the superproject's configs. However, once
 	 *	initialized, this config is globally accessible and is read by
diff --git a/builtin/mv.c b/builtin/mv.c
index d43925097b..29801f5fe7 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -572,7 +572,7 @@ int cmd_mv(int argc,
 		rename_index_entry_at(the_repository->index, pos, dst);
 
 		if (ignore_sparse &&
-		    core_apply_sparse_checkout &&
+		    the_repository->config_values.apply_sparse_checkout &&
 		    core_sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..cfd107db5e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -63,7 +63,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 	int res;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->config_values.apply_sparse_checkout)
 		die(_("this worktree is not sparse"));
 
 	argc = parse_options(argc, argv, prefix,
@@ -400,11 +400,11 @@ static int set_config(struct repository *repo,
 
 static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 	/* If not specified, use previous definition of cone mode */
-	if (*cone_mode == -1 && core_apply_sparse_checkout)
+	if (*cone_mode == -1 && the_repository->config_values.apply_sparse_checkout)
 		*cone_mode = core_sparse_checkout_cone;
 
 	/* Set cone/non-cone mode appropriately */
-	core_apply_sparse_checkout = 1;
+	the_repository->config_values.apply_sparse_checkout = 1;
 	if (*cone_mode == 1 || *cone_mode == -1) {
 		core_sparse_checkout_cone = 1;
 		return MODE_CONE_PATTERNS;
@@ -418,7 +418,8 @@ static int update_modes(struct repository *repo, int *cone_mode, int *sparse_ind
 	int mode, record_mode;
 
 	/* Determine if we need to record the mode; ensure sparse checkout on */
-	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
+	record_mode = (*cone_mode != -1) ||
+		      !the_repository->config_values.apply_sparse_checkout;
 
 	mode = update_cone_mode(cone_mode);
 	if (record_mode && set_config(repo, mode))
@@ -699,9 +700,9 @@ static int modify_pattern_list(struct repository *repo,
 		break;
 	}
 
-	if (!core_apply_sparse_checkout) {
+	if (!the_repository->config_values.apply_sparse_checkout) {
 		set_config(repo, MODE_ALL_PATTERNS);
-		core_apply_sparse_checkout = 1;
+		the_repository->config_values.apply_sparse_checkout = 1;
 		changed_config = 1;
 	}
 
@@ -798,7 +799,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->config_values.apply_sparse_checkout)
 		die(_("no sparse-checkout to add to"));
 
 	repo_read_index(repo);
@@ -907,7 +908,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->config_values.apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
 	reapply_opts.cone_mode = -1;
@@ -969,7 +970,7 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->config_values.apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to clean directories"));
 	if (!core_sparse_checkout_cone)
 		die(_("must be in a cone-mode sparse-checkout to clean directories"));
@@ -1035,7 +1036,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	struct pattern_list pl;
 
 	/*
-	 * We do not exit early if !core_apply_sparse_checkout; due to the
+	 * We do not exit early if !repo->config_values.apply_sparse_checkout; due to the
 	 * ability for users to manually muck things up between
 	 *   direct editing of .git/info/sparse-checkout
 	 *   running read-tree -m u HEAD or update-index --skip-worktree
@@ -1061,7 +1062,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
 	pl.use_cone_patterns = 0;
-	core_apply_sparse_checkout = 1;
+	the_repository->config_values.apply_sparse_checkout = 1;
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..4b0c3e09a9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -536,7 +536,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * If the current worktree has sparse-checkout enabled, then copy
 	 * the sparse-checkout patterns from the current worktree.
 	 */
-	if (core_apply_sparse_checkout)
+	if (the_repository->config_values.apply_sparse_checkout)
 		copy_sparse_checkout(sb_repo.buf);
 
 	/*
diff --git a/dir.c b/dir.c
index b00821f294..bc59d8cd6a 100644
--- a/dir.c
+++ b/dir.c
@@ -1551,7 +1551,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 int init_sparse_checkout_patterns(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->config_values.apply_sparse_checkout)
 		return 1;
 	if (istate->sparse_checkout_patterns)
 		return 0;
diff --git a/environment.c b/environment.c
index 72735d9e4b..269cac6d6e 100644
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
index 0c0dcc6847..ddce69c6ba 100644
--- a/environment.h
+++ b/environment.h
@@ -87,6 +87,7 @@ struct strvec;
 struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
+	int apply_sparse_checkout;
 };
 
 /*
@@ -168,7 +169,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
diff --git a/sparse-index.c b/sparse-index.c
index 76f90da5f5..f00c601986 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -152,7 +152,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	struct repo_config_values *cfg = &the_repository->config_values;
+	if (!cfg->apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
@@ -670,7 +671,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout ||
+	struct repo_config_values *cfg = &the_repository->config_values;
+	if (!cfg->apply_sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index f38c761ab9..a2f4d568da 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->prefix)
 		update_sparsity_for_prefix(o->prefix, o->src_index);
 
-	if (!core_apply_sparse_checkout || !o->update)
+	if (!the_repository->config_values.apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..4c66b47052 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1764,7 +1764,8 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 	int skip_worktree = 0;
 	int i;
 
-	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
+	if (!the_repository->config_values.apply_sparse_checkout ||
+	    r->index->cache_nr == 0) {
 		/*
 		 * Don't compute percentage of checked out files if we
 		 * aren't in a sparse checkout or would get division by 0.
-- 
2.34.1

