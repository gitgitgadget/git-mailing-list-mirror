Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA962DA768
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973607; cv=none; b=f1V1MfOxWxSLXmZHiu5ceZNFUzCjONUFfcn0Xgxfo1C88Qg61LzWEYLmGw5iNhSnga2Hy2Z/Z2MsIFdz5+MInSaeVDSOLp7FLRbFsLhTGZRPd8V0id3uzzgSSZnoh/18BqiaDuzN6pS5xx6s8exOS/0XIw1bu+WjhE2SxhMJ/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973607; c=relaxed/simple;
	bh=uHOsiNseNo34ctXXJuDPtJp2RmwOG8OL6SAVLlAzCq4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SBAICvo42cCnHuXqh+TDk5WFs1fcx1ezznHXBtY4k2xLSHyGPSi86AVo2vLHScDvgQNClWY0D97TAYmTyYs4D/XWUAbPf5sjztY9cUcDzXB+LU5qnoACs5s7FIQEUxty/xW1jEAG0wbjrvBNltwkucziNMVUDIUNKlZVxvzZQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWtFBLh/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWtFBLh/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso36341755e9.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751973603; x=1752578403; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDIP1OJGx2aXGYdc889gDZX0gIFPbn8UlFMFKh4TTho=;
        b=FWtFBLh/5UQSF91ncFSpzImiUZGhO6Z4KKpn/pH/hE4IHyA5HhfTerPcH1enhO5eUu
         lUgnwQ0pC+612OpgjLxCMdy+qCFjyWKJCPa8U3WBPNo8NvyW4Nctne26fxzumbLUy9dK
         z7PVjQtxWzrH4Q8K52Ly5R6ErQZXs0aKmkbp/Uj/GJFKRXo0m7aQjzNePp7xDXXxhAoA
         fjTnMuukT7hkl7eNBtvqIRVfr8GnW+TuYLZmVYQXegaKQj4/nl2DUFl9wQaAdb2bi/gO
         1LXCjcdUl2foWowuNOfRGm7pdBRLLpuHTH/5f13YO3NsR0l38aoH/DzkihCD2BE68Zan
         dMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973603; x=1752578403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDIP1OJGx2aXGYdc889gDZX0gIFPbn8UlFMFKh4TTho=;
        b=sF7/pMjmAh/nDCFHQe4zi8+6y4m+b46BVOKFxoQ91rTgFt4FaGhJVTCiC+0DiiUtYY
         KTdtNLiIKU3tRN72C1jVUHmEMQORuE5/zLJVI7LVM4q9eTf1vLJIYK6Q4UwyPY1S9zfZ
         lTEKIfIlTTIOHDvDRa42EkcjmouwALDRYKRaGCUrgulj/cwTyT6M2qe+bwD1xufhW46v
         7elkhfJwwp/M3IOOwLsDr6YkXXywob+gpsssyeDeqmwUHf/ndPoY2ZIyfnw9g4GW0uMU
         HHbdHXp1ooisrIseShsuMV6mAebbvUg6mQzW7VSnHMk7zwns4FQTeblqS8w6YY4RdwG1
         yA6Q==
X-Gm-Message-State: AOJu0YyszRZrG04aWaRPYoVe5IStEn+KU7r3g5vs79DcRmwNn5rrCktQ
	f0+Mk8uz+8OLxcBWzTTXUIu5riVM7JqeK/vDrbndIN1ch4Rw2lLk+UeFNmP6yQ==
X-Gm-Gg: ASbGnctBuhdRE9Fa24NfWCdlA3O3sF9d75i8PlmYxLhBvmfs3byxsFJw1Y25JugYEbe
	qPzVoIW0H40wPXUsxudgmiw7tE7NaqrQBe557FKnhPxIuOy9hbto+/hxQY0dVQkQKA6IbSMnPxD
	yq3tX1tCoAPKnnbS3aVoou87hKaPk9xHx33TOBXky92KHRAdmfrZldFiPCL0HN2AlHAHyGMC5Tx
	LNnFPKc1QPf0nVPSAjzS4jLHeIqZqWTawudXjV8AUFWe5lAr5OqEJoFok9hRQciPXnUuSJx7icq
	rLX+3EMz5IgWXduvoccymtQMnmzEpiOKkfW6DWfRlYbL2ffX70zV2fpcU5In6B0=
X-Google-Smtp-Source: AGHT+IE+7iivugtkw/U05BRz2TsNahFnRV4Ct0m5QOcSZR4b9qADAWWIeWA0BKmrFOUucS0nH6YXtA==
X-Received: by 2002:a05:600c:83c4:b0:450:d04e:22d6 with SMTP id 5b1f17b1804b1-454b4e6bbdcmr143305945e9.7.1751973602208;
        Tue, 08 Jul 2025 04:20:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d7d44sm19723615e9.30.2025.07.08.04.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:19:59 -0700 (PDT)
Message-Id: <3cdc44a9e8c8e6718b24bc25def291348a0b2613.1751973594.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Jul 2025 11:19:51 +0000
Subject: [PATCH 1/3] sparse-checkout: remove use of the_repository
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The logic for the 'git sparse-checkout' builtin uses the_repository all
over the place, despite some use of a repository struct in different
method parameters. Complete this removal of the_repository by using
'repo' when possible.

In one place, there was already a local variable 'r' that was set to
the_repository, so move that to a method parameter.

We cannot remove the USE_THE_REPOSITORY_VARIABLE declaration as we are
still using global constants for the state of the sparse-checkout.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/sparse-checkout.c | 119 ++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 56 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1bf01591b275..8b70d0c6a441 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -204,12 +204,12 @@ static void clean_tracked_sparse_directories(struct repository *r)
 		ensure_full_index(r->index);
 }
 
-static int update_working_directory(struct pattern_list *pl)
+static int update_working_directory(struct repository *r,
+				    struct pattern_list *pl)
 {
 	enum update_sparsity_result result;
 	struct unpack_trees_options o;
 	struct lock_file lock_file = LOCK_INIT;
-	struct repository *r = the_repository;
 	struct pattern_list *old_pl;
 
 	/* If no branch has been checked out, there are no updates to make. */
@@ -327,7 +327,8 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	string_list_clear(&sl, 0);
 }
 
-static int write_patterns_and_update(struct pattern_list *pl)
+static int write_patterns_and_update(struct repository *repo,
+				     struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
@@ -336,15 +337,15 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
 	sparse_filename = get_sparse_checkout_filename();
 
-	if (safe_create_leading_directories(the_repository, sparse_filename))
+	if (safe_create_leading_directories(repo, sparse_filename))
 		die(_("failed to create directory for sparse-checkout file"));
 
 	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
 
-	result = update_working_directory(pl);
+	result = update_working_directory(repo, pl);
 	if (result) {
 		rollback_lock_file(&lk);
-		update_working_directory(NULL);
+		update_working_directory(repo, NULL);
 		goto out;
 	}
 
@@ -372,25 +373,26 @@ enum sparse_checkout_mode {
 	MODE_CONE_PATTERNS = 2,
 };
 
-static int set_config(enum sparse_checkout_mode mode)
+static int set_config(struct repository *repo,
+		      enum sparse_checkout_mode mode)
 {
 	/* Update to use worktree config, if not already. */
-	if (init_worktree_config(the_repository)) {
+	if (init_worktree_config(repo)) {
 		error(_("failed to initialize worktree config"));
 		return 1;
 	}
 
-	if (repo_config_set_worktree_gently(the_repository,
+	if (repo_config_set_worktree_gently(repo,
 					    "core.sparseCheckout",
 					    mode ? "true" : "false") ||
-	    repo_config_set_worktree_gently(the_repository,
+	    repo_config_set_worktree_gently(repo,
 					    "core.sparseCheckoutCone",
 					    mode == MODE_CONE_PATTERNS ?
 						"true" : "false"))
 		return 1;
 
 	if (mode == MODE_NO_PATTERNS)
-		return set_sparse_index_config(the_repository, 0);
+		return set_sparse_index_config(repo, 0);
 
 	return 0;
 }
@@ -410,7 +412,7 @@ static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 	return MODE_ALL_PATTERNS;
 }
 
-static int update_modes(int *cone_mode, int *sparse_index)
+static int update_modes(struct repository *repo, int *cone_mode, int *sparse_index)
 {
 	int mode, record_mode;
 
@@ -418,20 +420,20 @@ static int update_modes(int *cone_mode, int *sparse_index)
 	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
 
 	mode = update_cone_mode(cone_mode);
-	if (record_mode && set_config(mode))
+	if (record_mode && set_config(repo, mode))
 		return 1;
 
 	/* Set sparse-index/non-sparse-index mode if specified */
 	if (*sparse_index >= 0) {
-		if (set_sparse_index_config(the_repository, *sparse_index) < 0)
+		if (set_sparse_index_config(repo, *sparse_index) < 0)
 			die(_("failed to modify sparse-index config"));
 
 		/* force an index rewrite */
-		repo_read_index(the_repository);
-		the_repository->index->updated_workdir = 1;
+		repo_read_index(repo);
+		repo->index->updated_workdir = 1;
 
 		if (!*sparse_index)
-			ensure_full_index(the_repository->index);
+			ensure_full_index(repo->index);
 	}
 
 	return 0;
@@ -448,7 +450,7 @@ static struct sparse_checkout_init_opts {
 } init_opts;
 
 static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
-				struct repository *repo UNUSED)
+				struct repository *repo)
 {
 	struct pattern_list pl;
 	char *sparse_filename;
@@ -464,7 +466,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
 	};
 
 	setup_work_tree();
-	repo_read_index(the_repository);
+	repo_read_index(repo);
 
 	init_opts.cone_mode = -1;
 	init_opts.sparse_index = -1;
@@ -473,7 +475,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
 
-	if (update_modes(&init_opts.cone_mode, &init_opts.sparse_index))
+	if (update_modes(repo, &init_opts.cone_mode, &init_opts.sparse_index))
 		return 1;
 
 	memset(&pl, 0, sizeof(pl));
@@ -485,14 +487,14 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
 	if (res >= 0) {
 		free(sparse_filename);
 		clear_pattern_list(&pl);
-		return update_working_directory(NULL);
+		return update_working_directory(repo, NULL);
 	}
 
-	if (repo_get_oid(the_repository, "HEAD", &oid)) {
+	if (repo_get_oid(repo, "HEAD", &oid)) {
 		FILE *fp;
 
 		/* assume we are in a fresh repo, but update the sparse-checkout file */
-		if (safe_create_leading_directories(the_repository, sparse_filename))
+		if (safe_create_leading_directories(repo, sparse_filename))
 			die(_("unable to create leading directories of %s"),
 			    sparse_filename);
 		fp = xfopen(sparse_filename, "w");
@@ -511,7 +513,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
 	add_pattern("!/*/", empty_base, 0, &pl, 0);
 	pl.use_cone_patterns = init_opts.cone_mode;
 
-	return write_patterns_and_update(&pl);
+	return write_patterns_and_update(repo, &pl);
 }
 
 static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
@@ -674,7 +676,8 @@ static void add_patterns_literal(int argc, const char **argv,
 	add_patterns_from_input(pl, argc, argv, use_stdin ? stdin : NULL);
 }
 
-static int modify_pattern_list(struct strvec *args, int use_stdin,
+static int modify_pattern_list(struct repository *repo,
+			       struct strvec *args, int use_stdin,
 			       enum modify_type m)
 {
 	int result;
@@ -696,22 +699,23 @@ static int modify_pattern_list(struct strvec *args, int use_stdin,
 	}
 
 	if (!core_apply_sparse_checkout) {
-		set_config(MODE_ALL_PATTERNS);
+		set_config(repo, MODE_ALL_PATTERNS);
 		core_apply_sparse_checkout = 1;
 		changed_config = 1;
 	}
 
-	result = write_patterns_and_update(pl);
+	result = write_patterns_and_update(repo, pl);
 
 	if (result && changed_config)
-		set_config(MODE_NO_PATTERNS);
+		set_config(repo, MODE_NO_PATTERNS);
 
 	clear_pattern_list(pl);
 	free(pl);
 	return result;
 }
 
-static void sanitize_paths(struct strvec *args,
+static void sanitize_paths(struct repository *repo,
+			   struct strvec *args,
 			   const char *prefix, int skip_checks)
 {
 	int i;
@@ -752,7 +756,7 @@ static void sanitize_paths(struct strvec *args,
 
 	for (i = 0; i < args->nr; i++) {
 		struct cache_entry *ce;
-		struct index_state *index = the_repository->index;
+		struct index_state *index = repo->index;
 		int pos = index_name_pos(index, args->v[i], strlen(args->v[i]));
 
 		if (pos < 0)
@@ -779,7 +783,7 @@ static struct sparse_checkout_add_opts {
 } add_opts;
 
 static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
-			       struct repository *repo UNUSED)
+			       struct repository *repo)
 {
 	static struct option builtin_sparse_checkout_add_options[] = {
 		OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
@@ -796,7 +800,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 	if (!core_apply_sparse_checkout)
 		die(_("no sparse-checkout to add to"));
 
-	repo_read_index(the_repository);
+	repo_read_index(repo);
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_add_options,
@@ -804,9 +808,9 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 
 	for (int i = 0; i < argc; i++)
 		strvec_push(&patterns, argv[i]);
-	sanitize_paths(&patterns, prefix, add_opts.skip_checks);
+	sanitize_paths(repo, &patterns, prefix, add_opts.skip_checks);
 
-	ret = modify_pattern_list(&patterns, add_opts.use_stdin, ADD);
+	ret = modify_pattern_list(repo, &patterns, add_opts.use_stdin, ADD);
 
 	strvec_clear(&patterns);
 	return ret;
@@ -825,7 +829,7 @@ static struct sparse_checkout_set_opts {
 } set_opts;
 
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
-			       struct repository *repo UNUSED)
+			       struct repository *repo)
 {
 	int default_patterns_nr = 2;
 	const char *default_patterns[] = {"/*", "!/*/", NULL};
@@ -847,7 +851,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	setup_work_tree();
-	repo_read_index(the_repository);
+	repo_read_index(repo);
 
 	set_opts.cone_mode = -1;
 	set_opts.sparse_index = -1;
@@ -856,7 +860,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 			     builtin_sparse_checkout_set_options,
 			     builtin_sparse_checkout_set_usage, 0);
 
-	if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
+	if (update_modes(repo, &set_opts.cone_mode, &set_opts.sparse_index))
 		return 1;
 
 	/*
@@ -870,10 +874,10 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	} else {
 		for (int i = 0; i < argc; i++)
 			strvec_push(&patterns, argv[i]);
-		sanitize_paths(&patterns, prefix, set_opts.skip_checks);
+		sanitize_paths(repo, &patterns, prefix, set_opts.skip_checks);
 	}
 
-	ret = modify_pattern_list(&patterns, set_opts.use_stdin, REPLACE);
+	ret = modify_pattern_list(repo, &patterns, set_opts.use_stdin, REPLACE);
 
 	strvec_clear(&patterns);
 	return ret;
@@ -891,7 +895,7 @@ static struct sparse_checkout_reapply_opts {
 
 static int sparse_checkout_reapply(int argc, const char **argv,
 				   const char *prefix,
-				   struct repository *repo UNUSED)
+				   struct repository *repo)
 {
 	static struct option builtin_sparse_checkout_reapply_options[] = {
 		OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
@@ -912,12 +916,12 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 			     builtin_sparse_checkout_reapply_options,
 			     builtin_sparse_checkout_reapply_usage, 0);
 
-	repo_read_index(the_repository);
+	repo_read_index(repo);
 
-	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
+	if (update_modes(repo, &reapply_opts.cone_mode, &reapply_opts.sparse_index))
 		return 1;
 
-	return update_working_directory(NULL);
+	return update_working_directory(repo, NULL);
 }
 
 static char const * const builtin_sparse_checkout_disable_usage[] = {
@@ -927,7 +931,7 @@ static char const * const builtin_sparse_checkout_disable_usage[] = {
 
 static int sparse_checkout_disable(int argc, const char **argv,
 				   const char *prefix,
-				   struct repository *repo UNUSED)
+				   struct repository *repo)
 {
 	static struct option builtin_sparse_checkout_disable_options[] = {
 		OPT_END(),
@@ -955,7 +959,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	 * are expecting to do that when disabling sparse-checkout.
 	 */
 	give_advice_on_expansion = 0;
-	repo_read_index(the_repository);
+	repo_read_index(repo);
 
 	memset(&pl, 0, sizeof(pl));
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
@@ -965,14 +969,14 @@ static int sparse_checkout_disable(int argc, const char **argv,
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.sparse_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.sparse_index = 0;
 
-	if (update_working_directory(&pl))
+	if (update_working_directory(repo, &pl))
 		die(_("error while refreshing working directory"));
 
 	clear_pattern_list(&pl);
-	return set_config(MODE_NO_PATTERNS);
+	return set_config(repo, MODE_NO_PATTERNS);
 }
 
 static char const * const builtin_sparse_checkout_check_rules_usage[] = {
@@ -987,14 +991,17 @@ static struct sparse_checkout_check_rules_opts {
 	char *rules_file;
 } check_rules_opts;
 
-static int check_rules(struct pattern_list *pl, int null_terminated) {
+static int check_rules(struct repository *repo,
+		       struct pattern_list *pl,
+		       int null_terminated)
+{
 	struct strbuf line = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
 	char *path;
 	int line_terminator = null_terminated ? 0 : '\n';
 	strbuf_getline_fn getline_fn = null_terminated ? strbuf_getline_nul
 		: strbuf_getline;
-	the_repository->index->sparse_checkout_patterns = pl;
+	repo->index->sparse_checkout_patterns = pl;
 	while (!getline_fn(&line, stdin)) {
 		path = line.buf;
 		if (!null_terminated && line.buf[0] == '"') {
@@ -1006,7 +1013,7 @@ static int check_rules(struct pattern_list *pl, int null_terminated) {
 			path = unquoted.buf;
 		}
 
-		if (path_in_sparse_checkout(path, the_repository->index))
+		if (path_in_sparse_checkout(path, repo->index))
 			write_name_quoted(path, stdout, line_terminator);
 	}
 	strbuf_release(&line);
@@ -1016,7 +1023,7 @@ static int check_rules(struct pattern_list *pl, int null_terminated) {
 }
 
 static int sparse_checkout_check_rules(int argc, const char **argv, const char *prefix,
-				       struct repository *repo UNUSED)
+				       struct repository *repo)
 {
 	static struct option builtin_sparse_checkout_check_rules_options[] = {
 		OPT_BOOL('z', NULL, &check_rules_opts.null_termination,
@@ -1055,7 +1062,7 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
 		free(sparse_filename);
 	}
 
-	ret = check_rules(&pl, check_rules_opts.null_termination);
+	ret = check_rules(repo, &pl, check_rules_opts.null_termination);
 	clear_pattern_list(&pl);
 	free(check_rules_opts.rules_file);
 	return ret;
@@ -1084,8 +1091,8 @@ int cmd_sparse_checkout(int argc,
 
 	git_config(git_default_config, NULL);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
 	return fn(argc, argv, prefix, repo);
 }
-- 
gitgitgadget

