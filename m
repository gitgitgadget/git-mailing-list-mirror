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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B36EC432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A461100
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbhHSDfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbhHSDfp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 23:35:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA1C0617AF
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:35:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso5218374ybn.2
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=psBwRW3Smh7pS835dsMUT4AYNFbKbJBjRrVf96skj6Y=;
        b=RzOHyVb/2rOB/xthItDwsmFSh2oQe4Y6HSzzALaxuDPHP5Qf9rFAizYRixPIdbbY5t
         dVWFdbcporXqvle8TNb/JojzNyQQd1V0H4rrjWIeXpRU90loEbPLMAE2knuOYln7W2uz
         2ljpdbSYatcs+EVCdxhS31KNisPmpLxnOhrRCWzRPMMX4IJJdPQGuY9e/OHP1lTQZiZN
         LJtbCs62BKCoBYCYjYy+VKIaS+ZpE//waDzO5RHKlI3E+TOnUOUHGuRP+5qvA0eTw23O
         C57e8gxJawqd15FdZRyYKrnUqvjb9MCzJKR1gmQ+Co50v3weVwEGzGOce7DIwiHN27eo
         dhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=psBwRW3Smh7pS835dsMUT4AYNFbKbJBjRrVf96skj6Y=;
        b=uXZY6nmM2eVpKPk505IL7wMPGTCkcLo+4KwUBvT8W9Oq6+Z9GmC77uaMmRWYkGY9NG
         Kw35x8nUPYe4bAlBm11JRSswhLsfz6jgpKsVXHttbEMWbHgX57gfTUkXTl2LBg7XO0cm
         dfkZjkKcHl2Ra6c+FvxDJzJMqA11e+az9CH3ypaTzzs3dBZ3S0HabtnCvrSJSZ47r+bA
         Y20CjtqlA8zentbnZYU026lu4xmUuRDSWtdrFVDuutJGrVXX0+vOBItjBGwc35TYwsuU
         lM9w3sCa3AHF+8dD4vrnaLK4R+q1O9gIE6tA50PsF1lmGGaXlJrcFNtwhXKKAJnYylGj
         DyPA==
X-Gm-Message-State: AOAM5329Qtc4rEiOXNFL+32v22L/iGJDf73pD/jorm6rW5USRIOO2srf
        5G0jB0+qHKuGbei25B3Bur/XR9YJupzl5Zh6zdiT5XAD8bPoKnF6k2Xf1WCDNQ6NEH7lwAFygOI
        P/w5vZkKi+sphCXXtB7b/y9To6pgf2Q7TZ0TMeAHPRinDCK2xSLlMx+W1MA5UGPQMG1o+32mw9w
        ==
X-Google-Smtp-Source: ABdhPJxrafV9AQsJy5GggvEStq0XG6Sr6iCaTaC2MXOzt72JDWjnHADev+6PSBNV+T3k/Yb5uEvFjQBgCAoYUzyHK2o=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:b5ce:: with SMTP id
 d14mr16019006ybg.415.1629344107547; Wed, 18 Aug 2021 20:35:07 -0700 (PDT)
Date:   Wed, 18 Aug 2021 20:34:50 -0700
In-Reply-To: <20210819033450.3382652-1-emilyshaffer@google.com>
Message-Id: <20210819033450.3382652-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819033450.3382652-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 6/6] hook: allow out-of-repo 'git hook' invocations
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since hooks can now be supplied via the config, and a config can be
present without a gitdir via the global and system configs, we can start
to allow 'git hook run' to occur without a gitdir. This enables us to do
things like run sendemail-validate hooks when running 'git send-email'
from a nongit directory.

It still doesn't make sense to look for hooks in the hookdir in nongit
repos, though, as there is no hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    For hookdir hooks, do we want to run them in nongit dir when core.hooksPath
    is set? For example, if someone set core.hooksPath in their global config and
    then ran 'git hook run sendemail-validate' in a nongit dir?

 git.c           |  2 +-
 hook.c          |  2 +-
 t/t1800-hook.sh | 20 +++++++++++++++-----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/git.c b/git.c
index 540909c391..39988ee3b0 100644
--- a/git.c
+++ b/git.c
@@ -538,7 +538,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
-	{ "hook", cmd_hook, RUN_SETUP },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
index 581d87cbbd..2e08156546 100644
--- a/hook.c
+++ b/hook.c
@@ -218,7 +218,7 @@ struct list_head *list_hooks_gently(const char *hookname)
 
 	/* Add the hook from the hookdir. The placeholder makes it easier to
 	 * allocate work in pick_next_hook. */
-	if (find_hook_gently(hookname))
+	if (have_git_dir() && find_hook_gently(hookname))
 		append_or_move_hook(hook_head, NULL);
 
 	return hook_head;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index ef2432f53a..a7e45c0d16 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -118,15 +118,25 @@ test_expect_success 'git hook run -- pass arguments' '
 	test_cmp expect actual
 '
 
-test_expect_success 'git hook run -- out-of-repo runs excluded' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	echo Test hook
-	EOF
+test_expect_success 'git hook run: out-of-repo runs execute global hooks' '
+	test_config_global hook.global-hook.event test-hook --add &&
+	test_config_global hook.global-hook.command "echo no repo no problems" --add &&
+
+	echo "global-hook" >expect &&
+	nongit git hook list test-hook >actual &&
+	test_cmp expect actual &&
+
+	echo "no repo no problems" >expect &&
 
-	nongit test_must_fail git hook run test-hook
+	nongit git hook run test-hook 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
 	mkdir my-hooks &&
 	write_script my-hooks/test-hook <<-\EOF &&
 	echo Hook ran $1 >>actual
-- 
2.33.0.rc2.250.ged5fa647cd-goog

