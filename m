Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5953E207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 10:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031185AbdDTKLc (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:11:32 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34462 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031175AbdDTKL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:11:29 -0400
Received: by mail-oi0-f67.google.com with SMTP id y11so5653988oie.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sog3h3oUDX6J3XYo+xgjNg4RbLTPVn/owUteScTnYGA=;
        b=B2Nd/vZPFiZNNfWaIh25Ax75OVKGMVsZwO/e6LB2+6KEguavkQxBTial2H1BzzXNRA
         SP7FQ0A3nbyFqj5L5Ge8wOO9tOhjgL5mx77S5TwJ2dQGwJu4y9eAjia8IwPzfhVpgmDf
         ZGM5juBtVDY4AiQl2PTN7f4rcrZq3fMKl/7rAmR7R4ng02zDb2ItCFX/cmGnHudHXVHY
         YM+bNFlPfe9Ptj2r7mfVTiZnxHrDaBhcvFu/Sm5mSRbEgB2/NyBv1v0O4Mf9Qmm4ihLo
         tHrLZ24FgM00dSLIE1rxihSV/ZhJX/Zz43VRTYXZoRHPpnLy745MY0+KGf28QEjSaedD
         M6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sog3h3oUDX6J3XYo+xgjNg4RbLTPVn/owUteScTnYGA=;
        b=p7wz8cBlYWIK/xzLKftJb4cISr1otcTLTPo1eWgsbVEi1x7FAk+bUnajZezTyOeNGn
         QzduR+aitW3BhC7jHjt+mpZpNXg3PaRb1m1tkqS4vhkCDFqOr6L18cHl0oXO/2JWJSR9
         BFZw8U7zfjztT9jRhne9mXFrGKc002HwCFCqISElnavYe8c4JMVRmmj20/W04K9VtvBW
         g1qNeLbpXlP3Lem5IEa1xAYD4uVYntbanZVk0P9uoSoXi7LDePu1x18vpMzHW4UwyuCs
         Zt6Xkzrx5fZ2yS5KOshykn0YVYtxjwNCf83wVpPk5BuTtDedLjU4Pc9G2/gfRLBZ0AoK
         /y8A==
X-Gm-Message-State: AN3rC/5QkNgs3x1+qVErpz6M9tgjfBSe4POJcNFUKyk/M+q95vvvRQp+
        NER0wuXdbup02g==
X-Received: by 10.84.245.2 with SMTP id i2mr9382655pll.131.1492683088126;
        Thu, 20 Apr 2017 03:11:28 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id q1sm9536699pfl.89.2017.04.20.03.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 03:11:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:11:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/6] worktree move: new command
Date:   Thu, 20 Apr 2017 17:10:21 +0700
Message-Id: <20170420101024.7593-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420101024.7593-1-pclouds@gmail.com>
References: <20170420101024.7593-1-pclouds@gmail.com>
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
 builtin/worktree.c                     | 41 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 31 +++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 553cf8413f..b47a3247bb 100644
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
index 9993ded41a..e3fbfe2a71 100644
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
@@ -525,6 +526,44 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
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
+	strbuf_addstr(&dst, prefix_filename(prefix, av[1]));
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
@@ -547,5 +586,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return lock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "unlock"))
 		return unlock_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "move"))
+		return move_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1150164d5c..651809c52f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3036,7 +3036,7 @@ _git_whatchanged ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock prune unlock"
+	local subcommands="add list lock move prune unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 8298aaf97f..bef420a086 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -59,4 +59,35 @@ test_expect_success 'unlock worktree twice' '
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
+	toplevel="$(pwd)" &&
+	git worktree move source destination &&
+	test_path_is_missing source &&
+	git worktree list --porcelain | grep "^worktree" >actual &&
+	cat <<-EOF >expected &&
+	worktree $toplevel
+	worktree $toplevel/destination
+	worktree $toplevel/elsewhere
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
2.11.0.157.gd943d85

