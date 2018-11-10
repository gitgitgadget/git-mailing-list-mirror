Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E561F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeKJPdK (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38975 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbeKJPdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so3377334ljh.6
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpV8xhNLB/scWysqMZej/wGnQkc4j31hL9ZxATH0HSQ=;
        b=e3DOAlIZhmKi5qRstBoMgzt7ecYXu7JvIWa4b+H3NnpcJYWWcjQys7KpjMoyN2y4Zw
         Xtw7NEu/TdTjMsX+wC/29//hidIitR3iO5SE48E4aAxoqDlbrCsq11np81gM4J2hlOTu
         yvj9ITTQOIf0UQWRzllusqeEftTLrZ0Q+h1BdZNZyPiCyo3ks77YAQ9ynC+wy+i78g8P
         fUBsZU4ZdWQ9EwL2MuURncGZoSi3xT6WoMS032LuRxo1rpEGWZcxB8JbOVyDgSnA28YH
         W50J2pSDnCIe9xiL5DlXEPgOWaVMi92YB6qXHGvM/iWJq6O/5duEPrf/hm6pKzxywEPG
         9NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpV8xhNLB/scWysqMZej/wGnQkc4j31hL9ZxATH0HSQ=;
        b=QqMO8GsMeWT9VHL40Y/8tR5TonFtORFBKI80XZGyi+Ke2vGu90B+EjXgWYK7trJfDC
         zWS/lJpsiq4pCRWbCsCnp5vxBJsVwYo0wGEuwgJq5WeYOaBe0zdWM44bBdrxdCdnYzes
         0ZA7lSnices2MRBzwtpA/eTmu5eGtqSzU39GB6OHeAP1cQkTW5R1hjUXCX/yCHYbXVHw
         KMlveEHP/JpPuoUgUiROB6anevRzA+XZOMTF4Nah4SI7uWm+F9cupg2uXy7QX17rVlh/
         i2BAZ5GozDzZgyjUUld8rj/aIykcyBN8obMvt70hgadO3Oy+ceat13ZsvHVTQS/86Dgs
         YnDA==
X-Gm-Message-State: AGRZ1gIZ4Q6ELo9m4lBjjMBoNrQsrGYEhvQxG480U2G5gycxnJw/jxGl
        ns13KbLRV1zKaKpGgDJQCFZ98/9T
X-Google-Smtp-Source: AJdET5eEDk7zL9VztFkaTLfanU/hLQcwe8pg5l89fM1VkqpKZMh6h9aTJ9H1zv5qb3uax2lsZ3fsCw==
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr6276352ljb.104.1541828962900;
        Fri, 09 Nov 2018 21:49:22 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:22 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 03/22] list-objects-filter.c: remove implicit dependency on the_index
Date:   Sat, 10 Nov 2018 06:48:51 +0100
Message-Id: <20181110054910.10568-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at there, since we have access to struct repository now,
eliminate the only the_repository reference in this file.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 list-objects-filter.c | 10 +++++++---
 list-objects-filter.h |  2 ++
 list-objects.c        |  9 ++++++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 765f3df3b0..a62624a1ce 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -34,6 +34,7 @@ struct filter_blobs_none_data {
 };
 
 static enum list_objects_filter_result filter_blobs_none(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
@@ -88,6 +89,7 @@ struct filter_trees_none_data {
 };
 
 static enum list_objects_filter_result filter_trees_none(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
@@ -144,6 +146,7 @@ struct filter_blobs_limit_data {
 };
 
 static enum list_objects_filter_result filter_blobs_limit(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
@@ -171,7 +174,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
-		t = oid_object_info(the_repository, &obj->oid, &object_length);
+		t = oid_object_info(r, &obj->oid, &object_length);
 		if (t != OBJ_BLOB) { /* probably OBJ_NONE */
 			/*
 			 * We DO NOT have the blob locally, so we cannot
@@ -249,6 +252,7 @@ struct filter_sparse_data {
 };
 
 static enum list_objects_filter_result filter_sparse(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
@@ -268,7 +272,7 @@ static enum list_objects_filter_result filter_sparse(
 		dtype = DT_DIR;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
-					    &the_index);
+					    r->index);
 		if (val < 0)
 			val = filter_data->array_frame[filter_data->nr].defval;
 
@@ -331,7 +335,7 @@ static enum list_objects_filter_result filter_sparse(
 		dtype = DT_REG;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
-					    &the_index);
+					    r->index);
 		if (val < 0)
 			val = frame->defval;
 		if (val > 0) {
diff --git a/list-objects-filter.h b/list-objects-filter.h
index 52b4a84da9..1d45a4ad57 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -4,6 +4,7 @@
 struct list_objects_filter_options;
 struct object;
 struct oidset;
+struct repository;
 
 /*
  * During list-object traversal we allow certain objects to be
@@ -60,6 +61,7 @@ enum list_objects_filter_situation {
 };
 
 typedef enum list_objects_filter_result (*filter_object_fn)(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
diff --git a/list-objects.c b/list-objects.c
index c41cc80db5..0cfd646026 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -55,7 +55,8 @@ static void process_blob(struct traversal_context *ctx,
 	pathlen = path->len;
 	strbuf_addstr(path, name);
 	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
-		r = ctx->filter_fn(LOFS_BLOB, obj,
+		r = ctx->filter_fn(ctx->revs->repo,
+				   LOFS_BLOB, obj,
 				   path->buf, &path->buf[pathlen],
 				   ctx->filter_data);
 	if (r & LOFR_MARK_SEEN)
@@ -175,7 +176,8 @@ static void process_tree(struct traversal_context *ctx,
 
 	strbuf_addstr(base, name);
 	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
-		r = ctx->filter_fn(LOFS_BEGIN_TREE, obj,
+		r = ctx->filter_fn(ctx->revs->repo,
+				   LOFS_BEGIN_TREE, obj,
 				   base->buf, &base->buf[baselen],
 				   ctx->filter_data);
 	if (r & LOFR_MARK_SEEN)
@@ -191,7 +193,8 @@ static void process_tree(struct traversal_context *ctx,
 		process_tree_contents(ctx, tree, base);
 
 	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
-		r = ctx->filter_fn(LOFS_END_TREE, obj,
+		r = ctx->filter_fn(ctx->revs->repo,
+				   LOFS_END_TREE, obj,
 				   base->buf, &base->buf[baselen],
 				   ctx->filter_data);
 		if (r & LOFR_MARK_SEEN)
-- 
2.19.1.1231.g84aef82467

