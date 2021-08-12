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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307DEC4320A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFAA60FC3
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhHLAnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 20:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhHLAnp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 20:43:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D9C061799
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:21 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 12-20020ac8570c0000b029029624d5a057so2264519qtw.12
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NcExMpBskBtD+KGM4GW9neOABzmjEoIy2WzFCzlO9to=;
        b=WsQ//w4/8vD5T+x3PgHlUNvEGAyczi1KTXbx2/OamJ59SdViUc17FvA0bIFCsvpcYd
         cuQnrWYwF3Sb5/vJ89eQp1zw/Tvkzy76UDF4XwcwQS634bmfrY46pwfY3JTflPO35TSQ
         MhzF6Gp961iSvFAtwOtXa/N5YRkGZ8v7Qrd4EUbL6g4oTmVJjxfmZuFq7rN6JeFQtune
         6CTpl0L3NYVdlV60+0U+OyXKa65X2YJ3mSQ2G0MSSywjUZxbLGeUXlU4mGqEMUqy/WKb
         mUSjNY/gFapQAlnZMzMe15TYWZ4KR+VLxrlOJsOEpGswyX75B1ctzAGnqsUEIQFhi6AJ
         GTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NcExMpBskBtD+KGM4GW9neOABzmjEoIy2WzFCzlO9to=;
        b=PWR5FSnnSTHoque8lhRQQ7fdQmxJBIZNB2q3wa7AqxGyj29jCL7041voUQ8lAAZlaF
         9mhNjE96pkC/+ZcXbHkXIZXV2xBQs/RML2w0XRQF+KCOq+h1U9+9qTNo2AC5t4oraMsJ
         0fnd1uKNS6Dha7PPbFp87hQBYlsTLbghcraxzaw9Sug7QBdpwfKbA5j+lFCRlC3wReFv
         5vzhkTQ3IyyK8KZSBU85WYT36nShlzp7QFWaR45EtYMTxrPWC29aVjNJQxPrMun0U6mY
         nBtXCuhP7wZFsK9JgktXyYm+QyHP3WxSCygN65d950BkDzVjVxtbEQTeolX2KsGBHG5O
         3LLw==
X-Gm-Message-State: AOAM532gU2YT85WLlrl8unCuAMkSUR7U1xpqax7p6XdaDwy/odEEgglk
        6dVx/FDlLd3J0ngSspGLpQe8x+a67TXVAHKCiNwnrR2LlbuTU+6fUc3JlOggBVywKZzaZT4zvHb
        4BpVpRaQJEzTH03UtdY0TVzbHgrNPDRMmjqxGnfKTWcYACq5yjyBpdiwZbjWG4//ZabhP95+eBQ
        ==
X-Google-Smtp-Source: ABdhPJx4pEIQZvYKY2AJKL3a771PylLhGZukMwrwtRnqYpA1jFEfM+MfMrNzTnz4XqD7oZN1MnFjLejteqNyqDE+Go0=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:5182:: with SMTP id
 kl2mr1323830qvb.19.1628729000282; Wed, 11 Aug 2021 17:43:20 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:42:56 -0700
In-Reply-To: <20210812004258.74318-1-emilyshaffer@google.com>
Message-Id: <20210812004258.74318-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210812004258.74318-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 4/6] hook: allow running non-native hooks
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
 Documentation/git-hook.txt |  8 ++++++++
 builtin/hook.c             |  4 ++--
 hook.c                     | 32 ++++++++++++++++++++++++++++----
 hook.h                     | 16 +++++++++++++++-
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 8bf82b5dd4..11a8b87c60 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -18,6 +18,14 @@ This command is an interface to git hooks (see linkgit:githooks[5]).
 Currently it only provides a convenience wrapper for running hooks for
 use by git itself. In the future it might gain other functionality.
 
+It's possible to use this command to refer to hooks which are not native to Git,
+for example if a wrapper around Git wishes to expose hooks into its own
+operation in a way which is already familiar to Git users. However, wrappers
+invoking such hooks should be careful to name their hook events something which
+Git is unlikely to use for a native hook later on. For example, Git is much less
+likely to create a `mytool-validate-commit` hook than it is to create a
+`validate-commit` hook.
+
 SUBCOMMANDS
 -----------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index c36b05376c..3aa65dd791 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -46,7 +46,7 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	hookname = argv[0];
 
-	head = hook_list(hookname);
+	head = hook_list(hookname, 1);
 
 	if (list_empty(head)) {
 		printf(_("no commands configured for hook '%s'\n"),
@@ -108,7 +108,7 @@ static int run(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	hook_name = argv[0];
-	hooks = hook_list(hook_name);
+	hooks = hook_list(hook_name, 1);
 	if (list_empty(hooks)) {
 		/* ... act like run_hooks_oneshot() under --ignore-missing */
 		if (ignore_missing)
diff --git a/hook.c b/hook.c
index 2714b63473..e5acd02a50 100644
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
@@ -93,10 +102,16 @@ int hook_exists(const char *name)
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
@@ -104,6 +119,11 @@ struct list_head* hook_list(const char* hookname)
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
@@ -299,7 +319,11 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
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
index 4f90228a0c..ffa96c6e4d 100644
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
@@ -32,8 +40,14 @@ struct hook {
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
 
 struct run_hooks_opt
 {
-- 
2.32.0.605.g8dce9f2422-goog

