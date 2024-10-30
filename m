Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9441F9AAF
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298770; cv=none; b=S/WdufGqlV484ACpU8G75ORDFOuN3Ek/nzaCEIv8nQ57lE/gwyxsMxg99NU6AeZXwr3xX7kofTV9Tx1BjTNkyL1tnGP6QTShQg9C/noSoNzRaToc7B1llTF5WZ5F13tmeEJahm7G5k9pIzgh0aXFWOhtxtNn2RYXg30vj9PwzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298770; c=relaxed/simple;
	bh=K2NtRWrXLpRFi9DHgBgLLU3Ieo8u9yKDyqtWX0Vej3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LosuVbs0sW8VPJ3vHnCuqnnmh9mvS0bJoOD9KvyNrPybqicwtu5r6I6X8gQ1bTgBQK6AUEbpBcjQwdMWiMnkkxAkJmr7kMZsD92LDLf6CSjE08AY/5ty3zLy5q0ElI1uS48qepXpsoi9yw6NQyyVzydDF6DjBcCydG5ITuhdpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At0y/GAB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At0y/GAB"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99e3b3a411so153868266b.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730298766; x=1730903566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gphffhiamdFoioDqWMyRRP6+5kh8E6RV2uAASHPong=;
        b=At0y/GABoC07IBDF1q6W1yxauLj3cMOGnPPY3QuP+3NzNq0iJZExtXLXGkKk0mY7wl
         MMwbwnmixU4yXg5BWCOTwWExmTnFPZ4TQPEgR77OtgILgLtBbfIVxo1GPND85X0TDkkX
         dDRv9MDzUVkDKCwscDeYN0+Ev5LXV5RajreywAo28LkJydWHT1wJFEEkB7XWt5HaAGQ6
         VM1IsDGIt+cVYMhq/1mDZWvFZj8RG+uTbrP4WUCedTXqOwvr0Jp8o+wvqDbtqsgBLEM7
         VKpfsT+z3PWrd32emkVfY4G9J1uQfYU/ER1KzUBcRnUWXFgUUzh4lHvcqeGZpYh4QgRj
         pAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298766; x=1730903566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gphffhiamdFoioDqWMyRRP6+5kh8E6RV2uAASHPong=;
        b=hCfzTvPDYMu6/S8oLl+JDN8QysLSmK2uk6Kpf/RIFlp1uZkQWO+hahKdkBmpTCyAld
         JQbjy8M0h4oyOF+uQfqOOCYPe6rIt/rHY7gBfF9Gl5h/8svwnzbO2hg63mlDJM9foxw7
         nDsGNtrehN6kSkSbj2gUaA2xZT4/f8xpAqTQGVJ6xc5ZzkgLfJtNuMiu5F3qF5nl0EZj
         aP2hTGork2xrowt3++1i9b67SFvA+AZUlfhKJ7W3/gdA272IFYXhk3+ukwKOdCR971f4
         eX321NsgIQiudlYkh/Y6ArxCkP0S8hCA3bhSwmOtftubEo4fbzRShlJwV850EXphZtKz
         lklg==
X-Gm-Message-State: AOJu0Yw0GnkJscRHAbcaEFCEYKEALNc1tldBJlCcwcK0ez+MjnbNaPls
	yo5o9F7jZWWbZxA2RJa8rwyl4FZeSAyxoU07fsnvhRfC2bH3tN9Re9feJTxi
X-Google-Smtp-Source: AGHT+IEw4pRkZjOVyT8cVptEqhiBtGZ0F1akcsclveVJ0ExQ+O3jZ9DBWizKG8263Mx5zSin0hQgiA==
X-Received: by 2002:a17:907:6094:b0:a9a:85b5:2aca with SMTP id a640c23a62f3a-a9e40b9965dmr251643366b.7.1730298765540;
        Wed, 30 Oct 2024 07:32:45 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbc7d4sm576821066b.32.2024.10.30.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:32:45 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v3 8/9] config: make `packed_git_(limit|window_size)` non-global variables
Date: Wed, 30 Oct 2024 15:32:33 +0100
Message-ID: <ec9061fbbd779185b96963c259026df602e447d6.1730297934.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730297934.git.karthik.188@gmail.com>
References: <cover.1730297934.git.karthik.188@gmail.com>
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
index 2ca8198153..c159cc584b 100644
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
index 56a5c55a5d..426606585f 100644
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
 
+			repo_config(p->r, packfile_config, &config);
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

