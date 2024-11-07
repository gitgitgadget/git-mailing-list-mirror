Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61820FAA9
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988653; cv=none; b=a5ZURoTtk37xoXKGL3Mdpw5qPlsfGi7FgQjuOXEvfz7WUVv+rK+EYSgDBmEw8SzYnK48+Wl/9IhLA7+v5gxuuV8z2YjYyWUYByCjpcwewIRobQA48dj0JapsJk6mi3D4GdB5vppL7TORjl2u1jxjP5eMdIxY7GoZ8RYUC5h0xhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988653; c=relaxed/simple;
	bh=dOJHLuPxr0Q38JKTZaswKT+8dDZoMOVt4TC1V1f77mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXinyDQFmU1a8fkbdtm4umfS71eUZwQRu3yFSXXWuPAHjjlghtgt6Tbs61sNn5dzqAFeVG1c9aQcufeXZ0YdwL0N6FwIjYcadhx4LSZh8qcBscbMwmR5cxyEzBmyxOQqlN0EAWL1cUXOqS+gi76yCYZzPFzwTYar3Qaw8Tisw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9u9WBJx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9u9WBJx"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso1400284a12.2
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 06:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730988650; x=1731593450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPbqnrhQLb+1FE8VDbLAskn6h2UGpd/Jd17Wgbk6W5o=;
        b=F9u9WBJxIqbnYxmSO8J47SV0LWiW1KaGK1QFlKVy3NTDFFmnBCEgasoAhZ0Ex8tNPm
         9G7iKNasQWdMzg2BQgLIZfvmhJpPin/9S2aqorZPvsK+SvVFI/Q2PTgfRhQTenpCHkDt
         WEvn8OnRsPtpIcIUIag/UIfXGBwkKyk3xECYmWPmgglKB2q5+ekrxhkw1QWXdrAtCIgX
         gFSGt8D8PCfejmwKiH4DtQMMj04EcJ7saTsfTKLzNjUueaanNbs3mIkW93zgwZRnW1di
         acyGswzyYv+UXsWGOQ+oHqGUNEC/XjwjXTTOUodllC42cFzYk7Q6Bih3/R/dLnhpKGnW
         yQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730988650; x=1731593450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPbqnrhQLb+1FE8VDbLAskn6h2UGpd/Jd17Wgbk6W5o=;
        b=oV0KbXj9/V+iDYFq1djRHmyl/w8OFPPsaHCSE4NwKm7E09fAwSs6cCwlMZVmXjjtol
         kPV3ULtIYITT+tq3xl1inU7JoslT1v/cOEIDpnqotxBRK1p6C4/HaEAjjBtvtuc+xj5H
         SBlo9aCYHK+IdK0e3lJ+IARPrSRRZ9wPEMP55bmLt9dx05AlUoUnLV/PchuCffPFTFMY
         ZRB+fxj99KXfPmCFyuXO47n9VlhcBfhI9s/14PoSDr9Y9KB+Uc1Qu+1Y2AxK3/7i1bXO
         A9tc6dK+NhYQ6jYz2UjvKMkIBmmTpYarQMbRqPIahXDNDwR+FKe5F2NybUTM9zo4uGxo
         9zZQ==
X-Gm-Message-State: AOJu0Yyph6jOaijdeD57PpDAy3mBMn/ouO4VzHSvJ9YMN7iv3UiRCRuq
	fbdjCl4t4U3721BmeQUs3roDit756YLtw8uqfsmMBHrNaVEv7cqG
X-Google-Smtp-Source: AGHT+IE2NcDgWPZrOEh2k16OpiMMnbo5rJXoOcGYCrhgQ4lRZy/k2Yr9goAyQty3XsRKi+M1BEJ4ig==
X-Received: by 2002:a05:6402:1ed4:b0:5ce:dde6:dd6f with SMTP id 4fb4d7f45d1cf-5cf08c21254mr96819a12.24.1730988649406;
        Thu, 07 Nov 2024 06:10:49 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ec90sm815424a12.58.2024.11.07.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:10:49 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v6 8/9] config: make `packed_git_(limit|window_size)` non-global variables
Date: Thu,  7 Nov 2024 15:10:35 +0100
Message-ID: <3a8e3b88df28ed65cc8fbce3d51dd1cc19581e7e.1730976185.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730976185.git.karthik.188@gmail.com>
References: <cover.1730976185.git.karthik.188@gmail.com>
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

We do this by introducing a new local `packfile_config` struct in
`packfile.c` and also adding the required function to parse the said
config. We then use this within `packfile.c` to obtain the variables.

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
 repo-settings.c       | 14 ++++++++++++++
 repo-settings.h       |  5 +++++
 7 files changed, 37 insertions(+), 30 deletions(-)

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
index 2ae35dd03f..46f5369173 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -48,15 +47,15 @@ static size_t pack_mapped;
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
@@ -652,8 +651,15 @@ unsigned char *use_pack(struct packed_git *p,
 				break;
 		}
 		if (!win) {
-			size_t window_align = packed_git_window_size / 2;
+			size_t window_align;
 			off_t len;
+			struct repo_settings *settings;
+
+			/* lazy load the settings incase it hasn't been setup */
+			prepare_repo_settings(p->repo);
+			settings = &p->repo->settings;
+
+			window_align = settings->packed_git_window_size / 2;
 
 			if (p->pack_fd == -1 && open_packed_git(p))
 				die("packfile %s cannot be accessed", p->pack_name);
@@ -661,11 +667,12 @@ unsigned char *use_pack(struct packed_git *p,
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
index 4699b4b365..0d875fdd86 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -26,6 +26,7 @@ void prepare_repo_settings(struct repository *r)
 	const char *strval;
 	int manyfiles;
 	int read_changed_paths;
+	unsigned long longval;
 
 	if (!r->gitdir)
 		BUG("Cannot add settings for uninitialized repository");
@@ -123,6 +124,19 @@ void prepare_repo_settings(struct repository *r)
 	 * removed.
 	 */
 	r->settings.command_requires_full_index = 1;
+
+	if (!repo_config_get_ulong(r, "core.packedgitwindowsize", &longval)) {
+		int pgsz_x2 = getpagesize() * 2;
+
+		/* This value must be multiple of (pagesize * 2) */
+		longval /= pgsz_x2;
+		if (longval < 1)
+			longval = 1;
+		r->settings.packed_git_window_size = longval * pgsz_x2;
+	}
+
+	if (!repo_config_get_ulong(r, "core.packedgitlimit", &longval))
+		r->settings.packed_git_limit = longval;
 }
 
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
diff --git a/repo-settings.h b/repo-settings.h
index 51d6156a11..b22d6438e2 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -57,12 +57,17 @@ struct repo_settings {
 
 	int core_multi_pack_index;
 	int warn_ambiguous_refs; /* lazily loaded via accessor */
+
+	size_t packed_git_window_size;
+	size_t packed_git_limit;
 };
 #define REPO_SETTINGS_INIT { \
 	.index_version = -1, \
 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
 	.warn_ambiguous_refs = -1, \
+	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
+	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
 }
 
 void prepare_repo_settings(struct repository *r);
-- 
2.47.0

