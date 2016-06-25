Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187771FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 08:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbcFYIMg (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 04:12:36 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35641 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcFYIMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 04:12:34 -0400
Received: by mail-lf0-f66.google.com with SMTP id w130so23926126lfd.2
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 01:12:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QL0MWG6n5XsxNNBuoV4tNZvkcK549YnW8/dgX8nUygg=;
        b=fyDXv9JUhShjY8+hSgtWogBVr+neuO3lhV5dOM7qfQjmj4IZb49RmAqRDzRdvhLpO8
         UN/7Q0eibE6+/rX7ZkSV9EknJvJr2brh++vt1Q50eOzjn12qemXzrFoxEi1sOnLOBFOP
         OBaqnGLL2sjJRw0TDdA804PEzLwU/MMahI73HW/wKE2WjyPGJ8RT90n9IK262fFoEo0I
         VjrJbhkPkeYuSLWznTkcBnk7GFc6LYScRguV4ZA5Bl+gBY8jM1JgPKS/qpIQroy9aTCm
         LhMP1IUgiR9Ajg8RFjOpAECEMdwkvSS6RXITsvQCuOINvBOLH+i9E2j1bOWp9XvEGEYl
         HkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QL0MWG6n5XsxNNBuoV4tNZvkcK549YnW8/dgX8nUygg=;
        b=HvAW23l/xb+T3toFi9YRvV+f+ryz7PaJGl0tpqynd/OjbcfgudS8nTruu+cCl5cpS9
         FzVkFYAdoB6hWQErPNT4i/sbyofBCk4U3s73IPqI7g3OOoYLZHSIrE9EwpnZPCmywC8+
         JuYkBdXM0uDG8UiuBOJuwv8F4feWKjIghe7Hu0CR+xhqKNfTUGQu8gbSGPsKuk2Jfibi
         TM01cqtcQjq21w0FkG6cftdCDctTKSBeZCKdK5V46b8eG6HyreJOy0/4Qb0L7UO6Ext4
         V1wPwHDFzFgiE7DuWH2fKfdt5xGSmwjlzN7qFGZQfMUcEmHlvY+tEuKhTFYqwgKIiOBS
         hUnw==
X-Gm-Message-State: ALyK8tJ4OMdYAMi2vmyQRaQIQhq1Oy6Q8N05yHDzhBti8tbrUKyewh4epTXQ2usS/I6Wuw==
X-Received: by 10.25.201.88 with SMTP id z85mr2832466lff.158.1466841288231;
        Sat, 25 Jun 2016 00:54:48 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g79sm1536122ljg.26.2016.06.25.00.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 00:54:47 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/10] worktree: add "move" commmand
Date:	Sat, 25 Jun 2016 09:54:31 +0200
Message-Id: <20160625075433.4608-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625075433.4608-1-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt         |  7 +++-
 builtin/worktree.c                     | 61 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 30 +++++++++++++++++
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 0aeb020..b842136 100644
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
+cannot be moved.
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
index e7d4b04..5d7ca27 100644
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
@@ -524,6 +525,64 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
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
+	worktrees = get_worktrees();
+	wt = find_worktree(worktrees, prefix, av[0]);
+	if (!wt)
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+	if ((reason = is_worktree_locked(wt))) {
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
@@ -544,5 +603,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return lock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "unlock"))
 		return unlock_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "move"))
+		return move_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0e3841d..b2028e2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2597,7 +2597,7 @@ _git_whatchanged ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock prune unlock"
+	local subcommands="add list lock move prune unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 68d3fe8..3cf5305 100755
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
+	worktree $TRASH_DIRECTORY/elsewhere
+	worktree $TRASH_DIRECTORY/destination
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
2.8.2.526.g02eed6d

