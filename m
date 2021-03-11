Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D7DC433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE5264FC9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhCKCLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhCKCLA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:00 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78917C061762
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:00 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id e17so2410328qkg.3
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RpSEtPsAi8tbtJobuTrBN0rmJ1JQzaRPVpGjy54khnY=;
        b=WiZ5myK6hDD+x2xFQirUhheSiJ0Fu4mZHN8lul3EC04T7W+heWKfDpE3sUcfN1HVps
         lopOnfxAKRVl7l2JxArYO3JyCVv6YECOK0kN8OFItkzeGMBoozFK3hnnxGl9UMQiBTwJ
         uPjTVZpOajEZ2BNt3P7sd7r1L21wsf2nnsdP7BUUAqTq9bn9i43HaXgxCForwlyGeMWV
         x4rIWPJqqsaBWghurl8Z/mjWnSjRVXYVB/Fexo3jPAAZblU7Y1S2tpQoJ5VotJZeJ0Tn
         0vtsiULqHllmaP50sNX0KxRNK37JCxLgU44Hp+eEQN/B0+EFVMBemDwClRZlXCCgI8cx
         ghkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RpSEtPsAi8tbtJobuTrBN0rmJ1JQzaRPVpGjy54khnY=;
        b=FZfYGcAO2oUGoiO+6hrILhSZQ/I+eqeWcv5SDWFGpoIeRZsPuhMBr2Ft4v68IzgYe8
         TMTMB/AiutMTkxaD1i4nGCV/01EB7WN6WusfYTQpKIoa0cY/pWST5Y7xp8jiZ42gLt3/
         8Y78cZnSkdq0RScWXGLg9/d2YPB1Zxh5/LwkhFGjwEaFD1Ytpi+PQDUn6l5rPvSN0TGs
         ZmahvVIFPnJ2ClYGAfCm2tSR45ttDef+/vlJUASurZN5cjWzqxmEiJxIfX96p+1pbxO3
         eQyc9IDCJhU4Qk9sC6XrDMJhrU4mebIz8nqBTXY6V/mlEvuZUnP1omvru/YgFRCWdO1m
         LGMQ==
X-Gm-Message-State: AOAM530fpIBT7flUNiTHyN3zGoocj2HWkea06+lGGQGua/muTkoZeG2U
        1bJ+nZvY3d9FRraaDOTPSz8n9Jn8PFUMaoC9/QiBBjOJL+vTHugFrYuaJaXWClRaukAp+/7mrKJ
        yls4ZHiY46QsBTJ85AJrM13B7WA0HgOX5MvkzYwmQm/F3zG/PpXTtnPbJuRUjKq+SV9oT1eL+CA
        ==
X-Google-Smtp-Source: ABdhPJx5/jhMeRmIp0/tWKVuU7YHLoWmKml/CHnOXWZvpe8oICRaIfBqRMUYVSVJsa43vL713Iwi3GX/wWVOXTtIXZY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:2b06:: with SMTP id
 jx6mr5896953qvb.48.1615428659694; Wed, 10 Mar 2021 18:10:59 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:05 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 05/37] hook: teach hook.runHookDir
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

 - Emily

 Documentation/config/hook.txt |  5 +++
 builtin/hook.c                | 69 +++++++++++++++++++++++++++++++---
 hook.c                        | 24 ++++++++++++
 hook.h                        | 16 ++++++++
 t/t1360-config-based-hooks.sh | 71 +++++++++++++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 5 deletions(-)

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
index c8fbfbb39d..310f696ebf 100644
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
 	struct strbuf hookname = STRBUF_INIT;
+	struct strbuf hookdir_annotation = STRBUF_INIT;
 
 	struct option list_options[] = {
 		OPT_END(),
@@ -38,20 +41,48 @@ static int list(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	switch (should_run_hookdir) {
+		case HOOKDIR_NO:
+			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
+			break;
+		case HOOKDIR_ERROR:
+			strbuf_addstr(&hookdir_annotation, _(" (will error and not run)"));
+			break;
+		case HOOKDIR_INTERACTIVE:
+			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
+			break;
+		case HOOKDIR_WARN:
+			strbuf_addstr(&hookdir_annotation, _(" (will warn but run)"));
+			break;
+		case HOOKDIR_YES:
+		/*
+		 * The default behavior should agree with
+		 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
+		 * do the default behavior.
+		 */
+		case HOOKDIR_UNKNOWN:
+		default:
+			break;
+	}
+
 	list_for_each(pos, head) {
 		struct hook *item = list_entry(pos, struct hook, list);
 		item = list_entry(pos, struct hook, list);
 		if (item) {
 			/* Don't translate 'hookdir' - it matches the config */
-			printf("%s: %s\n",
+			printf("%s: %s%s\n",
 			       (item->from_hookdir
 				? "hookdir"
 				: config_scope_name(item->origin)),
-			       item->command.buf);
+			       item->command.buf,
+			       (item->from_hookdir
+				? hookdir_annotation.buf
+				: ""));
 		}
 	}
 
 	clear_hook_list(head);
+	strbuf_release(&hookdir_annotation);
 	strbuf_release(&hookname);
 
 	return 0;
@@ -59,16 +90,44 @@ static int list(int argc, const char **argv, const char *prefix)
 
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
index 080e25696b..039ff0a378 100644
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
 struct list_head* hook_list(const struct strbuf* hookname)
 {
 	struct strbuf hook_key = STRBUF_INIT;
diff --git a/hook.h b/hook.h
index a97d43670d..1c4b953aec 100644
--- a/hook.h
+++ b/hook.h
@@ -20,6 +20,22 @@ struct hook {
  */
 struct list_head* hook_list(const struct strbuf *hookname);
 
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
 /* Free memory associated with a 'struct hook' */
 void free_hook(struct hook *ptr);
 /* Empties the list at 'head', calling 'free_hook()' on each entry */
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 0f12af4659..66b0b6b7ad 100755
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
+	test_i18ncmp expected actual
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
+	test_i18ncmp expected actual
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
+	test_i18ncmp expected actual
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
+	test_i18ncmp expected actual
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
+	test_i18ncmp expected actual
+'
+
 test_done
-- 
2.31.0.rc2.261.g7f71774620-goog

