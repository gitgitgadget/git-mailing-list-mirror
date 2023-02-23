Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9688EC6379F
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjBWIGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjBWIF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:59 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724748E33
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so7284205wmc.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qix9SHwVkTq8khdXz/bs4Q47Ge9wVJIZWWzOWc5pnb4=;
        b=GGxCxmYb7ficoETpD3bP/iEPogXLAeho+bm9gKRmMyNm2rDBkWz7OEei1qw8efSFMb
         czzXsOEXwEyKYtEHsWtg1LTlN4aiSqSWsPZfuZ7R92cImc04XDh+q3Ic8b5W5CRdehP1
         WlUKRTiMRXTacVx4asC2pTyFsCwikOj081kyTiGI4NYJyjkbr077ZE1HHNKray34w+Q7
         6Lj9sZ9Bk4q4DQjY56IP6ob5BBIjK9zFYLu4PnvdirGxVUs2oAyR2JuyPrEfLO7u56vj
         gvHx8yTYmywtnR7xLfVIT/9oGEOf9I9GPA/40l9kew0T6LZwBvn6koK6IvMCsN7rbkh1
         aX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qix9SHwVkTq8khdXz/bs4Q47Ge9wVJIZWWzOWc5pnb4=;
        b=plCqKahWw7ARLKZ9PqA6pArhgG9vRlWTbHnOSehlXwTdF8TrR0X+6L1hFK/B/lkvzF
         pacNw2CMTpkfyWbK8WEqA2ZXTGcXJ2hQ18QiXe1N0FUaYUue7CQ+OFcH3/EKTi/xC4vc
         8mtd+h7Rrt65VbQGH6mk8xYKoQGIv5WXnIYFcx3W2atk2d+7I+BGiEym7lcusDNLOgX+
         zor93x3NaQjlOuKHJ6FkguIVlIVTTtRijg6QTpkyYwCApc59o93dzw9OkoufGwHns93X
         mlXWn3Od56B4Pc4D4i6VQqwAKZoV1KkPMYaQFb4cWyeO5StRmLAafddnw7GkImAFS4Ia
         o5WA==
X-Gm-Message-State: AO0yUKVa+Pw0kuioh3RVUthdwleanAbBQs9GrnLMx26ZYfEbgvcBleM5
        gbhajkeK2uDu+Kc+/JhqDN933e+z/V4=
X-Google-Smtp-Source: AK7set+5Nna/0l78o6bH1TvXvJkaohAk4oj1wrkIXHMMFmGO0f1mxbJjfE5lxUoakDEj6mgNmI8mCA==
X-Received: by 2002:a05:600c:755:b0:3e2:1fe9:8d1b with SMTP id j21-20020a05600c075500b003e21fe98d1bmr4304602wmn.6.1677139533958;
        Thu, 23 Feb 2023 00:05:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c22-20020a7bc856000000b003e01493b136sm10409670wml.43.2023.02.23.00.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:33 -0800 (PST)
Message-Id: <3d99495aff38cf67dba6bb895c18c724fadc9251.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:19 +0000
Subject: [PATCH 14/16] treewide: replace cache.h with more direct headers,
 where possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 advice.c          | 4 +++-
 decorate.c        | 3 ++-
 diffcore-order.c  | 3 ++-
 diffcore-rename.c | 6 +++++-
 diffcore-rotate.c | 3 ++-
 graph.c           | 3 ++-
 hook.c            | 5 ++++-
 quote.c           | 1 +
 sha1dc_git.c      | 4 +++-
 unix-socket.c     | 3 ++-
 url.c             | 4 +++-
 urlmatch.c        | 5 ++++-
 12 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/advice.c b/advice.c
index fd189689437..a5ea460ab86 100644
--- a/advice.c
+++ b/advice.c
@@ -1,6 +1,8 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "advice.h"
 #include "config.h"
 #include "color.h"
+#include "gettext.h"
 #include "help.h"
 #include "string-list.h"
 
diff --git a/decorate.c b/decorate.c
index 2036d159671..71e79daa825 100644
--- a/decorate.c
+++ b/decorate.c
@@ -2,7 +2,8 @@
  * decorate.c - decorate a git object with some arbitrary
  * data.
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "hashmap.h"
 #include "object.h"
 #include "decorate.h"
 
diff --git a/diffcore-order.c b/diffcore-order.c
index 19e73311f9c..57ccab28464 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -1,7 +1,8 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "gettext.h"
 #include "diff.h"
 #include "diffcore.h"
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 62c0299984e..7e9ff96d435 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -2,15 +2,19 @@
  *
  * Copyright (C) 2005 Junio C Hamano
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "object-store.h"
 #include "hashmap.h"
+#include "mem-pool.h"
+#include "oid-array.h"
 #include "progress.h"
 #include "promisor-remote.h"
+#include "string-list.h"
 #include "strmap.h"
+#include "trace2.h"
 
 /* Table of rename/copy destinations */
 
diff --git a/diffcore-rotate.c b/diffcore-rotate.c
index 445f060ab00..533986cf632 100644
--- a/diffcore-rotate.c
+++ b/diffcore-rotate.c
@@ -2,7 +2,8 @@
  * Copyright (C) 2021, Google LLC.
  * Based on diffcore-order.c, which is Copyright (C) 2005, Junio C Hamano
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "gettext.h"
 #include "diff.h"
 #include "diffcore.h"
 
diff --git a/graph.c b/graph.c
index 568b6e7cd41..2a9dc430fae 100644
--- a/graph.c
+++ b/graph.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "gettext.h"
 #include "config.h"
 #include "commit.h"
 #include "color.h"
diff --git a/hook.c b/hook.c
index 1a848318634..f6ddd790988 100644
--- a/hook.c
+++ b/hook.c
@@ -1,7 +1,10 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "advice.h"
+#include "gettext.h"
 #include "hook.h"
 #include "run-command.h"
 #include "config.h"
+#include "strbuf.h"
 
 const char *find_hook(const char *name)
 {
diff --git a/quote.c b/quote.c
index 2453397fbbd..7ccb5a06cd1 100644
--- a/quote.c
+++ b/quote.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "quote.h"
+#include "strbuf.h"
 #include "strvec.h"
 
 int quote_path_fully = 1;
diff --git a/sha1dc_git.c b/sha1dc_git.c
index 5c300e812e0..9b675a046ee 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -1,4 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "sha1dc_git.h"
+#include "hex.h"
 
 #ifdef DC_SHA1_EXTERNAL
 /*
diff --git a/unix-socket.c b/unix-socket.c
index e0be1badb58..79800d80636 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
 #include "unix-socket.h"
 
 #define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
diff --git a/url.c b/url.c
index e04bd60b6be..2e1a9f6feec 100644
--- a/url.c
+++ b/url.c
@@ -1,4 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "hex.h"
+#include "strbuf.h"
 #include "url.h"
 
 int is_urlschemechar(int first_flag, int ch)
diff --git a/urlmatch.c b/urlmatch.c
index 620a648efc5..eba0bdd77fe 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -1,4 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "hex.h"
+#include "strbuf.h"
 #include "urlmatch.h"
 
 #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
-- 
gitgitgadget

