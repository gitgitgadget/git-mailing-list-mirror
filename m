Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84429C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDAPKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDAPKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6F1D2C6
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m8so3671573wmq.5
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361844;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnADl5qxP5oARf2rWxvJMotWa54UXEQ/45BX0cY3csw=;
        b=DY26iAyKeWEA28zc6xvzpFLvony0cbq358uhE8PjMNzzAXrfTPwg98wHRSleY7LrSl
         JZT/ZRwUGXAautYVfbli/1/hsBCUWznV4HPxy7I1oPNRoSx5WVJ8utfT5S9N9jtFeBiZ
         /wUdbwj5qouanXXhI4sd7QTEOkB6AOVNc5Y7tbifQ5jEl8XCP4KJUa85Py2sCQxNPCNc
         oDCJ1jWVnKdIpRN6At/3/ouszGFo5b6eXI3YRyoxBQ+rEfcUg17LJorRzsIFddkB9xkJ
         qKbXHvcCWHqyKha+htPCPeHXeHW97E18YoPIKC8+hpyNf9IntUluSVWC4nhGP6DvzaJj
         shhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361844;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnADl5qxP5oARf2rWxvJMotWa54UXEQ/45BX0cY3csw=;
        b=zYzLHMBmSunu+NWPdCGzmzOvSRcfmNTEODfpuFz6QyMwZuDNs4c+aBdmI/rcJumU6U
         NEvfja4zH3qBaCTFHTk5ORSsGsLOMz4vbre/fE6R4It0vERvpfUjNLxo7pBMIc/ZK7+Z
         4SIyq3zNuryz3lf008oSxEMcL46Uqi5MUQqMyBKPo3+DYoy7FASxjGdofnfNkB5aIWCL
         +028aRydE62zpSM6M7VHmDcHGXNXYND8WzZ0+QKYH8iOGmX5q9U2JqijMBERNYVX5NLU
         ao2yayW0gGEQBX8FtCwsQPZRRv9gi6y3kmblOXVv+sJMdFurKjI7dzK9QqfRXg6beyYi
         UraA==
X-Gm-Message-State: AO0yUKVk+LCna9TOtWjzWotDuFT7IStzfjZ2J/jo0DTA3qgDVeUFOkBQ
        MtThRBBWK4fqH5oWhgwxjLk5pTLVuVc=
X-Google-Smtp-Source: AK7set9QTWmAz5mH6Cq3XTxY2+jcRVpuujUa8QtcivI+DoNEvNlN/9uzCc0ciCH2zYJfqH8/CD8nHA==
X-Received: by 2002:a1c:6a05:0:b0:3ee:138f:be54 with SMTP id f5-20020a1c6a05000000b003ee138fbe54mr23616064wmc.3.1680361843898;
        Sat, 01 Apr 2023 08:10:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh23-20020a05600c3d1700b003ee9c8cc631sm13102326wmb.23.2023.04.01.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:43 -0700 (PDT)
Message-Id: <4ef4ee9daf31c4d52d43d7ce15b3cb42ce480c25.1680361839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:16 +0000
Subject: [PATCH 03/24] treewide: be explicit about dependence on convert.h
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

