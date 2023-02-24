Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43182C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBXAKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBXAJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FC019F13
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c12so12328210wrw.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/xn+HgvYrS95jt13hJGU0co0KYRBMbn2u24VFc0FfQ=;
        b=hND76v3RFTMK4Vrn1nzMIPBB4+tpXdyneecV5d+QAcYm29o3JIcO/c/vPEIwB8PdYv
         vO9d4EOrOTDSR9gGZrG7Hi+x3UWXcZyp0uVufOHbi9/uM1KjKogoHrxZEH5v0aSiGFoJ
         R/xs8dzJJZ2MhsvozmJIPKOOxLUwVTLdbDBUau8ILUxUGOVbRNuRSFrOf8Iw9w7gsNoO
         GM9z3FY31YMuu6PhWWAbrGIxFel/1MhVA4V7XsA4pwfRYsHjm5KypGeWBXdCFtVDvflV
         yg+LsPCLWEeNtmlMYSunpuGZObPsqgiQhIETXwQ2OimCq5ntLFUztWG8G+pjmfS4rgu6
         o2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/xn+HgvYrS95jt13hJGU0co0KYRBMbn2u24VFc0FfQ=;
        b=vUaS8BolLjRgX/opU0C8/vx/B2PgBHLFmCAUJ2kuuO86nN/bUqw8UvbQRkwa+UgCym
         BE/ld9kPYYP1W2w63F88uYMEbu1NWhgxgJUiPYooImc99f41UE34NK+wm4YSKXILPEMQ
         uqYI0AWDaaYOBAGxfYag2DJgr6/nFRb752v7Ws+Spn1xAnuGcr3LXEtzkw0yikl5Dm5Q
         0MSWHxxTw3ohFdC1IphPRCNPmJyG3I38uhUT51oOndDzVdWCwobOQ3DkGpRkXmzMHY9t
         Sr0GAAvtkjmMTSPTyiv8fD/GSvwONcyocnmB9vrgMQgExKzxyLfptVtXqSz80J06Mcmz
         f4BQ==
X-Gm-Message-State: AO0yUKXpTPholrN5sMNTCsKFtOibldP1znZA4TxzFIV+ItWVp102jjNS
        XBhCqFyCLdfGXYlCJcjkhr+h5HztK08=
X-Google-Smtp-Source: AK7set97jS84ANFqlwN5kcv3HH8KLQBOzMTOb13WZVYCmEHrTAMhnDva1cynB+pB24jNnsEHQNN2GA==
X-Received: by 2002:adf:f010:0:b0:2c7:5ad:9c69 with SMTP id j16-20020adff010000000b002c705ad9c69mr8664909wro.71.1677197390791;
        Thu, 23 Feb 2023 16:09:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a0560001a4800b002c54e26bca5sm1586324wry.49.2023.02.23.16.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:50 -0800 (PST)
Message-Id: <12eb68b1ba36fcdcb5d97c6119db5581477a742c.1677197378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:32 +0000
Subject: [PATCH v2 13/17] object-store.h: move struct object_info from cache.h
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

Move struct object_info, and a few related #define's from cache.h to
object-store.h.

A surprising effect of this change is that replace-object.h, which
includes object-store.h, now needs to directly include cache.h since
that is where read_replace_refs is declared and that variable is used
in one of its inline functions.  The next commit will move that
declaration and fix that unfortunate new direct inclusion of cache.h.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-blobs.c    |   2 +-
 object-store.h   | 128 +++++++++++++++++++++++------------------------
 protocol-caps.c  |   1 +
 replace-object.h |   1 +
 4 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/merge-blobs.c b/merge-blobs.c
index 8138090f81c..aedcab81138 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "run-command.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
diff --git a/object-store.h b/object-store.h
index 1a713d89d7c..82201ec3e7b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,7 +1,7 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
-#include "cache.h"
+#include "object.h"
 #include "oidmap.h"
 #include "list.h"
 #include "oid-array.h"
@@ -284,6 +284,69 @@ int pretend_object_file(void *, unsigned long, enum object_type,
 
 int force_object_loose(const struct object_id *oid, time_t mtime);
 
+struct object_info {
+	/* Request */
+	enum object_type *typep;
+	unsigned long *sizep;
+	off_t *disk_sizep;
+	struct object_id *delta_base_oid;
+	struct strbuf *type_name;
+	void **contentp;
+
+	/* Response */
+	enum {
+		OI_CACHED,
+		OI_LOOSE,
+		OI_PACKED,
+		OI_DBCACHED
+	} whence;
+	union {
+		/*
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } cached;
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } loose;
+		 */
+		struct {
+			struct packed_git *pack;
+			off_t offset;
+			unsigned int is_delta;
+		} packed;
+	} u;
+};
+
+/*
+ * Initializer for a "struct object_info" that wants no items. You may
+ * also memset() the memory to all-zeroes.
+ */
+#define OBJECT_INFO_INIT { 0 }
+
+/* Invoke lookup_replace_object() on the given hash */
+#define OBJECT_INFO_LOOKUP_REPLACE 1
+/* Allow reading from a loose object file of unknown/bogus type */
+#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
+/* Do not retry packed storage after checking packed and loose storage */
+#define OBJECT_INFO_QUICK 8
+/*
+ * Do not attempt to fetch the object if missing (even if fetch_is_missing is
+ * nonzero).
+ */
+#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
+/*
+ * This is meant for bulk prefetching of missing blobs in a partial
+ * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
+ */
+#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
+
+/* Die if object corruption (not just an object being missing) was detected. */
+#define OBJECT_INFO_DIE_IF_CORRUPT 32
+
+int oid_object_info_extended(struct repository *r,
+			     const struct object_id *,
+			     struct object_info *, unsigned flags);
+
 /*
  * Open the loose object at path, check its hash, and return the contents,
  * use the "oi" argument to assert things about the object, or e.g. populate its
@@ -381,69 +444,6 @@ static inline void obj_read_unlock(void)
 		pthread_mutex_unlock(&obj_read_mutex);
 }
 
-struct object_info {
-	/* Request */
-	enum object_type *typep;
-	unsigned long *sizep;
-	off_t *disk_sizep;
-	struct object_id *delta_base_oid;
-	struct strbuf *type_name;
-	void **contentp;
-
-	/* Response */
-	enum {
-		OI_CACHED,
-		OI_LOOSE,
-		OI_PACKED,
-		OI_DBCACHED
-	} whence;
-	union {
-		/*
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } cached;
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } loose;
-		 */
-		struct {
-			struct packed_git *pack;
-			off_t offset;
-			unsigned int is_delta;
-		} packed;
-	} u;
-};
-
-/*
- * Initializer for a "struct object_info" that wants no items. You may
- * also memset() the memory to all-zeroes.
- */
-#define OBJECT_INFO_INIT { 0 }
-
-/* Invoke lookup_replace_object() on the given hash */
-#define OBJECT_INFO_LOOKUP_REPLACE 1
-/* Allow reading from a loose object file of unknown/bogus type */
-#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
-/* Do not retry packed storage after checking packed and loose storage */
-#define OBJECT_INFO_QUICK 8
-/*
- * Do not attempt to fetch the object if missing (even if fetch_is_missing is
- * nonzero).
- */
-#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
-/*
- * This is meant for bulk prefetching of missing blobs in a partial
- * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
- */
-#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
-
-/* Die if object corruption (not just an object being missing) was detected. */
-#define OBJECT_INFO_DIE_IF_CORRUPT 32
-
-int oid_object_info_extended(struct repository *r,
-			     const struct object_id *,
-			     struct object_info *, unsigned flags);
-
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:
diff --git a/protocol-caps.c b/protocol-caps.c
index f9bc2a8b90b..874bc815b4f 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -5,6 +5,7 @@
 #include "pkt-line.h"
 #include "strvec.h"
 #include "hash.h"
+#include "hex.h"
 #include "object.h"
 #include "object-store.h"
 #include "string-list.h"
diff --git a/replace-object.h b/replace-object.h
index 3fbc32eb7b7..3c92ae94610 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -1,6 +1,7 @@
 #ifndef REPLACE_OBJECT_H
 #define REPLACE_OBJECT_H
 
+#include "cache.h"
 #include "oidmap.h"
 #include "repository.h"
 #include "object-store.h"
-- 
gitgitgadget

