Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6C3E5ECF
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355963; cv=none; b=dBPeY6w1bhqAcxDtqWF77Xf0Tt1FbjK0l3itRuM4lALRHXOMLZlezxfGWPxKmJWgf59h294xIFPHyu/oLzra6CSbHh8H/Rnzd6Lh7P89uMCybHhWEWlNmnLWR/KiJJ92/jLg4hcDUvlykOcB2LT/9eGUGJgT5+IchLjYxDfUczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355963; c=relaxed/simple;
	bh=ci0Lk3CzqsE19Nzs14YbEXzImrvyQqLcU503tWrhon8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3pQFOjDeqCAxLF43iXAw+haAgFoIEm3iczIzgLr0cDZSzMjF42G5z32+u5BtFc3Dnwde4bnAZtEf3G51E3ub1+RGh6FRHGtDNBgwGa9Bvci3ww3HdomZyQt1nZg6VzY9iMc5IgFeVSbMiHLgmjXh46iCvHZGuccZJONQ/bj8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyeXJ3yG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyeXJ3yG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so13786645e9.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355960; x=1774960760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9VCTDb59i4xUByEkU4q/QiVGJ9e6dqRb88+lDFK4P0=;
        b=kyeXJ3yG8n4tz5u/5vGVkafIaWybLHOmF/AfByk2Xq6TBOnF10JFLxnLsndB9Rszdg
         8LXxypeIc+mOvl8vsxPnQIgAG5IhrEeW74d5zUsKrj9Z6q6b5ubQEZigmr+4MLxdkthI
         5BC33wVOpYRD3TcrFDCdpZQ5QojK3lnAZ1lau8VqIWBbv8QsOWHogLM9R8dLf1iEtLS2
         XWkOIeoQuEz7JdKDUAiRqOv/1hcIVriee6uhD3k/3cu57sL3tsZjwOwz883jQ07Pc4pY
         0UkvJ9igFu6kMsSyWEiFoxOxLTAopNysdIn37lKnjdlEC1vPO/dOd2tGwkVpAEBPjYdN
         tSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355960; x=1774960760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9VCTDb59i4xUByEkU4q/QiVGJ9e6dqRb88+lDFK4P0=;
        b=lunYofY54Z/7aT1uauLIAu8aisEsmtmGcim9HNRoGXYoBxupCn5fzHwRnFWDWZmkA3
         4fprtwtyjVDo+3dEPQ5dv7+xzSRlKPbnDvRvb2E1ya7yOT0G3LMLIRGDxK5iouYXLGnE
         3l/76TSGSZ2BdSR33bMuPB902pQnF+FV1cThBx1/0Lil9M/u0FlDpYkGHQFZW9mSGale
         uuCcNVUCMEK+k85M+icdfceI4KIcLINN609gXSDX5Jr8TtymQYKNYR17i9eEBj16ztM5
         20Arp40HJVgFy53i6JmiVdH3HApKVbbubaWAGVA9bneo7siFu0EuzSNRHHLkMXcH454R
         ktYg==
X-Gm-Message-State: AOJu0YxJpX/Q7efpuvhcBL5AVB0r6o8JNixQMVPzkeBtbLQF286a6s0M
	l/JhXbiaynLwYnBez2bpZEqwtEj3AjuhXZtb7DZCnmyaKqmWUHoDXLC1KamB1wNG
X-Gm-Gg: ATEYQzyiRLK3la45jkiHbkrQ0MT7DUUJEanInPeOvbg2dc5dado6X6nEKOsIdElkArU
	ED4ZTWje5slkX6GFe0wKIrmE5EYTgd8eeV+hrZ7sVequ/x1KLtYx5ZCe9sJL9VOzpLTouW33gXG
	9U/cfHRzigl1sNc8QiRD6NaOrLkJNjY8oaEYbFwlFKQHGteavtNWTmUIYI1N/SDpvcBBKUdzE6p
	24OoTBVMjj+hniN6ufbtqVIiG3KgVUfpcfHw6wcu+VuFWuvx5MrUy9nuYcfF6or1+7oIORqzYGL
	3kRa6L4UXQxRgcirVoCaqpau+cRah395O5lQkhR92etKU8sgz1RZy9XrU0PaKOSGyvUWeRGP2kj
	QL5k4KBWBCgkey1zFcGQl/6ryA+r2YvfGmJaPSxr4O5kJeYDrvC91n+3nwGKbGhWcI8+csevwbI
	kWYq7P8WSFAB/FQDMDWYWTdgHTz7dlaNGdKRTVjR4n4hTntM6gcS9tabQ9JGkFUy0I
X-Received: by 2002:a05:600c:45c4:b0:486:f308:94ec with SMTP id 5b1f17b1804b1-486fee227f8mr212802775e9.24.1774355959928;
        Tue, 24 Mar 2026 05:39:19 -0700 (PDT)
Received: from pop-os.localdomain ([102.88.113.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fd2c4esm32049815e9.4.2026.03.24.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:39:19 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 5/8] environment: move "precomposed_unicode" into `struct repo_config_values`
Date: Tue, 24 Mar 2026 13:37:47 +0100
Message-ID: <20260324123750.157143-6-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260324123750.157143-1-belkid98@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `core.precomposeunicode` configuration is currently stored in the
global variable `precomposed_unicode`, which makes it shared across
repository instances within a single process.

Store it instead in `repo_config_values` so the value is associated
with the repository from which it was read. This preserves existing
behavior while avoiding cross-repository state leakage and is another
step toward eliminating repository-dependent global state.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 compat/precompose_utf8.c | 20 +++++++++++++-------
 environment.c            |  4 ++--
 environment.h            |  2 +-
 upload-pack.c            |  3 ++-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 43b3be0114..0e94dbd862 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -48,16 +48,18 @@ void probe_utf8_pathname_composition(void)
 	static const char *auml_nfc = "\xc3\xa4";
 	static const char *auml_nfd = "\x61\xcc\x88";
 	int output_fd;
-	if (precomposed_unicode != -1)
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
+	if (cfg->precomposed_unicode != -1)
 		return; /* We found it defined in the global config, respect it */
 	repo_git_path_replace(the_repository, &path, "%s", auml_nfc);
 	output_fd = open(path.buf, O_CREAT|O_EXCL|O_RDWR, 0600);
 	if (output_fd >= 0) {
 		close(output_fd);
 		repo_git_path_replace(the_repository, &path, "%s", auml_nfd);
-		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
+		cfg->precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
 		repo_config_set(the_repository, "core.precomposeunicode",
-				precomposed_unicode ? "true" : "false");
+				cfg->precomposed_unicode ? "true" : "false");
 		repo_git_path_replace(the_repository, &path, "%s", auml_nfc);
 		if (unlink(path.buf))
 			die_errno(_("failed to unlink '%s'"), path.buf);
@@ -69,14 +71,16 @@ const char *precompose_string_if_needed(const char *in)
 {
 	size_t inlen;
 	size_t outlen;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	if (!in)
 		return NULL;
 	if (has_non_ascii(in, (size_t)-1, &inlen)) {
 		iconv_t ic_prec;
 		char *out;
-		if (precomposed_unicode < 0)
-			repo_config_get_bool(the_repository, "core.precomposeunicode", &precomposed_unicode);
-		if (precomposed_unicode != 1)
+		if (cfg->precomposed_unicode < 0)
+			repo_config_get_bool(the_repository, "core.precomposeunicode", &cfg->precomposed_unicode);
+		if (cfg->precomposed_unicode != 1)
 			return in;
 		ic_prec = iconv_open(repo_encoding, path_encoding);
 		if (ic_prec == (iconv_t) -1)
@@ -130,7 +134,9 @@ PREC_DIR *precompose_utf8_opendir(const char *dirname)
 
 struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	struct dirent *res;
+
 	res = readdir(prec_dir->dirp);
 	if (res) {
 		size_t namelenz = strlen(res->d_name) + 1; /* \0 */
@@ -149,7 +155,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 		prec_dir->dirent_nfc->d_ino  = res->d_ino;
 		prec_dir->dirent_nfc->d_type = res->d_type;
 
-		if ((precomposed_unicode == 1) && has_non_ascii(res->d_name, (size_t)-1, NULL)) {
+		if ((cfg->precomposed_unicode == 1) && has_non_ascii(res->d_name, (size_t)-1, NULL)) {
 			if (prec_dir->ic_precompose == (iconv_t)-1) {
 				die("iconv_open(%s,%s) failed, but needed:\n"
 						"    precomposed unicode is not supported.\n"
diff --git a/environment.c b/environment.c
index d0d3a4b7d2..739b647ebe 100644
--- a/environment.c
+++ b/environment.c
@@ -72,7 +72,6 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
-int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 
 #ifndef PROTECT_HFS_DEFAULT
@@ -532,7 +531,7 @@ int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.precomposeunicode")) {
-		precomposed_unicode = git_config_bool(var, value);
+		cfg->precomposed_unicode = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -723,4 +722,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
+	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 }
diff --git a/environment.h b/environment.h
index 514576b67a..508cb1afbc 100644
--- a/environment.h
+++ b/environment.h
@@ -95,6 +95,7 @@ struct repo_config_values {
 	int check_stat;
 	int zlib_compression_level;
 	int pack_compression_level;
+	int precomposed_unicode;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -174,7 +175,6 @@ extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
 extern unsigned long pack_size_limit_cfg;
 
-extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
diff --git a/upload-pack.c b/upload-pack.c
index 88dac1b65c..afa3ef7655 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1288,6 +1288,7 @@ static int upload_pack_config(const char *var, const char *value,
 			      void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
@@ -1318,7 +1319,7 @@ static int upload_pack_config(const char *var, const char *value,
 		if (value)
 			data->allow_packfile_uris = 1;
 	} else if (!strcmp("core.precomposeunicode", var)) {
-		precomposed_unicode = git_config_bool(var, value);
+		cfg->precomposed_unicode = git_config_bool(var, value);
 	} else if (!strcmp("transfer.advertisesid", var)) {
 		data->advertise_sid = git_config_bool(var, value);
 	}
-- 
2.53.0.155.g9f36b15afa

