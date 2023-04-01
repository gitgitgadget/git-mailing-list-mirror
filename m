Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7D6C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjDAPLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjDAPKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932D91EA2A
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:52 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso17162274wmb.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361850;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhuBK+3FsrA7wWsxcUTj1ZWSQavRr8GogtMub0kQ4m4=;
        b=bgnlrFM9sji0FTl9Tmp3oM9+n5ImrgN98WoMkDsbKkbnYnbncJpeLPgloEHdZRG6p7
         EGG466LlKzUcnElDx7bLLw1bgS7TZk501ZKVKUY6WkBiZjjEogeMRYeasoHKstS/XKM2
         bWfWlSmh/PBIkfN/jpjQcQ/gb9+TY9VUgZ0QbE0YzeEJlqAiLL1VNbkBMLsPLi/wdT37
         8D5oPAgS3m5C98USLJ0Dbo2SGjAUMuoOlDFpkTnRwuEuw4Kv9fYpYMB5o1cySAXSocUf
         3Im7HOAUMvR8WozbXlanH31Yqw4g1p3P3ujjXJ+05DGBTXjwsviKt/7SRPGSsJ93HJIO
         pjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361850;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhuBK+3FsrA7wWsxcUTj1ZWSQavRr8GogtMub0kQ4m4=;
        b=dMTrplf36t8eIJC/LrfXI8CwKoQKJ0NYEnYRVU2PLtghBtK5aamPxaD/9lCItJ0bk+
         uAANS0dmYJtmYFebp1/fIAKwRhCc016yzRhzN1nAixuieZ7x8W4MrVpszmJPFQ51jy5B
         01JQ3XPfoTBJMydzdjRgoBQGxNCI3Z1dfvW8G5nMmf9LOzpO38hTjGm2u22hETIeUi6T
         szCBw6R+6SGE3J/qETaB9nmCnFZ8PyEjbO0den9XKO1hvVE1DM5/lLq/pAENGNDg02ce
         gndQm0IK2AiKQgNJ+ZqSAtWnKcXZUyanCU6WzoU+hPdclUpK8tMPoXFvC8c6OAJqVUba
         LOtg==
X-Gm-Message-State: AAQBX9eFh+DuXCn5I60TheekDPWkEBbv0kUIveztH0JYN9GZwSyZxMjr
        kigYagUoFybVmWeTMeQyi1azLss6oww=
X-Google-Smtp-Source: AKy350ZZ/+5OTvZQRR/IXrNVrIrl/hlC8zbUxatWIfkFyyG5POBB29ZRgGy5ET5OR6twDQd3gjYcdg==
X-Received: by 2002:a05:600c:2104:b0:3ef:732e:2d5a with SMTP id u4-20020a05600c210400b003ef732e2d5amr13785254wml.34.1680361850803;
        Sat, 01 Apr 2023 08:10:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003e203681b26sm6312311wme.29.2023.04.01.08.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:50 -0700 (PDT)
Message-Id: <fa58cf82c66c7bb8e6e441b7e5fa5b5ac45f301b.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:27 +0000
Subject: [PATCH 14/24] object.h: move an inline function and some defines from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The object_type() inline function is very tied to the enum object_type
declaration within object.h, and just seemed to make more sense to live
there.  Move it, and as a side-effect, remove a bunch of dependencies
on cache.h that are no longer needed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 bundle.c            |  2 +-
 cache.h             | 21 ---------------------
 delta-islands.c     |  2 +-
 fsck.c              |  2 +-
 http-push.c         |  2 +-
 list-objects.c      |  2 +-
 object.h            | 21 +++++++++++++++++++++
 pack-bitmap-write.c |  2 +-
 submodule-config.c  |  2 +-
 walker.c            |  2 +-
 10 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/bundle.c b/bundle.c
index 6471489975a..a5505368de5 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "lockfile.h"
 #include "bundle.h"
 #include "environment.h"
diff --git a/cache.h b/cache.h
index f02c7c9609d..f5eaea341c2 100644
--- a/cache.h
+++ b/cache.h
@@ -29,18 +29,6 @@
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
@@ -156,8 +144,6 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
 
-#define S_ISSPARSEDIR(m) ((m) == S_IFDIR)
-
 /* Forward structure decls */
 struct pathspec;
 struct child_process;
@@ -415,13 +401,6 @@ void prefetch_cache_entries(const struct index_state *istate,
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
 
diff --git a/delta-islands.c b/delta-islands.c
index 40f2ccfb550..c824a5f6a42 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "attr.h"
 #include "object.h"
diff --git a/fsck.c b/fsck.c
index 8ef1b022346..adbe8bf59e7 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/http-push.c b/http-push.c
index a8af6c0f690..637a4e91f7a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/list-objects.c b/list-objects.c
index df18d103063..eecca721ac0 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "tag.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/object.h b/object.h
index fc45b158da0..568cddfc2b4 100644
--- a/object.h
+++ b/object.h
@@ -101,6 +101,27 @@ enum object_type {
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
 /*
  * The object type is stored in 3 bits.
  */
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 7f5f489beb0..faf67c94d37 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/submodule-config.c b/submodule-config.c
index 252b90aa439..7fc0812b644 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/walker.c b/walker.c
index cfbd257fdba..24ff7dfdc28 100644
--- a/walker.c
+++ b/walker.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "walker.h"
-- 
gitgitgadget

