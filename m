Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96819D890
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663333; cv=none; b=ZIHWeDsH9389RmScyTEu63hDNoIgh9CX17mn0W4adC9fyCfjMdQ4adIanoNrEcJnmRiY9XUGcTnagIOJpdqKwjFOq1GKd9bc7HZBB8hcRanN2gKbQinE3MrdoxPui37KkCdhECnGHiRbcm0iIjnV8kl+yR2IpRMrZijKyQJJEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663333; c=relaxed/simple;
	bh=b40/mByGf5Zf7whmZ4xXwJABZ86LzHcdnGGOOG89Ztk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdfS3oU2FQaRQNycsK5RAivs57T2CmbfnZT2IsVrrYOeeddqBmHbcmz93lYMYv/DOrnKdAptnSnmAkVkc83Wto01eJCBX6sx59SK9xMx/JC3x8ljUvFeY8bRqlf9wkwaexAl/Yq3gmmmXocE1HRH1e9Q82YAH1dYp0IktD4tMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzwZiej0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzwZiej0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2352e3db62cso583395ad.2
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749663330; x=1750268130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxizwuw9oIayIdrx6pZyau6Q40BxsYtDiSA4FkEqw7g=;
        b=fzwZiej0xCkpFPFmsd+6jV3Et8pCZnjwyPQDhrlglUVCs2QTQseOX/eX7N899NRfgX
         9qF28F061r/soj5P32y0n4R7Aw6lCBn3lkl31Zc8fuWB8G0aSCxgZiV1lDPesy8nJ3Wy
         d/xe8+kWougr6cbIolx7WzeGGMu3XmorkCffsFjU7aGCcvpdDaiRyigPJHnlcW/TYG0g
         s6WlI0vvc+RC64PreW+XyFTgJLrUnsFXaH8kUSucXycAH7SoH04QcTXnF5N0zRbPw4/G
         l26CfGsNoTv8Ztm/RcEYjVwcbAbJ3FdjoW/6LRefz2C0rPFTwlgydDw7+pcyDQXu2OUX
         bAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749663330; x=1750268130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxizwuw9oIayIdrx6pZyau6Q40BxsYtDiSA4FkEqw7g=;
        b=mrI8rVX/15VlEkMHj26dOT4D201RTjhokVyE/J6JrjKainfeAoO7zWb0KjJWuYBoeU
         HopxyYgsmZwf7y0UVRfts5I+8VLGNZwUlBYkao8l79G9V2bSfpWmKEgajzoXow2ogr8V
         mn2UkPvYSOBzhn3mA5xJGAbqG9XfnHyXiNOsrGzD2TsdGKZ2EpBEFAFqUqKz4cymSboy
         oMD7pst6r/ccPcIeVsO/RtJXBmqX9FhjpE54nXrW6UU8KCBjsgVb93xw85GPYTdelLeP
         mD89KtkVdPckAiOscMbiPU56B6pMD7ei/rA9edTGBwY/SlHoTpUEnxCWB/AgjcrZChT3
         5BsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUEWoSgkhtBeVoTF5Nw95jYVMbxhm6cZkyDoskMY+VQo8XHmMEoqctEsqDbo8D8iFy5vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDhe1/cBxw5uIG50JNmP2PZs6NXC2F4aMG3fEM/VKfkBlYRiO
	VzGftA+JnDH2w3a/KHZbpPXnTKU6SG+C3i584i7i1TTkcm5EZLeg91a/GS7uMlSu
X-Gm-Gg: ASbGncvaxqZ+Frk8IfwM6M2Egw8Tw/qnlx83nkT2duz+DuwTEdlTT4olvLV9PZJBWun
	J4ZKjclIE+yNhbcB2RbH87IxKjYU9gj1sGDYcJx2TXGpc/A4kHC5U7HKbKcPgIYSsC9LQjmtWaK
	6a4l2LBNKVnG/qHAZkAmN13KP8a62ajAMVCXfNdH9GyoVPxGWiAFCjd1DfMlKEmOVhZQe5I9G/t
	QWKJ6/+UTmOIV89MrJwBP5UNLDYdbCcOAiZN/+0NI2UBzp+kKxln0eRWA4ZWpVNmCngozKLiTne
	tRFIRaS2wgF+jnt/D3xgzZHD69o2GU8Lz4hhEbzqly24HNLIYNvcKwMPx6MbyWv7G5wiUot5t79
	H
X-Google-Smtp-Source: AGHT+IH7VUhO7oUd7XDG2NYBqGB058VkDquT7YIXf20otfNjwlAc4vv9x7ANKJ8X6RY4+0N0grNZbA==
X-Received: by 2002:a17:902:d487:b0:232:1daf:6f06 with SMTP id d9443c01a7336-23641b3ff29mr55051835ad.47.1749663329316;
        Wed, 11 Jun 2025 10:35:29 -0700 (PDT)
Received: from thinku.localdomain ([2409:40c2:105a:523:d9bb:b018:3f1:1973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034056e7sm90407945ad.166.2025.06.11.10.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:35:28 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	ps@pks.im,
	ben.knoble@gmail.com
Subject: [PATCH v3] environment: move access to "core.sparsecheckout" into repo_settings
Date: Wed, 11 Jun 2025 23:04:33 +0530
Message-ID: <20250611173433.74393-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603131806.14915-1-ayu.chandekar@gmail.com>
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
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
`repo_settings`. Also, create functions to set and get the value of the
setting and update all the occurrences.

This also allows us to remove the definition `#define
USE_THE_REPOSITORY_VARIABLE` from the file 'builtin/backfill.c'.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---

Note that this patch is the same as v2, the v3 just contains the range-diff 
of v2/v3 vs v1, and the 'Mentored-by' trailers.

I thank my mentors Christian and Ghanshyam, as well as Patrick and Ben, 
for reviewing my patch and suggesting changes.

Summary of the range-diff:
* Change the variable name from 'core_apply_sparse_checkout' to 'sparse_checkout'.
* Update the getter and setter function names to use 'sparse_checkout' instead of 'apply_sparse_checkout'.
* Call the function 'prepare_repo_settings()' in the getter/setter functions of the variable.

Range-diff:
1:  a385fc1dbe ! 1:  c49dcde03b environment: move access to "core.sparsecheckout" into repo_settings
    @@ Commit message
     
         The setting "core.sparsecheckout" is stored in the global
         `core_apply_sparse_checkout` and is populated in config.c. Refactor the
    -    code to store it inside the struct `repo_settings`. Also, create
    -    functions to set and get the value of the setting and update all the
    -    occurrences.
    +    code to store it in the variable `sparse_checkout` in the struct
    +    `repo_settings`. Also, create functions to set and get the value of the
    +    setting and update all the occurrences.
     
         This also allows us to remove the definition `#define
         USE_THE_REPOSITORY_VARIABLE` from the file 'builtin/backfill.c'.
    @@ Commit message
         This change is part of an ongoing effort to eliminate global variables,
         improve modularity and help libify the codebase.
     
    +    Mentored-by: Christian Couder <christian.couder@gmail.com>
    +    Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
         Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
     
      ## builtin/backfill.c ##
    @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *pr
      
      	if (ctx.sparse < 0)
     -		ctx.sparse = core_apply_sparse_checkout;
    -+		ctx.sparse = repo_settings_get_apply_sparse_checkout(repo);
    ++		ctx.sparse = repo_settings_get_sparse_checkout(repo);
      
      	result = do_backfill(&ctx);
      	backfill_context_clear(&ctx);
    @@ builtin/clone.c: static int git_sparse_checkout_init(const char *repo)
      	 * for the later checkout to use the sparse-checkout file.
      	 */
     -	core_apply_sparse_checkout = 1;
    -+	repo_settings_set_apply_sparse_checkout(the_repository, 1);
    ++	repo_settings_set_sparse_checkout(the_repository, 1);
      
      	cmd.git_cmd = 1;
      	if (run_command(&cmd)) {
     
    + ## builtin/grep.c ##
    +@@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
    + 	 *	"forget" the sparse-index feature switch. As a result, the index
    + 	 *	of these submodules are expanded unexpectedly.
    + 	 *
    +-	 * 2. "core_apply_sparse_checkout"
    ++	 * 2. "sparse_checkout"
    + 	 *	When running `grep` in the superproject, this setting is
    + 	 *	populated using the superproject's configs. However, once
    + 	 *	initialized, this config is globally accessible and is read by
    +
      ## builtin/mv.c ##
     @@ builtin/mv.c: int cmd_mv(int argc,
      		rename_index_entry_at(the_repository->index, pos, dst);
      
      		if (ignore_sparse &&
     -		    core_apply_sparse_checkout &&
    -+		    repo_settings_get_apply_sparse_checkout(the_repository) &&
    ++		    repo_settings_get_sparse_checkout(the_repository) &&
      		    core_sparse_checkout_cone) {
      			/*
      			 * NEEDSWORK: we are *not* paying attention to
    @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo_settings_get_apply_sparse_checkout(the_repository))
    ++	if (!repo_settings_get_sparse_checkout(the_repository))
      		die(_("this worktree is not sparse"));
      
      	argc = parse_options(argc, argv, prefix,
    @@ builtin/sparse-checkout.c: static int set_config(enum sparse_checkout_mode mode)
      static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
      	/* If not specified, use previous definition of cone mode */
     -	if (*cone_mode == -1 && core_apply_sparse_checkout)
    -+	if (*cone_mode == -1 && repo_settings_get_apply_sparse_checkout(the_repository))
    ++	if (*cone_mode == -1 && repo_settings_get_sparse_checkout(the_repository))
      		*cone_mode = core_sparse_checkout_cone;
      
      	/* Set cone/non-cone mode appropriately */
     -	core_apply_sparse_checkout = 1;
    -+	repo_settings_set_apply_sparse_checkout(the_repository, 1);
    ++	repo_settings_set_sparse_checkout(the_repository, 1);
      	if (*cone_mode == 1 || *cone_mode == -1) {
      		core_sparse_checkout_cone = 1;
      		return MODE_CONE_PATTERNS;
    @@ builtin/sparse-checkout.c: static int update_modes(int *cone_mode, int *sparse_i
      
      	/* Determine if we need to record the mode; ensure sparse checkout on */
     -	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
    -+	record_mode = (*cone_mode != -1) || !repo_settings_get_apply_sparse_checkout(the_repository);
    ++	record_mode = (*cone_mode != -1) || !repo_settings_get_sparse_checkout(the_repository);
      
      	mode = update_cone_mode(cone_mode);
      	if (record_mode && set_config(mode))
    @@ builtin/sparse-checkout.c: static int modify_pattern_list(struct strvec *args, i
      	}
      
     -	if (!core_apply_sparse_checkout) {
    -+	if (!repo_settings_get_apply_sparse_checkout(the_repository)) {
    ++	if (!repo_settings_get_sparse_checkout(the_repository)) {
      		set_config(MODE_ALL_PATTERNS);
     -		core_apply_sparse_checkout = 1;
    -+		repo_settings_set_apply_sparse_checkout(the_repository, 1);
    ++		repo_settings_set_sparse_checkout(the_repository, 1);
      		changed_config = 1;
      	}
      
    @@ builtin/sparse-checkout.c: static int sparse_checkout_add(int argc, const char *
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo_settings_get_apply_sparse_checkout(the_repository))
    ++	if (!repo_settings_get_sparse_checkout(the_repository))
      		die(_("no sparse-checkout to add to"));
      
      	repo_read_index(the_repository);
    @@ builtin/sparse-checkout.c: static int sparse_checkout_reapply(int argc, const ch
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo_settings_get_apply_sparse_checkout(the_repository))
    ++	if (!repo_settings_get_sparse_checkout(the_repository))
      		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
      
      	reapply_opts.cone_mode = -1;
    +@@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const char **argv,
    + 	struct pattern_list pl;
    + 
    + 	/*
    +-	 * We do not exit early if !core_apply_sparse_checkout; due to the
    ++	 * We do not exit early if !sparse_checkout; due to the
    + 	 * ability for users to manually muck things up between
    + 	 *   direct editing of .git/info/sparse-checkout
    + 	 *   running read-tree -m u HEAD or update-index --skip-worktree
     @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const char **argv,
      	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
      	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
      	pl.use_cone_patterns = 0;
     -	core_apply_sparse_checkout = 1;
    -+	repo_settings_set_apply_sparse_checkout(the_repository, 1);
    ++	repo_settings_set_sparse_checkout(the_repository, 1);
      
      	add_pattern("/*", empty_base, 0, &pl, 0);
      
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      	 * the sparse-checkout patterns from the current worktree.
      	 */
     -	if (core_apply_sparse_checkout)
    -+	if (repo_settings_get_apply_sparse_checkout(the_repository))
    ++	if (repo_settings_get_sparse_checkout(the_repository))
      		copy_sparse_checkout(sb_repo.buf);
      
      	/*
    @@ dir.c: enum pattern_match_result path_matches_pattern_list(
      int init_sparse_checkout_patterns(struct index_state *istate)
      {
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo_settings_get_apply_sparse_checkout(the_repository))
    ++	if (!repo_settings_get_sparse_checkout(the_repository))
      		return 1;
      	if (istate->sparse_checkout_patterns)
      		return 0;
    @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
      		      &r->settings.pack_use_bitmap_boundary_traversal,
      		      r->settings.pack_use_bitmap_boundary_traversal);
      	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
    -+	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.core_apply_sparse_checkout, 0);
    ++	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.sparse_checkout, 0);
      
      	/*
      	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
    @@ repo-settings.c: void repo_settings_reset_shared_repository(struct repository *r
      	repo->settings.shared_repository_initialized = 0;
      }
     +
    -+int repo_settings_get_apply_sparse_checkout(struct repository *repo)
    ++int repo_settings_get_sparse_checkout(struct repository *repo)
     +{
    -+	return repo->settings.core_apply_sparse_checkout;
    ++	prepare_repo_settings(repo);
    ++	return repo->settings.sparse_checkout;
     +}
     +
    -+void repo_settings_set_apply_sparse_checkout(struct repository *repo, int value)
    ++void repo_settings_set_sparse_checkout(struct repository *repo, int value)
     +{
    -+	repo->settings.core_apply_sparse_checkout = value;
    ++	prepare_repo_settings(repo);
    ++	repo->settings.sparse_checkout = value;
     +}
     
      ## repo-settings.h ##
    @@ repo-settings.h: struct repo_settings {
      	unsigned long big_file_threshold;
      
      	char *hooks_path;
    -+	int core_apply_sparse_checkout;
    ++	int sparse_checkout;
      };
      #define REPO_SETTINGS_INIT { \
      	.shared_repository = -1, \
    @@ repo-settings.h: int repo_settings_get_shared_repository(struct repository *repo
      void repo_settings_set_shared_repository(struct repository *repo, int value);
      void repo_settings_reset_shared_repository(struct repository *repo);
      
    -+/* Read, set or reset the value for "core.sparsecheckout". */
    -+int repo_settings_get_apply_sparse_checkout(struct repository *repo);
    -+void repo_settings_set_apply_sparse_checkout(struct repository *repo, int value);
    ++/* Read or set the value for "core.sparseCheckout". */
    ++int repo_settings_get_sparse_checkout(struct repository *repo);
    ++void repo_settings_set_sparse_checkout(struct repository *repo, int value);
     +
      #endif /* REPO_SETTINGS_H */
     
    @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
      int is_sparse_index_allowed(struct index_state *istate, int flags)
      {
     -	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
    -+	if (!repo_settings_get_apply_sparse_checkout(istate->repo) || !core_sparse_checkout_cone)
    ++	if (!repo_settings_get_sparse_checkout(istate->repo) || !core_sparse_checkout_cone)
      		return 0;
      
      	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
    @@ sparse-index.c: static void clear_skip_worktree_from_present_files_full(struct i
      void clear_skip_worktree_from_present_files(struct index_state *istate)
      {
     -	if (!core_apply_sparse_checkout ||
    -+	if (!repo_settings_get_apply_sparse_checkout(istate->repo) ||
    ++	if (!repo_settings_get_sparse_checkout(istate->repo) ||
      	    sparse_expect_files_outside_of_patterns)
      		return;
      
    @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpac
      		update_sparsity_for_prefix(o->prefix, o->src_index);
      
     -	if (!core_apply_sparse_checkout || !o->update)
    -+	if (!repo_settings_get_apply_sparse_checkout(repo) || !o->update)
    ++	if (!repo_settings_get_sparse_checkout(repo) || !o->update)
      		o->skip_sparse_checkout = 1;
      	if (!o->skip_sparse_checkout) {
      		memset(&pl, 0, sizeof(pl));
    @@ wt-status.c: static void wt_status_check_sparse_checkout(struct repository *r,
      	int i;
      
     -	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
    -+	if (!repo_settings_get_apply_sparse_checkout(r) || r->index->cache_nr == 0) {
    ++	if (!repo_settings_get_sparse_checkout(r) || r->index->cache_nr == 0) {
      		/*
      		 * Don't compute percentage of checked out files if we
      		 * aren't in a sparse checkout or would get division by 0.

 builtin/backfill.c        |  5 +----
 builtin/clone.c           |  2 +-
 builtin/grep.c            |  2 +-
 builtin/mv.c              |  2 +-
 builtin/sparse-checkout.c | 20 ++++++++++----------
 builtin/worktree.c        |  2 +-
 config.c                  |  5 -----
 dir.c                     |  2 +-
 environment.c             |  1 -
 environment.h             |  1 -
 repo-settings.c           | 13 +++++++++++++
 repo-settings.h           |  5 +++++
 sparse-index.c            |  4 ++--
 unpack-trees.c            |  2 +-
 wt-status.c               |  2 +-
 15 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index fa82ad2f6f..e16d116e98 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -1,6 +1,3 @@
-/* We need this macro to access core_apply_sparse_checkout */
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "git-compat-util.h"
 #include "config.h"
@@ -139,7 +136,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	repo_config(repo, git_default_config, NULL);
 
 	if (ctx.sparse < 0)
-		ctx.sparse = core_apply_sparse_checkout;
+		ctx.sparse = repo_settings_get_sparse_checkout(repo);
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
diff --git a/builtin/clone.c b/builtin/clone.c
index 91b9cd0d16..ba25e58258 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -621,7 +621,7 @@ static int git_sparse_checkout_init(const char *repo)
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
-	core_apply_sparse_checkout = 1;
+	repo_settings_set_sparse_checkout(the_repository, 1);
 
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
index 07548fe96a..95d24843d9 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -572,7 +572,7 @@ int cmd_mv(int argc,
 		rename_index_entry_at(the_repository->index, pos, dst);
 
 		if (ignore_sparse &&
-		    core_apply_sparse_checkout &&
+		    repo_settings_get_sparse_checkout(the_repository) &&
 		    core_sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1bf01591b2..662858b0a8 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -62,7 +62,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 	int res;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo_settings_get_sparse_checkout(the_repository))
 		die(_("this worktree is not sparse"));
 
 	argc = parse_options(argc, argv, prefix,
@@ -397,11 +397,11 @@ static int set_config(enum sparse_checkout_mode mode)
 
 static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 	/* If not specified, use previous definition of cone mode */
-	if (*cone_mode == -1 && core_apply_sparse_checkout)
+	if (*cone_mode == -1 && repo_settings_get_sparse_checkout(the_repository))
 		*cone_mode = core_sparse_checkout_cone;
 
 	/* Set cone/non-cone mode appropriately */
-	core_apply_sparse_checkout = 1;
+	repo_settings_set_sparse_checkout(the_repository, 1);
 	if (*cone_mode == 1 || *cone_mode == -1) {
 		core_sparse_checkout_cone = 1;
 		return MODE_CONE_PATTERNS;
@@ -415,7 +415,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 	int mode, record_mode;
 
 	/* Determine if we need to record the mode; ensure sparse checkout on */
-	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
+	record_mode = (*cone_mode != -1) || !repo_settings_get_sparse_checkout(the_repository);
 
 	mode = update_cone_mode(cone_mode);
 	if (record_mode && set_config(mode))
@@ -695,9 +695,9 @@ static int modify_pattern_list(struct strvec *args, int use_stdin,
 		break;
 	}
 
-	if (!core_apply_sparse_checkout) {
+	if (!repo_settings_get_sparse_checkout(the_repository)) {
 		set_config(MODE_ALL_PATTERNS);
-		core_apply_sparse_checkout = 1;
+		repo_settings_set_sparse_checkout(the_repository, 1);
 		changed_config = 1;
 	}
 
@@ -793,7 +793,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo_settings_get_sparse_checkout(the_repository))
 		die(_("no sparse-checkout to add to"));
 
 	repo_read_index(the_repository);
@@ -902,7 +902,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo_settings_get_sparse_checkout(the_repository))
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
+	repo_settings_set_sparse_checkout(the_repository, 1);
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 88a36ea9f8..590bec334f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -536,7 +536,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * If the current worktree has sparse-checkout enabled, then copy
 	 * the sparse-checkout patterns from the current worktree.
 	 */
-	if (core_apply_sparse_checkout)
+	if (repo_settings_get_sparse_checkout(the_repository))
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
index a374972b62..323017e7a5 100644
--- a/dir.c
+++ b/dir.c
@@ -1503,7 +1503,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 int init_sparse_checkout_patterns(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout)
+	if (!repo_settings_get_sparse_checkout(the_repository))
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
index 4129f8fb2b..e11201e25b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -81,6 +81,7 @@ void prepare_repo_settings(struct repository *r)
 		      &r->settings.pack_use_bitmap_boundary_traversal,
 		      r->settings.pack_use_bitmap_boundary_traversal);
 	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
+	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.sparse_checkout, 0);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
@@ -227,3 +228,15 @@ void repo_settings_reset_shared_repository(struct repository *repo)
 {
 	repo->settings.shared_repository_initialized = 0;
 }
+
+int repo_settings_get_sparse_checkout(struct repository *repo)
+{
+	prepare_repo_settings(repo);
+	return repo->settings.sparse_checkout;
+}
+
+void repo_settings_set_sparse_checkout(struct repository *repo, int value)
+{
+	prepare_repo_settings(repo);
+	repo->settings.sparse_checkout = value;
+}
diff --git a/repo-settings.h b/repo-settings.h
index 2bf24b2597..0d181e3f21 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -67,6 +67,7 @@ struct repo_settings {
 	unsigned long big_file_threshold;
 
 	char *hooks_path;
+	int sparse_checkout;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
@@ -98,4 +99,8 @@ int repo_settings_get_shared_repository(struct repository *repo);
 void repo_settings_set_shared_repository(struct repository *repo, int value);
 void repo_settings_reset_shared_repository(struct repository *repo);
 
+/* Read or set the value for "core.sparseCheckout". */
+int repo_settings_get_sparse_checkout(struct repository *repo);
+void repo_settings_set_sparse_checkout(struct repository *repo, int value);
+
 #endif /* REPO_SETTINGS_H */
diff --git a/sparse-index.c b/sparse-index.c
index 5634abafaa..1bedb35001 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -150,7 +150,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	if (!repo_settings_get_sparse_checkout(istate->repo) || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
@@ -668,7 +668,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout ||
+	if (!repo_settings_get_sparse_checkout(istate->repo) ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 471837f032..c8eba27e5f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->prefix)
 		update_sparsity_for_prefix(o->prefix, o->src_index);
 
-	if (!core_apply_sparse_checkout || !o->update)
+	if (!repo_settings_get_sparse_checkout(repo) || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
diff --git a/wt-status.c b/wt-status.c
index 454601afa1..004f2945b7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1773,7 +1773,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 	int skip_worktree = 0;
 	int i;
 
-	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
+	if (!repo_settings_get_sparse_checkout(r) || r->index->cache_nr == 0) {
 		/*
 		 * Don't compute percentage of checked out files if we
 		 * aren't in a sparse checkout or would get division by 0.

-- 
2.49.0

