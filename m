Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044A2EACFB
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673020; cv=none; b=NdvGVCWQ1tUCDqtyGZo+aKjIH+u9iEoqSNr9EZIbtpbp6hyN8qYzMCUBScT8jI5WhAeZpNCi7psIWOOeac2chtCkHkrt7BBsn3WRJ2haex4Iy0HwDUSKKLQycIHnbFJjE18pt9anIPtGaa+3dugrC8r0eif3+Ok0MC+Khp93B5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673020; c=relaxed/simple;
	bh=GDl8CKicFKHgidqu966uhuyzHqCdFBjOaerrnx0ocwA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FFgNyMihdDwrQxyYswLll9qFqj98mwJVZwEDSeZUChlrfN8U4dZj/HtjMxOdEXyul5Eqgku0Qjb9VfYOC5FLwzstmLcRHluNq1DuzH4xIrbVyXxzkgyid8Y6SpiVSHrMXabUvS5aCjAj8oyOXmgZ7q8TOEvV2fGmIOaRhvPQ6Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwJpL9ru; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwJpL9ru"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32d6c194134so2501626a91.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757673016; x=1758277816; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vfFNTMsU29cFdXusE+Bt2pi6XfCJRGrbduTthrCM78=;
        b=KwJpL9ruUp8INmIKuF+VBUYsfjtms56HJRgi/4zhSfodwsonJOeKREPq7g8zrfjzLj
         wxDjlghHrYu9Tkhz1sj9D/MuIbYKR+CqOALzNxiwmwnHIGlBfcJ1y7wh35I3SVLQEP5q
         WyekbhDYPTfLP1Tz4a6RqjdhB1dA5dy3tHvxgQPXzrB84h42xxvD4zfb3vyENriHXJKf
         Gq7MR35Vv+zrdbNmVyFT210Ch741u+9FWbbNqTGnME3kvuX06Qv3qQNc+CXfZTnFYZmf
         NP4QR9QqGGoOh4t/fZ0+RHGNbR4uoFeNHGgC/+qdFkb9zb56f7AQr+VBEv+5qRvZFZe4
         26ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673016; x=1758277816;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vfFNTMsU29cFdXusE+Bt2pi6XfCJRGrbduTthrCM78=;
        b=C7HzFvtClM24ovVjCM7q3fXTB4OHSllN2Fkt2oAsusswmHa0wu1PdnUt1iYbGu9UXo
         9U7OlKWgWi1J1m79X8GyLyT3Dm/kh/e72lZ3yq07TPzhQVevlWbalzJUe9UxNtua1f6V
         PKr+EGx2NvrMNMM4PUmxjEVJ3WAGPFDXZ1sOLTIv22t+z5aXsYJSiedeqaUtlJZEphON
         upnySnSI94od+VTRYIb9iATB+7o4viitIfyXVYPNDqqlYS6WSw1Bx36NIUA59iOWHulT
         w/U5QbMumbEyxRkFZQX7ibXORzwwBSftjmsbjvkBDWdItF7SLxtubDnN27sJS/abdXf/
         hvag==
X-Gm-Message-State: AOJu0Yy8FDy6YaPqiVC/vCc+oTa17A51jyiChLDbNKaM8mtD6YGGvkvb
	gJ47So3vKN20QHOI4G8EKslOWjxoe4jNORvoZC7xiD+XzVPFsUGiO59lHHbrfA==
X-Gm-Gg: ASbGnctOZKpg10ilUE8JuYr/sSvoBtforsC4txhkyepkX8jbYltfpmtJELWRInlUbmT
	aWt/z6MDDnVBhULmAuZpRHLX69OW1HmZugT2kX1n33BWO5j2fAjEFBE1TeA0qfjiLF6+sfRKNVK
	1zpOBWw9hSaxSGoYOcLOkucxSk8vA6E76S7gcOvREypQCjCMx32KpiJJnMfEzFCHjCMYBLjb2Zw
	RPqR9ECd6CgLIMJV9a2WoOVj1K0HxQhLehFejK9CqVjCOGWlcbWjOHjdZxG+BFW/wI4M9BqBWR8
	goBPdDD+/knAA00juhK6I8dXcxwFmaKT2WmEoet/n89mZup7zxuGXWkcQGbZoMzJFlPiFYlMPPc
	Q22Er4s0+vj5pTqqahb7yw1+5j2KDBMQbFKRlBsymrELLd+fK
X-Google-Smtp-Source: AGHT+IFAZ/hHp21IEZ+sh2QNLoj82DTEZhZ+d4fTa/7OCjjCox2v11Nkh3xUZ1hWSl0lSb48w/Jcyw==
X-Received: by 2002:a17:90b:1651:b0:32d:3895:656b with SMTP id 98e67ed59e1d1-32de4ed5b88mr3218576a91.12.1757673015422;
        Fri, 12 Sep 2025 03:30:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.175.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd620a64dsm5847010a91.8.2025.09.12.03.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:30:14 -0700 (PDT)
Message-Id: <437a57b665786a3d3b5142ce5f79d839decd486f.1757673011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 10:30:05 +0000
Subject: [PATCH v3 1/7] sparse-checkout: remove use of the_repository
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
    Patrick Steinhardt <ps@pks.im>,
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
 builtin/sparse-checkout.c | 117 ++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 55 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8c333b3e2e..06de61bd9d 100644
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
@@ -966,13 +970,13 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
 	prepare_repo_settings(the_repository);
-	the_repository->settings.sparse_index = 0;
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
 
 	repo_config(the_repository, git_default_config, NULL);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
 	return fn(argc, argv, prefix, repo);
 }
-- 
gitgitgadget

