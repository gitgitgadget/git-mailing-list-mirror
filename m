Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A68920248
	for <e@80x24.org>; Wed, 17 Apr 2019 04:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfDQEHl (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 00:07:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38306 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfDQEHl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 00:07:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so11376031plb.5
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 21:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjmOxxya0w9qSE+WmWN5pPW3ekTX/f0s/ccqAUBPUow=;
        b=hXnWElvVieszHYiyzDFpHbdZpEsGVHOYktpH66F2GsOKvMQajNiSQ0mKtOF+1VPtLC
         0JhT+wAIePTztu+XFZIvrYQxcx8MXNyuq3nPvYgawSuhKhJrvzJDd2BFbzITwzaFdLmQ
         rk7QXB17alKxg/jbORuBay6MOT4qurFoJpGyNS3D/geniOOeE+wHX60YUv1Sp1tkhWTw
         BteTEBnDzkHSyq+zMF9/4TBwDaf8IbzDryYtAIzKTfTmyRCGJP10yxrJ/AjTync2cwdF
         ht/zPTUCV3iwIPk+Mh74GRjp/YSX4msJkKQqFMmqf+u5zonZvmmTRAboKfMWVfmVSDXa
         gNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjmOxxya0w9qSE+WmWN5pPW3ekTX/f0s/ccqAUBPUow=;
        b=LI/40OldzR3TxtFhgmiqHHN2imjGPoMWpcz6JStFmEUfkFz1s2ykwWub+iTlFb/Ul2
         JxrB5Gfh8R4CTQ5pUlzJy9jluFD0BFNrHOEQ9SqhR6+jEIGgzOses5zsw7BJpWtfRchF
         zjFMSwS5fZfann8xfAJ8xvdyYhgg8P/lfqPncO9m9rXOfWHcYEY1JzG6rC4SdW9dgTJ6
         vbPLbHbpeDE4KGp91u1ZhYGjXX2q6PmY1WUVq/SSEX0s2rO1a3n9HzazF2ASNLGBvatx
         SlruvZ7eyr+RxVe1vjUZMR6knGGUWoYGbNmbk6mQmP/hWGl5OuqIKMVm4waRQ9okwA36
         WtOg==
X-Gm-Message-State: APjAAAWVIncngvvWoe2N59hw5qEVV8HYtfZOlFnIrMhTcGeaq5I3A0kv
        HMYv2+qZ5TC9NyBlL6BcHe+0rpTn
X-Google-Smtp-Source: APXvYqyiTFiTOuyO2u/S1Dz++1gTE+710PJWL19uz4yxOeNynrSEpb3n0FrOl1cjbllCOWwcQa91IA==
X-Received: by 2002:a17:902:106:: with SMTP id 6mr43162226plb.98.1555474059797;
        Tue, 16 Apr 2019 21:07:39 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:f2d5:bfff:fecd:8741])
        by smtp.gmail.com with ESMTPSA id o67sm115884608pga.55.2019.04.16.21.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 21:07:38 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] Give git-pull a --reset option
Date:   Tue, 16 Apr 2019 22:07:33 -0600
Message-Id: <20190417040733.22200-1-alexhenrie24@gmail.com>
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
 builtin/pull.c             | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 118d9d86f7..bae8f07161 100644
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
+	Reset the local branch to match the remote commit, discarding any local
+	commits or other changes.
+
+--no-reset::
+	Override earlier --reset.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 33db889955..97379447eb 100644
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
@@ -860,6 +864,21 @@ static int run_rebase(const struct object_id *curr_head,
 	return ret;
 }
 
+/**
+ * Runs git-reset, returning its exit status.
+ */
+static int run_reset(void)
+{
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	argv_array_pushl(&args, "reset", NULL);
+	argv_array_push(&args, "--hard");
+	argv_array_push(&args, "FETCH_HEAD");
+	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	argv_array_clear(&args);
+	return ret;
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -892,6 +911,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
+	if (opt_rebase && opt_reset)
+		die(_("--rebase and --reset are mutually exclusive."));
+
 	if (!opt_rebase && opt_autostash != -1)
 		die(_("--[no-]autostash option is only valid with --rebase."));
 
@@ -986,6 +1008,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
-- 
2.21.0

