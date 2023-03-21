Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C857FC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCUG07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCUG0e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632603844E
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v25so9039580wra.12
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379988;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFM3ETpPA0/8BbUUV1vbuv04wwKUHUfhKKdGmOCFjeI=;
        b=R7zkItWWf9QdsSW64mvC7oUt+Ux8ctu7LaaUvR3BfoEAqtdY5tM9+tQeRkE42ltj8/
         2mH0Yz+yOjf1Ge/jxrUiIJiZKwKT8OhJFBbGy+LUM3rs13HSMFiPRXYzvtxv0gGdILAR
         Nc+h/TmFhFzYw6x3YkyZMn+bb75XPtVLB6rzEuWajJAR9aVl9+U/V80VsUGgVcH2ghfX
         UL2Kx78HTK8I3h0ztEA1+/tohV/Pv0dmSAR1hlhpIHzKzFzVSxXl3j84fxJ5ZZU32/es
         5TcoGWboBj+F++e5PjnMJhpTuFbmi9AQdF1uHCWs8StsTCj6P4pvPYQkyWb8V9gNk9yZ
         I5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379988;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFM3ETpPA0/8BbUUV1vbuv04wwKUHUfhKKdGmOCFjeI=;
        b=KXjDggVOFQ3bo5cQYo89gISlYdVkJEg7KFZ7+wX3TXHYqVL6fO5znYF+TsWpkfCRE5
         fsZIjZTNCYuI66z2v7nQgOpw9bvmzt0vgy0VN94Mw7ScRRkMwq8vS2+tIwOotWSz9ggZ
         pa7roBtFJZrsTe2tJ7RCPizdWcxCK3EZeNW7EDTKzFLTEiZBu5UjPT9nNOcs6S6nPmvF
         es5Yh7oW5cb45uXgwGrOADpRiqwc1K6+w6+TAGFmtXu1TNJpW16ZZmJGuEQ0825tou+Y
         t68MDB4CxYgqe5fQ3350wWkitCD5t9358at3VKXXbMLSqW8E1cV/SHcUyy6PjX1FGo2p
         McHw==
X-Gm-Message-State: AO0yUKWxgtPVM1kBAhWkKmJPDUBViUfXzDzCdx+SO29s0DsZT1U8zniU
        q9wMBbhiILDz0HLxcV1d9pvYhLSbkyY=
X-Google-Smtp-Source: AK7set9zZDUu9kfYTSlFrjSFZJL0D1VED8+8UTju2MUIyn4mHuhwZdbsboxKbcEgTxKjXrEM0caITA==
X-Received: by 2002:adf:f605:0:b0:2d4:766d:e02f with SMTP id t5-20020adff605000000b002d4766de02fmr1322586wrp.59.1679379987905;
        Mon, 20 Mar 2023 23:26:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e23-20020a5d5957000000b002cfefa50a8esm10434215wri.98.2023.03.20.23.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:27 -0700 (PDT)
Message-Id: <30b21691265a57bb3c6db0c5e2e117731c795daa.1679379973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:26:06 +0000
Subject: [PATCH v2 14/16] treewide: remove cache.h inclusion due to setup.h
 changes
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

By moving several declarations to setup.h, the previous patch made it
possible to remove the include of cache.h in several source files.  Do
so.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 line-log.c                                   | 1 -
 path.c                                       | 2 +-
 t/helper/test-advise.c                       | 1 -
 t/helper/test-bloom.c                        | 3 +--
 t/helper/test-config.c                       | 1 -
 t/helper/test-pack-mtimes.c                  | 1 -
 t/helper/test-partial-clone.c                | 3 +--
 t/helper/test-proc-receive.c                 | 3 +--
 t/helper/test-read-graph.c                   | 1 -
 t/helper/test-ref-store.c                    | 1 -
 t/helper/test-repository.c                   | 1 -
 t/helper/test-revision-walking.c             | 1 -
 t/helper/test-serve-v2.c                     | 1 -
 t/helper/test-submodule-nested-repo-config.c | 1 -
 t/helper/test-submodule.c                    | 1 -
 t/helper/test-subprocess.c                   | 1 -
 t/helper/test-userdiff.c                     | 1 -
 worktree.c                                   | 2 +-
 18 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/line-log.c b/line-log.c
index 84c8093c517..10c19daec4a 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "line-range.h"
-#include "cache.h"
 #include "hex.h"
 #include "tag.h"
 #include "blob.h"
diff --git a/path.c b/path.c
index a1702434979..dff215ac693 100644
--- a/path.c
+++ b/path.c
@@ -1,7 +1,7 @@
 /*
  * Utilities for paths and pathnames
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index 4e6ed30afa1..8a3fd0009a0 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "advice.h"
 #include "config.h"
 #include "setup.h"
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index e5754b8da62..d2b30d644da 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -1,7 +1,6 @@
-#include "cache.h"
+#include "test-tool.h"
 #include "bloom.h"
 #include "hex.h"
-#include "test-tool.h"
 #include "commit.h"
 #include "setup.h"
 
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 5877188f3ad..32d170ec303 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "config.h"
 #include "setup.h"
 #include "string-list.h"
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index 75ca1505a37..0f3fbeec532 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 #include "strbuf.h"
 #include "object-store.h"
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index cce496944ac..362bd64a4c2 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -1,6 +1,5 @@
-#include "cache.h"
-#include "hex.h"
 #include "test-tool.h"
+#include "hex.h"
 #include "repository.h"
 #include "object-store.h"
 #include "setup.h"
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index 7c8de7b562a..f30022d2225 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -1,11 +1,10 @@
-#include "cache.h"
+#include "test-tool.h"
 #include "connect.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "setup.h"
 #include "sigchain.h"
-#include "test-tool.h"
 
 static const char *proc_receive_usage[] = {
 	"test-tool proc-receive [<options>]",
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index e21b0805f3c..78965a6ebdc 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "commit-graph.h"
 #include "repository.h"
 #include "object-store.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 8717b95e84f..d1192c8c039 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 #include "refs.h"
 #include "setup.h"
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 6774f6245f0..bafd2a5bf95 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "commit-graph.h"
 #include "commit.h"
 #include "config.h"
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index f2df4334063..7750afb2866 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -9,7 +9,6 @@
  */
 
 #include "test-tool.h"
-#include "cache.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/t/helper/test-serve-v2.c b/t/helper/test-serve-v2.c
index 7d590ab7227..054cbcf5d83 100644
--- a/t/helper/test-serve-v2.c
+++ b/t/helper/test-serve-v2.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "serve.h"
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index aaffd422d6e..d31f5e48ab5 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "setup.h"
 #include "submodule-config.h"
 
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index f18ca46dce4..0e34581b209 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -1,6 +1,5 @@
 #include "test-tool.h"
 #include "test-tool-utils.h"
-#include "cache.h"
 #include "parse-options.h"
 #include "remote.h"
 #include "setup.h"
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index 65a355cc590..c344f1694df 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "run-command.h"
 #include "setup.h"
 
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index 0cd7ee12b7e..680124a6760 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "setup.h"
 #include "userdiff.h"
 #include "config.h"
diff --git a/worktree.c b/worktree.c
index 7f0f04eab56..b5ee71c5ebd 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "environment.h"
-- 
gitgitgadget

