Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501AA248F6A
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772197160; cv=none; b=qwH+zDpmtdIEPR+3u/9cSJ+D4qthLxkHNvlNzKKQk3AKVRIkHaqI0lpyICYhFmrLkBzEnAf9de9IlQrApWGS2Ej66tsTShhlosDX/lZMFTrDWo/DkJus8ptf+KiufNY6CHwrkbuXzWesTqQmPVZZHIIbrevojjhhRBMd6WxCeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772197160; c=relaxed/simple;
	bh=of4WoQU85l1E5/UvHrVf1JhoC60qgNAr6EKXih99R9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvb1IukzcH3IIO1P3FL/12SPzJqr36CJlXKQZNyOPLdMkzBPDBT7YQIub4xA6ALf2MKShI+wkIicMq4o8ZMvx74S+J4U4ZfPBzU/qv4TVPawLeTRHJMWgc+eN4DjvkKgkbMPxfTnY1pVBDCn1lFQcZM0gqWlzOpF4usRS5WjCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKQo+QG2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKQo+QG2"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-827307b12dfso1108812b3a.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772197158; x=1772801958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2p2Ntfj3KePSFCPt870dV2QW+SeaN+npvDptk+uLqY=;
        b=AKQo+QG27rDvDpPa5hQ9f+i/Sz2lJHU/L+8wgn/N0Fy1d60+NuVuc/ya9PPD/qUOSl
         MrSkOVxFuuYRZGdF/04ZY7S0fSKX5hVKuuWRRnDsyHGBs/C5mSDadHXHvq6dx3gOPVOe
         KCVXQFhI/DOkaduyES846KYcyPSYx5eXRjbM5/mRyMvuG60CC/ByTDmgErQEDNKOeVOJ
         Qn0vpuHw7HHbkW8GVF/4/8DB8v4dTBWoVRnLF3Ntud3u+/r15EVIA46rz1JauCNIcqqt
         orisyqE+7ce20L/vT+Kav32/JqzYzaIjwmtEdYyQbFKKsPm0n5uZwb8H6eVVStUbt5GM
         mSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772197158; x=1772801958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2p2Ntfj3KePSFCPt870dV2QW+SeaN+npvDptk+uLqY=;
        b=TluCaMoP4uXF2vF/oPC6qgX+Bkjq0Tu0VaJB/R2VNfdgo4CljPw0+1bNuA96/KW2ab
         Diyml9I7K9zaKTNzsocgummsGKbaIY8Kl/Bjr1bcgdv96kKi5y9VpkKQDNg2BzbxzfmK
         4j4MjUx6c6PSCKPyrTud2S1TRUBa9F6jAY8cNPD96c9YUVxhTb+GyvJYhg+8Bn0a6X8b
         YGCubTtmDFuJB0QTdSguHlide5kz9Z0/ZamWzsNkeaKOm5gaODRueM2GRHt0ecCVVyOj
         RJZd1UWYOKONLrjez2FGXGxFj5Vje4yXUK8FPTd1knMwCh3U9KyT1e/cfMT0Jt2J5ADa
         5a4g==
X-Gm-Message-State: AOJu0YwGxQPb6KfRWjgWLUpsSRsSMWYYeIBdkt/WXOKYs0zeXtD276Es
	GtigsLjs4MDPxenaZf7RoT4z5JyoHsBdenZCWcXUgB9P1c1vHiE7cO0CepJh9A==
X-Gm-Gg: ATEYQzxkdB35aA1TGLuymEOeBCA+TP0mjJfCJ7cUP6ELMt94hakSyEboSfpVbDqjO+Y
	0YQOtP80cx56aF9WVZdKOcbZhq5ZeFl2pjRQ1d3CxX4SV8pgqdCuORJWU1lPMwxAhMfWSjayHvs
	Oc+KHNsxu+AukAUPtxyBULTWHgnktcdl1i+q7mgVIdZYEiCGmQ+NDsCoehR4VyvzbSVvDlv5SIA
	cCK56okIV5L1uK+G4FE5fGApB274QwsqO2dABs/67iklGg2s+kn9kTKuQl4ICW14PJx2IgZB7TJ
	IEXAnU6WqdsOxdwXDufPPYb9eHYyfiCtTbowYJA3hUo982KMXRiplX9ssUkUHHdR/tqqDKmJYP9
	H9WAGTfxlgL0JtZXZv9m2VzcLMyyBMs6yY6JzEGljqQR40CRCP9+koEt1bhdbhoRv2hAMpV7qRM
	mRCQnJY4a2b2sbcyeCLPDeOj9KZaVwY5A+kSbcxJZ7FA==
X-Received: by 2002:a05:6a20:3d02:b0:393:bfa:1150 with SMTP id adf61e73a8af0-395c4765719mr2322096637.28.1772197158337;
        Fri, 27 Feb 2026 04:59:18 -0800 (PST)
Received: from dorna-OEM.. ([103.152.144.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dda5ec8sm5320882a91.12.2026.02.27.04.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 04:59:18 -0800 (PST)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH] repo-settings: move warn_on_object_refname_ambiguity to repo_settings
Date: Fri, 27 Feb 2026 18:41:52 +0545
Message-ID: <20260227125654.249676-1-dronarajgyawali@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dorna Raj Gyawali <dronarajgyawali@gmail.com>

This flag (default: true) controls whether warnings are printed when
disambiguating object names that match multiple refname prefixes.
Move it from a global variable in environment.c to struct repo_settings
to reduce global state.

- Added field and default value to repo-settings.h
- Added getter and setter helpers in repo-settings.[ch]
- Updated all call sites in object-name.c, submodule.c, revision.c,
  builtin/cat-file.c and builtin/pack-objects.c
- Removed the old global from environment.[ch]

No functional change intended.

The USE_THE_REPOSITORY_VARIABLE macros are kept in this version.
Will remove them in v2 if requested.

Signed-off-by: drona <dronarajgyawali@gmail.com>
Signed-off-by: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
---
 builtin/cat-file.c     |  6 +++---
 builtin/pack-objects.c |  6 +++---
 environment.c          |  1 -
 environment.h          |  1 -
 object-name.c          |  2 +-
 repo-settings.c        | 10 ++++++++++
 repo-settings.h        |  7 ++++++-
 revision.c             |  6 +++---
 submodule.c            |  6 +++---
 9 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df8e87a81f..bc48ae9f1e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -947,8 +947,8 @@ static int batch_objects(struct batch_options *opt)
 	 * warn) ends up dwarfing the actual cost of the object lookups
 	 * themselves. We can work around it by just turning off the warning.
 	 */
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = repo_settings_get_warn_on_object_refname_ambiguity(the_repository);
+	repo_settings_set_warn_on_object_refname_ambiguity(the_repository, 0);
 
 	if (opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH) {
 		batch_objects_command(opt, &output, &data);
@@ -976,7 +976,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
-	warn_on_object_refname_ambiguity = save_warning;
+	repo_settings_set_warn_on_object_refname_ambiguity(the_repository, save_warning);
 	return retval;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cfb03d4c09..da008c7e98 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4679,8 +4679,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = repo_settings_get_warn_on_object_refname_ambiguity(the_repository);
+	repo_settings_set_warn_on_object_refname_ambiguity(the_repository, 0);
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
@@ -4708,7 +4708,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 			die(_("bad revision '%s'"), line);
 	}
 
-	warn_on_object_refname_ambiguity = save_warning;
+	repo_settings_set_warn_on_object_refname_ambiguity(the_repository, save_warning);
 
 	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
 		return;
diff --git a/environment.c b/environment.c
index 0026eb2274..c76adc02c1 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,6 @@ int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
-int warn_on_object_refname_ambiguity = 1;
 char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
diff --git a/environment.h b/environment.h
index 27f657af04..f2438634ce 100644
--- a/environment.h
+++ b/environment.h
@@ -151,7 +151,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
 extern char *git_attributes_file;
diff --git a/object-name.c b/object-name.c
index 7b14c3bf9b..e420152064 100644
--- a/object-name.c
+++ b/object-name.c
@@ -973,7 +973,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (!(flags & GET_OID_SKIP_AMBIGUITY_CHECK) &&
 		    repo_settings_get_warn_ambiguous_refs(r) &&
-		    warn_on_object_refname_ambiguity) {
+		    repo_settings_get_warn_on_object_refname_ambiguity(r)) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
diff --git a/repo-settings.c b/repo-settings.c
index 208e09ff17..c415779b9b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -233,3 +233,13 @@ void repo_settings_reset_shared_repository(struct repository *repo)
 {
 	repo->settings.shared_repository_initialized = 0;
 }
+
+int repo_settings_get_warn_on_object_refname_ambiguity(struct repository *repo)
+{
+    return repo->settings.warn_on_object_refname_ambiguity;
+}
+
+void repo_settings_set_warn_on_object_refname_ambiguity(struct repository *repo, int value)
+{
+    repo->settings.warn_on_object_refname_ambiguity = value;
+}
\ No newline at end of file
diff --git a/repo-settings.h b/repo-settings.h
index cad9c3f0cc..f74d6b1a6b 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -61,7 +61,7 @@ struct repo_settings {
 
 	int core_multi_pack_index;
 	int warn_ambiguous_refs; /* lazily loaded via accessor */
-
+	int warn_on_object_refname_ambiguity;
 	size_t delta_base_cache_limit;
 	size_t packed_git_window_size;
 	size_t packed_git_limit;
@@ -77,6 +77,7 @@ struct repo_settings {
 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
 	.warn_ambiguous_refs = -1, \
+	.warn_on_object_refname_ambiguity = 1, \
 	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
 	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
 	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
@@ -102,4 +103,8 @@ int repo_settings_get_shared_repository(struct repository *repo);
 void repo_settings_set_shared_repository(struct repository *repo, int value);
 void repo_settings_reset_shared_repository(struct repository *repo);
 
+/* Read the value for "warn_on_object_refname_ambiguity" (internal flag) */
+int repo_settings_get_warn_on_object_refname_ambiguity(struct repository *repo);
+void repo_settings_set_warn_on_object_refname_ambiguity(struct repository *repo, int value);
+
 #endif /* REPO_SETTINGS_H */
diff --git a/revision.c b/revision.c
index 047ff7e458..7072f9c331 100644
--- a/revision.c
+++ b/revision.c
@@ -2905,8 +2905,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	int save_warning;
 	int flags = 0;
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = repo_settings_get_warn_on_object_refname_ambiguity(revs->repo);
+	repo_settings_set_warn_on_object_refname_ambiguity(revs->repo, 0);
 
 	strbuf_init(&sb, 1000);
 	while (strbuf_getline(&sb, stdin) != EOF) {
@@ -2940,7 +2940,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		read_pathspec_from_stdin(&sb, prune);
 
 	strbuf_release(&sb);
-	warn_on_object_refname_ambiguity = save_warning;
+	repo_settings_set_warn_on_object_refname_ambiguity(revs->repo, save_warning);
 }
 
 static void NORETURN diagnose_missing_default(const char *def)
diff --git a/submodule.c b/submodule.c
index 508938e4da..a1d618e802 100644
--- a/submodule.c
+++ b/submodule.c
@@ -899,11 +899,11 @@ static void collect_changed_submodules(struct repository *r,
 		.assume_dashdash = 1,
 	};
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = repo_settings_get_warn_on_object_refname_ambiguity(r);
+	repo_settings_set_warn_on_object_refname_ambiguity(r, 0);
 	repo_init_revisions(r, &rev, NULL);
 	setup_revisions_from_strvec(argv, &rev, &s_r_opt);
-	warn_on_object_refname_ambiguity = save_warning;
+	repo_settings_set_warn_on_object_refname_ambiguity(r, save_warning);
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 
-- 
2.43.0

