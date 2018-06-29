Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F641F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936452AbeF2BWu (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:22:50 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:58568 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936423AbeF2BWm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:22:42 -0400
Received: by mail-it0-f74.google.com with SMTP id k129-v6so448909itg.8
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0OTmx0xDHBC6Kl/eHG5xnKL7kSkzM5q7t/4pNziAL8E=;
        b=YczK0ABsSC8MfQb39SUBel3+2ZFVPldzbBVZYSWy3DonoXkP86o93HhewKomGvAPf7
         pI6obTr1lur3WR7L5ji92uZk06Pq4Rf8XK+cymWd+Au5jp/FrXPd8pRalLIHrvcusjSs
         fgampoyNx8Xsz2rghk/UIM9MTRx3nsTohnt+cMEecwt0XZqa5ROClT/jfhXSjGbJyXSe
         c0j9F3/4qYymcvZlEnl8+8zMGV3bI5t5UfCJplQ2oNE46ufg5VsrAva2qhoOGFKaCGmb
         HLOh2nWUmD91qQPQthB5QHVdp/iM35rb9lJN2eDEO8GHfZx2DvpgUUCynATpGgndZLV0
         QUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0OTmx0xDHBC6Kl/eHG5xnKL7kSkzM5q7t/4pNziAL8E=;
        b=PvFVQv6KqaQEU3au31E2h4OvFCs5CdCqfYlB2L6xLaSLhpgF1KLgZa5CQZ0hWMTAts
         4e3zNZ13oGOrMdRdFNvXe6A1mrWkt8lhDJGlbjUuSGZqHjDS6NTF2TurrYwZqY07Ijyo
         5Q7bLzpa8sF9HRD9/EunmUH+zJtOr/ScvN9KldJrDhG2W6+hX64tAQV+9fMKfyivVXwy
         1k3jM5X8AHrSqPjdjPWB+c20tBj3HakAwbxN0ZpvVqOldSAoN+VseTX7AO4v1TXfPOya
         cDgcts17Z6lzBpkoRRiYL0j5aJLOMiHv4ao/ZBYzq5Df9qNnoNuIP7ZcyUl3FwokTUNH
         NCmA==
X-Gm-Message-State: APt69E3WX/M1epMdL7+7Uy2Ot4TG4rRnAP/qRg2WHG41Y0M9YL8oCVTC
        jkwYqmLeVevL+xH0OIQmuAmjzkgN459XQl3wIdVXbz7nbq+PaQx1IXK4pYxwCy52Iu8P+l74dMt
        T4TEy7/VIRiUlTmTA0Jyxro35e0/dkGrUQV2wmBhC27pYxFwRty5N4ObiI0Rp
X-Google-Smtp-Source: AAOMgpcTwD6y8mEDBruc3AyvPGfdiCLAvizYbxt80qw8VxtwksTDCF5MnxESd346nzXQyzo8gar/MIjzd5sr
MIME-Version: 1.0
X-Received: by 2002:a24:694a:: with SMTP id e71-v6mr86647itc.52.1530235361287;
 Thu, 28 Jun 2018 18:22:41 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:21:54 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-5-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 04/32] object: add repository argument to object_as_type
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
index 09cf5333444..a906fe4a82b 100644
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
index b4dbfd889a3..0d55600e643 100644
--- a/commit.c
+++ b/commit.c
@@ -32,7 +32,7 @@ struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 
 	if (!obj)
 		return NULL;
-	return object_as_type(obj, OBJ_COMMIT, quiet);
+	return object_as_type(the_repository, obj, OBJ_COMMIT, quiet);
 }
 
 struct commit *lookup_commit_reference(const struct object_id *oid)
@@ -58,7 +58,7 @@ struct commit *lookup_commit(const struct object_id *oid)
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_commit_node(the_repository));
-	return object_as_type(obj, OBJ_COMMIT, 0);
+	return object_as_type(the_repository, obj, OBJ_COMMIT, 0);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/object.c b/object.c
index 49719694c14..404919043d4 100644
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
index 2ba23c07a72..3faa89578fc 100644
--- a/object.h
+++ b/object.h
@@ -114,7 +114,8 @@ struct object *lookup_object_the_repository(const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-void *object_as_type(struct object *obj, enum object_type type, int quiet);
+#define object_as_type(r, o, t, q) object_as_type_##r(o, t, q)
+void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet);
 
 /*
  * Returns the object, having parsed it to find out what it is.
diff --git a/refs.c b/refs.c
index 3b4508a97aa..fcfd3171e83 100644
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
index 73e8a8a948d..f31afb81be0 100644
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
2.18.0.399.gad0ab374a1-goog

