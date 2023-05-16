Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B28C7EE26
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjEPGfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEPGex (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8003C3E
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso49760555e9.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218874; x=1686810874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0B4pvIc5DiagiUq2VjsSPV6kDHWGEDm7Wv1uqhJ3os=;
        b=iVnYY+Jlq7It/FDVqrCSds49vN+PuQvAcugvFg6cQK8yU6sekWUI1HToVexOCepQrw
         4js9Z9OqO3DsFlq38JqtVKiH/l+QJ6lpOEtdcU759PmdgUlMOfpsQTZ6PGmx3q3gpmfS
         avkbNQ9uqITz//0P0UWadQjyqqbGZm3xvQ3Feimbc8QsVOEUwZ3O2/rkr3J5AwSYCJRB
         Txk39raW+4oAiVvpk4Cll0Mp/s/8EnWsF1E4S8WGfpar9Mz7gX3r9aFAXBOTBHyw5GoV
         mWnrAy6VQdNbPq/C/ioVr0XsnU99B0pBXaWr3HhUG2SSSCZmYqammlvtJNaYZRwSWd8+
         5rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218874; x=1686810874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0B4pvIc5DiagiUq2VjsSPV6kDHWGEDm7Wv1uqhJ3os=;
        b=JGSi2RwhTZUGGKR5N8AmT1tZPe2KeNhEpRLSZ82bTzNVkJ0Fc1yr3QnOcXIgavO6/n
         J8WKsOv5bTyNCxjJTF5ZL5WKLv0Sv0kpjHRP51Xw2gvy9A0TonUoPdKqiaJj6dxcL572
         iGXlLsiADAA4nBnd5U1w0914zyd0SuXgMovMqy0j5bWl3xCAEHPFqW8k+aBBPoSKCjKE
         3c41m7eErCjiI8lHMJBrOsKr/NF+K5WWim9qjC9qvH4rRQuhRWjl+7ooIUJYrADosYt5
         wT//UwWjRGtJ35dskrZwiOCpJ495XZ40bMosa6PiEbcOdDPrxZmSjWIOJJJ4R2xJemX9
         b7Dw==
X-Gm-Message-State: AC+VfDzwz/0gz7LLacBUoxYC4rXKfJ6VAqjRiaDe6eRxbisMNKud2voZ
        AMaIjtnjqmjYkXWE7KUoSQBH07Q9jb8=
X-Google-Smtp-Source: ACHHUZ6B////3yepGSWu2Bau2JCmw+JjHB8LdR9AVywg/dZAvHmf15Woi4PLDGsqjmjtOK4uauTvwg==
X-Received: by 2002:a1c:6a0d:0:b0:3f4:23d4:e48 with SMTP id f13-20020a1c6a0d000000b003f423d40e48mr20792573wmc.23.1684218874185;
        Mon, 15 May 2023 23:34:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16-20020a1c4b10000000b003f4f1b884cdsm1106391wma.36.2023.05.15.23.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:33 -0700 (PDT)
Message-Id: <452254dbce097a5c7f313c7056fe46c10b7ec399.1684218852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:34:02 +0000
Subject: [PATCH v3 22/28] builtin.h: remove unneccessary includes
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

This also made it clear that a few .c files under builtin/ were
depending upon some headers but had forgotten to #include them.  Add the
missing direct includes while at it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin.h                  | 2 --
 builtin/check-mailmap.c    | 1 +
 builtin/commit-graph.c     | 1 +
 builtin/config.c           | 1 +
 builtin/credential-cache.c | 1 +
 builtin/for-each-ref.c     | 1 +
 builtin/init-db.c          | 1 +
 builtin/verify-pack.c      | 1 +
 8 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin.h b/builtin.h
index 3e6c22eef69..d560baa6618 100644
--- a/builtin.h
+++ b/builtin.h
@@ -2,8 +2,6 @@
 #define BUILTIN_H
 
 #include "git-compat-util.h"
-#include "strbuf.h"
-#include "commit.h"
 
 /*
  * builtin API
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 002d2941e93..b8a05b8e07b 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -4,6 +4,7 @@
 #include "ident.h"
 #include "mailmap.h"
 #include "parse-options.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "write-or-die.h"
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a3d00fa232b..96a8a677327 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "commit.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/builtin/config.c b/builtin/config.c
index ff2fe8ef125..30f6d9fe67b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -12,6 +12,7 @@
 #include "path.h"
 #include "quote.h"
 #include "setup.h"
+#include "strbuf.h"
 #include "worktree.h"
 #include "wrapper.h"
 
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 0ffacfdd83c..ff3a47badbe 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -2,6 +2,7 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
+#include "strbuf.h"
 #include "wrapper.h"
 #include "write-or-die.h"
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index d0d6ab0fd34..15409337f83 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "parse-options.h"
 #include "ref-filter.h"
+#include "strbuf.h"
 #include "strvec.h"
 #include "commit-reach.h"
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 680ef7e1837..0d8bd4d7219 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "path.h"
 #include "setup.h"
+#include "strbuf.h"
 #include "wrapper.h"
 
 static int guess_repository_type(const char *git_dir)
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index aba92cf8af7..011dddd2dc3 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "strbuf.h"
 
 #define VERIFY_PACK_VERBOSE 01
 #define VERIFY_PACK_STAT_ONLY 02
-- 
gitgitgadget

