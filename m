Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B79AC6379F
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjBWIGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjBWIFp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320CB497C9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so5424608wmq.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J5ag7W8Qc7Fj5Xtx5vyk+neaYs5Q6+VWJ09EaED+KU=;
        b=fQvFwyCaO7CgB9XOUfvXQBLZw3HqLZitPXT4+m0pm8SI018udrpkBWoZT+QCFE+48V
         hvhQctqXl0Jy999d4uoYPMhyPwzmKTKKTmh1NTEjXwKocEIoWffrVb/nwWU3rFetX1oP
         L5hMd+mR1dr6eiaAexWfTKPidmItFDbktF2cFg13tLBYUSCZHTdB5iLScKx2Hwswf7ij
         mxTGs/cW3tL5wRB3zzHLsLKmtk9kceNGwuLD09fVd7NnjRfOSFaaFENkiJej4aGMtiGF
         IykH/cp1Hx4mSSjwPLIenwVrz0bkM6bHlZMopk/8GXe44JnBR28/+I2NS9F7ZNuBlOiW
         FUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J5ag7W8Qc7Fj5Xtx5vyk+neaYs5Q6+VWJ09EaED+KU=;
        b=oiwEM12r2mFf82bLQBnkxKwUV5sLl9/GlkharHfuT7yZqcsKOSc6GfrRnq6qRlGvEW
         SdwJl6Bqqp3ZBE8OQHttGpeJYmta+8CQRo0Jo/MYpTeWaY8x3EcSNbhD7RrJOHYbmJo1
         Hp8UWunCJSblhBsf086uWlLA/27OgkPjTeoll7K6mCUCVqgpfKSr0F+vprWf73Qbb1ZK
         XujhBrG+AA3+SqUMMGmi0GMy+iK4So0qikfjsKztpdpaMOgWE8uxgQsEaIZhSFlD+2+I
         XTZK+MibSlXxFiNty1kTPbETCp27da6KQ+uu6kKEQGSzd1PjIG4L/0CHi0x4i9FRMkaC
         TPuQ==
X-Gm-Message-State: AO0yUKU6BIA6hrRrSWUYNbabaTF5oMHYpSd8DHthi2tOs9klAVpBBHjp
        S5+UhVvrAvAoIwdEy2hJ9dfwlz4KXxQ=
X-Google-Smtp-Source: AK7set+0oXNemmuIPvYcpg8N+IYk6B85Rh8EAKB+jcZtL+/G3g0uDEHDKymF39xW8psithjXN6xF3w==
X-Received: by 2002:a05:600c:44c5:b0:3e2:cf0:4087 with SMTP id f5-20020a05600c44c500b003e20cf04087mr6571054wmo.32.1677139532449;
        Thu, 23 Feb 2023 00:05:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c274100b003dfe549da4fsm10916366wmw.18.2023.02.23.00.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:32 -0800 (PST)
Message-Id: <c42261483cff903c8742fd8e1423ac0b14c65099.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:17 +0000
Subject: [PATCH 12/16] object-store.h: move struct object_info from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Move struct object_info, and a few related #define's from cache.h to
object-store.h.

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
index bbde91810ac..29a5bc07bbe 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -4,6 +4,7 @@
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

