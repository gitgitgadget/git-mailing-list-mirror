Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BEFA1F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968507AbeE3Asl (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:48:41 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33496 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968494AbeE3As2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:28 -0400
Received: by mail-pg0-f54.google.com with SMTP id e21-v6so7330320pgv.0
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfR4xXihc7M/09v9iEIR52+RcxA6VQZzHMOGVED2mfk=;
        b=q64owUUvxt2Kl1qwwfIheMgywTG+HmbHIXo/c4KeDQg1TPSiGyP4Jr3GxnTKal8YqG
         Z8ySEnh/GFC4gj02bLax5DuH2OHMMrexl8yra46aouD4eQyqTlLxPgKrUMLAG2q8koZ8
         qpP6zirs/u7mtDVCZA+M0FLoPFYpnsa51a0qxlY4/D4z5OngmmF4lRmSYePA1gD2pVkc
         G+p9kKcHm8J99lw1cMKgabY5tnA2XZlSp7EN5ruwtfxCodDYGb0V8PA5xKNNCIWh7Lk4
         1eJwaYAr/xvdCsCrdpBvz9ifET1YTvxcCG555WidnNuPTvJND+wyo4dLFAz7xnjcEOTi
         ddYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfR4xXihc7M/09v9iEIR52+RcxA6VQZzHMOGVED2mfk=;
        b=X9gqxo+pNFQ9b+6Sc8TklKGdM+mkY0lh3RaB2Dbc7jTBcw7kRom2ryN8VY01oi43L2
         985ZYQSXyaz0FZmvn5d9vgeRS99rgk8oDN+PS9jk/GH9dGqNADIpl1t43aP9pY6urWxm
         pSpR9HzAd/tb0/OIj2llFdAA+fIs+e+DY9DyK+6N618aZ0W5ywwFj9L52uHs3GbN7Oi9
         MbHB0BI5VbZzES4F6fnw6fx16eUqo8g0NUXNmLuOuxAbajemhBjHaLBho4WAX4vjGFWo
         9uawSRA3XpZjDLSqjpswkgQeGB7LYAyYjnN5wEVd18kfYMxJ+pRM+3WCCXLyWpZr0z1z
         xcew==
X-Gm-Message-State: ALKqPwfw59hynIJox38ha42G2czE+DgArD5hIFvKSeJudSK1hRBjHKT2
        Lw0kvfkvxewX3pC/pI1xEHpBQn/61Hc=
X-Google-Smtp-Source: ADUXVKIzqe4eEEYThuX0ZNR2+e2XLa6UNScN1FWrgKETnaR/ZBG8lQEFR7iabw3lkU1nTfjMxC+8tA==
X-Received: by 2002:a63:a60a:: with SMTP id t10-v6mr454673pge.351.1527641307285;
        Tue, 29 May 2018 17:48:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l71-v6sm24359847pge.8.2018.05.29.17.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/35] object: add repository argument to object_as_type
Date:   Tue, 29 May 2018 17:47:40 -0700
Message-Id: <20180530004810.30076-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blob.c         | 2 +-
 builtin/fsck.c | 2 +-
 commit.c       | 4 ++--
 object.c       | 2 +-
 object.h       | 3 ++-
 refs.c         | 2 +-
 tag.c          | 2 +-
 tree.c         | 2 +-
 8 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/blob.c b/blob.c
index 75b737a761e..dada295698c 100644
--- a/blob.c
+++ b/blob.c
@@ -11,7 +11,7 @@ struct blob *lookup_blob(const struct object_id *oid)
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_blob_node(the_repository));
-	return object_as_type(obj, OBJ_BLOB, 0);
+	return object_as_type(the_repository, obj, OBJ_BLOB, 0);
 }
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index e6d6eb266eb..82a5acaf76e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -70,7 +70,7 @@ static const char *printable_type(struct object *obj)
 		enum object_type type = oid_object_info(the_repository,
 							&obj->oid, NULL);
 		if (type > 0)
-			object_as_type(obj, type, 0);
+			object_as_type(the_repository, obj, type, 0);
 	}
 
 	ret = type_name(obj->type);
diff --git a/commit.c b/commit.c
index 97b4ccde8f0..d76d64d4dfc 100644
--- a/commit.c
+++ b/commit.c
@@ -31,7 +31,7 @@ struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 
 	if (!obj)
 		return NULL;
-	return object_as_type(obj, OBJ_COMMIT, quiet);
+	return object_as_type(the_repository, obj, OBJ_COMMIT, quiet);
 }
 
 struct commit *lookup_commit_reference(const struct object_id *oid)
@@ -57,7 +57,7 @@ struct commit *lookup_commit(const struct object_id *oid)
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_commit_node(the_repository));
-	return object_as_type(obj, OBJ_COMMIT, 0);
+	return object_as_type(the_repository, obj, OBJ_COMMIT, 0);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/object.c b/object.c
index 4250ddd3f7f..bd5df7d007a 100644
--- a/object.c
+++ b/object.c
@@ -158,7 +158,7 @@ void *create_object(struct repository *r, const unsigned char *sha1, void *o)
 	return obj;
 }
 
-void *object_as_type(struct object *obj, enum object_type type, int quiet)
+void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
 		return obj;
diff --git a/object.h b/object.h
index c6386d7b6b1..f2afe7cc66f 100644
--- a/object.h
+++ b/object.h
@@ -115,7 +115,8 @@ struct object *lookup_object_the_repository(const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-void *object_as_type(struct object *obj, enum object_type type, int quiet);
+#define object_as_type(r, o, t, q) object_as_type_##r(o, t, q)
+void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet);
 
 /*
  * Returns the object, having parsed it to find out what it is.
diff --git a/refs.c b/refs.c
index 3b9e8463656..310d5f81dbf 100644
--- a/refs.c
+++ b/refs.c
@@ -305,7 +305,7 @@ enum peel_status peel_object(const struct object_id *name, struct object_id *oid
 
 	if (o->type == OBJ_NONE) {
 		int type = oid_object_info(the_repository, name, NULL);
-		if (type < 0 || !object_as_type(o, type, 0))
+		if (type < 0 || !object_as_type(the_repository, o, type, 0))
 			return PEEL_INVALID;
 	}
 
diff --git a/tag.c b/tag.c
index 1b95eb9f07f..a14a4f23037 100644
--- a/tag.c
+++ b/tag.c
@@ -98,7 +98,7 @@ struct tag *lookup_tag(const struct object_id *oid)
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_tag_node(the_repository));
-	return object_as_type(obj, OBJ_TAG, 0);
+	return object_as_type(the_repository, obj, OBJ_TAG, 0);
 }
 
 static timestamp_t parse_tag_date(const char *buf, const char *tail)
diff --git a/tree.c b/tree.c
index 47ecc85f90a..bd74ed66e23 100644
--- a/tree.c
+++ b/tree.c
@@ -201,7 +201,7 @@ struct tree *lookup_tree(const struct object_id *oid)
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_tree_node(the_repository));
-	return object_as_type(obj, OBJ_TREE, 0);
+	return object_as_type(the_repository, obj, OBJ_TREE, 0);
 }
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
-- 
2.17.0.582.gccdcbd54c44.dirty

