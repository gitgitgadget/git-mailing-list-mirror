Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242271FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 08:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754936AbcLNIiW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 03:38:22 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33781 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754722AbcLNIiU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 03:38:20 -0500
Received: by mail-pf0-f193.google.com with SMTP id 144so823664pfv.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 00:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oPnSgXfthVJPGLzaEj0WsmDbIjoyelawleLxA3COixE=;
        b=RZ/Zs+X9/7zPPlKgTFeWULPCC22LiIPaoX0LY+sF3z3ZHEYiQn+MQpFmuh0t0AypsC
         gKNOM2YAakQfCdRfQX6n8azvjIePmVPNximO3FB0Kra2aM9NHqcfDPdZYtMLOMFqkJQc
         hzckulGjheIAo/tSa/NYR18k817QyrYrAUI11ahGaSpB8wxRHJ5gIPpCYszrpwKM6j8y
         ApqoCaNkiSA2UA3aepzK78vGRTD9eIvcWYvkZ2cWGD8QXVSzuroOv8E11rJE0ZVOZ4lE
         m+3oMrPVOTQzgaWdBXfErP1nlXq2BgRVzmKT9wbXIVs2Mgs0s00F+vV8if/Hr3MFIsRk
         AvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oPnSgXfthVJPGLzaEj0WsmDbIjoyelawleLxA3COixE=;
        b=MrrxpjtKkkflRt2FB7WjfncpUVGzNx3AYu8tI+gi2P8YeW3DUXf3BRf2ehgQFqkgIZ
         zsu6mwAhiagQMHOMl2U36F+z0e3/4FsiLdPKOC4Mj1jvQez6AhXIIb66AKJavAgvtSD3
         6vYanddVgED+1EgR/weV+ozPxDov+giKmTXFa1uBzwYZ2HB2qHGWSvnKx+u3cc2kfpfJ
         S3X4t1AWtYPIfQWTNbu2t32wYz22CBWr0dCPPvVPYFtenyESIec+aCn4XCh3EZa8PnJp
         RODcBuCCpKKGR3HLd39iFJgXCvEyOUUFOqODcD+lVbY02PeUOQ6UrlWnGSD8kZmiKsYe
         q8sA==
X-Gm-Message-State: AKaTC011L1uTD5Tts86S5BRtBH+uJFhCQVPAngTJVhQmR49kjWNEXo/Py4AmYNLXxOk2ww==
X-Received: by 10.98.192.21 with SMTP id x21mr104259326pff.94.1481704691621;
        Wed, 14 Dec 2016 00:38:11 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:50cb:a0f2:6faa:ea3b])
        by smtp.gmail.com with ESMTPSA id g63sm85225192pfd.60.2016.12.14.00.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 00:38:10 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     mah@jump-ing.de, peff@peff.net, jacob.keller@gmail.com,
        gitster@pobox.com, Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv3 1/3] merge: Add '--continue' option as a synonym for 'git commit'
Date:   Wed, 14 Dec 2016 21:37:55 +1300
Message-Id: <20161214083757.26412-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.11.0.24.ge6920cf
In-Reply-To: <20161213084859.13426-1-judge.packham@gmail.com>
References: <20161213084859.13426-1-judge.packham@gmail.com>
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
Changes in v2:
- add --continue to builtin_merge_usage
- verify that no other arguments are present when --continue is used.
- add basic test
Changes in v3:
- check for other options in addtion to arguments, add test for this case
- re-instate references to 'git commit' that were removed in v2
- re-work documentation

 Documentation/git-merge.txt |  8 ++++++++
 builtin/merge.c             | 21 +++++++++++++++++++++
 t/t7600-merge.sh            |  9 +++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b758d5556..ca3c27b88 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
+'git merge' --continue
 
 DESCRIPTION
 -----------
@@ -61,6 +62,8 @@ reconstruct the original (pre-merge) changes. Therefore:
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
+The fourth syntax ("`git merge --continue`") can only be run after the
+merge has resulted in conflicts.
 
 OPTIONS
 -------
@@ -99,6 +102,11 @@ commit or stash your changes before running 'git merge'.
 'git merge --abort' is equivalent to 'git reset --merge' when
 `MERGE_HEAD` is present.
 
+--continue::
+	After a 'git merge' stops due to conflicts you can conclude the
+	merge by running 'git merge --continue' (see "HOW TO RESOLVE
+	CONFLICTS" section below).
+
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
 	Specifying more than one commit will create a merge with
diff --git a/builtin/merge.c b/builtin/merge.c
index b65eeaa87..836ec281b 100644
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
@@ -1125,6 +1129,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list *remoteheads, *p;
 	void *branch_to_free;
+	int orig_argc = argc;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_merge_usage, builtin_merge_options);
@@ -1166,6 +1171,22 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	}
 
+	if (continue_current_merge) {
+		int nargc = 1;
+		const char *nargv[] = {"commit", NULL};
+
+		if (orig_argc != 2)
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
index 85248a14b..682139c4e 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -154,6 +154,8 @@ test_expect_success 'test option parsing' '
 	test_must_fail git merge -s foobar c1 &&
 	test_must_fail git merge -s=foobar c1 &&
 	test_must_fail git merge -m &&
+	test_must_fail git merge --continue foobar &&
+	test_must_fail git merge --continue --quiet &&
 	test_must_fail git merge
 '
 
@@ -763,4 +765,11 @@ test_expect_success 'merge nothing into void' '
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

