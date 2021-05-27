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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D5C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3C9613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhE0AMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhE0AL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AE1C061351
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v184-20020a257ac10000b02904f84a5c5297so3633345ybc.16
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iLOtjpzDnEaWUXWYBndYmwd+SM1Z7rlGSIHzSaeSOSM=;
        b=Pg1uVs/b5OhtBq4YKVNDQVz2eHh7ejeSNgZol5R/XBPPwQ9Eo9gF4htjraSbAQg3zB
         skooIxu2unTxTlSqINTlQF+VXZv4UbIQgSk3UGi4O1qFBG/BkaAZ2BDyGM4FLAlfN0WJ
         ZG8wlRG2xKHAJ4+WggaHT4mt+a6QEKYNrCIYBUafPV4dneFzpEu1qAVxq4r0M1AhejQk
         0SxmYPqnzpY+zemjdsbZWHIN1IMi8NhxgSdE93rWZq+9qOharjqihL5pl0lqQUDz0REZ
         jKUJsN/Qg+lzyTzaY7em5JfRVNPTxem8EfJiKdphGtkMkahwwpWJ/vmQdRM0vcukLPdc
         v3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iLOtjpzDnEaWUXWYBndYmwd+SM1Z7rlGSIHzSaeSOSM=;
        b=G3NyDcQOu8eI1nrWw6/5T7aDOMGYZBh37dcvpNwieig8RYbRBV8NIdEr6zMget8vKi
         ibJT+xJTgzaVm3Xjs3ZUphwyzNbeqKTYkVziuigvqAJWGppurGLqtlAXvybgdcBwJnkw
         eW3+97VU/1kNp5slDbPbXKQL+L6TmPNAbMNk8VRVli0ZW8Sp22KjXAFi7ey37VhdBGHp
         gwechq7bFyKC7RClJHKSoWjfTcru9fztkLb+E+LyvlcvFsMKN3xdmFS21zE0NYH2CPcr
         IDk5wI+6C4MRz8QZdPaoUDWO/LW2oJMa4V/l5Y18N7Ln17qF4OaGsSq5Hm0Zpkekd9yY
         ms+Q==
X-Gm-Message-State: AOAM530QmW6luCTdM8jY6K9+UHGG5u7C/d0kYCDFlXziDBDwZvaarh10
        4CCx+NalC++OTwgA0lFdHXUhucYcWl6sEZRC8zDSmrugGVfvEtX4ktJwN6IRCsjg8fExlVbkFhq
        zRLMv0VvHyAi+S5fc9Jec0ox9c9lkmwvLxzyYmKCFyFIBW5UgYC4A4mi/XYG/Hn8VUONnDybAQw
        ==
X-Google-Smtp-Source: ABdhPJwJaDJaqlAzrzVWw878c+lU3yG2D7bBSRUDFy6Zd9oO9I9ahzOLr/gC0gdp9akoY2DjO8qfr8CERsXcxWW55HI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:a1c4:: with SMTP id
 a62mr866486ybi.338.1622074185655; Wed, 26 May 2021 17:09:45 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:42 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-24-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 23/37] receive-pack: convert push-to-checkout hook to hook.h
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
 builtin/receive-pack.c     | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 5efa25a44a..17ffeebf07 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -564,6 +564,7 @@ that switches branches while
 keeping the local changes in the working tree that do not interfere
 with the difference between the branches.
 
+Hooks executed during 'push-to-checkout' will not be parallelized.
 
 pre-auto-gc
 ~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a34742513a..09e7cdee45 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -29,6 +29,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "hook.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -1435,12 +1436,20 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt;
+
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
@@ -1464,7 +1473,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook, HOOKDIR_USE_CONFIG))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
-- 
2.31.1.818.g46aad6cb9e-goog

