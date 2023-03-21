Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D22C74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCUG0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCUG00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9F833445
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ip21-20020a05600ca69500b003ed56690948so8361401wmb.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCcV+XRz3ZvYSk7Ny0a+1rSaT2uakbGD+pGKFbnpJ9s=;
        b=f8+lx+481Iiaeowa7680fFryqgC4QpkxBXVZ4jfv2mzmozSdIgRbEeYhBbZsqh++ob
         SO+qXQLj94zlaksP0LJvJs+tp9f+Erj0LbXj4dv/BAZJpBmik3UBfsrYh9dc8viH5sjx
         cyL19aBIipEDuUzhKPGc6G2qlYheEnZuvfhvDkXbZAeOlMxu0XS301vIO9rGGb5XK180
         Wd3oI+JBIfV+SaKc9pPo95JJDeHU7vUFWEzwIQpY6E6M6tMvxnz9h+d3J6rry6cvmUPI
         YzjqHTZ/5MMy+tAEVGqWhZ3/Wq8N7hYCPjAnSQ2wzayAFGchjJAXmZ+qOvUHsDT5/f7w
         UHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCcV+XRz3ZvYSk7Ny0a+1rSaT2uakbGD+pGKFbnpJ9s=;
        b=uCNS5m1CsKpukh3crJbja80YzJBu08JjD+3CPQud0iWWVtrpbVD/DKwXwp4HV1dzTa
         xSYziquPooA0GaxeurTZSPnd+uNe5XH5iETOTH84BMC5a/rgZho7uHlqgK74ycirEUtc
         cAu8/hpBieHKehiMSMoUvxD24R0ujhVAuPar6nExh3C1u7l9HferGO8ItPRKIqN0sZyR
         sLX/TPBM4iGmX268JzAnKAQ5IPYw/UTmautJ+UokRBzq5ZSMdv3MW7FzEmIhiweSNqVy
         csI688ns+QEbrcHTJHx6PTWUc9lgIBs0IowGWHZZwfwKsZFL1wSlIn37wTbmaCgvHh8q
         h/pw==
X-Gm-Message-State: AO0yUKX6YVJlbSdPMDYCUG/mxSYp+KtlxzJPhj4Bz6prfSypsusiUk/5
        d+2QyCdNnDYv3f/6voAZGMpazshLAF0=
X-Google-Smtp-Source: AK7set8E6vwJO7K5u2VbHw1SwComZJlXfWwS/D614ZFzBTp1ysYjKtyFvzlMhyaGyZHvqXhz7RPXLA==
X-Received: by 2002:a7b:cd8b:0:b0:3ed:d64f:ec30 with SMTP id y11-20020a7bcd8b000000b003edd64fec30mr1421146wmj.33.1679379981672;
        Mon, 20 Mar 2023 23:26:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c230a00b003ed2384566fsm12474653wmo.21.2023.03.20.23.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:21 -0700 (PDT)
Message-Id: <417b2ffa9992846cd3d93681ad19f66158ae1a42.1679379971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:25:57 +0000
Subject: [PATCH v2 05/16] environment: move comment_line_char from cache.h
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
index 4c803a5f4db..e59830291a6 100644
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
index c2ea89c4754..0611b3bd600 100644
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
index 5a736a2b7e7..e122de6f930 100644
--- a/cache.h
+++ b/cache.h
@@ -959,13 +959,6 @@ extern int sparse_expect_files_outside_of_patterns;
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
index 0df51726306..7fa776b0615 100644
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

