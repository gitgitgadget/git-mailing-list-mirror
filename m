Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E9CC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDVURz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjDVURl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8BD1FDF
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso6308195e9.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194658; x=1684786658;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/xjejO9UpnBrcbYciWJDTtA7ZALLuxMP2eVG6ZMH0Q=;
        b=PoaODrtvJfqvjGb0ro6VAhMs2auvs5XI+2fPm+bYI8aUK6X3LSiQ9HX6YCm2dy7xsr
         QARdcWwgXITIHS9EZqC9C3Xdc7XhaBrg/TV6Xh+36a1VvZnPGJEtSI99Ax5niQTuGomY
         rRuBVpAnNxo5agpEUqwTG27iQldjdx8KThJM2bdzfxUeSe4JKRb4MdYQwhhsehLgInDF
         Zk9ZjTWDVYjYfyCvhqf1uCYPYqFcjuk9PDo28dUmbB7Vli8lu/wxrLmH2LIFU6Z42Gx9
         DwHYEgjDc1vrUe+HEqcWyXN+jDSpg/vZrs0uS5xDkrv4etXBZiHOrmzz4M17F+pOVZnq
         sxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194658; x=1684786658;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/xjejO9UpnBrcbYciWJDTtA7ZALLuxMP2eVG6ZMH0Q=;
        b=YT6C6CceaUQV/O2Z59j+rJJDd/qx4dkSSFlyOAe1lf1VeG6zcWPX6feYi97uSDXFKs
         VICr+YMzDu5tvq7HtnYhlE95Hy3qcjANXYn5fn/96N/EO/EsXGomuImf8xA/ut/2ZdSm
         p2QLT72T7lh0/fvvfXOxE3oMw4PVD0lKtLVpWwSYnlQbvW6fQ75EKjhc3SzQWAgSpdnQ
         wIXxbY29vzKK2v7t2KJJ+TMleUcpyYmAJ3WYnw/AJ43PYrS+vn9x5nfR7NCtpbO32CIZ
         D8k+vgZ9/iG8MCtykMRCuCIL6D93u06v/oq9/c88d8iid38Tmezo6x5lGY5zlSpCYOMj
         whFg==
X-Gm-Message-State: AAQBX9eCCEJ478xA1fLiuJI47N06absFfG78EMexZmPMtHHD1Fug1RSJ
        rkHjfHSnAOwM5cPJa1ZZD7+JugBsQCE=
X-Google-Smtp-Source: AKy350ZeOOJhxx7ZGs5VCKhTbqH8A/YYOrVhMJKNed4j7oE8cFKkpU56L0IzbFCmXiKNx+yRwnsEbg==
X-Received: by 2002:a1c:f309:0:b0:3f1:80d2:2dff with SMTP id q9-20020a1cf309000000b003f180d22dffmr4542621wmq.26.1682194658457;
        Sat, 22 Apr 2023 13:17:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16-20020a05600c0ad000b003f198dfbbfcsm2377385wmr.19.2023.04.22.13.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:38 -0700 (PDT)
Message-Id: <513ffafa597f18363bdcd308cf8159c21e66ecb0.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:12 +0000
Subject: [PATCH v2 05/22] copy.h: move declarations for copy.c functions from
 cache.h
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

