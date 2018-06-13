Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A765F1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935633AbeFMXFp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:05:45 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:39546 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935070AbeFMXFm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:05:42 -0400
Received: by mail-vk0-f73.google.com with SMTP id j68-v6so1636382vkj.6
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HWWQsjefFSYGsTrWoleVt2QhlVB4L1ihQMsZx7XOcSQ=;
        b=uuyr0BtvOTJMcDOz1tTrTbFA21TJIswuJ0+ET+PaxvC2ErASEWqbdBhKWpJCNxfs2p
         wykObdvR1rizuA2a8hfTrxm2D8FVmZ6mNJF6Co5jbTTm+gsbmu85yP1biOBXKWGFa5dB
         5fD4X5BeZo9xIGQxXm2Lcft30mimbnYltSJMWx03mSCT8J25YtQW8reLpyflLQ2YkqlV
         q4Iqo1QeY6Iw3vWbGwFRnI9jzB50qNaC5Nz6zrx726CFRyC+ucKYj4FU+5oJYc8uHrpK
         vChUVqWA1L5kluitnzrPHC9+mKQf0SpgF+jl/+kIaZlzuQObdM1tjq6AaiLKaYzJIegl
         fVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HWWQsjefFSYGsTrWoleVt2QhlVB4L1ihQMsZx7XOcSQ=;
        b=MpB+kqH4v3K7x7qFQJvjQ/GOhNnnUhJAIJsCjLNsZ1J6foXO+xBaVfu9aSJD7eTNXE
         Spo4KoZ2McKSBi266H8KJXw9AL6cLYY88p5wH2HUWcrnwn858FiQgSmaVeXbvz2yx+Hb
         tVG8U/BIcTRh9eEL5H4CSZy27j150tvIownm/EIwtRSCpdYZuImXdU09pJScKgyLWLKQ
         xINN9FlzrDkCs9f4MlWYyFg2HxUU8iYtf8Ds14To+OyOX4lG9hOzTZSj5AKTKuGgxIgi
         wmu/eRfLi594gfge/0ZUAnEMeNnOqCkB9JGKAuhLLAEv3jvZRv1VnuPSS/xHM69wFZCs
         o+LQ==
X-Gm-Message-State: APt69E0VVc9bhELo9zHPvK/ZAfmpowVDD/VANTafcyRABUp/JyuFBA0U
        WdRSipCbS4LWf1/CFgVi/WA3W2aXbYGDFGE+D7JmIdDUY+kzSCSkkXG2+p3w56KvnN1QAT6F/8p
        01dgSrBR8d11wbxnHwIVwWGzO3nqStZ27rbTPNkUNkALToxBG9p4UOGm7Leff
X-Google-Smtp-Source: ADUXVKJdobcukBgodHrKv/y4b8u+GG63dKEPWaedFC54ZOnpahMLCXlChY9rQcIAbgBz6HVkU0HQMk7p8Dp6
MIME-Version: 1.0
X-Received: by 2002:ab0:2497:: with SMTP id i23-v6mr87189uan.48.1528931141089;
 Wed, 13 Jun 2018 16:05:41 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:04:54 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-4-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 03/31] object: add repository argument to object_as_type
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index 6b8c9074920..72d7a9cbd8c 100644
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
index 0ffcf619cef..b221ba714a7 100644
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
index 7526ee151f5..5425d8e647c 100644
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
index 23d53957deb..0304e2b866f 100644
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
2.18.0.rc1.244.gcf134e6275-goog

