Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141042773F7
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328634; cv=none; b=jnr7ZUM+1aH8bnWCI21tth6Xlq8ANe8sZH2MzNmGKRiejS+rnPlpihiqX1NwbJ3nsk4E9/qWW4Ghme9xWlwY4RpMFy1QxdQYUJdHgbZ7gBCJ1PQsdK8QhfrPjAyUZKN38Dl2MYWXArylwKuwljbwV8NpNg3OEgFMBPHLcFPlU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328634; c=relaxed/simple;
	bh=Ns7EVHYX96JTmi55Gb5fbHzY0yUltDOuoBy00KVd9+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2GrCnTj66ixHW/B4YjIneaIVLu3T0yJxaszHVoQ7VUl8E0jd+Weuds2cOF3wmtR+++fWq4T+pl5g+whAVejpDEzTih1MGpyJHB31Zx8ozx+NBBnKddanXVZw55Xzkp95OEHdyMIZvu35uTwrWvZAFtNPlUl7KSh6/GHDBjuswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq5DV/Zn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq5DV/Zn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4905529b933so78849625e9.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328631; x=1780933431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UIpsItiFR+iUXIEX0r0lmV1Ig3n9ALonrgv+Rn+uWI=;
        b=Xq5DV/ZnCRe2ey936pU4XZors3UrGTnS1B346imHfTNS1IULJ7q42voRCNUfzKF7QE
         Br+wT3N/ZIAlAlvnQCdjqHVac2uDqgis732zhEF0O1r8oAwXdrXE9nUMBGhzQ57QTHgq
         a1BYkR2W/3Zgm4z0TvKwyn06/z8kroi7S+7+Mym2AnOHqRGcTtnfB6k55ZRASE3LpVNm
         XxU0yhUicToXkgF3E1Qlfudmwvu/HjgtfaeD3DnOmvraBsLyit/cRR7zEiV6BLTWGM1U
         Q725nedlVjYtXwC13Z4CZ1P8vBoLME3ptzeO+8SF41jb5w2jJE+LttUyPuRVU1mNQJgE
         ZhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328631; x=1780933431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+UIpsItiFR+iUXIEX0r0lmV1Ig3n9ALonrgv+Rn+uWI=;
        b=O35OTT0C7LDh9oGw1LcaQkSg7WqcHnXthU2ZjVo7pfghucmFjSZBewzRQArwN/yIkU
         0A6CsmonATE9CV+c4rBvBdoOAiuwmr0X24aUFC47AMu5dS7ugBiv/akfpvih3565O2HH
         tn39sKr7k1wTTMs6TmyQ1w+Lc6EcPbT3YwmcePQL4Ob/ZRhCHjeXr+p2VO15Jg5wX+Il
         i5tDQmeZNPJLZy2caVlhaD5/F2Kx6yfNgvwulO3ybnbCHMfDnJzHmMLj7kLdcs8XllBo
         59/HquYz1umQZRjcPgodqJPgaXu6JEILXufdGZAaItwjIYXYSvwSOoaCT4ICBUp2gnwV
         VV1Q==
X-Gm-Message-State: AOJu0YzA7A8LjQu7hkNxDWPwUDUcg5WVQkp+pcDNfvl7WMMx13Uyf5Ot
	zrZYf5UTu8a0m8FSycAcT9doas5N6OmgyPUHQYfjcvQ7vgrWTQwLKQO1Ym0Uru8k
X-Gm-Gg: Acq92OF1l4GzQg4Y+04jtIunoiZFDtF6h2c0dmGbOY3eI7qbVibSuv/nuKLLdbJjiJm
	x6v2qT/vbpu0Vxm7tNItFdlEID+YUsucG/vzfNIWq5P3DbUx0Ekfh6MvpAjwBfE/CTiGaJcpYNE
	HiLAG+Csz/9vM+n30IXTtKK9/rM/A3UkbTsWFjZSZTlxjOX6Vapr0zZbtMJVKKIC/R85DqMsH9h
	WZfUiF3oQXl2MHerDSSf4lObMCypBcnn0yofrBPl+cj7wDehBb14DGHmIPDOtlakbqpXpXXN8Jn
	7N6/3tN83FzZAV93GaC67Te8DL6Vc2h9/81OHUYeYCr50DPg+roiUaNp2PAjkcctymtAOp+bYsq
	v0dwcw2eF2SgC8mIPVRWRlxDYA1Qq2yVswMG/Qfi1E6CVjH7jDfzzSbzlGWGVSl2zcYod4RcKWL
	4XqgdCKq2HJW37nXaU15EPQY0LU3SIP1XdQPatb/2uvsdxeFcoKnRpKVtvUJZKpyD7ZeMiC3m7Z
	FmB
X-Received: by 2002:a05:600c:6091:b0:490:6237:521b with SMTP id 5b1f17b1804b1-490a2b6b21cmr217323625e9.27.1780328631217;
        Mon, 01 Jun 2026 08:43:51 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e07:e310:19bb:fe0b:a332:fe8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e81ef4sm350485e9.12.2026.06.01.08.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:43:50 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 2/8] environment: move "check_stat" into `struct repo_config_values`
Date: Mon,  1 Jun 2026 16:42:05 +0100
Message-ID: <20260601154211.82370-3-belkid98@gmail.com>
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

The `core.checkstat` configuration is currently stored in the global
variable `check_stat`, which makes it shared across repository
instances within a single process.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. `core.checkstat` is parsed eagerly
because it controls how `match_stat_data()` and related functions
decide file freshness; a lazy parse could lead to unexpected
behavior or complicate libification. This preserves the existing
eager‑parsing behavior while tying the value to the repository it
was read from, avoiding cross‑repository state leakage, and
continuing the effort to reduce reliance on global configuration
state.

Update all references to use `repo_config_values()`.

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

