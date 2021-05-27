Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7BC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FD46128D
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhE0AK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhE0AKo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14924C061760
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e198-20020a25e7cf0000b029052a1d34778fso3617630ybh.13
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5u3Jomj2WzIKSJPoNZOXmDBZeXPSqG0sey2cRsleXNE=;
        b=ugeCRYEB847rmGpoazcpjcx2ccUDCFFUb2Io+GV0lyMpaH0X2lGVcIKJNoH22AnVAE
         rOncj+qd6nD5RdJNhUxHWQVVdr0Zh9whd6ypcebtoXa7lALYcNwgKGbx3m84UEr3me0S
         crT1k09T6/zqLuRpuSMCq9QADLhayYEASampEuU8KP8/NgPbSLIKsHaNUXotMKQmQZ86
         Xl6JIUVgqWVsg08SL27mRB+xi7/vHZBkAzrjElmSrgItDBjDfjYLd2HiUuuUybbdZc/q
         39kp8BYsh6LiLmHTsEuECJmWXXs2Qi0tIzXGJU2nJYYjGhkTsL7rZVJHoAAhFPx4bzAQ
         yPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5u3Jomj2WzIKSJPoNZOXmDBZeXPSqG0sey2cRsleXNE=;
        b=Fl71G0JRpS08+eWcZzuSnChbCPfzsHEMjEtdG7y5dECLvbJ5z5g+Z6+qYJXAjzjj5g
         AYrhJu0Xd9VUymt7Bsi1VZB/vcqarrhgYw4geQORZfF3IhaIwXaWURGhMn5OIwBmFK09
         p7vA85lyJsxX8D9EiCMNmFNgjmZPxUQaYxkq2ZhYXVHsq8IDCCOpa43klF4KEr7AkXZH
         C9XT9+fznZWU8+k2/cotgkZr9JdOghjCdHy9Euq0xL4whE77WFdMmkGSfYXJxM8vqSao
         ESX9bfPeieFlctwqMWxphJhNOSZ7xK3VZeQGOpnMV4oyxoX0cCXk1CM79ttbjPhQ4T9w
         HGmw==
X-Gm-Message-State: AOAM531BwXOdMufRQoJW6C3BXynBe4MPvyGIUHI9Mbd5zV9XLH1crIoB
        yVb0kVB05B0PfAdBFDl9ci3v5uTjAQ8yTRzcwTgu1xr5u6nimoQiXgIQIM5Zb0w0oi1UQLWyttW
        Kb3uvYckzIEtgExDUN1WdDTzD856ScecuWv7f4Qj/XKPKBssdLxLCTqCAXUnc1d/0yDdy+Oy86A
        ==
X-Google-Smtp-Source: ABdhPJxa/hPhqJXJs7nfNaEAQFzJrcpF/Z/6ZBi1lis28IWAYSBngVoEREfcEtUwM2V/RK9r6JYMT3ggJbQ4N2a1XuU=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:df8e:: with SMTP id
 w136mr893269ybg.404.1622074149235; Wed, 26 May 2021 17:09:09 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:23 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 04/37] hook: teach hook.runHookDir
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now, just give a hint about how these hooks will be run in 'git hook
list'. Later on, though, we will pay attention to this enum when running
the hooks.
---

Notes:
    Since v7, tidied up the behavior of the HOOK_UNKNOWN flag and added a test to
    enforce it - now it matches the design doc much better.
    
    Also, thanks Jonathan Tan for pointing out that the commit message made no sense
    and was targeted for a different change. Rewrote the commit message now.
    
    Plus, added HOOK_ERROR flag per Junio and Jonathan Nieder.
    
    Newly split into its own commit since v4, and taking place much sooner.
    
    An unfortunate side effect of adding this support *before* the
    hook.runHookDir support is that the labels on the list are not clear -
    because we aren't yet flagging which hooks are from the hookdir versus
    the config. I suppose we could move the addition of that field to the
    struct hook up to this patch, but it didn't make a lot of sense to me to
    do it just for cosmetic purposes.
    
    Since v7, tidied up the behavior of the HOOK_UNKNOWN flag and added a test to
    enforce it - now it matches the design doc much better.
    
    Also, thanks Jonathan Tan for pointing out that the commit message made no sense
    and was targeted for a different change. Rewrote the commit message now.
    
    Newly split into its own commit since v4, and taking place much sooner.
    
    An unfortunate side effect of adding this support *before* the
    hook.runHookDir support is that the labels on the list are not clear -
    because we aren't yet flagging which hooks are from the hookdir versus
    the config. I suppose we could move the addition of that field to the
    struct hook up to this patch, but it didn't make a lot of sense to me to
    do it just for cosmetic purposes.

 Documentation/config/hook.txt |  5 ++
 builtin/hook.c                | 98 ++++++++++++++++++++++++++++++-----
 hook.c                        | 24 +++++++++
 hook.h                        | 22 ++++++++
 t/t1360-config-based-hooks.sh | 71 +++++++++++++++++++++++++
 5 files changed, 206 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index 71449ecbc7..75312754ae 100644
--- a/Documentation/config/hook.txt
+++ b/Documentation/config/hook.txt
@@ -7,3 +7,8 @@ hookcmd.<name>.command::
 	A command to execute during a hook for which <name> has been specified
 	as a command. This can be an executable on your device or a oneliner for
 	your shell. See linkgit:git-hook[1].
+
+hook.runHookDir::
+	Controls how hooks contained in your hookdir are executed. Can be any of
+	"yes", "warn", "interactive", or "no". Defaults to "yes". See
+	linkgit:git-hook[1] and linkgit:git-config[1] "core.hooksPath").
diff --git a/builtin/hook.c b/builtin/hook.c
index e82725f0a6..b1e63a9576 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -10,10 +10,13 @@ static const char * const builtin_hook_usage[] = {
 	NULL
 };
 
+static enum hookdir_opt should_run_hookdir;
+
 static int list(int argc, const char **argv, const char *prefix)
 {
 	struct list_head *head, *pos;
 	const char *hookname = NULL;
+	struct strbuf hookdir_annotation = STRBUF_INIT;
 
 	struct option list_options[] = {
 		OPT_END(),
@@ -41,37 +44,104 @@ static int list(int argc, const char **argv, const char *prefix)
 		struct hook *item = list_entry(pos, struct hook, list);
 		item = list_entry(pos, struct hook, list);
 		if (item) {
-			/*
-			 * TRANSLATORS: "<config scope>: <path>". Both fields
-			 * should be left untranslated; config scope matches the
-			 * output of 'git config --show-scope'. Marked for
-			 * translation to provide better RTL support later.
-			 */
-			printf(_("%s: %s\n"),
-			       (item->from_hookdir
-				? "hookdir"
-				: config_scope_name(item->origin)),
-			       item->command.buf);
+			if (item->from_hookdir) {
+				/*
+				 * TRANSLATORS: do not translate 'hookdir' as
+				 * it matches the config setting.
+				 */
+				switch (should_run_hookdir) {
+				case HOOKDIR_NO:
+					printf(_("hookdir: %s (will not run)\n"),
+					       item->command.buf);
+					break;
+				case HOOKDIR_ERROR:
+					printf(_("hookdir: %s (will error and not run)\n"),
+					       item->command.buf);
+					break;
+				case HOOKDIR_INTERACTIVE:
+					printf(_("hookdir: %s (will prompt)\n"),
+					       item->command.buf);
+					break;
+				case HOOKDIR_WARN:
+					printf(_("hookdir: %s (will warn but run)\n"),
+					       item->command.buf);
+					break;
+				case HOOKDIR_YES:
+				/*
+				 * The default behavior should agree with
+				 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
+				 * do the default behavior.
+				 */
+				case HOOKDIR_UNKNOWN:
+				default:
+					printf(_("hookdir: %s\n"),
+						 item->command.buf);
+					break;
+				}
+			} else {
+				/*
+				 * TRANSLATORS: "<config scope>: <path>". Both fields
+				 * should be left untranslated; config scope matches the
+				 * output of 'git config --show-scope'. Marked for
+				 * translation to provide better RTL support later.
+				 */
+				printf(_("%s: %s\n"),
+					config_scope_name(item->origin),
+					item->command.buf);
+			}
 		}
 	}
 
 	clear_hook_list(head);
+	strbuf_release(&hookdir_annotation);
 
 	return 0;
 }
 
 int cmd_hook(int argc, const char **argv, const char *prefix)
 {
+	const char *run_hookdir = NULL;
+
 	struct option builtin_hook_options[] = {
+		OPT_STRING(0, "run-hookdir", &run_hookdir, N_("option"),
+			   N_("what to do with hooks found in the hookdir")),
 		OPT_END(),
 	};
-	if (argc < 2)
+
+	argc = parse_options(argc, argv, prefix, builtin_hook_options,
+			     builtin_hook_usage, 0);
+
+	/* after the parse, we should have "<command> <hookname> <args...>" */
+	if (argc < 1)
 		usage_with_options(builtin_hook_usage, builtin_hook_options);
 
 	git_config(git_default_config, NULL);
 
-	if (!strcmp(argv[1], "list"))
-		return list(argc - 1, argv + 1, prefix);
+
+	/* argument > config */
+	if (run_hookdir)
+		if (!strcmp(run_hookdir, "no"))
+			should_run_hookdir = HOOKDIR_NO;
+		else if (!strcmp(run_hookdir, "error"))
+			should_run_hookdir = HOOKDIR_ERROR;
+		else if (!strcmp(run_hookdir, "yes"))
+			should_run_hookdir = HOOKDIR_YES;
+		else if (!strcmp(run_hookdir, "warn"))
+			should_run_hookdir = HOOKDIR_WARN;
+		else if (!strcmp(run_hookdir, "interactive"))
+			should_run_hookdir = HOOKDIR_INTERACTIVE;
+		else
+			/*
+			 * TRANSLATORS: leave "yes/warn/interactive/no"
+			 * untranslated; the strings are compared literally.
+			 */
+			die(_("'%s' is not a valid option for --run-hookdir "
+			      "(yes, warn, interactive, no)"), run_hookdir);
+	else
+		should_run_hookdir = configured_hookdir_opt();
+
+	if (!strcmp(argv[0], "list"))
+		return list(argc, argv, prefix);
 
 	usage_with_options(builtin_hook_usage, builtin_hook_options);
 }
diff --git a/hook.c b/hook.c
index b4994fc108..030051cab2 100644
--- a/hook.c
+++ b/hook.c
@@ -102,6 +102,30 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
 	return 0;
 }
 
+enum hookdir_opt configured_hookdir_opt(void)
+{
+	const char *key;
+	if (git_config_get_value("hook.runhookdir", &key))
+		return HOOKDIR_YES; /* by default, just run it. */
+
+	if (!strcmp(key, "no"))
+		return HOOKDIR_NO;
+
+	if (!strcmp(key, "error"))
+		return HOOKDIR_ERROR;
+
+	if (!strcmp(key, "yes"))
+		return HOOKDIR_YES;
+
+	if (!strcmp(key, "warn"))
+		return HOOKDIR_WARN;
+
+	if (!strcmp(key, "interactive"))
+		return HOOKDIR_INTERACTIVE;
+
+	return HOOKDIR_UNKNOWN;
+}
+
 struct list_head* hook_list(const char* hookname)
 {
 	struct strbuf hook_key = STRBUF_INIT;
diff --git a/hook.h b/hook.h
index b6c5480325..7f2b2ee8f2 100644
--- a/hook.h
+++ b/hook.h
@@ -20,6 +20,28 @@ struct hook {
  */
 struct list_head* hook_list(const char *hookname);
 
+enum hookdir_opt
+{
+	HOOKDIR_NO,
+	HOOKDIR_ERROR,
+	HOOKDIR_WARN,
+	HOOKDIR_INTERACTIVE,
+	HOOKDIR_YES,
+	HOOKDIR_UNKNOWN,
+};
+
+/*
+ * Provides the hookdir_opt specified in the config without consulting any
+ * command line arguments.
+ */
+enum hookdir_opt configured_hookdir_opt(void);
+
+/*
+ * Provides the hookdir_opt specified in the config without consulting any
+ * command line arguments.
+ */
+enum hookdir_opt configured_hookdir_opt(void);
+
 /* Free memory associated with a 'struct hook' */
 void free_hook(struct hook *ptr);
 /* Empties the list at 'head', calling 'free_hook()' on each entry */
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 0f12af4659..141e6f7590 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -104,4 +104,75 @@ test_expect_success 'git hook list shows hooks from the hookdir' '
 	test_cmp expected actual
 '
 
+test_expect_success 'hook.runHookDir = no is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "no" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will not run)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual
+'
+
+test_expect_success 'hook.runHookDir = error is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "error" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will error and not run)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual
+'
+
+test_expect_success 'hook.runHookDir = warn is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "warn" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will warn but run)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual
+'
+
+
+test_expect_success 'hook.runHookDir = interactive is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "interactive" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will prompt)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual
+'
+
+test_expect_success 'hook.runHookDir is tolerant to unknown values' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "junk" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_cmp expected actual
+'
+
 test_done
-- 
2.31.1.818.g46aad6cb9e-goog

