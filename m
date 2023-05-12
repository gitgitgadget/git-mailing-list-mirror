Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B823C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbjELHFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbjELHFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:05:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC96D2CC
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3063891d61aso9112613f8f.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875094; x=1686467094;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0B4pvIc5DiagiUq2VjsSPV6kDHWGEDm7Wv1uqhJ3os=;
        b=p/AFCKkvDkWoajovv82iakXxZHlazj9mfNRw0sbLn6L/wJCJciGjJBU8F2o6ij8QW1
         e76dEPNjagj7Pdc9fpI6u9hrFnNRlxAQs/NhDETIqzT3UuycLUB7TKhC9bZjxldRsbmZ
         wnsLlOba4y2umQBN7huZrJ9zyxPD1xGdTAErHk7pW0OJfVQZ9JRd5iT+iT5vlkU2vJoJ
         eZKqaof6Q+g3zdEr5PAO05vO3/8I19zTw5lG2j5y83tiiVNAFT97ewizb3DYdXpzQH0z
         cKcq1NPzklVoMYpci0hBK+ede/acOzMAnHvkuoKMLttdKZfMAI5XybcyS/ZsnTKadQzK
         +lIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875094; x=1686467094;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0B4pvIc5DiagiUq2VjsSPV6kDHWGEDm7Wv1uqhJ3os=;
        b=T0BmUiwWfTBApJ+xNnhCY20qGTiVs4fEwJGjtQV2oICqZQMgJT5UHkpfSl30mF/DM0
         POJTW13EyG0yTCGWDeGoaS8csaJeUjVXDSRhR5D1RGUKaNfERcKBBa5rLkave4W5v+Ao
         OBj42lN1QmDKgt6MTWqN3LpjBkKRpvMdVsEmJR+3LWpAPyWz9kQ2bXinJDJhnE3ngUoe
         05NKwJ9g/3Vf+BD0Z9sWkD7APFLfpxVUbYqbh981jnpa6/61+uhTbtquboSStDt2f4Jj
         PtbHymY8MZMMAx2V/gZYTaYxiK5p0Upv4++h7gJ5Kxw3h1M5uvjnHFO7EjtNXjfKLt0P
         ounA==
X-Gm-Message-State: AC+VfDxlDmDVJwTJQ8WTDbZVPhoeL/CL3ciGIuyW1NrHCDO/b9dRTK0R
        nHdDT5cIbE1RSop0PlfFJgXJj0y50dQ=
X-Google-Smtp-Source: ACHHUZ6xmvl33O7Mj7qseaE+kxlIWLcKcsz8uM9E56WEbEHpXTTcVd74mSYj0lRN/M21rTuKdKIOqw==
X-Received: by 2002:a05:6000:1191:b0:306:462a:b78d with SMTP id g17-20020a056000119100b00306462ab78dmr14942971wrx.53.1683875093855;
        Fri, 12 May 2023 00:04:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b003063db8f45bsm22356474wrt.23.2023.05.12.00.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:53 -0700 (PDT)
Message-Id: <1d3d33a843b3af435300d37228cd028a67ae1265.1683875072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:23 +0000
Subject: [PATCH v2 22/27] builtin.h: remove unneccessary includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
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

