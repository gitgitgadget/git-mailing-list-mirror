Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683C21FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbcK1JoY (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:44:24 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34768 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932469AbcK1JoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:44:23 -0500
Received: by mail-pg0-f67.google.com with SMTP id e9so12670279pgc.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5wREdLYKot3vADpQwTTxYsEfSb3J27lDZGlCrlHXe0=;
        b=EqAt4syPrhrdS5UMnDYFyQK3jGn6zQwWwA6CNqFXUAnaisVVhBGILtIPctUmJejk3B
         JpKLlBcw4kua6CQcJ1aJ6Cf1XKFAJaGAehxdDwKDJN8lJ6xUQ1zLK+GM9yThIaYHwnEJ
         3s0PhHCzEowxIhgJKTZ/zxUynN/B9mQYmYef6tnqdvZDGim1SZpwTtZpeZ0g3ZAQ7ryx
         aLrPObGSQJaFDDORzBLqnej2fn/C7BKkCDxsdwvWkWylVT7/0u3dHubuwDSaj97Tbvqv
         u/EemEOom7Zx+cUnqAxMqBHIRyr8sexbffGo9H1hDWgT/qgn82qpVUf1HZ9xGrtIYo1E
         VmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5wREdLYKot3vADpQwTTxYsEfSb3J27lDZGlCrlHXe0=;
        b=PhE4HD5B5P3rb1Wc94XpkCMv2D8ib/qQTBMAEedy/XbkGXnQbi8/7rwwbbyv+MXBXc
         u54a6rrFZnsAL/48v26uZAem9y0WTy8qmuWT0RyTuwD35ZjazaCKcsGRfoxvEKcg+WkS
         U88g3ECgYCLuNsAtpBSolbeeCp6gvbqaj4KI8CyKeqbDtuwOgtudCISgmKle2tN3M0tl
         7tbFZ8AWaA8e6Z9yfA+PT1PSvd9z70pOZXITNjxPnDwWvYdzseShMD9fZ3ExF9qwDsJN
         mLIMYVwgeLixu3zPwt/sJEU08HvFSuIn656ePziw0TY3bMm3+ZRyhpIntyfYzQWp6pBn
         azlQ==
X-Gm-Message-State: AKaTC01XOebeX8Bnrq6nImRqQGvCaPerE8jTUA2f75Rsp4wPo1wTGnnE9FETmRCUAAT3rw==
X-Received: by 10.84.209.140 with SMTP id y12mr46806632plh.74.1480326262481;
        Mon, 28 Nov 2016 01:44:22 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id o1sm67900075pgf.35.2016.11.28.01.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:44:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:44:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/11] worktree move: new command
Date:   Mon, 28 Nov 2016 16:43:16 +0700
Message-Id: <20161128094319.16176-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128094319.16176-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
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
 Documentation/git-worktree.txt         |  7 +++-
 builtin/worktree.c                     | 62 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 30 ++++++++++++++++
 4 files changed, 99 insertions(+), 2 deletions(-)

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
index 9a97e37..f114965 100644
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
@@ -524,6 +525,65 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
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
+	/*
+	 * First try. Atomically move, and probably cheaper, if both
+	 * source and target are on the same file system.
+	 */
+	if (rename(wt->path, dst.buf) == -1) {
+		if (errno != EXDEV)
+			die_errno(_("failed to move '%s' to '%s'"),
+				  wt->path, dst.buf);
+
+		/* second try.. */
+		if (copy_dir_recursively(wt->path, dst.buf))
+			die(_("failed to copy '%s' to '%s'"),
+			    wt->path, dst.buf);
+		else {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_addstr(&sb, wt->path);
+			(void)remove_dir_recursively(&sb, 0);
+			strbuf_release(&sb);
+		}
+	}
+
+	return update_worktree_location(wt, dst.buf);
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -546,5 +606,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return lock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "unlock"))
 		return unlock_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "move"))
+		return move_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf..613e03b 100644
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

