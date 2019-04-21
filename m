Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E451C20248
	for <e@80x24.org>; Sun, 21 Apr 2019 04:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfDUEJM (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 00:09:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36927 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDUEJL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 00:09:11 -0400
Received: by mail-io1-f65.google.com with SMTP id a23so3456116iot.4
        for <git@vger.kernel.org>; Sat, 20 Apr 2019 21:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iu1wDPEOj4rMBqcY6h8uqHgzkUTO401DaC7sYZMJxA4=;
        b=IDj/Y4ZT0ihuIvu8ap2qInvIco/cqoPFaKZ7VztaUM2CpI2vKKfcCK1wFq7VqkZV/Z
         RYncF3kc6vxQmhaz4iNeN9BVvuEB4PuFg6DZ2LXPpAaymQSRx3Ztvat0ufCKbA5ANMRJ
         w5i5mSd8H8ayDNNi6hcJPGbOELNSLkt95ONT+jge682ple7tLWiLqGwQDjq1wJlIPpvg
         cOIehyDXSncxZA+RYpzwgZbcRUTb5t+7/PrKfEKQego25qZeXLKSGUVdrjqUngUXHJP3
         E6XYxLX6iiPP4YVeRPUjG/otg5XIWutJtNl/sf72K9YCoqbD5YhTa8l9adwCleYMmJ3o
         9phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iu1wDPEOj4rMBqcY6h8uqHgzkUTO401DaC7sYZMJxA4=;
        b=d+6qRIOhIYxw0YxCDkibuj7PvK7RgJObVr+8rwjeL6Rwn96tTOhaneCbhsckqUXJ4J
         Sl3SrSa/3x/m1AbdDLQFgQHynjT85V3mgsR1NzxnvSmmqhblM/xw0WAO/dbJ5AFZT3gI
         Qw2Jl1Lr+GYJcrHckwVfu9iRy5qNjf8nw5+GCcGUvVXNImCQJIUcp5CTeYhwZrj9crwJ
         SFWXaFDNWbYlENtusPseRK7yIGhROTBHykRQ5nsG2TpSctso0j3nK19GHv+cwd1hYpsC
         XcQ/5sndW5Ydn3eKfGuVxZCkImJl7etp2tidmB2pMfwWfOUD8831AeiXmHjzmFeUdxor
         sxjQ==
X-Gm-Message-State: APjAAAW6DtrwbKFGHQj/wZitDNOO2e1NpMBK0419PN35h5he+t/fiDKH
        hMUmg5aL2ZXUTmL30f/y07Nl8GlV
X-Google-Smtp-Source: APXvYqwaieSjnuWnWOEDLYH+oI0Go4EEd5H//tGSpl1NjnI9xUm11vZlmd4zlX8TXCiinBhwoG3gew==
X-Received: by 2002:a6b:d119:: with SMTP id l25mr8377496iob.278.1555819750244;
        Sat, 20 Apr 2019 21:09:10 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:f2d5:bfff:fecd:8741])
        by smtp.gmail.com with ESMTPSA id y11sm4406570ita.14.2019.04.20.21.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 21:09:09 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] Give git-pull a --reset option
Date:   Sat, 20 Apr 2019 22:08:23 -0600
Message-Id: <20190421040823.24821-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common workflow is to make a commit on a local branch, push the branch
to the remote, check out the remote branch on a second computer, amend
the commit on the second computer, force-push back to the remote branch,
and finally submit a pull request. However, if the user switches back to
the first computer, they must then run the cumbersome command
`git fetch && git reset --hard origin`. (Actually, at this point Git
novices often try running `git pull --force`, but it doesn't do what
they expect.) This patch adds the shortcut `git pull --reset` to serve
as a complement to `git push --force`.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-pull.txt |  8 ++++++++
 builtin/pull.c             | 23 +++++++++++++++++++++++
 t/t5520-pull.sh            | 24 ++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 118d9d86f7..032a5c2e34 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -23,6 +23,7 @@ More precisely, 'git pull' runs 'git fetch' with the given
 parameters and calls 'git merge' to merge the retrieved branch
 heads into the current branch.
 With `--rebase`, it runs 'git rebase' instead of 'git merge'.
+With `--reset`, it runs `git reset --hard` instead of 'git merge'.
 
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
@@ -141,6 +142,13 @@ unless you have read linkgit:git-rebase[1] carefully.
 +
 This option is only valid when "--rebase" is used.
 
+--reset::
+	Reset the local branch to be identical to the remote branch, discarding
+	any local commits or other changes.
+
+--no-reset::
+	Override earlier --reset.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 33db889955..b32134c1f1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -95,6 +95,7 @@ static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
 static enum rebase_type opt_rebase = -1;
+static char *opt_reset;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_signoff;
@@ -144,6 +145,9 @@ static struct option pull_options[] = {
 	  "(false|true|merges|preserve|interactive)",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase },
+	OPT_PASSTHRU(0, "reset", &opt_reset, NULL,
+		N_("discard all local changes rather than merging"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -860,6 +864,16 @@ static int run_rebase(const struct object_id *curr_head,
 	return ret;
 }
 
+/**
+ * Runs git-reset, returning its exit status.
+ */
+static int run_reset(void)
+{
+	static const char *argv[] = { "reset", "--hard", "FETCH_HEAD", NULL };
+
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -892,6 +906,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
+	if (opt_rebase && opt_reset)
+		die(_("--rebase and --reset are mutually exclusive"));
+
 	if (!opt_rebase && opt_autostash != -1)
 		die(_("--[no-]autostash option is only valid with --rebase."));
 
@@ -986,6 +1003,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			ret = rebase_submodules();
 
 		return ret;
+	} else if (opt_reset) {
+		int ret = run_reset();
+		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
+			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
+			ret = update_submodules();
+		return ret;
 	} else {
 		int ret = run_merge();
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index cf4cc32fd0..597f2429d5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -708,4 +708,28 @@ test_expect_success 'git pull --rebase against local branch' '
 	test file = "$(cat file2)"
 '
 
+test_expect_success 'git pull --rebase --reset is an invalid combination' '
+	test_must_fail git pull --rebase --reset .
+'
+
+test_expect_success 'git pull --reset overwrites or deletes all tracked files' '
+	git init cloned &&
+	(
+		cd cloned &&
+		echo committed > committed &&
+		echo staged > staged &&
+		echo untracked > file &&
+		echo untracked > untracked &&
+		git add committed &&
+		git commit -m original &&
+		git add staged &&
+		git pull --reset .. &&
+		test ! -f committed &&
+		test ! -f staged &&
+		test "$(cat untracked)" = "untracked" &&
+		test "$(git status --porcelain)" = "?? untracked"
+	) &&
+	test_cmp file cloned/file
+'
+
 test_done
-- 
2.21.0

