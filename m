Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDABE56A
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311741; cv=none; b=qGKOoQYNOlex4H34SJh4Zck8Y364HCy/zD8diiTFOvAbtmRcFLR/Vyz6VFG9Zx4l8FGoJmzZyr9YBzlrVuN1sPeid+UrWdcwZ0pwoXbmFPGqgY+BZI3nTP9a7gTBDOJUuSV9YOJsi/FgWyhNwAE4J7Cc8tdp8IkyBvc2czuhnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311741; c=relaxed/simple;
	bh=iXjersnBRRA0l/IhBwexiG1PZWzDj4gbhvYtznWriNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfBllLar+e+CGQJPTbUKXxBlILjo5yRODFwxbnhNxYtoDCxKkacm6005GXhYg9hCSgth/Sw/XL5MOiYZIZ6OooMVKgWfryn8UssXe8UYXFOhnLaz9pFvco5U21lN1Guzq4yNV4lijzpOhKcGOFz+lLAe5YFl1ixIDMmbiljBCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/VTOQGr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/VTOQGr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4994115b3a.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751311738; x=1751916538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ibJfqcl/GQcFKf2ZS6j+y719+q5phj8Z4yBlZt7Xio=;
        b=W/VTOQGrTru4he5yFgm92U4l9TmowxwhcsAbA/wUY9CGW8L/QbmNCu5dtlgOLtUtBH
         hgzRcEbhx/FTRUPHKErQQdz48cJUyuQTrL8ppL/ya0KYZ1vq5Gv2KEsbnU4vgDK/dPRU
         2U8KopIn4lYIKzsYje29+maZhRJDX6plzLzBW0QoGje9CKecCnqLG7BP8rqQzpMznzTx
         pPwcL+gu/CD12xBkU/lJsPDKvuikBC0FMTOcdnj1i2oewKp3lEL+ob4eZioUD8j5v5Zx
         BooGotSR3Fs6K5KLYTKcRSqjEb8Zcx4lWPC7lWPd5IXK0kp2+Ih7A+55ZIt/WnYFQtU9
         9y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311738; x=1751916538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ibJfqcl/GQcFKf2ZS6j+y719+q5phj8Z4yBlZt7Xio=;
        b=Niw76zQbMzzAOmDCov30WDW/+fWNkRWEP/kjiub7gcg9e4Sg5dnPFPhAXryyo3DqYL
         JjTQCN8oMMRcUBRJS7Pc5QfTLBWQu9jN7U1LLJdncUuDYN9dj4gnjyNTjSNaXY/qMI7V
         e85vHFNxeSAdTIM3UjKiwoSTxHn0Jqfg4dwC0krScDp0cmvR4QzM55oe6SZzn8jDABS1
         lKLGV5L1qxm5sZrZG4Zs3MR+awb1JgmnsPb7ZUnccXpmTGXVZwkN/q8uBQ3ZBypZMtES
         pCCBuSiCTYT2OniEnXA+l6hYlhE3dCLfE1knsXNHSPw30niLtRpWVOuvdNiOocaAHlLr
         GryQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqhOXNxz+semMFT4RD1FtelLwIFjtXlWlEEqmD5ISExrpj6R4h8SPVf7TNEUU7i9coCZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1LamNIBZ41Vu6TVMUilMkuOxVLAl2s88UYHsHz6i8/stYsbB
	KwbbKMY3EXo8+4PE1IhjkAMwUjspjaSJOwyUu6FHZiEWMfAy71H9mi2P5cXFSzeNQos=
X-Gm-Gg: ASbGncsZ7sXEbeDfaP/CTze90X9OHo9EaVbAwBgW08MUyx/0BO4UmOyUktlR1FduuAt
	Xhom+67ZbHPYzYxBceDy35AowfzhdM62D69ID/eVu+1Zo81rSyKJKdRZ7UIM0+1hm9HJ4XJIATr
	1H3XLQXyOpsARGZ4xKlB2u/G1fqIKI26f5UHBieNSMoh0Hp8dq5rkw4vj0hGReBltzVSqkD2VNu
	BCXfETZ2FMvjTWzLhFJmOn3J2aNL9h4id/eUnfNh5syhfZCgEcZWqxBnOF1vgY7QHT7nYHa9IJZ
	87xkSpiJ6mtG8TazDGRsDc5gr83+GYkp8FkLclzDh10fFV9RxUiYnGSffpz4aHnlTAP0sugx0JS
	ozA==
X-Google-Smtp-Source: AGHT+IHJMMxvZ1Jlo3Ahrjbvr9ldkIOSxig5Y3voWi+3HcEsWMe6Gc6q+9OCIiaTkiH3hzifPGUkfw==
X-Received: by 2002:a05:6a00:1992:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-74af6f2e8c1mr21143939b3a.18.1751311737617;
        Mon, 30 Jun 2025 12:28:57 -0700 (PDT)
Received: from thinku.localdomain ([110.226.180.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557b27dsm9757779b3a.84.2025.06.30.12.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:28:57 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	ben.knoble@gmail.com
Subject: [GSOC PATCH v5 1/3] environment: move access to "core.sparsecheckout" into repo_settings
Date: Tue,  1 Jul 2025 00:57:46 +0530
Message-ID: <ba9929d128c07993c8a83229b3721d12b7455dc6.1751309770.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751309770.git.ayu.chandekar@gmail.com>
References: <cover.1751309770.git.ayu.chandekar@gmail.com>
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
- In "sparse-checkout.c", add a call to `prepare_repo_settings()` inside
  `is_sparse_index_allowed()`, as it is used widely and relies on the
  setting.
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
index fa82ad2f6f..bf9e56bff3 100644
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
index 91b9cd0d16..6d70986f3e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -617,11 +617,12 @@ static int git_sparse_checkout_init(const char *repo)
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
index 3ce574a605..6111fee60b 100644
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
index 88a36ea9f8..92e1c92afc 100644
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
index b18b5617fc..8fd4dd8c81 100644
--- a/config.c
+++ b/config.c
@@ -1612,11 +1612,6 @@ static int git_default_core_config(const char *var, const char *value,
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
index a374972b62..5d1cb7a067 100644
--- a/dir.c
+++ b/dir.c
@@ -1503,7 +1503,8 @@ enum pattern_match_result path_matches_pattern_list(
 
 int init_sparse_checkout_patterns(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout)
+	prepare_repo_settings(istate->repo);
+	if (!istate->repo->settings.sparse_checkout)
 		return 1;
 	if (istate->sparse_checkout_patterns)
 		return 0;
diff --git a/environment.c b/environment.c
index c61d773e7e..a379a9149e 100644
--- a/environment.c
+++ b/environment.c
@@ -64,7 +64,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
diff --git a/environment.h b/environment.h
index 3d98461a06..6a30512f3c 100644
--- a/environment.h
+++ b/environment.h
@@ -160,7 +160,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
diff --git a/repo-settings.c b/repo-settings.c
index 4129f8fb2b..9270cca561 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -81,6 +81,7 @@ void prepare_repo_settings(struct repository *r)
 		      &r->settings.pack_use_bitmap_boundary_traversal,
 		      r->settings.pack_use_bitmap_boundary_traversal);
 	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
+	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.sparse_checkout, 0);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repo-settings.h b/repo-settings.h
index 2bf24b2597..9caa7c57a3 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -67,6 +67,7 @@ struct repo_settings {
 	unsigned long big_file_threshold;
 
 	char *hooks_path;
+	int sparse_checkout;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
diff --git a/sparse-index.c b/sparse-index.c
index 5634abafaa..8132c0f2fb 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -150,7 +150,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	prepare_repo_settings(istate->repo);
+	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
@@ -172,7 +173,6 @@ int is_sparse_index_allowed(struct index_state *istate, int flags)
 		/*
 		 * Only convert to sparse if index.sparse is set.
 		 */
-		prepare_repo_settings(istate->repo);
 		if (!istate->repo->settings.sparse_index)
 			return 0;
 	}
@@ -668,7 +668,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout ||
+	if (!istate->repo->settings.sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 471837f032..02e32c4ba1 100644
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

