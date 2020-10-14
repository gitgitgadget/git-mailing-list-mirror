Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF7FC4363A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A12D22257
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPLqv19l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbgJOByp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbgJOByi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:54:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346AFC08EAC2
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:06 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t4so753871qtd.23
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rgP0+z5JIC8ipIr9bMvY+BnU+XsgUIaNny6z7kLU62g=;
        b=IPLqv19lVKfYbAE7dCu8BL+w+Rby3kwt2a72S+v30AfSK/YbT+Q3DcUW7FMGU3ZwgI
         P5mvZCE28HF1bMT5VtHRsPTu4X3mdDb7NtdbCYHXD72FLPJlgNLktRspDsKN434llVjI
         Is880GTc39b+2onvn7h2clMnfF5hAGEXeJZZtonIJo6BbZ7IyTuM2S6Atxhz2Pxn4/ou
         qQf85GGJD1Dw286wXqO9jARMYc6Lzs/8UYjSK4xpC1ysDAfNbQbd3AQpUE1TkwAP+igW
         8f2hHeB+NoTLwCEfeCny7R12ZYDHKBE6cL91i7mk0O4fAl36HRakPrMXJnIHpeYSVpnt
         6+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rgP0+z5JIC8ipIr9bMvY+BnU+XsgUIaNny6z7kLU62g=;
        b=FKbnI12itr2BOdWNsI2YZJDBwxXyLOyerW/ap5Vv8QMsslTBeMArFobhZHIb677qxU
         UMS+bCLsVuukdytqmdAuZ40S5PXUnSmQiBvX3gTMeZRolnj58J1dYiB+ZM8k/LdOae+I
         siQXTBuyUEeA3ByDvwpBBX6w8JXTKMRs/33AfAdEGtK4NnG3KLQBzwwwqCSAKYj+iBMu
         4fLB0t904yJvZxpp2p19/hfX7yN2u2tztPkKjSN327aakvhzYxrJAvFM1ySuHBvlmWMG
         k2/3BmoOmRiDCTtXwYkC8m0fLjif9UCHG0c7ywUYWyI5IaMSCuvxgjPJHncizhxejA7y
         8OIQ==
X-Gm-Message-State: AOAM533bcyCuqToe253QCB1j0r+8IPENa9GH6BGmmWVfdYc5KYap7Req
        wctqnFhqpWBPemgux9iaJ5mBZR2PP2DDtQoqDF08XZA0bsiexG/4I/8XPPPOFPvDjMdBOXnIsm5
        d7fFsI+UUKbW+GgLdoywOs9vp7zZFy7aa18FoftT+b2nWPhJlNtpssjHIyF9J5Moa7rNE+/YOWw
        ==
X-Google-Smtp-Source: ABdhPJxE5f82WzB5V6fSkX6GO8aGgtlyRxgIsx11CWAez3O/kb368pXpJXt7cAJB7PrF/5RmgEcLQVa6wjowcmnpL74=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:a2a6:: with SMTP id
 g35mr1794550qva.4.1602717905253; Wed, 14 Oct 2020 16:25:05 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:24:44 -0700
In-Reply-To: <20201014232447.3050579-1-emilyshaffer@google.com>
Message-Id: <20201014232447.3050579-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201014232447.3050579-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH v5 5/8] hook: implement hookcmd.<name>.skip
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user wants a specific repo to skip execution of a hook which is set
at a global or system level, they can now do so by specifying 'skip' in
their repo config:

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

Notes:
    New since v4.
    
    During the Google team's review club I was reminded about this whole
    'skip' option I never implemented. It's true that it's impossible to
    exclude a given hook without this; however, I think I have some more
    work to do on it, so consider it RFC for now and tell me what you think
    :)
     - Emily

 hook.c                        | 37 +++++++++++++++++++++++++----------
 t/t1360-config-based-hooks.sh | 23 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/hook.c b/hook.c
index 340e5a35c8..f4084e33c8 100644
--- a/hook.c
+++ b/hook.c
@@ -12,23 +12,24 @@ void free_hook(struct hook *ptr)
 	}
 }
 
-static void append_or_move_hook(struct list_head *head, const char *command)
+static struct hook* find_hook_by_command(struct list_head *head, const char *command)
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
@@ -41,7 +42,7 @@ static void append_or_move_hook(struct list_head *head, const char *command)
 	/* re-set the scope so we show where an override was specified */
 	to_add->origin = current_config_scope();
 
-	list_add_tail(&to_add->list, pos);
+	list_add_tail(&to_add->list, head);
 }
 
 static void remove_hook(struct list_head *to_remove)
@@ -73,8 +74,18 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
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
 
 		/* Check if a hookcmd with that name exists. */
+		strbuf_reset(&hookcmd_name);
 		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
 		git_config_get_value(hookcmd_name.buf, &command);
 
@@ -89,7 +100,13 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
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
index 91127a50a4..ebd3bc623f 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -132,6 +132,29 @@ test_expect_success 'hook.runHookDir = warn is respected by list' '
 	test_i18ncmp expected actual
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
+	test_i18ncmp expected actual
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
2.28.0.rc0.142.g3c755180ce-goog

