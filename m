Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F91E8831
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504706; cv=none; b=Fjo5GTkhnHw4L8yeQJqbiXul+9JfFoEugpLdQ/qNg1Np2cTdGbyepAaz3HnhSaSPscXbI7Pjp3sCnSLV1pCUCTIX6gzpYbojRkmZ6G6gNeTFoQf/Tk1Qgycy+vFXtgC2Y7Y7BISGIL/gnDkDVy7Ps/2uMXZ+IOunxNdXUM15vKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504706; c=relaxed/simple;
	bh=/d6c96uLPEUN3tCIZzWb7e3Q7FtmtE5khCSIs+p2aBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFMmm35mwxenNKZfOf4bwspHKPUErTB0mifzZPVTSflxMfSqkiUoxO18JPkHfzaMKgbapSIsNVIeGSrpP94cg/yuFTZoB6FTclHt1fOwrk5FW82JTQX/TEGrxEXtWmu12U/UvCW/oJl2JLw2hPh5q5txkdM6EnbKGIZa8FJmRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9gYlzpz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9gYlzpz"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso61997351fa.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504702; x=1730109502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4WDPl6CsurkH6Vn6s4wnu0DhHOYgLmJROy8hJK2hVI=;
        b=K9gYlzpzut2icC3PdYL/wAx6VliFvO7U/eY9IdrfWjveKKzFjODZBLHVkmqovrZU12
         3ff2n1Ojcxn9CBdawSTa8s2bq9dEsxb1grxVJnvzfGu1wwpkyOzGH8//YmjQaqQ9vU1C
         oxVTYBEp7wSV03DQ57sNL52720h8GuHH7yoNxCwjsyKgQXvsyIr7Odswbfiq2mM0coca
         7VLO88U40C4Fsvmivw7fjmDDL1Eq0hh0n/89WhdRgD3ioUbmLLPuYEdO7wvDV6GrDNQA
         h6HusE48CZanov4pYwkJjjJhfaQRHBa/Pr+Q7OrjngzMz2vygmV6jnWLZQzegzU7WlAv
         2s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504702; x=1730109502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4WDPl6CsurkH6Vn6s4wnu0DhHOYgLmJROy8hJK2hVI=;
        b=YhoBKv2mPSGC+JvqDK73Pyk39G+kHMct5LyuZ+OVvdIbZ7VUn19e9ZKGZXuwkQOlbD
         y5MP3Op4Kt1E/S9LzBVL7lR0Cl7KICyvY52xhufdO+Dw5fw7F/Sn6Xg+kBbW68gHxAAe
         d1X00RRxZYm0lD/cJ9vvYMqf7qPyTsoU+NZhYt/CZO631AXZpH+IICNJR5rox/VhE+/j
         GsPvP2Yxz2es+eVR+yyIYiTGAIRNrfFZQiDFP8rzidIN6pfTEm8UQ+MMPwBRZEOExqj9
         k6QqT4Deio2hhOKuAx+84NmpFtNBspPxo3rEnq1UbtetvnnrkMfhj3xqHRCowOzfZa9B
         B3VQ==
X-Gm-Message-State: AOJu0YxU1xEBK21Shi/nkk8JISYggxOWPWN654plnMBIrUUkQUZAyRY3
	NC5Q3ZB67GwAC3YN2k7oHi+uHPVZhqZBq/fXGtUsK6Sc2ysgvcQr+W6QuNC8
X-Google-Smtp-Source: AGHT+IFbBZHDirb61InXq8AB45F60lCheD2CiY0qPSSDAQwowTe4aog0cODXKtKhaHAhqC2WdIjarw==
X-Received: by 2002:a2e:80a:0:b0:2fb:5ae7:24e7 with SMTP id 38308e7fff4ca-2fb82e90ee3mr59747571fa.4.1729504701582;
        Mon, 21 Oct 2024 02:58:21 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:21 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 20/20] config: make `packed_git_(limit|window_size)` non-global variables
Date: Mon, 21 Oct 2024 11:58:03 +0200
Message-ID: <6a6600698be06e2cd6bccda6df8cba41ee3540a2.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c |  4 +--
 config.c              | 17 -------------
 environment.c         |  2 --
 packfile.c            | 59 +++++++++++++++++++++++++++++++++++++------
 packfile.h            |  2 +-
 5 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index a6743db85c..e8c814a07e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3540,7 +3540,7 @@ static void parse_argv(void)
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    struct repository *repo)
 {
 	unsigned int i;
 
@@ -3661,7 +3661,7 @@ int cmd_fast_import(int argc,
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
index c9812eedad..00a39036c9 100644
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
+	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT,  \
+}
+
 char *odb_pack_name(struct repository *repo, struct strbuf *buf,
 		    const unsigned char *hash, const char *ext)
 {
@@ -60,15 +70,44 @@ static size_t pack_mapped;
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
+	}
+
+	if (!strcmp(var, "core.packedgitlimit")) {
+		config->packed_git_limit = git_config_ulong(var, value, ctx->kvi);
+		return 0;
+	}
+
+	return git_default_config(var, value, ctx, cb);
+}
+
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
@@ -656,20 +695,24 @@ unsigned char *use_pack(struct repository *repo, struct packed_git *p,
 				break;
 		}
 		if (!win) {
-			size_t window_align = packed_git_window_size / 2;
+			struct packfile_config config = PACKFILE_CONFIG_INIT;
+			size_t window_align;
 			off_t len;
 
+			repo_config(repo, packfile_config, &config);
+			window_align = config.packed_git_window_size / 2;
+
 			if (p->pack_fd == -1 && open_packed_git(repo, p))
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
+			while (config.packed_git_limit < pack_mapped
 				&& unuse_one_window(repo, p))
 				; /* nothing */
 			win->base = xmmap_gently(NULL, win->len,
diff --git a/packfile.h b/packfile.h
index 9184560f0e..1894d7db93 100644
--- a/packfile.h
+++ b/packfile.h
@@ -91,7 +91,7 @@ struct packed_git *find_sha1_pack(struct repository *repo,
 				  const unsigned char *sha1,
 				  struct packed_git *packs);
 
-void pack_report(void);
+void pack_report(struct repository *repo);
 
 /*
  * mmap the index file for the specified packfile (if it is not
-- 
2.47.0

