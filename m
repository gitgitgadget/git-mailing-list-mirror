Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441EE1DD523
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123041; cv=none; b=bPax56E40YfBgZnGPxau3Jh3ojeANA00HoiE1K/hAp3+X/g8olVs7alDc3PJGb9NLQFOHXCDUsOD+Lt7t81oDqrBHipVj5QlahzQvFLIdbGl1JWfiBxFGTwsvTQ0fITLDaHGJymNs5WC8+ofn/KK8gFaK/t8WRrWpSHWQHCBJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123041; c=relaxed/simple;
	bh=+xYmEI/kPdSy/HBx54XisLXhJsgButGLCqzr7zcRIeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks0w4Fy4ZZjZGMM9f/ScpDv/K/1uT9KM5hjCMOXw/oJl27sFPyiYRx1cWKKenDoelaMzLkwXsFdjWuYhkVPa09bOvhyHSVPvxyTSTWv6VMRPoXvntFTeLt+NglcoNz9srch5/qUH4KeQjfXoRYcXRIXnA8VWNEL3dETxjtdRdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeTpLAZB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeTpLAZB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso644689766b.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730123038; x=1730727838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUv2dyMQ/e/SM+CHRcXtmVAQnljwMyN1ueTOhhsoklM=;
        b=KeTpLAZBd43WqRW4l0i/di8m1r3tNd2JoCCZuhEcDM3ONLbfKbuuiw50d89hcjrpqc
         aO3yfWFf4mKK8lim9vCAfb8vt33BUAAY7wXMa8YHoizBMLXEx2XEsnkJO50NkMCm3UgG
         NhjiZCYQFSbEahLaXqnV9DehoDchm2ztqS5ZQnVq+DY3DyCKdXLNJwko+g3ulmgAOKeL
         5F3C9W8VIZEsuPc7TTv1ui3qVebAdwTqHR8n27SDCH3gTPvui4vjNteFBbyEI6yI4R08
         esL/r0CHBN8qOEql9Z+lfPILXs5TyqkuGGyMbofUxnG/FzMNsY2SR5cvauRwDoI27uXF
         DYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123038; x=1730727838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUv2dyMQ/e/SM+CHRcXtmVAQnljwMyN1ueTOhhsoklM=;
        b=t4Bmtz8OeWuI3gF1a8XBVVtS1hBlIfuIK4ceMfjldmgFpFn09AVN1OEoAhq5q3CpyA
         UWzXZN35yOp/Me2BN8B0BIaSMn16iFFhew8lnQP83K1Kex29QsVzWxaFq8mVAocMqJHB
         qTKvv+/WoEslSTJQ5NC7kkwq37NTBPgcpWkk6uW44qWwPYly80dDCEpNsQ1F9Qd8Klx4
         InXNdtuWkY2ghcmT18YLkOU81uZ92yXZcAeZeoKTz58tcsvuhdPH0Gugy7r5McbtaAy1
         oZvPQ/xjL7N+xsaCHiIi8QWKxa786Y0JkLOae/LGJ9enpF7ZNfISXRxpfEBIcnhVqGr8
         1U9A==
X-Gm-Message-State: AOJu0YzRpGptUggAM/Y3Swgus6ROA7W12rkr0l0AkzcNJ9ObhiLa5jaJ
	PXeZNWDmGR/ZEK6kDKgbuapzpK3JHV04HCuROJ/G1tnYguQpcqkXcuyOoi1i
X-Google-Smtp-Source: AGHT+IHDNqARU8GTk9ab+kJjH1+LpWTFPlkPT29jFDGPqZVYam7N/h9OgksFW6hnADyFhP0oi7oKdw==
X-Received: by 2002:a17:907:944f:b0:a9a:825:4c39 with SMTP id a640c23a62f3a-a9de5d00e3emr853515766b.20.1730123037559;
        Mon, 28 Oct 2024 06:43:57 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2971e8sm376647466b.125.2024.10.28.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:43:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com
Subject: [PATCH v2 8/8] config: make `packed_git_(limit|window_size)` non-global variables
Date: Mon, 28 Oct 2024 14:43:46 +0100
Message-ID: <e99b1dad549bb1e87011d8722b8582172390aa04.1730122499.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730122499.git.karthik.188@gmail.com>
References: <cover.1730122499.git.karthik.188@gmail.com>
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
 config.c              | 17 ------------
 environment.c         |  2 --
 packfile.c            | 60 +++++++++++++++++++++++++++++++++++++------
 packfile.h            |  2 +-
 5 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f4892d7f37..9056447bd0 100644
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
index 93b0d6af31..cfbfcdc2b8 100644
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
@@ -48,15 +58,44 @@ static size_t pack_mapped;
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
-void pack_report(void)
+static int packfile_config(const char *var, const char *value,
+			   const struct config_context *ctx, void *cb)
 {
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
+{
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
@@ -652,20 +691,25 @@ unsigned char *use_pack(struct packed_git *p,
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
index c1883e60ef..3409aef35d 100644
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

