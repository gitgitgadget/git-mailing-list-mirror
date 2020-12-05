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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30684C2BB48
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E05229C4
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbgLEBvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbgLEBvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:37 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EF4C08ED7E
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:22 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 141so7053298qkh.18
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3QYHXqQKW+jhRQyMmmXKWe0AW395ERpQXdVL/vuJUSQ=;
        b=USk0mthItq+PgYraVFJw/1YuMz41xjJiKbxPa57hI/KswEiMkq0KzgfokdVSHmjEwi
         FC1IMHfHG8qmMmuYHHKIttboPErIcNrxKQLQJuHD+iChmWWGaBhNgN2KmOSpZPjsUtai
         OxqoG6MZWfQa+/B6g6/MVB+zbxAC98SX0qHIPocnjI2ZJtFzWPWux3t7LANvzSrCBxYh
         GLhXzGvNYxS9URyZCeFegjWwgAkrWvmwCS6cfD7llXrhbdQuOhJcJfIhpXh64jR/AMwd
         Vv5HW/QEqyhJKd/zfm9FNgBd+JNSvlV2HfAJPdhXuT+J6trlRRCXx9XmZwFJ5qR0OdAt
         67sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3QYHXqQKW+jhRQyMmmXKWe0AW395ERpQXdVL/vuJUSQ=;
        b=Xpuo4jlqUOqTwpoVy/yvrFGnI25GSk56XgawnJSlJ0ddbumMLo5zIy5lHp5e4VLDiP
         nWOv9SlfzBTvGqwTw6m4eq+rD7U9eWkBc0ByUKcmdtvmXz+5tZm48claXNqXBRS6Iwqy
         pGqj7PiucMipSeodTBd6qCTbNEPof6k9vRxBCBpKSLt4YQ+A/GNlmZ1uHZqjZxG1Mmqm
         Ld3h2VG+D3mBXOrnCQNSgmk4JyQJCom0d5rIbGixgXYxg1Lkbr3hMeC67+thvtBptKz4
         noA/1XI7Cjl4vDI/LIT/B24MzazUK9PYJr23Y2HvSr+qEm53/1SJXwY4kn5CXqBDiLxE
         W9dg==
X-Gm-Message-State: AOAM532TJ6rBFv/BKLRRkuUAQZdcqSkiks+dYjAxAohZL0KhswHgwdy3
        2Xi10Glkc2pN6P/GY8I8fMu7HJwxdeTBHKtSNY2HsJBJUloKjRbVvtfwpBHG69g5dOhsY0q9Y2Q
        1g73pIU2r+YBrfNLUp2hRwPkzopNWXWGwfIxz9Mul4+d0KlGXXisABlx5VFnQsTcj6om8GIfgMQ
        ==
X-Google-Smtp-Source: ABdhPJzXHYzCZlwULEwKsbCwFvISA5lik5S6aZhbypFwRibr1brWqmXTn54rjCA99lpLjXqK/MpHo0+OMF2lldtGB4A=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:5762:: with SMTP id
 r2mr9118875qvx.45.1607133021919; Fri, 04 Dec 2020 17:50:21 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:45 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-18-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 17/17] run-command: stop thinking about hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hook.h has replaced all run-command.h hook-related functionality.
run-command.h:run_hooks_le/ve and find_hook are no longer used anywhere
in the codebase. So, let's delete the dead code - or, in the one case
where it's still needed, move it to an internal function in hook.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 hook.c        | 39 ++++++++++++++++++++++++++++--
 run-command.c | 66 ---------------------------------------------------
 run-command.h | 24 -------------------
 3 files changed, 37 insertions(+), 92 deletions(-)

diff --git a/hook.c b/hook.c
index 78d7721b74..85fd59865d 100644
--- a/hook.c
+++ b/hook.c
@@ -197,6 +197,41 @@ static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
 	}
 }
 
+static const char *find_legacy_hook(const char *name)
+{
+	static struct strbuf path = STRBUF_INIT;
+
+	strbuf_reset(&path);
+	strbuf_git_path(&path, "hooks/%s", name);
+	if (access(path.buf, X_OK) < 0) {
+		int err = errno;
+
+#ifdef STRIP_EXTENSION
+		strbuf_addstr(&path, STRIP_EXTENSION);
+		if (access(path.buf, X_OK) >= 0)
+			return path.buf;
+		if (errno == EACCES)
+			err = errno;
+#endif
+
+		if (err == EACCES && advice_ignored_hook) {
+			static struct string_list advise_given = STRING_LIST_INIT_DUP;
+
+			if (!string_list_lookup(&advise_given, name)) {
+				string_list_insert(&advise_given, name);
+				advise(_("The '%s' hook was ignored because "
+					 "it's not set as executable.\n"
+					 "You can disable this warning with "
+					 "`git config advice.ignoredHook false`."),
+				       path.buf);
+			}
+		}
+		return NULL;
+	}
+	return path.buf;
+}
+
+
 struct list_head* hook_list(const struct strbuf* hookname)
 {
 	struct strbuf hook_key = STRBUF_INIT;
@@ -214,7 +249,7 @@ struct list_head* hook_list(const struct strbuf* hookname)
 	git_config(hook_config_lookup, (void*)&cb_data);
 
 	if (have_git_dir())
-		legacy_hook_path = find_hook(hookname->buf);
+		legacy_hook_path = find_legacy_hook(hookname->buf);
 
 	/* Unconditionally add legacy hook, but annotate it. */
 	if (legacy_hook_path) {
@@ -245,7 +280,7 @@ int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
 	int could_run_hookdir = (should_run_hookdir == hookdir_interactive ||
 				should_run_hookdir == hookdir_warn ||
 				should_run_hookdir == hookdir_yes)
-				&& !!find_hook(hookname);
+				&& !!find_legacy_hook(hookname);
 
 	strbuf_addf(&hook_key, "hook.%s.command", hookname);
 
diff --git a/run-command.c b/run-command.c
index 0dce6bec83..16656135dd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1310,72 +1310,6 @@ int async_with_fork(void)
 #endif
 }
 
-const char *find_hook(const char *name)
-{
-	static struct strbuf path = STRBUF_INIT;
-
-	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
-	if (access(path.buf, X_OK) < 0) {
-		int err = errno;
-
-#ifdef STRIP_EXTENSION
-		strbuf_addstr(&path, STRIP_EXTENSION);
-		if (access(path.buf, X_OK) >= 0)
-			return path.buf;
-		if (errno == EACCES)
-			err = errno;
-#endif
-
-		if (err == EACCES && advice_ignored_hook) {
-			static struct string_list advise_given = STRING_LIST_INIT_DUP;
-
-			if (!string_list_lookup(&advise_given, name)) {
-				string_list_insert(&advise_given, name);
-				advise(_("The '%s' hook was ignored because "
-					 "it's not set as executable.\n"
-					 "You can disable this warning with "
-					 "`git config advice.ignoredHook false`."),
-				       path.buf);
-			}
-		}
-		return NULL;
-	}
-	return path.buf;
-}
-
-int run_hook_ve(const char *const *env, const char *name, va_list args)
-{
-	struct child_process hook = CHILD_PROCESS_INIT;
-	const char *p;
-
-	p = find_hook(name);
-	if (!p)
-		return 0;
-
-	strvec_push(&hook.args, p);
-	while ((p = va_arg(args, const char *)))
-		strvec_push(&hook.args, p);
-	hook.env = env;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.trace2_hook_name = name;
-
-	return run_command(&hook);
-}
-
-int run_hook_le(const char *const *env, const char *name, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, name);
-	ret = run_hook_ve(env, name, args);
-	va_end(args);
-
-	return ret;
-}
-
 struct io_pump {
 	/* initialized by caller */
 	int fd;
diff --git a/run-command.h b/run-command.h
index 2ad8271f56..e67bd22c5a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -194,30 +194,6 @@ int finish_command_in_signal(struct child_process *);
  */
 int run_command(struct child_process *);
 
-/*
- * Returns the path to the hook file, or NULL if the hook is missing
- * or disabled. Note that this points to static storage that will be
- * overwritten by further calls to find_hook and run_hook_*.
- */
-const char *find_hook(const char *name);
-
-/**
- * Run a hook.
- * The first argument is a pathname to an index file, or NULL
- * if the hook uses the default index file or no index is needed.
- * The second argument is the name of the hook.
- * The further arguments correspond to the hook arguments.
- * The last argument has to be NULL to terminate the arguments list.
- * If the hook does not exist or is not executable, the return
- * value will be zero.
- * If it is executable, the hook will be executed and the exit
- * status of the hook is returned.
- * On execution, .stdout_to_stderr and .no_stdin will be set.
- */
-LAST_ARG_MUST_BE_NULL
-int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
-
 /*
  * Trigger an auto-gc
  */
-- 
2.28.0.rc0.142.g3c755180ce-goog

