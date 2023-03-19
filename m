Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C316DC7619A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCSG2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCSG2T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C263E2472C
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id w11so4522773wmo.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA0O3qeSqMX1hqtmM6pmONEe5YJVwJwNrwiany9TGUk=;
        b=GLRjICj62CHLnUv5t86QmSCu/MpTD6zH5R+W0OwSwLZqsKXXWt7sY2SexVaIt8LaAe
         jcHwO48WmF1rUFQElQ9g0QiqOt/Ec79Xt2w4utAHI/jPAOIkVRfmE9D1FDKL3Wy43eKb
         WMyqPDJQopjTXR+2dEytBPbi1EXwn52cgruCFXwBdB5XZdQlaOEauNh1xIOKs0YMyD6r
         CBZWUVGe8nbs7lFSOuGJyU1THhCgTIzMTYdDcbTKZZL8ndI9zAQI6BFwKpGzTRAFpl7p
         H4U7/kggyJx191820IWor/vBgObV9a2ZpI0uC+z3agXejpvk1UWXAy0xEyHHTWc6emjk
         6uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nA0O3qeSqMX1hqtmM6pmONEe5YJVwJwNrwiany9TGUk=;
        b=NtI0nKyIhQ8bSAGEJ1fUVOHo+W5GJ8x/AqqY4aYEnuGQFGNI/PF4wLaqqXR743x64l
         H3GpC6XoxNdK4OTko+9rYng4o3kXUMC7VDdUNRaPAhqz0zlqoJLg2mNibY7sN7M9xltv
         D4aRsaqx/r32H2pyV6tpfk38Lx7pu0wEOMSlM34GhMFTzY7HviPe2sW85TluTW7Tyf8M
         LnyE2xMiyS+4VMxn510U0SQ9dBQZiYAN4JacAGy2xpr2SwrspdCb9jWbd98kth+dQ5Ip
         2K/qRzNoA8Ip4i0gmfinfM0fzfJPZLAdhi4vmXRp21//ZlTPyh3xPUdlNJsnnjL08X/e
         PjfQ==
X-Gm-Message-State: AO0yUKWHOY+cYl/NCfmyL+IfQXh5XfwqCkle0xHdRZ+cVaVquBi5f4UV
        4Av+83eUzs2hfhoMgxAhly/gAuX5W8k=
X-Google-Smtp-Source: AK7set88fmcx9bJeSmmLm4CUCrvhyxLGqhLc2nHNuKvcCM5gUXdbxlH7kpHA9h7tuCWUOFarSq7fVg==
X-Received: by 2002:a1c:720c:0:b0:3ed:e406:a320 with SMTP id n12-20020a1c720c000000b003ede406a320mr310224wmc.24.1679207295637;
        Sat, 18 Mar 2023 23:28:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg7-20020a05600c3c8700b003eb2e33f327sm22368222wmb.2.2023.03.18.23.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:15 -0700 (PDT)
Message-Id: <4e6a4030b1ec542014b84b13e651ec2518511f46.1679207285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:58 +0000
Subject: [PATCH 12/16] treewide: remove cache.h inclusion due to environment.h
 changes
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

