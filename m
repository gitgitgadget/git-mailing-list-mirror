Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423183587CE
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222786; cv=none; b=RLOfxLZV60iBHIBtgkf7RFR3TW5EY9FgnNBZ5v7+JCa6EVFE3o4UGuHQqiWpKSuL9yGqNtmw4m1ju70SjEpDFohe+SIodfIfJ7eH4yzE5o0WJ4+nEMUP2965rBzYTyBG5+HM4d7pgAL3zbKp8s2u9wkaWcmYfM89ZhZJpEE9QRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222786; c=relaxed/simple;
	bh=MxhBa8PLDiC7HxhUFXOORqMBTmizWF4PuWaKxGCO5OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+xmaoVrQmsKsCKnQ/gLuG08ZL4Yms0gVY7cdiXlyQbnJVLUwkqcbflL6Fjm30PEd6qteOpN8EC9aJkuCMG5kFsN3bT1azGPNCdFwt8tTVP7xsVXdv8QJ9x9/vSsTMxXSGGfjjtqms0F5uxCJrIeIM01TKIKA3koZ3khK0OmEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqfK/G98; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqfK/G98"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so46622065e9.3
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 04:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768222783; x=1768827583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b0TZmxOi2Dol7AriggQSVquFDTr+jjx9KxZspRw2d8=;
        b=hqfK/G98UiVZVaKSXl7f3mQco172kZRvrsY/nUfSH0Fg+7NPh3AEsGBwyHBtGXUQA3
         YUC2mk8f3MCFZVjIl2TfsxiipIHRDlpVUMBLbkJ8cb3pjmRKR/yv3OMP41Z4mNfQGWdl
         u8UEZk0Njzxv1xOmcUSYZmgAACTTej+zECmx7gj0vaKW9MNfag8UrhTpZedcLaAnjmwJ
         RMLX22PIuSW0D3qlHAMNoq+5RRvw9RJRMkU95xZMnWFPs2Mq0A/5i8PdjnWghki02xEp
         pp7G2GSNwQQkv+Ia0txwHZVGsVuyCVlsObNN9ALUeyv6h7gNZYLrpnOTrPB/pQwvCwb0
         PbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222783; x=1768827583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9b0TZmxOi2Dol7AriggQSVquFDTr+jjx9KxZspRw2d8=;
        b=KfDgkwEsOkKPdEVj02GR761SrDHQQ7+3xbSIdrc4KGRKYywWUZdFkZif1sEDHaKg71
         Xx+Ip3du1Jkqo+13GCrFS21Nsjoll8WZri91q6oOuYb6lb65yP8oXRaH6XuYyFH3rjv8
         g3t5ectTUvamc4IWOXxgkAIctH87awZOLE6XacMzATQliT71HAQv7aR6Dx8woM8qwqH0
         VvtaTyZFTLPsdu9NP1IZedLzSYVVq0RdfJ0CvvdU7Wu52WNno2Dfc6kIOq5YHr5aOtyf
         e/4ewX/hwEUukIWX9+F/oU1gme0+wDwySDpLNEfpHd9XYCnT0Gte1SFACeD9s0133FG8
         sT+g==
X-Gm-Message-State: AOJu0YxJT7pboy80sQ6Gh2tK4jSRr0r5JcKx/p8pAb4zojrvgEOzaCfm
	QjrC+ZBS5efu+qu1DirC1riAmxVwHrv/MnvNYol+mEPJBoRuLWOz1GZV
X-Gm-Gg: AY/fxX6Ef4iq6Vnp7LdUxYhSOlyAltxi0UrZu3muEKCeYl/fAPzshDkjNuaOiwHeuii
	LTUaWiJc7v+qdee+2qtZuiozPzqoW78ORe/MkRXQ8PXzGP6Rvf4Hwkvfa5oF6jYfjtlGnq19HQl
	MsjUBxkqwfUjxPwk92a1/yLMi/VagXOxmO6+LHuYAmiEcA6tR1BlW5mhtjam9Kv/wTtBK2ejYzW
	hE4YwBiADcyAgd8heJTCOs/a/av5I9NJteSaXZEL9BPG46emtJzOYv9d4z3raipcXLmucc1+Ba7
	yU1+pkGpwEL8/gxlx+IXXRyLjFZl1ux8TYhN1fNpbjyi3a4Q7gGmroctJK6UY+DZebIjNdRHtQ+
	0JiwnO7078iPf97ALwZrTCdAoKWBbkpNb5JT9572PH9892OVTWkFXoWoNoR8uBmH4dA2s5KurNi
	9lU5cx1jbmnaY3MjM=
X-Google-Smtp-Source: AGHT+IHyLc2ln0yQNi1rtl1YyfDPK9d7pw0DbgIE+gTLTIl1VTVH3HrTq7pmXtTvVCL2jVvTAXVH8g==
X-Received: by 2002:a05:600c:83c9:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-47d84b3b719mr225956425e9.31.1768222782542;
        Mon, 12 Jan 2026 04:59:42 -0800 (PST)
Received: from ubuntu ([102.91.81.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm367017185e9.7.2026.01.12.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:59:42 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [Outreachy PATCH RFC 2/3] environment: stop using core.sparseCheckout globally
Date: Mon, 12 Jan 2026 13:59:24 +0100
Message-Id: <87b86239ff31cef5ebb6264d630b9072132c490f.1768217572.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768217572.git.belkid98@gmail.com>
References: <cover.1768217572.git.belkid98@gmail.com>
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

Move the parsed value into `struct config_values` which holds all the
values parsed by `git_default_config()` and can be accessed
per repo via `git_default_config()`. This would mean we do not need to
remove code from `git_default_core_config()`, thereby retaining current
behaviours.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/backfill.c        |  3 +--
 builtin/clone.c           |  2 +-
 builtin/mv.c              |  2 +-
 builtin/sparse-checkout.c | 22 +++++++++++-----------
 builtin/worktree.c        |  2 +-
 config.h                  |  1 +
 dir.c                     |  2 +-
 environment.c             |  3 +--
 environment.h             |  1 -
 sparse-index.c            |  4 ++--
 unpack-trees.c            |  2 +-
 wt-status.c               |  3 ++-
 12 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..7745aa6bf9 100644
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
+		ctx.sparse = repo->cfg_values->sparse_checkout;
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
diff --git a/builtin/clone.c b/builtin/clone.c
index b19b302b06..568e76a135 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -623,7 +623,7 @@ static int git_sparse_checkout_init(const char *repo)
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
-	core_apply_sparse_checkout = 1;
+	the_repository->cfg_values->sparse_checkout = 1;
 
 	cmd.git_cmd = 1;
 	if (run_command(&cmd)) {
diff --git a/builtin/mv.c b/builtin/mv.c
index d43925097b..e95c1dfb91 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -572,7 +572,7 @@ int cmd_mv(int argc,
 		rename_index_entry_at(the_repository->index, pos, dst);
 
 		if (ignore_sparse &&
-		    core_apply_sparse_checkout &&
+		    the_repository->cfg_values->sparse_checkout &&
 		    core_sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..0eb81b2188 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -63,7 +63,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 	int res;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!the_repository->cfg_values->sparse_checkout)
 		die(_("this worktree is not sparse"));
 
 	argc = parse_options(argc, argv, prefix,
@@ -400,11 +400,11 @@ static int set_config(struct repository *repo,
 
 static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 	/* If not specified, use previous definition of cone mode */
-	if (*cone_mode == -1 && core_apply_sparse_checkout)
+	if (*cone_mode == -1 && the_repository->cfg_values->sparse_checkout)
 		*cone_mode = core_sparse_checkout_cone;
 
 	/* Set cone/non-cone mode appropriately */
-	core_apply_sparse_checkout = 1;
+	the_repository->cfg_values->sparse_checkout = 1;
 	if (*cone_mode == 1 || *cone_mode == -1) {
 		core_sparse_checkout_cone = 1;
 		return MODE_CONE_PATTERNS;
@@ -418,7 +418,7 @@ static int update_modes(struct repository *repo, int *cone_mode, int *sparse_ind
 	int mode, record_mode;
 
 	/* Determine if we need to record the mode; ensure sparse checkout on */
-	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
+	record_mode = (*cone_mode != -1) || !repo->cfg_values->sparse_checkout;
 
 	mode = update_cone_mode(cone_mode);
 	if (record_mode && set_config(repo, mode))
@@ -699,9 +699,9 @@ static int modify_pattern_list(struct repository *repo,
 		break;
 	}
 
-	if (!core_apply_sparse_checkout) {
+	if (!repo->cfg_values->sparse_checkout) {
 		set_config(repo, MODE_ALL_PATTERNS);
-		core_apply_sparse_checkout = 1;
+		repo->cfg_values->sparse_checkout = 1;
 		changed_config = 1;
 	}
 
@@ -798,7 +798,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo->cfg_values->sparse_checkout)
 		die(_("no sparse-checkout to add to"));
 
 	repo_read_index(repo);
@@ -907,7 +907,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo->cfg_values->sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
 	reapply_opts.cone_mode = -1;
@@ -969,7 +969,7 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo->cfg_values->sparse_checkout)
 		die(_("must be in a sparse-checkout to clean directories"));
 	if (!core_sparse_checkout_cone)
 		die(_("must be in a cone-mode sparse-checkout to clean directories"));
@@ -1035,7 +1035,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	struct pattern_list pl;
 
 	/*
-	 * We do not exit early if !core_apply_sparse_checkout; due to the
+	 * We do not exit early if !repo->cfg_values->sparse_checkout; due to the
 	 * ability for users to manually muck things up between
 	 *   direct editing of .git/info/sparse-checkout
 	 *   running read-tree -m u HEAD or update-index --skip-worktree
@@ -1061,7 +1061,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
 	pl.use_cone_patterns = 0;
-	core_apply_sparse_checkout = 1;
+	repo->cfg_values->sparse_checkout = 1;
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..921b4a8ca2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -536,7 +536,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * If the current worktree has sparse-checkout enabled, then copy
 	 * the sparse-checkout patterns from the current worktree.
 	 */
-	if (core_apply_sparse_checkout)
+	if (the_repository->cfg_values->sparse_checkout)
 		copy_sparse_checkout(sb_repo.buf);
 
 	/*
diff --git a/config.h b/config.h
index 1652d315e2..21d65c440e 100644
--- a/config.h
+++ b/config.h
@@ -140,6 +140,7 @@ struct config_context {
 struct config_values {
 	/* core config values */
 	char *attributes_file_path;
+	int sparse_checkout;
 
 };
 #define CONFIG_CONTEXT_INIT { 0 }
diff --git a/dir.c b/dir.c
index b00821f294..d23f057f95 100644
--- a/dir.c
+++ b/dir.c
@@ -1551,7 +1551,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 int init_sparse_checkout_patterns(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout)
+	if (!istate->repo->cfg_values->sparse_checkout)
 		return 1;
 	if (istate->sparse_checkout_patterns)
 		return 0;
diff --git a/environment.c b/environment.c
index d633b0405b..15b63cdc4a 100644
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
index 3512a7072e..60d5933cc2 100644
--- a/environment.h
+++ b/environment.h
@@ -161,7 +161,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
diff --git a/sparse-index.c b/sparse-index.c
index 76f90da5f5..14f3f07fe9 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -152,7 +152,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	if (!istate->repo->cfg_values->sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
@@ -670,7 +670,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout ||
+	if (!istate->repo->cfg_values->sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index f38c761ab9..ffab104bfb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->prefix)
 		update_sparsity_for_prefix(o->prefix, o->src_index);
 
-	if (!core_apply_sparse_checkout || !o->update)
+	if (!repo->cfg_values->sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..de527bd620 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -35,6 +35,7 @@
 #include "lockfile.h"
 #include "sequencer.h"
 #include "fsmonitor-settings.h"
+#include "config.h"
 
 #define AB_DELAY_WARNING_IN_MS (2 * 1000)
 #define UF_DELAY_WARNING_IN_MS (2 * 1000)
@@ -1764,7 +1765,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 	int skip_worktree = 0;
 	int i;
 
-	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
+	if (!r->cfg_values->sparse_checkout || r->index->cache_nr == 0) {
 		/*
 		 * Don't compute percentage of checked out files if we
 		 * aren't in a sparse checkout or would get division by 0.
-- 
2.34.1

