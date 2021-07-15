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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D5C636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC36613DC
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhGOX3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGOX3U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB3C061760
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x15-20020a25ce0f0000b029055bb0981111so9986171ybe.7
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eKB7ODy10YLtEQDpCWNy+G5xovtxFYrb/dABv3sbur0=;
        b=F/8PUE7FVblM83+eqYzfK3t5CsaBHNBlU/QbAttbNvVuswqrDR0ySY+xUuJSyfRRA4
         fHd9FlhRu1C1V7mDMmJI0mudFP5tdz0eXmfFOeUlx2DAsKtRyukUgeTe7U+iQMyLVOTP
         lnI7rHKvWYIw1tiGDfjjqRMfgE3KgA8EzX1x5HsEU+Uw9ejZtW41A17jdrP2hKkkKzSn
         GlsOdT//ETwFFz4bhs2A99Q022azLUA8IQ47L7l0m6cZa+71ygC7XfJjKl6zOaHe9smW
         4CRIrUyyhC5DBkGII7r9kSYSW7vyG9etMaKDdu0DorAt1KtxpTEJXTDe0Q8E/53LPn1J
         doJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eKB7ODy10YLtEQDpCWNy+G5xovtxFYrb/dABv3sbur0=;
        b=PY53YVhOGL6pz9Caoe8A565z4LPqDpcockr1jguGKmngSEo/vPS2VuZhnB+CPamInj
         wIt9kYGnD2KP3HA4FnxzgQSyzqgyLo9mwBuFAi8IDI4qsNZwnKemAjJbz53pi3iQn8zw
         czPVaLvQJhW55FEs7mxChJWy11FMJXBVjU7at349egNY9SueFxsvUYNekpOI1murZJdQ
         AtlXpuZiieAwr3g6Iwb9V98QpqE71UUNnESm6n1lx2MYXqj+YZper2qrZcNi9jNhp/Xn
         qqcpO8TcbPEbANUAwKcPyc52U+g9lFZXgkOoHB/euTVKz3v4ge9rfB8Y1P6/mfjnstrH
         z2ng==
X-Gm-Message-State: AOAM530//m5enzMEe2du/4YT0MRX+4qr+44Bo7FTrLWJLX/Dy/tokHDM
        d/pANfh79kqw2UidU+AVd/66p9bkqxGgkNJ/wqwaNWVUSOBFJCXcjoulDKLfh92tw8ngHgcsaWR
        QlTcFurLV5JbdZkgu2bunMkqQvU4NgVqfxh3jkNL5zuub1et/T+B/f0CN0drygxrA+vcpVaZ4Ng
        ==
X-Google-Smtp-Source: ABdhPJz3Wpwh9z6ZHBlOBRdKWP+Rz82WqqIr9CS5rlYcwynXzMq1kHKYalZL+IN9cJO8oxmdyMY4+m94ec+XKVVzmxg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:a25:2c8a:: with SMTP id
 s132mr9652405ybs.148.1626391585639; Thu, 15 Jul 2021 16:26:25 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:26:02 -0700
In-Reply-To: <20210715232603.3415111-1-emilyshaffer@google.com>
Message-Id: <20210715232603.3415111-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To enable fine-grained options which apply to a single hook executable,
and to make it easier for a single executable to be run on multiple hook
events, teach "hookcmd.<alias>.config". These can be configured as
follows:

  [hookcmd.my-linter]
    command = ~/my-linter.sh
  [hook.pre-commit]
    command = my-linter

During the config parse, we can attempt to dereference the
'hook.pre-commit.command' string 'my-linter' and check if it matches any
hookcmd names; if so, we can run the command associated with that
hookcmd alias instead.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/hook.txt |  5 +++++
 Documentation/git-hook.txt    | 42 +++++++++++++++++++++++++++++++----
 hook.c                        |  9 +++++++-
 t/t1360-config-based-hooks.sh | 19 ++++++++++++++++
 4 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index a97b980cca..5b35170664 100644
--- a/Documentation/config/hook.txt
+++ b/Documentation/config/hook.txt
@@ -3,6 +3,11 @@ hook.<command>.command::
 	executable on your device, a oneliner for your shell, or the name of a
 	hookcmd. See linkgit:git-hook[1].
 
+hookcmd.<name>.command::
+	A command to execute during a hook for which <name> has been specified
+	as a command. This can be an executable on your device or a oneliner for
+	your shell. See linkgit:git-hook[1].
+
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to the number of processors on
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 8e2ab724e8..1a4d22fd90 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -18,10 +18,44 @@ This command is an interface to git hooks (see linkgit:githooks[5]).
 Currently it only provides a convenience wrapper for running hooks for
 use by git itself. In the future it might gain other functionality.
 
-This command parses the default configuration files for sections like `hook
-"<hook name>"`. `hook` is used to describe the commands which will be run during
-a particular hook event; commands are run in the order Git encounters them
-during the configuration parse (see linkgit:git-config[1]).
+This command parses the default configuration files for sections `hook` and
+`hookcmd`. `hook` is used to describe the commands which will be run during a
+particular hook event; commands are run in the order Git encounters them during
+the configuration parse (see linkgit:git-config[1]). `hookcmd` is used to
+describe attributes of a specific command. If additional attributes don't need
+to be specified, a command to run can be specified directly in the `hook`
+section; if a `hookcmd` by that name isn't found, Git will attempt to run the
+provided value directly. For example:
+
+Global config
+----
+  [hook "post-commit"]
+    command = "linter"
+    command = "~/typocheck.sh"
+
+  [hookcmd "linter"]
+    command = "/bin/linter --c"
+----
+
+Local config
+----
+  [hook "prepare-commit-msg"]
+    command = "linter"
+  [hook "post-commit"]
+    command = "python ~/run-test-suite.py"
+----
+
+With these configs, you'd then run post-commit hooks in this order:
+
+  /bin/linter --c
+  ~/typocheck.sh
+  python ~/run-test-suite.py
+  .git/hooks/post-commit (if present)
+
+and prepare-commit-msg hooks in this order:
+
+  /bin/linter --c
+  .git/hooks/prepare-commit-msg (if present)
 
 In general, when instructions suggest adding a script to
 `.git/hooks/<something>`, you can specify it in the config instead by running
diff --git a/hook.c b/hook.c
index b08b876d5d..21904d90f6 100644
--- a/hook.c
+++ b/hook.c
@@ -184,7 +184,14 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
 
 		/* TODO: implement skipping hooks */
 
-		/* TODO: immplement hook aliases */
+		/*
+		 * Check if a hookcmd with that name exists. If it doesn't,
+		 * 'git_config_get_value()' is documented not to touch &command,
+		 * so we don't need to do anything.
+		 */
+		strbuf_reset(&hookcmd_name);
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
+		git_config_get_value(hookcmd_name.buf, &command);
 
 		/*
 		 * TODO: implement an option-getting callback, e.g.
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index e4a7b06ad1..50ee824f05 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -18,6 +18,11 @@ setup_hooks () {
 	test_config_global hook.pre-commit.command "/path/def" --add
 }
 
+setup_hookcmd () {
+	test_config hook.pre-commit.command "abc" --add
+	test_config_global hookcmd.abc.command "/path/abc" --add
+}
+
 setup_hookdir () {
 	mkdir .git/hooks
 	write_script .git/hooks/pre-commit <<-EOF
@@ -59,6 +64,20 @@ test_expect_success 'git hook list orders by config order' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list dereferences a hookcmd' '
+	setup_hooks &&
+	setup_hookcmd &&
+
+	cat >expected <<-EOF &&
+	$ROOT/path/def
+	$ROOT/path/ghi
+	$ROOT/path/abc
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'git hook list reorders on duplicate commands' '
 	setup_hooks &&
 
-- 
2.32.0.402.g57bb445576-goog

