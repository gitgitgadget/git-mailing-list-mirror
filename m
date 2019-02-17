Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50BD1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfBQKLb (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:11:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37351 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:11:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so7005584pgq.4
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jleZNUN/XlwENcXCZNd5RkzR7bRh5KggGH/AZOUaIIY=;
        b=Iy57y6EKKTuDxwS4drpqjZdevDLgMm/hiYoO1sieLf93kSaAJkEekzjtWZ5F+96dJI
         MQ+V6Z7QViDT6M/l48aax6FVxZHUjJx67ldqUwveAQuASnneRpxDbXYpSZ/Iw49EJxG8
         IM98ZhbzSFAd4llyv8ORqwhq12oJGGE6ZC/X0+oV8PzenxPx/rnZckbe2qiP0Il/+fZN
         WA3pk1puk3LIUBgLmHbLV4mVJr8EOO2Un1bsF9wQWyNhIekgVsmuDF3B19D/qpowlDBL
         TLcMxsmVaSpSoywOq+xlYhtyyTV5zuZ5XBS1ZmXP9jx3IYHAlzuImUxRRhEZ3Ux0V+FD
         P2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jleZNUN/XlwENcXCZNd5RkzR7bRh5KggGH/AZOUaIIY=;
        b=C8Gw3L/LbGbPWmJCuckVo5yQFUqwfFtXPYir/2EoRhltpwUWqvvE5fNvTkPRiy4hKN
         fFvrAuupTExxq8qVjogdobMQUgDGLz+wckVhphvPNLaZQTaBmoqCuKn2aWaqEtpAR3vC
         hszLApp2mAFL7xgv93/qTMyrLal9C1DtbzgtjaNNEQb6AozFtH/xWDjD6rB80bb/4c90
         z8YWsGCwdc2dnfdVRq+ilatdBGpNqW3880CfbtJVOAjkDbd7A/l+2on3MAcnIHJdVCRa
         f0CH288BsDsIF2ojoUcO2RujgWwij/h4p8v+vzcwKrQ4ZuufyyY/maPamCZcQtEku9Jx
         EXng==
X-Gm-Message-State: AHQUAuZuJsVvOj1eDlE52gZgI75cGzXiz/RLHk37c2phYvcC9fTwb7w8
        rTZ23xnqkRHDzV/WRv/STiDAudE6
X-Google-Smtp-Source: AHgI3Ib/9vW+lmssDfLrm75mYb4hzR3Bl4MgcRbj0y5dES/23wl2lA+80rFF6nRrr19evOtzZiW52g==
X-Received: by 2002:a62:170b:: with SMTP id 11mr18326139pfx.47.1550398290416;
        Sun, 17 Feb 2019 02:11:30 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x23sm28315167pfe.0.2019.02.17.02.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:11:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:11:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 30/31] sha1-name.c: remove the_repo from other get_oid_*
Date:   Sun, 17 Feb 2019 17:09:12 +0700
Message-Id: <20190217100913.4127-31-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h     | 18 ++++++++++++------
 sha1-name.c | 35 ++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index da7035c261..7ce8c566fc 100644
--- a/cache.h
+++ b/cache.h
@@ -1355,12 +1355,11 @@ enum get_oid_result {
 };
 
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
-#define get_oid(str, oid) repo_get_oid(the_repository, str, oid)
-extern int get_oid_commit(const char *str, struct object_id *oid);
-extern int get_oid_committish(const char *str, struct object_id *oid);
-extern int get_oid_tree(const char *str, struct object_id *oid);
-extern int get_oid_treeish(const char *str, struct object_id *oid);
-extern int get_oid_blob(const char *str, struct object_id *oid);
+int repo_get_oid_commit(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_committish(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_tree(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_treeish(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_blob(struct repository *r, const char *str, struct object_id *oid);
 void maybe_die_on_misspelt_object_name(struct repository *repo,
 				       const char *name,
 				       const char *prefix);
@@ -1368,6 +1367,13 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
 				unsigned flags, struct object_id *oid,
 				struct object_context *oc);
 
+#define get_oid(str, oid)		repo_get_oid(the_repository, str, oid)
+#define get_oid_commit(str, oid)	repo_get_oid_commit(the_repository, str, oid)
+#define get_oid_committish(str, oid)	repo_get_oid_committish(the_repository, str, oid)
+#define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, oid)
+#define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, str, oid)
+#define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, oid)
+
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
 int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
 #define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repository, prefix, fn, data)
diff --git a/sha1-name.c b/sha1-name.c
index b94d381bef..d49496397d 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1590,43 +1590,48 @@ int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
  * commit-ish. It is merely to give a hint to the disambiguation
  * machinery.
  */
-int get_oid_committish(const char *name, struct object_id *oid)
+int repo_get_oid_committish(struct repository *r,
+			    const char *name,
+			    struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_COMMITTISH,
+	return get_oid_with_context(r, name, GET_OID_COMMITTISH,
 				    oid, &unused);
 }
 
-int get_oid_treeish(const char *name, struct object_id *oid)
+int repo_get_oid_treeish(struct repository *r,
+			 const char *name,
+			 struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_TREEISH,
+	return get_oid_with_context(r, name, GET_OID_TREEISH,
 				    oid, &unused);
 }
 
-int get_oid_commit(const char *name, struct object_id *oid)
+int repo_get_oid_commit(struct repository *r,
+			const char *name,
+			struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_COMMIT,
+	return get_oid_with_context(r, name, GET_OID_COMMIT,
 				    oid, &unused);
 }
 
-int get_oid_tree(const char *name, struct object_id *oid)
+int repo_get_oid_tree(struct repository *r,
+		      const char *name,
+		      struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_TREE,
+	return get_oid_with_context(r, name, GET_OID_TREE,
 				    oid, &unused);
 }
 
-int get_oid_blob(const char *name, struct object_id *oid)
+int repo_get_oid_blob(struct repository *r,
+		      const char *name,
+		      struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_BLOB,
+	return get_oid_with_context(r, name, GET_OID_BLOB,
 				    oid, &unused);
 }
 
-- 
2.21.0.rc0.328.g0e39304f8d

