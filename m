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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D39C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA2822DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgLEBri (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgLEBri (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2424C061A55
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z29so9213832ybi.23
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wvrSrg5uh1R7ODnVjJP54cmy3dbwabyEERDXi5IHc6c=;
        b=CAw5mcoiSVWoUfrgi2lDPDdIqgUUim2H5jUw6jgnGbDxuTUMbC2k0xQkZ5NcuUNcUF
         bffOjQyATiqQHcV/NQkmqo9pymHNPBHU3Ik0UoyIN1HxgCHEUX07H/CxAGI60Wlfl5bL
         LAkEV+4Q3csGOiMGBMe94I764AIeDJJZYnFdpwFmEdHag9vlMf8YAu5eXjJJyaXDIpRW
         DGsKvLEDvn4lGwML7RLgd+4rfIAFX1DZ+7SE6Q4dP0hzLawl5vQi2Ahr8YJcInso4w3o
         Ba2CeIdzpkvMogFbxgGFNLjSkkF3x24tnskrQ+ys2xtw9K1IpaABhtgLL3cjzG2bWG+8
         85mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wvrSrg5uh1R7ODnVjJP54cmy3dbwabyEERDXi5IHc6c=;
        b=aoOM+UJE1AmW24D1uGHUbC3GtAzWYqxc3eErlt2qW+umhnQptJV7dRFBRBKh22tBxF
         105FeZyftW7mpPDaHTpKAs7Eh561FQXTXWP/5oTpmka7YnjFWN7fNWgjIgRQwyA9dTRw
         71YbPJ4VSRQMPH0j/dpaPef9A3RVbGBxl6UgKJ5St5VBwB64EFBzOnFOkjnMqux8URFW
         qVrVg/0KYF0k8Q02yYtz9SvTouwNwbJDbwRHNgGPzj1iox/fiz7NSyRaKezPBSsjfWca
         O0pIcbwChD/HgsjEewbLSjZ05glI0EfwDnXksw2X75eYcC6Rh/OGEown8tHIvUWHLL9j
         kzIg==
X-Gm-Message-State: AOAM531fLWnHztdIWRaDx6ceeJ30YuZSKwyTrM3JO1JwnnCGRDVXv+Uf
        UZUfJetc8fkciVLMLTFgOCFItOCUOtSGE/uNwLGqgv5vEOQuzwcjBIqLfIBxTNC+N9bI/IgF/2j
        oyLy4ugcWfEgGWNFKSdE7/p5TdZDGbqXdsRnHBehDzs7o/h0epUfw90STdvPWVH1JMwrbRE0Cug
        ==
X-Google-Smtp-Source: ABdhPJy5F6Gs2F/qNdkRZXXNM5Gfx+X7Z83T7eDKPgwRgrY7bOtPxvL274s3ebiCrdgOuEXRigiSdTOu2mAuQcXNVHc=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6902:4a5:: with SMTP id
 r5mr9131695ybs.443.1607132786032; Fri, 04 Dec 2020 17:46:26 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:45:56 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 06/17] hook: implement hookcmd.<name>.skip
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

