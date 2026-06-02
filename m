Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E273F54B4
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420252; cv=none; b=ObhzYnhT67ufvOGeTPX7WLHpTdjzzEurCAFAKo4nX3Ghom69QjdfIZFxZgt5qBUtHhq7C35DPUtxpK4AnJ9lD4/thD8E/MShH/X4J19Dk1bNh/gV+nco+IfJOPdASEG1YiQtfegek1+I6fQIaJBhfRKECw9/w0MHAKodlvqEMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420252; c=relaxed/simple;
	bh=Ns7EVHYX96JTmi55Gb5fbHzY0yUltDOuoBy00KVd9+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMOgQtpAvc/HBV2c48t8YshqyabZj8iXkB0uFQYvmq6I1X2PSydLhUlVp0zlB/CFxl1Li+5uqDME1HbKuy1StdI1MI1Xsx9tZUjuR/abvYuv23t9h46/umdPpFaO+xi+oaGV+HIJZMIoSQBjrU++PWFyFq9W07Z+VD3IFnbNkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbQjPNcv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbQjPNcv"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ac357c55so23428755e9.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420250; x=1781025050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UIpsItiFR+iUXIEX0r0lmV1Ig3n9ALonrgv+Rn+uWI=;
        b=CbQjPNcv/I6jT5dHUiF1RTtVKTSxts71cMdjlgsD2KnNZjJusyVnw+dvjkJ3a3kAtM
         MKHtfpWJ8S+WW3ib9AwtBI2ggmUyHS71ewnqtQPn2xQi2S88gEuP4brKbkd8GBLzW+O2
         jWEyoLw18iZN6eVklSIt1FEO0NNY/N+A87G6+rYXxOA5GPYZybHeymiqgCUDgaZwsNeI
         Ot/Xxjehxj8ZIjvQVtv45oUhiVzLEg265BMzZZQybzhGNILFPk0OYHrs802aPzvvClXa
         xZWRUtjx25F07ZUVYEPGUoVS6bCL/7Sie7DfnnDM9re/H/Dq5TQBW0HCGj03h4X3356D
         jGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420250; x=1781025050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+UIpsItiFR+iUXIEX0r0lmV1Ig3n9ALonrgv+Rn+uWI=;
        b=M9UxopyLJwljRQFRHe3s4zpr3aitL7e8MXklfWRIg1KpiBNAhGtZjW51Apz2v/eJhI
         21/QVifa2iomp2V4Fb02yDRNn4QlaWfpZdOah2uyzx3fadLS8sZ8OolLKUs0vNrhuCz5
         caSar7C9qzJUrC0crNh0STf+Dj0omYRb6Np6BJxo4RsABuaX9a1v5KGc8ZdadBYB4QtA
         jWtp+wTtX6DiG9oIHeHyk22bEnJVEn2V53D+6C/LoZPuwicIzFnoePSIo20zIKzGqhfj
         o3cNM8cY3di45/QWCTZfL/VM/cRBdbeQ1626Qtqz4fAVaROwxjwlZTRp8ALpORxa/Ijv
         P8VA==
X-Gm-Message-State: AOJu0YwM0zFcLMF/kpClaEi7TJr5fYp1q67EUZI6eNWJF5cVhZvQaJJW
	V45nR/rr7XfqFo44MJ8YH1C0MeXi5sFCNFAV6mAf9hiAmaD7QE8Fdq+at/RO+27O
X-Gm-Gg: Acq92OFU/Vn3LGxaGum4pD0jRVpg9i6eoHORme4F8yYUVI7XXx8xlihiE4vOda3zasL
	XHKDGwzafEftOoji1FzY2G0PqOJnE2oDftSmOG8te8VYv2MdghjLUAulQI8TGa4USEdyHwn6RDJ
	Lq59mlIi/n9Ia6yaRIveRm0Z8qU1pcVYeebJKB8r2VKgHh1iW6I6YZ30V2ZqSNwfmEyDloNGTLG
	rDuCcDlxV+sQLDj3TDUkYlrN6WeZA+eOKdgZmV1kw+FdhmviPHSe6UjG8Bh/8aGnHvmdZ0Pdlqs
	RkjJNQoeR4tSHXHkoGZBznsVXJBq7/r4NVnoikHtUErfsl4iXWv5GZOgQwlsa/B/efsOa+f2zKy
	PNivqkNBYHGOhhzb9BCTsaxi46tNCB4t/DFiu98iiMQ3NWtmyG6JFfpDGbNlok7NPuLUi6aLkpL
	+rXcP5CXPVWcI4l74tG0IDhMIg67BOnfqmhgRd70ATxm6RKK23wLPL+3Z+ac+oyFYxZ68QhUk=
X-Received: by 2002:a05:600c:1384:b0:490:6869:46c3 with SMTP id 5b1f17b1804b1-490b50c2008mr9349655e9.30.1780420249550;
        Tue, 02 Jun 2026 10:10:49 -0700 (PDT)
Received: from pop-os.localdomain ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e239f4sm122904265e9.7.2026.06.02.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:10:49 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 2/8] environment: move "check_stat" into `struct repo_config_values`
Date: Tue,  2 Jun 2026 18:09:15 +0100
Message-ID: <20260602170921.35869-3-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260602170921.35869-1-belkid98@gmail.com>
References: <20260601154211.82370-1-belkid98@gmail.com>
 <20260602170921.35869-1-belkid98@gmail.com>
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

