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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241F3C4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E372B22E00
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgLEBvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbgLEBvL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF2C08C5F2
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k196so9290797ybf.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+mnr8yMgYpEUZu44Y7m+nf6hxutdvOIMK3KN13V6zVA=;
        b=ZC38tXSpJetuysisfyHwaJf1MWcLpU7HC6MFfGM4m6XXya1W9R9bM0jKkDGz3MKveb
         CzYbXBS6QVfo8Rx+sh9cjDdqnAiJUCNlspUTrCzbiSUOXIoQZgqo2OfiRa6DyO6i5svy
         Qg/D0cw/bM/XmkpZ57JA7WCEC+LXfRnVNWyGWZxiOd5uxIawMAcUcqQWP1CiPrVeGHfX
         mZaIvViXvMUzaTGR4Tl7zj92Q99Pn4UZDBY2PEoAigsQRw/h4J/PG0CJRGSNQLZ8sLFJ
         COkWeYD3XmjAzdyrxpv81rI5hc/a2+LnT9kLQZSzmtjQ9XZC34wwci3ujubg+bnHpKPP
         s+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+mnr8yMgYpEUZu44Y7m+nf6hxutdvOIMK3KN13V6zVA=;
        b=OxItwfxq1dqBZFBvJ3GHFzTLxdbjpH2yxIYJWsXo62Sw7+T6GvNujvffuNlGSsyK+p
         okLI+xgqN8sod1R4ikYAGwSZ4v7/m0CrDRGsu3bEiGxa1Cpv+tldXYdldaOvbk9ukd2p
         YFlPq2giGsDzPfEZESOMYxzlwmtiq2pmqA5NIx7Fz44Z5fa+gC5s9PSkkMAZP2+jFuCV
         t62CX+a+/jJB8aMOKqRcDknTZOiQgygh5XyO+bOvKXfkEM2m2xKhYs3LISlA2Mzl09Q6
         zJDCtIChZNXVNMPV8Mo35byXjrPZ+Ysa/shUt/Q3yDdeuvxapyafn4MQ42BE4MtiSOo/
         G1xg==
X-Gm-Message-State: AOAM533FoETtlx2ptklj/ShGYKL7pL82lKMRzHGonrhkSruc/LuT2t9y
        VVjB+gD1L1QuF3hxTppJpJtirO/lQPa5x4U1NEpEiOUGjjdthaJzzhT0gNlnmcU2tbY2wfsxLg2
        4kIZ/BiCzjzR6aEH2IzHouI1uat6rMF5hjD81Rk+VlpGowQtxx0SPhamfZJ0Pg/mf9aeoKGq8uQ
        ==
X-Google-Smtp-Source: ABdhPJzNBnahfRdz7FWUAFXpbpdIAV2mnZBXjZ29pB65GqOsV0oFsWNl4JDssPWB6NULo7+N9xoOB/4wXlODRbSSx0M=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:497:: with SMTP id
 145mr3068755ybe.275.1607133003260; Fri, 04 Dec 2020 17:50:03 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:35 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 07/17] receive-pack: convert push-to-checkout hook to hook.h
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
 builtin/receive-pack.c     | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 8249ecec5f..8de512ee5d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -547,6 +547,7 @@ that switches branches while
 keeping the local changes in the working tree that do not interfere
 with the difference between the branches.
 
+Hooks executed during 'push-to-checkout' will not be parallelized.
 
 pre-auto-gc
 ~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f1f0f7bef6..d64a3076be 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -29,6 +29,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "hook.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -1427,12 +1428,18 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
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
@@ -1456,7 +1463,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook, configured_hookdir_opt()))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
-- 
2.28.0.rc0.142.g3c755180ce-goog

