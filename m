Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727F1F7557
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237057; cv=none; b=XzhfjYJxemAaySftycfSBK0s2XsPCLnxiTsxVaciwY82OUxBlY7DyRKZkP/daTprUQNL5N0yg5y2d4oAGBgl0R/Iu7T85xnj0GuL8nHhhwP/4uVMnPahjqPiPc7EjD04rJKSP54Csxn4NxVR1gZJUez/Kf813lwWKlthhmKTSE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237057; c=relaxed/simple;
	bh=OjfNsaizNKUeavX9nA016cLiACNMXukHbje3II0XW/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4WbcX3XyWG7ZBWg0541IOw60bBNqrbflKLctUK8RKEguMWkJeQLzku5VgdqiMc+q8270La0yC4c6q9kp710bhvIhwC1qUHlcigNuFBSL9EbEqsOLGDwFMUBUGG2R1OKAAY9XR4zGafatUEM+av8B329riUbkeONUdPd3v81eoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpa/lzWX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpa/lzWX"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso739892266b.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237054; x=1733841854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZFgPzVJHQ3yC7i60MvhG+rvUFiOHrUley1ktvUV0rc=;
        b=mpa/lzWXFFLh/55wBp3riCc/VsYeBy61XwPV/y/rv10lu8TST17sBtPvESOxViD7Ui
         gfmKW27ts/LHsEW/mf0Hb1VrG561kuMSJvaSR5gPricdPyb3OcMgc4bMAQOxbsog0yNZ
         GpgO0QH4ZVoBuo5Hxb6RDE86oKDH9DAhYoFZud0fFEdYGy/jJDr/P8N3AF7dZ6ZGzD+6
         u4hB+Z94SUo0nXiu2JRSlncOYt/PTyXvz4N+ldgQQLZt5wdl5s2Ol4xS9EDFy3Shxmy8
         jQIaKXACbDXAD2GKZE/n+zzO0jJ21o/hRYQwtLRROH4uIUqMkpqlK2IdLpK/Y8Pqd01i
         yuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237054; x=1733841854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZFgPzVJHQ3yC7i60MvhG+rvUFiOHrUley1ktvUV0rc=;
        b=gip1NovhgZd8im9/rV20+GJAXD24sSNtKxisgz9Soa9D09SjRwu39TkpZHPoo3rkOT
         yMR7jyw43HH9rs3h66fa1VrzoVJLR/BjdsVxcGpFf4T9gwZ4cPfK6eg39Quzb6Kmrkoz
         HVccTO1hm35sIR2BDUdVeIMJiOLuXtUSjpNBwNsi2q/H75NI9NmFvUHjk177f3K99K3I
         JHfrqOY5fd8yi3d0wXD98wQvu82pVxA2KtzbBT2i6rXhwSCeInawPs/eAV0ICCuO0Ry5
         Sp6MN/SF7Qib+1AphsGjDKjhslbqeN/oujL4FNOqnOjwZixzXBxHd3wTGzRzzgAE0xYo
         FpAQ==
X-Gm-Message-State: AOJu0Yw+HPr7J4ldUXj/CvLbkqWEPEGg4Ya4ofbkPyfNzRMFOR90Uovh
	LETwQw2pC9JcY4Z0eDfwGbDtFAO6jHSpJsgRPQ3qplVja+Z5Wk+x2oRbDcVp
X-Gm-Gg: ASbGncubOhbwHOWpHuYbAt13OZaM5Hfdz6jkyWFE/KKX6iv4HjdXQ1IbOZ56X4GMBRp
	qbuMu+1wu+xvny3UH5NumOP95cGzW49XkFGQL1Ys9VRxYJfYwZ5WqYG7qAsfhAbpvzOaUlEgq9+
	dkzzZUx0sxCfJ5SyGmmrt+kEF0fS267D0ddiN3ZWEEw44UVaFTpl4HS6tQxZUaz18cmdFdXRMA9
	pSRyttl4O+0e7+A86rc5Sf8InC05AjAy6zxS+/aKpA3a5JW9/HzsQg+O5ZUX4uyzqDn
X-Google-Smtp-Source: AGHT+IFyv1Wf34ocCveDrvwar/D1P2pyl3CPncIUB8Pn7guQolP3V0mqVALFfLiuZx6Ht94o7u+JDA==
X-Received: by 2002:a17:907:7846:b0:a9e:441c:f74d with SMTP id a640c23a62f3a-aa5f7d61c72mr199945066b.16.1733237053370;
        Tue, 03 Dec 2024 06:44:13 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de782sm619021466b.56.2024.12.03.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:44:13 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v10 08/10] config: make `packed_git_(limit|window_size)` non-global variables
Date: Tue,  3 Dec 2024 15:44:02 +0100
Message-ID: <6e55daf5b36c748a0c5f794c9bf6c09efe477fe5.1733236936.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733236936.git.karthik.188@gmail.com>
References: <cover.1733236936.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variables `packed_git_window_size` and `packed_git_limit` are global
config variables used in the `packfile.c` file. Since it is only used in
this file, let's change it from being a global config variable to a
local variable for the subsystem.

With this, we rid `packfile.c` from all global variable usage and this
means we can also remove the `USE_THE_REPOSITORY_VARIABLE` guard from
the file.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c |  4 ++--
 config.c              | 17 -----------------
 environment.c         |  2 --
 packfile.c            | 23 +++++++++++++++--------
 packfile.h            |  2 +-
 repo-settings.c       | 13 +++++++++++++
 repo-settings.h       |  4 ++++
 7 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3ccc4c5722..0ece070260 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3539,7 +3539,7 @@ static void parse_argv(void)
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    struct repository *repo)
 {
 	unsigned int i;
 
@@ -3660,7 +3660,7 @@ int cmd_fast_import(int argc,
 		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)((tree_entry_allocd + fi_mem_pool.pool_alloc) /1024));
 		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
-		pack_report();
+		pack_report(repo);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
 		fprintf(stderr, "\n");
 	}
diff --git a/config.c b/config.c
index 728ef98e42..2c295f7430 100644
--- a/config.c
+++ b/config.c
@@ -1493,28 +1493,11 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.packedgitwindowsize")) {
-		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_ulong(var, value, ctx->kvi);
-
-		/* This value must be multiple of (pagesize * 2) */
-		packed_git_window_size /= pgsz_x2;
-		if (packed_git_window_size < 1)
-			packed_git_window_size = 1;
-		packed_git_window_size *= pgsz_x2;
-		return 0;
-	}
-
 	if (!strcmp(var, "core.bigfilethreshold")) {
 		big_file_threshold = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
-	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_ulong(var, value, ctx->kvi);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			auto_crlf = AUTO_CRLF_INPUT;
diff --git a/environment.c b/environment.c
index 8e5022c282..8389a27270 100644
--- a/environment.c
+++ b/environment.c
@@ -49,8 +49,6 @@ int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
-size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
-size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 char *editor_program;
 char *askpass_program;
diff --git a/packfile.c b/packfile.c
index 64248ca664..2e0e28c7de 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -46,15 +45,15 @@ static size_t pack_mapped;
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
-void pack_report(void)
+void pack_report(struct repository *repo)
 {
 	fprintf(stderr,
 		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
 		"pack_report: core.packedGitWindowSize = %10" SZ_FMT "\n"
 		"pack_report: core.packedGitLimit      = %10" SZ_FMT "\n",
 		sz_fmt(getpagesize()),
-		sz_fmt(packed_git_window_size),
-		sz_fmt(packed_git_limit));
+		sz_fmt(repo->settings.packed_git_window_size),
+		sz_fmt(repo->settings.packed_git_limit));
 	fprintf(stderr,
 		"pack_report: pack_used_ctr            = %10u\n"
 		"pack_report: pack_mmap_calls          = %10u\n"
@@ -650,8 +649,15 @@ unsigned char *use_pack(struct packed_git *p,
 				break;
 		}
 		if (!win) {
-			size_t window_align = packed_git_window_size / 2;
+			size_t window_align;
 			off_t len;
+			struct repo_settings *settings;
+
+			/* lazy load the settings in case it hasn't been setup */
+			prepare_repo_settings(p->repo);
+			settings = &p->repo->settings;
+
+			window_align = settings->packed_git_window_size / 2;
 
 			if (p->pack_fd == -1 && open_packed_git(p))
 				die("packfile %s cannot be accessed", p->pack_name);
@@ -659,11 +665,12 @@ unsigned char *use_pack(struct packed_git *p,
 			CALLOC_ARRAY(win, 1);
 			win->offset = (offset / window_align) * window_align;
 			len = p->pack_size - win->offset;
-			if (len > packed_git_window_size)
-				len = packed_git_window_size;
+			if (len > settings->packed_git_window_size)
+				len = settings->packed_git_window_size;
 			win->len = (size_t)len;
 			pack_mapped += win->len;
-			while (packed_git_limit < pack_mapped
+
+			while (settings->packed_git_limit < pack_mapped
 				&& unuse_one_window(p))
 				; /* nothing */
 			win->base = xmmap_gently(NULL, win->len,
diff --git a/packfile.h b/packfile.h
index addb95b0c4..58104fa009 100644
--- a/packfile.h
+++ b/packfile.h
@@ -89,7 +89,7 @@ unsigned long repo_approximate_object_count(struct repository *r);
 struct packed_git *find_oid_pack(const struct object_id *oid,
 				 struct packed_git *packs);
 
-void pack_report(void);
+void pack_report(struct repository *repo);
 
 /*
  * mmap the index file for the specified packfile (if it is not
diff --git a/repo-settings.c b/repo-settings.c
index acc27eb8fe..9d16d5399e 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -128,6 +128,19 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_ulong(r, "core.deltabasecachelimit", &ulongval))
 		r->settings.delta_base_cache_limit = ulongval;
+
+	if (!repo_config_get_ulong(r, "core.packedgitwindowsize", &ulongval)) {
+		int pgsz_x2 = getpagesize() * 2;
+
+		/* This value must be multiple of (pagesize * 2) */
+		ulongval /= pgsz_x2;
+		if (ulongval < 1)
+			ulongval = 1;
+		r->settings.packed_git_window_size = ulongval * pgsz_x2;
+	}
+
+	if (!repo_config_get_ulong(r, "core.packedgitlimit", &ulongval))
+		r->settings.packed_git_limit = ulongval;
 }
 
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
diff --git a/repo-settings.h b/repo-settings.h
index 10a6f7ed64..93ea0c3274 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -59,6 +59,8 @@ struct repo_settings {
 	int warn_ambiguous_refs; /* lazily loaded via accessor */
 
 	size_t delta_base_cache_limit;
+	size_t packed_git_window_size;
+	size_t packed_git_limit;
 };
 #define REPO_SETTINGS_INIT { \
 	.index_version = -1, \
@@ -66,6 +68,8 @@ struct repo_settings {
 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
 	.warn_ambiguous_refs = -1, \
 	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
+	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
+	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
 }
 
 void prepare_repo_settings(struct repository *r);
-- 
2.47.1

