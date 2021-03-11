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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E9C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830C464FC6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhCKCMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCKCL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8739C061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 127so23683277ybc.19
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JsCprLWLyFSuBzFrBsU3D0YNMKHlYXYbK3AIXZsDlDY=;
        b=sCf8tmXMw0p6LudblwUVP+pbkDp72kzQA3LXmjggLgfRZoVwU3CNXAB9OgckLXB0X5
         zXpkBbh0JAyO0b5M4In5J9C7quHUY6LOiMFgrkUTy+Oa1Xs9bUV2LoWgmkXWr7Whag1a
         uF+ENxiM+jQxAx0530daL1OX6WWUz7logcrddzqfDDpNq5WbTy1aWray0viZBNfDlN1T
         V3hdDyNxdR2ciFa2zv+Vc12HdmjJCYcMh5I6rsUWodC1bzbFKeozFO9ysBF99w2SNuLm
         zjxB1o8adDJ4+5ghG0TgRlGjKQF1O47Uu3z7W0n5TwqAOvvj6a9hgMiyBGSR4EeJXFkN
         l4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JsCprLWLyFSuBzFrBsU3D0YNMKHlYXYbK3AIXZsDlDY=;
        b=dt0eEX5e8OOE2u73yFmGUqhqJbrHAd2hRqx9y/PSsqToliiXAIO/xzfO0TbpTpTZWa
         JWZFGW/TgL7CX1pzpB5I0E6DcyvBdcTuNpfcsr3s8CWIgL/O5xf8c/hUufwcyAv2mezB
         cdOxNeol2ytY8fsOiI+LbaLJKxou9zG8iRIgjUoFRUV6PzoFEFGarC9bwFJtKt31+CRn
         HBTqVi2ipghRXzSZaDZaNhf1AXwqG//i9CDseV67HtxkqhN7um+Pnr1XpWNIJamlKnyv
         d5kWwydoXNMuhhksdAqFviZUZdVACa5+ZShT+jeL4p9nA5g80RmYn1p1iPQqYDh/FyCX
         L4sg==
X-Gm-Message-State: AOAM532BsQ5OcP4dt3UjDcQ583Vlx7IwCy9qswmk2tzQ8ndf+g1q/cLz
        jGRBUPNkuEFA3a9IvlDIQboHEo0vTrxYeuQ2ww9B2q2oNdB/3jUxGuSdbXxB6ZmeYtnyaNeD8U5
        7zFLvdiQxo7sbE3GSh0zmwfYffYwfF3SLOj65YC7a7B2RpNeIMH2Fp/Iw9INrtoZCH5RPbBKrOA
        ==
X-Google-Smtp-Source: ABdhPJwcGs29KmhMw0pngF36W+0XroEvI5YaSJIXWlrAck6yvhtMFZp4lnojmkq7AtCjwdC9xMsfXW/4SuNefBbRFB0=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a5b:7cd:: with SMTP id
 t13mr8270069ybq.417.1615428715063; Wed, 10 Mar 2021 18:11:55 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:36 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-37-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 36/37] run-command: stop thinking about hooks
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
index 2322720ffe..7f6f3b9a61 100644
--- a/hook.c
+++ b/hook.c
@@ -212,6 +212,41 @@ static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
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
@@ -228,7 +263,7 @@ struct list_head* hook_list(const struct strbuf* hookname)
 	git_config(hook_config_lookup, &cb_data);
 
 	if (have_git_dir()) {
-		const char *legacy_hook_path = find_hook(hookname->buf);
+		const char *legacy_hook_path = find_legacy_hook(hookname->buf);
 
 		/* Unconditionally add legacy hook, but annotate it. */
 		if (legacy_hook_path) {
@@ -277,7 +312,7 @@ int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
 	could_run_hookdir = (should_run_hookdir == HOOKDIR_INTERACTIVE ||
 				should_run_hookdir == HOOKDIR_WARN ||
 				should_run_hookdir == HOOKDIR_YES)
-				&& !!find_hook(hookname);
+				&& !!find_legacy_hook(hookname);
 
 	strbuf_addf(&hook_key, "hook.%s.command", hookname);
 
diff --git a/run-command.c b/run-command.c
index 36a4edbacf..837415131d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1320,72 +1320,6 @@ int async_with_fork(void)
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
index ebc4a95a94..7150da851a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -201,30 +201,6 @@ int finish_command_in_signal(struct child_process *);
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
2.31.0.rc2.261.g7f71774620-goog

