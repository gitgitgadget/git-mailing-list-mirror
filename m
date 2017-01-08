Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98EA31FEB3
	for <e@80x24.org>; Sun,  8 Jan 2017 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934772AbdAHJk7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 04:40:59 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34247 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934618AbdAHJkg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 04:40:36 -0500
Received: by mail-pg0-f68.google.com with SMTP id b1so48632348pgc.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JlaNGa5NMt79U5xZyeFeqQckQC81fMdjrfOuaLZHT4=;
        b=UhW/eZQpVDwuZ+iWPBW57/qu9bwb0rJrVEhzoSWh/Prjqb6HpM094V6EAPwOQv040K
         6DFdqUQrPv2RM1ZYEKBVWEp1F+9/6CxOAw2ryHphOxinSGCK04DdU8bfcHAehpISFkpI
         xBZSdmYI/USlPWcFc9XAQ1D10cP7c84xqJ/j6auTplueVMpOAmNLMGmzU8mrhiolsi8L
         JI5jhVVIz1e4i7N06Iv8TKWOlrziGfnfqISxeCdh4Y+xL9nT+hSeMr4ZGvri+RrZf6PK
         cmD2H7ptMup73PYp4B36okTqLWOxkahMr5ZeJ+Ha14kzafioX56jrzktJ+EAd5cm9/Pa
         hgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JlaNGa5NMt79U5xZyeFeqQckQC81fMdjrfOuaLZHT4=;
        b=nvt7qdxnxO7u2CAS1wOGCFvL/ccb3F8wrQgHVa0yvlJzw9BW/YcxOw2v7rGZ4CLDpp
         PQDyZxm/pIQn9M84EfKdkJ97oxRQ5yEFRzfFvm2cjz/z7eF/1DE3Y6MiKSSI6CzbaCCN
         81Rw5xr3Wk/yILoPgrTRbShZH4nIGSV4yiUS/nYjT25OND+pKTQ4Plo6yHSJMhLIPK5e
         h6vhWHLAfv1FpRFh5ItaLZOeXcnw42LG9VxI7+Q79OHjkQk9yWhSWQoA5FLdG0RwT288
         jJmroRuJ4jMjf5E9/+C+ykW8kIerbn70syi6XbNJAA/z/OppJz/bScUmhZJ53sfirREy
         +fXA==
X-Gm-Message-State: AIkVDXLizkXCaTD1lskKQt8w4+O80aTcHreyMEk0gQ1kacqERKSMylpdLg/ZI85pbkzI0Q==
X-Received: by 10.99.123.3 with SMTP id w3mr147549248pgc.155.1483868435547;
        Sun, 08 Jan 2017 01:40:35 -0800 (PST)
Received: from ash ([115.72.187.80])
        by smtp.gmail.com with ESMTPSA id z9sm18986991pfg.86.2017.01.08.01.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jan 2017 01:40:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 08 Jan 2017 16:40:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/6] worktree move: new command
Date:   Sun,  8 Jan 2017 16:40:00 +0700
Message-Id: <20170108094003.637-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170108094003.637-1-pclouds@gmail.com>
References: <20170108094003.637-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two options to move the main worktree, but both have
complications, so it's not implemented yet. Anyway the options are:

 - convert the main worktree to a linked one and move it away, leave the
   git repository where it is. The repo essentially becomes bare after
   this move.

 - move the repository with the main worktree. The tricky part is make
   sure all file descriptors to the repository are closed, or it may
   fail on Windows.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt         |  7 +++++-
 builtin/worktree.c                     | 43 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 30 ++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e257c19..1310513 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <path> [<branch>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
+'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree unlock' <worktree>
 
@@ -71,6 +72,11 @@ files from being pruned automatically. This also prevents it from
 being moved or deleted. Optionally, specify a reason for the lock
 with `--reason`.
 
+move::
+
+Move a working tree to a new location. Note that the main working tree
+cannot be moved yet.
+
 prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
@@ -252,7 +258,6 @@ performed manually, such as:
 
 - `remove` to remove a linked working tree and its administrative files (and
   warn if the working tree is dirty)
-- `mv` to move or rename a working tree and update its administrative files
 
 GIT
 ---
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9a97e37..0d8b57c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -15,6 +15,7 @@ static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<branch>]"),
 	N_("git worktree list [<options>]"),
 	N_("git worktree lock [<options>] <path>"),
+	N_("git worktree move <worktree> <new-path>"),
 	N_("git worktree prune [<options>]"),
 	N_("git worktree unlock <path>"),
 	NULL
@@ -524,6 +525,46 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static int move_worktree(int ac, const char **av, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+	struct strbuf dst = STRBUF_INIT;
+	const char *reason;
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac != 2)
+		usage_with_options(worktree_usage, options);
+
+	strbuf_addstr(&dst, prefix_filename(prefix,
+					    strlen(prefix),
+					    av[1]));
+	if (file_exists(dst.buf))
+		die(_("target '%s' already exists"), av[1]);
+
+	worktrees = get_worktrees(0);
+	wt = find_worktree(worktrees, prefix, av[0]);
+	if (!wt)
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+	reason = is_worktree_locked(wt);
+	if (reason) {
+		if (*reason)
+			die(_("already locked, reason: %s"), reason);
+		die(_("already locked, no reason"));
+	}
+	if (validate_worktree(wt, 0))
+		return -1;
+
+	if (rename(wt->path, dst.buf) == -1)
+		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
+
+	return update_worktree_location(wt, dst.buf);
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -546,5 +587,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return lock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "unlock"))
 		return unlock_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "move"))
+		return move_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6721ff8..e80392b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2715,7 +2715,7 @@ _git_whatchanged ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock prune unlock"
+	local subcommands="add list lock move prune unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 8298aaf..74070bd 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -59,4 +59,34 @@ test_expect_success 'unlock worktree twice' '
 	test_path_is_missing .git/worktrees/source/locked
 '
 
+test_expect_success 'move non-worktree' '
+	mkdir abc &&
+	test_must_fail git worktree move abc def
+'
+
+test_expect_success 'move locked worktree' '
+	git worktree lock source &&
+	test_must_fail git worktree move source destination &&
+	git worktree unlock source
+'
+
+test_expect_success 'move worktree' '
+	git worktree move source destination &&
+	test_path_is_missing source &&
+	git worktree list --porcelain | grep "^worktree" >actual &&
+	cat <<-EOF >expected &&
+	worktree $TRASH_DIRECTORY
+	worktree $TRASH_DIRECTORY/destination
+	worktree $TRASH_DIRECTORY/elsewhere
+	EOF
+	test_cmp expected actual &&
+	git -C destination log --format=%s >actual2 &&
+	echo init >expected2 &&
+	test_cmp expected2 actual2
+'
+
+test_expect_success 'move main worktree' '
+	test_must_fail git worktree move . def
+'
+
 test_done
-- 
2.8.2.524.g6ff3d78

