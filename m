Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93AD20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDFLiJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:38:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38893 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:38:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so4767240pfo.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4UsmkkHNE/w67i9pZNTRUVeoBYpvfa1184swHxAb98=;
        b=hO7smCy0BksyM825VhcVBQUacQLZDCIgVkXe4EKwE+0V+sKVlBnrfJL6XEyCUrJgVZ
         +o1Wnhfb1n8LwMbewhB4RMTg+i2qrv/cKtP6SgSS7GhkB7u00amtjuZY7x3nPDUvqE5z
         VNTFj8XZezPy2/ngk3/C+rtVFe4eEXVws+j/3mYoSSAh0Y7/J/oU60HlL6QKLQQ72hpq
         LA59+dWkiBhQBu0VBgs+sPsz9phkqmbPEXLaUZpMNnOpKgStnQem4fxjeMvDp1sSM0ss
         Ca4DaD7305wUFyw8hQqKGOXfso1lb00pR2pEGUWy39x2c2dl6xcG7EiA7hhJyY3LZXK6
         rFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4UsmkkHNE/w67i9pZNTRUVeoBYpvfa1184swHxAb98=;
        b=BvW60mwDulkYMek4ci2qX465duNxQBRgV/obnKiL1Gq9F4B/iN2P0o3KEr/QxB77ai
         XzZ/vPa7gPyuGljC4f+nGQxR9c0GE3O09KczFF4zw7Fy49RglQb/4NY2ykU8c6vhHgWb
         U0Bs/u+49jIbgw6ZYZ3VMYAE/H+gpbKfQcxB5mwGaThmIy1RR+Ut8GhfssT8MA9IGo6v
         8dm+Jn9YhrpUqzgYAWXAXc4l+Oq+TCBeunlj+Xkh2pi2DYEiAxQVanRkdCRfMdC3xF59
         ezFi7vIe+gw+SNAe1z0nvq2ACCUAnF7cvMD4Rb5j5wZzV9xu+6E9F2befG7nZLiclOwI
         Loog==
X-Gm-Message-State: APjAAAV/losLadJ/LprBJeKhknRWoSTolsVKr78c6W9yrStHO8L9YWNS
        IvvnbOrAHoPRjaxhzzW9ncCYauYi
X-Google-Smtp-Source: APXvYqxBBHOphIFvrRBPwLHF15rkMeuxS1BY0LO3wez82bqFYJg3xI7rhf8xRs2p3NzclTLv13C7cA==
X-Received: by 2002:a63:3d85:: with SMTP id k127mr17455292pga.152.1554550688580;
        Sat, 06 Apr 2019 04:38:08 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id i79sm53667249pfj.28.2019.04.06.04.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:38:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:38:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 32/33] sha1-name.c: remove the_repo from other get_oid_*
Date:   Sat,  6 Apr 2019 18:34:52 +0700
Message-Id: <20190406113453.5149-33-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

