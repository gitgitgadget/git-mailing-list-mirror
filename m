Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFA81F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeBFAWZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:22:25 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42146 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeBFAWV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:22:21 -0500
Received: by mail-pl0-f68.google.com with SMTP id 11so120490plc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KpNb06aB3zJ0SuYL2ncM6w+KU4xEfIDDVGiJbXH9FRQ=;
        b=Tvz3YZjcdsJvht8Ie4vijqxmKWgm0wu/pnLUhgsULB+xbNas/Iyw+3KRjch/VtQsis
         1fJkFAa8q0s2uq+WjuZS+mYp25gHCj+T5CjFp4V8FZuSNl/acjfPNMHv/fhpNmnSGCeg
         WUwvKNUK4ezN0ie55qsFD9B5CXDRgLrr8WbBK3bSglvUUpmrjKCtmVpPPlcYXSuSE8uv
         gInBiNKpf5bgZu6VzByK8L05BbBzPQvrHMH7rurtPQ5InV+oK7/mex6qH8NnJ6kSFVex
         z5uZXFl3su3v753BOi7/BSHvbZkBWLWjTALXAB5wA1ylS9Hk95nZokcxgqHazQYGab2a
         JlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KpNb06aB3zJ0SuYL2ncM6w+KU4xEfIDDVGiJbXH9FRQ=;
        b=Zp/T5SEWdWEn9tjdgzBVKdEz/j2iqKiERnTdg0HpImljU/rk1WybW7nxBMR2uxhHVP
         jI0pRveRWQxASol4kMM2CYiYPyEIRBLth46epXzGuSJ/joLsiEyJP1nDd4E1tWEW7NC7
         pnt+7ov+cnP4ORZ5JKs1bbOBeRq0FJuAzIy4yeFJcr8hYZ0BREs+bFV3T16BAO3ajYsg
         x3x/GmTY4/6vDgupAh4l05cdrflXzpx6Tnoe4VszdZe/LDMoeS4vqfJYGJB5cBVGjAqK
         6YRkf1ywlUixvwNEKRPsAWTYK7k+SnQywMODcNfB888TCITG2U6ueuRd1T6ukAgVdcnw
         eV4A==
X-Gm-Message-State: APf1xPAQ1iNZeDanLdb6d8ZgY8NMLC8wWTTFelbwOTJK7lQblsoHY1Hh
        vFd2xL3iC1z5aF5sp0KqIPqxVXJBg4U=
X-Google-Smtp-Source: AH8x225rmOKqJCnCI1yRolAcywEIQ9kFLgEU8iasK0+qBjAsJktE++rlyGhFRm69Ag41FCHvJNkQNw==
X-Received: by 2002:a17:902:9683:: with SMTP id n3-v6mr527516plp.177.1517876540272;
        Mon, 05 Feb 2018 16:22:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q82sm18605237pfa.58.2018.02.05.16.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:22:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 128/194] object: add repository argument to object_as_type
Date:   Mon,  5 Feb 2018 16:16:43 -0800
Message-Id: <20180206001749.218943-30-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
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
index 25faf3e692..0c53cfce45 100644
--- a/blob.c
+++ b/blob.c
@@ -10,7 +10,7 @@ struct blob *lookup_blob_the_repository(const struct object_id *oid)
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_blob_node());
-	return object_as_type(obj, OBJ_BLOB, 0);
+	return object_as_type(the_repository, obj, OBJ_BLOB, 0);
 }
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 527c03eb39..2e8b298384 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -72,7 +72,7 @@ static const char *printable_type(struct object *obj)
 		enum object_type type = sha1_object_info(the_repository,
 							 obj->oid.hash, NULL);
 		if (type > 0)
-			object_as_type(obj, type, 0);
+			object_as_type(the_repository, obj, type, 0);
 	}
 
 	ret = typename(obj->type);
diff --git a/commit.c b/commit.c
index 2fb702795c..953c537059 100644
--- a/commit.c
+++ b/commit.c
@@ -30,7 +30,7 @@ struct commit *lookup_commit_reference_gently_the_repository(
 
 	if (!obj)
 		return NULL;
-	return object_as_type(obj, OBJ_COMMIT, quiet);
+	return object_as_type(the_repository, obj, OBJ_COMMIT, quiet);
 }
 
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid)
@@ -56,7 +56,7 @@ struct commit *lookup_commit_the_repository(const struct object_id *oid)
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_commit_node());
-	return object_as_type(obj, OBJ_COMMIT, 0);
+	return object_as_type(the_repository, obj, OBJ_COMMIT, 0);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/object.c b/object.c
index 28f536dcae..156fbae15e 100644
--- a/object.c
+++ b/object.c
@@ -155,7 +155,7 @@ void *create_object(struct repository *r, const unsigned char *sha1, void *o)
 	return obj;
 }
 
-void *object_as_type(struct object *obj, enum object_type type, int quiet)
+void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
 		return obj;
diff --git a/object.h b/object.h
index d676404f00..a61d965700 100644
--- a/object.h
+++ b/object.h
@@ -106,7 +106,8 @@ struct object *lookup_object(struct repository *r, const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-void *object_as_type(struct object *obj, enum object_type type, int quiet);
+#define object_as_type(r, o, t, q) object_as_type_##r(o, t, q)
+void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet);
 
 /*
  * Resolves 'sha1' to an object of the specified type and returns the
diff --git a/refs.c b/refs.c
index 0ea9b05d03..24fa57b0f1 100644
--- a/refs.c
+++ b/refs.c
@@ -304,7 +304,7 @@ enum peel_status peel_object(const struct object_id *name, struct object_id *oid
 
 	if (o->type == OBJ_NONE) {
 		int type = sha1_object_info(the_repository, name->hash, NULL);
-		if (type < 0 || !object_as_type(o, type, 0))
+		if (type < 0 || !object_as_type(the_repository, o, type, 0))
 			return PEEL_INVALID;
 	}
 
diff --git a/tag.c b/tag.c
index e2fd31ffc7..abba1b8d88 100644
--- a/tag.c
+++ b/tag.c
@@ -98,7 +98,7 @@ struct tag *lookup_tag_the_repository(const struct object_id *oid)
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_tag_node());
-	return object_as_type(obj, OBJ_TAG, 0);
+	return object_as_type(the_repository, obj, OBJ_TAG, 0);
 }
 
 static timestamp_t parse_tag_date(const char *buf, const char *tail)
diff --git a/tree.c b/tree.c
index f1c4e937c8..37fec8623b 100644
--- a/tree.c
+++ b/tree.c
@@ -200,7 +200,7 @@ struct tree *lookup_tree_the_repository(const struct object_id *oid)
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_tree_node());
-	return object_as_type(obj, OBJ_TREE, 0);
+	return object_as_type(the_repository, obj, OBJ_TREE, 0);
 }
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
-- 
2.15.1.433.g936d1b9894.dirty

