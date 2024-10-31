Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C40199246
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367607; cv=none; b=mN8/JLBIDPIUUP5TKN/OiNdOqzZe54rGrv5Taobitw02nrRrYseqgMhIeyOqG1WiaqWKpMH+NO4hjY56Tbxweoo9PJjZXnWtVK56AJRjZhHv1i6m2m6x4yzFiUosFN2CMFpB72Ylcmm174NcE7GucS4BseXMKaTO0EtSwH12zss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367607; c=relaxed/simple;
	bh=RJgJhjSLG4Zt4fQ+2B2D9qNrRQCii5e7wtXV7Dlhe90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL+jV4d12Q46IZYqal/1wOlFm0SFi94IQGq1sisMy2fvMtkzjieQqaRaEpi/iFhCVqDwIXWHYAzxdGFhsfP2Px0PiB+5ZRHSoly6nUIuvUsaCQ+6UhvA+YMejh6hwIEx/g/EKRcD7yOMrZiaYoZY6bH3p1/v7rAMTMMD8pGpNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7KnpZ0T; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7KnpZ0T"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso104488666b.2
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730367603; x=1730972403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yyiQ3jcYmnLxZtvsgtVJsTgIC/uxyt3VVX+G7Zw92k=;
        b=d7KnpZ0TGFmI9j5X2VaXF12ix9vVTf4X6SPwXZHEuYioHsXqHkKrshCHawnzjLWZqL
         tw0da/AqOLt3M6kQyYTURBOyChmS8Gu9VFS5qyI2rGNWGpNQLM3PbeXbv6mCuS2vLUrD
         uL9kBcti+GcYPyh1OpVBRuqjclK0VzG0GEV4zxDc8vHtGhRLbqBGdroEFvdlqWi7dG0G
         sODwgMUsEUugVLe0xwozMPV5T6YndoYuuQCs0TLFigs5TDEONcb7VUeC2zWD3sC5IObS
         s3FVwXl2fz2XsaD9o+0j+5+5nV0HmCdBwlIzT1YIwXJnrnWxT0dFup45F67bYly4iNaN
         DwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367603; x=1730972403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yyiQ3jcYmnLxZtvsgtVJsTgIC/uxyt3VVX+G7Zw92k=;
        b=DUIgYRVtOcDfEe+6xWKp7akiJ3JZ6/pbcZ8EIbeSBmk4rC1rMU7BnzcjmShfIqRRBV
         svs+DFKva/Zxljb3VW/ZjEQIBm6ts2PE6TzkYRIG1wjZK3LT7XR5IjANGMTOlvruGKLt
         /tzxjfkQU2/sZP0CThqeFM9TqlQ42yMCwyllVfwA1TDsni16yhNgpeA14nfbkrQ7Bbfz
         NT/xkhp6pl7WBjJmdvPOf+/T0i/DPvOf71PgAx6HhD/xUQBSgBmxHWc33GZ70FEmIQxW
         pz9YnOjj1aNpFjkPWVk3tqydXMaferZvWpLcGSHWyjeQ87Emg/agsdSzRcFdgjLRPr8Z
         k6jg==
X-Gm-Message-State: AOJu0YzDMni0q9ZsTbL7CvBs8Fg/9RycsX9QnFVI5Ytr1qJ/+79YFrD1
	adzrv4hYdiiCFMolYhYaWoDNbnZ3lEG9ABfzB1UxT1ugsb7DQuZ2LY5sAd3d
X-Google-Smtp-Source: AGHT+IGjZBLnmXSW6NujVqv3GyiFa3E7c+gXve0oFNrlJsD7OJ+CsQaCukqDwWn9mepDi3sgpv6a+A==
X-Received: by 2002:a17:907:7e8b:b0:a99:fd32:11dc with SMTP id a640c23a62f3a-a9de5d858aemr1859390166b.24.1730367603346;
        Thu, 31 Oct 2024 02:40:03 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564940d5sm46399566b.26.2024.10.31.02.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:40:02 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v4 8/9] config: make `packed_git_(limit|window_size)` non-global variables
Date: Thu, 31 Oct 2024 10:39:51 +0100
Message-ID: <5bbdc7124d58526a7a2d7b3bdc807ddd204a6df1.1730366765.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730366765.git.karthik.188@gmail.com>
References: <cover.1730366765.git.karthik.188@gmail.com>
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
 builtin/fast-import.c |  4 +--
 config.c              | 17 -------------
 environment.c         |  2 --
 packfile.c            | 57 +++++++++++++++++++++++++++++++++++++------
 packfile.h            |  2 +-
 5 files changed, 52 insertions(+), 30 deletions(-)

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
index 2ae35dd03f..f626d38071 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -27,6 +26,17 @@
 #include "config.h"
 #include "pack-objects.h"
 
+struct packfile_config {
+	unsigned long packed_git_window_size;
+	unsigned long packed_git_limit;
+};
+
+#define PACKFILE_CONFIG_INIT \
+{ \
+	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
+	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
+}
+
 char *odb_pack_name(struct repository *r, struct strbuf *buf,
 		    const unsigned char *hash, const char *ext)
 {
@@ -48,15 +58,41 @@ static size_t pack_mapped;
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
-void pack_report(void)
+static int packfile_config(const char *var, const char *value,
+			   const struct config_context *ctx, void *cb)
+{
+	struct packfile_config *config = cb;
+
+	if (!strcmp(var, "core.packedgitwindowsize")) {
+		int pgsz_x2 = getpagesize() * 2;
+		config->packed_git_window_size = git_config_ulong(var, value, ctx->kvi);
+
+		/* This value must be multiple of (pagesize * 2) */
+		config->packed_git_window_size /= pgsz_x2;
+		if (config->packed_git_window_size < 1)
+			config->packed_git_window_size = 1;
+		config->packed_git_window_size *= pgsz_x2;
+		return 0;
+	} else if (!strcmp(var, "core.packedgitlimit")) {
+		config->packed_git_limit = git_config_ulong(var, value, ctx->kvi);
+		return 0;
+	} else {
+		return git_default_config(var, value, ctx, cb);
+	}
+}
+
+void pack_report(struct repository *repo)
 {
+	struct packfile_config config = PACKFILE_CONFIG_INIT;
+	repo_config(repo, packfile_config, &config);
+
 	fprintf(stderr,
 		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
 		"pack_report: core.packedGitWindowSize = %10" SZ_FMT "\n"
 		"pack_report: core.packedGitLimit      = %10" SZ_FMT "\n",
 		sz_fmt(getpagesize()),
-		sz_fmt(packed_git_window_size),
-		sz_fmt(packed_git_limit));
+		sz_fmt(config.packed_git_window_size),
+		sz_fmt(config.packed_git_limit));
 	fprintf(stderr,
 		"pack_report: pack_used_ctr            = %10u\n"
 		"pack_report: pack_mmap_calls          = %10u\n"
@@ -652,20 +688,25 @@ unsigned char *use_pack(struct packed_git *p,
 				break;
 		}
 		if (!win) {
-			size_t window_align = packed_git_window_size / 2;
+			struct packfile_config config = PACKFILE_CONFIG_INIT;
+			size_t window_align;
 			off_t len;
 
+			repo_config(p->repo, packfile_config, &config);
+			window_align = config.packed_git_window_size / 2;
+
 			if (p->pack_fd == -1 && open_packed_git(p))
 				die("packfile %s cannot be accessed", p->pack_name);
 
 			CALLOC_ARRAY(win, 1);
 			win->offset = (offset / window_align) * window_align;
 			len = p->pack_size - win->offset;
-			if (len > packed_git_window_size)
-				len = packed_git_window_size;
+			if (len > config.packed_git_window_size)
+				len = config.packed_git_window_size;
 			win->len = (size_t)len;
 			pack_mapped += win->len;
-			while (packed_git_limit < pack_mapped
+
+			while (config.packed_git_limit < pack_mapped
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
-- 
2.47.0

