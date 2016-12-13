Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCE9206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 08:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932698AbcLMItT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 03:49:19 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34696 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbcLMItP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 03:49:15 -0500
Received: by mail-pg0-f68.google.com with SMTP id e9so3853736pgc.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TgUf61iWQlvTXThgJMY2igCd4UNnRTmh85V9WMn3fGw=;
        b=tVngytXMpgAsa++wZhBc1fQBa2wqS47C+8rVBWy84W/LTFEOKhMEjxauL1B8RCdZgP
         J7LcnUTykFhm/xQAnUItSNzYyWLEEGbytmrjk3KOJoHzrN3WntKB8yveacEzLXXiSw+9
         Bbnh4yPrRVLhx8DLfGB4ruld1bknkeKk7Gr4RClhty+7TMnmIZDj6DQkrXBkoJQbTve+
         teJ8x+YUnuc/HzAlYHUBKPmyc6nF3yeXKLQ0xwXx3e5OxxhQfViAk1om65x8psbXP4ml
         JHKfCM4hv5l2LXxWOCmS0ziUflpChVku/Tod51NRpnv0bWlACKwh8KjaKsB/MmZRiTri
         FZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TgUf61iWQlvTXThgJMY2igCd4UNnRTmh85V9WMn3fGw=;
        b=dJJvayxk3kuZDH1wXxsao8p73cTBw9+IQ2G59BUEehD+37cYQnljJawBytaI0/k/sn
         /a7XmyWjJPIuA8Zs+XTcOJH0OUTg+fYaeJRMiy5rCwe98fFps0n1pGw0SoBWqXcRol7t
         DeKhXsQQsXowjyhZtzZT1dY1S9UneE8ee7U3z+6k+Ggk0uVhfFv+RVy4JRm5keZIwauV
         OcafNCU8kl8/2Qst/xUQ9h8xKhuscdQpE2j+B2DtS29OeCdgYM9r5d6UB2kAmAZ0ONhp
         gzypjeZDzRlFXYMn7MfqE85t4JNcGs7AGx3GoFOaoYzWXkv808i4ZfivTZKa3leb9mLx
         LL7Q==
X-Gm-Message-State: AKaTC02wdIN5b7KAUXvc0eY94UdxzadTxZ3HbWSxYwYRhfl/a46VRTdI4MLCqpipuN2B5A==
X-Received: by 10.84.168.4 with SMTP id e4mr194612994plb.160.1481618955087;
        Tue, 13 Dec 2016 00:49:15 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:7966:ce03:97ae:8cb])
        by smtp.gmail.com with ESMTPSA id m5sm79839976pgn.42.2016.12.13.00.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 00:49:14 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     mah@jump-ing.de, peff@peff.net, jacob.keller@gmail.com,
        gitster@pobox.com, Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv2 1/2] merge: Add '--continue' option as a synonym for 'git commit'
Date:   Tue, 13 Dec 2016 21:48:58 +1300
Message-Id: <20161213084859.13426-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.11.0.24.ge6920cf
In-Reply-To: <20161212083413.7334-1-judge.packham@gmail.com>
References: <20161212083413.7334-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git merge' the --continue option which allows 'continuing' a
merge by completing it. The traditional way of completing a merge after
resolving conflicts is to use 'git commit'. Now with commands like 'git
rebase' and 'git cherry-pick' having a '--continue' option adding such
an option to 'git merge' presents a consistent UI.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

Notes:
    Changes in v2:
    - add --continue to builtin_merge_usage
    - verify that no other arguments are present when --continue is used.
    - add basic test

 Documentation/git-merge.txt | 13 ++++++++++++-
 builtin/merge.c             | 22 +++++++++++++++++++++-
 t/t7600-merge.sh            |  8 ++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b758d5556..765b0f26e 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
+'git merge' --continue
 
 DESCRIPTION
 -----------
@@ -61,6 +62,9 @@ reconstruct the original (pre-merge) changes. Therefore:
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
+The fourth syntax ("`git merge --continue`") can only be run after the
+merge has resulted in conflicts. 'git merge --continue' will take the
+currently staged changes and complete the merge.
 
 OPTIONS
 -------
@@ -99,6 +103,12 @@ commit or stash your changes before running 'git merge'.
 'git merge --abort' is equivalent to 'git reset --merge' when
 `MERGE_HEAD` is present.
 
+--continue::
+	Take the currently staged changes and complete the merge.
++
+'git merge --continue' is equivalent to 'git commit' when
+`MERGE_HEAD` is present.
+
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
 	Specifying more than one commit will create a merge with
@@ -277,7 +287,8 @@ After seeing a conflict, you can do two things:
 
  * Resolve the conflicts.  Git will mark the conflicts in
    the working tree.  Edit the files into shape and
-   'git add' them to the index.  Use 'git commit' to seal the deal.
+   'git add' them to the index.  Use 'git merge --continue' to seal the
+   deal.
 
 You can work through the conflict with a number of tools:
 
diff --git a/builtin/merge.c b/builtin/merge.c
index b65eeaa87..379685223 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -46,6 +46,7 @@ static const char * const builtin_merge_usage[] = {
 	N_("git merge [<options>] [<commit>...]"),
 	N_("git merge [<options>] <msg> HEAD <commit>"),
 	N_("git merge --abort"),
+	N_("git merge --continue"),
 	NULL
 };
 
@@ -65,6 +66,7 @@ static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
+static int continue_current_merge;
 static int allow_unrelated_histories;
 static int show_progress = -1;
 static int default_to_upstream = 1;
@@ -223,6 +225,8 @@ static struct option builtin_merge_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
+	OPT_BOOL(0, "continue", &continue_current_merge,
+		N_("continue the current in-progress merge")),
 	OPT_BOOL(0, "allow-unrelated-histories", &allow_unrelated_histories,
 		 N_("allow merging unrelated histories")),
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
@@ -739,7 +743,7 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 	if (err_msg)
 		error("%s", err_msg);
 	fprintf(stderr,
-		_("Not committing merge; use 'git commit' to complete the merge.\n"));
+		_("Not committing merge; use 'git merge --continue' to complete the merge.\n"));
 	write_merge_state(remoteheads);
 	exit(1);
 }
@@ -1166,6 +1170,22 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	}
 
+	if (continue_current_merge) {
+		int nargc = 1;
+		const char *nargv[] = {"commit", NULL};
+
+		if (argc)
+			usage_msg_opt("--continue expects no arguments",
+			      builtin_merge_usage, builtin_merge_options);
+
+		if (!file_exists(git_path_merge_head()))
+			die(_("There is no merge in progress (MERGE_HEAD missing)."));
+
+		/* Invoke 'git commit' */
+		ret = cmd_commit(nargc, nargv, prefix);
+		goto done;
+	}
+
 	if (read_cache_unmerged())
 		die_resolve_conflict("merge");
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 85248a14b..44b34ef3a 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -154,6 +154,7 @@ test_expect_success 'test option parsing' '
 	test_must_fail git merge -s foobar c1 &&
 	test_must_fail git merge -s=foobar c1 &&
 	test_must_fail git merge -m &&
+	test_must_fail git merge --continue foobar &&
 	test_must_fail git merge
 '
 
@@ -763,4 +764,11 @@ test_expect_success 'merge nothing into void' '
 	)
 '
 
+test_expect_success 'merge can be completed with --continue' '
+	git reset --hard c0 &&
+	git merge --no-ff --no-commit c1 &&
+	git merge --continue &&
+	verify_parents $c0 $c1
+'
+
 test_done
-- 
2.11.0.24.ge6920cf

