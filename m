Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD545C7EE24
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjEPGfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjEPGey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2188A49C0
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4249b7badso96478815e9.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218877; x=1686810877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYQGq11DEV5igawAK2q4qB05drCi+R06eg1GHcU1PAM=;
        b=NssC+PCv7Y66g8T+GAEViKwanPaMoy6S4y3QCm9DQgeeDY0tyW+8Rkbg/LyX1WvX0j
         ZwqlqgN9jYnIhFKVx6lXya7Cw1YyLGXuFTZ2Wz+7rSs8toEZTQwZX9CJBbNOaWW0VuTi
         yXMxmPxcs8LNTtN7GrW35WdAUFlLr5glrdVMnuZpzFKL+qOYtZl15fo8o4b6gtwQADAK
         ZOMy1o/7w5I6q2WbrPNBde/oZFOKSlxX52myF6AHIslL7wJsM+DSZIdGVRS832yE2ZOl
         a/d4PbKycmfZQvUiLSM9UbBJdWnC+iDeNM8KaOuIeX6EC/u9ZWNedBSXA0w7hceIeK3/
         mdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218877; x=1686810877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYQGq11DEV5igawAK2q4qB05drCi+R06eg1GHcU1PAM=;
        b=GmLUB+YtYec11R7RdzL8IiXruJgyR97b70CsM8GImGTtPoKLn12d4NkIl2C76TWQVu
         SWmx+A0lnLm24i8iRZA7mWInXNS9TDXdoSDixy/wyVYoo1k/V2PGV2z/UfrIsscV1Nta
         a9g7aR4DWIeKWFUHDUXa8K/17EsCO7xCxRrPjz4l1RYbPbHH/lcK4CFU3C16Zxhtfq+U
         PRwabmIrlYkd4lARyHDZYu0+6+o0MBoJGmj6ZbOZiO1ISOAdUPt4i5+SEojdevbXxoxK
         sPAZx2F0GIB2QAuqPZStutfCU2KDqEakfdWGk/n9YSPdsthVDF/BH5dH7BjXnyUQwow7
         kPBw==
X-Gm-Message-State: AC+VfDwGX4OJOoSXGwduxL5cnDJs21Q5Is4/0P78P102HZpIXSYArErr
        6OtLjO4zWDtsNWOicbE8zZLEFamgK3E=
X-Google-Smtp-Source: ACHHUZ5odFZXBpjRUW/4xLsdn3dHAlAXY6ZrtGdX+SgoROeaszykzlos8EuUyH10sl86TPFYhrkfxg==
X-Received: by 2002:a7b:cbd7:0:b0:3f4:c28b:ec88 with SMTP id n23-20020a7bcbd7000000b003f4c28bec88mr11905748wmi.41.1684218877118;
        Mon, 15 May 2023 23:34:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d4d0d000000b0030785b864f1sm1391486wrt.65.2023.05.15.23.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:36 -0700 (PDT)
Message-Id: <d6057718fde2c48824f77b56cafadf1cab929144.1684218853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:34:07 +0000
Subject: [PATCH v3 27/28] hash-ll, hashmap: move oidhash() to hash-ll
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

oidhash() was used by both hashmap and khash, which makes sense.
However, the location of this function in hashmap.[ch] meant that
khash.h had to depend upon hashmap.h, making people unfamiliar with
khash think that it was built upon hashmap.  (Or at least, I personally
was confused for a while about this in the past.)

Move this function to hash-ll, so that khash.h can stop depending upon
hashmap.h.

This has another benefit as well: it allows us to remove hashmap.h's
dependency on hash-ll.h.  While some callers of hashmap.h were making
use of oidhash, most were not, so this change provides another way to
reduce the number of includes.

Diff best viewed with `--color-moved`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 decorate.c |  1 -
 dir.h      |  1 +
 hash-ll.h  | 19 +++++++++++++++++++
 hashmap.h  | 21 ---------------------
 khash.h    |  1 -
 remote.h   |  1 +
 serve.c    |  1 +
 7 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/decorate.c b/decorate.c
index 71e79daa825..a5c43c0c146 100644
--- a/decorate.c
+++ b/decorate.c
@@ -3,7 +3,6 @@
  * data.
  */
 #include "git-compat-util.h"
-#include "hashmap.h"
 #include "object.h"
 #include "decorate.h"
 
diff --git a/dir.h b/dir.h
index 79b85a01ee4..279a0660801 100644
--- a/dir.h
+++ b/dir.h
@@ -1,6 +1,7 @@
 #ifndef DIR_H
 #define DIR_H
 
+#include "hash-ll.h"
 #include "hashmap.h"
 #include "pathspec.h"
 #include "statinfo.h"
diff --git a/hash-ll.h b/hash-ll.h
index 80509251370..8d7973769fd 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -270,6 +270,25 @@ static inline void oid_set_algo(struct object_id *oid, const struct git_hash_alg
 	oid->algo = hash_algo_by_ptr(algop);
 }
 
+/*
+ * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
+ * for use in hash tables. Cryptographic hashes are supposed to have
+ * uniform distribution, so in contrast to `memhash()`, this just copies
+ * the first `sizeof(int)` bytes without shuffling any bits. Note that
+ * the results will be different on big-endian and little-endian
+ * platforms, so they should not be stored or transferred over the net.
+ */
+static inline unsigned int oidhash(const struct object_id *oid)
+{
+	/*
+	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
+	 * platforms that don't support unaligned reads.
+	 */
+	unsigned int hash;
+	memcpy(&hash, oid->hash, sizeof(hash));
+	return hash;
+}
+
 const char *empty_tree_oid_hex(void);
 const char *empty_blob_oid_hex(void);
 
diff --git a/hashmap.h b/hashmap.h
index 2695f3d3a6e..c8216e47bb2 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -1,8 +1,6 @@
 #ifndef HASHMAP_H
 #define HASHMAP_H
 
-#include "hash-ll.h"
-
 /*
  * Generic implementation of hash-based key-value mappings.
  *
@@ -120,25 +118,6 @@ unsigned int memhash(const void *buf, size_t len);
 unsigned int memihash(const void *buf, size_t len);
 unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
 
-/*
- * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
- * for use in hash tables. Cryptographic hashes are supposed to have
- * uniform distribution, so in contrast to `memhash()`, this just copies
- * the first `sizeof(int)` bytes without shuffling any bits. Note that
- * the results will be different on big-endian and little-endian
- * platforms, so they should not be stored or transferred over the net.
- */
-static inline unsigned int oidhash(const struct object_id *oid)
-{
-	/*
-	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
-	 * platforms that don't support unaligned reads.
-	 */
-	unsigned int hash;
-	memcpy(&hash, oid->hash, sizeof(hash));
-	return hash;
-}
-
 /*
  * struct hashmap_entry is an opaque structure representing an entry in the
  * hash table.
diff --git a/khash.h b/khash.h
index a0a08dad8b7..ff881631778 100644
--- a/khash.h
+++ b/khash.h
@@ -26,7 +26,6 @@
 #ifndef __AC_KHASH_H
 #define __AC_KHASH_H
 
-#include "hashmap.h"
 #include "hash.h"
 
 #define AC_VERSION_KHASH_H "0.2.8"
diff --git a/remote.h b/remote.h
index 73638cefeb1..929c7c676d3 100644
--- a/remote.h
+++ b/remote.h
@@ -1,6 +1,7 @@
 #ifndef REMOTE_H
 #define REMOTE_H
 
+#include "hash-ll.h"
 #include "hashmap.h"
 #include "refspec.h"
 
diff --git a/serve.c b/serve.c
index 5329c91011f..a1d71134d49 100644
--- a/serve.c
+++ b/serve.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "repository.h"
 #include "config.h"
+#include "hash-ll.h"
 #include "pkt-line.h"
 #include "version.h"
 #include "ls-refs.h"
-- 
gitgitgadget

