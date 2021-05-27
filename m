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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F6EC47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576FC6128D
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhE0AMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbhE0AMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:12:25 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0FC061361
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:09 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so2099262qkj.6
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mQthgHLAeS25SjBjBAWzGs1a3kEccUbm8XzgLq4xxuM=;
        b=SW0Btnt3epyS2GuM8BotnKs+dVhh9IXUAG0yPC/6tqK6z1uJCI7wjrsw1UeINI0tUZ
         4MWvk+rRa4YwbCQfRBTzkrsnyezzy8krGQ1KHGTwD8xz4k4tQUfK7u9/BUbBhCoiGHWm
         giV5V5xeIKCRlIau0p42NTghbr8LT5S7diwSvBmTE12dP532pPGTRQQfTll3BBPUDPQ4
         aD9BjKJ2UIY0/7HiuPTLQKFfH5hyuyQX4gTtLxd7JYAsrj1bRaRzcrlDV0wGJrSQtE3l
         dkF0bJPdliFko3Wz/UuI4lV8hTxUeF1j5h/S9l76gz8cy70jvarsXsGkPWg0AWpLrX8M
         Hy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mQthgHLAeS25SjBjBAWzGs1a3kEccUbm8XzgLq4xxuM=;
        b=aXuHB7cfgyb2P0Z0NYDqiOqLK4Rbw/kBsdfqIIotXDwOKs+lMVuijqN/Z559WHK5p0
         NWyS/tAU7sUS8SK8QmphdqbTFS1zxO9NHSXLGuVHtwBB2AgN04TyslsQPdKUIF8PYNdp
         SWuVYIcpDA5+ocOjLGdVU7KVwYmSAmxA088vkWsusGsl3JFN0IWrc0gucPQ69lo4UKRQ
         eWYGpboVsbIRBait3nLlsJpWogS3Xxgq4RtNxrhNm9RsRzs5dsjDaodi4CXKg49pNviN
         uRUOdhjo4GTYMYD2ympAhqmRBpyp7H5j6crm7y77FVhUMX/Gol9L+XN9cifl6GbVAKup
         1+yQ==
X-Gm-Message-State: AOAM533/i9Ol2P0+GZzuU5y6Y0GT3zY3C/nDADeNNU7wjH3zFy5/ekZF
        lbjd+0GIx76r4WvfFRIr807mgmnQ/XYQVZ+Tv/OU4AFX6Pym7a54yr04BjXYv5wrojDiqu1Bx1l
        d/N7w+cWmXynjuNvlg/azrWepGHP8GL7M3Fags6VoKlHK7GhakbH6bMPFlWLP7NmT8uQ5YNe48g
        ==
X-Google-Smtp-Source: ABdhPJzA3wbDCmY7xc72RlEp/VDq+J01qDQU8JiPpnhIIt9PGSqqsq30+EoitG2FjNY+xmC3jHy2v/E+AYNOGDZK6uY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:11a3:: with SMTP id
 u3mr1055931qvv.6.1622074208190; Wed, 26 May 2021 17:10:08 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:54 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-36-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 35/37] run-command: stop thinking about hooks
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
index 27da1fdb32..ff80e52edd 100644
--- a/hook.c
+++ b/hook.c
@@ -218,6 +218,41 @@ static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
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
 struct list_head* hook_list(const char* hookname)
 {
 	struct strbuf hook_key = STRBUF_INIT;
@@ -234,7 +269,7 @@ struct list_head* hook_list(const char* hookname)
 	git_config(hook_config_lookup, &cb_data);
 
 	if (have_git_dir()) {
-		const char *legacy_hook_path = find_hook(hookname);
+		const char *legacy_hook_path = find_legacy_hook(hookname);
 
 		/* Unconditionally add legacy hook, but annotate it. */
 		if (legacy_hook_path) {
@@ -283,7 +318,7 @@ int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
 	could_run_hookdir = (should_run_hookdir == HOOKDIR_INTERACTIVE ||
 				should_run_hookdir == HOOKDIR_WARN ||
 				should_run_hookdir == HOOKDIR_YES)
-				&& !!find_hook(hookname);
+				&& !!find_legacy_hook(hookname);
 
 	strbuf_addf(&hook_key, "hook.%s.command", hookname);
 
diff --git a/run-command.c b/run-command.c
index 27135defb8..2ff76f3c2f 100644
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
2.31.1.818.g46aad6cb9e-goog

