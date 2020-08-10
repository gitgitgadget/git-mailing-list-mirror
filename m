Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF77C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B32206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="FRa5A/J7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgHJVfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHJVfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:46 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671ACC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 77so9873477qkm.5
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wvrvKFNwrONSKucJStPte6w8ul1OeR/QlmjFedtXVY=;
        b=FRa5A/J7Aky2xaNOD4301relG1dBBJ0g0hvP7uoA7EYYkO34CgPhkZjQEFhWw3xDkS
         e1OGripsKwBb+se/dAGUkT1LPlZx1RaWAx0IGmRzbYhfpXTY/Q7SfUP9oD8Z/j27KJ0j
         yFuVOZu1rz7evdhWgoGRUGjtRUkgzf3I/6g1dch+pOTflowajSW94SUuOdcnO3d55BKL
         GkCdYvjW8EsHU/zTsulcIK1vSvikSjfTFocQV/h/nnK+OHTIMJO4wQwo80CUcgW8pSup
         sBtsbbm0Eh+DbylD38HbUUT0RnBWawJxUy22bRof6HueYLmONelBm1Qv9ldc9zD/k10z
         yy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wvrvKFNwrONSKucJStPte6w8ul1OeR/QlmjFedtXVY=;
        b=LBqDZZCo4n5Z1ThV921GWa4flbelwYKDGCELnmv5dfH9LkTuAT5512nozVRhhaMVIR
         tyHzjnP5VOmBY98bKho8Gzw1evMiuoJOlarXkrMveO98+vR09ODf1T6uFq3aTiuq/XYu
         014U5xaDFCnGbQsj8ArDfpta2b5ySuAxMwIw9CaF0rsrG2FGFj9ofdZ28p82vkwX6t+w
         XYTCOgTVUjYxpAmnEhvYimvHSzGZMl3g7kkSBLRBeSVO7ooMZkVenOsId6UCo7j+5fM2
         7mMDuhtgOtovFJ5V8w3Val8WwlyIpvOMJI+LgMWbxR8JnMpH6w/hQYZI9qB8tFcXsY20
         Sb4w==
X-Gm-Message-State: AOAM531D70b+RN7Wj0pxtkIiyE81MRpQl9Nvq2J1RBm2wcVRMUGOAHeW
        oTYIzOv1xenyC5X/Gy6Eg/UP5hQXj2s=
X-Google-Smtp-Source: ABdhPJywmZU/Unm3qr9VEhF17eEF0zemvb+DpS9gBqoLkxhUtap8ops9y/CoJOw3a2GVW9fePzZFNQ==
X-Received: by 2002:a05:620a:9d0:: with SMTP id y16mr28877221qky.353.1597095345043;
        Mon, 10 Aug 2020 14:35:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:44 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 19/21] symlinks: make has_dirs_only_path() track FL_NOENT
Date:   Mon, 10 Aug 2020 18:33:27 -0300
Message-Id: <e4aed47fa62cb2d7ed3411c5ef1464025572c2ec.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, the parallel-checkout workers will be able to create
the leading directories of the entries being written by themselves, to
increase performance. But to do so, the main process will first need to
remove non-directory files that can potentially be in the way (the
reasoning is discussed in the next patch). This can be done without much
cost by calling has_dirs_only_path() for each path component until we
find the first one which is not a real directory, which should then be
removed. This operations is cheap because it doesn't have to call stat()
again for each component, as the information is already cached from the
previous call at entry.c:check_path().

However, when has_dirs_only_path() returns false, we don't know if the
component doesn't exist or if it exists as another file type. The best
we could do in this case would be to stat() the component again. When
there are many files to be checked out inside the same directory (yet
to be created by a worker), we would have to call stat() for the same
directory once for each path, even though there is nothing to be
unlinked there. We can skip this stat() calls by making
has_dirs_only_path() also ask for FL_NOENT caching, and converting its
return to a tri-state.

Note: since we are now caching FL_NOENT, we also need to manually
invalidate the cache when we create a directory in a path previously
cached as non-existent.

While we are here, also remove duplicated comments in
has_dirs_only_path() and check_leading_path().

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 cache.h             |  1 +
 entry.c             | 11 +++++++++--
 parallel-checkout.c |  3 +++
 symlinks.c          | 42 ++++++++++++++++++------------------------
 4 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index e2b41c5f8b..7a08cd6f0e 100644
--- a/cache.h
+++ b/cache.h
@@ -1711,6 +1711,7 @@ int has_symlink_leading_path(const char *name, int len);
 int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
 int check_leading_path(const char *name, int len);
 int has_dirs_only_path(const char *name, int len, int prefix_len);
+void reset_default_lstat_cache(void);
 void schedule_dir_for_removal(const char *name, int len);
 void remove_scheduled_dirs(void);
 
diff --git a/entry.c b/entry.c
index 19f2c1d132..e876adff19 100644
--- a/entry.c
+++ b/entry.c
@@ -14,6 +14,7 @@ static void create_directories(const char *path, int path_len,
 {
 	char *buf = xmallocz(path_len);
 	int len = 0;
+	int reset_cache = 0;
 
 	while (len < path_len) {
 		do {
@@ -31,7 +32,7 @@ static void create_directories(const char *path, int path_len,
 		 * we test the path components of the prefix with the
 		 * stat() function instead of the lstat() function.
 		 */
-		if (has_dirs_only_path(buf, len, state->base_dir_len))
+		if (has_dirs_only_path(buf, len, state->base_dir_len) > 0)
 			continue; /* ok, it is already a directory. */
 
 		/*
@@ -45,8 +46,14 @@ static void create_directories(const char *path, int path_len,
 			    !unlink_or_warn(buf) && !mkdir(buf, 0777))
 				continue;
 			die_errno("cannot create directory at '%s'", buf);
+		} else {
+			/* The cache had FL_NOENT, but we now created a dir */
+			reset_cache = 1;
 		}
 	}
+
+	if (reset_cache)
+		reset_default_lstat_cache();
 	free(buf);
 }
 
@@ -406,7 +413,7 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 
 	while (path < slash && !is_dir_sep(*slash))
 		slash--;
-	if (!has_dirs_only_path(path, slash - path, skiplen)) {
+	if (has_dirs_only_path(path, slash - path, skiplen) <= 0) {
 		errno = ENOENT;
 		return -1;
 	}
diff --git a/parallel-checkout.c b/parallel-checkout.c
index fee93460c1..4d72540256 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -185,6 +185,9 @@ static int handle_results(struct checkout *state)
 
 	pc_status = PC_HANDLING_RESULTS;
 
+	/* Workers might have created dirs, so the cache must be invalidated */
+	reset_default_lstat_cache();
+
 	for (i = 0; i < parallel_checkout->nr; ++i) {
 		struct checkout_item *ci = &parallel_checkout->items[i];
 		struct stat *st = &ci->st;
diff --git a/symlinks.c b/symlinks.c
index 69d458a24d..3adf6ef8a1 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -47,6 +47,11 @@ static inline void reset_lstat_cache(struct cache_def *cache)
 	 */
 }
 
+void reset_default_lstat_cache(void)
+{
+	reset_lstat_cache(&default_cache);
+}
+
 #define FL_DIR      (1 << 0)
 #define FL_NOENT    (1 << 1)
 #define FL_SYMLINK  (1 << 2)
@@ -210,15 +215,6 @@ int has_symlink_leading_path(const char *name, int len)
 	return threaded_has_symlink_leading_path(&default_cache, name, len);
 }
 
-/*
- * Return zero if path 'name' has a leading symlink component or
- * if some leading path component does not exists.
- *
- * Return -1 if leading path exists and is a directory.
- *
- * Return path length if leading path exists and is neither a
- * directory nor a symlink.
- */
 int check_leading_path(const char *name, int len)
 {
 	return threaded_check_leading_path(&default_cache, name, len);
@@ -246,30 +242,28 @@ static int threaded_check_leading_path(struct cache_def *cache, const char *name
 		return match_len;
 }
 
-/*
- * Return non-zero if all path components of 'name' exists as a
- * directory.  If prefix_len > 0, we will test with the stat()
- * function instead of the lstat() function for a prefix length of
- * 'prefix_len', thus we then allow for symlinks in the prefix part as
- * long as those points to real existing directories.
- */
 int has_dirs_only_path(const char *name, int len, int prefix_len)
 {
 	return threaded_has_dirs_only_path(&default_cache, name, len, prefix_len);
 }
 
 /*
- * Return non-zero if all path components of 'name' exists as a
- * directory.  If prefix_len > 0, we will test with the stat()
- * function instead of the lstat() function for a prefix length of
- * 'prefix_len', thus we then allow for symlinks in the prefix part as
- * long as those points to real existing directories.
+ * Return a positive number if all path components of 'name' exist as
+ * directories, a negative number if a component does not exist, and 0 otherwise
+ * (e.g. a component exists but as another file type). If prefix_len > 0, we
+ * will test with the stat() function instead of the lstat() function for a
+ * prefix length of 'prefix_len', thus we return +1 for symlinks in the prefix
+ * part as long as those points to real existing directories.
  */
 static int threaded_has_dirs_only_path(struct cache_def *cache, const char *name, int len, int prefix_len)
 {
-	return lstat_cache(cache, name, len,
-			   FL_DIR|FL_FULLPATH, prefix_len) &
-		FL_DIR;
+	int flags = lstat_cache(cache, name, len,
+				FL_NOENT|FL_DIR|FL_FULLPATH, prefix_len);
+	if (flags & FL_DIR)
+		return 1;
+	if (flags & FL_NOENT)
+		return -1;
+	return 0;
 }
 
 static struct strbuf removal = STRBUF_INIT;
-- 
2.27.0

