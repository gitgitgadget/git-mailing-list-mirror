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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4FBC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DE164FAF
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhCKCLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCKCK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:10:59 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9FC061762
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:58 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id b78so14304097qkg.13
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PGWwGCCl7uxnqzvZ0XsMsktSth1oIo2y9XcFCqZtCBc=;
        b=lWR5T5ps9R7j5DSRcokNjXXUrYxFM8vyUXLXLviglkG7TOWX/RVGKUKXg0uMflThzr
         DHM4zIztRa4sWIWlAZL+aLu3cw2kEtLU3KHz4PLlWxTxWQGkixOdSv0JWro278Fk9Xj7
         oji0NKV54K2GFH7HL720geuN8hbyYppLqbVlvuDwltC6TzZe9qcEWafHhnhW6oY7bnXZ
         BXgMIPZbvxzaYjisN+w/bZw7eik0dO5czf+Wjnh5PJT5ROCH+H+8KLNDEyE2FeBNfQkC
         unG+DZhl15eKRdq9mr9fIle9aVzaMVZArRlY2gwMpXeOPId2EirX6WFriWUqAOvLxGGG
         q3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PGWwGCCl7uxnqzvZ0XsMsktSth1oIo2y9XcFCqZtCBc=;
        b=s0ieiR78VQVVF7/vgXt9pt9KaAdB/4jGao/CWOVbDdguEf79eFT85F694lf3MoAqz3
         rGWGxKxZtY3hOSLi3Laow7pGwEJ4VbRvTXA2OGsiMomBaFbxk/33jW0nDPzraqNl/kAk
         hM0bJq2jUHGDbfLs2NPKr/Ydbzl2o/YIhIXYb1AOljUmSpczl1ZI2EPQGV5cPdEPWPox
         tWB8IDVCUW/ukObsh/GdpEgLNHiZaXOAcUL7BOKYroszeG9PYVN/EKT4hJTRS/L/433J
         J/qh8/zmFJgmMQhnDseXzRfuHDV8UpfH6nQqk/QMFxVn3qPM1/2DFvWISq8vL/gszlZT
         ycGA==
X-Gm-Message-State: AOAM533Jk0g0DFyaH1OjmZP1dGQhGtMGk1bLyx2uZRHu9KElxwoahIHu
        f0AyhOuLmrYkITdF0uH9doN1QEZc3w0avUkeOHPL2yduOy3XaC0EqpGR9WAQ1Q1/dl4Ssn/T4aI
        W4q2LyJBJwvwOVQFaayQ6Z6AKjYWHBxwuDBqRowMq2E1LaT2IZSUiLRNCivMRDA2cpdE12SZDUw
        ==
X-Google-Smtp-Source: ABdhPJzvCNqQ3tYG7XKE191V+WgRySxjPme9mUGUJk6bI0XKkGi4yW/Wzyc5hlCy+iaSjTKsT3CqFui7qP+DRnauqMg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:1484:: with SMTP id
 bn4mr6066096qvb.8.1615428657927; Wed, 10 Mar 2021 18:10:57 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:04 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 04/37] hook: include hookdir hook in list
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Historically, hooks are declared by placing an executable into
$GIT_DIR/hooks/$HOOKNAME (or $HOOKDIR/$HOOKNAME). Although hooks taken
from the config are more featureful than hooks placed in the $HOOKDIR,
those hooks should not stop working for users who already have them.
Let's list them to the user, but instead of displaying a config scope
(e.g. "global: blah") we can prefix them with "hookdir:".

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v7, fix some nits from Jonathan Tan. The largest is to move reference to
    "hookdir annotation" from this commit to the next one which introduces the
    hook.runHookDir option.

 builtin/hook.c                | 11 +++++++++--
 hook.c                        | 17 +++++++++++++++++
 hook.h                        |  1 +
 t/t1360-config-based-hooks.sh | 19 +++++++++++++++++++
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index bb64cd77ca..c8fbfbb39d 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -40,10 +40,15 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	list_for_each(pos, head) {
 		struct hook *item = list_entry(pos, struct hook, list);
-		if (item)
+		item = list_entry(pos, struct hook, list);
+		if (item) {
+			/* Don't translate 'hookdir' - it matches the config */
 			printf("%s: %s\n",
-			       config_scope_name(item->origin),
+			       (item->from_hookdir
+				? "hookdir"
+				: config_scope_name(item->origin)),
 			       item->command.buf);
+		}
 	}
 
 	clear_hook_list(head);
@@ -60,6 +65,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 	if (argc < 2)
 		usage_with_options(builtin_hook_usage, builtin_hook_options);
 
+	git_config(git_default_config, NULL);
+
 	if (!strcmp(argv[1], "list"))
 		return list(argc - 1, argv + 1, prefix);
 
diff --git a/hook.c b/hook.c
index fede40e925..080e25696b 100644
--- a/hook.c
+++ b/hook.c
@@ -2,6 +2,7 @@
 
 #include "hook.h"
 #include "config.h"
+#include "run-command.h"
 
 void free_hook(struct hook *ptr)
 {
@@ -35,6 +36,7 @@ static void append_or_move_hook(struct list_head *head, const char *command)
 		to_add = xmalloc(sizeof(*to_add));
 		strbuf_init(&to_add->command, 0);
 		strbuf_addstr(&to_add->command, command);
+		to_add->from_hookdir = 0;
 	}
 
 	/* re-set the scope so we show where an override was specified */
@@ -115,6 +117,21 @@ struct list_head* hook_list(const struct strbuf* hookname)
 
 	git_config(hook_config_lookup, &cb_data);
 
+	if (have_git_dir()) {
+		const char *legacy_hook_path = find_hook(hookname->buf);
+
+		/* Unconditionally add legacy hook, but annotate it. */
+		if (legacy_hook_path) {
+			struct hook *legacy_hook;
+
+			append_or_move_hook(hook_head,
+					    absolute_path(legacy_hook_path));
+			legacy_hook = list_entry(hook_head->prev, struct hook,
+						 list);
+			legacy_hook->from_hookdir = 1;
+		}
+	}
+
 	strbuf_release(&hook_key);
 	return hook_head;
 }
diff --git a/hook.h b/hook.h
index e48dfc6d27..a97d43670d 100644
--- a/hook.h
+++ b/hook.h
@@ -11,6 +11,7 @@ struct hook {
 	enum config_scope origin;
 	/* The literal command to run. */
 	struct strbuf command;
+	unsigned from_hookdir : 1;
 };
 
 /*
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 6e4a3e763f..0f12af4659 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -23,6 +23,14 @@ setup_hookcmd () {
 	test_config_global hookcmd.abc.command "/path/abc" --add
 }
 
+setup_hookdir () {
+	mkdir .git/hooks
+	write_script .git/hooks/pre-commit <<-EOF
+	echo \"Legacy Hook\"
+	EOF
+	test_when_finished rm -rf .git/hooks
+}
+
 test_expect_success 'git hook rejects commands without a mode' '
 	test_must_fail git hook pre-commit
 '
@@ -85,4 +93,15 @@ test_expect_success 'git hook list reorders on duplicate commands' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list shows hooks from the hookdir' '
+	setup_hookdir &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.31.0.rc2.261.g7f71774620-goog

