Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F2DC77B73
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDPDDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjDPDDf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0928270D
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f167d0c91bso6718675e9.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614212; x=1684206212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/xjejO9UpnBrcbYciWJDTtA7ZALLuxMP2eVG6ZMH0Q=;
        b=EguDCdWfgiFZmPm+PvHBV+bSjmlXD8F+1/l82GxmjRvMVRFTKwSxGIZnosfUM8zvqg
         GKwoA9OLSPXatqkCgCIPdvEfTvtTzJrN9eRhCmD0f1ng4IEhKIKEC5LQSEMQh8RThc5K
         4D/Bb6o+d/5obphyH7c3FktbDdOZQOc5Re1RKVhb7gMOvBy3qOt1cLJiMsgP1MWyn9Ls
         IHJ4VvbW4dlsq10mr9KD0jSlDRVPZY8TyoTXySrV5VBrURdFrT35TySWZ2gjQNs73Nw9
         gADUvk/1ALmLFVUK30AhYn/+T3l8ZvPK5h4l9VN+vsYBIXW1cypuinjcYae8sgMIFjhD
         6HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614212; x=1684206212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/xjejO9UpnBrcbYciWJDTtA7ZALLuxMP2eVG6ZMH0Q=;
        b=QvbTjIlAGjEsgqMleqSmnWe85ElSU110rgIdrmgHa/3iKpYHs4t7rNpefE3R9N/LD1
         MM86VBR5uwbmkI3o1vQQWzcsX3uH5kU/RWbAiIqbeokLz4F7r+W3hcZPkqtOmMDXQPgo
         npM0M3AZt5KFViIxIepmunF0rkCV5Q1o642iRv61zZ+q4xi4pNBnj8IaGUurhlSP/T6T
         S6wU2i7q7ZX2FZDI3XsYDlnclWJPxtx5aSxKVQzJcNo8ZWBrQ15e/H54j1Wgom+R9VSd
         4paFMXrAm53SBaLzcRAMfYb+KrXCLG9tQu/ff5YHIlGf813asWITksP9fKHpFRNZlo8f
         jpQw==
X-Gm-Message-State: AAQBX9de5og9HWSFyaMXsIMN5n3FvW+/oT7UjnovMrSTX6DPT5qmzzHH
        3uEbiW/HBGc2YQyGdY1MUeA/CETK00k=
X-Google-Smtp-Source: AKy350Yly+x3Ct+4xwqPv65XWr6sjcEozEI+ayHY0lferEZgunl9Zfgo3DbwoqCazz6edSmhiyylpA==
X-Received: by 2002:a5d:6dce:0:b0:2ef:b052:1296 with SMTP id d14-20020a5d6dce000000b002efb0521296mr2427666wrz.22.1681614212168;
        Sat, 15 Apr 2023 20:03:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m25-20020a056000181900b002f90a75b843sm1638203wrh.117.2023.04.15.20.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:31 -0700 (PDT)
Message-Id: <dbd08e60b58abac393c0be3f87b6838a05941f8b.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:08 +0000
Subject: [PATCH 06/23] copy.h: move declarations for copy.c functions from
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/bisect.c     |  1 +
 builtin/clone.c      |  1 +
 builtin/difftool.c   |  1 +
 builtin/init-db.c    |  1 +
 builtin/worktree.c   |  1 +
 bundle-uri.c         |  1 +
 cache.h              |  6 ------
 convert.c            |  1 +
 copy.c               |  1 +
 copy.h               | 10 ++++++++++
 pkt-line.c           |  1 +
 refs/files-backend.c |  1 +
 rerere.c             |  1 +
 sequencer.c          |  1 +
 14 files changed, 22 insertions(+), 6 deletions(-)
 create mode 100644 copy.h

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 4b2143d4557..4812450c393 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "copy.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 4ed0a1d5aad..017ebc3faa8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -13,6 +13,7 @@
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
+#include "copy.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 3ffb0524be7..409507983f2 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -15,6 +15,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "config.h"
+#include "copy.h"
 #include "builtin.h"
 #include "run-command.h"
 #include "environment.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6183f3fb3ff..cda6ee75eb5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "config.h"
+#include "copy.h"
 #include "environment.h"
 #include "gettext.h"
 #include "refs.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0621f6f708e..0b411e9deee 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "checkout.h"
 #include "config.h"
+#include "copy.h"
 #include "builtin.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/bundle-uri.c b/bundle-uri.c
index 1ff1cf51dad..6d44662ee1f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "bundle-uri.h"
 #include "bundle.h"
+#include "copy.h"
 #include "environment.h"
 #include "gettext.h"
 #include "object-store.h"
diff --git a/cache.h b/cache.h
index 2eb4546473f..2b661764794 100644
--- a/cache.h
+++ b/cache.h
@@ -593,12 +593,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-#define COPY_READ_ERROR (-2)
-#define COPY_WRITE_ERROR (-3)
-int copy_fd(int ifd, int ofd);
-int copy_file(const char *dst, const char *src, int mode);
-int copy_file_with_time(const char *dst, const char *src, int mode);
-
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
diff --git a/convert.c b/convert.c
index 5a2ea5308d6..7cf7bd0c883 100644
--- a/convert.c
+++ b/convert.c
@@ -2,6 +2,7 @@
 #include "advice.h"
 #include "config.h"
 #include "convert.h"
+#include "copy.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/copy.c b/copy.c
index c3250f08221..db6b615c188 100644
--- a/copy.c
+++ b/copy.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "copy.h"
 #include "wrapper.h"
 
 int copy_fd(int ifd, int ofd)
diff --git a/copy.h b/copy.h
new file mode 100644
index 00000000000..2af77cba864
--- /dev/null
+++ b/copy.h
@@ -0,0 +1,10 @@
+#ifndef COPY_H
+#define COPY_H
+
+#define COPY_READ_ERROR (-2)
+#define COPY_WRITE_ERROR (-3)
+int copy_fd(int ifd, int ofd);
+int copy_file(const char *dst, const char *src, int mode);
+int copy_file_with_time(const char *dst, const char *src, int mode);
+
+#endif /* COPY_H */
diff --git a/pkt-line.c b/pkt-line.c
index 3561d853584..8b5fa788517 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "copy.h"
 #include "pkt-line.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d0581ee41ac..1128a9af292 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,5 +1,6 @@
 #include "../cache.h"
 #include "../config.h"
+#include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
 #include "../hex.h"
diff --git a/rerere.c b/rerere.c
index 7abc94bf444..e968d413d65 100644
--- a/rerere.c
+++ b/rerere.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "copy.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/sequencer.c b/sequencer.c
index fcca3b81447..c16df514434 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3,6 +3,7 @@
 #include "advice.h"
 #include "alloc.h"
 #include "config.h"
+#include "copy.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-- 
gitgitgadget

