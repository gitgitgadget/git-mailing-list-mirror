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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7CBC636CD
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E24613DF
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhGOX3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhGOX3W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584BC061762
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k32-20020a25b2a00000b0290557cf3415f8so10057302ybj.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sfGN5CTRkFopdvhgJTzA+sL1lypZEXjczBizc0Qv1sE=;
        b=nbZHoVlzouecjnUrSdSzeCr6sXr8Ax14DjhIQPmqMgklMkYn1yFo+sNkRz0x3mBh0m
         PnGSLwI3lxe+N82T1Bpix7As1VB/RmCQZAO0ow+bXcaqaOwHspKYIZfKaWLnozie3oBn
         4cFukCCFR/e72K6rXhnSf6FUbP6n69e4hMdNJqCGnKAdb1wqba+VEXudZWXGI45Aqrrm
         Trg9A7ogERhjvB6bQ6l1Z7W3NoRWSkrdi8Z0yCvCSzMIaI69GwHD0D4bZeh4h/DbrDgJ
         CUvWqoUpkP3u1ft4u3X2Qlncfidupewga16uy8XKcgzEsO0FxXpDE6e4Eb7bogJLd86K
         sRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sfGN5CTRkFopdvhgJTzA+sL1lypZEXjczBizc0Qv1sE=;
        b=joLTfQoMZ0JPbxZgFdi3myqDPqTWlVcJc7GCK/XvZ+0EvQ/ZmYkDYlTIYnSxxM1mWW
         UrOtweouCS4Wr9k+61uct3OOULVl3JsjI+hye7KYrDtuxI/AuBGsHRdrW1TRuCMaG990
         WG4SXpBqt7suO8JN4VZ/b8SqYA7TCSGTBFEQlS/gH9OywkuHzSeO7PS6ZnvOpf2KwyOi
         7lBM/mb17VIaXDM7nWChMdos7LHPCCuiotVHSJVjN1SR8h/zLR++qfF6jQ2ZS5wfMPEm
         puasKe6KDW//B0bxLoN30bh+n1gCk0cCLBF3WWORAFz7vV8uYjy8A0DMlTpGIJH8khvU
         wFLA==
X-Gm-Message-State: AOAM530QyCiw4zoodBmqDOgGlHAzAWMS1HczIfwa9ka3C7zVnvM3eS9A
        yOyCPmtkXz3QVHN69ssEwUMIKkAoFN2DR5x0u6N9VjYAN3NH6ykCMzEhUQVjD+DbCt/qg5Uwne5
        1Z0XOvFLfJjjVGtSwYQcgj1aJWK8nSfurmRRiKSVk+LGap7KsWkGh2e5GJc+DmWuSVaNw/Fz7dA
        ==
X-Google-Smtp-Source: ABdhPJwhBzYUSWN6ZtQ2+Xo7xPVmsSzbaKl8OKtAx/cDK6jdCOeSqW4yHKbr5VYSw7gfBWuvalNl9JlKhAB1KQLzBWk=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:a25:c054:: with SMTP id
 c81mr9103095ybf.26.1626391587934; Thu, 15 Jul 2021 16:26:27 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:26:03 -0700
In-Reply-To: <20210715232603.3415111-1-emilyshaffer@google.com>
Message-Id: <20210715232603.3415111-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 9/9] hook: implement hookcmd.<name>.skip
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
 Documentation/git-hook.txt    | 30 +++++++++++++++++++++++++++++
 hook.c                        | 31 +++++++++++++++++++++---------
 t/t1360-config-based-hooks.sh | 36 +++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index 5b35170664..6b3776f06f 100644
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
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to the number of processors on
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 1a4d22fd90..fcd13da4ff 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -57,6 +57,36 @@ and prepare-commit-msg hooks in this order:
   /bin/linter --c
   .git/hooks/prepare-commit-msg (if present)
 
+If there is a command you wish to run in most cases but have one or two
+exceptional repos where it should be skipped, you can specify
+`hookcmd.<name>.skip`, for example:
+
+System config
+----
+  [hook "post-commit"]
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
+After these configs are added, and including the earlier example configs, the
+hook list becomes:
+
+post-commit:
+  /bin/linter --c
+  python ~/run-test-suite.py
+  .git/hooks/post-commit (if present)
+
 In general, when instructions suggest adding a script to
 `.git/hooks/<something>`, you can specify it in the config instead by running
 `git config --add hook.<something>.command <path-to-script>` - this way you can
diff --git a/hook.c b/hook.c
index 21904d90f6..5faa1690e4 100644
--- a/hook.c
+++ b/hook.c
@@ -18,6 +18,7 @@ static void free_hook(struct hook *ptr)
  */
 static struct hook * find_hook_by_command(struct list_head *head, const char *command)
 {
+	/* check if the hook is already in the list */
 	struct list_head *pos = NULL, *tmp = NULL;
 	struct hook *found = NULL;
 
@@ -40,7 +41,6 @@ static struct hook * find_hook_by_command(struct list_head *head, const char *co
  */
 static struct hook * append_or_move_hook(struct list_head *head, const char *command)
 {
-	/* check if the hook is already in the list */
 	struct hook *to_add = find_hook_by_command(head, command);
 
 	if (!to_add) {
@@ -175,14 +175,15 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
 	if (!strcmp(key, hook_key)) {
 		const char *command = value;
 		struct strbuf hookcmd_name = STRBUF_INIT;
+		int skip = 0;
 
-
-		if (!command) {
-			strbuf_release(&hookcmd_name);
-			BUG("git_config_get_value overwrote a string it shouldn't have");
-		}
-
-		/* TODO: implement skipping hooks */
+		/*
+		 * Check if we're removing that hook instead. Hookcmds are
+		 * removed by name, and inlined hooks are removed by command
+		 * content.
+		 */
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.skip", command);
+		git_config_get_bool(hookcmd_name.buf, &skip);
 
 		/*
 		 * Check if a hookcmd with that name exists. If it doesn't,
@@ -193,12 +194,24 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
 		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
 		git_config_get_value(hookcmd_name.buf, &command);
 
+		if (!command) {
+			strbuf_release(&hookcmd_name);
+			BUG("git_config_get_value overwrote a string it shouldn't have");
+		}
+
 		/*
 		 * TODO: implement an option-getting callback, e.g.
 		 *   get configs by pattern hookcmd.$value.*
 		 *   for each key+value, do_callback(key, value, cb_data)
 		 */
-		append_or_move_hook(head, command);
+
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
index 50ee824f05..30dc7b6054 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -103,6 +103,42 @@ test_expect_success 'git hook list shows hooks from the hookdir' '
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
+	$ROOT/path/def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
 
 test_expect_success 'inline hook definitions execute oneliners' '
 	test_config hook.pre-commit.command "echo \"Hello World\"" &&
-- 
2.32.0.402.g57bb445576-goog

