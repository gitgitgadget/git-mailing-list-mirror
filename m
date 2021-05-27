Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A202BC47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED4A613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhE0AK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbhE0AKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:49 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08502C06138B
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:12 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s123-20020a3777810000b02902e9adec2313so2105613qkc.4
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SXHg8b+uFdBO2stA984yAarTPvmFraUymxfuXjYJCTI=;
        b=pH5tQ9wdXB8e5nUYEje2Hg1JvNXr+nhqDtrMZxps++/nnVRLfgiec24BSSneALCsAw
         vhtHGyzdJtQy+4MKjDxRFQkZ0IaP8P08Im4VgYIuAEGSeCmeJ1SD8fviBj2BL78WDiow
         nrcPQ7rJj2paB5Vv1peV6BiWDPTqvBN8r5eJYurTVITY+6dTCI0vnwdDt06f1K1yCYSw
         6QNUnf7qin6yIADEslsGwfVvmKbhljxMS2YwltSvsCgR0xuZTGal0LOgwcE73JEEEtoa
         BSv73/BVqlYVC9gDiGL3anfF/cybwCVBfAuVBDjG6QMYWIUvvjwQGQpTSStDpvoSnNSZ
         D5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SXHg8b+uFdBO2stA984yAarTPvmFraUymxfuXjYJCTI=;
        b=Fh/tf4c/1/zfsPm/LItXh/TnmTWjXjCWf91k2LpEblGqQ26JZe3Oflk5zase3JSdZh
         djvqXkjlh9bycSWSMZkkWFDebBsEaIqQT98cv9Pq3u4O5rq0JKibUHM1PgaWoy7ZmnK5
         mxNVaKiUup0jpzk24FlFxDc0B4Wh9ZNX7mZIYbS1Yjl1WlhP/H/hkJVFGvWp5obNbwLZ
         hjgOsyLUslh7DPvL8oiwV8HG783rU5iizkGL6s3qtPx0N77KVk3Usm1rmoch9OMXeMBq
         Mb8Y6nkAH1HGqGIVJnCirykIceqDFu08jLVcv2/7GbyU+QNPK4ywCsViQG/RyaUhk6NF
         Smng==
X-Gm-Message-State: AOAM530sDXeuXFkpi2Mm17lL7dU1T9bIIkM7lcudub6G6HWJ65j/a6VU
        NBnPPfzXxio5lYT7dfHUFYFajABlNhF9ZEqgLQR3LfGXUCYMCTwfzC1q8ABjOEkBE+wkS9pBbru
        ShmV0Q/YngruQ1A+zi15qJsY6ah1jqvWueBM+M200sCSBVXUxvDx8WxLe1RwOFyjQ2Hx4VHYJMg
        ==
X-Google-Smtp-Source: ABdhPJx+rAxrXF19GEwkxeJNuwOWdUcjKKIvgIU5G/mXpJc++oO6bTTfZCFI85T4XZqmw5aExaVc0tDCR9coe3x9DSk=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:19c8:: with SMTP id
 j8mr1081111qvc.42.1622074151120; Wed, 26 May 2021 17:09:11 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:24 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 05/37] hook: implement hookcmd.<name>.skip
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user wants a specific repo to skip execution of a hook which is set
at a global or system level, they will be able to do so by specifying
'skip' in their repo config:

~/.gitconfig
  [hook.pre-commit]
    command = skippable-oneliner
    command = skippable-hookcmd

  [hookcmd.skippable-hookcmd]
    command = foo.sh

$GIT_DIR/.git/config
  [hookcmd.skippable-oneliner]
    skip = true
  [hookcmd.skippable-hookcmd]
    skip = true

Later it may make sense to add an option like
"hookcmd.<name>.<hook-event>-skip" - but for simplicity, let's start
with a universal skip setting like this.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/hook.txt |  8 ++++++++
 Documentation/git-hook.txt    | 33 +++++++++++++++++++++++++++++++++
 hook.c                        | 35 ++++++++++++++++++++++++++---------
 t/t1360-config-based-hooks.sh | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index 75312754ae..8b12512e33 100644
--- a/Documentation/config/hook.txt
+++ b/Documentation/config/hook.txt
@@ -8,6 +8,14 @@ hookcmd.<name>.command::
 	as a command. This can be an executable on your device or a oneliner for
 	your shell. See linkgit:git-hook[1].
 
+hookcmd.<name>.skip::
+	Specify this boolean to remove a command from earlier in the execution
+	order. Useful if you want to make a single repo an exception to hook
+	configured at the system or global scope. If there is no hookcmd
+	specified for the command you want to skip, you can use the value of
+	`hook.<command>.command` as <name> as a shortcut. The "skip" setting
+	must be specified after the "hook.<command>.command" to have an effect.
+
 hook.runHookDir::
 	Controls how hooks contained in your hookdir are executed. Can be any of
 	"yes", "warn", "interactive", or "no". Defaults to "yes". See
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index f19875ed68..c84520cb38 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -54,6 +54,39 @@ $ git hook list "prepare-commit-msg"
 local: /bin/linter --c
 ----
 
+If there is a command you wish to run in most cases but have one or two
+exceptional repos where it should be skipped, you can use specify
+`hookcmd.<name>.skip`, for example:
+
+System config
+----
+  [hook "pre-commit"]
+    command = check-for-secrets
+
+  [hookcmd "check-for-secrets"]
+    command = /bin/secret-checker --aggressive
+----
+
+Local config
+----
+  [hookcmd "check-for-secrets"]
+    skip = true
+  # This works for inlined hook commands, too:
+  [hookcmd "~/typocheck.sh"]
+    skip = true
+----
+
+After these configs are added, the hook list becomes:
+
+----
+$ git hook list "post-commit"
+global: /bin/linter --c
+local: python ~/run-test-suite.py
+
+$ git hook list "pre-commit"
+no commands configured for hook 'pre-commit'
+----
+
 COMMANDS
 --------
 
diff --git a/hook.c b/hook.c
index 030051cab2..65cbad8dba 100644
--- a/hook.c
+++ b/hook.c
@@ -12,24 +12,25 @@ void free_hook(struct hook *ptr)
 	}
 }
 
-static void append_or_move_hook(struct list_head *head, const char *command)
+static struct hook * find_hook_by_command(struct list_head *head, const char *command)
 {
 	struct list_head *pos = NULL, *tmp = NULL;
-	struct hook *to_add = NULL;
+	struct hook *found = NULL;
 
-	/*
-	 * remove the prior entry with this command; we'll replace it at the
-	 * end.
-	 */
 	list_for_each_safe(pos, tmp, head) {
 		struct hook *it = list_entry(pos, struct hook, list);
 		if (!strcmp(it->command.buf, command)) {
 		    list_del(pos);
-		    /* we'll simply move the hook to the end */
-		    to_add = it;
+		    found = it;
 		    break;
 		}
 	}
+	return found;
+}
+
+static void append_or_move_hook(struct list_head *head, const char *command)
+{
+	struct hook *to_add = find_hook_by_command(head, command);
 
 	if (!to_add) {
 		/* adding a new hook, not moving an old one */
@@ -74,12 +75,22 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
 	if (!strcmp(key, hook_key)) {
 		const char *command = value;
 		struct strbuf hookcmd_name = STRBUF_INIT;
+		int skip = 0;
+
+		/*
+		 * Check if we're removing that hook instead. Hookcmds are
+		 * removed by name, and inlined hooks are removed by command
+		 * content.
+		 */
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.skip", command);
+		git_config_get_bool(hookcmd_name.buf, &skip);
 
 		/*
 		 * Check if a hookcmd with that name exists. If it doesn't,
 		 * 'git_config_get_value()' is documented not to touch &command,
 		 * so we don't need to do anything.
 		 */
+		strbuf_reset(&hookcmd_name);
 		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
 		git_config_get_value(hookcmd_name.buf, &command);
 
@@ -94,7 +105,13 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
 		 *   for each key+value, do_callback(key, value, cb_data)
 		 */
 
-		append_or_move_hook(head, command);
+		if (skip) {
+			struct hook *to_remove = find_hook_by_command(head, command);
+			if (to_remove)
+				remove_hook(&(to_remove->list));
+		} else {
+			append_or_move_hook(head, command);
+		}
 
 		strbuf_release(&hookcmd_name);
 	}
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 141e6f7590..33ac27aa97 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -146,6 +146,41 @@ test_expect_success 'hook.runHookDir = warn is respected by list' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list removes skipped hookcmd' '
+	setup_hookcmd &&
+	test_config hookcmd.abc.skip "true" --add &&
+
+	cat >expected <<-EOF &&
+	no commands configured for hook '\''pre-commit'\''
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list ignores skip referring to unused hookcmd' '
+	test_config hookcmd.abc.command "/path/abc" --add &&
+	test_config hookcmd.abc.skip "true" --add &&
+
+	cat >expected <<-EOF &&
+	no commands configured for hook '\''pre-commit'\''
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list removes skipped inlined hook' '
+	setup_hooks &&
+	test_config hookcmd."$ROOT/path/ghi".skip "true" --add &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
 
 test_expect_success 'hook.runHookDir = interactive is respected by list' '
 	setup_hookdir &&
-- 
2.31.1.818.g46aad6cb9e-goog

