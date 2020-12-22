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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B511C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D6622AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgLVADq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLVADp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:45 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD5C061248
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:34 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x12so6526590plr.21
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EmHsBf1+1NjuozJFvJ8OL3GYhDVYbAr1m6xHT89QZNg=;
        b=Jb5ObFzMMFFTPyxzyYcc753fQt17WKh8mQyycYlkjw5ej11qGk4+ipIyc7NGpfeFo5
         +mSLx8jMR+UL3Sn8XMJ6mElAuOOpJQMD1mh04Gm+kLe7hvO7R2Mp1Y/sP8qQLaBCJVy9
         //xz0nczQ6Q4E9N8LpJ6IQTLr/Jy4bMy0dJuo/KBOCkYWe7IEf42mOYzHLJA1rwzJKTc
         v5r4X+NUpVEn7Li3ZcHurzHWdAa530FsKU0M7nVzrVpJRQaVuF7AET8H1pHFa779kRjG
         JLJHNt7APdoZ+yCBCEHl5vcIyofeORMW3COny2sEf6/lqas3T8hiE/fXc7JZpgtkyGnV
         kE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EmHsBf1+1NjuozJFvJ8OL3GYhDVYbAr1m6xHT89QZNg=;
        b=K5OIpEGFkHYUt3oY4wDfpqVhBiia6cvfBT7BhwYjf9+y93AZxiRJT+B80dE1kmSZv7
         hV23mbue7H141vdWBbABvZoFI6vP+L9/zwoOHwE05oS+0+xCPkHsZXi+q6SOoaREAAK4
         vIxw3rU5W1LMZ3vgbH+cSZqmHbWEX5hDSZiaNsd4vCHTg24QZu+DXAYbW1S2lf6GgNPj
         q0pFwtUTyc51fazV5/gOncMUp7AbzPsq7/ieDbkb3uSEfS01e/WL+XdyAuGJgtmEhuzO
         invrSlujSM67yf908bdg6r4aUG3WubX4rrekFC8G/kC22OXart21t7QNOGtWhSpS0QD4
         ZRxw==
X-Gm-Message-State: AOAM532Z6y2S/Pv2zuNObBTzEdsdKN9Xta0jYWzUopGmJ7faZsOaU5qF
        nfmxd9Qj2tKDKeNrQz7V6LG2kpmr1tV+tcjibnvvcHodurpA5QmWXedFv+8xiZEw+X+DGR3PjQj
        4B//zZOLTeG4bdpRxVuKIBhiityowBRP3+d4ddf1jYtDsUGcqXnKBdQ39DBukC6KVHFu/2RT22Q
        ==
X-Google-Smtp-Source: ABdhPJxshcycMiziB8jasD+GYfBSrPOglW2kXAm7xArODkvYgKFa5m1IpAKoqVs8EOKzikXnhVOKEtfMQi4oKmzIckM=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:8bc8:b029:dc:36d4:fba8 with
 SMTP id r8-20020a1709028bc8b02900dc36d4fba8mr11166276plo.82.1608595353882;
 Mon, 21 Dec 2020 16:02:33 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:08 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 05/17] hook: respect hook.runHookDir
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include hooks specified in the hook directory in the list of hooks to
run. These hooks do need to be treated differently from config-specified
ones - they do not need to run in a shell, and later on may be disabled
or warned about based on a config setting.

Because they are at least as local as the local config, we'll run them
last - to keep the hook execution order from global to local.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Newly split into its own commit since v4, and taking place much sooner.
    
    An unfortunate side effect of adding this support *before* the
    hook.runHookDir support is that the labels on the list are not clear -
    because we aren't yet flagging which hooks are from the hookdir versus
    the config. I suppose we could move the addition of that field to the
    struct hook up to this patch, but it didn't make a lot of sense to me to
    do it just for cosmetic purposes.

 Documentation/config/hook.txt |  5 ++++
 builtin/hook.c                | 54 +++++++++++++++++++++++++++++++++--
 hook.c                        | 21 ++++++++++++++
 hook.h                        | 15 ++++++++++
 t/t1360-config-based-hooks.sh | 43 ++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+), 3 deletions(-)

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
index a0013ae4d7..d087e6f5b0 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -11,6 +11,8 @@ static const char * const builtin_hook_usage[] = {
 	NULL
 };
 
+static enum hookdir_opt should_run_hookdir;
+
 static int list(int argc, const char **argv, const char *prefix)
 {
 	struct list_head *head, *pos;
@@ -41,6 +43,26 @@ static int list(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	switch (should_run_hookdir) {
+		case HOOKDIR_NO:
+			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
+			break;
+		case HOOKDIR_INTERACTIVE:
+			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
+			break;
+		case HOOKDIR_WARN:
+		case HOOKDIR_UNKNOWN:
+			strbuf_addstr(&hookdir_annotation, _(" (will warn)"));
+			break;
+		case HOOKDIR_YES:
+		/*
+		 * The default behavior should agree with
+		 * hook.c:configured_hookdir_opt().
+		 */
+		default:
+			break;
+	}
+
 	list_for_each(pos, head) {
 		item = list_entry(pos, struct hook, list);
 		if (item) {
@@ -64,16 +86,42 @@ static int list(int argc, const char **argv, const char *prefix)
 
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
index ffbdcfd987..ed52e85159 100644
--- a/hook.c
+++ b/hook.c
@@ -97,6 +97,27 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
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
index 5750634c83..ccdf6272f2 100644
--- a/hook.h
+++ b/hook.h
@@ -21,6 +21,21 @@ struct hook
  */
 struct list_head* hook_list(const struct strbuf *hookname);
 
+enum hookdir_opt
+{
+	HOOKDIR_NO,
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
index 0f12af4659..91127a50a4 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -104,4 +104,47 @@ test_expect_success 'git hook list shows hooks from the hookdir' '
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
+test_expect_success 'hook.runHookDir = warn is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "warn" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will warn)
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
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

