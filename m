Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EF8C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 03:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDKDBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 23:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDKDBM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 23:01:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6E32729
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d9so6153597wrb.11
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681182069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5s4+nQacGNEaJvKHD5nhQnzhMBKMD7B1tWPD2OejTw=;
        b=JSRS2371jk4Yz7OBgVOi7rty3Zrhbtw9Ma/kAWIBfIsZiD382bKVUDj/K29saz9OII
         ElI6NSUZ5Sw5+5v2tVo+EgQ+afi223uN6Ce8m+mr6HGg6Yf+NaWbhyM5uQDXjmc/JfRR
         jhIZ/P24PT4nCnRwIgeXaBiEMgDYLtB3QhpdZa+jHz1XCLq9JcQr0Dr7IgUSQ7HroBJ8
         yvRKghmaRdKXLSDEIxErAnT5WmcxS/tBCEOoZrZW4FAvhbW9CDvu6pLE0kd60/ouJpSS
         YfbpEkv+bbQ7OEaH14OW5ig6R5AR+W3+YJtLOgP7v2rIrdCYTKEd109q3lFx2tyTcS+C
         inzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5s4+nQacGNEaJvKHD5nhQnzhMBKMD7B1tWPD2OejTw=;
        b=60UanJ4CLKvVovNbAdWhBR/33+toSeQBOTWRgnWIHfB/aZgiHSBlyuQ40b6sU1Ways
         o8HPIf+DUrCNVsZ+uvv3C1JpSJBnxloKKSm+N2jXytkcq7I/CyaMaKGajMro9bis0QyV
         N1q31mzyyU1Id72pMffoEUfleMUE0HA5Ny0upOssSWun1JqYbaZe1PZFsjc+5pLN7fLA
         /JnsFHJw7UJAjompvOxp2Cg+Sdn4wcCJ3kg9IRzK4zHt+OR84z2dkaXpo1QTTPe/sB6b
         H8r2fglPCjM6WBKqWWmTRbBLwN+BoayhlD+04Rd1lcKKLLcowBmGGF6zwbTPL1TT88QG
         R9dQ==
X-Gm-Message-State: AAQBX9c8DNSe+TDIkPaIG2o4/3P1FeK/+uuq2LcMdJ3XEEpIFsDH1VEC
        DEr4EvKDyvNohHkhUuyd26iOn2rE+90=
X-Google-Smtp-Source: AKy350bJ0C386gNpu0dyhnuFLjLCFBR4HbmDikBMoBuhMawfb5LbBVBuSMANxT3apsfXZ2GJZ/SeTw==
X-Received: by 2002:a5d:6101:0:b0:2f1:da09:883f with SMTP id v1-20020a5d6101000000b002f1da09883fmr3117204wrt.59.1681182068989;
        Mon, 10 Apr 2023 20:01:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d6985000000b002f2789d1bcfsm2740789wru.21.2023.04.10.20.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 20:01:08 -0700 (PDT)
Message-Id: <146aaef8e6aaf5675d5c04bb1ba0a54362d46497.1681182062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
References: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
        <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 03:00:40 +0000
Subject: [PATCH v3 03/23] treewide: be explicit about dependence on convert.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 archive.c          | 1 +
 blame.c            | 1 +
 builtin/cat-file.c | 1 +
 builtin/ls-files.c | 1 +
 cache.h            | 1 -
 combine-diff.c     | 1 +
 config.c           | 1 +
 convert.c          | 1 +
 diff.c             | 1 +
 dir.c              | 1 +
 environment.c      | 1 +
 ll-merge.c         | 1 +
 object-file.c      | 1 +
 streaming.c        | 1 +
 unpack-trees.h     | 1 +
 15 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index f1b8e9ce486..ab8966d73a5 100644
--- a/archive.c
+++ b/archive.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "convert.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/blame.c b/blame.c
index 3455f6a5ea3..ff2a6c49125 100644
--- a/blame.c
+++ b/blame.c
@@ -3,6 +3,7 @@
 #include "object-store.h"
 #include "cache-tree.h"
 #include "mergesort.h"
+#include "convert.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "gettext.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 04d4bb6c777..1e4b4798f40 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "convert.h"
 #include "builtin.h"
 #include "diff.h"
 #include "environment.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 68532f3e51a..7f228353feb 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
+#include "convert.h"
 #include "quote.h"
 #include "dir.h"
 #include "builtin.h"
diff --git a/cache.h b/cache.h
index d9ca2688d8c..415f0f85670 100644
--- a/cache.h
+++ b/cache.h
@@ -6,7 +6,6 @@
 #include "hashmap.h"
 #include "list.h"
 #include "gettext.h"
-#include "convert.h"
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
diff --git a/combine-diff.c b/combine-diff.c
index 44ef6a1a812..6586e4508d6 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "object-store.h"
 #include "commit.h"
+#include "convert.h"
 #include "blob.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/config.c b/config.c
index 3cee6538f3f..9e74b5aec7f 100644
--- a/config.c
+++ b/config.c
@@ -12,6 +12,7 @@
 #include "date.h"
 #include "branch.h"
 #include "config.h"
+#include "convert.h"
 #include "environment.h"
 #include "gettext.h"
 #include "ident.h"
diff --git a/convert.c b/convert.c
index 59127706448..5a2ea5308d6 100644
--- a/convert.c
+++ b/convert.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "advice.h"
 #include "config.h"
+#include "convert.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/diff.c b/diff.c
index e55a015cfd0..47c1973a504 100644
--- a/diff.c
+++ b/diff.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "convert.h"
 #include "environment.h"
 #include "gettext.h"
 #include "tempfile.h"
diff --git a/dir.c b/dir.c
index 10f6c38b930..d1f1b1ef768 100644
--- a/dir.c
+++ b/dir.c
@@ -9,6 +9,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "convert.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/environment.c b/environment.c
index 2254595e4a8..e57292eccc9 100644
--- a/environment.c
+++ b/environment.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "branch.h"
+#include "convert.h"
 #include "environment.h"
 #include "gettext.h"
 #include "repository.h"
diff --git a/ll-merge.c b/ll-merge.c
index 8be38d3bd41..28bc94c45d6 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -6,6 +6,7 @@
 
 #include "cache.h"
 #include "config.h"
+#include "convert.h"
 #include "attr.h"
 #include "xdiff-interface.h"
 #include "run-command.h"
diff --git a/object-file.c b/object-file.c
index 76b22ca75cd..a4331e0da61 100644
--- a/object-file.c
+++ b/object-file.c
@@ -10,6 +10,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "convert.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/streaming.c b/streaming.c
index 024fd796b7d..27e014d8b23 100644
--- a/streaming.c
+++ b/streaming.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2011, Google Inc.
  */
 #include "cache.h"
+#include "convert.h"
 #include "environment.h"
 #include "streaming.h"
 #include "repository.h"
diff --git a/unpack-trees.h b/unpack-trees.h
index 61c06eb7c50..30622aeebff 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -2,6 +2,7 @@
 #define UNPACK_TREES_H
 
 #include "cache.h"
+#include "convert.h"
 #include "strvec.h"
 #include "string-list.h"
 #include "tree-walk.h"
-- 
gitgitgadget

