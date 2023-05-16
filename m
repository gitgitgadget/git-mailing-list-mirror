Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D31C7EE24
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjEPGfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjEPGeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF2C4685
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso72306535e9.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218869; x=1686810869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUwimbSgeOzcEP9ameyh3VbVpCTezWYkKUoRQfT5VtA=;
        b=lPYxjy2XTlsmmQxWtJnmCDs3DIY4FStJBEs0QikQdkO7Ab39BH2RccpCa8xB5cw4u+
         qg5UKRSCU2N5sJvOD0w+8sFOx2XFdbsTTCER0f8Kwjh2mHQt58WFvdFZjGBLK7d8JyCS
         BIf74D6pzNa0s54fqp3WoLsJK0BQYLfNSayyi9BnXC38hYXGC9V55LOdRqU0j6ACgTo1
         I6JO22Sx//BbAFwU5rwNgatECED5VSZPkFKRA3XsAKkFa0aS1Nqj1feVwyG14aCMtmbe
         lwwXUdrao4q/DVDfmUDRZ9fZp1Q3l41ETV7GecZStusYzm+dhFPuFEMR9eswjJTmZQhx
         hVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218869; x=1686810869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUwimbSgeOzcEP9ameyh3VbVpCTezWYkKUoRQfT5VtA=;
        b=bFGKLZ3j7/SxY1gQxYnxjc9DSYxhock/ajrAq0dumzqoRrgF9xTXvVVrCRIlYT+lms
         r0sHITXe6Kavg7MOYT49X8VZT9WSD4vSAYcKAcXjhFcIWi1vrmPeZDtqyw8zyg2O8Rs5
         ngoSBiWfrQN0jfGXKqEi1KFGmSc31SS/sLI6f2VNn5U7aUvp9FUyw3Jk9jDBrtYavTj/
         qd6uj03QQ+iwSCF0pbbpjN4YK21bnyoNoA7MOEOjOv1jUdZHB1iPVnV61yLSu9leUUC5
         rqSF/0lysH09BjKfVOldB2duiDMAcqojOU09rzvKaJ7pM8cycKgPyMWil9dueutzLQ/t
         NPFw==
X-Gm-Message-State: AC+VfDzow+/NkdUdPoejYfkO6Woltgu6dzadOof6ba1Kle0Bjp3H1DN8
        UYKwntGNYkfv8Y9FFZq9i9KI9R2t+yc=
X-Google-Smtp-Source: ACHHUZ7NTLJJxaeeWiQde0Zg6ba1p2mtqiKKFEVcAECz1eizMN7Sc2q0Zcah9l+cxuPvA8NTV6pCIg==
X-Received: by 2002:a05:600c:295:b0:3f4:e43a:8292 with SMTP id 21-20020a05600c029500b003f4e43a8292mr13774548wmk.3.1684218868888;
        Mon, 15 May 2023 23:34:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b003f4e3ed98ffsm1096506wmf.35.2023.05.15.23.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:28 -0700 (PDT)
Message-Id: <8a94028229971aeaa49020a870b4cbcb4ac1ecd6.1684218851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:54 +0000
Subject: [PATCH v3 14/28] merge.h: move declarations for merge.c from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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

