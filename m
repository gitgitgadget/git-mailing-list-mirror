Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298E219EB
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716061; cv=none; b=PcshuUJJmqegFIUdFW8PL48lpV0FVmMc/N+JdFd36EzoXl4cuBCx/xcmB27pFqIKI2+GlGU23ueoHZHY5NEkHj/lMcifBtOaWa3GKQ0ZwNcRoxHFdo9/CSXJPUXDkp2ESqHkwvhJbMmzE317bLkIxQcANyWM0tocbiXVeQ5xeDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716061; c=relaxed/simple;
	bh=zr2GdrThuGPkJnKLetm+ecRqD6jBwx/bU1MKjECBrcI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SAtc73HAhUysfFrKwcp3RiomgUlvOwC70Es8oqao1DOEOytlnPJPnJ2agJDVd0VTw4gEy3F2WsK0BF6dL8msqy/SKH1JpYzZ+rmALcMn/tvxyb/rUAdNO7W6VLROTH2/juy63qrdHL47/t4t2IqB3JteeRGCAZUYHIfb8uNMY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOzrxkPP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOzrxkPP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so4037765e9.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716057; x=1753320857; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0yenRuDArrJOLThn9JK5cYe/iFJDmNxO4g/0Q+uUI8=;
        b=WOzrxkPPNMKwwcWF7/vYfMBOQmwFH6CDHgFvFHW4m1q66iC7VtVupJBTJ1q3lIsBsx
         yOsQXUJyC3Zp3OOwkM2wAvMtLKVlV4mu7bQRnARDy5Xnio+wvf0tOI1+bMosYDOeZdng
         wCKqQ8BXnBAQpcOqncwTkt4+UCHwSD2NQb/N6h5xjklr3vIv/+QOORftdUdykMu7Yzxt
         cd26DsOr0pmvXGho4OrBevWb+SYLHCzwhW7UOk2PmKw/xDim1/rrsUQCHrd1pL7cGGN2
         DcSepdJf6ka7up3e5WhWCcscXbOhMezRuEnwPVcrjlpv3M74GV+55HCNZEEJFr+8NkBx
         dE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716057; x=1753320857;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0yenRuDArrJOLThn9JK5cYe/iFJDmNxO4g/0Q+uUI8=;
        b=hDqMIQzfPxa9VZXRfXn9U6BzQZvlKNzcwZoYBien7stEfH/kZugTdWmOH5QUAHlfmF
         qq7bJ+lFqg8PmQeCZ+hRVd8LVzGYs0ttDJdE+ebYPxiiUaUKd9Gq4h68BeWpuWXMj8pv
         zIH5FsDMzMcTGPVoazmjhFtTTsFtcK1JDAfHwBKsoiuuyMkENFH92ZtGP8zHY/GQk5iP
         LSz55J+M3G2CwGwj8bPEWI8fvEK5Umndn54wmKe/VXLaq0B6zv0/bPaBf2L6OaGImLOE
         4av/aAT4fHgfsJwO+9h+XBaZXKey5oZ+eEdmUBoyeVGssWW6NzgFw0fJfOGAJ7tTXGfi
         LoUA==
X-Gm-Message-State: AOJu0YyUWLpu8gcuUZIqXVm1eYZpvfqcioVPBeBBIF1jUHRT6ztVzbFF
	4ClVeWssKryRXmJglnYt0CV3v4FtN/XeVQQkTDR9SldEa5hmXRZ7TdsOFefXlA==
X-Gm-Gg: ASbGncuacuzd0rPfcugMK3f5zZ+nrauOfmseWv17IPM//TjdIbh9jK+gl/GUeECWYXb
	Ar+rcbDuGrjg6t+/UCAms0cTKfHEegPraDVPV67oVUFtKn9Y4mybyALtcj2dfyy1opsyaC3LFpG
	YZVkt1DznkNQTLcXTgtTaF/Ve59n5LTBlhCUzuqoN3VNBSAp3DZF0aLkNfXCHl7k7g9gs38Bm0Z
	hbYaiZiGo4Iq4arxq9GG9eJdkyineR7rZSlOscNG/QxBaQqdW/bbIZdKpBKiF0oGx+gWxTlmp8F
	j38C5jp9TiPTuk4pWp+luhu91orWPlfz8nnZve3tGIrjM3KQPT/XHRr/Sf41/PA13m0BNtvuqxk
	wjZb0RnHLPWw/lohYpFAb1uc=
X-Google-Smtp-Source: AGHT+IF+mztUrffPuOzwtyeLurut0LAh8FDpLrvb79EY3q08VK94/BDyQ4rvAAyqr5hRFNJf5ZAyCw==
X-Received: by 2002:a05:600c:450f:b0:453:5fde:fb5b with SMTP id 5b1f17b1804b1-4562e39ba98mr46914385e9.19.1752716057100;
        Wed, 16 Jul 2025 18:34:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e25e75sm19188060f8f.87.2025.07.16.18.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:34:16 -0700 (PDT)
Message-Id: <92d0cd41a412307cf319337ac6ea7e677975e506.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 01:34:07 +0000
Subject: [PATCH v2 1/8] sparse-checkout: remove use of the_repository
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
 builtin/sparse-checkout.c | 121 ++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 57 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8a0ffba9d4b3..61714bf80be0 100644
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
 	record_mode = (*cone_mode != -1) || !the_repository->settings.sparse_checkout;
 
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
@@ -695,23 +698,24 @@ static int modify_pattern_list(struct strvec *args, int use_stdin,
 		break;
 	}
 
-	if (!the_repository->settings.sparse_checkout) {
-		set_config(MODE_ALL_PATTERNS);
-		the_repository->settings.sparse_checkout = 1;
+	if (!repo->settings.sparse_checkout) {
+		set_config(repo, MODE_ALL_PATTERNS);
+		repo->settings.sparse_checkout = 1;
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
 	if (!the_repository->settings.sparse_checkout)
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
@@ -965,13 +969,13 @@ static int sparse_checkout_disable(int argc, const char **argv,
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
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
@@ -986,14 +990,17 @@ static struct sparse_checkout_check_rules_opts {
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
@@ -1005,7 +1012,7 @@ static int check_rules(struct pattern_list *pl, int null_terminated) {
 			path = unquoted.buf;
 		}
 
-		if (path_in_sparse_checkout(path, the_repository->index))
+		if (path_in_sparse_checkout(path, repo->index))
 			write_name_quoted(path, stdout, line_terminator);
 	}
 	strbuf_release(&line);
@@ -1015,7 +1022,7 @@ static int check_rules(struct pattern_list *pl, int null_terminated) {
 }
 
 static int sparse_checkout_check_rules(int argc, const char **argv, const char *prefix,
-				       struct repository *repo UNUSED)
+				       struct repository *repo)
 {
 	static struct option builtin_sparse_checkout_check_rules_options[] = {
 		OPT_BOOL('z', NULL, &check_rules_opts.null_termination,
@@ -1054,7 +1061,7 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
 		free(sparse_filename);
 	}
 
-	ret = check_rules(&pl, check_rules_opts.null_termination);
+	ret = check_rules(repo, &pl, check_rules_opts.null_termination);
 	clear_pattern_list(&pl);
 	free(check_rules_opts.rules_file);
 	return ret;
@@ -1083,8 +1090,8 @@ int cmd_sparse_checkout(int argc,
 
 	git_config(git_default_config, NULL);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
 	return fn(argc, argv, prefix, repo);
 }
-- 
gitgitgadget

