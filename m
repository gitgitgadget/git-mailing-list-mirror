Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E272E764C
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325154; cv=none; b=cEmnvAy8u3K3EelZQshMnPlHcEFzll+2/FNXjGhU6gLdXUCyDzwLbN/5Byv93blfOrrpz1n+Va1/PEwiGdnYWO5Yzla9svdYHxXJVmb3EydBUlio34r3cBgHisUPMfz9g+H3b11TYu9BALd8h784DpCk+j3Ezto+1S4XnnMc8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325154; c=relaxed/simple;
	bh=Y01oNS5AoIBnsZ9DOPzHioSqdc3pop5B821b0UhDYtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yh/l4G+EdIJ3BZe6WaTAs1mAoiTotOzyd5t7P9JpPKqw58442h10J3Ne0vPbdA+anXRqepns1EAKYqn79Tt7UQkMmNVTWGTP7LREfW3YRAqODSL7cI9ga8t0UTMzMrRLoAgAMFvpHEcQ8eabUzeNwhH9nJP5uWMu7bQ5CH0RIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ1Tlk10; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ1Tlk10"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-432d256c2a9so4157907f8f.3
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325151; x=1768929951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efxjWSJNrn9w/31kFS996ZAyaGgbxMJKYH9ymIsJnHQ=;
        b=YQ1Tlk10Ymccuscbbbtd4vqInO6fNCem0fKHCzKZiZeGw4SXxAeThpJ9dQVB1NShET
         DoFPW2442DPdalCt22NJQBWU/UdFyXVZ0wuKyFQTGt/z30UiGOqwdblhVEsSauzZEF0Z
         c8GMnBTkj/U6v6vtjJQ27lEr8UE1Tl3eoE9SZaEnwgxwH/s0NfdTKV2bi1WCd0D6h2I9
         hiM+vUAkJDa9jH1t5BO15lCm8zGSlhf+VGvE8rSjME92Kbu6SmEdjvFK85AAF1Z2MTsY
         DFuaxg7ZwdxJHjOFxoxGSSEYY1K7NhYQmjC/dhtNlZledTF3BFIbC22e+vN05r7je5bE
         tCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325151; x=1768929951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=efxjWSJNrn9w/31kFS996ZAyaGgbxMJKYH9ymIsJnHQ=;
        b=jj4RwZB+C4twbICRIyEQyeo7ytdlOQO9qNWevp8ZJS7OslA9hMkUIuMGlJDKRQdlUJ
         XuNhBb/mEG40/EeBW/8Va6mPmgrblKIR6qtmIlpkoYmhOpL01xhte5XRRSBfU8eXEScb
         03WTkpa1gTbJRnzfhfDZBy61REPOhQugyHLh1AiYWdgz+ITnkQIH5tZEOmFEb5aK1VoR
         wUAda9+O4eur+m5qwzgpgMj7Ga2QUxKJFJAwI6ADxCYIug1id0FA74MOHF0NdiXPr++O
         yGcnnSnAvQddWWx9aFGaS2r3Kkb3p8/2Mt3WHkTa2QwjoctUJbrm5Ahyn+r/tuUF0xqT
         QQKQ==
X-Gm-Message-State: AOJu0YwP6g5fYwzaWx5BoK5uiviQXYJJOCox3lyJruagNH/Tinq2JnnG
	at907QkcKvrTo2r59UoSJbrVF7gDWaz8HBlOWrFljuQ1XNgj4VQV0yj2
X-Gm-Gg: AY/fxX7fvxpmDG/2vvAt8sfAk3tVYbN7mj6IVHgeqCLZdJNwR6yvhzZV7Jb0VeRLWiJ
	0CgoRFgxlww4zitv+vaL4+/tTHL3lDk7MwP+PfHgx5ezSsKPNEMuE0PvI1rRIVC4cyRTjZaAnEQ
	M0MiGczgKCWA+MWi7oyTtL5+QIJIVxOoQIwcewloahHEm8i3I4od42UI6KqGuMRxEpFA0g8Y9eM
	xZ5ZJB9uAGv/8OjdM1FmpyyE3Tgmr8wW2qJQf7KEOlZDT4dCohJc4NWe+2EFrg9FTjss24FQNiY
	BSs9yrIK+rsF9P+I8xdxov3CWVKgrEy+reyYjcGWxXxpncniRhSj+uocbiXvU1bGMwgZIzt3TmC
	H4RfXHbqRoga35d4kDj9V0+d28R1p3UKdN1qYbrxX3WpqKK0HEF3/jmUzeBbgw0BNrg3Z0BubHB
	iLeeNM
X-Google-Smtp-Source: AGHT+IHNWjt/VC7VrUoXsAfzgmIGVVefV//vTsuHJ19I2/cuQM9vZ95qnRqsDGNf1OQQir/BE45Q5w==
X-Received: by 2002:a05:6000:1a8b:b0:42f:b707:56f0 with SMTP id ffacd0b85a97d-432c379520cmr28286151f8f.37.1768325151175;
        Tue, 13 Jan 2026 09:25:51 -0800 (PST)
Received: from ubuntu ([102.91.81.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5e3sm45059696f8f.35.2026.01.13.09.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:25:50 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v2 2/3] environment: environment: stop using core.sparseCheckout globally
Date: Tue, 13 Jan 2026 17:44:01 +0100
Message-Id: <1e83c077f274d73aebe183ae61157593f4a358c2.1768318762.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768318762.git.belkid98@gmail.com>
References: <cover.1768318762.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value `core.sparseCheckout` is parsed in
`git_default_core_config()` and stored globally in
`core_appy_sparse_checkout`. This could cause unintended behaviours
when different Git repositories running in the same process access this
variable.

Move the parsed value into `struct repo_config_values` which holds all the
values parsed by `git_default_config()` and can be accessed
per repo via `git_default_config()`. This retains current
behaviours while achieving the repository scoped access.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/backfill.c        |  3 +--
 builtin/clone.c           |  2 +-
 builtin/grep.c            |  2 +-
 builtin/mv.c              |  2 +-
 builtin/sparse-checkout.c | 22 +++++++++++-----------
 builtin/worktree.c        |  2 +-
 dir.c                     |  2 +-
 environment.c             |  3 +--
 environment.h             |  2 +-
 sparse-index.c            |  6 ++++--
 unpack-trees.c            |  2 +-
 wt-status.c               |  2 +-
 12 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..90d5312240 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -1,4 +1,3 @@
-/* We need this macro to access core_apply_sparse_checkout */
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
@@ -139,7 +138,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	repo_config(repo, git_default_config, NULL);
 
 	if (ctx.sparse < 0)
-		ctx.sparse = core_apply_sparse_checkout;
+		ctx.sparse = repo->config_values.sparse_checkout;
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
diff --git a/builtin/clone.c b/builtin/clone.c
index b19b302b06..b6b19e83d1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -623,7 +623,7 @@ static int git_sparse_checkout_init(const char *repo)
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
-	core_apply_sparse_checkout = 1;
+	the_repository->config_values.sparse_checkout = 1;
 
 	cmd.git_cmd = 1;
 	if (run_command(&cmd)) {
diff --git a/builtin/grep.c b/builtin/grep.c
index 53cccf2d25..525edb5e9c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -482,7 +482,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 *	"forget" the sparse-index feature switch. As a result, the index
 	 *	of these submodules are expanded unexpectedly.
 	 *
-	 * 2. "core_apply_sparse_checkout"
+	 * 2. "sparse_checkout"
 	 *	When running `grep` in the superproject, this setting is
 	 *	populated using the superproject's configs. However, once
 	 *	initialized, this config is globally accessible and is read by
diff --git a/builtin/mv.c b/builtin/mv.c
index d43925097b..511620747b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -572,7 +572,7 @@ int cmd_mv(int argc,
 		rename_index_entry_at(the_repository->index, pos, dst);
 
 		if (ignore_sparse &&
-		    core_apply_sparse_checkout &&
+		    the_repository->config_values.sparse_checkout &&
 		    core_sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..1c2c39b968 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -63,7 +63,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 	int res;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->config_values.sparse_checkout)
 		die(_("this worktree is not sparse"));
 
 	argc = parse_options(argc, argv, prefix,
@@ -400,11 +400,11 @@ static int set_config(struct repository *repo,
 
 static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 	/* If not specified, use previous definition of cone mode */
-	if (*cone_mode == -1 && core_apply_sparse_checkout)
+	if (*cone_mode == -1 && the_repository->config_values.sparse_checkout)
 		*cone_mode = core_sparse_checkout_cone;
 
 	/* Set cone/non-cone mode appropriately */
-	core_apply_sparse_checkout = 1;
+	the_repository->config_values.sparse_checkout = 1;
 	if (*cone_mode == 1 || *cone_mode == -1) {
 		core_sparse_checkout_cone = 1;
 		return MODE_CONE_PATTERNS;
@@ -418,7 +418,7 @@ static int update_modes(struct repository *repo, int *cone_mode, int *sparse_ind
 	int mode, record_mode;
 
 	/* Determine if we need to record the mode; ensure sparse checkout on */
-	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
+	record_mode = (*cone_mode != -1) || !repo->config_values.sparse_checkout;
 
 	mode = update_cone_mode(cone_mode);
 	if (record_mode && set_config(repo, mode))
@@ -699,9 +699,9 @@ static int modify_pattern_list(struct repository *repo,
 		break;
 	}
 
-	if (!core_apply_sparse_checkout) {
+	if (!repo->config_values.sparse_checkout) {
 		set_config(repo, MODE_ALL_PATTERNS);
-		core_apply_sparse_checkout = 1;
+		repo->config_values.sparse_checkout = 1;
 		changed_config = 1;
 	}
 
@@ -798,7 +798,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo->config_values.sparse_checkout)
 		die(_("no sparse-checkout to add to"));
 
 	repo_read_index(repo);
@@ -907,7 +907,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo->config_values.sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
 	reapply_opts.cone_mode = -1;
@@ -969,7 +969,7 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo->config_values.sparse_checkout)
 		die(_("must be in a sparse-checkout to clean directories"));
 	if (!core_sparse_checkout_cone)
 		die(_("must be in a cone-mode sparse-checkout to clean directories"));
@@ -1035,7 +1035,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	struct pattern_list pl;
 
 	/*
-	 * We do not exit early if !core_apply_sparse_checkout; due to the
+	 * We do not exit early if !repo->config_values.sparse_checkout; due to the
 	 * ability for users to manually muck things up between
 	 *   direct editing of .git/info/sparse-checkout
 	 *   running read-tree -m u HEAD or update-index --skip-worktree
@@ -1061,7 +1061,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
 	pl.use_cone_patterns = 0;
-	core_apply_sparse_checkout = 1;
+	repo->config_values.sparse_checkout = 1;
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..e401b8253e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -536,7 +536,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * If the current worktree has sparse-checkout enabled, then copy
 	 * the sparse-checkout patterns from the current worktree.
 	 */
-	if (core_apply_sparse_checkout)
+	if (wt->repo->config_values.sparse_checkout)
 		copy_sparse_checkout(sb_repo.buf);
 
 	/*
diff --git a/dir.c b/dir.c
index b00821f294..56b412a6d2 100644
--- a/dir.c
+++ b/dir.c
@@ -1551,7 +1551,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 int init_sparse_checkout_patterns(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout)
+	if (!istate->repo->config_values.sparse_checkout)
 		return 1;
 	if (istate->sparse_checkout_patterns)
 		return 0;
diff --git a/environment.c b/environment.c
index 2789c3514a..65919a6c52 100644
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
+		cfg->sparse_checkout = git_config_bool(var, value);
 		return 0;
 	}
 
diff --git a/environment.h b/environment.h
index 8c7803425e..5caf73b4b8 100644
--- a/environment.h
+++ b/environment.h
@@ -88,6 +88,7 @@ struct strvec;
 struct repo_config_values {
 	/* core config values */
 	char *attributes_file_path;
+	int sparse_checkout;
 };
 
 /*
@@ -167,7 +168,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
diff --git a/sparse-index.c b/sparse-index.c
index 76f90da5f5..6dd8dd679d 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -152,7 +152,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	struct repo_config_values *cfg = &istate->repo->config_values;
+	if (!cfg->sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
@@ -670,7 +671,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout ||
+	struct repo_config_values *cfg = &istate->repo->config_values;
+	if (!cfg->sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index f38c761ab9..2bdfa1334c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->prefix)
 		update_sparsity_for_prefix(o->prefix, o->src_index);
 
-	if (!core_apply_sparse_checkout || !o->update)
+	if (!repo->config_values.sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..a2e388606f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1764,7 +1764,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 	int skip_worktree = 0;
 	int i;
 
-	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
+	if (!r->config_values.sparse_checkout || r->index->cache_nr == 0) {
 		/*
 		 * Don't compute percentage of checked out files if we
 		 * aren't in a sparse checkout or would get division by 0.
-- 
2.34.1

