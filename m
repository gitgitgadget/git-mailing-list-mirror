Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1BE56A
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311744; cv=none; b=VtkXu5zP5WVaHdV7R7N7RVRqLnk7TjC1t1RieV9YdiKYikcfrn3lGpibHCjOjVnseaZ5pxRymFsX4JWdOXQdESWw4ts6CrTTegMUECDw57/PtHdvUbl3hV4ISkzwOEGp0jcFycT9sp9I9lojdfSVsiDpQWzW3zDQpnHEyL9zcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311744; c=relaxed/simple;
	bh=RXvn+xDYekYZMjSOZCJVtda+QAjQr4YgszudpLVC7J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prwIhTAlLNBpI1WkXeFGkQ54zm2XFFMSgtBk3KeuTjsLrK05Q09jaT48ISGH31zJUuQ+Q8drUau6xxTvWqgnhNvNaVQEvj+Epy8i4q4kf7Ij6O6h+wsBTVpdv80pxHyKK9JkqNlfSyC932fJl/tB/iVqhXS9C9qH8ma7/xVfKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvENEVdU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvENEVdU"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748e378ba4fso6676985b3a.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751311742; x=1751916542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITIz81g48yq2m1visUORWO3QAVe0qdk7ZOdKODyFTnQ=;
        b=fvENEVdUvqLBDPpb1GSQejkJ2BJlUBZqmtzAULbeCtBG5QAGmoOune4Gec+kcyOiYv
         197lcH41GYt7ZGNhq2RrAgKEXZJO87CTAZi1O0H9/3qQoG5E9hxDb1yG7u6pbj7LC6Ux
         9tt3eKlFzFvgGGmj7E3oSmihSSdZrYLkPPVMh7oyeJZ9SvT6FP0ZDPaavjwx1SbGNgWl
         6wv0QVi45N4g8ELlGiU2OHWt7wh9guP8y5oV083OCB1Ywyf3smZttD01QvpNy6aXliCi
         TJDyTT4Ko9mP3JIZfw+2JpIKrdIPFMd41XS7MQZEfym2wQKQ2QNSLJH4Ul0p3Ya+aCFH
         e1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311742; x=1751916542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITIz81g48yq2m1visUORWO3QAVe0qdk7ZOdKODyFTnQ=;
        b=F8fO6XIjePC55els8XCb3eyyzKBK9verSaHLucZIFn0YLwILYjCCCzhMFHE+Z+4fdZ
         i0hZs64my1Dx460jOa/P6dUBvxdDJ09Oq54NI7piCwTamnV2zMBe8fWYBiCZp18n2ubs
         iEKcn/9po7D3TnHM0bnDohf4Za/j4qHwF4mzoHuoZLHwNNM6/zx1ZdBl/YE+vlqHkT/0
         aG1nkjGIobNOpyHpcc2EUzO0rMGlTtU6njI5KvNfj4gWccJfMMMmObQiydIzFsUpXJbN
         koadj8UoScmjdsATw6iNQPwmCS46Rdh66cn0fxhRI2Ogxzy5ejImeyZPHa21cQkZ+b32
         hWlg==
X-Forwarded-Encrypted: i=1; AJvYcCUUdxv9NIJjHlLLCrAh2O5p8D3tEorHhz5gaWLA+/TxKHuGAdLSFQ7BRz3eIXOGWf/qOEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kkqo+vn70Pa0RNZvaCZZT9gYIkxbho3kJA2V6euUdg9JJHcH
	WPpgduCod7iZbnJzs3SgqYi2FK0ggUqDRaELQneAy0+YSIyAE+/YYAs4
X-Gm-Gg: ASbGncu1SSdk/1bmfoRVBcO9jLTHB8UP8lGHbgAtqIf+4M/6tjqPz/jiB+EgEqwDIVs
	mPLp9E7aXAKWTzxw6nDOHyM44uTJ/tBNTPP0rcUlEaxVxdaPy95txsVPiHS/pJrPcYOvj0KQZir
	Dt5UEMqr2mTJUBfgnbYliGySYVZV39iLuWJf7XHUY9Izwg32Oh1m327qoxVLnWKoUiXHL23vRJa
	76vMwStdnpm67rFGWk0p+K6Vy4B21lkAQBup7hJcb3KXbdLjOep+3SCuGlaAiYcrf+KLW/gEUgT
	wtH4sdJQFHR8joMImC9mDkK1JQPk90Wt/6tQ9tzCq/jBX8eYeN2aO9ac6l4h6HT+hrhSe+jbA2m
	K0g==
X-Google-Smtp-Source: AGHT+IEP/nCI71tuXq0BCufk3BXblP+DY71M2korc3uVdVnydsAw9tAYvqbafcMqDdPHBasS7zzv2w==
X-Received: by 2002:a05:6a00:218b:b0:746:31d1:f7d0 with SMTP id d2e1a72fcca58-74af6ea1d5cmr19867602b3a.9.1751311742357;
        Mon, 30 Jun 2025 12:29:02 -0700 (PDT)
Received: from thinku.localdomain ([110.226.180.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557b27dsm9757779b3a.84.2025.06.30.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:29:02 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	ben.knoble@gmail.com
Subject: [GSOC PATCH v5 2/3] environment: move access to "core.sparsecheckoutcone" into repo_settings
Date: Tue,  1 Jul 2025 00:57:47 +0530
Message-ID: <5a2f61443bda079a2d85190b904473d6fab3fec4.1751309770.git.ayu.chandekar@gmail.com>
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

The setting "core.sparsecheckoutcone" is stored in the global
`core_sparse_checkout_cone` and is populated in config.c. Refactor the
code to store it in the variable `sparse_checkout_cone` in the struct
`repo_settings`.

Call `prepare_repo_settings()` where necessary to ensure the `struct
repo_settings` is initialized before use:
- In "dir.c", the function accessing the setting is usually called after
  `prepare_repo_settings()`, except for one code path in
  "unpack-trees.c", so add a call there.

Avoid redundant calls to `prepare_repo_settings()` where it is already
present:
- In "builtin/mv.c" and "builtin/sparse-checkout.c", it is already
  invoked in their respective `cmd_*()` functions.
- In "sparse-index.c", `prepare_repo_settings` is already called before
  the setting is accessed.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/grep.c            |  2 +-
 builtin/mv.c              |  2 +-
 builtin/sparse-checkout.c | 28 ++++++++++++++--------------
 config.c                  |  5 -----
 dir.c                     |  2 +-
 environment.c             |  1 -
 environment.h             |  1 -
 repo-settings.c           |  1 +
 repo-settings.h           |  2 ++
 sparse-index.c            |  2 +-
 unpack-trees.c            |  1 +
 11 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6111fee60b..8971a15ef4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -491,7 +491,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 *	dictate the behavior for the submodule, making it "forget" its
 	 *	sparse-checkout state.
 	 *
-	 * 3. "core_sparse_checkout_cone"
+	 * 3. "settings.sparse_checkout_cone"
 	 *	ditto.
 	 *
 	 * Note that this list is not exhaustive.
diff --git a/builtin/mv.c b/builtin/mv.c
index 43ed2e3d0a..2d1326a18f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -573,7 +573,7 @@ int cmd_mv(int argc,
 		prepare_repo_settings(the_repository);
 		if (ignore_sparse &&
 		    the_repository->settings.sparse_checkout &&
-		    core_sparse_checkout_cone) {
+		    the_repository->settings.sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
 			 * "out-to-out" move (<source> is out-of-cone and
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8329d29a27..8a0ffba9d4 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -71,7 +71,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 
 	memset(&pl, 0, sizeof(pl));
 
-	pl.use_cone_patterns = core_sparse_checkout_cone;
+	pl.use_cone_patterns = the_repository->settings.sparse_checkout_cone;
 
 	sparse_filename = get_sparse_checkout_filename();
 	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL, 0);
@@ -352,7 +352,7 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	if (!fp)
 		die_errno(_("unable to fdopen %s"), get_lock_file_path(&lk));
 
-	if (core_sparse_checkout_cone)
+	if (the_repository->settings.sparse_checkout_cone)
 		write_cone_to_file(fp, pl);
 	else
 		write_patterns_to_file(fp, pl);
@@ -398,15 +398,15 @@ static int set_config(enum sparse_checkout_mode mode)
 static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 	/* If not specified, use previous definition of cone mode */
 	if (*cone_mode == -1 && the_repository->settings.sparse_checkout)
-		*cone_mode = core_sparse_checkout_cone;
+		*cone_mode = the_repository->settings.sparse_checkout_cone;
 
 	/* Set cone/non-cone mode appropriately */
 	the_repository->settings.sparse_checkout = 1;
 	if (*cone_mode == 1 || *cone_mode == -1) {
-		core_sparse_checkout_cone = 1;
+		the_repository->settings.sparse_checkout_cone = 1;
 		return MODE_CONE_PATTERNS;
 	}
-	core_sparse_checkout_cone = 0;
+	the_repository->settings.sparse_checkout_cone = 0;
 	return MODE_ALL_PATTERNS;
 }
 
@@ -572,7 +572,7 @@ static void add_patterns_from_input(struct pattern_list *pl,
 				    FILE *file)
 {
 	int i;
-	if (core_sparse_checkout_cone) {
+	if (the_repository->settings.sparse_checkout_cone) {
 		struct strbuf line = STRBUF_INIT;
 
 		hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
@@ -637,7 +637,7 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 				use_stdin ? stdin : NULL);
 
 	memset(&existing, 0, sizeof(existing));
-	existing.use_cone_patterns = core_sparse_checkout_cone;
+	existing.use_cone_patterns = the_repository->settings.sparse_checkout_cone;
 
 	if (add_patterns_from_file_to_list(sparse_filename, "", 0,
 					   &existing, NULL, 0))
@@ -683,7 +683,7 @@ static int modify_pattern_list(struct strvec *args, int use_stdin,
 
 	switch (m) {
 	case ADD:
-		if (core_sparse_checkout_cone)
+		if (the_repository->settings.sparse_checkout_cone)
 			add_patterns_cone_mode(args->nr, args->v, pl, use_stdin);
 		else
 			add_patterns_literal(args->nr, args->v, pl, use_stdin);
@@ -719,7 +719,7 @@ static void sanitize_paths(struct strvec *args,
 	if (!args->nr)
 		return;
 
-	if (prefix && *prefix && core_sparse_checkout_cone) {
+	if (prefix && *prefix && the_repository->settings.sparse_checkout_cone) {
 		/*
 		 * The args are not pathspecs, so unfortunately we
 		 * cannot imitate how cmd_add() uses parse_pathspec().
@@ -736,10 +736,10 @@ static void sanitize_paths(struct strvec *args,
 	if (skip_checks)
 		return;
 
-	if (prefix && *prefix && !core_sparse_checkout_cone)
+	if (prefix && *prefix && !the_repository->settings.sparse_checkout_cone)
 		die(_("please run from the toplevel directory in non-cone mode"));
 
-	if (core_sparse_checkout_cone) {
+	if (the_repository->settings.sparse_checkout_cone) {
 		for (i = 0; i < args->nr; i++) {
 			if (args->v[i][0] == '/')
 				die(_("specify directories rather than patterns (no leading slash)"));
@@ -761,7 +761,7 @@ static void sanitize_paths(struct strvec *args,
 		if (S_ISSPARSEDIR(ce->ce_mode))
 			continue;
 
-		if (core_sparse_checkout_cone)
+		if (the_repository->settings.sparse_checkout_cone)
 			die(_("'%s' is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), args->v[i]);
 		else
 			warning(_("pass a leading slash before paths such as '%s' if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), args->v[i]);
@@ -864,7 +864,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	 * non-cone mode, if nothing is specified, manually select just the
 	 * top-level directory (much as 'init' would do).
 	 */
-	if (!core_sparse_checkout_cone && !set_opts.use_stdin && argc == 0) {
+	if (!the_repository->settings.sparse_checkout_cone && !set_opts.use_stdin && argc == 0) {
 		for (int i = 0; i < default_patterns_nr; i++)
 			strvec_push(&patterns, default_patterns[i]);
 	} else {
@@ -1041,7 +1041,7 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
 		check_rules_opts.cone_mode = 1;
 
 	update_cone_mode(&check_rules_opts.cone_mode);
-	pl.use_cone_patterns = core_sparse_checkout_cone;
+	pl.use_cone_patterns = the_repository->settings.sparse_checkout_cone;
 	if (check_rules_opts.rules_file) {
 		fp = xfopen(check_rules_opts.rules_file, "r");
 		add_patterns_from_input(&pl, argc, argv, fp);
diff --git a/config.c b/config.c
index 8fd4dd8c81..707fe0707a 100644
--- a/config.c
+++ b/config.c
@@ -1612,11 +1612,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.sparsecheckoutcone")) {
-		core_sparse_checkout_cone = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.precomposeunicode")) {
 		precomposed_unicode = git_config_bool(var, value);
 		return 0;
diff --git a/dir.c b/dir.c
index 5d1cb7a067..d2b0a5aef6 100644
--- a/dir.c
+++ b/dir.c
@@ -3460,7 +3460,7 @@ int get_sparse_checkout_patterns(struct pattern_list *pl)
 	int res;
 	char *sparse_filename = get_sparse_checkout_filename();
 
-	pl->use_cone_patterns = core_sparse_checkout_cone;
+	pl->use_cone_patterns = the_repository->settings.sparse_checkout_cone;
 	res = add_patterns_from_file_to_list(sparse_filename, "", 0, pl, NULL, 0);
 
 	free(sparse_filename);
diff --git a/environment.c b/environment.c
index a379a9149e..7d46b80711 100644
--- a/environment.c
+++ b/environment.c
@@ -64,7 +64,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
diff --git a/environment.h b/environment.h
index 6a30512f3c..00a5b332a0 100644
--- a/environment.h
+++ b/environment.h
@@ -160,7 +160,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
 enum rebase_setup_type {
diff --git a/repo-settings.c b/repo-settings.c
index 9270cca561..eebc1f941d 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -82,6 +82,7 @@ void prepare_repo_settings(struct repository *r)
 		      r->settings.pack_use_bitmap_boundary_traversal);
 	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
 	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.sparse_checkout, 0);
+	repo_cfg_bool(r, "core.sparsecheckoutcone", &r->settings.sparse_checkout_cone, 0);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repo-settings.h b/repo-settings.h
index 9caa7c57a3..443e1399da 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -67,7 +67,9 @@ struct repo_settings {
 	unsigned long big_file_threshold;
 
 	char *hooks_path;
+
 	int sparse_checkout;
+	int sparse_checkout_cone;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
diff --git a/sparse-index.c b/sparse-index.c
index 8132c0f2fb..6fd782a8fc 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -151,7 +151,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
 	prepare_repo_settings(istate->repo);
-	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
+	if (!istate->repo->settings.sparse_checkout || !istate->repo->settings.sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
diff --git a/unpack-trees.c b/unpack-trees.c
index 02e32c4ba1..0e9813bddf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2144,6 +2144,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 		BUG("update_sparsity() called wrong");
 
 	trace_performance_enter();
+	prepare_repo_settings(the_repository);
 
 	/* If we weren't given patterns, use the recorded ones */
 	if (!pl) {
-- 
2.49.0

