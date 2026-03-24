Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE83F7ABF
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355955; cv=none; b=pUYDPl2pilQUbve9jS/TlCVesoT/aM8HmfNN/uIfHWPpM9f/tiBJYpluYu8ugF31hCxAQPA+/97xZvuA7tC+SgtEuIQYaOY1wM6D6YokMEU1N9YpRWLJOLHz5V1LCxAzHEmxReD6XuO0WYC3+mrZ/hROZFLhagzk0kSq48Y/xQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355955; c=relaxed/simple;
	bh=Iu0EWxS0q4x018YN0U1jYVpPNgIXsEpeIqoUhIRNQX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGshMXTM8rBsIbCErBs5nnP0xGHGfIT3XeJ1VA9qiErDuUbHH37jcLcslO9iqIM9PUpr3yqIg660nJf48GW7TsVt00NwIzNJdxU7EFzbAv754MkFiMoC+uWgJTlIkxq7hwQxfR5FgH1NQrr1CVyNSrXG8cYys+XQVzHGqr6JQYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZom39vU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZom39vU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486ff201041so33385735e9.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355952; x=1774960752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS82ra0PcHlFTTKD1U+6hLtrxhfFaxKlSeiE181nzP8=;
        b=DZom39vUn6eukJXxzmgmL2M9yCKR5lFpMHMTqYjav3+PBAE7wz5etmdLT8u9WV/WTw
         UUQ2z8SuDM3N6NKJwtRFp4oDJlZFoe2lcGvjLZSCBYItGClpnXrrKb5XBUaQuTmVlcpg
         rjTP8HJLGVcm8S4E2tGndq7cCbGafDbrtWzNv6da4rLDJ4mQmmDtVqgkhqxd7ztC74qu
         vmZ4qk5BSybXCt1jO8MXaZJpmxG/wod62Zno0yKxaQZiECwTgiZScb9bE50PWzfOXOhG
         4nK3zNjeWw5aMMF66eum+fiRwlEahbV1Xw+6HHnptZXvqWEFI/jXTmoKoTx68JNt7N1H
         p/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355952; x=1774960752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS82ra0PcHlFTTKD1U+6hLtrxhfFaxKlSeiE181nzP8=;
        b=CURdiD/bqhwq4w0X7PHehMnACI7hj+BhA7zMbh9/Dh80K5zDy5xGkMIwyv/TdtZzTu
         GvgNCY48zCYumgNtReA50T55Tu+b+ZtTiTIs+FdWVG0M1wt+HNBFAmK+6JQn71vCT+3q
         Gf4ie9LIZfMsHyF1TTuiHGIBywtXJ/laTfyHLBrrHs6/ZhLNwY7Q1SBbvw3qQJzMfXip
         PKp2gbvLB0wL1vGkY/hB1k6sH170mk9/4xKhe1i+IX9ww/oaHBzBgMtgTs5S6FHopWN7
         7BDLmn2nkGLt21bhSaosGec6njVCq+u5Jx8CdmeB95Gz6BDp8c0fpFT1I5jQSB8s35eW
         ZSPg==
X-Gm-Message-State: AOJu0YwhJU3wRoQa5NeXZY/7H9qwkSyFDdGorMAuToikw9SOLJzMZRjM
	X0STyq2sQZCr0hgPR9jzMqqbHYQMil2DRINd2vPJMfbNQly/Lx4sB2Mf+TR27D/ihx0=
X-Gm-Gg: ATEYQzwZkUZXS6XIiuzVutZWaLiytQti8RXqT+Ml4J+0IRJjDAPzL+pbDEgXlD5QW6z
	PV78pCnopfY9ejhH5OrLqm+5gE3IFevD9MVBksULOXmPFvGLmi/ZUzH2oWO2LcGBKZpsi22vtLp
	epEiW2rhrzRUy9VnOplzvmShBPJEQYqjy8ZoufCX/BYe4geaYVnHrF/epQF/wg/oGKUhPnE7Nfy
	cvGhEzagK5Wxybzw6SMyHbQ4j+4Pwed+9a5j+Jc8spZOZzFYYtRsPl4tVobJYL1tKucUTFavihG
	6LT05onzV3/iY7lzXl5GgvObNVB2g8i9OnFH8chUDPpTPuYWusjj4998ITQhM0uXyPBuH+N3Zaq
	uK/pE9qM+7srj5eJiR/iw3pnPx5vkJj/evB2xPuJpx2h5EabvrC9/+zBh4FEiFJWm9+FUk4w+HG
	QlFsKgzAA2xoMhMRCMb3sRwgst4GuDgm52/85QLZeJeZdIvx2/cIA6VPjONErC1XIB
X-Received: by 2002:a05:600c:3b1e:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-486fee1ab10mr223040815e9.24.1774355951923;
        Tue, 24 Mar 2026 05:39:11 -0700 (PDT)
Received: from pop-os.localdomain ([102.88.113.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fd2c4esm32049815e9.4.2026.03.24.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:39:11 -0700 (PDT)
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
Subject: [PATCH v2 2/8] environment: move "check_stat" into `struct repo_config_values`
Date: Tue, 24 Mar 2026 13:37:44 +0100
Message-ID: <20260324123750.157143-3-belkid98@gmail.com>
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

