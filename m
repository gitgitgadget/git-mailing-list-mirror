Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A17C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 03:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDKDB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 23:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjDKDBO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 23:01:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF72D49
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w21so5967229wra.4
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681182070;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa0v754i0Q2U43qAMyRL0LkHJXVVJNPDNxKpJw0tJis=;
        b=ZlvYCk1GAfxBE+SFz/q0UhxLEziTxRkYhUTSipUEoDOzvBx48KE+VXB0ZRPpcAha45
         4U1SR/p+4QYdjpgEWUPmRJcjGHmyfOEwuc1WY5a22pX0ftjVteSxZEzWXeaZwo1/8nJ9
         /og9pX2SYQKdoH5iZbzR7Lssa4TBgcmLwMgBXrdva7WwgjpbR+VXKO+ZKy41MuwP/qZr
         QKxC9Hy8FZ7OTU9C77sQHDVe0a08Xer5rz/BlHNqIpphetBs3affhnimfTpqu2SysLKH
         qH2CE5LhY1TZmuCCmRwM21xtsp7VuixcRe8PAes5bW9MOYjrLriPremgl0KTT7Xsof+e
         Bf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182070;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa0v754i0Q2U43qAMyRL0LkHJXVVJNPDNxKpJw0tJis=;
        b=Pn+LtlfS1zZb1Fho71VYq8OUKcaXeJPYfEfSoJplc9YcQGUTFwpMgNUwDwCeWYljO3
         qSzdrIohPSGngykcwuPnIynWRqM2/gl/YOIabM4k/6XG8ikYQPiJxDOSqH+l+zonPMN4
         Y3DYAdhb5Ee5z0qFdiby5csOJ/majsu5TKCicK4SnbBZAuXUbogeU7r3k3P39PU/9UXh
         FSaEHvShMmppcsjBk9iambVNABRKZy2n4tudIDgHe8aYQCn83GEc5ny7yVi8i0WxnFpO
         cWR0EvEKFVhTraudqTyE2JKULwkMnBE+9O4kGXbPcZxbPwC2XTnoWhcp6pfaSFIaZOyL
         rkuA==
X-Gm-Message-State: AAQBX9cYGgxw0df/zindCplS5qf7pO0ogObDE7atwM9oiUsZF3c3m9Bi
        lHrJ8mBD3/VWOXiQNAJW/yJP5Nek/MY=
X-Google-Smtp-Source: AKy350Y8Cp60ZdA6PejJo+2rWANNc6h0z8xJhaNEUN9q0mpFynJcV/YLU3NQDbm+94ny+oN0l/Nitg==
X-Received: by 2002:adf:e710:0:b0:2f2:7a7e:6ba with SMTP id c16-20020adfe710000000b002f27a7e06bamr1904814wrm.15.1681182070445;
        Mon, 10 Apr 2023 20:01:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4c90000000b002cf1c435afcsm13228666wrs.11.2023.04.10.20.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 20:01:10 -0700 (PDT)
Message-Id: <f3c5ad2a2be24fcbe86026e4550e90bd7fc186ae.1681182062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
References: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
        <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 03:00:42 +0000
Subject: [PATCH v3 05/23] treewide: be explicit about dependence on
 oid-array.h
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

