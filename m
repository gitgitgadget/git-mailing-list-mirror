Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1520C77B70
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjDPDEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDPDDi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD25026A6
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bd13-20020a05600c1f0d00b003f14c42cc99so2431587wmb.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614215; x=1684206215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIkGlAhmULKGxj9CHConEVpIpm56FQxo272CDrQqxBE=;
        b=Fo+QAlvg8+Q/Bg047HglvLS1LYXDb4iEA3M7pdV57xz//vuqhEZQ0SbNWrlAMePfxy
         +UeHROuDW+P52u2jC0isy7kCx5Cn2gLyMDpXOk9bf4VBn2kgpVnE6lkKwslqfENngZ4R
         gLjHVMYK1zJVvHngPGWEQYezAlB2d0YdQhwXXqMEODaffRArbacXKR402OgHFowXb+gG
         o3LHhAPrkZc5pcNaGVLPj2RHfRRAEbjNyS9CWgBTUXVkypKia/znJrkyYHvkrUeONk4+
         /FC5gWfudnx45nt8ftoZ8rzWOuZFHJrbUaDNQrGt3Rr/ZNbd0gxKmqakeaR6RqtqK9U9
         Srew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614215; x=1684206215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIkGlAhmULKGxj9CHConEVpIpm56FQxo272CDrQqxBE=;
        b=h8yEgWlQ7VBvGg7CLkY1E/m1Y4u/yeFlzCyL/LgphcAyGWPr/KUsK2CpF4E1xuuCpb
         gfVpf/JJzr2G7PzNuBMr4hvVzQrJeYHW14MO1JdQYVRlXcbm+jQTmu6GJJzg7pw8oad6
         JqBl8we5yGgPXZ1NeJaPPb5lGO6dtpJf7n+7mwc73W7l5LxQqJt64bjyhZ8dVUlrGPYy
         RhR9CCBLZA0BUoA2lhMnt0i7dgNHsRk+cC+eUpfYUj2EQ+vHfOHydtHMMAuJVguKpfbS
         3RdLAvxIOE3NvTE9xbpWMoV3IbJQiMDBgmbZwfQjRwswRxoUmTfw+ztA5M+m3Ns6TOa7
         22rQ==
X-Gm-Message-State: AAQBX9fMTu//JMd4LP1Zg5MWJJ7TQs6Z85cs8uwIc0+P4JabXP/W94jR
        h+NyUqGkNaYaY3UtvwqzdHlIrrzPW2g=
X-Google-Smtp-Source: AKy350YE8BhZx71f7SyjW3DacN/LwNYjbxPvcBR9u9Iqg+o7UWtPSmj6VTULls3E0pEySES7Qww/Pw==
X-Received: by 2002:a7b:cd8c:0:b0:3ee:4dc0:d4f2 with SMTP id y12-20020a7bcd8c000000b003ee4dc0d4f2mr7262091wmj.41.1681614215370;
        Sat, 15 Apr 2023 20:03:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a7bce05000000b003ed1f6878a5sm8118830wmc.5.2023.04.15.20.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:35 -0700 (PDT)
Message-Id: <07e5da241dc2cb6cf6cc6de1051a2ee490bf26c2.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:13 +0000
Subject: [PATCH 11/23] versioncmp.h: move declarations for versioncmp.c
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
 cache.h      | 2 --
 ref-filter.c | 1 +
 versioncmp.c | 3 ++-
 versioncmp.h | 6 ++++++
 4 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 versioncmp.h

diff --git a/cache.h b/cache.h
index dde275c9301..6955745cccd 100644
--- a/cache.h
+++ b/cache.h
@@ -648,6 +648,4 @@ int stat_validity_check(struct stat_validity *sv, const char *path);
  */
 void stat_validity_update(struct stat_validity *sv, int fd);
 
-int versioncmp(const char *s1, const char *s2);
-
 #endif /* CACHE_H */
diff --git a/ref-filter.c b/ref-filter.c
index 57a5884aec7..5387f79be6d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -19,6 +19,7 @@
 #include "revision.h"
 #include "utf8.h"
 #include "version.h"
+#include "versioncmp.h"
 #include "trailer.h"
 #include "wt-status.h"
 #include "commit-slab.h"
diff --git a/versioncmp.c b/versioncmp.c
index 069ee94a4d7..9b21ec142dd 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,6 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "string-list.h"
+#include "versioncmp.h"
 
 /*
  * versioncmp(): copied from string/strverscmp.c in glibc commit
diff --git a/versioncmp.h b/versioncmp.h
new file mode 100644
index 00000000000..879b510e82a
--- /dev/null
+++ b/versioncmp.h
@@ -0,0 +1,6 @@
+#ifndef VERSIONCMP_H
+#define VERSIONCMP_H
+
+int versioncmp(const char *s1, const char *s2);
+
+#endif /* VERSIONCMP_H */
-- 
gitgitgadget

