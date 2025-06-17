Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19221884A
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162082; cv=none; b=iIEhN8O1hMrJB6k/3vPnkJ38PCEPeTdEAYV92lznXqhy9PT4lBBu6mP4i2r6ERZgzNCAF5UYBa/IRn/HeQeaLaaoz9c1N99Rp+lNZ0U7llm3SkvKwIjH9u2FmH6LEGYJs2+GneEWGVHGV7zJe+EVqQRKhI6lb38QlUICe+InkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162082; c=relaxed/simple;
	bh=P4Gi2/Y7bFQuPujIQIuohBkgplspvlYTZy47h5kGkDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWEfdC3EGdsNjb7yIbVhnKq1WsInHOdB0wZHPOZayLVTS2yksNigBAm/P+Ue9MQn2e4PEWYekl+2RBsQ569qOxdFoVf3DJl3dMS1JUii03gXuY2r3a+8sIYvm/Qp8ajQIwTi72dRYGq/S79fCDyjLLl/heRptoqG8DUK7JRFvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjIZ4EZp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjIZ4EZp"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747c2cc3419so4340346b3a.2
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750162080; x=1750766880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr4IEPxueKNumlgHzbkcbpGzCpmhFEwRdLcEoBEIo7c=;
        b=cjIZ4EZpo6LlP9WsgOvsLpB8IuR3sxWavBGOXRIk2Q2LQhWBQ2mW/RVBnSWxLPuJZg
         MNzAXG6nW7VhrTdU3kLxw/Ln6PMy4iBpcxnikR8M2OSpViVqSz1/qtnUHl+BVjRTSaha
         dzzZ4OfMTfJXbPuj1VlZrliAjiIVSUwN7fMyiMwj5DWse0zMXzyuMF1Kx9IUuU85GcGb
         hyKsngDZIPUs2BKrrQekcnI5zJrl6xASDVm8auft3YZX881Blsc1WuN8xfJSX23nPjYf
         UgQQEL55aNSGgoDkH1OgMnnpJFSRe8MxVoT0gVeGVI1WIf1Zoa+XlsXKIQ3Xv6LUwjYC
         TGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162080; x=1750766880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr4IEPxueKNumlgHzbkcbpGzCpmhFEwRdLcEoBEIo7c=;
        b=JauKJXt7enEtHSfBxHQaQvcUl4S1SpMjvV1agtXDK18PViwUHeE2hVbjmEa17iKlf3
         su522fIr/KJTgboXQqjM9jFJHIFz5kuQKSiDasS59zNAA32bblkyWFgkfatUqUjR21/C
         RlbU5ZM4M9VeqVvc5Atq5i08oW29M8MlMGpR3wOkfkZMJukQ1Nplqh5w+ZTU1gBY6HnV
         rM7FZnEaXDJLDu0cEafxZd7u8HKzjl26DdAyn2gJhbvrvmYWdN9nOJisZ0Wq1H/EC7VN
         DD0YafNhZiHXpSAnq8cW5iOcZE+3+cvv/tWyIpzWHfJHXBpyVim3ra+8fnDByrn8OyGB
         cuOg==
X-Forwarded-Encrypted: i=1; AJvYcCWt0SGZECK9KqVZswtF1ngmKObQt5cxybAkHYrbhwjqi9/yoRQyKzRsilV0B41UXInLUfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CSepbBfI6Uy0+poA1NRo1RzUkukR4mJRZKw+gvu4uC1x13+5
	C3Lg4Og7QnyKsbtKPLAFp3csw0zzM2tV/17Uax13ygSiJOx7wMZv/P6e4W053FSjemc=
X-Gm-Gg: ASbGncs0Kt+nsRUEndIuY85uHMl9JN8Yto1ms3fsuY1fgMmj0SUS81IG5C02Ti7ftVi
	A4gPVWCPch4LV8UDi7eYe2CxMiangtqVI8B3R+pQQkOtQ4/Aizfv0/WEK0wof+tAkv0sZ9RnyHG
	e9pefaXg0i6qJu+52jAIlmY0kaCUInecGozzoA8sdINaHm9jNMp9us52MFGPnWI+kaTf0w1CYrS
	bKRkTrhJmjGSETfJct/o1Qi9U5LfoAKjXWWTYC3fK/mYCPsH8D5Dt3qnIVezcIeEzwVkFNjaX8r
	76jkoYGiuKM1me0Y97d1I7kOLUpRukq4SppVFJgDY++iEqm1QSSLgaGCkXIICB8f67/tGilRxKm
	mXC2i
X-Google-Smtp-Source: AGHT+IEiuKYyQODARQd8NU/zZrsA1jRnefqwiPgAK7e4nHzRjNUtgmy4L1nesJzn7K2ynJpd2XU1nA==
X-Received: by 2002:a05:6a00:4644:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-7489d04fa69mr18211793b3a.21.1750162080038;
        Tue, 17 Jun 2025 05:08:00 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c96:a38d:5480:e4eb:2835:b445])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffed0c2sm8623333b3a.22.2025.06.17.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:07:59 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v4 2/3] environment: move access to "core.sparsecheckoutcone" into repo_settings
Date: Tue, 17 Jun 2025 17:36:35 +0530
Message-ID: <9a638843411d0542e240ea0dd9537f388523fb3c.1750157825.git.ayu.chandekar@gmail.com>
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

The setting "core.sparsecheckoutcone" is stored in the global
`core_sparse_checkout_cone` and is populated in config.c. Refactor the
code to store it in the variable `sparse_checkout_cone` in the struct
`repo_settings`.
It's fine not to lazily load it from the config, as the variable
is used quite commonly.

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
 10 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 63342f5e36..94d6245b85 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -491,7 +491,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 *	dictate the behavior for the submodule, making it "forget" its
 	 *	sparse-checkout state.
 	 *
-	 * 3. "core_sparse_checkout_cone"
+	 * 3. "sparse_checkout_cone"
 	 *	ditto.
 	 *
 	 * Note that this list is not exhaustive.
diff --git a/builtin/mv.c b/builtin/mv.c
index 1e9f4d3eba..833fa761dd 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -573,7 +573,7 @@ int cmd_mv(int argc,
 
 		if (ignore_sparse &&
 		    the_repository->settings.sparse_checkout &&
-		    core_sparse_checkout_cone) {
+		    the_repository->settings.sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
 			 * "out-to-out" move (<source> is out-of-cone and
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 869d574a03..e65a62f250 100644
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
@@ -1042,7 +1042,7 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
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
index 8f0f7ca8a4..8378996b72 100644
--- a/dir.c
+++ b/dir.c
@@ -3459,7 +3459,7 @@ int get_sparse_checkout_patterns(struct pattern_list *pl)
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
index 2428b20634..444da8a753 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -150,7 +150,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
+	if (!istate->repo->settings.sparse_checkout || !istate->repo->settings.sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
-- 
2.49.0

