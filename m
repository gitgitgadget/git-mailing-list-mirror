Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A89461
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883926; cv=none; b=ljhiXPcqvfBI9uIUi4kOXnGrxX83BwALSizZetsrlpmwtgYwddJ8FoksiaGSqf2wqXRYDDQQCE4MQ30NtEoMkyfBLsFZwe2pyyk+do0JaO/IR30d38SHhBQ+lMf5LgscwfWKwIA9YvKoD0vH84J9WOmEthQusfX2wMvxnsbvA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883926; c=relaxed/simple;
	bh=RyFd5cl0OXCjMjro0CDohdCZxUUrKfsjS06UCKOnlE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RExPxv9b+wfL6qFYq8IS/0xlAfJyIb9nmw9nDx9z9pgkFT7NDtXyDEFpMDHh7fdKwEqnBjH75ko2M5a44QehQtIfvxoFH7r1nIPjQYzouk+U+XVQcdhjyKSrL9qLG/RbGuGurZpiE3mBV4koH2CG+8cp9atZiPaOh2qVZxcnIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5J1z6Tf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5J1z6Tf"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313f68bc519so1800220a91.0
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752883924; x=1753488724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+njbMDXMRXIEIRiB8HAimnzM8OQ+HiRfNmWEcRq4ms=;
        b=W5J1z6TfYF+Jk8JRMhLmuUF3hsUQePO5qX9SjIAKj32w2EB1P9QXsWBMl9hz4x3yNL
         aP1xDSxkW0P0LuMHea9D8uCshtPxKE9/48MOPM0/Qb0imkB8Qyrlsnea76m7raKC2Te6
         hJ+Xexo9zAEaqUaVSugwLyJhgtzLXUTnKHKA96xeCffIQjuHdMJKrJylJbWYThn2mIKu
         qWvow0VnwpXlk1zMHF6MWnJpXEoVbDnlD9OFktkjXFjQaXX/esa0dct1NBzaVcoSoJLZ
         PKKnL2LtW9QXbeNBrd/k8m5YdWa4PMY999aZXeqKugs5S+T8gl3yD4nmyaXUISB9+E4w
         osTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752883924; x=1753488724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+njbMDXMRXIEIRiB8HAimnzM8OQ+HiRfNmWEcRq4ms=;
        b=wFBWlWG+9kXXvjoibrq+/Tr1L3emVrMeb6IjbQ6MhTkFGnp5uYv4+7xTipSVXse4wK
         5GF3RuGLgGlg/RQiO0LcMWl5znWbniQpkxoN/9x0qN/MLB3OYYqi9eqTsibAsd9AZI0C
         /h//VXuKVdlHZxABaG9Bg9+xkogwgyfXG6OQtoBt553m8u7eqkKwnDH5d9sFlTYe4Fk9
         XWwjYj/T+qqhic8p/BpEO2iSEWNhrG1ufOjzRwZJwW8XDRDK/b5OMK+nIfeB3pyrljIh
         kCUgIHWFLTUOBqsLkB/mNmkyw4q2aFhcr4cgUUhkHupTd20OcDPCMz3cOzHnMHYSbbwo
         nizw==
X-Forwarded-Encrypted: i=1; AJvYcCUWaormEJX54pYLH2X8RY1IlG+i7vCVJ4kikTXJh/TUom2r0etssOmeh8gsC8lC25aoUws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCEcgBlERMkM0J2Lz938NS7PY0WHPYfYWfFk0PruTt8t9+BWj
	LO9J4wi9F7KgcLzXTEJ2XhuXGwgQ9UaR72v7Y7eBPSkDsXq02WST8NWDLtOGumtg
X-Gm-Gg: ASbGnctkopq4MYBCdXq/BynxsTKKEOua6G70iqT5OLF3utm8l3hoqyGn/9imvC/LnBs
	lPEiHr8TPMqusybPBb6c7KxsXfaIehpjF9kOd1b8b1/0kIqKiwmESHXpPV0QVTzjTls6mXKOxX5
	Zo9uQhpAW9yX91M5eKRIIHpkPMCvdZOCr5R3Sf6w931+hA1xYMiGt20iqrKFQ4xG2auEI6d+GaH
	WgVVf07g/LqIA6/mbEiri5bHzUOiiaacm53tkfOnUHsKaxPsVkP/hMk7L++VPV4D9/eeGqRVC38
	yRrAXJ+XTc2sKj9KKntczoSct5s9qrX+6j7GHViZ5ohs/aknzA+aFX+II5jIsFcDKy5lyh1D6yr
	OXv6OxQDMGAjMS/Ax1KicRjDJzVPjcC5H5VM=
X-Google-Smtp-Source: AGHT+IGrEsgfC7NfT1aljRKR1g0s82Y06tmZgFh5/7pj/BA9Mkr5srNtDOgTU3tVg2xmojM7d2OJZA==
X-Received: by 2002:a17:90b:1b07:b0:312:db8:dbdd with SMTP id 98e67ed59e1d1-31c9f4b539amr17555206a91.28.1752883924048;
        Fri, 18 Jul 2025 17:12:04 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3d5e765sm1964268a91.0.2025.07.18.17.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 17:12:03 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	ben.knoble@gmail.com
Subject: [GSOC PATCH v6 2/3] environment: move access to "core.sparsecheckoutcone" into repo_settings
Date: Sat, 19 Jul 2025 05:41:27 +0530
Message-ID: <d799faca3fa93b0e5ac906bfd9839f143d299e5b.1752882401.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752882401.git.ayu.chandekar@gmail.com>
References: <cover.1752882401.git.ayu.chandekar@gmail.com>
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

Avoid redundant calls to `prepare_repo_settings()` where it is already
present:
- In "builtin/mv.c" and "builtin/sparse-checkout.c", it is already
  invoked in their respective `cmd_*()` functions.
- In "sparse-index.c", `prepare_repo_settings()` is already called
  before the setting is accessed.
- In "dir.c", `prepare_repo_settings()` is already called in all code
  paths before the setting is accessed.

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
index fbad1a72a2..bd5481cc44 100644
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
index da76bf4fde..e13f7d8fe8 100644
--- a/config.c
+++ b/config.c
@@ -1607,11 +1607,6 @@ static int git_default_core_config(const char *var, const char *value,
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
index 01d7574c09..5bed22a479 100644
--- a/dir.c
+++ b/dir.c
@@ -3473,7 +3473,7 @@ int get_sparse_checkout_patterns(struct pattern_list *pl)
 	int res;
 	char *sparse_filename = get_sparse_checkout_filename();
 
-	pl->use_cone_patterns = core_sparse_checkout_cone;
+	pl->use_cone_patterns = the_repository->settings.sparse_checkout_cone;
 	res = add_patterns_from_file_to_list(sparse_filename, "", 0, pl, NULL, 0);
 
 	free(sparse_filename);
diff --git a/environment.c b/environment.c
index 3a21629f86..cd5ec5c736 100644
--- a/environment.c
+++ b/environment.c
@@ -63,7 +63,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
diff --git a/environment.h b/environment.h
index 1e1e83fff1..5642156d3d 100644
--- a/environment.h
+++ b/environment.h
@@ -159,7 +159,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
 enum rebase_setup_type {
diff --git a/repo-settings.c b/repo-settings.c
index c3aa92c065..505e402276 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -85,6 +85,7 @@ void prepare_repo_settings(struct repository *r)
 		      r->settings.pack_use_bitmap_boundary_traversal);
 	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
 	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.sparse_checkout, 0);
+	repo_cfg_bool(r, "core.sparsecheckoutcone", &r->settings.sparse_checkout_cone, 0);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repo-settings.h b/repo-settings.h
index 95900784f1..1b43c4029c 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -68,7 +68,9 @@ struct repo_settings {
 	unsigned long big_file_threshold;
 
 	char *hooks_path;
+
 	int sparse_checkout;
+	int sparse_checkout_cone;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
diff --git a/sparse-index.c b/sparse-index.c
index c9e5a5efe1..3b51ea46e3 100644
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

