Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A3FC6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDVUSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjDVURr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158E2122
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f19b9d5358so5220535e9.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194661; x=1684786661;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIkGlAhmULKGxj9CHConEVpIpm56FQxo272CDrQqxBE=;
        b=hSCcXpZ+7CnrDJchQTqnageWgcE86ipYwpaJVNE+Sgqhuwribuaqq8QPtrscVQvEl5
         iFEil/19X/JwRYzpE661mwkZx8ETYsZkNdquNLKCGJyNvkZdFg/ygcNL7rv34hsQ61WE
         74a3TKAoh3PAjlQ/m42hvgafgcNws77Dgz2kYxRX3S8smM7WQfbMnABzsHvjyOvA7S3u
         A+t7Go0GlRwK7I7OO7R6G8Rwh/0No+xEXNiie8tJ89YtQB7Oy6VAU1hxOo9uNDqxBkXN
         57PoVP814auuDi8JcChB//z67j1Kizfja3L541NegZjwDda6JjAs9LOxOGpeqgvPTKXN
         piJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194661; x=1684786661;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIkGlAhmULKGxj9CHConEVpIpm56FQxo272CDrQqxBE=;
        b=IAA3pBwQwcAm4FlkJFS1ce4P2XI8RjuakWCTQtXxIMwFaiP7cD3P1qH2vmxPyEOWW+
         M6LdEZvrGa6Bl95kzgI5u6CAEBpm9MM/4K9A8Zz3RyUhI+XZzc0Zq/w2tuiocreABeUq
         BUr+1mAMuATHOmhX61Fie/POJTxmDXzYCzTTL1SMr6BIJdsXXq2HsC03mg0sra9wxbXd
         2vRPrlZsDd7KoKkAH0PM64BfSW3ajNaRn2OUUdXuuGdvOJLP7ro54Q1uhw+Xx1+/eaof
         BVxnc0Ha1FUv3mQch6GPg+8hktsRsvibWyQGnp4Z71f9qUAQtVw7SgVB5Tx5N1HonldL
         /xIQ==
X-Gm-Message-State: AAQBX9e5FOX42qn8b0YBKmi28DI7fe03ZWWvWqTE69b/hEcI+mGB8HV6
        HTN9VimQeGUcpVc3Ew2zs4ZuVfyb2kU=
X-Google-Smtp-Source: AKy350YhoVX+I8uoThn+Cs8Vs5FZ6dVr4lQriAMrZrABoz5VVJ5yt4M4fl6XjhmT9oxQ40Xdi0Ok4g==
X-Received: by 2002:a05:600c:b5a:b0:3f1:979f:a734 with SMTP id k26-20020a05600c0b5a00b003f1979fa734mr2190670wmr.11.1682194661460;
        Sat, 22 Apr 2023 13:17:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003f17848673fsm8001537wml.27.2023.04.22.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:41 -0700 (PDT)
Message-Id: <ff99d0eb207008642c0142996d34f849cbf6af8d.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:17 +0000
Subject: [PATCH v2 10/22] versioncmp.h: move declarations for versioncmp.c
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

