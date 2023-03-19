Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F045C7618E
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCSG2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCSG22 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C508524738
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m35so5573874wms.4
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10hMyIrarvOcbckAPPw2d93EfWKd0PXMEvhiavUtS9s=;
        b=oNn5+fTwtT0xTiynmCEUCEpcIWRP2APPegZosyVRFXTz70ojVME0+afrNKYHwROP8x
         F2rMGeUQEl4jzD2AEAECpd70EOfAlFACGiQi6HYdNK08O/s12PiangiwFwwrmiywlqBV
         atcsd1NmHvqxjrR0tSmo1FDpc48bvqlbcMyTEjpwTLOPegIHSP3F+xayUGB1AoiF5evw
         5X+YZaDEEx/oSxZqcygxQ2h3OI/0/2/rl+Sxgs57KTeo7Rg5pJoayFn8blHfHcnIzIWW
         kYXi0mciPreaFknBIYFt80FKaTDam3dzlFugivkzrciKBsHPln3mMNb2oVZrKp65uus4
         KftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10hMyIrarvOcbckAPPw2d93EfWKd0PXMEvhiavUtS9s=;
        b=bUNRent7VBMcBVfkOL6nwccsxgfwgvlJw9SeZHJC7JWNMv4ub6uO2uINNTCYmPZXsr
         2Xe7eW3ptACHyf3EzGrb+m8vl+T4n2at+KmQBcK4BMYmySmNSARzP4ZL545P8Ts1CXAB
         Qil5MtoGAXxbMYJhL/iSS9PnEkrkir9N+HZEYCsyQAlVG/ElcWKT/QIQ6SJ2feihTFFJ
         GPhnKLa40C/ZrPTb1u7jaXWAQEZXpHQu2V3KX+nN4cOYu2cmdjhKOi8KU+RJVpU4Q9tZ
         D1LoAUYqig5iANN1r+tc5oEnZmxGR+mHurunkGKr65ZP1/OJ/u2AqUsuJ52vyttQ/YQa
         abnQ==
X-Gm-Message-State: AO0yUKUfUUwvlU7OW52/iMLzLnqjyn0ue3w/KSaHhVg4GTN80v20iDWe
        eO0T3aHCg9iZP1gE7QgxyxXn/P+c3AI=
X-Google-Smtp-Source: AK7set8ralDZTFQpLqxwOPZTFscrrmbgIQjNJAR4B2A/JNN6ceqF4jhG0LwE+IissEWdifvaRdadBQ==
X-Received: by 2002:a1c:cc01:0:b0:3ed:8b43:5f44 with SMTP id h1-20020a1ccc01000000b003ed8b435f44mr5652072wmb.35.1679207296881;
        Sat, 18 Mar 2023 23:28:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c025000b003ed1ff06faasm6664642wmj.19.2023.03.18.23.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:16 -0700 (PDT)
Message-Id: <0e84202da90e7edb90f6d7cc62aae4b10c86bbe8.1679207285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:28:00 +0000
Subject: [PATCH 14/16] treewide: remove cache.h inclusion due to setup.h
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
index edef9e161dc..f33826f0a0b 100644
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

