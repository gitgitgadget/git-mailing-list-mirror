Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC02C77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjEGDrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjEGDrI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:47:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3118867
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so7474875e9.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431169; x=1686023169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0B4pvIc5DiagiUq2VjsSPV6kDHWGEDm7Wv1uqhJ3os=;
        b=ByKVlE0dRbkArrMUyJixrGzHDuJbHCikwucFvk7ulLH7u3wllBgLJOaTTbHyJbZCjm
         RQfIVCae8WhDd52UKhNYqKVr0Lbk9q6GyVlrGXxML4D5ZoXU1a4PcLIzA+ZIjLyfNne5
         McaEWDagvxi3KOfmBMqvaUtIs6sCBdudNvubzMsPVG7OQRII+bM8AhuQodvBsLszCh08
         IV3adhxw6xJ83QyYth3u3vV5Ai26tffqpcu94rlCGXwIzR40jv1WKRoKjUYedzQCa3ZY
         I1WyHUlu+fcD0getUEvyoW0JX5HLRARJyZWuPpL7mm2JPFtiIq0nzyPcKxhWtFhbp7Fs
         dQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431169; x=1686023169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0B4pvIc5DiagiUq2VjsSPV6kDHWGEDm7Wv1uqhJ3os=;
        b=OGdpBITxGIVtJM01+xzVKCOTJ+kYU+pmooPns7nrlgHWHPUgspfI3sr5z2rd9xesbj
         2iFdKAutkrx6Ry00XLXCl9tCAzOflPAy6k83fR2fD8nwP4I1MuT21Iw+pBK4276yhBBQ
         3Qhf8/hqjbXTptbN1c9pDMjERz4A661656Icy2Da2cQK2LRY+Bw0OmZKtnl9Jr/tRHjB
         9d4ycO61P9rZfOFu+XWTlqy0TTY1CQRHIkoHCcVgUUfBZwuj7OIS3Lo53+dj3c1T8dsz
         DC9uxJUYVGnf1qK2prp5vygby0/eHHvSGRlG3ATkwGj1CnfvIZoIru0TY6Az4C+RG/qx
         aI/A==
X-Gm-Message-State: AC+VfDz2zIzcX/Z9K5VoZ0pYR6sbludZq1YgNoFt6coaPZoqDr0yON77
        j4r+ZCe0X3IjCsZh42yrZPFu4u2f9UI=
X-Google-Smtp-Source: ACHHUZ4mbGUYU4nq5MNEVk3KKp2i9R/4rU0W7hthkAr76Ic5PEloml2HvTWe7dO3Syafeekc0I8ziw==
X-Received: by 2002:a7b:ca45:0:b0:3f4:2300:e00d with SMTP id m5-20020a7bca45000000b003f42300e00dmr284409wml.3.1683431168812;
        Sat, 06 May 2023 20:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a7bc34b000000b003f195d2f1a9sm12441153wmj.15.2023.05.06.20.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:08 -0700 (PDT)
Message-Id: <f0e69592be839cc3604c6c5f60a61732f26f20ea.1683431153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:46 +0000
Subject: [PATCH 21/24] builtin.h: remove unneccessary includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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

