Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAEB020248
	for <e@80x24.org>; Sat, 23 Feb 2019 19:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfBWTDZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 14:03:25 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34423 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfBWTDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 14:03:25 -0500
Received: by mail-qk1-f195.google.com with SMTP id a15so3117610qkc.1
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 11:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMbGWAL9DB2Kop5ENb0TYtL0kLnchra4Ikt+IocMdJU=;
        b=COAxcGmIyOz7extlKyRoyvQD6FSOYWr6+FNFKu5/Lj/WR9u0A7Wxlqqto45yvcs7gp
         vfJ+OknMKreX+Lzz231AORxZUwRT7gMmuXtOKBlaFHKNu1oUfjRY+WIM9SED2LBurkR7
         tjDQD2rzgiQYIupE2bVwlQZUlz6fTnIXTaPwvun02/NSeUr84DSR5MwBBYVaElBNrplC
         Yl/A5haE2Hg9HqIXEpKKqh/ON4vq6+anIrh5KXH1A52y76B5rWFivLhgx0xcT0oKhZng
         kE61E5T7wGLeiJgr0S/ihQRy+eJckMOeSzyLTLYUNhatrEjE+TjIT+W9uqnJvPJiOEJh
         0Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMbGWAL9DB2Kop5ENb0TYtL0kLnchra4Ikt+IocMdJU=;
        b=mXukcf0JgRunzSugup7VOepFIBXDDSh6+MLH2I+0e4lSBd1GwaKLgkiJdUWjkSDXAZ
         59A00J/8DopmAYxtyc4iDuAh9jJkSaeEdvH93whigkMv0BwWzbn+vytYXWC72Kcj5VAR
         JY2gnY5qwaLSEad0CSJrHkMDjLpcGkBcbzgqXZ61uYPosogbgnCGV01cUfbZ9EhKHw5E
         hgKAeRuV2k0xQnQVayXSY4OaH7abPKLokGfBML26XnNVVXz+UqwiRvpB/xrjegK6aCxc
         nueFnzI+bwIo2m3XpicsUQ42ejm6X/P546fwmli8ALteUxvLljt+AlijadcD3k1ZJNaq
         /ayA==
X-Gm-Message-State: AHQUAubgCy9X9y4NFWYEEeVpDy/UZFptzNxqda2j/Z3w8zXJPwYY4ht9
        UwnJbKt/sWtDh7cX4YryhF4QBFJgegc=
X-Google-Smtp-Source: AHgI3IY73zYmbRg8UyGopuBJ9PgoO1qx2xDeVvWBeP0odDLn8cfF32NMUcxDKyKGMesySoZOe5ObVQ==
X-Received: by 2002:a37:4751:: with SMTP id u78mr7373486qka.280.1550948604161;
        Sat, 23 Feb 2019 11:03:24 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id j9sm1028064qtb.30.2019.02.23.11.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 11:03:23 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [GSoC][PATCH 1/3] dir-iterator: add pedantic option to dir_iterator_begin
Date:   Sat, 23 Feb 2019 16:03:07 -0300
Message-Id: <20190223190309.6728-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190223190309.6728-1-matheus.bernardino@usp.br>
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the pedantic option to dir-iterator's initialization function,
dir_iterator_begin. When this option is set to true,
dir_iterator_advance will immediately return ITER_ERROR when failing to
fetch the next entry. When set to false, dir_iterator_advance will emit
a warning and keep looking for the next entry.

Also adjust refs/files-backend.c to the new dir_iterator_begin
signature.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - Added in v2

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
2.20.1

