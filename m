Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242B3769EC
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328641; cv=none; b=u6Xn+AjtlftFwuFyx9j2tfBtuuXGcR0n+aU/S0tK5g+1UAd3zAD6pvTJxaKoibwxahMOK/mk/1AY3akeFNsvHCC0634K/yEqw/obJbpa62uBunwumU9HB8ASAeSecUMhcL342qUoTPGypFXyZUA2jFgIgG2+tKb47pEVUueuimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328641; c=relaxed/simple;
	bh=4yk9784iisuYZZFIEZZR/hHGPbWL2sKcxATm3h99+sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Av6s0442SvwFKcpkeri8hopl0IqRqFhsDJxAm5UGqXfLZTqvzY9ThLUdx9aFyoF15EaYAiaDS6aVW/XcIrk9gSzShQ+FYC4FX9XsNEfGZqvgPO5paZlpMnmaPhHxRPQyOhba+hFbNdqspvAVQqMB4JhvLp6Gp8DGBGx+1Ds4QiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O93Dh0eG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O93Dh0eG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so3959495e9.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328638; x=1780933438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6O7lhc3upL87bhqDgebbAITXodlhenAoe1ugIKkD0qQ=;
        b=O93Dh0eGo1YpHmOO2YvGBH8rBQFXcqtYZUx/d9s+YbFv5POf/B4/fcxN2qBRfNb+dR
         1c4fSVZwtrJRIuBZDMLWFL7CXlwEJa3ujNrjHqoQpX2OIQZPdse/EVQipFLUOPVnAMRz
         V047QBQTEWZ5DB7awfQiHDhJLEojICZpasEeWPMxAPwlVJkt63rSsdXRJek+uoFXLfX6
         zG16RZrX70l9i6BE9wSHnlA2GcBqDZQtDPGJkYS492NfCqmVitS+dZ1SDKgskxs63cL8
         OdvljnXOvhVqb3kADDXr/at/hzbMSJHnBYLNNsb/TIq8TJ4SN8kLvywgQfQIg8wW6+rx
         L3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328638; x=1780933438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6O7lhc3upL87bhqDgebbAITXodlhenAoe1ugIKkD0qQ=;
        b=X4o5AmQDQm/EiQAJsIUjtm10SPw4t7UuynSI4BVLzfUocFAE1Qq2lsfBwSuTqjWQVP
         ZnvxSw9RUqkPYljcmswRFqkDvplBWAlynu4jT2vLh5yfUZ0/SfmxWKoMuyQ3vge8iDHN
         k6SIFEgYjtOIvFIafzABNOnKVK4KeCfl0Penm3heg8dWvFF47Q8owlF1PGX2cL0O+eLF
         mqYEqhtfCDYuPQ1EMfkumEm7xOLIVmeo0RwNYEn3Ce2//MyCrHg/fPjNnEeo9ju2Ufl0
         fUsGWloIlzmoSGif9HE3+URU9Lp16BP7akJdSSiHCcSFTWABhjJY5ljd04u9Zc3kPxIY
         4DSQ==
X-Gm-Message-State: AOJu0Yx3XT61pWrGiqVihCf4nSdmiDruIpDD7jqfMbbn38+V+kK5dcIz
	nB8naKaILZtz4MfUC5DLTSakXBBknEeeBTlaYI5IqtehWfg/A7EKxKfdQDE50NiH
X-Gm-Gg: Acq92OFy0UvHg6YhtF0/4iUAB5p8XcWYZUkZxViDN2eZiXUQo/to6KGgXwY/7AJ60e+
	0dZKouapEC2KyWXmyIk65kTKF5y/SFS+M1o+KkkFizaSDzNFtDkWAv42MyPoDWpwet8sMAa+rbR
	dV63QYdSkbU/enlVQ7Q0ectEhxu4F2FGvXorDzxSiKrH23BFnk9p0oEUzkz2joM/4mAN7nnXS7d
	LzP8teIRH/+k5bRESSkRlpWWCRI7h315fhUcars/NA6PKnM7UUatx8QaTMRds/wMiYDv/ivgzPY
	6UKWVQGV8uSwgMUzeedrXBVRhz4Ha/KnLpe67P0o4anjLDBSgf/MfXOSyKDJHMzs6hiod6xYP28
	ucvGpHjg3DFvCUqrCAFwP+I8lf3r+Y8ETTDjtPg1mvSqv1R6vRfrRGq6F4a+juUM08t7QN4m8pZ
	aFFKIj5I7tcedayhyElzuFgR4EO80lHhzRmtMTEn6eWPldZTk9qvaCYfuRVV9fiEsLyw==
X-Received: by 2002:a05:600d:6413:20b0:490:890a:da46 with SMTP id 5b1f17b1804b1-490a292a4b7mr164319775e9.2.1780328638349;
        Mon, 01 Jun 2026 08:43:58 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e07:e310:19bb:fe0b:a332:fe8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e81ef4sm350485e9.12.2026.06.01.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:43:57 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 5/8] environment: move "precomposed_unicode" into `struct repo_config_values`
Date: Mon,  1 Jun 2026 16:42:08 +0100
Message-ID: <20260601154211.82370-6-belkid98@gmail.com>
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

The `core.precomposeunicode` configuration is currently stored in the
global variable `precomposed_unicode`, which makes it shared across
repository instances within a single process.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. `core.precomposeunicode` is parsed
eagerly because it controls Unicode path normalization on macOS,
a fundamental filesystem‑level behavior that many operations depend
on; a lazy parse could lead to inconsistent results and hamper
libification. This preserves the existing behavior while tying the
value to the repository from which it was read, avoiding cross‑
repository state leakage and continuing the effort to reduce reliance
on global configuration state.

Change the type of the field from `int` to `bool` since it is parsed
as a boolean value.

Update all references to use `repo_config_values()`.

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
index 9f6d6fe48c..3a52237134 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1336,6 +1336,7 @@ static int upload_pack_config(const char *var, const char *value,
 			      void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
@@ -1366,7 +1367,7 @@ static int upload_pack_config(const char *var, const char *value,
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

