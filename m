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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE6AC4332B
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B1364FC5
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCKCLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhCKCLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A950C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j4so23633034ybt.23
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ylnOZikcKWIdIian1z84J6asjhogfYDwv55kcH6FPWQ=;
        b=IolqxSNEDYHAOJRGlDyuXrvFL8b+ZvClu11YCEQfsEsmlxBhwwv3uEib8PAMErq72u
         sZbySsG6jv1w2WFT13IDtcZQBWcCLXEB9kfa0EM65Tzs1pOr9I6U6xLo3aX9j+NhRSK9
         +dltDTtIS9Z1qynJ/AJWCZwpKs6o4KfZxGX/yrnzY89/SQCB7hPrvwJWyXikYc5abN5i
         KkqZAu+vT+3THgQzuJH6DW5gLowfW/UHA58TgBX+fNSXiCsWcdmkq17oXkZC3VVrWZj7
         hAxbsevQu06m2gyJDP7SqMqZ5Ei4IsrE3OmiH9yMMyC7lO7Ysg9Y1IA8uHT+O8MmvX8S
         xQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ylnOZikcKWIdIian1z84J6asjhogfYDwv55kcH6FPWQ=;
        b=ApWG20+rHLG8xYsLP3SF3Scimk1OMAqKqCKmq93Z7iSW5tLhVORfsOGPdAZJ+IQN10
         IUWpupTxxQ2SMQUzmd7omHhy2zRlN9OwUKMjztVzKBAMSZbrM8dIwil8AbTQleE8RMBg
         oLdYlklgnUW/Kg2m+PyuytiWl9DVzdwLdPSWLtu/2tQcDPRRo6g04z/f8irNGbiWrSKK
         hoVL+oZfzJA5Nxahmp1OTTuRqj7rnHdMM+5QgibypEVnDYABf7t+Zp2IeLUPfWzSxUSI
         OJFeyu9gsieSYBe8Vu7NpqarBA30rqPCYIwwxrTnozBpf6WjWaozUO8IfuuipyczMrBt
         TdFg==
X-Gm-Message-State: AOAM533m4MQYefYP8HpCz86RLKoHfJUF/uMV71UFKe+LqfH89PBgmpD+
        deCyh84SKJXAtNkxJBHB7UdsftSZGEaAXr4VeGRJfEGgPPK3LVIcG7WIMhm4Fwds6fsiM64X1pY
        r2pJwH20wRYtyDIPMYVR4R5Tk8q/AZ6nRes/JiRhvYl5owPwz1/llxiXnlFQv4wVux4MFLGXbVw
        ==
X-Google-Smtp-Source: ABdhPJwvrmGoKdNtWudCPtEn32ajFotK47fgRePWAz6tE8Rw8Djl5NO76VMrAggsZqELeD0IxKdAazyt9v+E6oqsxnU=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:af4f:: with SMTP id
 c15mr8722331ybj.85.1615428668622; Wed, 10 Mar 2021 18:11:08 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:10 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 10/37] hook: support passing stdin to hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some hooks (such as post-rewrite) need to take input via stdin.
Previously, callers provided stdin to hooks by setting
run-command.h:child_process.in, which takes a FD. Callers would open the
file in question themselves before calling run-command(). However, since
we will now need to seek to the front of the file and read it again for
every hook which runs, hook.h:run_command() takes a path and handles FD
management itself. Since this file is opened for read only, it should
not prevent later parallel execution support.

On the frontend, this is supported by asking for a file path, rather
than by reading stdin. Reading directly from stdin would involve caching
the entire stdin (to memory or to disk) and reading it back from the
beginning to each hook. We'd want to support cases like insufficient
memory or storage for the file. While this may prove useful later, for
now the path of least resistance is to just ask the user to make this
interim file themselves.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    | 11 +++++++++--
 builtin/hook.c                |  5 ++++-
 hook.c                        |  8 +++++++-
 hook.h                        |  6 +++++-
 t/t1360-config-based-hooks.sh | 24 ++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 8f96c347ea..96a857c682 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git hook' list <hook-name>
-'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hook-name>
+'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>]
+	<hook-name>
 
 DESCRIPTION
 -----------
@@ -98,7 +99,7 @@ in the order they should be run, and print the config scope where the relevant
 `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
 This output is human-readable and the format is subject to change over time.
 
-run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] `<hook-name>`::
+run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>] `<hook-name>`::
 
 Runs hooks configured for `<hook-name>`, in the same order displayed by `git
 hook list`. Hooks configured this way may be run prepended with `sh -c`, so
@@ -124,6 +125,12 @@ Specify arguments to pass to every hook that is run.
 +
 Specify environment variables to set for every hook that is run.
 
+--to-stdin::
+	Only valid for `run`.
++
+Specify a file which will be streamed into stdin for every hook that is run.
+Each hook will receive the entire file from beginning to EOF.
+
 CONFIGURATION
 -------------
 include::config/hook.txt[]
diff --git a/builtin/hook.c b/builtin/hook.c
index e823a96238..38a4555e05 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -8,7 +8,8 @@
 
 static const char * const builtin_hook_usage[] = {
 	N_("git hook list <hookname>"),
-	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hookname>"),
+	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...]"
+	   "[--to-stdin=<path>] <hookname>"),
 	NULL
 };
 
@@ -101,6 +102,8 @@ static int run(int argc, const char **argv, const char *prefix)
 			   N_("environment variables for hook to use")),
 		OPT_STRVEC('a', "arg", &opt.args, N_("args"),
 			   N_("argument to pass to hook")),
+		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
+			   N_("file to read into hooks' stdin")),
 		OPT_END(),
 	};
 
diff --git a/hook.c b/hook.c
index 118931f273..f906e8c61c 100644
--- a/hook.c
+++ b/hook.c
@@ -240,6 +240,7 @@ void run_hooks_opt_init(struct run_hooks_opt *o)
 {
 	strvec_init(&o->env);
 	strvec_init(&o->args);
+	o->path_to_stdin = NULL;
 	o->run_hookdir = configured_hookdir_opt();
 }
 
@@ -274,7 +275,12 @@ static void prepare_hook_cp(struct hook *hook, struct run_hooks_opt *options,
 	if (!hook)
 		return;
 
-	cp->no_stdin = 1;
+	/* reopen the file for stdin; run_command closes it. */
+	if (options->path_to_stdin)
+		cp->in = xopen(options->path_to_stdin, O_RDONLY);
+	else
+		cp->no_stdin = 1;
+
 	cp->env = options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook->command.buf;
diff --git a/hook.h b/hook.h
index 0df785add5..2314ec5962 100644
--- a/hook.h
+++ b/hook.h
@@ -52,6 +52,9 @@ struct run_hooks_opt
 	 * to be overridden if the user can override it at the command line.
 	 */
 	enum hookdir_opt run_hookdir;
+
+	/* Path to file which should be piped to stdin for each hook */
+	const char *path_to_stdin;
 };
 
 void run_hooks_opt_init(struct run_hooks_opt *o);
@@ -68,7 +71,8 @@ int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
 
 /*
  * Runs all hooks associated to the 'hookname' event in order. Each hook will be
- * passed 'env' and 'args'.
+ * passed 'env' and 'args'. The file at 'stdin_path' will be closed and reopened
+ * for each hook that runs.
  */
 int run_hooks(const char *hookname, struct run_hooks_opt *options);
 
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 1fca83d536..cace5a23c1 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -276,4 +276,28 @@ test_expect_success 'hook.runHookDir is tolerant to unknown values' '
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'stdin to multiple hooks' '
+	git config --add hook.test.command "xargs -P1 -I% echo a%" &&
+	git config --add hook.test.command "xargs -P1 -I% echo b%" &&
+	test_when_finished "test_unconfig hook.test.command" &&
+
+	cat >input <<-EOF &&
+	1
+	2
+	3
+	EOF
+
+	cat >expected <<-EOF &&
+	a1
+	a2
+	a3
+	b1
+	b2
+	b3
+	EOF
+
+	git hook run --to-stdin=input test 2>actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.31.0.rc2.261.g7f71774620-goog

