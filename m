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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905CCC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4F7229C6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgLVADq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLVADp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:45 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C70C061257
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:36 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id c1so313942pjo.6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=l4nwN7UBxNOkLOLmU9E9t2L7T24QGATpAFRP9+Jp3qQ=;
        b=qVQ9hC5YElCIBgO5Kz6zFUBSPFfoZadJ5d+jq0ZUklelrslIfcU5XPVZ8+g5F1Hha8
         QHsL+Tj11vuNPY0W3HGULtoQHctEGrdQJ2ZRCZLudZBvt8S+HC1Bu9GORIgVxFOqbBbr
         g1CSAXLKoSGE34WsFYImheqpdkxAsBqrqa+G41cElrOp5/149UBTWhBSckLGbr9bEqDi
         B1+rmffYH07WyTbQ6FTwji2ked97rLGFRx9mObIgeZJbg96xwpL74/STNkMH4qER44W7
         FQCfdzPtrmBu/uMJWjY4gOaUJ+hsbtFMGF/5WYEXODYOg3IjylA4xM2qxnD4G0wlk+f1
         BnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l4nwN7UBxNOkLOLmU9E9t2L7T24QGATpAFRP9+Jp3qQ=;
        b=S669Px6uTKi4vb6fHTn5WcAx/r5sdD39fHepgPQJe1WJczWLBrQo9DhTedSd5XswLk
         5DsYGjATsz/KH8WXGpvRZzIHMyAs/jpHO3XIH5Vr0vxmJzvVurBgPoPWch/CRZtmwKiO
         lDe722jVBGJpbWwpO7FsgYwyaL1Ud1u569hHdub/x5inT7Tz/ndNmUOHyHOBOkE8TTJw
         R3lGBWe1KfherQC0Ws+oAfAuOcDCmWNjJ0Lkcf+CQQAIrKdcJvMUF8oL0ck5SA3GsbVm
         0gclOgByEAUVnXbsMZNZ8YUWguFJPRtMbWm/nHYlibn5w8hhUi2NyWWaH7UplA3BMPKu
         g7mg==
X-Gm-Message-State: AOAM533L/XN5p4XBghJaK3RISiigx/IQXjR3BKanmTV4ykKgE90Ow0iN
        itpXaT787vDHRtofFQWQ3fIHqsOr+oCm56fVzvNYQgAvl7TUimR35M1J5GWDeObM6Xpvys+Jtx2
        9zBm+Dcr0Ke/Od3lW7zL+jdgRYaAf/A+BR5z8IPVkq1PKbwAJ/dO4ShUjZkug0dc2YJKPUfItBA
        ==
X-Google-Smtp-Source: ABdhPJwXCxUhI3aqqaqkvudkLjp3sgJ/+/+AkpESkXzyyu/TTpbqMFc5CB9x/w5dcF8sEoTZ1votpeCRwhDFHuK3BeE=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:b189:b029:dc:4102:4edf with
 SMTP id s9-20020a170902b189b02900dc41024edfmr4964766plr.80.1608595355924;
 Mon, 21 Dec 2020 16:02:35 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:09 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 06/17] hook: implement hookcmd.<name>.skip
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
    In addition to being handy for turning off global hooks one project doesn't
    care about, this setting will be necessary much later for the 'proc-receive'
    hook, which can only cope with up to one hook being specified.
    
    New since v4.
    
    During the Google team's review club I was reminded about this whole
    'skip' option I never implemented. It's true that it's impossible to
    exclude a given hook without this; however, I think I have some more
    work to do on it, so consider it RFC for now and tell me what you think
    :)
     - Emily
    
    During the Google team's review club this week I was reminded about this whole
    'skip' option I never implemented. It's true that it's impossible to exclude
    a given hook without this; however, I think we have some more work to do on it,
    so consider it RFC for now and tell me what you think :)
    
     - Emily

 hook.c                        | 37 +++++++++++++++++++++++++----------
 t/t1360-config-based-hooks.sh | 23 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/hook.c b/hook.c
index ed52e85159..d262503725 100644
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

