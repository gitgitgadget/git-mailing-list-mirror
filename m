Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE568C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbjELHFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbjELHEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E05E8A56
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f315712406so309973895e9.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875088; x=1686467088;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUwimbSgeOzcEP9ameyh3VbVpCTezWYkKUoRQfT5VtA=;
        b=M+zzDcyeVKrS74ovEMUZIG/+08HrcKhz5zIeE4s57VS5p0CAAYn0IaPI1dwbQ+Vitm
         BqJnZGtjjx2nnUmimbllPNaFd9oWxCsN1bvVHYlZpv0Vth7jxZ9RpcCD8T5mPtNbvX6H
         hNWzQtzSNuHewOEUE/p66LGkkI8FVewfS9MHAb4G4JERUu/lBDaIozF6a75VWfL5C150
         8GbysIbtQYtdLP/90Ue9rq7gUCWO6hxB6V4w7SgxgM/raR9hO+WSlrvJzYWXga0uwiBY
         2DQrCEXrX/4Qrn/PFTqau8X/eMruKjiQ+e8VeGhCOBFLqIp4XENiMi9e7CiGtMKrLoSn
         f3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875088; x=1686467088;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUwimbSgeOzcEP9ameyh3VbVpCTezWYkKUoRQfT5VtA=;
        b=a5xbRuWVV+HoA+JwOIqdUURr3LbsedhPhli7Ax+rygkrFMNlzsIHG2MMXoH/v185oI
         Bk+DeduhnXaQKkUBgwernygOJL4BBxidIWyx9T9o1WSaQ72I2rv0I/NqZDedM1+ZDOh3
         +4Z7cx7/e6yd9VfhXFj9a83kxCye1Xqxb8tbVHkcuuPfiHFEmm9JKDGyFtkvneTYQvFw
         fg2550WatIgz0Htl6FRvlhz1+paTuXoWUZW3pjkiamgr9kO7XnYUayZ44W2fFP+OdPya
         9/sC/ivxRaImeVwZmMjTEhTV6D2S5qJxllpA7X4onpCR3B/GqDzPNxplNNYTuqK14F+j
         7gSQ==
X-Gm-Message-State: AC+VfDzwtY7xqh2A8W6vLs9axGn2p2pz9TIsxSlj+ISpTRuJbtxQWuLJ
        bPmGX4qxvexJ5lQ2nyO9Y3cnOSkxJeM=
X-Google-Smtp-Source: ACHHUZ6qeFWY8zexlDlp4pIwOCkVNYGjVUJZrq/0ksrc7RNfLAEgHOihOszVuQdyvoLrxsihLg6ZPw==
X-Received: by 2002:a05:600c:4e44:b0:3f4:9a86:f2ab with SMTP id e4-20020a05600c4e4400b003f49a86f2abmr5533242wmq.17.1683875088259;
        Fri, 12 May 2023 00:04:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc014000000b003ef64affec7sm27670789wmb.22.2023.05.12.00.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:47 -0700 (PDT)
Message-Id: <77c3c5918b8cd874d0ca1be7b326207ea3fc98bd.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:15 +0000
Subject: [PATCH v2 14/27] merge.h: move declarations for merge.c from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

