Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC491F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 17:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbfJPR0j (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 13:26:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37297 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388525AbfJPR0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 13:26:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so15156912pfo.4
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fu1dpc9XKUP03S1WoDVX5vWi9ZpeyFSpINZzMSV6kC4=;
        b=amXmmYNwAELGaxARdDhRp3Qc5259UXlwAI5FyrdH8/Iy5R0mttW5iifp2Ppu3VOfbQ
         Iaxy2uKJpKSIbsPrCXz3pddy3Y3sFiooyZ14KEPHL54JBidrKNPKFsxv+7DcguISiuFv
         j1F3qjp62L+lgKbak40Y9Uy7JvG0P+gsBXNCynET7aSepZWP5SbwX19mI9IGKtx3p90s
         qhN9BSYNRrKpdQVHA9S5sH0L2WYUpZfehbtckF4ug1YAKWAEK91dDMu4tLQ3zTFoCwyK
         /HZXD8NE1rly6D8iJjro3LUdWoCkE57TyrNo/xvrbb810FTcIkdOeHW33DMHuFfugTlN
         hjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fu1dpc9XKUP03S1WoDVX5vWi9ZpeyFSpINZzMSV6kC4=;
        b=Ht3POW6WMa0iCH+XGAPnVRU42x4Zq2zh+BjHgNDOzim2v9YXkV4i7sgCxopunoJMf3
         5w+VTZ50fzwtJG+l9LJ6MuIKTNehONnYkYoZpNrNP3kesOrn1CyXdVuNBQVjgsfdcptR
         8y1FpULISSRxT1+IQ1RHLNKpw2C47OEBi3vFvFlh535y6yNJI5T+aOKVfbSKcBElZuAu
         vDYHHmtdaqkteQJA8hPW28zj502e4iX7Kmh76y5DV6CytBRznTIbWHPZnqCgcq5SfX0k
         nbsU2cFZM8fvbEk48q2CYzdhM8ZObU7MBBIJWp7P4h+Pp0XMcmdpFGVEAYQPWH8kcKIJ
         C+AQ==
X-Gm-Message-State: APjAAAUjn8MUhOZHh8cmzahtW+ozkR19O3YKp7T57u2tbAeO+sH/CQ19
        sFO+8wp+sTfOgOBPlGk6CKVWLfZF
X-Google-Smtp-Source: APXvYqzoHmogXBRwM/4X+Y7CcrFjbNPmoBTUte1jXSrnAPd/PfPWUsrDW6COMByXvDqpDcY6yFMmdw==
X-Received: by 2002:a17:90a:f001:: with SMTP id bt1mr6522936pjb.2.1571246796677;
        Wed, 16 Oct 2019 10:26:36 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id v8sm9290338pje.6.2019.10.16.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:26:36 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:26:34 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 7/7] merge: teach --autostash option
Message-ID: <f43c10e4818c91a8c6e9d5e0ce2a04710db3e300.1571246693.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571246693.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In rebase, one can pass the `--autostash` option to cause the worktree
to be automatically stashed before continuing with the rebase. This
option is missing in merge, however.

Implement the `--autostash` option and corresponding `merge.autoStash`
option in merge which stashes before merging and then pops after.

Reported-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/merge.c | 13 +++++++++++++
 builtin/pull.c  |  9 +++++----
 t/t5520-pull.sh |  8 --------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 062e911441..d1a5eaad0d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -40,6 +40,7 @@
 #include "branch.h"
 #include "commit-reach.h"
 #include "wt-status.h"
+#include "autostash.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -58,6 +59,8 @@ static const char * const builtin_merge_usage[] = {
 	NULL
 };
 
+static GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
+
 static int show_diffstat = 1, shortlog_len = -1, squash;
 static int option_commit = -1;
 static int option_edit = -1;
@@ -81,6 +84,7 @@ static int show_progress = -1;
 static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
+static int autostash;
 static int no_verify;
 
 static struct strategy all_strategy[] = {
@@ -285,6 +289,8 @@ static struct option builtin_merge_options[] = {
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+	OPT_BOOL(0, "autostash", &autostash,
+	      N_("automatically stash/stash pop before and after")),
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
 	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
@@ -440,6 +446,7 @@ static void finish(struct commit *head_commit,
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
+	apply_autostash(merge_autostash());
 	if (squash) {
 		squash_message(head_commit, remoteheads);
 	} else {
@@ -631,6 +638,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "commit.gpgsign")) {
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
+	} else if (!strcmp(k, "merge.autostash")) {
+		autostash = git_config_bool(k, v);
+		return 0;
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
@@ -724,6 +734,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
 
+		if (autostash)
+			perform_autostash(merge_autostash());
 		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 		clean = merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
@@ -1288,6 +1300,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		/* Invoke 'git reset --merge' */
 		ret = cmd_reset(nargc, nargv, prefix);
+		apply_autostash(merge_autostash());
 		goto done;
 	}
 
diff --git a/builtin/pull.c b/builtin/pull.c
index d25ff13a60..ee186781ae 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -183,7 +183,7 @@ static struct option pull_options[] = {
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
 	OPT_BOOL(0, "autostash", &opt_autostash,
-		N_("automatically stash/stash pop before and after rebase")),
+		N_("automatically stash/stash pop before and after")),
 	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
 		N_("merge strategy to use"),
 		0),
@@ -671,6 +671,10 @@ static int run_merge(void)
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
+	else if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
 	if (opt_allow_unrelated_histories > 0)
 		argv_array_push(&args, "--allow-unrelated-histories");
 
@@ -918,9 +922,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (!opt_rebase && opt_autostash != -1)
-		die(_("--[no-]autostash option is only valid with --rebase."));
-
 	autostash = config_autostash;
 	if (opt_rebase) {
 		if (opt_autostash != -1)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index cf4cc32fd0..75f162495a 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -365,14 +365,6 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 	test_pull_autostash_fail --rebase --no-autostash
 '
 
-for i in --autostash --no-autostash
-do
-	test_expect_success "pull $i (without --rebase) is illegal" '
-		test_must_fail git pull $i . copy 2>err &&
-		test_i18ngrep "only valid with --rebase" err
-	'
-done
-
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.23.0.897.g0a19638b1e

