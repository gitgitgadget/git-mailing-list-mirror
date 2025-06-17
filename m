Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF62EB5D7
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162072; cv=none; b=I3VYa62qwK0AbUdxnf0dQagYDeq3KM/vb0pBdKfM2aEvSAvBKm29O2AIQtI3NkWrDZ6ITsl7JkjoboSKnj9SYqbFMQfPwSRAlfLwbarinTgEaw9DUTRt61I0rH1ox8XbheBpRcRMoemWXeDbmn+n3UWNdCxSLi+DvARUckxZy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162072; c=relaxed/simple;
	bh=w/fH6FBopAFZWGIoCpma/qom7hQJJUISpIN0ZSVV+PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7L6FBaCxrXwOegvfn0C61LxzDsnRjre9BJNCQqRtePxMOfRvtQjiR1J4i7HvHPgWBGxLyDDQpOLYZIcxa9Q4pcGWDj/Q7xUmAXo3QbZJpT0wWWQA4AFbs/8yr1g7lZi5v7z0H8eUFRM4YClA5dZ8GWZ0PiSWmiwJA+CRTKfGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDtbjM3y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDtbjM3y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747c2cc3419so4340174b3a.2
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750162070; x=1750766870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+b7rQ2PiQCRQST/4dxjdKU9iWylCFi3m7vyHHcfoUs=;
        b=aDtbjM3yKkzm7rMYW+sJ+SN1zrcoPQVNGe8TMnBKkLVgzI7KIahRgllTJNhI270/ur
         oVQmK09S06MphAd1mbNhqV4BHKjpPO9/u2NdrAi6GTN1yAMyg8n4mpK++ZpJUu+Sim3t
         sd3BIxj5tiJjPhIhekFEyZJK9ud1wKgmVzLJdM1WUjmpQNNV8cnp0frh7jhpDDD5dilx
         CfIMyiwBQLSyNGXQR5FZ3tnsvou6R884Sb90HeQ9RAUk5beiZ2iUvjDIwNJnojIcccFS
         aHeo2MZITgj8H1MLjwaiOTpQVU6gG8ahKDdRR5Ml23GTiGklCpf42NRwy/mSb96kCiAr
         UPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162070; x=1750766870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+b7rQ2PiQCRQST/4dxjdKU9iWylCFi3m7vyHHcfoUs=;
        b=eT6iveyHefK7cIU7w4nQoFrZYG2dhGZDVdOR//PBnQHXgh2UYtq3qgLA8g7wXv384i
         FE/MjT3dnLooWICoQcxwlezFW/YZ/uCUUNCyD2skhEyp07ued1BeOebke8woXWf/molt
         nhtHm8E5jyaALuoyfwh65SJ4LvK/orsXQXo5yfgwRgwEoEBiJAJSu7yY09PQpnF7rNG6
         xcWTMxjzLfJ8df5bFyrT3GzGKjH5rqLQVpYlXGx/9bY7jk8DxUDxm2lJKKgFZGs/YzP2
         m1tOgOKNG97FFnXgls3bfuGsF0iIofBAstp69f7cL2FbdyWUEJoMTRKMrXTyvzq6v5T/
         jViQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpCybxLsOFjBWOGP6A4/rjT+B1gOdNrEunjLj4XtfY6aanD4obyHqY5LJixTKGR8xUhsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6/JfjpTWqDEXZuDEqiKHB3uuCpT/L4beHlSnwaHgTnIdqtLQ
	94zSTtlTaZl4oi2uqrmIIOM+vWFmdt7r5PolaN+y7HdCroxYMQulAlXm
X-Gm-Gg: ASbGncu08aM53jvHkjyAWoHhR5C4+5Jv71WtjR+00xEm3krtdZFBBTGVMWVz8+E1sqD
	pYwU53FYrZrD1tguwS25ep4MEk6arATKSR7+CurZAk+9SSlGShO8TwcrepOeQEyIFg0NyDNtQQ9
	hW9b/aJfcWNEwHm50wOGVKmntQAwr5TdPo0OVD0pQJ72HIvM8HKIdNYZ+p5cmIb8vs5d9AH7EYe
	1ajCVfjC+LAp1NHsCjx0FVe9bgBUFnZAwDXAW7yNRO68kkzxK02PiDN2+p2O2mv+5B5o3PhRXrD
	e179hdiBJJ78jYhsOYoGZeenkyMRdC5t0ethdhwBf364jdPioqwuyUydMCW4BNleM4VUPMhxbtz
	u69+J
X-Google-Smtp-Source: AGHT+IEpCz92o/BD/M2rWEpZ4DLk3Q8jEY9Bz0UnmitcKSENzhLmkwArsVlqdBLSnAlbxJRQrQXAPQ==
X-Received: by 2002:a05:6a00:1895:b0:740:6630:633f with SMTP id d2e1a72fcca58-7489cf728ccmr20758099b3a.8.1750162069564;
        Tue, 17 Jun 2025 05:07:49 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c96:a38d:5480:e4eb:2835:b445])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffed0c2sm8623333b3a.22.2025.06.17.05.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:07:49 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v4 1/3] environment: move access to "core.sparsecheckout" into repo_settings
Date: Tue, 17 Jun 2025 17:36:34 +0530
Message-ID: <e221c68ab52e995adbb175dc4a09f6c3dfeaf7c8.1750157825.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750157825.git.ayu.chandekar@gmail.com>
References: <cover.1750157825.git.ayu.chandekar@gmail.com>
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
It's fine not to lazily load it from the config, as the variable
is used quite commonly.

This also allows us to remove the definition `#define
USE_THE_REPOSITORY_VARIABLE` from the file 'builtin/backfill.c'.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/backfill.c        |  7 ++-----
 builtin/clone.c           |  2 +-
 builtin/grep.c            |  2 +-
 builtin/mv.c              |  2 +-
 builtin/sparse-checkout.c | 20 ++++++++++----------
 builtin/worktree.c        |  2 +-
 config.c                  |  5 -----
 dir.c                     |  2 +-
 environment.c             |  1 -
 environment.h             |  1 -
 repo-settings.c           |  1 +
 repo-settings.h           |  1 +
 sparse-index.c            |  4 ++--
 unpack-trees.c            |  2 +-
 wt-status.c               |  2 +-
 15 files changed, 23 insertions(+), 31 deletions(-)

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
index 91b9cd0d16..1bc9c1bada 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -621,7 +621,7 @@ static int git_sparse_checkout_init(const char *repo)
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
-	core_apply_sparse_checkout = 1;
+	the_repository->settings.sparse_checkout = 1;
 
 	cmd.git_cmd = 1;
 	if (run_command(&cmd)) {
diff --git a/builtin/grep.c b/builtin/grep.c
index 3ce574a605..63342f5e36 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -481,7 +481,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 *	"forget" the sparse-index feature switch. As a result, the index
 	 *	of these submodules are expanded unexpectedly.
 	 *
-	 * 2. "core_apply_sparse_checkout"
+	 * 2. "sparse_checkout"
 	 *	When running `grep` in the superproject, this setting is
 	 *	populated using the superproject's configs. However, once
 	 *	initialized, this config is globally accessible and is read by
diff --git a/builtin/mv.c b/builtin/mv.c
index 07548fe96a..1e9f4d3eba 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -572,7 +572,7 @@ int cmd_mv(int argc,
 		rename_index_entry_at(the_repository->index, pos, dst);
 
 		if (ignore_sparse &&
-		    core_apply_sparse_checkout &&
+		    the_repository->settings.sparse_checkout &&
 		    core_sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1bf01591b2..869d574a03 100644
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
@@ -961,7 +961,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
 	pl.use_cone_patterns = 0;
-	core_apply_sparse_checkout = 1;
+	the_repository->settings.sparse_checkout = 1;
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
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
index a374972b62..8f0f7ca8a4 100644
--- a/dir.c
+++ b/dir.c
@@ -1503,7 +1503,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 int init_sparse_checkout_patterns(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout)
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
index 5634abafaa..2428b20634 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -150,7 +150,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
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
index 454601afa1..ec2be98194 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1773,7 +1773,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 	int skip_worktree = 0;
 	int i;
 
-	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
+	if (!r->settings.sparse_checkout || r->index->cache_nr == 0) {
 		/*
 		 * Don't compute percentage of checked out files if we
 		 * aren't in a sparse checkout or would get division by 0.
-- 
2.49.0

