Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1FA1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfDYJqk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41964 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDYJqk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so10907520pgs.8
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xlp8jEVy/enGQUzw47FxdZj8LMTDl40q1WmFIEAwnUU=;
        b=LjsTkLzUxaElDPp9Du6CiEapWR6uhdWDCWUAr5uVp0jJs1JPHLJgGtVvqOOrS1y6T/
         0hSo8jFIMW7rgF45bKvSNKIR4IjoZT8BfUnN/LhqRA5mjk8wbpf0EpLZT2slAnnH8Jax
         Vaos6yt2jDyA/A2WwlOmz0+ACiwAav0duPp6ajGY/q5QiYJqpIEz5lktytd2QPkzUA92
         JWRtpZFRFFj7GoK7rRzIm+ZuzwmDujqj3KAMVKH4799jMyksH9HWnSdwrjvz9R1uYFFk
         S9BpajZlqJxhAfkZ4SlcAwQBmgvGXA0Gd5b4Xn3wfcI6O7jOUJ8VF9oLHZsFCGuZCc2W
         ysxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xlp8jEVy/enGQUzw47FxdZj8LMTDl40q1WmFIEAwnUU=;
        b=mr7AAYVN+I11EwJu644lTcyfYN46yzuTk5JjZaosfdtmhvB5de0RGabDP6DbaupbHT
         /MQmC7qQMHabjgk9OektthtzeM2IcguAtvJN7ChoDkKpGvj0qsu2QvhUKVHqwSDzD6A+
         tGGfR3BFP5XBJXSHQR73qEw6GOjdNjWpfW60FpNDmcmYGAjw9rB47i9Hjr3RY5n2zvm0
         w3HJHXAN7CmnEtRxaG6VFxUFPlyiqlSA9LnZv2t4HRD3ixnJ3j4pp4m3i6+K0Ew6+fib
         77v9Dr7rXVHwb9+p67LZq8NvNT8NJ7mxQ2LuGwuJzEFSukpbKRTC55AiT6a89LI+b5ER
         EV3Q==
X-Gm-Message-State: APjAAAW9fQhg8N5B9YGPhQZCAuTpFB3D0MjaHNHUxb9P1jwbs+6Uwb10
        csFOz7tDbLLguEejCu1/7jA=
X-Google-Smtp-Source: APXvYqytTnGI62u7DpNKDwzlgIT7TG39LgGEhTexthMuQmn8EQXli56UW09+yJnF2VFur6lfLWetAg==
X-Received: by 2002:a63:d34b:: with SMTP id u11mr4230583pgi.385.1556185599306;
        Thu, 25 Apr 2019 02:46:39 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id e6sm13745294pfe.158.2019.04.25.02.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:38 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 06/16] restore: add --worktree and --staged
Date:   Thu, 25 Apr 2019 16:45:50 +0700
Message-Id: <20190425094600.15673-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git checkout <tree-ish> <pathspec>' updates both index and
worktree. But updating the index when you want to restore worktree
files is non-intuitive. The index contains the data ready for the next
commit, and there's no indication that the user will want to commit
the restored versions.

'git restore' therefore by default only touches worktree. The user has
the option to update either the index with

    git restore --staged --source=<tree> <path>  (1)

or update both with

    git restore --staged --worktree --source=<tree> <path> (2)

PS. Orignally I wanted to make worktree update default and form (1)
would add index update while also updating the worktree, and the user
would need to do "--staged --no-worktree" to update index only. But it
looks really confusing that "--staged" option alone updates both. So
now form (2) is used for both, which reads much more obvious.

PPS. Yes form (1) overlaps with "git reset <rev> <path>". I don't know
if we can ever turn "git reset" back to "_always_ reset HEAD and
optionally do something else".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 74 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1753c8c5ed..e855c64cfe 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -66,6 +66,8 @@ struct checkout_opts {
 	int can_switch_when_in_progress;
 	int orphan_from_empty_tree;
 	int empty_pathspec_ok;
+	int checkout_index;
+	int checkout_worktree;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -397,6 +399,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct commit *head;
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
+	int checkout_index;
 
 	trace2_cmd_mode(opts->patch_mode ? "patch" : "path");
 
@@ -422,9 +425,26 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
 		    opts->new_branch);
 
-	if (opts->patch_mode)
-		return run_add_interactive(revision, "--patch=checkout",
-					   &opts->pathspec);
+	if (!opts->checkout_worktree && !opts->checkout_index)
+		die(_("neither '%s' or '%s' is specified"),
+		    "--staged", "--worktree");
+
+	if (!opts->checkout_worktree && !opts->from_treeish)
+		die(_("'%s' must be used when '%s' is not specified"),
+		    "--worktree", "--source");
+
+	if (opts->patch_mode) {
+		const char *patch_mode;
+
+		if (opts->checkout_index && opts->checkout_worktree)
+			patch_mode = "--patch=checkout";
+		else if (opts->checkout_index && !opts->checkout_worktree)
+			patch_mode = "--patch=reset";
+		else
+			die(_("'%s' with only '%s' is not currently supported"),
+			    "--patch", "--worktree");
+		return run_add_interactive(revision, patch_mode, &opts->pathspec);
+	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(&opts->pathspec) < 0)
@@ -482,10 +502,30 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return 1;
 
 	/* Now we are committed to check them out */
-	errs |= checkout_worktree(opts);
+	if (opts->checkout_worktree)
+		errs |= checkout_worktree(opts);
 
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-		die(_("unable to write new index file"));
+	/*
+	 * Allow updating the index when checking out from the index.
+	 * This is to save new stat info.
+	 */
+	if (opts->checkout_worktree && !opts->checkout_index && !opts->source_tree)
+		checkout_index = 1;
+	else
+		checkout_index = opts->checkout_index;
+
+	if (checkout_index) {
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+			die(_("unable to write new index file"));
+	} else {
+		/*
+		 * NEEDSWORK: if --worktree is not specified, we
+		 * should save stat info of checked out files in the
+		 * index to avoid the next (potentially costly)
+		 * refresh. But it's a bit tricker to do...
+		 */
+		rollback_lock_file(&lock_file);
+	}
 
 	read_ref_full("HEAD", 0, &rev, NULL);
 	head = lookup_commit_reference_gently(the_repository, &rev, 1);
@@ -1461,6 +1501,20 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->overlay_mode == 1 && opts->patch_mode)
 		die(_("-p and --overlay are mutually exclusive"));
 
+	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
+		if (opts->checkout_index < 0)
+			opts->checkout_index = 0;
+		if (opts->checkout_worktree < 0)
+			opts->checkout_worktree = 0;
+	} else {
+		if (opts->checkout_index < 0)
+			opts->checkout_index = -opts->checkout_index - 1;
+		if (opts->checkout_worktree < 0)
+			opts->checkout_worktree = -opts->checkout_worktree - 1;
+	}
+	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
+		BUG("these flags should be non-negative by now");
+
 	/*
 	 * From here on, new_branch will contain the branch to be checked out,
 	 * and new_branch_force and new_orphan_branch will tell us which one of
@@ -1617,6 +1671,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.orphan_from_empty_tree = 0;
 	opts.empty_pathspec_ok = 1;
 	opts.overlay_mode = -1;
+	opts.checkout_index = -2;    /* default on */
+	opts.checkout_worktree = -2; /* default on */
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1674,6 +1730,10 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	struct option restore_options[] = {
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
 			   N_("where the checkout from")),
+		OPT_BOOL('S', "staged", &opts.checkout_index,
+			   N_("restore the index")),
+		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
+			   N_("restore the working tree (default)")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
@@ -1684,6 +1744,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	opts.accept_pathspec = 1;
 	opts.empty_pathspec_ok = 0;
 	opts.overlay_mode = 0;
+	opts.checkout_index = -1;    /* default off */
+	opts.checkout_worktree = -2; /* default on */
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.854.ge34a79f761

