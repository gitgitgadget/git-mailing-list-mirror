Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF1AC77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjEGDrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjEGDqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A21B18911
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so20606125e9.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431164; x=1686023164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUwimbSgeOzcEP9ameyh3VbVpCTezWYkKUoRQfT5VtA=;
        b=NnFUoOsC4OL7whth3Xaemxs4F8zFdowNW+WFMeN7odH7Q3fU/ea8r/PgMumotJCv2b
         R7T+O3q99OrL43Yda12BxRxPC55pUSdOEOtAN0v8v2gXphea/2kwHlPErQJ3Q0RV2tNV
         N3xmd2E1zvxa+RgcvsvejdZjj+gKunwGQNeqpsQbklGelFks+IZPRxfOnfhDNrZQqaCP
         GCpg0VklDgbVb89urXxu5aZ2RXP1y9Z0p3CKVpuUrgP4V7pgswGopkLMh5Q9TJ79r+zl
         /7cfsy0E0e1knzhn+yQaRItFbGg342aspG/OD1lxqp1o51J7vAcf3a/C/UGeFX9/F/55
         ek5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431164; x=1686023164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUwimbSgeOzcEP9ameyh3VbVpCTezWYkKUoRQfT5VtA=;
        b=dp7leB+Ra/FqFWR1PEdjpOItTCVanBKQlW7bV61BoIjndHdAqNGykq84v/H9vkIeiZ
         tWcW27NVFgKF2RapEp7MqPlc/VRJuzpVqqAgwBvqAxWh9lbnDOxpWf+mvRWCq5V309+H
         en6brgwWk3bB2pOBtz+f7pBRGYv2Zv4T6GVLAr3X7zyqX3/YS+FTnpMFZ6ETo9lfo42j
         5tu5JGqKQXQNmdsd/qTkziD3ydROCAIfwGr4yzhlOXwlpfjfG95UeztHu4W/MyI3RNdY
         xjH9fLH6kkzWKv3ELtcNaI+X5oUzfL29DMV6i9hPxs24Df/lJ92d25WjpeWpEBAI4R9A
         XGUQ==
X-Gm-Message-State: AC+VfDyQWWZeYiWcUiDOCl829MaOypDrJXK/fNHbEA9QOHgVqFGEuJ8M
        7fa6eSvxCE/ICW56DKy07HbmMdNN9To=
X-Google-Smtp-Source: ACHHUZ5Tifv80mqAqYjHBoBL3qRCUZ7/3SxAGhZs5SWKpZZMFIPcivF4nKsER03bwOT9jfKvbAnWCg==
X-Received: by 2002:a5d:5286:0:b0:2cf:ee9d:ce2f with SMTP id c6-20020a5d5286000000b002cfee9dce2fmr4514363wrv.19.1683431163864;
        Sat, 06 May 2023 20:46:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4ec2000000b003063a92bbf5sm7025556wrv.70.2023.05.06.20.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:03 -0700 (PDT)
Message-Id: <d56fc27c94b8830d3a0e896ee8d713651c63d52d.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:38 +0000
Subject: [PATCH 13/24] merge.h: move declarations for merge.c from cache.h
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
 builtin/merge.c |  1 +
 builtin/pull.c  |  1 +
 cache.h         | 11 -----------
 merge.c         |  1 +
 merge.h         | 17 +++++++++++++++++
 sequencer.c     |  1 +
 6 files changed, 21 insertions(+), 11 deletions(-)
 create mode 100644 merge.h

diff --git a/builtin/merge.c b/builtin/merge.c
index 8da3e46abb0..6e8f7b9bb53 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,6 +37,7 @@
 #include "color.h"
 #include "rerere.h"
 #include "help.h"
+#include "merge.h"
 #include "merge-recursive.h"
 #include "merge-ort-wrappers.h"
 #include "resolve-undo.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 967368ebc65..f9ddc94ba9a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
+#include "merge.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "exec-cmd.h"
diff --git a/cache.h b/cache.h
index 08f6fbd801d..5b690b80a16 100644
--- a/cache.h
+++ b/cache.h
@@ -527,15 +527,4 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
 
-/* merge.c */
-struct commit_list;
-int try_merge_command(struct repository *r,
-		const char *strategy, size_t xopts_nr,
-		const char **xopts, struct commit_list *common,
-		const char *head_arg, struct commit_list *remotes);
-int checkout_fast_forward(struct repository *r,
-			  const struct object_id *from,
-			  const struct object_id *to,
-			  int overwrite_ignore);
-
 #endif /* CACHE_H */
diff --git a/merge.c b/merge.c
index 10aaec3a6c1..fade6b203b3 100644
--- a/merge.c
+++ b/merge.c
@@ -4,6 +4,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
+#include "merge.h"
 #include "commit.h"
 #include "run-command.h"
 #include "resolve-undo.h"
diff --git a/merge.h b/merge.h
new file mode 100644
index 00000000000..21ac7ef2f13
--- /dev/null
+++ b/merge.h
@@ -0,0 +1,17 @@
+#ifndef MERGE_H
+#define MERGE_H
+
+struct commit_list;
+struct object_id;
+struct repository;
+
+int try_merge_command(struct repository *r,
+		const char *strategy, size_t xopts_nr,
+		const char **xopts, struct commit_list *common,
+		const char *head_arg, struct commit_list *remotes);
+int checkout_fast_forward(struct repository *r,
+			  const struct object_id *from,
+			  const struct object_id *to,
+			  int overwrite_ignore);
+
+#endif /* MERGE_H */
diff --git a/sequencer.c b/sequencer.c
index cae9c75a54e..ec4a2e80a10 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -25,6 +25,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "rerere.h"
+#include "merge.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "refs.h"
-- 
gitgitgadget

