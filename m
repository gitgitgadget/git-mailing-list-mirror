Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A80C64ED6
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBXAKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjBXAJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44BC2C665
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j2so12146007wrh.9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/exVLOfyJ821kcaMlsfzPXkBPgu2DlOOQJ132O2GD98=;
        b=RT/RBJVbQPqRuQWia64fGD0FwwGlgDonryjz8fEDUEqOtQzCotHknfZQAK7tSWk+Vr
         O66h5PXQLhmacHn4Ch+BO+i/Olu/Xsr3oSIWwzfyVNrlnlUhONsw1uH73rRhI5Mt8OfO
         aDOs+B8Ljq9rlEI2xhr8FU17CJn4NsNA7YlBv/7Q3JDsvRo4UK84drQ+aR/BbCHlkMBw
         t403by4XucJgAR7qw0gWSojmGirS5E1DQRrv8GqsqZDW/I3K+fmHIa4kp7W8uwzHx8su
         CW0nDpHuC5P1DPdJBRCLoAzvnpfCYk2vTDBWXthuPc1Sp97EmKadVV3RvhXZO61IqOrU
         0KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/exVLOfyJ821kcaMlsfzPXkBPgu2DlOOQJ132O2GD98=;
        b=bn3NCL4G8Lm/iJJ4C3REl9WplCgQcgZuyfxbj1LUBLNSjJfgYIozvnTtbf1hIve2kd
         P9Asv7eUL0Sbke+Jg9oeaox/YHCytISsnn4AKZwye4LzvDQ0ZbhaEXD2inkNQGth8HbS
         6qaHP1y7qYZjJ9f9sWUfqJdo3VJFqz50xLBH+PCQRgq2HiX4H71TP7Bi31eLDUQkRwL1
         uSYfaFvZIUi4UFywq8q4mVHmcQBtF1upUD9rj5UfOQRyCEUR9vPAbIhmTa6l2iKYgUYx
         119C/Z6opqvZgvxx+ZICLUSPr3PUPfEi4fT3p+EFAI/dHcA/qeBQehuoURgE2IfUf/uQ
         RR4Q==
X-Gm-Message-State: AO0yUKU67ZBUzaDF0xPH0/WjkC/B40z3H6dqYQ8PJQhuWEORwvPYc+ni
        aETJ5igXwyM0LAPtTkvaxCg/Hr2ynTs=
X-Google-Smtp-Source: AK7set9wfRy9w4cIFafxD5w4TBRI6Jv4mV2I0C2l36iKtjzYUnUGacZxgFN/4SPDs6w15/ENMg7/cg==
X-Received: by 2002:a5d:6645:0:b0:2c3:db87:977c with SMTP id f5-20020a5d6645000000b002c3db87977cmr10493261wrw.12.1677197392208;
        Thu, 23 Feb 2023 16:09:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2-20020adff502000000b002c573a6216fsm9788665wro.37.2023.02.23.16.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:51 -0800 (PST)
Message-Id: <814d60ec94ef56071becb4ea03d2524e088a75f7.1677197378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:34 +0000
Subject: [PATCH v2 15/17] treewide: replace cache.h with more direct headers,
 where possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
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
 sha1dc_git.c      | 3 ++-
 unix-socket.c     | 3 ++-
 url.c             | 3 ++-
 urlmatch.c        | 4 +++-
 12 files changed, 30 insertions(+), 11 deletions(-)

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
index 72709606fdf..9b675a046ee 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "sha1dc_git.h"
 #include "hex.h"
 
 #ifdef DC_SHA1_EXTERNAL
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
index bf318c05205..2e1a9f6feec 100644
--- a/url.c
+++ b/url.c
@@ -1,5 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "hex.h"
+#include "strbuf.h"
 #include "url.h"
 
 int is_urlschemechar(int first_flag, int ch)
diff --git a/urlmatch.c b/urlmatch.c
index 2965cbe774f..eba0bdd77fe 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -1,5 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "gettext.h"
 #include "hex.h"
+#include "strbuf.h"
 #include "urlmatch.h"
 
 #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
-- 
gitgitgadget

