Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655D420248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfDPJhv (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:37:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41315 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfDPJhv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:37:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so10052238pgs.8
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRuEv926aMOZTHL0yq7NWx01gvtB4KDzBoGmI2mX+LM=;
        b=vS+zSYOSGiYWfGJaP8wSHgKZ0zkq6ORjX7ExmFX3GTqD08RCFMIW0Zvp+Ip19M6cy3
         +U5rtVdflpL8D8i8Wyz3/HQLYISSB+70a6HakGtkcsilnzboigB0NlcMciWsYsaNTQtb
         SxHnA9y8DIKwT4RyQBd2+8EzHNI3/FcRE3fL2Z9Y7bnK41KO1u7p8gGzhyEWjPriq/s8
         ytM5oeaP6XNBW9aUnhzUZQcyxgZupAbeID1V3tmgdYo/9k8+JvPhL0nqUGxYjzMT7LSJ
         /OPoEy/GEyVY6qs18XdVxKZzwkyAWrc7Ug9Y3mmTJh0WHmyOmK4aIEY8MN6sCQjfRT0k
         ciEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRuEv926aMOZTHL0yq7NWx01gvtB4KDzBoGmI2mX+LM=;
        b=AO0edqbSyrow5HU2BbWz60C01CnTIKKzwEkp8mnWs8OrQZ+xfdEoH6sW+qk+lID6wK
         JgsE/5WVmbS2EMhxGLle+AMhDnt7DbCd0tAQidmtU448J3vK24uyRBOaqt9w17JEGsS1
         UPyTanGSZ8pxAOvx5r0UG3xdUKRPyTogt0ERt2B52bu3eD1JnS0itKThaoJ1iKNiP/oM
         kNToiOw4e18pvjaR3YLnoIVQPsT9N3ktYTFbOsXElnwNbRjcxFfeWUHUrovGYOLc7WQa
         +KyA6+QpP7j//3TA2MqB7W11EZm1mzarorkqKP0Rn4UgCrYhOroCgGqN7fbwwexCxkNI
         6gCw==
X-Gm-Message-State: APjAAAU3rAlfTfxxIX3hpEYnUxLQcxo8ROEUgu5MkVSdvBZ4ovtgCJRp
        Y482xal1DdG9MeNcSXda16jC2q3G
X-Google-Smtp-Source: APXvYqw9vP6Y6Y4YV8urAz2jUqCT6xj7+i0GC6gDd4Ge0EK2w6ebvZ68zo2Dx12wGQ9tV0kow34tcQ==
X-Received: by 2002:a65:51c8:: with SMTP id i8mr75407145pgq.175.1555407470116;
        Tue, 16 Apr 2019 02:37:50 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id q74sm93145575pfc.111.2019.04.16.02.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:37:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:37:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 33/34] sha1-name.c: remove the_repo from other get_oid_*
Date:   Tue, 16 Apr 2019 16:33:40 +0700
Message-Id: <20190416093341.17079-34-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
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
index 3718b3db8a..871a167bf8 100644
--- a/cache.h
+++ b/cache.h
@@ -1381,12 +1381,11 @@ enum get_oid_result {
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
@@ -1394,6 +1393,13 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
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
2.21.0.682.g30d2204636

