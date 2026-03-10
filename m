Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43DF397E73
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144488; cv=none; b=ec8vEpl7qonkjkSuZtNpZptKwDWPLivM/NLIcT0h3aSC3jyRazBHbDsUGgglsELymiAv6FWKQ4sY1cLwQ4MXf2lKfPAIH9jebcffV12sWsxZb+SuHqMMoF+8SRsZEtWlOdvdPXP225KF2mpo8WiMY9BoZOAeFMc4AKKRt0NdSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144488; c=relaxed/simple;
	bh=gC4GaRWFUuN+GoB+c+BUfn47qGCNY2T37RegxsPJiWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ibm+du/7JZ5C+VgVoT5k2inCAno93gzOFAbCpLopWtmgVZjOrEbhH4kPoftHC+9cFQ8aO6wrItRkBrLzjvw2KZOzNZiXpzDDFfRaNrJ6yD+DKFkpQkRxkT8RRCM6WrMW14wiHV8vCIRoLDz4IumPp8MqlKalPr6LhSAiIZ+zCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN8s4H+L; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN8s4H+L"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7985ce90542so122782217b3.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144485; x=1773749285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kLaiuthbiIMSkh5eOgDH2rYByCtFvXZd2HcqwF0Sfo=;
        b=nN8s4H+LY3FIty4MnAhd9GYHQUslHTq0pV6nUoNhRPMYMi0kaEPLK5FA8PgHOcPibb
         7QpZx8l7JbaJpDy0gwqMxLi8Z2qXTBYza+ifi+S8YWNkZQ4MNhfnJSJiPtT6qA9ERZxe
         mDKPO1hnn+nhaOn395u5WGTLbyhOl7gvRNBPNZMIIVTfjgdLGQbmL3QXKBiw//rijahu
         Bz3dOW6u9NJGrsUP6FNgHEGThg1OkPjzdnjOPl5f4hYj4XIe9Th+F7wiLuX+g/Ivy81L
         Ec2Wik1gld2ubUS488dipGAibQ4BHNCnE/cOae5wwKnO1PaRVX8ZkwL8vsnZA7xOFSqD
         nu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144485; x=1773749285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kLaiuthbiIMSkh5eOgDH2rYByCtFvXZd2HcqwF0Sfo=;
        b=ZGeRUZPcypQMtF01QS5zy/WoWargzdCoHQUWdZfWjCX0ZtjBo8ijGOie9VWo7ApRel
         eDHBOjvEIRdFAU9p5/usgZHjlRW3udlAe62HAKZq/aL3hwMRBFtqT7TPUKMmosHtkziL
         1KN/+u2ZlFqc3ZUDpO7oOd8Lec/gbEnvGqBdgs2jyil64YpMuUEeKbpm+cXfHMjC3VkA
         DgOHGYWvX3nDRHKpTTVpV+3E1PAdqkZwjE06QCs/YtnGIoNyMkiRpAElyY7NTMTayb70
         6ZDF/d4dtxchHYVx67ZusIpFGnTqS28oPRpbFsIBzfterENVy/A+6Hoi+fkLSLJ78jDz
         XvCQ==
X-Gm-Message-State: AOJu0YzrXR7tzZJ/RhjId0Sd7fUsVy90q/rxPcGptIg0mAK0lkm75qHs
	RYSRtJRDmQ0X36B1+9+uMRq9KnJVMApvaUQonJOa3ONlroFj5PbMKlpCaIUGeOlu
X-Gm-Gg: ATEYQzz3K9liKeSaunhSLNOEB3FbXAXtJ+nYpskQTkVuCgi5bh+0RIYZn/qzUe21Q7F
	TVMoZ5IO0+RW7V9fqGDswZDtvFjD9yIk6VNFpBMZj1mANFwQfxlgn1zAVH6LbFxAShRHa48w+5O
	4Hmi90bQu91R4m35IFFbKupTbl7QVx1p5TOnZyFZmNic/qpCjHn0OhRqnjmA+j9UTULnRPZAOqu
	apX2jJq5kvpX0WOt4rS3LtddeA4uRJfM23UCWT+gHwsXk8NngvjgjnG5fnTdsiFOmr17pJuZOF7
	j70JMVS/v7f6PoLwcAEWww0VoIF7gAyZ6PSzg6rT+NNjfORUlTiBy00hsJ3MUsdPqK6bJ2dCvWL
	w29XzZUCCJErOmrNAMfbHyEEA/viVGCHp/0A9GcYLxh85saVg+8aY9ML9yoyl7MGIEKjlKj7iai
	Blf9oQBtT7qcHZ3WH+UBMKnkAWkuU=
X-Received: by 2002:a05:690c:386:b0:796:34f7:8ea2 with SMTP id 00721157ae682-798dd78031bmr133317697b3.31.1773144485165;
        Tue, 10 Mar 2026 05:08:05 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:f56b:22db:e23b:9613])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a54a46esm14838847b3.15.2026.03.10.05.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:08:04 -0700 (PDT)
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
Subject: [PATCH v1 8/8] env: move "warn_on_object_refname_ambiguity" into `repo_config_values`
Date: Tue, 10 Mar 2026 13:06:29 +0100
Message-ID: <0d37266a75333305047b76cae95595987f45b903.1773127785.git.belkid98@gmail.com>
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

The `warn_on_object_refname_ambiguity` variable was previously a global
integer, which makes it shared across repository instances in a single
process.

Move it into `repo_config_values` so the value is associated with the
repository from which it was read. This preserves existing behavior
while avoiding cross-repository state leakage and is another step
toward eliminating repository-dependent global state.

Update all references to use repo_config_values().

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
index da059d0e26..32f60f2f64 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -897,6 +897,7 @@ static int batch_objects(struct batch_options *opt)
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
 	struct expand_data data = EXPAND_DATA_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int save_warning;
 	int retval = 0;
 
@@ -969,8 +970,8 @@ static int batch_objects(struct batch_options *opt)
 	 * warn) ends up dwarfing the actual cost of the object lookups
 	 * themselves. We can work around it by just turning off the warning.
 	 */
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	if (opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH) {
 		batch_objects_command(opt, &output, &data);
@@ -998,7 +999,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f5164486ea..964c46d682 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4653,6 +4653,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	char line[1000];
 	int flags = 0;
 	int save_warning;
@@ -4663,8 +4664,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
+	save_warning = cfg->warn_on_object_refname_ambiguity;
+	cfg->warn_on_object_refname_ambiguity = 0;
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
@@ -4692,7 +4693,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
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
index 7b14c3bf9b..ddd863d293 100644
--- a/object-name.c
+++ b/object-name.c
@@ -969,11 +969,12 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
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
index 402eb1b029..cff821132b 100644
--- a/revision.c
+++ b/revision.c
@@ -2904,9 +2904,10 @@ static void read_revisions_from_stdin(struct rev_info *revs,
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
@@ -2940,7 +2941,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		read_pathspec_from_stdin(&sb, prune);
 
 	strbuf_release(&sb);
-	warn_on_object_refname_ambiguity = save_warning;
+	cfg->warn_on_object_refname_ambiguity = save_warning;
 }
 
 static void NORETURN diagnose_missing_default(const char *def)
diff --git a/submodule.c b/submodule.c
index 508938e4da..486b41011c 100644
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

