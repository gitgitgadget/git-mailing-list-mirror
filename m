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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D69C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFFC6128D
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhE0AKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbhE0AKl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2BC06175F
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d20-20020a25add40000b02904f8960b23e8so3676713ybe.6
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RQEPhYSW+pnU2Ya2fKl3UKob65qngob4CXBszDyv+Tg=;
        b=KWhocE/ezycq+UZT0UJeNdGGf+/+8OXs2/9gniyxgiDkyGXVgyWY6RJAZuGY3uIU4n
         pmvY/JoUli1n2gCczU4Ip120Om6WgP6Xe318t7yliOlY1vFBx8eDi/3kjq58MkXiygVD
         0f+iTl639pSMUZ1M54nQu+LH/geY37oAdw5j9SMKix1ghQaUnHY0BdKcnk74AePTf2oq
         UhTNM4hJbnJ87fN6jDQfiLpomGSPUANS08VnwlkFCi1sTbgI9ap3DxNUAQPvtkGk9uhH
         0HqTzJ3k7GRN6nvtJHoVqFNhYfJbMLZGVVCI57Xtw4fU6rn0kBZyHKoGxqaqQ7Nk+iIb
         T5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RQEPhYSW+pnU2Ya2fKl3UKob65qngob4CXBszDyv+Tg=;
        b=RgTudwwQA/CzCfdJ6KSxZeqvXpn077EelEGHvx9YSoZWj1t88RWJpum1zdBBEeQk13
         FTc2Jqn4vOsjSfzrT+6HIFzaWE8wZSqFGvH0uly4q8W+lieoYjeOoMhx0nXHAbhvtJbE
         DhWQIn5qxplQtcGE3jsEhHQRAeoGSwXu5m+xn2WCwBCKCce91WoZBRSVlTYjr9ygo8Lr
         PRNRHWzRujAaUGAWcjsVThumocj9ccQY9QNgoRPyBhQcG082vz2DtyJFIhxnO5f1rW/i
         LVVefLN1cnUw1dNl2VBnc+SGENcuTnS84j9S1bNxXCsUw5oqwZU+unCxTaC2Sye+en9h
         u9FA==
X-Gm-Message-State: AOAM5303updZJZnNFzOcDfWkaQpHWKL7jrSdj5upiMaMCDSON/wF190x
        P59PjsIhfftqbrPBSAUlvAOOYAPUG4z2H8Y52HXjqTPgq+3VlgkjxT5tSlJ7hTyYvmgJNPEWVWz
        SrdjMwDIrFpZfQTuNV4goCIprzX2p9ddPnI2ga33vGhVSzlig97H0O1IQLu5CeToqXnUAY/xmbg
        ==
X-Google-Smtp-Source: ABdhPJzwgQ47zNeGw1zznHfhSgtnDQrf2LNA+nAdjCeLaNmI85qB6LhM4rkYfAlTmiXcjEOtO7E3MpZfhNQv9iX65jI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6902:1005:: with SMTP id
 w5mr825103ybt.233.1622074147180; Wed, 26 May 2021 17:09:07 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:22 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 03/37] hook: include hookdir hook in list
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
 builtin/hook.c                | 18 +++++++++++++++---
 hook.c                        | 17 +++++++++++++++++
 hook.h                        |  1 +
 t/t1360-config-based-hooks.sh | 19 +++++++++++++++++++
 4 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 79e150437e..e82725f0a6 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -39,10 +39,20 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	list_for_each(pos, head) {
 		struct hook *item = list_entry(pos, struct hook, list);
-		if (item)
-			printf("%s: %s\n",
-			       config_scope_name(item->origin),
+		item = list_entry(pos, struct hook, list);
+		if (item) {
+			/*
+			 * TRANSLATORS: "<config scope>: <path>". Both fields
+			 * should be left untranslated; config scope matches the
+			 * output of 'git config --show-scope'. Marked for
+			 * translation to provide better RTL support later.
+			 */
+			printf(_("%s: %s\n"),
+			       (item->from_hookdir
+				? "hookdir"
+				: config_scope_name(item->origin)),
 			       item->command.buf);
+		}
 	}
 
 	clear_hook_list(head);
@@ -58,6 +68,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 	if (argc < 2)
 		usage_with_options(builtin_hook_usage, builtin_hook_options);
 
+	git_config(git_default_config, NULL);
+
 	if (!strcmp(argv[1], "list"))
 		return list(argc - 1, argv + 1, prefix);
 
diff --git a/hook.c b/hook.c
index d3e28aa73a..b4994fc108 100644
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
@@ -115,6 +117,21 @@ struct list_head* hook_list(const char* hookname)
 
 	git_config(hook_config_lookup, &cb_data);
 
+	if (have_git_dir()) {
+		const char *legacy_hook_path = find_hook(hookname);
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
index 042cab8446..b6c5480325 100644
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
2.31.1.818.g46aad6cb9e-goog

