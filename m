Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B43DBD49
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328648; cv=none; b=ZnLXf1pw4YzRE95D71nUQV0cDR3JA8cJn85fdhSP+vAIeF318DcSXa16AmgAJGhUiPvH7pxk323FJS6fR/x8df4kLr/RrIjPwO4GncJaSv60sfuN3cotnvjqTnd4abWP+6edsn7yJcwgsf+OHOz+Mdm+Ot1ay1d3SLBABDtVF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328648; c=relaxed/simple;
	bh=/6c+dbeiUG3B+YUM0ZLJCPU2dmO4rHRaKXrNwisDGN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPMgJzrBw4oSB1B+KC5XjEnAh48SnlMUR9RCG/A6PF7hxMv4D69j1Rj9+u1x1m5VIzisZiQ2YJghob0N0KB1aQ0L0XFkbGKr+ASa/LrAFNB2tJRcSjpssf6bcP0ts0+z7Yx1bWjvp2aRgyoM1Pb9Dq8xEN6wfT2FymgwIeMLwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9KHlOSL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9KHlOSL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490a7629380so15591135e9.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328645; x=1780933445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seC9EwPT85Hqc0mYP/zzdggodyJfK5UAqOgowPQ23y8=;
        b=K9KHlOSL2LH1aIeZm3Is0zrnEFlNt0pyEET2I2Hq8G8LCZo9bvcdAhJzbL8BLue2bU
         22LZJYQDhUYm7pdhHJUnIFDQXcqIYZJIzBOAzwdMtnmJ9CDfsr1vQ656tR+RODUMb3CZ
         M/m9oytaBvRbumshfKPhdYya0coFwTyILXuLz3fhy8T+bvOoRCjPEebSeX93+UHhXrom
         VVn9qZef5n/LcdxFuuARE3EFmruSxDfEej4ChSbs9ZOBlRrf1+S3qet/hZ8xquxUajbS
         bOJy3Bc6qOCw4JiTLIOSLO1TQEAtWB8H01k6IJcifYM3vy3ialvGWRBqWPDiq6Oootnx
         JZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328645; x=1780933445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=seC9EwPT85Hqc0mYP/zzdggodyJfK5UAqOgowPQ23y8=;
        b=c+gmMApLOeN8XgxMtxQNhRMS4DB/dkpih2MfKhZYpig1Sh7OAcLGZAE4FTJ3ey2xN2
         hi1mV1qg9/X4/dSXsmI2s+EViGvgEjhEofVzONSXBxdOV4WQW3C2DLK1zl4i12DZw0mE
         2jQXi4Nl36MSgDuXeRbadfn/w1D88/jGd1OXPQEDmqc4BFm3vMg1TZtMjhGK8srVTnPR
         nd/0NXuZm6D5CzWwn36jCVPk0GsOWfFaQI/W3wJ/rVsYnT4yLfdYsYFO0tDKB3jzAAow
         zf11ru9qkPNXcZrueSCwaoXv+cTidWSRM1rIvVjSogtxGYDxdXf1QDDj3LS1vr23zE+7
         UkEA==
X-Gm-Message-State: AOJu0YzsHvdwGvMuql91yGSEiGIenJ/XMnBxsKg1g7/vLqpFONgcXbSj
	C8Re8FSGL6i+yrdZl8XBaon0fp13jpzb6GsAPdJYbN0XfuMYE0hAsaUEm9CSw7l5
X-Gm-Gg: Acq92OFvResYYFcnK2Eyt1DUUkdyaB0aALvfqK3MkAZ3TjNQYjTdy/kc7KiIXj74VJx
	ODeRpJjUpq7cQA/XsuMhO0Hiw1Gsojo7hSbF533aNy+Snc9A3L4F5oRmFHHfDvE3qf5C4ot4sqS
	z7otFR0KBpMDmOiGbLntoYSxzAphgasGmQIesyo/tdI3DMtnLOqmNDvwjYbunpvz/4Ui2AuHxm1
	Jvr2jhXzqfmLKyUT7qEtAHjYHs6I4jNaZzDmK5cD0z4PMrtMuTGt13tBCcuatHtzOHn3yjAraHg
	//eQlH8Foqp8gB3yHwSDFUQwneNymdaHgTA+KpySy5lY+gQXT0MOQI8wd7SOs9K+vpdGWDsUQcf
	/AGUHQgoB5XouULfrMp3rjYjj016TZMreXNlC3+Hl3ktKbyUBPkf2JjERThHl4gknYYv4rlyiRp
	oCs5dz+DRa31W4UDTo4bgTdJeHu4aiUxiUkB+q8G6iZD02SYek2vmln8CrGlUyfO3xXw==
X-Received: by 2002:a05:600c:1d11:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-490a291fa6fmr213787915e9.12.1780328645041;
        Mon, 01 Jun 2026 08:44:05 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e07:e310:19bb:fe0b:a332:fe8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e81ef4sm350485e9.12.2026.06.01.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:44:04 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 8/8] environment: move "warn_on_object_refname_ambiguity" into `struct repo_config_values`
Date: Mon,  1 Jun 2026 16:42:11 +0100
Message-ID: <20260601154211.82370-9-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260601154211.82370-1-belkid98@gmail.com>
References: <20260423160832.114816-1-belkid98@gmail.com>
 <20260601154211.82370-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `core.warnAmbiguousRefs` configuration was previously stored in a
global `int` variable, making it shared across repository instances
and risking cross‑repository state leakage.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. This option is parsed eagerly because
ambiguity warnings influence how users interpret object references in
many commands; a lazy parse could cause these warnings to behave
inconsistently or to appear for the wrong repository, confusing users
and hindering libification. This preserves the existing behavior while
tying the value to the repository from which it was read, avoiding
cross‑repository state leakage and continuing the effort to reduce
reliance on global configuration state.

Update all references to use `repo_config_values()`.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/cat-file.c     | 7 ++++---
 builtin/pack-objects.c | 7 ++++---
 environment.c          | 2 +-
 environment.h          | 2 +-
 object-name.c          | 3 ++-
 revision.c             | 7 ++++---
 submodule.c            | 7 ++++---
 7 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d9fbad5358..cfc5430186 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -901,6 +901,7 @@ static int batch_objects(struct batch_options *opt)
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
 	struct expand_data data = EXPAND_DATA_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int save_warning;
 	int retval = 0;
 
@@ -973,8 +974,8 @@ static int batch_objects(struct batch_options *opt)
 	 * warn) ends up dwarfing the actual cost of the object lookups
 	 * themselves. We can work around it by just turning off the warning.
 	 */
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	if (opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH) {
 		batch_objects_command(opt, &output, &data);
@@ -1002,7 +1003,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8ccbe7e178..7df75fe91e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4788,6 +4788,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	char line[1000];
 	int flags = 0;
 	int save_warning;
@@ -4798,8 +4799,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
@@ -4827,7 +4828,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 			die(_("bad revision '%s'"), line);
 	}
 
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 
 	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
 		return;
diff --git a/environment.c b/environment.c
index 57587ede56..ba2c60103f 100644
--- a/environment.c
+++ b/environment.c
@@ -47,7 +47,6 @@ int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
-int warn_on_object_refname_ambiguity = 1;
 char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
@@ -725,4 +724,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 	cfg->core_sparse_checkout_cone = 0;
 	cfg->sparse_expect_files_outside_of_patterns = 0;
+	cfg->warn_on_object_refname_ambiguity = 1;
 }
diff --git a/environment.h b/environment.h
index 609cdaa07f..1ff0a7ba8b 100644
--- a/environment.h
+++ b/environment.h
@@ -97,6 +97,7 @@ struct repo_config_values {
 	int pack_compression_level;
 	int precomposed_unicode;
 	int core_sparse_checkout_cone;
+	int warn_on_object_refname_ambiguity;
 
 	/* section "sparse" config values */
 	int sparse_expect_files_outside_of_patterns;
@@ -174,7 +175,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
 extern unsigned long pack_size_limit_cfg;
diff --git a/object-name.c b/object-name.c
index 21dcdc4a0e..319d3db01d 100644
--- a/object-name.c
+++ b/object-name.c
@@ -684,11 +684,12 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
 	int fatal = !(flags & GET_OID_QUIETLY);
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (!(flags & GET_OID_SKIP_AMBIGUITY_CHECK) &&
 		    repo_settings_get_warn_ambiguous_refs(r) &&
-		    warn_on_object_refname_ambiguity) {
+		    cfg->warn_on_object_refname_ambiguity) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
diff --git a/revision.c b/revision.c
index 599b3a66c3..4e7faa7eb1 100644
--- a/revision.c
+++ b/revision.c
@@ -2922,9 +2922,10 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	int seen_end_of_options = 0;
 	int save_warning;
 	int flags = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	strbuf_init(&sb, 1000);
 	while (strbuf_getline(&sb, stdin) != EOF) {
@@ -2958,7 +2959,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		read_pathspec_from_stdin(&sb, prune);
 
 	strbuf_release(&sb);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 }
 
 static void NORETURN diagnose_missing_default(const char *def)
diff --git a/submodule.c b/submodule.c
index b1a0363f9d..f26235bbb7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -898,12 +898,13 @@ static void collect_changed_submodules(struct repository *r,
 	struct setup_revision_opt s_r_opt = {
 		.assume_dashdash = 1,
 	};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 	repo_init_revisions(r, &rev, NULL);
 	setup_revisions_from_strvec(argv, &rev, &s_r_opt);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 
-- 
2.53.0.155.g9f36b15afa

