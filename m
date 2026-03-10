Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71138B125
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144462; cv=none; b=WKj8N2y8ot/+65qqefitL2SwlRPk20L5iLg0vLW1QWZveB0FzyabqoT4emMQreB3QRHQrZ6b39NpwZyvdZGTjtv/U/fV5EBrD0Jyes+0LwxawVF8MDN/IXYuE/6fN1CszcBXlckNr9TEcUIp1MFNXSTlZWGR5GukUzwdEvsCCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144462; c=relaxed/simple;
	bh=Iu0EWxS0q4x018YN0U1jYVpPNgIXsEpeIqoUhIRNQX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUI6/Kx5yGJoWlaqz5Ud8VTKjPtA/ZqXrQ1ZXRVCZGgqV4G7EDw3wUnbYPqbKIJkysd6RU+1mg3hN3cK/nnPmN7CNIbKYDT2UN5a0aH+vYuBXg5eS36qqkcF05Gzd3jCIieSCGijhDHZi6qsRpYKMjaCoMq+TomTai00JqZgzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CekoWID2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CekoWID2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7985ce90542so122777827b3.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144460; x=1773749260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS82ra0PcHlFTTKD1U+6hLtrxhfFaxKlSeiE181nzP8=;
        b=CekoWID2GAgGYah/0GnYdZ9/OjJeXsHwf4Np3GG94WjQvAnUkobGA2RmsySmN0xhn+
         pi5yQRoYbu9QRWS41q13aGrPhSCUGo04fUr8TWgQOL/xXKQT78wXlpMi26PWH7usW+P9
         MyQr0/bLaqloAZw5zF0ilFHSNKKQb/B+vk4gyey+ZJDI1mHRwb2db36I/SDzuWgxSfBu
         H6bF5YmXknBbllCgCuj6xmgCKtNhNvaBwDcybDjkiCfUqvnDAtPS0ctZ+XBHLYTjHBRv
         QXCJM77K/lAKs810rTqC/8p9IBjDd/nkie56g4pvTrz0xpBMmvWaFpQSKWZcfXy2MEqN
         8/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144460; x=1773749260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS82ra0PcHlFTTKD1U+6hLtrxhfFaxKlSeiE181nzP8=;
        b=XJMLrXvCQXyfPVATjKdpG2DhNjXvEeSpuBiZoaK+rkr9bt1KDnkJwBtx43zXThx7id
         OoQMR19L7cu2+18+B5X3m9Icabo9mQthpYMB1/rmv3v+7m06nTAViY29nXRgSH3lI/8z
         J7BffwbHneAHEfjIj/mLJirrfpLlgxgoqXHkWDHVP+Xh80kTevp50qpcdRNWfkVM3VSh
         YtPTavSXMrD9sr2Wer0Ok06xn79kxztqBiQYj1yomArilyXrUiWS3bmcByyIeE7RcAVR
         reqGpKYkz7psLrHvnAHzgiktdpFqeMK2t/05FMBEnIJWC39j73Wumj+vQ/XrOWEmC/M7
         w+JQ==
X-Gm-Message-State: AOJu0Yw0mNAm0ZLCXyJyAC+U7fBIxyj5SDsSZsIMhOEcox8ropUoePlE
	n/KLora9X4HxvUlCNOXuJudh0H+0KL6liRX7kOwfyE+eZg3wDF19XatWDSix4+vHvug=
X-Gm-Gg: ATEYQzxa7f6h8Gjhf8LTfIZjfkPhH82AhTRBrXngrQ64Bpvr3g/Rf4ijPRWzlyMMOQA
	DB8IeHxpCttiEO++vHS/Pq4+UQ0O8ChVaBXWLgd5ZsA2v65s3UB2AiEoWxjf8c7oPnIulLoSqOZ
	ZaNjj0A39F70ZVrgMdlGbbEMaj5tUBySlcYWjBXi35XW3jXtg8YyCOD+fgDygvjFlxx2IU8LJAu
	0BuVvOcgqjCQID1SFPxtMZy5AaywyNN4eYB2WK6sYN2SJHTIIXlHerS0xEwDeLz2wzeydV1oVkK
	FlyC0OyaTbB9I+tU9oaICbsNRxWMkirp1pxd3OnCO8UluXsGuJQ9vd+ByZOFfBujxPkKMEsURm6
	gZc/yfTwV0bjXaIUmwFmWxRAYpoyE/hgNv2Zh6aRD5kXeAFPAq0Vg8+z7J67WkHhGNOv7P7hFEe
	DSHjl4MQtnSG8NjfBckqHtnJ8vXDw=
X-Received: by 2002:a05:690c:c510:b0:798:c5cf:8a1c with SMTP id 00721157ae682-798dd7a5aa1mr141931957b3.45.1773144459806;
        Tue, 10 Mar 2026 05:07:39 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:f56b:22db:e23b:9613])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a54a46esm14838847b3.15.2026.03.10.05.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:07:39 -0700 (PDT)
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
Subject: [PATCH v1 2/8] environment: move "check_stat" into `struct repo_config_values`
Date: Tue, 10 Mar 2026 13:06:23 +0100
Message-ID: <1cd8f88a3de4b81a37bdb86672b7d394d7232117.1773127785.git.belkid98@gmail.com>
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

The `core.checkstat` configuration is currently stored in the global
variable `check_stat`, which makes it shared across repository
instances within a single process.

Store it instead in `repo_config_values` so the value is associated
with the repository from which it was read. This preserves existing
behavior while avoiding cross-repository state leakage and continues
the effort to reduce reliance on global configuration state.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 entry.c       |  3 ++-
 environment.c |  6 +++---
 environment.h |  2 +-
 statinfo.c    | 10 +++++-----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/entry.c b/entry.c
index 7817aee362..c55e867d8a 100644
--- a/entry.c
+++ b/entry.c
@@ -443,7 +443,8 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 static void mark_colliding_entries(const struct checkout *state,
 				   struct cache_entry *ce, struct stat *st)
 {
-	int trust_ino = check_stat;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+	int trust_ino = cfg->check_stat;
 
 #if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
 	trust_ino = 0;
diff --git a/environment.c b/environment.c
index 0a9067729e..8542ac3141 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ static int pack_compression_seen;
 static int zlib_compression_seen;
 
 int trust_executable_bit = 1;
-int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
@@ -315,9 +314,9 @@ int git_default_core_config(const char *var, const char *value,
 		if (!value)
 			return config_error_nonbool(var);
 		if (!strcasecmp(value, "default"))
-			check_stat = 1;
+			cfg->check_stat = 1;
 		else if (!strcasecmp(value, "minimal"))
-			check_stat = 0;
+			cfg->check_stat = 0;
 		else
 			return error(_("invalid value for '%s': '%s'"),
 				     var, value);
@@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->apply_sparse_checkout = 0;
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
 	cfg->trust_ctime = 1;
+	cfg->check_stat = 1;
 }
diff --git a/environment.h b/environment.h
index 64d537686e..1d3e2e4f23 100644
--- a/environment.h
+++ b/environment.h
@@ -92,6 +92,7 @@ struct repo_config_values {
 	char *attributes_file;
 	int apply_sparse_checkout;
 	int trust_ctime;
+	int check_stat;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -162,7 +163,6 @@ extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
-extern int check_stat;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
diff --git a/statinfo.c b/statinfo.c
index 4fc12053f4..5e00af127d 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -68,19 +68,19 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 
 	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (cfg->trust_ctime && check_stat &&
+	if (cfg->trust_ctime && cfg->check_stat &&
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
-	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
+	if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (cfg->trust_ctime && check_stat &&
+	if (cfg->trust_ctime && cfg->check_stat &&
 	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
 		changed |= CTIME_CHANGED;
 #endif
 
-	if (check_stat) {
+	if (cfg->check_stat) {
 		if (sd->sd_uid != (unsigned int) st->st_uid ||
 			sd->sd_gid != (unsigned int) st->st_gid)
 			changed |= OWNER_CHANGED;
@@ -94,7 +94,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 	 * clients will have different views of what "device"
 	 * the filesystem is on
 	 */
-	if (check_stat && sd->sd_dev != (unsigned int) st->st_dev)
+	if (cfg->check_stat && sd->sd_dev != (unsigned int) st->st_dev)
 			changed |= INODE_CHANGED;
 #endif
 
-- 
2.53.0.155.g9f36b15afa

