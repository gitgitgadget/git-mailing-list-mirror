Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCCCC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDPDDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDPDDf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBCA26AA
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso376348f8f.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614211; x=1684206211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz+LsNK18ggreqmDEFWGm3x58LxSkDlwUlBEkEdHU8c=;
        b=mNtvxg2HGHEiqCxUoTI2KD/XQSBGEItadMpE9P1ZdJAG1rqQvTnCTOmr27twSStqrR
         dqCK+DHquvhfZhPgGzLtq4gStAJhA/JmmsgAzY3nILn48Y274rAKgrG+h9N3LyUjlrzR
         GAM6oveTwUYpgx02JLEksFPmuaDru3SAXsKC63qY+XO7o/iRz0lefCAvoL61Zul+EO9b
         kogGvK1AC3em2cFMfrmiO6VCkjeX87mYzBYbx1AY4KM11ytqBTvVv+xj08P/vyzmLfLG
         vW5Lkip9iP1mUxHooUjYqZNBQWm2Gso5ARAghNtKD7lHBHA5ZM0BWyeSUH0FQgvANAiL
         6jtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614211; x=1684206211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz+LsNK18ggreqmDEFWGm3x58LxSkDlwUlBEkEdHU8c=;
        b=Li1EuSG2TUV5nY7yaLCGk1YM1qgRHVhA1uRQtIuLL9SJOJ6tOOxx+HmqUbiLJfMbHx
         kaJqv4tUFVjXNxNNsvTesjiddlJts0N+KaKERPaPa2M54PcAS82EqKa9W3xBRAjMEkhT
         /I6vdqwZXL/1Bg5XLtUpzOTLbBXIL5WbqwZ5l98IXsyD1QASvh1kLspPDknL0c8eC+1f
         BIPakkj+H1MMgpuqyB7F5C2Fk60CDVf1yRVbCT5NZI+bvf3bOnjyad0X20YvBvbn8a+U
         tX1vCMlu8JSDGpelNLJKYlD/O/cp5kxcOJRs2aby/2Mc9aNII/tjajip9IuJTC2yg6+L
         LMaQ==
X-Gm-Message-State: AAQBX9cnAeMtUcwcs7i5VmF6q1H9eqca6Mur1ZWgoRlBa+hpqNXYyTOM
        iybklUQa853712KNQCkflPKQzTV5XvU=
X-Google-Smtp-Source: AKy350bWE02tRQKVsm2dy/ePTztXeeiM3p5xot7I01Vk5haOmXLRYe7skdJcqcE/K6xnKFWT5DXcNQ==
X-Received: by 2002:a5d:6342:0:b0:2ce:aa2d:c625 with SMTP id b2-20020a5d6342000000b002ceaa2dc625mr2193849wrw.22.1681614211492;
        Sat, 15 Apr 2023 20:03:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d4ec9000000b002cde25fba30sm7087702wrv.1.2023.04.15.20.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:31 -0700 (PDT)
Message-Id: <e22c8f242f3fd5fa93920169f15cd78b6cc13703.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:07 +0000
Subject: [PATCH 05/23] server-info.h: move declarations for server-info.c
 functions from cache.h
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/receive-pack.c       | 1 +
 builtin/repack.c             | 1 +
 builtin/update-server-info.c | 1 +
 cache.h                      | 3 ---
 server-info.c                | 3 ++-
 server-info.h                | 7 +++++++
 6 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 server-info.h

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7d921170f1c..dae99e4554d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -33,6 +33,7 @@
 #include "object-store.h"
 #include "protocol.h"
 #include "commit-reach.h"
+#include "server-info.h"
 #include "trace.h"
 #include "trace2.h"
 #include "worktree.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index df4d8e0f0ba..bed2c2aaafb 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -7,6 +7,7 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "server-info.h"
 #include "sigchain.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index e7bff27ae40..19dce3c0655 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -3,6 +3,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "server-info.h"
 
 static const char * const update_server_info_usage[] = {
 	"git update-server-info [-f | --force]",
diff --git a/cache.h b/cache.h
index ffb9028f015..2eb4546473f 100644
--- a/cache.h
+++ b/cache.h
@@ -593,9 +593,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-/* Dumb servers support */
-int update_server_info(int);
-
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
 int copy_fd(int ifd, int ofd);
diff --git a/server-info.c b/server-info.c
index 68098ddd1ad..55aa04f00ab 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "dir.h"
 #include "environment.h"
@@ -11,6 +11,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-store.h"
+#include "server-info.h"
 #include "strbuf.h"
 #include "wrapper.h"
 
diff --git a/server-info.h b/server-info.h
new file mode 100644
index 00000000000..13bbde2c55f
--- /dev/null
+++ b/server-info.h
@@ -0,0 +1,7 @@
+#ifndef SERVER_INFO_H
+#define SERVER_INFO_H
+
+/* Dumb servers support */
+int update_server_info(int);
+
+#endif /* SERVER_INFO_H */
-- 
gitgitgadget

