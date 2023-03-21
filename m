Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A56C74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCUG0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCUG0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A81437B6C
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o7so12507805wrg.5
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379986;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA0O3qeSqMX1hqtmM6pmONEe5YJVwJwNrwiany9TGUk=;
        b=iDGlKIRlV+DcY8WqfDtBWeuFglUuZqqP7DJv/u53v2NV1ps7gblDQcVzBmSUcnaus4
         f8vqkwIjHDph4MbMwv3JWWWLmlg+pdd6CbwTI78F9ZX5KtZK1sGUP12B5/JyPaR55WJb
         KKdhDqjyiLJ7XcBy7iJs/1Y3zBBl5wyD2f8SS7jQAMZnxHTJF8J5GrUfKJLSxznK5vCS
         3BzIq6TqW5uVg2Ag6Hq2Sr30Nlj5x0uayUJU8+uqQ8aX2retmLJVGDxy//KvCkhUzDpA
         k47XtavLT4UxVTRqGDLTnVvHKmfqCyxFQnm5bNYDzmv8fWIcwVfz6kDVnXrmpmEqyNoG
         ASHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379986;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nA0O3qeSqMX1hqtmM6pmONEe5YJVwJwNrwiany9TGUk=;
        b=kuGRL9MvZiDuk6ozhhCypb8Tv9b5S/6Zf5UGWJqWPwjRC2hI3WtU0UuEMO+byLhWwM
         s2ClcdQ2oScQDaf2tMmfrjbNA+IPOHaHwVCT/dqvHQkZcpoQ6oZFW5p30QBC7WF18phZ
         3f/xemT9ufO+EPKJE9M95QU1g/Uh+udMAcXR4XgOs2g159VeKWzAb26PKOyuZl6Xv11M
         RVSSk64XqlAPf6r4ySIIaJRUTDLsv0M3esdzLrpqPhX1XcMNsndMTfMU+lugT1zUttUD
         Ds5g3dRKpqbAwRwZXWMMfj5eWWfMdWOHTkXb7x+x3BTrCHWivaWAGvv5P5VAW7Ntc6Gr
         hwZQ==
X-Gm-Message-State: AO0yUKUXRhyqcRJUd5FOBrRe3XIUI7o0Rz+NZZfMaYQC5DuPzjNWZpVV
        fI9odq+phkyQl2fiVtVlCQbpruwCiVk=
X-Google-Smtp-Source: AK7set//3ub76KPRBJPdSkOF2mvUpgLZwFaEi2JGG1dKvk5kLTLvmI0fKv4Lzk7FWjbT1EESuXB/Fw==
X-Received: by 2002:adf:ed0e:0:b0:2d3:bfcc:1b11 with SMTP id a14-20020adfed0e000000b002d3bfcc1b11mr1118981wro.42.1679379986563;
        Mon, 20 Mar 2023 23:26:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d5102000000b002c71b4d476asm10438742wrt.106.2023.03.20.23.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:26 -0700 (PDT)
Message-Id: <496d36e4fd0cd68ef6592d3694c8c4ec281f579b.1679379972.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:26:04 +0000
Subject: [PATCH v2 12/16] treewide: remove cache.h inclusion due to
 environment.h changes
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 csum-file.c            | 2 +-
 gettext.c              | 2 +-
 ls-refs.c              | 2 +-
 notes-utils.c          | 2 +-
 prompt.c               | 2 +-
 prune-packed.c         | 2 +-
 reachable.c            | 2 +-
 t/helper/test-bitmap.c | 2 +-
 trailer.c              | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 2d22f80d901..82ae2973d30 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -7,7 +7,7 @@
  * files. Useful when you write a file that you want to be
  * able to verify hasn't been messed with afterwards.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "progress.h"
 #include "csum-file.h"
 #include "wrapper.h"
diff --git a/gettext.c b/gettext.c
index 85d3d3424eb..5f348708300 100644
--- a/gettext.c
+++ b/gettext.c
@@ -2,7 +2,7 @@
  * Copyright (c) 2010 Ævar Arnfjörð Bjarmason
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "exec-cmd.h"
diff --git a/ls-refs.c b/ls-refs.c
index 12cbb40a198..b9f3e08ec3d 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/notes-utils.c b/notes-utils.c
index 8797271faf1..86552f31c4a 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
 #include "environment.h"
diff --git a/prompt.c b/prompt.c
index ba10813b313..3baa33f63d8 100644
--- a/prompt.c
+++ b/prompt.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "run-command.h"
diff --git a/prune-packed.c b/prune-packed.c
index 5a57072a7ac..58412b4fb91 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
 #include "object-store.h"
diff --git a/reachable.c b/reachable.c
index b0f85046e9c..55bb1143530 100644
--- a/reachable.c
+++ b/reachable.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index ff35f5999b3..5bb489882da 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "cache.h"
+#include "git-compat-util.h"
 #include "pack-bitmap.h"
 
 static int bitmap_list_commits(void)
diff --git a/trailer.c b/trailer.c
index 6a5091a3c46..a2c3ed6f28c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
-- 
gitgitgadget

