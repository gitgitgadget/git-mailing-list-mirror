Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F3C7618E
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCSG2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCSG2O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D67C1B2CD
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso7328396wmb.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207290;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELgrMmmT+ZI+ACnFBAYyYo1hSQmMZ0lCaV/0gSrrsr8=;
        b=Y+keDu1zzzB2qc9vsbonpmtQwHxptWWkJoT2xOoaVUVAxs0ejszaQ6trvAsbFuCC1p
         XzD+yzuw+iLpJEZkrAf3kW7W8+MlbAZlvRZNDr4Hn4EulInEIeHUKm2aptFcdPFUBgn9
         YQrfViccSaESQ4XYAXTmZRhMSPhiocxjgZOYrSgfszKJcmnGXKGd7MFC52L97Pg1JAT3
         LOuwmPb2+AANBfdiObdqvQDbtqKwunNPrY3NGBn+4ehqQs3PeOf8WEqDW68vtckwAopw
         E2RJwucJzMXPGGJKjH39J5aGEjLmcS+G0Sy5L0SiiQAL5CPpxJAidg7lGsR3JUYWq1+O
         tvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207290;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELgrMmmT+ZI+ACnFBAYyYo1hSQmMZ0lCaV/0gSrrsr8=;
        b=I0xjKJp2Ypv2crWpD/YNuiq7pE0wzo0e2F7unmh5Re3/4nxmPOwGffytr68AFpguNc
         hgBWdHzWkEcXQH/1NKcvu3yEA1fADrigeNP9veH0eNfSD6kIYNpW222cYhNv0ZnSFn25
         z3HTYEV48pMpAnvPnWgiDzVCR/T1eqMQ5Pp1cTMNXQ2/Z5kprGnsn3mVZWOzV8kJuwms
         BURUGX6MScYnRsmN22WkEksVTVHRu1jlCLW7L1l/FCq01ZMNMLpknSdDh3F0WJl1VdA5
         nN3vDWbdKk5V8UPUR122ITSmKDTVtVJo04wzIFkYlCVfcpnN6nKmz2vk39BrPs+frksI
         mcBQ==
X-Gm-Message-State: AO0yUKUjjqdOJpU65JV3cP+IuFLmozyZA5fTgS8VKx1se5xUn6h+TS4F
        P5x31vcK0pm7PxihFgozBYT9wk91CBI=
X-Google-Smtp-Source: AK7set+uCXzN0c8zgvLRkQY3k02Zjq1Ji/wJl5CRCnIchcanVKqmheEv1AFqVl7kVQ8OAQ9+KZYKbg==
X-Received: by 2002:a7b:cbc6:0:b0:3ed:5c86:d81c with SMTP id n6-20020a7bcbc6000000b003ed5c86d81cmr10073914wmi.8.1679207290611;
        Sat, 18 Mar 2023 23:28:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c1d8b00b003daffc2ecdesm12565924wms.13.2023.03.18.23.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:09 -0700 (PDT)
Message-Id: <43457e44b4eaac190ddcafaf95cbc5422df82700.1679207284.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:51 +0000
Subject: [PATCH 05/16] environment: move comment_line_char from cache.h
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

This is one step towards making strbuf.c not depend upon cache.h.
Additional steps will follow in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-patch.c      | 1 +
 builtin/branch.c | 1 +
 builtin/commit.c | 1 +
 builtin/merge.c  | 1 +
 builtin/tag.c    | 1 +
 cache.h          | 7 -------
 commit.c         | 1 +
 environment.h    | 7 +++++++
 fmt-merge-msg.c  | 1 +
 sequencer.c      | 1 +
 strbuf.c         | 1 +
 trailer.c        | 1 +
 wt-status.c      | 1 +
 13 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 7fe6b66d866..780fb30607b 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "add-interactive.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "run-command.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index a67a8334d5c..56dbee97d20 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "color.h"
+#include "environment.h"
 #include "refs.h"
 #include "commit.h"
 #include "builtin.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 25575435ad7..42bf20f589c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -12,6 +12,7 @@
 #include "cache-tree.h"
 #include "color.h"
 #include "dir.h"
+#include "environment.h"
 #include "builtin.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index a90ae5d2ddc..2c9da4b23d1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 4f9047783a5..78b3e44e993 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -9,6 +9,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/cache.h b/cache.h
index 0221bc6d5c9..4b4c2e17557 100644
--- a/cache.h
+++ b/cache.h
@@ -956,13 +956,6 @@ extern int sparse_expect_files_outside_of_patterns;
  */
 int use_optional_locks(void);
 
-/*
- * The character that begins a commented line in user-editable file
- * that is subject to stripspace.
- */
-extern char comment_line_char;
-extern int auto_comment_line_char;
-
 enum log_refs_config {
 	LOG_REFS_UNSET = -1,
 	LOG_REFS_NONE = 0,
diff --git a/commit.c b/commit.c
index 3fdfb325117..f88fc5e1a2c 100644
--- a/commit.c
+++ b/commit.c
@@ -2,6 +2,7 @@
 #include "tag.h"
 #include "commit.h"
 #include "commit-graph.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/environment.h b/environment.h
index d438b5c8f3a..a26931556af 100644
--- a/environment.h
+++ b/environment.h
@@ -3,6 +3,13 @@
 
 #include "strvec.h"
 
+/*
+ * The character that begins a commented line in user-editable file
+ * that is subject to stripspace.
+ */
+extern char comment_line_char;
+extern int auto_comment_line_char;
+
 /*
  * Wrapper of getenv() that returns a strdup value. This value is kept
  * in argv to be freed later.
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index c870cb95b9d..bc4e61c5b1a 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "refs.h"
 #include "object-store.h"
 #include "diff.h"
diff --git a/sequencer.c b/sequencer.c
index bc7e72d5fef..0fe00b0bcec 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/strbuf.c b/strbuf.c
index 15209777d5a..b9cd593b147 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/trailer.c b/trailer.c
index 9eb1b761190..6a5091a3c46 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "string-list.h"
 #include "run-command.h"
diff --git a/wt-status.c b/wt-status.c
index d15f2b0e7e8..106e46480a1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "commit.h"
 #include "diff.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
-- 
gitgitgadget

