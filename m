Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35173C77B78
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDVURx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDVURl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC371BE7
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f192c23fffso11421125e9.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194658; x=1684786658;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz+LsNK18ggreqmDEFWGm3x58LxSkDlwUlBEkEdHU8c=;
        b=EQIKp5Kkscj9UUhyOXE+gDcYwOZmiCVJIqo3Qo59TDpYSbfUzn5SidCA1nfmSwov9j
         6cdziOfEk+NQNpCmFcaJM4SqgktfVVY+AKAdLFlJjN7YK94vdnnk5e8n8+lj0oyvxpZW
         t1fub27Y2K3KynDbFz+ay/QFZmN8JcCen/ZJD5WnRYUJUiZMrQMrEkZhM2oV9kIxC2hs
         1thTNavof6TRFbcAmawEuzX2v2H68ZUT7CVLf/OuE687VADn2bFH20/fNcS5uFixhXKr
         leSArJ3Suz/jO+ZL2BzvuvTAuaq4vKYOkRehKamvvS6jotybuUrfHa2To5CO4joLbMTO
         Yblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194658; x=1684786658;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz+LsNK18ggreqmDEFWGm3x58LxSkDlwUlBEkEdHU8c=;
        b=EZFAYHzYYlN5+xrnqKh/H3G6hqTm8ATYTfpVkIajju2JhSOQfd1QGDtGjDQmyuHXkj
         s+1+rqczAY0i7eoHwbeKPg10I/2rYfNJ1ITdYT/gq3Zo0TMzD7aH4irNWPp7wCuFbGRZ
         1IfpRdYp3FedFmdbqJAZBzlxypZI51opcrdf7JBvVlR+Jb5RjS/6k+qYOHx/7xrqHZ6e
         TY6dBDBq8kKCLgMgQL4isQFSHek/G2nQ+YM6NwO3wvMVxQKKMIF6//UkO1GsckeazAE3
         /2mnqqBmffbbO2gHp9Oi6k/BcbKafjz0DLSpPbMpBUi7A+xoaQ/EVZlq0JnsCHLo4aVf
         Tgkw==
X-Gm-Message-State: AAQBX9cvZ43xISzVEv3V9maXZYuvjR8y48j7ZpvCcm7JT7ZJ7zsHFunq
        H6R5OakihgmZyx8ECx2JpFBKQJpkyYs=
X-Google-Smtp-Source: AKy350ZMgoncrDophgHhRtUVZnzOLM3tQVNg4LNSg+AbZWc5czsfXfnhAVdVUUjz8WKLzjFT2CBTAA==
X-Received: by 2002:a5d:6591:0:b0:2fb:1a68:1d96 with SMTP id q17-20020a5d6591000000b002fb1a681d96mr6157031wru.15.1682194657759;
        Sat, 22 Apr 2023 13:17:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002f9ff443184sm7204805wrj.24.2023.04.22.13.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:37 -0700 (PDT)
Message-Id: <b2ce7a1786892267dc46669ef8aa5e2ec838170b.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:11 +0000
Subject: [PATCH v2 04/22] server-info.h: move declarations for server-info.c
 functions from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
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

