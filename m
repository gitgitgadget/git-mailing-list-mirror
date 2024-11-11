Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548C18BBAB
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323662; cv=none; b=OUET8rjQj1umYSxstTF9HGcAOIfWNBOkvpSC09+3FeMM1+f025cey1uMUgOfVTRNOuTYDtuEOZgn6R8Izg16Y60CURRM9FOylJeEvosmu020UrHhI1VX8pxS7M6rbW/8M53dO9l71hAPMPwX7OGPXghmYp4CxpTRJHREjo0Ld9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323662; c=relaxed/simple;
	bh=ZjMWHTponszLHvPIEIqSE6Befmf9wnoLNfOZIk59t14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UedfEzf0p//VnPfw2Bxx7r4/YwyzoNJgXiSl6m+CwCilcyvN4ydDCntrSkvLuBlG1BqaQhCpajQ+vqEtaclrXla8ad7QgJ7sDGDi1qxGTNmom7iL61debutYqCeCYWzSw89al3cNR/nSzx62DhGfh3bdQo/uyeZbuv4ukILXHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN8bCaUe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN8bCaUe"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so35401221fa.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731323658; x=1731928458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yyr8VN3Fc3es1nZ6w5PpetvPv4WdaOFjN0xwzyU5WVg=;
        b=AN8bCaUeSrL4SVbQEmoA1RWx77p1XXl4zS33aGYR1SaI4xSWTxlucGSdm+oNHaRf89
         Gy/VT3Jg5/lzfgtopHemxPEheO0jpUc84FnkXvRFK1niEmoCvSHcO5ZyrFDoEc1K7zPe
         xYsLn/jR0vSne8WWQrLSG1swdB780xkYpUprS8WXatXqkTcweROh5VJ/7FT4d8QTGLjb
         cAxNo9aV9JZ5fCg/D13TP8sR3LHwEuUwdBsgus/gYjOeMLdZEWpx13IK/0OBTK/9gf7s
         zLgVaOyh+88RsVM0S1BzKgIR8hPTJQ/UFRKiRNLQQYau6r9/RtOdy0jbBZK9kVNjmN4w
         UaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323659; x=1731928459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yyr8VN3Fc3es1nZ6w5PpetvPv4WdaOFjN0xwzyU5WVg=;
        b=EGkHNf5CsHsYhfiJyLIaqh80yG+BITXdCcaIHCNzzAordcMWwEg78lIy3r+qKHpp0B
         sjMTNROWQT/UytZk6NxtpuPQMEhrrp/2FXS3uFfE/K7CbfRfWLEjxfjvC6Ey+kt17dCW
         lwgpfb0PJ0AaHnf/Cmc7iBxQRLh08bkqEHzC/A/moUv7CgNgbglt+x2tY0dZmkIlqhNl
         fbmcEk1Ctd8o7dajepka0AHTRhIThkgiW53WHu33QNivPUoVqjDj9C5p33eGX/XVYDHq
         D1Lht9LSgEAk7S3qPQQ8x3RcGZP1pgDNsiWx+oWJK/CZU/p6sIeAFx2Sf5S2/DOFCKys
         FStw==
X-Gm-Message-State: AOJu0Yz+zGLnFPjeVveGFhRHak6MKHvkFhQ+EldvYdJkJjxCnVTPgZ84
	bUKE7klTMME075B+wH5rv0X9WfJQInwVRxL7q02ykdScR5u2y2oN
X-Google-Smtp-Source: AGHT+IFLTnpV1AvDour7DvF4KXAEeP4lD+Yiah2zndwxvtHzvpnygbK1owTKq5OG9NawRNtA+blvPQ==
X-Received: by 2002:a2e:be05:0:b0:2f7:ad6b:a31e with SMTP id 38308e7fff4ca-2ff202e1258mr57884321fa.31.1731323658382;
        Mon, 11 Nov 2024 03:14:18 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7c625sm5012959a12.82.2024.11.11.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:14:18 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v7 8/9] config: make `packed_git_(limit|window_size)` non-global variables
Date: Mon, 11 Nov 2024 12:14:08 +0100
Message-ID: <7b6baa89ac8937118524d4313d6e7b148567117b.1731323350.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731323350.git.karthik.188@gmail.com>
References: <cover.1731323350.git.karthik.188@gmail.com>
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
index 2ae35dd03f..724ce8e977 100644
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
+			/* lazy load the settings in case it hasn't been setup */
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

