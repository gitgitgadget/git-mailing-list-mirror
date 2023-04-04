Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F59CC76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjDDBXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjDDBXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6059635B7
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y14so31163997wrq.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571364;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCEW+O1lQOxc4CZu/nf9yk9T49OdAkmSk6xHeiEQnbI=;
        b=c+clw+L4VH2FnL4PlE2HWFeZ+3bGapMfy3rBhB5QgvZf8Yj2GOIjIwn7m4dKrCoJYE
         ppQj/oltt3y9tZCZKvvbszMxg24FRzjRxt4WJ5TTfIWfosXM9LSEOIyGtI+dBd3H6+Wm
         QYi+ZklyCYLGSKUqgVszYmvj2034wVz9jEayWjMyLEzePuh/qbfbNC2SVmjBd+M7K2Eh
         ZN/HLDDBcER9uL8YYRZEvbJ7iP1qX1idrTI5ZoWYWsOXqTC4gv5ku1BzpOfKsQID2iI5
         CdB5hg5nPYW7Cn42e1r8inm/OIoa4uMp0SKaypTdGgBpgRYkC61MiVZWEyfuHxGD4KkQ
         ghiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571364;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCEW+O1lQOxc4CZu/nf9yk9T49OdAkmSk6xHeiEQnbI=;
        b=7FDmU9HIphHlJIIK0KpDonveJwQU2bp/+fMl9lF5vEr2xGSLDksLH8nAwlBs1Fq4Uk
         TEBHsze+vmD86pQR3EzNkvGGJ5Gjj0OIJ+SgLmwd/3VQ1LK822apvF07nDZS/q/lgihY
         IfGMjTrDRm+xKzcf/F62QBPdvZ1tT0eLKJywdgaD4BIdgMRl3yQSdu3rNF2UFyg9xAh8
         GJjhCUEf9Q98L7X1MlZXklwp0p3Xq9R4or5dJcs2RvG9tw9bMJY2XBDDoxV7rjcdhSGw
         taq1eowhXwhxM/t1qwyF7usWj316JqT5HNQOkRb6mUJZ9xulzC07+SX96nHkbCFHahe/
         P8gA==
X-Gm-Message-State: AAQBX9ej+vtS4LwOU+iPugu0DNuiOsTZqTThaMCRf/LnpjSjhT7qpIoY
        ue2SPUvxf/2SYfCC3orjqiydu3jaZVc=
X-Google-Smtp-Source: AKy350Z0q6tr+7475Q1RbT4D6Duy2EBKQ0VBpIIOtc2NlHgbbDaK2uPxPG+Qr7x8sSK9vt1vKEUJTQ==
X-Received: by 2002:a05:6000:1805:b0:2d3:9c5a:8d70 with SMTP id m5-20020a056000180500b002d39c5a8d70mr330678wrh.12.1680571364098;
        Mon, 03 Apr 2023 18:22:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12-20020adfe8cc000000b002c7b229b1basm10930930wrn.15.2023.04.03.18.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:43 -0700 (PDT)
Message-Id: <8937f6d5ac543f602a0e27a854f867f4d4ca8bce.1680571351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:18 +0000
Subject: [PATCH v2 14/24] object.h: move some inline functions and defines
 from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The object_type() inline function is very tied to the enum object_type
declaration within object.h, and just seemed to make more sense to live
there.  That makes S_ISGITLINK and some other defines make sense to go
with it, as well as the create_ce_mode() and canon_mode() inline
functions.  Move all these inline functions and defines from cache.h to
object.h.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h  | 42 ------------------------------------------
 object.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/cache.h b/cache.h
index 89987cca22a..394e8d01254 100644
--- a/cache.h
+++ b/cache.h
@@ -28,18 +28,6 @@
 #define DTYPE(de)	DT_UNKNOWN
 #endif
 
-/* unknown mode (impossible combination S_IFIFO|S_IFCHR) */
-#define S_IFINVALID     0030000
-
-/*
- * A "directory link" is a link to another git directory.
- *
- * The value 0160000 is not normally a valid mode, and
- * also just happens to be S_IFDIR + S_IFLNK
- */
-#define S_IFGITLINK	0160000
-#define S_ISGITLINK(m)	(((m) & S_IFMT) == S_IFGITLINK)
-
 /*
  * Some mode bits are also used internally for computations.
  *
@@ -155,8 +143,6 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
 
-#define S_ISSPARSEDIR(m) ((m) == S_IFDIR)
-
 /* Forward structure decls */
 struct pathspec;
 struct child_process;
@@ -197,17 +183,6 @@ static inline unsigned create_ce_flags(unsigned stage)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
 #define ce_intent_to_add(ce) ((ce)->ce_flags & CE_INTENT_TO_ADD)
 
-#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
-static inline unsigned int create_ce_mode(unsigned int mode)
-{
-	if (S_ISLNK(mode))
-		return S_IFLNK;
-	if (S_ISSPARSEDIR(mode))
-		return S_IFDIR;
-	if (S_ISDIR(mode) || S_ISGITLINK(mode))
-		return S_IFGITLINK;
-	return S_IFREG | ce_permissions(mode);
-}
 static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
 					     unsigned int mode)
 {
@@ -234,16 +209,6 @@ static inline int ce_to_dtype(const struct cache_entry *ce)
 	else
 		return DT_UNKNOWN;
 }
-static inline unsigned int canon_mode(unsigned int mode)
-{
-	if (S_ISREG(mode))
-		return S_IFREG | ce_permissions(mode);
-	if (S_ISLNK(mode))
-		return S_IFLNK;
-	if (S_ISDIR(mode))
-		return S_IFDIR;
-	return S_IFGITLINK;
-}
 
 static inline int ce_path_match(struct index_state *istate,
 				const struct cache_entry *ce,
@@ -414,13 +379,6 @@ void prefetch_cache_entries(const struct index_state *istate,
 extern struct index_state the_index;
 #endif
 
-static inline enum object_type object_type(unsigned int mode)
-{
-	return S_ISDIR(mode) ? OBJ_TREE :
-		S_ISGITLINK(mode) ? OBJ_COMMIT :
-		OBJ_BLOB;
-}
-
 #define INIT_DB_QUIET 0x0001
 #define INIT_DB_EXIST_OK 0x0002
 
diff --git a/object.h b/object.h
index fc45b158da0..96e52e24fb1 100644
--- a/object.h
+++ b/object.h
@@ -101,6 +101,50 @@ enum object_type {
 	OBJ_MAX
 };
 
+/* unknown mode (impossible combination S_IFIFO|S_IFCHR) */
+#define S_IFINVALID     0030000
+
+/*
+ * A "directory link" is a link to another git directory.
+ *
+ * The value 0160000 is not normally a valid mode, and
+ * also just happens to be S_IFDIR + S_IFLNK
+ */
+#define S_IFGITLINK	0160000
+#define S_ISGITLINK(m)	(((m) & S_IFMT) == S_IFGITLINK)
+
+#define S_ISSPARSEDIR(m) ((m) == S_IFDIR)
+
+static inline enum object_type object_type(unsigned int mode)
+{
+	return S_ISDIR(mode) ? OBJ_TREE :
+		S_ISGITLINK(mode) ? OBJ_COMMIT :
+		OBJ_BLOB;
+}
+
+#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
+static inline unsigned int create_ce_mode(unsigned int mode)
+{
+	if (S_ISLNK(mode))
+		return S_IFLNK;
+	if (S_ISSPARSEDIR(mode))
+		return S_IFDIR;
+	if (S_ISDIR(mode) || S_ISGITLINK(mode))
+		return S_IFGITLINK;
+	return S_IFREG | ce_permissions(mode);
+}
+
+static inline unsigned int canon_mode(unsigned int mode)
+{
+	if (S_ISREG(mode))
+		return S_IFREG | ce_permissions(mode);
+	if (S_ISLNK(mode))
+		return S_IFLNK;
+	if (S_ISDIR(mode))
+		return S_IFDIR;
+	return S_IFGITLINK;
+}
+
 /*
  * The object type is stored in 3 bits.
  */
-- 
gitgitgadget

