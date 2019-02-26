Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2DC220248
	for <e@80x24.org>; Tue, 26 Feb 2019 00:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfBZA0t (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 19:26:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39017 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfBZA0t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so11955681wrw.6
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=osZrhocj2gzjlsu7cdenUckK+fi5gPbO0O8sqpgAlJ8=;
        b=Y3mrTOV2Pn2C0vTU/U1J0zVBVusS9UqBKCTs1sKEnQLf7lstn+n2askf0jLjBvQRFA
         n/GDDT87O4aMQlXcT+KobIL99t3xH4JApmvNiT6clxlcRyndyHaLbmrtCZmHIUrc4HL7
         azaxjmUspUQ/afeJBbQqLsz5DAMk7HjE4eCZviz4I714dBD8+5jEz+x6ZNONPumWVbm0
         I+KeLgokdu164XsmtrGF8hsgixSUvxpeh9rOboYQIrsXFqYeiWtdU1rqf1x+xZ5bDO2Y
         t4Zbm+fZjf2niJ9sly+c7g4thjsEsZJMCNaIkEzjfDrk8aGWozQcMN7O0o96vHjeRiPU
         zL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osZrhocj2gzjlsu7cdenUckK+fi5gPbO0O8sqpgAlJ8=;
        b=OyMtraz9iLeUBSN738PtNJk8n5qgeil0wkW/pTdbeihII5TsGx9eas1UWvWcggEQie
         DrkSh6eajJijqjlCqnfToHgX/02paGmd+ZHhE4mx1Gq0ZN91v1851VEqLc8YMFbiOY8e
         HMcpXB+vnpb4DZDat5fsyEZ1jCUKA/n+R/zlXMlLYA7IknLjcIMhDIq/O2iv3ET2AMMU
         34vRzj5ZQ7KnLX9TXDQiriceGvD6YIEjEBAYrGW1251IixFB1Dw2E/RRDJEG2oG7MR+o
         MfuGAeAb3ZC4RnUtYk9PzPHj7VRkmmqxsghdWbHmI4Pd6ng78hFs3pEURHHUFlNHp2fJ
         QQiw==
X-Gm-Message-State: AHQUAuZtc65xkrA3s2qg1nH3tbG5XYlSpNkNuvBmD39PivWOysh+XA18
        K5Ae0LzthklPMD9gIiC5MFskgBTylu8=
X-Google-Smtp-Source: AHgI3IbSAopzodnkrtrsO0eH7V4cOs1oCA4OIdSA08CmLXoYO9TGNE594Xr0Iq4YmNk78ipbbmkWMw==
X-Received: by 2002:adf:e80c:: with SMTP id o12mr13724384wrm.114.1551140806849;
        Mon, 25 Feb 2019 16:26:46 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm11745708wrt.14.2019.02.25.16.26.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 16:26:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [WIP RFC PATCH 1/7] dir-iterator: add pedantic option to dir_iterator_begin
Date:   Tue, 26 Feb 2019 01:26:19 +0100
Message-Id: <20190226002625.13022-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matheus Tavares <matheus.bernardino@usp.br>

Add the pedantic option to dir-iterator's initialization function,
dir_iterator_begin. When this option is set to true,
dir_iterator_advance will immediately return ITER_ERROR when failing to
fetch the next entry. When set to false, dir_iterator_advance will emit
a warning and keep looking for the next entry.

Also adjust refs/files-backend.c to the new dir_iterator_begin
signature.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir-iterator.c       | 23 +++++++++++++++++++++--
 dir-iterator.h       | 16 +++++++++++++---
 refs/files-backend.c |  2 +-
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index f2dcd82fde..070a656555 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -48,6 +48,13 @@ struct dir_iterator_int {
 	 * that will be included in this iteration.
 	 */
 	struct dir_iterator_level *levels;
+
+	/*
+	 * Boolean value to define dir-iterator's behaviour when failing to
+	 * fetch next entry. See comments on dir_iterator_begin at
+	 * dir-iterator.h
+	 */
+	int pedantic;
 };
 
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
@@ -71,6 +78,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 
 			level->dir = opendir(iter->base.path.buf);
 			if (!level->dir && errno != ENOENT) {
+				if (iter->pedantic)
+					goto error_out;
 				warning("error opening directory %s: %s",
 					iter->base.path.buf, strerror(errno));
 				/* Popping the level is handled below */
@@ -122,6 +131,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			if (!de) {
 				/* This level is exhausted; pop up a level. */
 				if (errno) {
+					if (iter->pedantic)
+						goto error_out;
 					warning("error reading directory %s: %s",
 						iter->base.path.buf, strerror(errno));
 				} else if (closedir(level->dir))
@@ -139,10 +150,13 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 
 			strbuf_addstr(&iter->base.path, de->d_name);
 			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
-				if (errno != ENOENT)
+				if (errno != ENOENT) {
+					if (iter->pedantic)
+						goto error_out;
 					warning("error reading path '%s': %s",
 						iter->base.path.buf,
 						strerror(errno));
+				}
 				continue;
 			}
 
@@ -159,6 +173,10 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			return ITER_OK;
 		}
 	}
+
+error_out:
+	dir_iterator_abort(dir_iterator);
+	return ITER_ERROR;
 }
 
 int dir_iterator_abort(struct dir_iterator *dir_iterator)
@@ -182,7 +200,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 	return ITER_DONE;
 }
 
-struct dir_iterator *dir_iterator_begin(const char *path)
+struct dir_iterator *dir_iterator_begin(const char *path, int pedantic)
 {
 	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
 	struct dir_iterator *dir_iterator = &iter->base;
@@ -195,6 +213,7 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
 
+	iter->pedantic = pedantic;
 	iter->levels_nr = 1;
 	iter->levels[0].initialized = 0;
 
diff --git a/dir-iterator.h b/dir-iterator.h
index 970793d07a..50ca8e1a27 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -19,7 +19,7 @@
  * A typical iteration looks like this:
  *
  *     int ok;
- *     struct iterator *iter = dir_iterator_begin(path);
+ *     struct iterator *iter = dir_iterator_begin(path, 0);
  *
  *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
  *             if (want_to_stop_iteration()) {
@@ -65,9 +65,15 @@ struct dir_iterator {
  * The iteration includes all paths under path, not including path
  * itself and not including "." or ".." entries.
  *
- * path is the starting directory. An internal copy will be made.
+ * Parameters are:
+ * - path is the starting directory. An internal copy will be made.
+ * - pedantic is a boolean value. If true, dir-iterator will free
+ *   resources and return ITER_ERROR immediately, in case of an error
+ *   while trying to fetch the next entry in dir_iterator_advance. If
+ *   false, it will just emit a warning and keep looking for the next
+ *   entry.
  */
-struct dir_iterator *dir_iterator_begin(const char *path);
+struct dir_iterator *dir_iterator_begin(const char *path, int pedantic);
 
 /*
  * Advance the iterator to the first or next item and return ITER_OK.
@@ -76,6 +82,10 @@ struct dir_iterator *dir_iterator_begin(const char *path);
  * dir_iterator and associated resources and return ITER_ERROR. It is
  * a bug to use iterator or call this function again after it has
  * returned ITER_DONE or ITER_ERROR.
+ *
+ * Note that whether dir_iterator_advance will return ITER_ERROR when
+ * failing to fetch the next entry or keep going is defined by the
+ * 'pedantic' option at dir-iterator's initialization.
  */
 int dir_iterator_advance(struct dir_iterator *iterator);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index dd8abe9185..c3d3b6c454 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2143,7 +2143,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
 	strbuf_addf(&sb, "%s/logs", gitdir);
-	iter->dir_iterator = dir_iterator_begin(sb.buf);
+	iter->dir_iterator = dir_iterator_begin(sb.buf, 0);
 	iter->ref_store = ref_store;
 	strbuf_release(&sb);
 
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

