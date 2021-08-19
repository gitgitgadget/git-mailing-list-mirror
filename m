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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFDC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2E96044F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhHSDfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbhHSDfj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 23:35:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F0AC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:35:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w200-20020a25c7d10000b02905585436b530so5170984ybe.21
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MhcElDgVfxqxQXJUv/XWqEOJuiEDABBTKckPBWruKLs=;
        b=fWM2d8Uhkm94TzPlKA9RCffKogIsOe3sKnOqiKiXxckuDwiHAHbZPSe8Xq9aDWE1yJ
         04k5aMYbD3kNa7daZTokhUPrVQep1mXNLxPbPW+aEhBzlhRCudlBge4J2wHnxQUHFcEz
         EUT8/Q45j48m/CEvcxRcjQKT0AxdTiDJUYmghVb9nUWWMpjuNGlv9Sj6WnJe4OVL2F8A
         SK1Nrgofcc72+gQoLmXLHfg++m3Bpbp3gvdAefNGTXaqbWcl5kMszIoSbp6TeMcbkfAz
         QK0gyRfBLx/QAihwZW7Qx/1Cmrxe52JaRR7lhpHd2BkH+5CLb3qf/N38F0bzRzUHR7Jp
         Spvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MhcElDgVfxqxQXJUv/XWqEOJuiEDABBTKckPBWruKLs=;
        b=k8sp9+cnnpLKIe3Lo2yPsnXG7uy0gJMIws/YSB0AU1Yw7x63vZHNn0FzgjNo11b/3u
         ibjxZAYzy1imv/5z6XF3Nt6koXFwZd/57G3O1xJY4A8ahnfESZrWw2YseXIm5/saVkCN
         fdFHXY4TY3GfQjtJIuHn/zeB4o0RSux10eIrJcy2io9zVVHXdQfEndF+iJyNUUIsXgZl
         kxkddAg1zVFbL0nBTPbZfZiVDj0Ba04ZbOQKBPWjS6+kyS4PPuyqcw4QzYLK5tP9raEs
         b6yGlI9ifXgEahdOW2q2H0Cb6biZ7gyTLtZrrXZJb5hTgYNEN/Li59ups+95kw33t88I
         1arg==
X-Gm-Message-State: AOAM532gSTsyQ8zXLrut1epMFV1leLeIQFt91nkv3WiraKVXms9y7cZu
        JrKzi47Hus2vxfxCHPE9ypaeUTTzJ5hYOLs1/AF8bEjHvcGcyD+TvkvqAYyzctUQqQ+ZbzILJBI
        /Z3jK2kGTYhIM09QOpJbvxJnOSaY9p5gOENUaO/ZQKOFyahG6umcGgmO6AsMsGwM6q3c/56s9Jw
        ==
X-Google-Smtp-Source: ABdhPJxnJT/xc4ShgNTd+GZHVzinUwT7y/mgnUM5f7UTdd40iJhgqGgF4yeNSgJdVXUdZdtwzVezE6oDXE2db6oYDwo=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:824b:: with SMTP id
 d11mr16210214ybn.361.1629344103032; Wed, 18 Aug 2021 20:35:03 -0700 (PDT)
Date:   Wed, 18 Aug 2021 20:34:48 -0700
In-Reply-To: <20210819033450.3382652-1-emilyshaffer@google.com>
Message-Id: <20210819033450.3382652-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819033450.3382652-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 4/6] hook: allow running non-native hooks
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
 hook.c                     | 35 +++++++++++++++++++++++++++++++----
 hook.h                     | 14 ++++++++++++++
 4 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 701ada9fc0..d1db084e4f 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -19,6 +19,14 @@ This command is an interface to git hooks (see linkgit:githooks[5]).
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
index d21f303eca..80397d39f5 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -46,7 +46,7 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	hookname = argv[0];
 
-	head = hook_list(hookname);
+	head = list_hooks_gently(hookname);
 
 	if (list_empty(head))
 		return 1;
@@ -105,7 +105,7 @@ static int run(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	hook_name = argv[0];
-	hooks = list_hooks(hook_name);
+	hooks = list_hooks_gently(hook_name);
 	if (list_empty(hooks)) {
 		/* ... act like run_hooks_oneshot() under --ignore-missing */
 		if (ignore_missing)
diff --git a/hook.c b/hook.c
index b1ea372e15..ab1e86ddcf 100644
--- a/hook.c
+++ b/hook.c
@@ -51,12 +51,21 @@ static int known_hook(const char *name)
 
 const char *find_hook(const char *name)
 {
-	static struct strbuf path = STRBUF_INIT;
+	const char *hook_path;
 
 	if (!known_hook(name))
-		die(_("the hook '%s' is not known to git, should be in hook-list.h via githooks(5)"),
+		BUG(_("the hook '%s' is not known to git, should be in hook-list.h via githooks(5)"),
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
@@ -92,10 +101,24 @@ int hook_exists(const char *name)
 	return !list_empty(list_hooks(name));
 }
 
+struct hook_config_cb
+{
+	struct strbuf *hook_key;
+	struct list_head *list;
+};
+
 struct list_head *list_hooks(const char *hookname)
 {
-	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
+	if (!known_hook(hookname))
+		BUG("Don't recognize hook event '%s'! "
+		    "Is it documented in Documentation/githooks.txt?",
+		    hookname);
+	return list_hooks_gently(hookname);
+}
 
+struct list_head *list_hooks_gently(const char *hookname)
+{
+	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
 
 	INIT_LIST_HEAD(hook_head);
 
@@ -103,7 +126,7 @@ struct list_head *list_hooks(const char *hookname)
 		BUG("null hookname was provided to hook_list()!");
 
 	if (have_git_dir()) {
-		const char *hook_path = find_hook(hookname);
+		const char *hook_path = find_hook_gently(hookname);
 		if (hook_path) {
 			struct hook *to_add = xmalloc(sizeof(*to_add));
 			to_add->hook_path = hook_path;
@@ -299,6 +322,10 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("choose only one method to populate stdin");
 
+	/*
+	 * 'git hooks run <hookname>' uses run_hooks, so we don't need to
+	 * allow unknown hooknames here.
+	 */
 	hooks = list_hooks(hook_name);
 
 	/*
diff --git a/hook.h b/hook.h
index cd3123d290..6b7b2d14d2 100644
--- a/hook.h
+++ b/hook.h
@@ -9,8 +9,16 @@
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
  * overwritten by further calls to find_hook and run_hook_*.
+ *
+ * If the hook is not a native hook (e.g. present in Documentation/githooks.txt)
+ * find_hook() will BUG(). find_hook_gently() does not consult the native hook
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
+ * list_hooks() checks the provided hookname against Documentation/githooks.txt
+ * and BUG()s if it is not found.  list_hooks_gently() allows any hookname. The
+ * latter should only be used when the hook name is provided by the user, and
+ * the former should be used by internal callers.
  */
 struct list_head *list_hooks(const char *hookname);
+struct list_head *list_hooks_gently(const char *hookname);
 
 struct run_hooks_opt
 {
-- 
2.33.0.rc2.250.ged5fa647cd-goog

