Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC9FC61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBXAKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBXAJw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504661CAD5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j2so12145846wrh.9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oTd4oGYUWNeX1XfriPfzFZ4g6Fr/Lz3jalhXGhBz3I=;
        b=F/pIX9yu9A7ztEG+R94RBc7/KQnkAap4WPLDyLKK7qEVO3kCMiO7GCcAXGmLCa+X9e
         VZHm7n2VSuPGsurz1uqGeDkXTZgnxBJ/Ql7r39JmgYSIfmXBX57e74ARYscRD2Vl3wZO
         7bE6ZnXi7dp0mbZTvHOtO97GtY+qclSnElLvpM8jBk+s/qD2EWqmhHMcVrheBJLxuNtq
         uOfol5KBi/4CA5W5JE7vM3vF7/f+Jo/tyqoOOhgyujS29ZZ9sh7z4CTUcXOFEXnegSch
         kxi9rERXXQD17i5FHEfwY+EsRkNMlc9vlzND9o63QRNzr6CIOl1SOMWQxlI6vr5y91cV
         jUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oTd4oGYUWNeX1XfriPfzFZ4g6Fr/Lz3jalhXGhBz3I=;
        b=RlOzewcDeI5LVJmuQZamJJ2X+6A8W43V9LbJFJrlw0e2DejTa86V0zUgc3MaI39wwa
         0ybsCDZQhnhIm1YKrJLCD0REsh8J8eT5tuLV58lrCxNbsUxpbdGOjMpQ3IJ6ADixZrY2
         JqLd8FT/SNr+dACJfr8LKbHJxaMj0xhq9prWJIy3dz48xnSdeTuB3FpRL2PEcNYYvYBv
         /TEIzWMv9f8qqrKBy24twYtJ9DrX+QN+vKnhgfN0dnpu/4Uk2rDv8unGKLO4bqEKprte
         XIvByJGZJ1kZX9IiRV6rGDUt86NfxDVKUDXd8HEWV3f0OgDLPhBnkGnhnAG85exrUpof
         ke6w==
X-Gm-Message-State: AO0yUKU8Fd7RtlFSLY+OGk/n4eRRF5QXcN9M/TqtG2KTVPyDYSk027va
        QdNYZOmd5Xto9Zzdhqj9mXT0JfoO0Fc=
X-Google-Smtp-Source: AK7set/bYoOAtko/5oSKVbBbBP9wucvaRcVXqz7nrM5hAnMdJrqPFI7XSELsOiozTkTzhEHIZOShBg==
X-Received: by 2002:adf:fc84:0:b0:2c7:1c08:121a with SMTP id g4-20020adffc84000000b002c71c08121amr596433wrr.68.1677197385637;
        Thu, 23 Feb 2023 16:09:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b003dc1d668866sm852969wmi.10.2023.02.23.16.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:45 -0800 (PST)
Message-Id: <b5046b7aaa684b8de6d2971be49cf5cba27eac08.1677197377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:25 +0000
Subject: [PATCH v2 06/17] hash.h: move some oid-related declarations from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

These defines and enum are all oid-related and as such seem to make
more sense being included in hash.h.  Further, moving them there
allows us to remove some includes of cache.h in other files.

The change to line-log.h might look unrelated, but line-log.h includes
diffcore.h, which previously included cache.h, which included the
kitchen sink.  Since this patch makes diffcore.h no longer include
cache.h, the compiler complains about the 'struct string_list *'
function parameter.  Add a forward declaration for struct string_list to
address this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h                                      | 34 --------------------
 diffcore.h                                   |  4 ++-
 hash.h                                       | 34 ++++++++++++++++++++
 line-log.h                                   |  1 +
 submodule-config.h                           |  1 -
 t/helper/test-submodule-nested-repo-config.c |  1 +
 tree-walk.h                                  |  4 ++-
 7 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/cache.h b/cache.h
index 0f1f9dde56b..daf6150bb3c 100644
--- a/cache.h
+++ b/cache.h
@@ -1363,40 +1363,6 @@ struct object_context {
 	char *path;
 };
 
-#define GET_OID_QUIETLY           01
-#define GET_OID_COMMIT            02
-#define GET_OID_COMMITTISH        04
-#define GET_OID_TREE             010
-#define GET_OID_TREEISH          020
-#define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
-#define GET_OID_ONLY_TO_DIE    04000
-#define GET_OID_REQUIRE_PATH  010000
-
-#define GET_OID_DISAMBIGUATORS \
-	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
-	GET_OID_TREE | GET_OID_TREEISH | \
-	GET_OID_BLOB)
-
-enum get_oid_result {
-	FOUND = 0,
-	MISSING_OBJECT = -1, /* The requested object is missing */
-	SHORT_NAME_AMBIGUOUS = -2,
-	/* The following only apply when symlinks are followed */
-	DANGLING_SYMLINK = -4, /*
-				* The initial symlink is there, but
-				* (transitively) points to a missing
-				* in-tree file
-				*/
-	SYMLINK_LOOP = -5,
-	NOT_DIR = -6, /*
-		       * Somewhere along the symlink chain, a path is
-		       * requested which contains a file as a
-		       * non-final element.
-		       */
-};
-
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
 __attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);
diff --git a/diffcore.h b/diffcore.h
index 9b588a1ee15..1701ed50b9c 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -4,9 +4,11 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
 
-#include "cache.h"
+#include "hash.h"
 
 struct diff_options;
+struct mem_pool;
+struct oid_array;
 struct repository;
 struct strintmap;
 struct strmap;
diff --git a/hash.h b/hash.h
index 351afc2ce3b..d39f73618cb 100644
--- a/hash.h
+++ b/hash.h
@@ -123,6 +123,40 @@ struct object_id {
 	int algo;	/* XXX requires 4-byte alignment */
 };
 
+#define GET_OID_QUIETLY           01
+#define GET_OID_COMMIT            02
+#define GET_OID_COMMITTISH        04
+#define GET_OID_TREE             010
+#define GET_OID_TREEISH          020
+#define GET_OID_BLOB             040
+#define GET_OID_FOLLOW_SYMLINKS 0100
+#define GET_OID_RECORD_PATH     0200
+#define GET_OID_ONLY_TO_DIE    04000
+#define GET_OID_REQUIRE_PATH  010000
+
+#define GET_OID_DISAMBIGUATORS \
+	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
+	GET_OID_TREE | GET_OID_TREEISH | \
+	GET_OID_BLOB)
+
+enum get_oid_result {
+	FOUND = 0,
+	MISSING_OBJECT = -1, /* The requested object is missing */
+	SHORT_NAME_AMBIGUOUS = -2,
+	/* The following only apply when symlinks are followed */
+	DANGLING_SYMLINK = -4, /*
+				* The initial symlink is there, but
+				* (transitively) points to a missing
+				* in-tree file
+				*/
+	SYMLINK_LOOP = -5,
+	NOT_DIR = -6, /*
+		       * Somewhere along the symlink chain, a path is
+		       * requested which contains a file as a
+		       * non-final element.
+		       */
+};
+
 /* A suitably aligned type for stack allocations of hash contexts. */
 union git_hash_ctx {
 	git_SHA_CTX sha1;
diff --git a/line-log.h b/line-log.h
index 82ae8d98a40..adff361b1bc 100644
--- a/line-log.h
+++ b/line-log.h
@@ -5,6 +5,7 @@
 
 struct rev_info;
 struct commit;
+struct string_list;
 
 /* A range [start,end].  Lines are numbered starting at 0, and the
  * ranges include start but exclude end. */
diff --git a/submodule-config.h b/submodule-config.h
index 28a8ca6bf46..c2045875bbb 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -1,7 +1,6 @@
 #ifndef SUBMODULE_CONFIG_CACHE_H
 #define SUBMODULE_CONFIG_CACHE_H
 
-#include "cache.h"
 #include "config.h"
 #include "hashmap.h"
 #include "submodule.h"
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index dc1c14bde37..a3848a8b668 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -1,4 +1,5 @@
 #include "test-tool.h"
+#include "cache.h"
 #include "submodule-config.h"
 
 static void die_usage(const char **argv, const char *msg)
diff --git a/tree-walk.h b/tree-walk.h
index 6305d531503..25fe27e3529 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,7 +1,9 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
-#include "cache.h"
+#include "hash.h"
+
+struct index_state;
 
 #define MAX_TRAVERSE_TREES 8
 
-- 
gitgitgadget

