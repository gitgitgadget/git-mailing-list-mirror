Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E590C76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjDDBWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDDBWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:22:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2FE2101
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q19so28067306wrc.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnADl5qxP5oARf2rWxvJMotWa54UXEQ/45BX0cY3csw=;
        b=f0bcHPGJoigRMMDaeGlwJG34/sYWh27ctbJwDDugJoSdAM2i8Fc/xDye+7+ZoyLCHB
         PMho505vpi/WA4nbDNbV1oUB+M+b05ldfD5cCUYdZPHAsGZ2Q8pKFoaLZdxlAIxWBD7d
         oYMQl6awk6CyVQrzpFYY7DbUqwasEsnfu5ELbFn2VHwN+R1FBjL/ioBZbvXCavVgXv6M
         CfIfpQsf/77w+0qS9A5HPAa3QJoz/fZFefihb5Nlrh1iDd5qjcu/WAZKHChFWbz2ddxT
         8FG95A7MVo2DSAM27dskbWe8WEiNe5IlInf81WR25OmSQ6SZo3Vk7nUeBwpnYR/XTwBm
         8xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnADl5qxP5oARf2rWxvJMotWa54UXEQ/45BX0cY3csw=;
        b=3S8XqfHoRQpPavzFHiiLzhmku0vjWAoMNwGcXmWV3fxJNj21778dmsrvZSewFvKOuv
         R7S1VvQxDkhB7F3EUtuT9scY2IxJr8k7mXo1MvWfPlEYMmGrGEHopsdUlkA+lVdb5TZ0
         yF9BDwfcbAr0i3h2Jmzd0NPuE3/552vGNj3vbI7r/+Q3LCdwSg9hX6exfj1w7XW5tZQy
         b23Mu674SGjJbmB2yG7mejUgK95cey5wp3LxHkdoUCbciTn+It3DAczlx3YeCxZGip5O
         2oyRgXrXZKeJ/uhH4U41C+0WHbjGjcydViGBfRnl4nlt+YmvbyR8CZWBHxIu/zxnMwHk
         S8RA==
X-Gm-Message-State: AAQBX9cYx8MAp19V/TSV/GkNCqb23F1WpIzumeSpoNjTJqf7kc+8yU0n
        UnTNNnRoMP7Y3TS1WG/hwBp223JTta0=
X-Google-Smtp-Source: AKy350bypchW1SHqsaIpmLawkQNXBCLZJ3DyAAlbVa1uNS+5JiXW11jOolUTqzHe7q8YDCgsPdHaGw==
X-Received: by 2002:a05:6000:12c3:b0:2d0:cf21:a40e with SMTP id l3-20020a05600012c300b002d0cf21a40emr273681wrx.30.1680571357431;
        Mon, 03 Apr 2023 18:22:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d68c8000000b002c55521903bsm10912588wrw.51.2023.04.03.18.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:37 -0700 (PDT)
Message-Id: <4ef4ee9daf31c4d52d43d7ce15b3cb42ce480c25.1680571350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:07 +0000
Subject: [PATCH v2 03/24] treewide: be explicit about dependence on convert.h
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

