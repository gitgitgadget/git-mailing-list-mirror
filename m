Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A171C4320A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B6060F21
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhHLAnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 20:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhHLAnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 20:43:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67E4C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p71-20020a25424a0000b029056092741626so4401496yba.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IPOe1lVJUuzg+pKRFhPkoKYvVHa9Jh4RzFXsyTEsGmE=;
        b=Vi3TkfDHj6Z17uv8XSXQZ0xBIlOZp9HnnewdSa1HxvkA4lITyNJJ3e1cDzlfwWxaL6
         md1tI7EYJ/b68Ii+QLNElGxWTuokQS0ZkTwoyxaBskPB+tWlNf2EKN+a1F2/yuB1e0Mu
         xYzLgFPqMlV2UlS52NDYgJynb9uk9lHMeDlk98x+7E7hcOApARvdoRR9e0cpzOTas9Rv
         dbf/VyDfYypXmNklAuKf/C4afnAeKQu0Qj9Xa74U1oK/s2nPxQWBg+GvgwyAy5rpIw7o
         ApprEUzdOMkWKX5X0OOr91Ng9XRyf08DrfE2EHR95R5qMPNH70vDXob2Na3vtoJxiUEX
         XCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IPOe1lVJUuzg+pKRFhPkoKYvVHa9Jh4RzFXsyTEsGmE=;
        b=jKvU5w/ZIFAeuPkKXwYiUkxlSwwyNojJV9sX7Moziy7vfQ5EElpWP/GC6U6gGDyMmL
         QKTsswoAun+M5BhXHVNuKoD61WqxFaV581QXosY/KYlKqGqcKF+HiRBHSjS34KWAKvFq
         pUnuuhRl3Gu0x3imWWpW26zrQ+Ssj9EagCyg986WXjpyh8HZ/7EwtQ31cOZpuE0fautc
         7ut4SBe7xvyu0S7MQjOCe5KVGXZJeWZow3HzgAVJJScQcICzSFpkCMgZlRnNoirSHD2J
         9xoDL4CCmUZ77vsNzdbQRqf8VteaGQ4qveoliVtkNGfOiR0+HHPttBVHyUf94HYM1stR
         lthA==
X-Gm-Message-State: AOAM530e7l/Lx5yB/VrASH/llO/5hOBbDu8txxh0a8GEs/zr2e2MOSDi
        xxCmCCdAoSJmGMPhLnum7APtU9VKkAPNCP4qKh5+lLXPY77rCMiUoP8mx7K/C3a6PtOSQaaXf1l
        NnWa4JqxOsMDvbwNxe5C9wH5sM641Qph0TjM8jhpxEq/NnBKrssaW04i7jYfH6GUcM6cSoIqRkw
        ==
X-Google-Smtp-Source: ABdhPJytQn3ztoGwgfuFBiNwzQ03q6gFeHsdO/+OX8pWvatJ4usaq070ZmtdyDY+XI0xeWWh7Bk3cc6CS4FF9mJUlLw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
 (user=emilyshaffer job=sendgmr) by 2002:a25:374d:: with SMTP id
 e74mr975509yba.130.1628729005023; Wed, 11 Aug 2021 17:43:25 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:42:58 -0700
In-Reply-To: <20210812004258.74318-1-emilyshaffer@google.com>
Message-Id: <20210812004258.74318-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210812004258.74318-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 6/6] hook: allow out-of-repo 'git hook' invocations
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since hooks can now be supplied via the config, and a config can be
present without a gitdir via the global and system configs, we can start
to allow 'git hook run' to occur without a gitdir. This enables us to do
things like run sendemail-validate hooks when running 'git send-email'
from a nongit directory.

It still doesn't make sense to look for hooks in the hookdir in nongit
repos, though, as there is no hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    For hookdir hooks, do we want to run them in nongit dir when core.hooksPath
    is set? For example, if someone set core.hooksPath in their global config and
    then ran 'git hook run sendemail-validate' in a nongit dir?

 git.c           |  2 +-
 hook.c          |  2 +-
 t/t1800-hook.sh | 20 +++++++++++++++-----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/git.c b/git.c
index 540909c391..39988ee3b0 100644
--- a/git.c
+++ b/git.c
@@ -538,7 +538,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
-	{ "hook", cmd_hook, RUN_SETUP },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
index 51ada266bc..87d57f4118 100644
--- a/hook.c
+++ b/hook.c
@@ -215,7 +215,7 @@ struct list_head* hook_list(const char *hookname, int allow_unknown)
 
 	/* Add the hook from the hookdir. The placeholder makes it easier to
 	 * allocate work in pick_next_hook. */
-	if (find_hook_gently(hookname))
+	if (have_git_dir() && find_hook_gently(hookname))
 		append_or_move_hook(hook_head, NULL);
 
 	return hook_head;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index ef2432f53a..a7e45c0d16 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -118,15 +118,25 @@ test_expect_success 'git hook run -- pass arguments' '
 	test_cmp expect actual
 '
 
-test_expect_success 'git hook run -- out-of-repo runs excluded' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	echo Test hook
-	EOF
+test_expect_success 'git hook run: out-of-repo runs execute global hooks' '
+	test_config_global hook.global-hook.event test-hook --add &&
+	test_config_global hook.global-hook.command "echo no repo no problems" --add &&
+
+	echo "global-hook" >expect &&
+	nongit git hook list test-hook >actual &&
+	test_cmp expect actual &&
+
+	echo "no repo no problems" >expect &&
 
-	nongit test_must_fail git hook run test-hook
+	nongit git hook run test-hook 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
 	mkdir my-hooks &&
 	write_script my-hooks/test-hook <<-\EOF &&
 	echo Hook ran $1 >>actual
-- 
2.32.0.605.g8dce9f2422-goog

