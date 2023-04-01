Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FB0C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDAPLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAPKw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BA61D2C6
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso689131wms.5
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OysujxAvO1LO+znxhq2cK1zhDT/kwGpupsQNqmo1Vj0=;
        b=SFdMx0etIQw0ZgkjdFY3qJBc4wjvkxdi43vNq24zNdhYoAB6QLWa2+YztnNXLpi55h
         L181HIGVRR6GxGAj/eXL8XsKOyaL8+hZOhp2/W91hxzabHsEyv/YPkvwEt/U8FW90X3b
         vzYxG2KMuApmEOdIeiDRCY46rEgpTJ6X2ITq0BgnLkU5CzegEUaNmnmJBRUda0nE9swr
         4G0WHAGiPd+WpMANWQS7opRRqqfTq+7sWyx8hnmL7isqo76D5OGDkvNJqOn1cmjoKEJC
         stU3n27uJn6Jmkotn1tqaV7autB1AgejcAJb3ah+SEqurqeuD9U+dI3XEO1aqNmJgsQZ
         CUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OysujxAvO1LO+znxhq2cK1zhDT/kwGpupsQNqmo1Vj0=;
        b=mYIUBeClpX5sNXWZanQLh657TzQ1/bAsk7kFr6qSNIxrXayxURDesjTJrpscKgBFFl
         wQUAIAVVN8Uqn6w2J5hnKWnTxZSSBf9xB8qM1ZDS0pwVkJR8vUBFNhPdtAhHCT/o86/O
         prr1PC4QCE9hAF+PRwUhpZ8+iDPPEQCelLoUBn/Z7JfZ5cMWiWrO3b3th2wf9Mavqz1x
         Nk+qbPXxYh86m97n6O43vGB2CCTf7vp6c6mFzvzK8iz7uVv2N9LE+bRTUFWPIK1Qk2GO
         MVq5e09GeOZSJEqVa1LlPW5z/qKlDd5q7yuvXBSJGwH/j5+PM2bL0cKIZrcvwZ37ha41
         YoAA==
X-Gm-Message-State: AO0yUKXSniYbF/1Es00kV6OX8naa60JLb9Xznyc2CQ2oJJlREKmIYxSz
        t9CptOHogJ1c3nHigmT+y8SxwnoiENg=
X-Google-Smtp-Source: AK7set8RwIjVJRK4hHdbuwMjAJHCUXwHCWEvLPRl7yjrZfxmwM5N4NrmjH8Hne4pObFc3159peR3fg==
X-Received: by 2002:a05:600c:2254:b0:3df:e41f:8396 with SMTP id a20-20020a05600c225400b003dfe41f8396mr22395066wmm.37.1680361848131;
        Sat, 01 Apr 2023 08:10:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c161500b003ef4cd057f5sm12783666wmn.4.2023.04.01.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:47 -0700 (PDT)
Message-Id: <2f240f0755194d1502bc214a4cc5c93a839c5542.1680361839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:23 +0000
Subject: [PATCH 10/24] git-zlib: move declarations for git-zlib functions from
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

Move functions from cache.h for zlib.c into a new header file.  Since
adding a "zlib.h" would cause issues with the real zlib, rename zlib.c
to git-zlib.c while we are at it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile                 |  2 +-
 archive-tar.c            |  1 +
 archive-zip.c            |  1 +
 builtin/unpack-objects.c |  1 +
 cache.h                  | 25 +------------------------
 zlib.c => git-zlib.c     |  3 ++-
 git-zlib.h               | 28 ++++++++++++++++++++++++++++
 http-backend.c           |  1 +
 http.h                   |  3 +++
 9 files changed, 39 insertions(+), 26 deletions(-)
 rename zlib.c => git-zlib.c (99%)
 create mode 100644 git-zlib.h

diff --git a/Makefile b/Makefile
index 50ee51fde32..0c367881bff 100644
--- a/Makefile
+++ b/Makefile
@@ -1036,6 +1036,7 @@ LIB_OBJS += fsmonitor.o
 LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += fsmonitor-settings.o
 LIB_OBJS += gettext.o
+LIB_OBJS += git-zlib.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
@@ -1196,7 +1197,6 @@ LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
-LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
diff --git a/archive-tar.c b/archive-tar.c
index 497dad0b3af..4cd81d8161e 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -5,6 +5,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "tar.h"
 #include "archive.h"
diff --git a/archive-zip.c b/archive-zip.c
index e6f5c10a14f..ef538a90df4 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "archive.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "streaming.h"
 #include "utf8.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f2c1323e661..ddbdb3dd226 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "object-store.h"
 #include "object.h"
diff --git a/cache.h b/cache.h
index dfae7d02c55..769b2ec545a 100644
--- a/cache.h
+++ b/cache.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
+#include "git-zlib.h"
 #include "hashmap.h"
 #include "list.h"
 #include "gettext.h"
@@ -14,30 +15,6 @@
 #include "repository.h"
 #include "statinfo.h"
 
-typedef struct git_zstream {
-	z_stream z;
-	unsigned long avail_in;
-	unsigned long avail_out;
-	unsigned long total_in;
-	unsigned long total_out;
-	unsigned char *next_in;
-	unsigned char *next_out;
-} git_zstream;
-
-void git_inflate_init(git_zstream *);
-void git_inflate_init_gzip_only(git_zstream *);
-void git_inflate_end(git_zstream *);
-int git_inflate(git_zstream *, int flush);
-
-void git_deflate_init(git_zstream *, int level);
-void git_deflate_init_gzip(git_zstream *, int level);
-void git_deflate_init_raw(git_zstream *, int level);
-void git_deflate_end(git_zstream *);
-int git_deflate_abort(git_zstream *);
-int git_deflate_end_gently(git_zstream *);
-int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
-
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
diff --git a/zlib.c b/git-zlib.c
similarity index 99%
rename from zlib.c
rename to git-zlib.c
index d594cba3fc9..d43bbeb6daa 100644
--- a/zlib.c
+++ b/git-zlib.c
@@ -2,7 +2,8 @@
  * zlib wrappers to make sure we don't silently miss errors
  * at init time.
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "git-zlib.h"
 
 static const char *zerr_to_string(int status)
 {
diff --git a/git-zlib.h b/git-zlib.h
new file mode 100644
index 00000000000..d8a670aff9f
--- /dev/null
+++ b/git-zlib.h
@@ -0,0 +1,28 @@
+#ifndef GIT_ZLIB_H
+#define GIT_ZLIB_H
+
+typedef struct git_zstream {
+	z_stream z;
+	unsigned long avail_in;
+	unsigned long avail_out;
+	unsigned long total_in;
+	unsigned long total_out;
+	unsigned char *next_in;
+	unsigned char *next_out;
+} git_zstream;
+
+void git_inflate_init(git_zstream *);
+void git_inflate_init_gzip_only(git_zstream *);
+void git_inflate_end(git_zstream *);
+int git_inflate(git_zstream *, int flush);
+
+void git_deflate_init(git_zstream *, int level);
+void git_deflate_init_gzip(git_zstream *, int level);
+void git_deflate_init_raw(git_zstream *, int level);
+void git_deflate_end(git_zstream *);
+int git_deflate_abort(git_zstream *);
+int git_deflate_end_gently(git_zstream *);
+int git_deflate(git_zstream *, int flush);
+unsigned long git_deflate_bound(git_zstream *, unsigned long);
+
+#endif /* GIT_ZLIB_H */
diff --git a/http-backend.c b/http-backend.c
index 89aad1b42c7..d41b3b9e1e7 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/http.h b/http.h
index 77c042706c6..783b2b09b8b 100644
--- a/http.h
+++ b/http.h
@@ -1,7 +1,10 @@
 #ifndef HTTP_H
 #define HTTP_H
 
+struct packed_git;
+
 #include "cache.h"
+#include "git-zlib.h"
 
 #include <curl/curl.h>
 #include <curl/easy.h>
-- 
gitgitgadget

