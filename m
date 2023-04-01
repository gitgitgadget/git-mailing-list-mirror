Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C8CC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjDAPK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjDAPKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1E1D2DC
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s13so14564206wmr.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361845;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uubwnAxTanaMxF9LO+ZNSELJoo7B/YYCOGh0zo53IBQ=;
        b=AxOKJUmzEiifrnlFYeAJA7dUc73ysvFPpPflVKfNzBtd8FYD4jRZt9KmBk6oYDrK3Q
         YddAmZXPNRs17UGJU/Ov4w8DOccYfZ+/3QM3Xsezmv4TQw2F65DJ01PtcUTEsdYxz1mV
         ZKdwf46mrPYbL6K+7qAHlJ5OA8Vo8l0iq3X8mMJVMj1+N5jfTDioRimKctAsrCQGptgu
         yV0ZlAZLqngRAWzgY1UvbO8NuZPl6LMA3BdYHSK/PUg4D505+9iMgTPaJMH6ewe12JkP
         sP0JyF5VdD1tNlWkuewAKfLcmBZQukBh5dOAzTWjGBrKOKusxIWdhknb2eFF8Fmf18YL
         ifZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361845;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uubwnAxTanaMxF9LO+ZNSELJoo7B/YYCOGh0zo53IBQ=;
        b=VXFQ7wbeRcfhfw41iqmO8WCScbqX/CPXPv8Uh1hvK8rfee4CeKNA/zHWknGV/ee78U
         p3lDnCPkP9k4w/tF0X6FIM1ZCPRkieDWL2N9cLAgWuZJYN+o0LsKfuh+XkGsQ1g2qw2Y
         NPph+KUY3/qGB0D5PbZ+ghkTsjs/rs7Wo8CXT54kGnW6+iqSkh1vaD7LQYc0kB5RVM6m
         BfooVjic9wHeBGoE0e3BiZilfElt/yRS1LmCylbCb0LMM6hFSn7gI9M3WRP3UATyfltq
         kerrUS03D19SOUUdADM1XTLxhAV/RoYWpJXCHQjOqoSmSE53cnf8Y72kSJf22vVCTO4u
         AqGQ==
X-Gm-Message-State: AO0yUKVacUUwuJOjgQWpTM0qlclzrzB2IHKBekNZA/iLGgQrMyD5GPQm
        CvK+6qPZLJZxGbinNbssE1eLB6gtWHc=
X-Google-Smtp-Source: AK7set8qB/1tYu9oOo1zzXrDruKtAi9G63I6ZTqeQGYfNHjhrjbNys9n2IjOyNb35PvJXeDeIzQrOQ==
X-Received: by 2002:a7b:c8c4:0:b0:3ed:ce6f:e86e with SMTP id f4-20020a7bc8c4000000b003edce6fe86emr23343302wml.23.1680361845317;
        Sat, 01 Apr 2023 08:10:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w20-20020a05600c475400b003f034c76e85sm10431028wmo.38.2023.04.01.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:45 -0700 (PDT)
Message-Id: <81a9378be43243c063430d6e23b6a0f28dae5d40.1680361839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:18 +0000
Subject: [PATCH 05/24] treewide: be explicit about dependence on oid-array.h
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
 builtin/bisect.c     | 1 +
 builtin/fetch.c      | 1 +
 builtin/index-pack.c | 1 +
 builtin/log.c        | 1 +
 cache.h              | 1 -
 commit-graph.c       | 1 +
 diff.c               | 1 +
 merge-ort.c          | 1 +
 read-cache.c         | 1 +
 ref-filter.c         | 1 +
 upload-pack.c        | 1 +
 11 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 26f07357a03..7dc175c6570 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -9,6 +9,7 @@
 #include "dir.h"
 #include "strvec.h"
 #include "run-command.h"
+#include "oid-array.h"
 #include "prompt.h"
 #include "quote.h"
 #include "revision.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f2b80987751..e0936629213 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -12,6 +12,7 @@
 #include "refspec.h"
 #include "object-store.h"
 #include "oidset.h"
+#include "oid-array.h"
 #include "commit.h"
 #include "builtin.h"
 #include "string-list.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ceb0f120ede..5adfb2521cd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -19,6 +19,7 @@
 #include "packfile.h"
 #include "pack-revindex.h"
 #include "object-store.h"
+#include "oid-array.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "setup.h"
diff --git a/builtin/log.c b/builtin/log.c
index 2ce645eee97..094897df236 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -20,6 +20,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "oid-array.h"
 #include "tag.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
diff --git a/cache.h b/cache.h
index 5f1279454a8..6eac3134a22 100644
--- a/cache.h
+++ b/cache.h
@@ -11,7 +11,6 @@
 #include "path.h"
 #include "pathspec.h"
 #include "object.h"
-#include "oid-array.h"
 #include "repository.h"
 #include "statinfo.h"
 #include "mem-pool.h"
diff --git a/commit-graph.c b/commit-graph.c
index 1bf673b1345..fe9a8b2342f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -12,6 +12,7 @@
 #include "hash-lookup.h"
 #include "commit-graph.h"
 #include "object-store.h"
+#include "oid-array.h"
 #include "alloc.h"
 #include "hashmap.h"
 #include "replace-object.h"
diff --git a/diff.c b/diff.c
index 47c1973a504..89cd0b17da5 100644
--- a/diff.c
+++ b/diff.c
@@ -29,6 +29,7 @@
 #include "string-list.h"
 #include "strvec.h"
 #include "graph.h"
+#include "oid-array.h"
 #include "packfile.h"
 #include "parse-options.h"
 #include "help.h"
diff --git a/merge-ort.c b/merge-ort.c
index ad7367179d9..9b0b184b130 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -32,6 +32,7 @@
 #include "entry.h"
 #include "ll-merge.h"
 #include "object-store.h"
+#include "oid-array.h"
 #include "promisor-remote.h"
 #include "revision.h"
 #include "strmap.h"
diff --git a/read-cache.c b/read-cache.c
index a744eb89e4e..1b585ce8424 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -15,6 +15,7 @@
 #include "refs.h"
 #include "dir.h"
 #include "object-store.h"
+#include "oid-array.h"
 #include "tree.h"
 #include "commit.h"
 #include "blob.h"
diff --git a/ref-filter.c b/ref-filter.c
index df84bb71643..1c6174c8aed 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-store.h"
+#include "oid-array.h"
 #include "repository.h"
 #include "commit.h"
 #include "remote.h"
diff --git a/upload-pack.c b/upload-pack.c
index 71440c63806..e17545a834a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -8,6 +8,7 @@
 #include "sideband.h"
 #include "repository.h"
 #include "object-store.h"
+#include "oid-array.h"
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
-- 
gitgitgadget

