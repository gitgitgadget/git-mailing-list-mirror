Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4EE61FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbdBMPVO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:21:14 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33915 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753151AbdBMPVK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:21:10 -0500
Received: by mail-ot0-f196.google.com with SMTP id 73so11888038otj.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 07:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+3h6Pu8Rjz4gxWqkQ9X8Yafls4Wr53tSYu5qrfJ2So=;
        b=KpPMyChA4C84H76NC/TDO1WeZQcb1UcE3GPOPBu13tozr08aIqeTPOwuV2KdCz4UMy
         ymQD+YnCdeihad665Qlm5On+TOka6Ow9UggbG4K8D16uSy70XPejxv8a9Nmo2gelZow6
         Jo9ix4mRdGMLZXKDmvugng1yJ3hZy048UIBxJikr4HQMfdewnkXunhVdMmsI+OezIUEk
         MMfBBmpAJZ9lblx/GLKR8joHqKRSOdpIXzFcSyjN/rCPNQzezarCHTUrvbvAziwnWe1j
         BsIvz56JsQ0SpegM2o4Q4xYkQuswxEN7mH0OI5W9M+jZZJui2eu3IuXHQID2kBxmU7xL
         dJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+3h6Pu8Rjz4gxWqkQ9X8Yafls4Wr53tSYu5qrfJ2So=;
        b=qGnBn5U1wDjcg6DSioGIh00vVaIKMv5kwz3040wWn4KJaEdO614SBl9L3tgCchlwWh
         MG9i9/8dl/KfBil+xL/2vttJybMWvMJ7MxM06WnFNbvWQd9ucYpPyGk4jE5z0I8Eombk
         OINoSm+wb5U2sLnRVn8XX/WAjH/dLrowBE/rosfSvrr6CYI6clKiDcHRCioaRMdOWB5l
         w2fU3swlj33m3ffK+L1Vb0NlAwHFiZcvqKSendFVDE19YX98MojhlBvAn34wNPf+buLe
         H13477jU1r/jcQ1hw2gZEATvq0QU1mv5gwtZQe5y1I4o0Vo1EdOCG2hfTap5yqgqLIsS
         FpXg==
X-Gm-Message-State: AMke39kctWiGoBubBShSx/tOWGrHyrXOWEJswPufz+R1kIG0yQ3QLCp1sCCBq3ooNaQuXQ==
X-Received: by 10.99.117.8 with SMTP id q8mr27564853pgc.9.1486999269440;
        Mon, 13 Feb 2017 07:21:09 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id r78sm21703915pfe.55.2017.02.13.07.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 07:21:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 22:21:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/11] refs: move submodule code out of files-backend.c
Date:   Mon, 13 Feb 2017 22:20:09 +0700
Message-Id: <20170213152011.12050-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213152011.12050-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

files-backend is now initialized with a $GIT_DIR. Converting a submodule
path to where real submodule gitdir is located is done in get_ref_store().

The new code in init_submodule_ref_store() is basically a copy of
strbuf_git_path_submodule().

This gives a slight performance improvement for submodules since we
don't convert submodule path to gitdir at every backend call like
before. We pay that once at ref-store creation.

More cleanup in files_downcast() follows shortly. It's separate to keep
noises from this patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 48 +++++++++++++++++++++++++++++++++++++++++-------
 refs/files-backend.c | 25 +++++++------------------
 refs/refs-internal.h |  6 +++---
 3 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/refs.c b/refs.c
index 8ef7a52ba..9ac194945 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,7 @@
 #include "refs/refs-internal.h"
 #include "object.h"
 #include "tag.h"
+#include "submodule-config.h"
 
 /*
  * List of all available backends
@@ -1410,7 +1411,7 @@ static void register_ref_store(struct ref_store *refs, const char *submodule)
  * Create, record, and return a ref_store instance for the specified
  * submodule (or the main repository if submodule is NULL).
  */
-static struct ref_store *ref_store_init(const char *submodule)
+static struct ref_store *ref_store_init(const char *submodule, const char *gitdir)
 {
 	const char *be_name = "files";
 	struct ref_storage_be *be = find_ref_storage_backend(be_name);
@@ -1419,7 +1420,7 @@ static struct ref_store *ref_store_init(const char *submodule)
 	if (!be)
 		die("BUG: reference backend %s is unknown", be_name);
 
-	refs = be->init(submodule);
+	refs = be->init(gitdir);
 	register_ref_store(refs, submodule);
 	return refs;
 }
@@ -1445,15 +1446,48 @@ static struct ref_store *lookup_ref_store(const char *submodule)
 	return entry ? entry->refs : NULL;
 }
 
-static struct ref_store *init_submodule_ref_store(const char *submodule)
+static struct ref_store *init_submodule_ref_store(const char *path)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
+	struct strbuf git_submodule_common_dir = STRBUF_INIT;
+	struct strbuf git_submodule_dir = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	const char *git_dir;
+	const struct submodule *sub;
 	struct ref_store *refs = NULL;
 
-	strbuf_addstr(&submodule_sb, submodule);
-	if (is_nonbare_repository_dir(&submodule_sb))
-		refs = ref_store_init(submodule);
+	strbuf_addstr(&submodule_sb, path);
+	if (!is_nonbare_repository_dir(&submodule_sb))
+		goto done;
+
+	strbuf_addstr(&buf, path);
+	strbuf_complete(&buf, '/');
+	strbuf_addstr(&buf, ".git");
+
+	git_dir = read_gitfile(buf.buf);
+	if (git_dir) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, git_dir);
+	}
+	if (!is_git_directory(buf.buf)) {
+		gitmodules_config();
+		sub = submodule_from_path(null_sha1, path);
+		if (!sub)
+			goto done;
+		strbuf_reset(&buf);
+		strbuf_git_path(&buf, "%s/%s", "modules", sub->name);
+	}
+	strbuf_addch(&buf, '/');
+	strbuf_addbuf(&git_submodule_dir, &buf);
+
+	refs = ref_store_init(path, git_submodule_dir.buf);
+
+done:
+	strbuf_release(&git_submodule_dir);
+	strbuf_release(&git_submodule_common_dir);
 	strbuf_release(&submodule_sb);
+	strbuf_release(&buf);
+
 	return refs;
 }
 
@@ -1465,7 +1499,7 @@ struct ref_store *get_ref_store(const char *submodule)
 		refs = lookup_ref_store(NULL);
 
 		if (!refs)
-			refs = ref_store_init(NULL);
+			refs = ref_store_init(NULL, NULL);
 	} else {
 		refs = lookup_ref_store(submodule);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 50eb9edb6..834bc6fdf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -920,13 +920,6 @@ struct packed_ref_cache {
 struct files_ref_store {
 	struct ref_store base;
 
-	/*
-	 * The name of the submodule represented by this object, or
-	 * NULL if it represents the main repository's reference
-	 * store:
-	 */
-	const char *submodule;
-
 	struct strbuf gitdir;
 	struct strbuf gitcommondir;
 
@@ -947,12 +940,9 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
 	va_start(vap, fmt);
 	strbuf_vaddf(&tmp, fmt, vap);
 	va_end(vap);
-	if (refs->submodule)
-		strbuf_git_path_submodule(sb, refs->submodule,
-					  "%s", tmp.buf);
-	else if (is_per_worktree_ref(tmp.buf) ||
-		 (skip_prefix(tmp.buf, "logs/", &ref) &&
-		  is_per_worktree_ref(ref)))
+	if (is_per_worktree_ref(tmp.buf) ||
+	    (skip_prefix(tmp.buf, "logs/", &ref) &&
+	     is_per_worktree_ref(ref)))
 		strbuf_addf(sb, "%s/%s", refs->gitdir.buf, tmp.buf);
 	else
 		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
@@ -1007,7 +997,7 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct ref_store *files_ref_store_create(const char *submodule)
+static struct ref_store *files_ref_store_create(const char *gitdir)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
@@ -1017,8 +1007,9 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 	strbuf_init(&refs->gitdir, 0);
 	strbuf_init(&refs->gitcommondir, 0);
 
-	if (submodule) {
-		refs->submodule = xstrdup_or_null(submodule);
+	if (gitdir) {
+		strbuf_addstr(&refs->gitdir, gitdir);
+		get_common_dir_noenv(&refs->gitcommondir, gitdir);
 	} else {
 		strbuf_addstr(&refs->gitdir, get_git_dir());
 		strbuf_addstr(&refs->gitcommondir, get_git_common_dir());
@@ -1034,8 +1025,6 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 static void files_assert_main_repository(struct files_ref_store *refs,
 					 const char *caller)
 {
-	if (refs->submodule)
-		die("BUG: %s called for a submodule", caller);
 }
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 69d02b6ba..d7112770d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -476,12 +476,12 @@ struct ref_store;
 /* refs backends */
 
 /*
- * Initialize the ref_store for the specified submodule, or for the
- * main repository if submodule == NULL. These functions should call
+ * Initialize the ref_store for the specified gitdir, or for the
+ * current repository if gitdir == NULL. These functions should call
  * base_ref_store_init() to initialize the shared part of the
  * ref_store and to record the ref_store for later lookup.
  */
-typedef struct ref_store *ref_store_init_fn(const char *submodule);
+typedef struct ref_store *ref_store_init_fn(const char *gitdir);
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
 
-- 
2.11.0.157.gd943d85

