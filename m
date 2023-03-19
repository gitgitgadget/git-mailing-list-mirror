Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91074C7619A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCSG2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCSG2O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35111ADF7
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so5649622wmq.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgapYYkR5aeTry8ev9WYQQSOGaa+JmeF/6sy2mXYLiY=;
        b=kWPI/6JPm14PwMI/NYLzfpZHfKhp+WneReXkFnYyx/tq9FRFdC5cbcNBPlS36eqca3
         ZvAa0PJTLq60LUB8GMZV7tbccZRsQNjQi9RJzs0YDMCk8VlATdfUuM7IEReOB7cG0ukP
         lzF3+eyW3mO8QgDcvDtl+6dRrBrDry9zLQiNopAFRqc1DJaHdkhwDZ3mAa6GJ01UGsA7
         QrZ/3m7CVEj/QMniH7mBYz4oej/gQhkAo3p+Kc5tHCPzOimc8DfHVFnKTwoFNCG9qCaf
         uJauSTXAljJ0r1qyULmNkY7sxKBBZsmWnhcq6Lunq6LGepTH3j6K7Q+uGTMx/m6HWa7D
         cnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgapYYkR5aeTry8ev9WYQQSOGaa+JmeF/6sy2mXYLiY=;
        b=emXv5NWuAmaCgG4icsOhM9JqOD4EzMUZRUpQy8Y+fr8qJbEVciZlmHoo/uqc9zKURW
         K5r0CPDgy4FBtytnQjlP5jmJHaiTaHq10OJpDADBNgvS0u0MqysrOOW8KxnU9DSvO/6f
         2HIOt8sRFaiaCWREzyAwqNwXBIa27AR2HrRr0fz4T0DFUdHhMAz9DkzCkpewf8f62cl+
         1l2WOSDCsKtx4QhqqwmKKZn72Agssi7VXOkdYEaeyVMOgwoo17yJ3SvJ9JGi3/TldJU2
         AAY987s12BblHl4MfsKg50tx5LYhLZwINsW8vDAq8+AIpYmcs58adcWw2fMQ1D1BsTxU
         d95w==
X-Gm-Message-State: AO0yUKUbUCRPROj/I/b9evhN0LpdUzvQRHR114evcFtKtK1rDEn1Qi/w
        tDeT/n3wKq+WH8+uEtkMTCNg1QKD5hU=
X-Google-Smtp-Source: AK7set/c9V0tJehV1M/zxzEQVxPyqrzFqixm5VtnHgLNlcFNjbQPM2VjFmxfwtCKVycgcMyLIWcipg==
X-Received: by 2002:a7b:c8c6:0:b0:3ed:da87:3349 with SMTP id f6-20020a7bc8c6000000b003edda873349mr713935wml.1.1679207289691;
        Sat, 18 Mar 2023 23:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg7-20020a05600c3c8700b003eb2e33f327sm22367892wmb.2.2023.03.18.23.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:09 -0700 (PDT)
Message-Id: <3c193bef1d017efb8e1c7b1dd7d753a7a5c9e352.1679207284.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:50 +0000
Subject: [PATCH 04/16] treewide: remove unnecessary cache.h inclusion from
 several sources
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

A number of files were apparently including cache.h solely to get
gettext.h.  By making those files explicitly include gettext.h, we can
already drop the include of cache.h in these files.  Remove those now
unnecessary includes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 compat/linux/procinfo.c        | 2 +-
 compat/simple-ipc/ipc-shared.c | 2 +-
 connected.c                    | 2 +-
 grep.c                         | 2 +-
 negotiator/default.c           | 2 +-
 negotiator/skipping.c          | 2 +-
 notes-cache.c                  | 2 +-
 patch-ids.c                    | 2 +-
 reflog.c                       | 2 +-
 refs/iterator.c                | 2 +-
 replace-object.c               | 2 +-
 t/helper/test-hash.c           | 1 -
 xdiff-interface.c              | 2 +-
 13 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index bc2f9382a17..4bb2d66227b 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 
 #include "strbuf.h"
 #include "strvec.h"
diff --git a/compat/simple-ipc/ipc-shared.c b/compat/simple-ipc/ipc-shared.c
index 1b9d359ab68..e5e1dda8ccd 100644
--- a/compat/simple-ipc/ipc-shared.c
+++ b/compat/simple-ipc/ipc-shared.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "simple-ipc.h"
 #include "strbuf.h"
 #include "pkt-line.h"
diff --git a/connected.c b/connected.c
index a4c0aece757..669bc4e8d69 100644
--- a/connected.c
+++ b/connected.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/grep.c b/grep.c
index febb076a7e6..bb8796a829f 100644
--- a/grep.c
+++ b/grep.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
 #include "grep.h"
diff --git a/negotiator/default.c b/negotiator/default.c
index b7e79feaf04..5dd553a1fe3 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "default.h"
 #include "../commit.h"
 #include "../fetch-negotiator.h"
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 264acf8bbea..4157c4d72f5 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "skipping.h"
 #include "../commit.h"
 #include "../fetch-negotiator.h"
diff --git a/notes-cache.c b/notes-cache.c
index 9dfd251a815..01a918c925e 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "notes-cache.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/patch-ids.c b/patch-ids.c
index a4473a88fa2..19af7bee984 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "diff.h"
 #include "commit.h"
 #include "hash-lookup.h"
diff --git a/reflog.c b/reflog.c
index d1c39374318..4e121e449d1 100644
--- a/reflog.c
+++ b/reflog.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "object-store.h"
 #include "reflog.h"
diff --git a/refs/iterator.c b/refs/iterator.c
index c9fd0bcaf90..6b680f610ef 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -3,7 +3,7 @@
  * documentation about the design and use of reference iterators.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
 #include "iterator.h"
diff --git a/replace-object.c b/replace-object.c
index 9e30e0362ba..e98825d5852 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "oidmap.h"
diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index 016248106a7..45d829c908f 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 
 int cmd_hash_impl(int ac, const char **av, int algo)
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 5baf6ceb947..356356afe71 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "hex.h"
 #include "object-store.h"
-- 
gitgitgadget

