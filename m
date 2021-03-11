Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA0C432C3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E164FEE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCKCMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCKCLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74855C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:34 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l3so23889161ybf.17
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0BuRmGZKoOY5XfD4AJjW5pTpDGMeN228GKmYi+Vi1Tc=;
        b=jSRYkW2gkRNjtN0dTlkbHeUZqytsYE6Ra5rGr6GH0tYBpBgS353RbP9KbBwoWpw1Rl
         76bMF8X4AWPkAbWwXjA5NNYrhE/t2X+LH1g/SptNi2Dap2cMCr18qS07AEpGRI4ChLxW
         b362DWQDdWtdpBkRNEedTIqdkDl4ly8C6eeqPQLznx/ezRX1NwF4DOHkju1Qtd4LE9P2
         hcGiphIe3AaPaw7u9mKxEpsl6N/3Gg/q66GFmJ9KaVO8IPVHFfVkGf7DSuRPOcJWbcCK
         5pp3kf0u8xf0OA/x+Ojuqr7k71gw1qqfA8lpLop0N5JlvrC45C0UXh7XLFof1W3EGCzx
         6dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0BuRmGZKoOY5XfD4AJjW5pTpDGMeN228GKmYi+Vi1Tc=;
        b=XyF1PDzIWLI1X7c8Lv3n5lyE112Wnl+w5BGHEyCU4snTw/HRwbG+Y55aM6hoqqNaXB
         CF5d6UaZPYJxfSJMbmq2piKy8xCsopGoYvRVaIWtDjp1Ne+ITxQJijiVYCP8wT4XdZwH
         LfnBEgsVfYsMiT7boN6a05YsVEFlh3d9RYVqemdeQDV9xrqTON7woWJi/44Zg8F/sc8N
         yZkGIdoglqSMJpqMDEhdeQp73ARxU+rL9wkMqzjs8h8dQ1BWEo5EyLKaZpF7SWY6IlD1
         5aPGoYik+wYEh8gUul6L9hyTDh47xxbLk7m2fa8zmnM07e2Ow6vON4az987jxv9XxOp7
         RThA==
X-Gm-Message-State: AOAM5301U4s2p8+aIlyBFQKA6nsaCv5ApbsICTwyZ2LpLXADPwls0Q+u
        l2FY7oVzCQEK/L/SA44gwF/CNXOhxP0VwVJAUVwvaY0oD4sDkwCPuzQ8QisrWjh1DR7htkv8oBa
        X3VTQv1hQCmNjgCqPoMbEP0gkMoslKDKuysH8TwKU7vO7G9CyRnkE6WgOJ0wihH2B1XxkJDD2/w
        ==
X-Google-Smtp-Source: ABdhPJyqgPoy3LbjarlnGCQiHV2ULg5EpEtjcMRSzFB1DboVgo3SjD6HCntmrGvLhgvrmCcHnIg1S+pwXXRatZolTI0=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:e752:: with SMTP id
 e79mr8684278ybh.373.1615428693672; Wed, 10 Mar 2021 18:11:33 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:24 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-25-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 24/37] receive-pack: convert push-to-checkout hook to hook.h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using hook.h instead of run-command.h to invoke push-to-checkout,
hooks can now be specified in the config as well as in the hookdir.
push-to-checkout is not called anywhere but in builtin/receive-pack.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  1 +
 builtin/receive-pack.c     | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index e5c2cef271..f2178dbc83 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -555,6 +555,7 @@ that switches branches while
 keeping the local changes in the working tree that do not interfere
 with the difference between the branches.
 
+Hooks executed during 'push-to-checkout' will not be parallelized.
 
 pre-auto-gc
 ~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d26040c477..234b70f0d1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -29,6 +29,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "hook.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -1435,12 +1436,19 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt;
+	run_hooks_opt_init_sync(&opt);
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks(push_to_checkout_hook, &opt)) {
+		run_hooks_opt_clear(&opt);
 		return "push-to-checkout hook declined";
-	else
+	} else {
+		run_hooks_opt_clear(&opt);
 		return NULL;
+	}
 }
 
 static const char *update_worktree(unsigned char *sha1, const struct worktree *worktree)
@@ -1464,7 +1472,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook, HOOKDIR_USE_CONFIG))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
-- 
2.31.0.rc2.261.g7f71774620-goog

