Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0B391E58
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144479; cv=none; b=jTB02COxIx4F8IKXpx+kOQJjnsOETRAtKzc+nR3clRXZoQpeAO/M9XSqF9d7/KUNDmcEuirCSbK2jMhhthkyStCg5qcy+amKASJ3GA5E4ZIvN80HLy9u1KD+0Lvs3W7AJPhDtL1qnEHZ0k88RGBLtBLnuirDOlFsb0Kjh34qzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144479; c=relaxed/simple;
	bh=8GUuRO3EWlrOeH1xXzDArBBHbKQrVA7o+nGN033Xu+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jafVceP/q8vodPq4eToPWaevW/kmEE7yKYLAsi4FP90LNA//Ox5JY0Wbp5bTawBtQKzfSYRC5AoWADgeA71QQvIi3jP46WKZGHd6QS6KtTF/CI9/KWeytaOcfQsAjZjd6wIbGrY1syx3zMClu3/9O9DnwYbsRr6iEqAxS/aWzgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqHPnhJx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqHPnhJx"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7982c3b7da9so115781627b3.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144477; x=1773749277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttb5qnYWPLwdSgbIG4fIDuKPnl96hzgjZp6Idph5CA4=;
        b=kqHPnhJxrViqxfYz1wm5K/FzcvsadgbBXhwr4znOPa3dPkcLlsvur+0EAIQCTr3vaq
         NM480y8iKU28z61QANRdA8CKJ//4O26NZR1Wq3Ss/s3kYqO4547R8aPWH0ZFUbOAai3P
         PEdQYm5BGoQ9V9i3r8OJFwcZqLO19sgqRFD8FK1BGE9npjstfJ18NO2Dc3wIIA9D3Ccg
         UwB8ejOrOqg/XbMJfqYQHkLxi4Cfaaj9YQQ56WzDUg2G+98xcvhPdPOu29EQXNf1ybKa
         nbHQEPpRvn+NNsZNNu4m1WBgVaJZRdRpYAg5dM1voWwpYGcZJVYqTLMldK94jNvUViLq
         7voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144477; x=1773749277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttb5qnYWPLwdSgbIG4fIDuKPnl96hzgjZp6Idph5CA4=;
        b=i9L8152Ay2iuLXF1RoEmmfGdTui8uhgxOVYa5oQmXRBHJx1CNA71UuHx4yjFcbHBYd
         EP11dGeW2HcEUrEev//SeCFQSupu5SGkB6YIjcBMhSeWyyrPVZvJV2VK+0zW6FN7cbYa
         jwPvx10YCl4Sygw7d8YU6m4k6FokZi7wNIWceEeViHzXOTXqaFKadIEqqtmRRbCV5nLA
         wSu9eILm1sUUSKZMHhYGX26m+u6QZYkbHS9hU7QdL6j2ZxeU9thJCD7ZrMd2xVZ7dh0D
         VOfb+oo1m1EABQbL9AubM0lQvZsYytYv9Hmi6Kmnmmeh4CaavycWaPTQg72C0rD0xZ7b
         xkVw==
X-Gm-Message-State: AOJu0YzlxVMqE1Jl6c4Uwd5Fle+MWnsUm60LV1WnWb9jjxGByXcFNgwO
	/7VZLBxIgaofwcTp+ijGOcJnODPpbmkvOlczQqOHfp8cqZz4TU1omR7Fonfl6VEf
X-Gm-Gg: ATEYQzwTW705HOEAGqHRfa122GIpmwTyIu8RVHlIHSM/U0ozV1n/sHoUZj9M+Gxv9QT
	iPJosuoJ9fw3a3iRt/wXWmY1quQRyksfmDXK9kGJ/HAEEuZ3F8ba4f8sJfvsWEO8HkoM3Q3vuBq
	UMBlQR/Qmgfc8oh7rF6LoCxY0mkvyB+OIdWxq46z5lXzh1lVZC1wQ5KS4d54y4K5Zfs5gVKlTBf
	PWCWu1/LevylFX4HFV0LpkWaaGhl2/heo47CX4Y7ndeppVaOkzf2pprJQfTAnDG6KalNEt209zt
	xjI/+TH7jHIEjZGUC/AobJuu8VVoBixqpOHO6TYM1pCm0c5+d+p55r22xA/9sksxKgLC5GPIr7K
	Bury6DMz263zZVxob0aRY4JyRISQawKCU4EGX60H7gQAfsPD+FXMoynYwxVZYiLqv2rsLpx24Ai
	slKQAXMzEq8h/lyaGZ/dMjVdWkzSw=
X-Received: by 2002:a05:690c:c4d2:b0:798:647f:20b with SMTP id 00721157ae682-798dd7853b4mr138921747b3.45.1773144477023;
        Tue, 10 Mar 2026 05:07:57 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:f56b:22db:e23b:9613])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a54a46esm14838847b3.15.2026.03.10.05.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:07:56 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 6/8] env: move "core_sparse_checkout_cone" into `struct repo_config_values`
Date: Tue, 10 Mar 2026 13:06:27 +0100
Message-ID: <b376cc9408f9e35adc7d45bf8d3c30a1ae945445.1773127785.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <cover.1773127785.git.belkid98@gmail.com>
References: <cover.1773127785.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `core_sparse_checkout_cone` variable was previously a global integer,
uninitialized by default. Storing repository-dependent configuration in
globals can lead to cross-repository state leakage.

Move it into `repo_config_values` and initialize it to 0 by default.
This ensures predictable behavior for repositories that do not set
this configuration while preserving existing semantics.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/mv.c              |  2 +-
 builtin/sparse-checkout.c | 37 ++++++++++++++++++++++---------------
 dir.c                     |  3 ++-
 environment.c             |  4 ++--
 environment.h             |  2 +-
 sparse-index.c            |  2 +-
 6 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2215d34e31..ef3a326c90 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -574,7 +574,7 @@ int cmd_mv(int argc,
 
 		if (ignore_sparse &&
 		    cfg->apply_sparse_checkout &&
-		    core_sparse_checkout_cone) {
+		    cfg->core_sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
 			 * "out-to-out" move (<source> is out-of-cone and
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f4aa405da9..92d017b81f 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -73,7 +73,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 
 	memset(&pl, 0, sizeof(pl));
 
-	pl.use_cone_patterns = core_sparse_checkout_cone;
+	pl.use_cone_patterns = cfg->core_sparse_checkout_cone;
 
 	sparse_filename = get_sparse_checkout_filename();
 	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL, 0);
@@ -334,6 +334,7 @@ static int write_patterns_and_update(struct repository *repo,
 	FILE *fp;
 	struct lock_file lk = LOCK_INIT;
 	int result;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	sparse_filename = get_sparse_checkout_filename();
 
@@ -353,7 +354,7 @@ static int write_patterns_and_update(struct repository *repo,
 	if (!fp)
 		die_errno(_("unable to fdopen %s"), get_lock_file_path(&lk));
 
-	if (core_sparse_checkout_cone)
+	if (cfg->core_sparse_checkout_cone)
 		write_cone_to_file(fp, pl);
 	else
 		write_patterns_to_file(fp, pl);
@@ -402,15 +403,15 @@ static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 
 	/* If not specified, use previous definition of cone mode */
 	if (*cone_mode == -1 && cfg->apply_sparse_checkout)
-		*cone_mode = core_sparse_checkout_cone;
+		*cone_mode = cfg->core_sparse_checkout_cone;
 
 	/* Set cone/non-cone mode appropriately */
 	cfg->apply_sparse_checkout = 1;
 	if (*cone_mode == 1 || *cone_mode == -1) {
-		core_sparse_checkout_cone = 1;
+		cfg->core_sparse_checkout_cone = 1;
 		return MODE_CONE_PATTERNS;
 	}
-	core_sparse_checkout_cone = 0;
+	cfg->core_sparse_checkout_cone = 0;
 	return MODE_ALL_PATTERNS;
 }
 
@@ -577,7 +578,9 @@ static void add_patterns_from_input(struct pattern_list *pl,
 				    FILE *file)
 {
 	int i;
-	if (core_sparse_checkout_cone) {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
+	if (cfg->core_sparse_checkout_cone) {
 		struct strbuf line = STRBUF_INIT;
 
 		hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
@@ -636,13 +639,14 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 	struct pattern_entry *pe;
 	struct hashmap_iter iter;
 	struct pattern_list existing;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	char *sparse_filename = get_sparse_checkout_filename();
 
 	add_patterns_from_input(pl, argc, argv,
 				use_stdin ? stdin : NULL);
 
 	memset(&existing, 0, sizeof(existing));
-	existing.use_cone_patterns = core_sparse_checkout_cone;
+	existing.use_cone_patterns = cfg->core_sparse_checkout_cone;
 
 	if (add_patterns_from_file_to_list(sparse_filename, "", 0,
 					   &existing, NULL, 0))
@@ -690,7 +694,7 @@ static int modify_pattern_list(struct repository *repo,
 
 	switch (m) {
 	case ADD:
-		if (core_sparse_checkout_cone)
+		if (cfg->core_sparse_checkout_cone)
 			add_patterns_cone_mode(args->nr, args->v, pl, use_stdin);
 		else
 			add_patterns_literal(args->nr, args->v, pl, use_stdin);
@@ -723,11 +727,12 @@ static void sanitize_paths(struct repository *repo,
 			   const char *prefix, int skip_checks)
 {
 	int i;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (!args->nr)
 		return;
 
-	if (prefix && *prefix && core_sparse_checkout_cone) {
+	if (prefix && *prefix && cfg->core_sparse_checkout_cone) {
 		/*
 		 * The args are not pathspecs, so unfortunately we
 		 * cannot imitate how cmd_add() uses parse_pathspec().
@@ -744,10 +749,10 @@ static void sanitize_paths(struct repository *repo,
 	if (skip_checks)
 		return;
 
-	if (prefix && *prefix && !core_sparse_checkout_cone)
+	if (prefix && *prefix && !cfg->core_sparse_checkout_cone)
 		die(_("please run from the toplevel directory in non-cone mode"));
 
-	if (core_sparse_checkout_cone) {
+	if (cfg->core_sparse_checkout_cone) {
 		for (i = 0; i < args->nr; i++) {
 			if (args->v[i][0] == '/')
 				die(_("specify directories rather than patterns (no leading slash)"));
@@ -769,7 +774,7 @@ static void sanitize_paths(struct repository *repo,
 		if (S_ISSPARSEDIR(ce->ce_mode))
 			continue;
 
-		if (core_sparse_checkout_cone)
+		if (cfg->core_sparse_checkout_cone)
 			die(_("'%s' is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), args->v[i]);
 		else
 			warning(_("pass a leading slash before paths such as '%s' if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), args->v[i]);
@@ -836,6 +841,7 @@ static struct sparse_checkout_set_opts {
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 			       struct repository *repo)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int default_patterns_nr = 2;
 	const char *default_patterns[] = {"/*", "!/*/", NULL};
 
@@ -873,7 +879,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	 * non-cone mode, if nothing is specified, manually select just the
 	 * top-level directory (much as 'init' would do).
 	 */
-	if (!core_sparse_checkout_cone && !set_opts.use_stdin && argc == 0) {
+	if (!cfg->core_sparse_checkout_cone && !set_opts.use_stdin && argc == 0) {
 		for (int i = 0; i < default_patterns_nr; i++)
 			strvec_push(&patterns, default_patterns[i]);
 	} else {
@@ -977,7 +983,7 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	setup_work_tree();
 	if (!cfg->apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to clean directories"));
-	if (!core_sparse_checkout_cone)
+	if (!cfg->core_sparse_checkout_cone)
 		die(_("must be in a cone-mode sparse-checkout to clean directories"));
 
 	argc = parse_options(argc, argv, prefix,
@@ -1141,6 +1147,7 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
 	FILE *fp;
 	int ret;
 	struct pattern_list pl = {0};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	char *sparse_filename;
 	check_rules_opts.cone_mode = -1;
 
@@ -1152,7 +1159,7 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
 		check_rules_opts.cone_mode = 1;
 
 	update_cone_mode(&check_rules_opts.cone_mode);
-	pl.use_cone_patterns = core_sparse_checkout_cone;
+	pl.use_cone_patterns = cfg->core_sparse_checkout_cone;
 	if (check_rules_opts.rules_file) {
 		fp = xfopen(check_rules_opts.rules_file, "r");
 		add_patterns_from_input(&pl, argc, argv, fp);
diff --git a/dir.c b/dir.c
index 026d8516a9..2744b3e5ca 100644
--- a/dir.c
+++ b/dir.c
@@ -3508,8 +3508,9 @@ int get_sparse_checkout_patterns(struct pattern_list *pl)
 {
 	int res;
 	char *sparse_filename = get_sparse_checkout_filename();
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	pl->use_cone_patterns = core_sparse_checkout_cone;
+	pl->use_cone_patterns = cfg->core_sparse_checkout_cone;
 	res = add_patterns_from_file_to_list(sparse_filename, "", 0, pl, NULL, 0);
 
 	free(sparse_filename);
diff --git a/environment.c b/environment.c
index 739b647ebe..b0e873e9f5 100644
--- a/environment.c
+++ b/environment.c
@@ -70,7 +70,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
 unsigned long pack_size_limit_cfg;
 
@@ -526,7 +525,7 @@ int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.sparsecheckoutcone")) {
-		core_sparse_checkout_cone = git_config_bool(var, value);
+		cfg->core_sparse_checkout_cone = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -723,4 +722,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
+	cfg->core_sparse_checkout_cone = 0;
 }
diff --git a/environment.h b/environment.h
index 508cb1afbc..befad9a388 100644
--- a/environment.h
+++ b/environment.h
@@ -96,6 +96,7 @@ struct repo_config_values {
 	int zlib_compression_level;
 	int pack_compression_level;
 	int precomposed_unicode;
+	int core_sparse_checkout_cone;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -178,7 +179,6 @@ extern unsigned long pack_size_limit_cfg;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
 enum rebase_setup_type {
diff --git a/sparse-index.c b/sparse-index.c
index 13629c075d..53cb8d64fc 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -154,7 +154,7 @@ int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	if (!cfg->apply_sparse_checkout || !core_sparse_checkout_cone)
+	if (!cfg->apply_sparse_checkout || !cfg->core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
-- 
2.53.0.155.g9f36b15afa

