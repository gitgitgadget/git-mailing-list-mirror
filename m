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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D98C636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1345613E0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhGOX3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhGOX3O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23611C061765
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l16-20020a25cc100000b0290558245b7eabso9978935ybf.10
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7qD2dtDQL5PfOC9r3c8WSXtT4kn85mpZVZ6BF1ffvyg=;
        b=cnIfQSDoU4ghmsPrzjKQWCWiqaMLRgvl0656ssWomyQTJhHyLGSiVvfE8slzYEJusP
         eSs83BZdaZaQTC3dS2EiRev8JOPR0AeX3JNLdSr6REiDN0ezKP8tkwUjKnt8mkaX+lmH
         zLLLIJigqSf4EbgI+mSzdlUGmpAvW677MiROf8J84BJ6cLJ9Jjo+nqMno7jER58eBJUx
         /dOYm+Z/JMljswJkGG1U9Z+3VlVQuFBygQ3XmcmobbR+yfWFSOaWIOq7BHZXLobMmNVI
         Kwte54mYFi7iS7vQrQmG1zaahLxplg9xMhdXweRKerklVwCHE2e39hPIuVJEqGcg9jeX
         ZBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7qD2dtDQL5PfOC9r3c8WSXtT4kn85mpZVZ6BF1ffvyg=;
        b=I+2K3fL4To4M7mJ7h8YAEEXOY3YOWnz4lydv5in9h+XOnyXQzZi5Goi4CGhO5bx2LO
         3exNo6CX7VX4EmRzfCizJ0nGrEgJiuMtQFoAb4v0VYz8sFyEePeyS3xp9K9tHrUjLwsD
         +4gqwKpMHeOj8CwPPjLCdEnAWl3R+ACUCsK3crpjUR6cMyxybm9O3N9LK4YRdxAbSH4o
         LAwUlr2GfI4Yco04IffKpp1gq2xtasuC3KdttoG/lSNJtO9tyGC/7+JGYSGSaaaNa7wJ
         QPRue7g6YN90ocG2UrAsPYi0UVXcyJowZL4FErfYB/VG86CvxPgBKihhaBfECLZaTZ2k
         HoQQ==
X-Gm-Message-State: AOAM530rqIFJaXC6gFO5RfnvCqQxzkiayHH0yMNqM3j9rJFi9VcyVzN1
        DmHrRuJqeR0sP3WbjZlRapjkpJb6coEkJeRsGPy5OnxF08iqbZXtefSl0jHwzjq0nAnNJaeoE8x
        B5PlyEiZohxgW/IqN0I/BF5oSsv4bOwdoVAgfmTszp67dWEAYxESLcw0hvPterlidx69kZArAVw
        ==
X-Google-Smtp-Source: ABdhPJxWDm9WvlfJDf5O4LiULa3mDSWCrJqrOA3khGQTe0fRRfPOFr0nPn1bQiXHrlfZ4ApVLpcW4qI4EvkrF9ULDm8=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:a25:2484:: with SMTP id
 k126mr9345976ybk.344.1626391579300; Thu, 15 Jul 2021 16:26:19 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:25:59 -0700
In-Reply-To: <20210715232603.3415111-1-emilyshaffer@google.com>
Message-Id: <20210715232603.3415111-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 5/9] hook: allow running non-native hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the hook architecture and 'git hook run' become more featureful, we
may find wrappers wanting to use the hook architecture to run their own
hooks, thereby getting nice things like parallelism and idiomatic Git
configuration for free. Enable this by letting 'git hook run' bypass the
known_hooks() check.

We do still want to keep known_hooks() around, though - by die()ing when
an internal Git call asks for run_hooks("my-new-hook"), we can remind
Git developers to update Documentation/githooks.txt with their new hook,
which in turn helps Git users discover this new hook.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/hook.c |  4 ++--
 hook.c         | 32 ++++++++++++++++++++++++++++----
 hook.h         | 16 +++++++++++++++-
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 8340c8c9a8..b08f9c9c4f 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -39,7 +39,7 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	hookname = argv[0];
 
-	head = hook_list(hookname);
+	head = hook_list(hookname, 1);
 
 	if (list_empty(head)) {
 		printf(_("no commands configured for hook '%s'\n"),
@@ -103,7 +103,7 @@ static int run(int argc, const char **argv, const char *prefix)
 	 * run_found_hooks() instead...
 	 */
 	hook_name = argv[0];
-	hooks = hook_list(hook_name);
+	hooks = hook_list(hook_name, 1);
 	if (list_empty(hooks)) {
 		/* ... act like run_hooks() under --ignore-missing */
 		if (ignore_missing)
diff --git a/hook.c b/hook.c
index 3a588cb055..e1cf035022 100644
--- a/hook.c
+++ b/hook.c
@@ -52,12 +52,21 @@ static int known_hook(const char *name)
 
 const char *find_hook(const char *name)
 {
-	static struct strbuf path = STRBUF_INIT;
+	const char *hook_path;
 
 	if (!known_hook(name))
 		die(_("the hook '%s' is not known to git, should be in hook-list.h via githooks(5)"),
 		    name);
 
+	hook_path = find_hook_gently(name);
+
+	return hook_path;
+}
+
+const char *find_hook_gently(const char *name)
+{
+	static struct strbuf path = STRBUF_INIT;
+
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0) {
@@ -101,10 +110,16 @@ int hook_exists(const char *name)
 	return !!find_hook(name);
 }
 
-struct list_head* hook_list(const char* hookname)
+struct hook_config_cb
+{
+	struct strbuf *hook_key;
+	struct list_head *list;
+};
+
+struct list_head* hook_list(const char* hookname, int allow_unknown)
 {
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
-	const char *hook_path = find_hook(hookname);
+	const char *hook_path;
 
 
 	INIT_LIST_HEAD(hook_head);
@@ -112,6 +127,11 @@ struct list_head* hook_list(const char* hookname)
 	if (!hookname)
 		return NULL;
 
+	if (allow_unknown)
+		hook_path = find_hook_gently(hookname);
+	else
+		hook_path = find_hook(hookname);
+
 	/* Add the hook from the hookdir */
 	if (hook_path) {
 		struct hook *to_add = xmalloc(sizeof(*to_add));
@@ -291,7 +311,11 @@ int run_hooks(const char *hook_name, struct run_hooks_opt *options)
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("choose only one method to populate stdin");
 
-	hooks = hook_list(hook_name);
+	/*
+	 * 'git hooks run <hookname>' uses run_found_hooks, so we don't need to
+	 * allow unknown hooknames here.
+	 */
+	hooks = hook_list(hook_name, 0);
 
 	/*
 	 * If you need to act on a missing hook, use run_found_hooks()
diff --git a/hook.h b/hook.h
index 60389cd8cd..2559232880 100644
--- a/hook.h
+++ b/hook.h
@@ -9,8 +9,16 @@
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
  * overwritten by further calls to find_hook and run_hook_*.
+ *
+ * If the hook is not a native hook (e.g. present in Documentation/githooks.txt)
+ * find_hook() will die(). find_hook_gently() does not consult the native hook
+ * list and will check for any hook name in the hooks directory regardless of
+ * whether it is known. find_hook() should be used by internal calls to hooks,
+ * and find_hook_gently() should only be used when the hookname was provided by
+ * the user, such as by 'git hook run my-wrapper-hook'.
  */
 const char *find_hook(const char *name);
+const char *find_hook_gently(const char *name);
 
 /*
  * A boolean version of find_hook()
@@ -34,8 +42,14 @@ struct hook {
 /*
  * Provides a linked list of 'struct hook' detailing commands which should run
  * in response to the 'hookname' event, in execution order.
+ *
+ * If allow_unknown is unset, hooks will be checked against the hook list
+ * generated from Documentation/githooks.txt. Otherwise, any hook name will be
+ * allowed. allow_unknown should only be set when the hook name is provided by
+ * the user; internal calls to hook_list should make sure the hook they are
+ * invoking is present in Documentation/githooks.txt.
  */
-struct list_head* hook_list(const char *hookname);
+struct list_head* hook_list(const char *hookname, int allow_unknown);
 
 /* Provides the number of threads to use for parallel hook execution. */
 int configured_hook_jobs(void);
-- 
2.32.0.402.g57bb445576-goog

