Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C12EA49B
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162061; cv=none; b=FharEJW65taujRHy6elgZmjIAii8NAbQQPdawSoo6hMjl+m7ZszBhG49HxSaCNYADaLy7+Lp1p71/nbEG71kE1hNll1kiGYXQOzqOYcq6tWwOWTc+szi98vlngpAiGa1yGhTbnhVGUm4mXGSdJ5zH6ucH494J4mM2+35CybnRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162061; c=relaxed/simple;
	bh=JGMnAcH9VQwiG3atrAcnVMUE0UmOQ8+sbULqibF9iho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEnNVFimrmiuM/xuvh2/tQBWhvqrGVWXQTqRn98QtabWu9uoHXcZLlFShaGLTZ9EtrCwOmkizbMmcmg8yO1yQrUKbOZgQXu8wmqueP6NV165jwOqLJ1k3GRLPBmjBYQSkZMORbb15NqJH38T2TIgGEV0mgjMBSBl8eU1mElhAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHJWqSKs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHJWqSKs"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748d982e92cso212762b3a.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750162058; x=1750766858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNsyzRz0zzgXQAhMQQyB5FbiHfNQjOTh6gyrbFSeDZ8=;
        b=jHJWqSKsX+83l/sIzp9RMHFh+7aH33MIsJUEPtJSDyggK2bS+grfDJqJd1ickPuKyf
         TCX3mvBSk8nsR2ANDSeAD5IV7l3GWr5w1sqWCdhy+EpHO+if8+ogjHJMDmBr9o0FEjcU
         8yXbP8CE2dygBpo9AuYCI5UuwY/mlUDa5Hb4x/HTThHXjrmkfJuCl96kfIbR7BOjUc4K
         ZbRZIBEtvD58vzHSamWDR9J1JongVFtEo/wj8atlehkcB+m03yQLxm4Fdkg7BSWo/LBl
         GWgsWWkofjTDvI2vV5DewuhA+kKlBb9hGcPCO88PxIy5lP1y9P6tLlD6DBkT9tBMiB1J
         uBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162058; x=1750766858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNsyzRz0zzgXQAhMQQyB5FbiHfNQjOTh6gyrbFSeDZ8=;
        b=LLcWHN9wM3CCFHIb3XIV/lWBl5faH4fixYF09gbCL2RKtZfjsSzS4GQyNpyA8RwrPq
         kdc7qDXLBoaJ1fd/mlj15lj8PsK46BBP6Rahex4xAn9Mrn8w2AXr6T2KkmnLD36rU4uU
         Ed6Xor/ERbQ7wGaPxc3yakpPw73pPJPKiE5m461n4swVdFhZHbcdqXL7/qODoVBKnGs8
         5jM5OUZqHyrLeKdPY3j+7p+4g4ocGiNSMM7DVb+Jn2abHOqLLNTnB+2okbzwwzh2geni
         Alf42SQJ/l5pPS6NmvVax0gLo2Q7fnEDmItaKlKKTXq0ij797p6ICul2oA4j0+oiikUE
         0oSg==
X-Forwarded-Encrypted: i=1; AJvYcCXcfKuOfj3auxIshTFE0Wd+VpE2YFgd/jPrwj5V7pfFvExDq1AWoKsK58gX0HKY6neRgQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDT0dRjkZCrMIhXQqkIjxvVVBm7zmPyOaFbSwvlV1JrPbEEAm
	kSKqPnxpGV/SIGaYk6rSJgYtpCY5PB+TtXVbUA2WJWDx9C+zMJLqTlP0ktQ6CEq++fU=
X-Gm-Gg: ASbGncsJOzN+5WBWuIiWpSMLQqXIg/Idk3qpjdqhXMFF4xALVPa11ABfaJKSrP1Syan
	utFsX8JQ0+xwD/rATr0NIralvislbuNTy6NGVxv/9MKpsawfMWBXv/JNBbjU/M9NFkahmQEkpge
	jsECNG+i/a21eFVBCLNdFhC7UsXIUB6LX7pKWkvJ7xF5Jx120XSqaZJJxcxgy0ipCyJi1sh5U1F
	v+lfH1iISJPLKm4XjvOybr4uFDcnrXRVRBpzBPuGNbxGznumnpywOxy3ZlTZ6p2axKYVfPbfnjk
	mM8/2t10GyQ89v88kcOck80NqmMNwgEqZLN+4p+nmVgqpFAR+YmZV9NRyV2AoCl26OiKHn+QaBy
	rxmlX
X-Google-Smtp-Source: AGHT+IHZKalx9GRPet1Bjh63OMfOUpsnzRD7BWMieXi0/8gqwnyuMHzqyAloZerW6L0s4QxDTjkMLA==
X-Received: by 2002:a05:6a00:806:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-7489cfdce76mr19830382b3a.21.1750162058345;
        Tue, 17 Jun 2025 05:07:38 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c96:a38d:5480:e4eb:2835:b445])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffed0c2sm8623333b3a.22.2025.06.17.05.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:07:38 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v4 0/3] environment: remove sparse-checkout related global variables
Date: Tue, 17 Jun 2025 17:36:33 +0530
Message-ID: <cover.1750157825.git.ayu.chandekar@gmail.com>
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

This patch series aims to remove global variables related to sparse-checkout from the global scope and to remove the definition '#define USE_THE_REPOSITORY_VARIABLE' from a few files.

It contains three patches:

1 - Remove the global variable 'core_apply_sparse_checkout' and move its setting to the 'struct repo_settings'. Also remove the definition '#define USE_THE_REPOSITORY_VARIABLE' from "builtin/backfill.c".

2 - Remove the global variable 'core_sparse_checkout_cone' and move its setting to the 'struct repo_settings'.

3 - Remove the global variable 'sparse_expect_files_outside_of_patterns` and localize it in the function which calls it. Also remove the definition '#define USE_THE_REPOSITORY_VARIABLE' from "sparse-index.c"

As Junio suggested while reviewing v3 patch, I removed the getter and setter functions for the 'core.sparsecheckout' settings. After making this change, I realized the other sparse-checkout-related global variables could be cleaned up as well, leading to the addition of two new patches in this series.

Ayush Chandekar (3):
  environment: move access to "core.sparsecheckout" into
    repo_settings
  environment: move access to "core.sparsecheckoutcone" into
    repo_settings
  environment: remove the global variable
    'sparse_expect_files_outside_of_patterns'

 builtin/backfill.c        |  7 ++----
 builtin/clone.c           |  2 +-
 builtin/grep.c            |  4 ++--
 builtin/mv.c              |  4 ++--
 builtin/sparse-checkout.c | 48 +++++++++++++++++++--------------------
 builtin/worktree.c        |  2 +-
 config.c                  | 24 --------------------
 dir.c                     |  4 ++--
 environment.c             |  3 ---
 environment.h             |  4 ----
 repo-settings.c           |  2 ++
 repo-settings.h           |  3 +++
 sparse-index.c            |  8 ++++---
 unpack-trees.c            |  2 +-
 wt-status.c               |  2 +-
 15 files changed, 46 insertions(+), 73 deletions(-)

-- 

Summary of the range-diff:
* Removed the getter and setter functions for the core.sparseCheckout setting. Instead, it is now initialized once in 'prepare_repo_settings()' and accessed directly, since it is commonly used.
* Added two new commits to eliminate the global variables 'core_sparse_checkout_cone' and 'sparse_expect_files_outside_of_patterns'.

Range-diff vs v3:
 1:  c49dcde03b ! 30:  e221c68ab5 environment: move access to "core.sparsecheckout" into repo_settings
    @@ Commit message
         The setting "core.sparsecheckout" is stored in the global
         `core_apply_sparse_checkout` and is populated in config.c. Refactor the
         code to store it in the variable `sparse_checkout` in the struct
    -    `repo_settings`. Also, create functions to set and get the value of the
    -    setting and update all the occurrences.
    +    `repo_settings`.
    +    It's fine not to lazily load it from the config, as the variable
    +    is used quite commonly.
     
         This also allows us to remove the definition `#define
         USE_THE_REPOSITORY_VARIABLE` from the file 'builtin/backfill.c'.
    @@ builtin/backfill.c
      #include "git-compat-util.h"
      #include "config.h"
     @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
    - 	repo_config(repo, git_default_config, NULL);
    + 			     0);
      
    + 	repo_config(repo, git_default_config, NULL);
    +-
    ++	prepare_repo_settings(repo);
      	if (ctx.sparse < 0)
     -		ctx.sparse = core_apply_sparse_checkout;
    -+		ctx.sparse = repo_settings_get_sparse_checkout(repo);
    ++		ctx.sparse = repo->settings.sparse_checkout;
      
      	result = do_backfill(&ctx);
      	backfill_context_clear(&ctx);
    @@ builtin/clone.c: static int git_sparse_checkout_init(const char *repo)
      	 * for the later checkout to use the sparse-checkout file.
      	 */
     -	core_apply_sparse_checkout = 1;
    -+	repo_settings_set_sparse_checkout(the_repository, 1);
    ++	the_repository->settings.sparse_checkout = 1;
      
      	cmd.git_cmd = 1;
      	if (run_command(&cmd)) {
    @@ builtin/mv.c: int cmd_mv(int argc,
      
      		if (ignore_sparse &&
     -		    core_apply_sparse_checkout &&
    -+		    repo_settings_get_sparse_checkout(the_repository) &&
    ++		    the_repository->settings.sparse_checkout &&
      		    core_sparse_checkout_cone) {
      			/*
      			 * NEEDSWORK: we are *not* paying attention to
    @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo_settings_get_sparse_checkout(the_repository))
    ++	if (!the_repository->settings.sparse_checkout)
      		die(_("this worktree is not sparse"));
      
      	argc = parse_options(argc, argv, prefix,
    @@ builtin/sparse-checkout.c: static int set_config(enum sparse_checkout_mode mode)
      static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
      	/* If not specified, use previous definition of cone mode */
     -	if (*cone_mode == -1 && core_apply_sparse_checkout)
    -+	if (*cone_mode == -1 && repo_settings_get_sparse_checkout(the_repository))
    ++	if (*cone_mode == -1 && the_repository->settings.sparse_checkout)
      		*cone_mode = core_sparse_checkout_cone;
      
      	/* Set cone/non-cone mode appropriately */
     -	core_apply_sparse_checkout = 1;
    -+	repo_settings_set_sparse_checkout(the_repository, 1);
    ++	the_repository->settings.sparse_checkout = 1;
      	if (*cone_mode == 1 || *cone_mode == -1) {
      		core_sparse_checkout_cone = 1;
      		return MODE_CONE_PATTERNS;
    @@ builtin/sparse-checkout.c: static int update_modes(int *cone_mode, int *sparse_i
      
      	/* Determine if we need to record the mode; ensure sparse checkout on */
     -	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
    -+	record_mode = (*cone_mode != -1) || !repo_settings_get_sparse_checkout(the_repository);
    ++	record_mode = (*cone_mode != -1) || !the_repository->settings.sparse_checkout;
      
      	mode = update_cone_mode(cone_mode);
      	if (record_mode && set_config(mode))
    @@ builtin/sparse-checkout.c: static int modify_pattern_list(struct strvec *args, i
      	}
      
     -	if (!core_apply_sparse_checkout) {
    -+	if (!repo_settings_get_sparse_checkout(the_repository)) {
    ++	if (!the_repository->settings.sparse_checkout) {
      		set_config(MODE_ALL_PATTERNS);
     -		core_apply_sparse_checkout = 1;
    -+		repo_settings_set_sparse_checkout(the_repository, 1);
    ++		the_repository->settings.sparse_checkout = 1;
      		changed_config = 1;
      	}
      
    @@ builtin/sparse-checkout.c: static int sparse_checkout_add(int argc, const char *
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo_settings_get_sparse_checkout(the_repository))
    ++	if (!the_repository->settings.sparse_checkout)
      		die(_("no sparse-checkout to add to"));
      
      	repo_read_index(the_repository);
    @@ builtin/sparse-checkout.c: static int sparse_checkout_reapply(int argc, const ch
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo_settings_get_sparse_checkout(the_repository))
    ++	if (!the_repository->settings.sparse_checkout)
      		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
      
      	reapply_opts.cone_mode = -1;
    @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
      	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
      	pl.use_cone_patterns = 0;
     -	core_apply_sparse_checkout = 1;
    -+	repo_settings_set_sparse_checkout(the_repository, 1);
    ++	the_repository->settings.sparse_checkout = 1;
      
      	add_pattern("/*", empty_base, 0, &pl, 0);
      
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      	 * the sparse-checkout patterns from the current worktree.
      	 */
     -	if (core_apply_sparse_checkout)
    -+	if (repo_settings_get_sparse_checkout(the_repository))
    ++	if (the_repository->settings.sparse_checkout)
      		copy_sparse_checkout(sb_repo.buf);
      
      	/*
    @@ dir.c: enum pattern_match_result path_matches_pattern_list(
      int init_sparse_checkout_patterns(struct index_state *istate)
      {
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo_settings_get_sparse_checkout(the_repository))
    ++	if (!istate->repo->settings.sparse_checkout)
      		return 1;
      	if (istate->sparse_checkout_patterns)
      		return 0;
    @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
      
      	/*
      	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
    -@@ repo-settings.c: void repo_settings_reset_shared_repository(struct repository *repo)
    - {
    - 	repo->settings.shared_repository_initialized = 0;
    - }
    -+
    -+int repo_settings_get_sparse_checkout(struct repository *repo)
    -+{
    -+	prepare_repo_settings(repo);
    -+	return repo->settings.sparse_checkout;
    -+}
    -+
    -+void repo_settings_set_sparse_checkout(struct repository *repo, int value)
    -+{
    -+	prepare_repo_settings(repo);
    -+	repo->settings.sparse_checkout = value;
    -+}
     
      ## repo-settings.h ##
     @@ repo-settings.h: struct repo_settings {
    @@ repo-settings.h: struct repo_settings {
      };
      #define REPO_SETTINGS_INIT { \
      	.shared_repository = -1, \
    -@@ repo-settings.h: int repo_settings_get_shared_repository(struct repository *repo);
    - void repo_settings_set_shared_repository(struct repository *repo, int value);
    - void repo_settings_reset_shared_repository(struct repository *repo);
    - 
    -+/* Read or set the value for "core.sparseCheckout". */
    -+int repo_settings_get_sparse_checkout(struct repository *repo);
    -+void repo_settings_set_sparse_checkout(struct repository *repo, int value);
    -+
    - #endif /* REPO_SETTINGS_H */
     
      ## sparse-index.c ##
     @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate)
    @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
      int is_sparse_index_allowed(struct index_state *istate, int flags)
      {
     -	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
    -+	if (!repo_settings_get_sparse_checkout(istate->repo) || !core_sparse_checkout_cone)
    ++	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
      		return 0;
      
      	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
    @@ sparse-index.c: static void clear_skip_worktree_from_present_files_full(struct i
      void clear_skip_worktree_from_present_files(struct index_state *istate)
      {
     -	if (!core_apply_sparse_checkout ||
    -+	if (!repo_settings_get_sparse_checkout(istate->repo) ||
    ++	if (!istate->repo->settings.sparse_checkout ||
      	    sparse_expect_files_outside_of_patterns)
      		return;
      
    @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpac
      		update_sparsity_for_prefix(o->prefix, o->src_index);
      
     -	if (!core_apply_sparse_checkout || !o->update)
    -+	if (!repo_settings_get_sparse_checkout(repo) || !o->update)
    ++	if (!repo->settings.sparse_checkout || !o->update)
      		o->skip_sparse_checkout = 1;
      	if (!o->skip_sparse_checkout) {
      		memset(&pl, 0, sizeof(pl));
    @@ wt-status.c: static void wt_status_check_sparse_checkout(struct repository *r,
      	int i;
      
     -	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
    -+	if (!repo_settings_get_sparse_checkout(r) || r->index->cache_nr == 0) {
    ++	if (!r->settings.sparse_checkout || r->index->cache_nr == 0) {
      		/*
      		 * Don't compute percentage of checked out files if we
      		 * aren't in a sparse checkout or would get division by 0.
 -:  ---------- > 31:  9a63884341 environment: move access to "core.sparsecheckoutcone" into repo_settings
 -:  ---------- > 32:  a9e1e23685 environment: remove the global variable 'sparse_expect_files_outside_of_patterns'


2.49.0

