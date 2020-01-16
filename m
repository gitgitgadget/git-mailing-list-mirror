Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCCBC33CB3
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5234D20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN7xidZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgAPGO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40188 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgAPGOt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2431109wmi.5
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hi3lfEf9XngD5/G24FIw9eQo7vkdJtfjPwLbEjO2TyI=;
        b=hN7xidZtr0ScQgbAASx7+IvBfTbvzdJnD7WbzUxkxxDpflDNWRjNeWe/KEq6wXuUva
         r0w1+Birr9M/qrVLdbE61eZ1ArMUcE+ey1u9bqFtekSstGFvHmtXgTRphiRkRe+irGWK
         F2PTVE/337BGTdf9y0yasxQl6LSI0rnvWEIHizKm1S2S96GyTVj41VVZEeNmHhgFv3Fj
         sqDqs6e0fgt6LdIiDhloEgcQQZfJWjSUVRhdea0q90964gU1tzB5WfR74oOAsebP7LvG
         Tc2WF9GBlF4XC5ruq/fLCpMBzdxpeIogFhRoCWQQF19nrvDdr8Q9kVIyluDlyqvwj42X
         G3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hi3lfEf9XngD5/G24FIw9eQo7vkdJtfjPwLbEjO2TyI=;
        b=PjZSI3R1lQTBmJDw2hLcx8/cYCmPaqWFQno9NLmlYIXt7odsITsV+63mYv+IpCXkw0
         nNC4XGTuH9K8AkxAy6Omor3CQ7S0Og2l5ZSoZ7RWimywzoZpCt1NbxB67VjmUVAyiQJq
         Gu+B39yEdSQ6tPCMgAnRsXkkQ38pa/L8dXabBzhFbnh2kL7yrmrtqFZntAVU9+N10pz/
         4ZuXDXY9NTJ/wDHWFXghcn0aG9bFr59NBt593dmjy2JJB3yRO/jN9Jb9CrH6u3nqOj5S
         51zAlBMCmSnp/0LuQcrZnBJbvFkO7iLBz2PSefJQmHRSYr1eY/xFTyDSAXMYNfYR8idF
         AbQA==
X-Gm-Message-State: APjAAAVOGLnuLEoAt1S+Rxfps8KJc88p7t8GzhkavoX1bwrIXRZDcosh
        JvCUL0e2dZ1UXuuQznhltOprsIYB
X-Google-Smtp-Source: APXvYqyajPEfhe+AJC4WN/uImPIYE1rQLO95dBw34JfEekuIr041AkL/QrPgTITHU54+iL+PXnjeSQ==
X-Received: by 2002:a05:600c:24ca:: with SMTP id 10mr4055157wmu.4.1579155286803;
        Wed, 15 Jan 2020 22:14:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm1478423wmc.8.2020.01.15.22.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:46 -0800 (PST)
Message-Id: <413e190ac9ae1e701a807a6c846789ae7df35896.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:29 +0000
Subject: [PATCH v4 15/19] rebase: drop '-i' from the reflog for
 interactive-based rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A large variety of rebase types are supported by the interactive
machinery, not just the explicitly interactive ones.  These all share
the same code and write the same reflog messages, but the "-i" moniker
in those messages doesn't really have much meaning.  It also becomes
somewhat distracting once we switch the default from the am-backend to
the interactive one.  Just remove the "-i" from these messages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c              |  2 +-
 sequencer.c                   | 12 ++++++------
 t/t3404-rebase-interactive.sh | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6884590258..ecd23d3ee7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1441,7 +1441,7 @@ static void set_reflog_action(struct rebase_options *options)
 	if (env && strcmp("rebase", env))
 		return; /* only override it if it is "rebase" */
 
-	strbuf_addf(&buf, "rebase -i (%s)", options->action);
+	strbuf_addf(&buf, "rebase (%s)", options->action);
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, buf.buf, 1);
 	strbuf_release(&buf);
 }
diff --git a/sequencer.c b/sequencer.c
index 078a68eaf3..cca503c11b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -290,7 +290,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 			char *eol = strchr(p, '\n');
 			if (eol)
 				*eol = '\0';
-			if (delete_ref("(rebase -i) cleanup", p, NULL, 0) < 0) {
+			if (delete_ref("(rebase) cleanup", p, NULL, 0) < 0) {
 				warning(_("could not delete '%s'"), p);
 				ret = -1;
 			}
@@ -324,7 +324,7 @@ static const char *action_name(const struct replay_opts *opts)
 	case REPLAY_PICK:
 		return N_("cherry-pick");
 	case REPLAY_INTERACTIVE_REBASE:
-		return N_("rebase -i");
+		return N_("rebase");
 	}
 	die(_("unknown action: %d"), opts->action);
 }
@@ -628,7 +628,7 @@ static int do_recursive_merge(struct repository *r,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		/*
 		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
-		 * "rebase -i".
+		 * "rebase".
 		 */
 		return error(_("%s: Unable to write new index file"),
 			_(action_name(opts)));
@@ -2885,8 +2885,8 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	int next = todo_list->current, offset, fd;
 
 	/*
-	 * rebase -i writes "git-rebase-todo" without the currently executing
-	 * command, appending it to "done" instead.
+	 * interactive backend writes "git-rebase-todo" without the currently
+	 * executing command, appending it to "done" instead.
 	 */
 	if (is_rebase_i(opts))
 		next++;
@@ -3197,7 +3197,7 @@ static int do_label(struct repository *r, const char *name, int len)
 		return error(_("illegal label name: '%.*s'"), len, name);
 
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
-	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
+	strbuf_addf(&msg, "rebase (label) '%.*s'", len, name);
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction) {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c41531f349..a31583eb2f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -223,7 +223,7 @@ test_expect_success 'reflog for the branch shows state before rebase' '
 '
 
 test_expect_success 'reflog for the branch shows correct finish message' '
-	printf "rebase -i (finish): refs/heads/branch1 onto %s\n" \
+	printf "rebase (finish): refs/heads/branch1 onto %s\n" \
 		"$(git rev-parse branch2)" >expected &&
 	git log -g --pretty=%gs -1 refs/heads/branch1 >actual &&
 	test_cmp expected actual
@@ -1162,10 +1162,10 @@ test_expect_success 'rebase -i produces readable reflog' '
 	git branch -f branch-reflog-test H &&
 	git rebase -i --onto I F branch-reflog-test &&
 	cat >expect <<-\EOF &&
-	rebase -i (finish): returning to refs/heads/branch-reflog-test
-	rebase -i (pick): H
-	rebase -i (pick): G
-	rebase -i (start): checkout I
+	rebase (finish): returning to refs/heads/branch-reflog-test
+	rebase (pick): H
+	rebase (pick): G
+	rebase (start): checkout I
 	EOF
 	git reflog -n4 HEAD |
 	sed "s/[^:]*: //" >actual &&
-- 
gitgitgadget

