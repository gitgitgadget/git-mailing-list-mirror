Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AA9C74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjCUG0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCUG0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE432E64
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so10441277wmb.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379981;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMth5Xyw5kKadzeguwjm+HZRMYYchGYdUJy0NuhaRFg=;
        b=LGw68yBK+qzjXVgOunv+b4QGWXZ8ziWGaEPaXAUaMwv2iluXPxn5I/OAKv0bK+ScyS
         8uUZOEn8fKM+UCU7TuW3yMMfIxjE20KPkvXrK88vM1l7pTFzw46hisZJz8FhopK+ecoe
         /zVGKkIoI+zixhD/kjDYr2Grf0a8mIgN5/VeXsm20pTnHp4kjSYBnbg5ouFL9/qXEpw+
         Bb338Al8HMtLhKI5xa052B8bnyrMMY3XsS7FGjKCs60xGVA/flxHnEh2CizcnambPPWi
         xGrvowo3Uj3Zt3rUSQz7b37jodJS0nQpFA74a72K3KXiThWjR/mMJzRwCpAzB04O8gDD
         yMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379981;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMth5Xyw5kKadzeguwjm+HZRMYYchGYdUJy0NuhaRFg=;
        b=3LlvVOs3VF1aJn2MB6v0xx6HHhw6thB56ttj7NAGkdOh0U49sYLPKPZssmNZ2uMyqm
         vHdLga3p6Xd1ZEgTFkCipwfzHYNTfbNy64xpCkfZ5P5jOxhp3Tmn4ZgJImJdT8+gbN7N
         XgyhtQ4i7M96NtintUuUJg2LwmcMNpSq7Jw5Lh/jAKKRMjdt60AqBPGQqisuzFQG5YUx
         PTA13u6uxSgdFMlIdvcr3RStqdpO0AmjTn0koCt888P4NR7IsnerTwmRNoDySgnvT1j9
         0uuLs74cpn7P5ehhzqMkzXiQxobDCSg1Vry5hGOor4ukfsGJpItqczPI6ad/t7WcXlD4
         2a0w==
X-Gm-Message-State: AO0yUKU/jBnO3bBtISgnulye3+7MqjEV1PPVH0My7rL3saJG9H+bNoJi
        A0dZXwouN7kfqjPUUz7XLKoGf7GEglg=
X-Google-Smtp-Source: AK7set+r8gn53Hf583ImDD92UQDgxCLPToGZVrv0CyLLcV+cHz4r4nUnCgzX95OrwyhbA9uaduZYjg==
X-Received: by 2002:a05:600c:220b:b0:3ed:c763:2765 with SMTP id z11-20020a05600c220b00b003edc7632765mr1444691wml.7.1679379981014;
        Mon, 20 Mar 2023 23:26:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c475000b003edc9a5f98asm8114645wmo.44.2023.03.20.23.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:20 -0700 (PDT)
Message-Id: <95b86aecb4391bf9767a1308267e18cc55c2fa5f.1679379971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:25:56 +0000
Subject: [PATCH v2 04/16] treewide: remove unnecessary cache.h inclusion from
 several sources
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A number of files were apparently including cache.h solely to get
gettext.h.  By making those files explicitly include gettext.h, we can
already drop the include of cache.h in these files.  On top of that,
there were some files using cache.h that didn't need to for any reason.
Remove these unnecessary includes.

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

