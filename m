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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59956C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7D064FAA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCKCLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhCKCLH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8DFC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s187so23864319ybs.22
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Kk5R8aI97X58ZOVmCowISGPjO//7aBJKSYMp9czi5eo=;
        b=q6Zh50j3PUsTiZSgv4Mbm8ZrBy04yoLi/Zto6bVu20Fs2Gpk17KqsSG50dZnQLzvHn
         H8WGOKucfLYk94fq1oxSnon55al470KDnMxbCA6zF3k/4iUTXYKeNs8mDfKDiNt/skn6
         KR/ippUBmm03zLLgw/fyytgvgt32QsQd62FevU3rL9nzJD9sxLs4yrPoeAaFF+L+c038
         t850ZwA3ekO0Nm+KHowr3wKl30+x96fkjNhyJmCkKOunzGG7tICjxCGr8Ya5ep1o8uLw
         S4CMNlVaHZNPuR2q/Uk1VkZE1WalG7j4MwfP8fpVlJVacccfDIeClzDjHxA0yHFRkk0p
         ehIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Kk5R8aI97X58ZOVmCowISGPjO//7aBJKSYMp9czi5eo=;
        b=iBsqGcvh8RFpwqaQFR8F2mdQNLs3cyHIG9ZYRRqiOpArqNtNXlyuY6immdqyv3MUCW
         I7F88HBsl1vqbDXL8wBGFjz30kbjgmNKNWxOuHXruHJ2rU7fdKvI0CHP4faSdVVkFPdz
         2OcmlWyXOWnnVIiQw7tcNvpVwxioXmGrXCiCNSUHMC301TiS9Hm3FbDEgWqFqbDYngSd
         t39pu/7ztr/DHQShUsEiS7W5Gi3gd/Ukam4Dt0bRJ/KKcn5qKBxPI36Mbck5mUo7TooI
         nwTB/X0Hf+iwST85rcKo7Z1UT64YgMAuohRvYPTDEFsVz3mrCmpUJl/vw8VL9CMnE1me
         BDmg==
X-Gm-Message-State: AOAM531jqYJcCCa3bGKqhmSruKWRbmgEBEFqVUMJgz0MQ1ciGWG0xCb0
        ZuezndJv0nqptyM9aE9Gc9yAuvY1IfWYtPBNt57RpjNA23sYRx7H6oZvVKWmUm/k0a+X+ySrLQ3
        sGe0ED6c0IrjkYu/H08YUElmyQGvNxWj1uhn14dTFB1FoHQ0nRPVQAIFCHYaL++iev64T1t/1sA
        ==
X-Google-Smtp-Source: ABdhPJzBeKtLyAo8DyERj2K9Pb3jlsYgf+c9iX8NX3QHXrEm3Ke7zXxi6pP8NpptOSTIYXJPoNEp6iXachRznZ9czhQ=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:c943:: with SMTP id
 z64mr8644906ybf.73.1615428666931; Wed, 10 Mar 2021 18:11:06 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:09 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 09/37] hook: introduce hook_exists()
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper to easily determine whether any hooks exist for a given
hook event.

Many callers want to check whether some state could be modified by a
hook; that check should include the config-based hooks as well. Optimize
by checking the config directly. Since commands which execute hooks
might want to take args to replace 'hook.runHookDir', let
'hook_exists()' take a hookdir_opt to override that config.

In some cases, external callers today use find_hook() to discover the
location of a hook and then run it manually with run-command.h (that is,
not with run_hook_le()). Later, those cases will call hook.h:run_hook()
directly instead.

Once the entire codebase is using hook_exists() instead of find_hook(),
find_hook() can be safely rolled into hook_exists() and removed from
run-command.h.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 hook.c | 19 +++++++++++++++++++
 hook.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/hook.c b/hook.c
index d166d17fb0..118931f273 100644
--- a/hook.c
+++ b/hook.c
@@ -243,6 +243,25 @@ void run_hooks_opt_init(struct run_hooks_opt *o)
 	o->run_hookdir = configured_hookdir_opt();
 }
 
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
+{
+	const char *value = NULL; /* throwaway */
+	struct strbuf hook_key = STRBUF_INIT;
+	int could_run_hookdir;
+
+	if (should_run_hookdir == HOOKDIR_USE_CONFIG)
+		should_run_hookdir = configured_hookdir_opt();
+
+	could_run_hookdir = (should_run_hookdir == HOOKDIR_INTERACTIVE ||
+				should_run_hookdir == HOOKDIR_WARN ||
+				should_run_hookdir == HOOKDIR_YES)
+				&& !!find_hook(hookname);
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
+
+	return (!git_config_get_value(hook_key.buf, &value)) || could_run_hookdir;
+}
+
 void run_hooks_opt_clear(struct run_hooks_opt *o)
 {
 	strvec_clear(&o->env);
diff --git a/hook.h b/hook.h
index c24b2c9ecd..0df785add5 100644
--- a/hook.h
+++ b/hook.h
@@ -23,6 +23,7 @@ struct list_head* hook_list(const struct strbuf *hookname);
 
 enum hookdir_opt
 {
+	HOOKDIR_USE_CONFIG,
 	HOOKDIR_NO,
 	HOOKDIR_ERROR,
 	HOOKDIR_WARN,
@@ -56,6 +57,15 @@ struct run_hooks_opt
 void run_hooks_opt_init(struct run_hooks_opt *o);
 void run_hooks_opt_clear(struct run_hooks_opt *o);
 
+/*
+ * Returns 1 if any hooks are specified in the config or if a hook exists in the
+ * hookdir. Typically, invoke hook_exsts() like:
+ *   hook_exists(hookname, configured_hookdir_opt());
+ * Like with run_hooks, if you take a --run-hookdir flag, reflect that
+ * user-specified behavior here instead.
+ */
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
+
 /*
  * Runs all hooks associated to the 'hookname' event in order. Each hook will be
  * passed 'env' and 'args'.
-- 
2.31.0.rc2.261.g7f71774620-goog

