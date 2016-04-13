From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/25] worktree: add "move" commmand
Date: Wed, 13 Apr 2016 20:15:44 +0700
Message-ID: <1460553346-12985-24-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:18:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKgC-0004wX-0X
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760697AbcDMNR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34303 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760687AbcDMNRy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id d184so4106305pfc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0MRLQSyjKX2kJGyl1+6ZVExkjLncLZCrUty9OCJQUo=;
        b=nOtaZfQyH3XwC5lh0oP3OjIIVhj5bmzFWTy7oc0kVA2GCsNQgSdt2AcN5YgmmQCQXL
         +9LKV0lGI3OCf9yYETSaPxd5PXjEsjmNzcRwqBHr0OuyQHuwEBKrGHZIrF5F5x4rGjjy
         d73RyLhFDFBLBB2M0Yop21X41ggq8f9iaxJOYMfdotiTmL85/k/aELDw5i8/fzWT+w37
         Az1+NosJKpNgzbRjlPMtjiFbfjjkwF+rgK689lORRo8PKT2vz9pE40O8erkztHUPRZP4
         GNOGXqko9iRF/qdv5K/H84FqSdJjwHBGzIZeAuV0k+AXrw4IKE433bSqj/wOS+J8YcYE
         MoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0MRLQSyjKX2kJGyl1+6ZVExkjLncLZCrUty9OCJQUo=;
        b=F+ke/tRt38aZL8WXI3gzKG5z28JsV0tHlesS8K0NW30JIeqxTqYBZ1BJgaZX1ceUyM
         oBNmuAQwOZ5RmM+1nJzv+6xuCmuIzoZLuVL5sFkd3GAHZrs3MGPkPu6zBg1H0+RdXJVC
         lg48C87KFhkW0YO/Axy3WPc3zYxDfIhleh7KEQkwqQy55hbsAy0wo3X0SoJMZ6dYtY2X
         I9OiaO4ew8hQVFlWCUS87BdLgWNigtdwCiJuiDgOsPmo19PSuGBXRzKu9g6Jbp3GQJ+e
         ymVcaEBcJ+0hzLioeM/RneKzWUn6gliGNmlHEw+ySD3izzhrPpb4gXnhMy5CWpaIHSiP
         8sTA==
X-Gm-Message-State: AOPr4FUpShfT6i3A/N/Z+G1kvafIkiSg8bZsKVsnQQBSo05fYcm9+MkTuzPBe1tS+KnkgQ==
X-Received: by 10.98.9.219 with SMTP id 88mr13124455pfj.0.1460553473983;
        Wed, 13 Apr 2016 06:17:53 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id u64sm51156522pfa.86.2016.04.13.06.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:18:00 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291443>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt         |  6 +++-
 builtin/worktree.c                     | 60 ++++++++++++++++++++++++++=
++++++++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 29 ++++++++++++++++
 4 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 8315e5b..a302f0a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <path>
+'git worktree move' <path> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree unlock' <path>
=20
@@ -69,6 +70,10 @@ When a worktree is locked, it cannot be pruned, move=
d or deleted. For
 example, if the worktree is on portable device that is not available
 when "git worktree <command>" is executed.
=20
+move::
+
+Move a worktree to a new location. Note that the main worktree cannot =
be moved.
+
 prune::
=20
 Prune working tree information in $GIT_DIR/worktrees.
@@ -234,7 +239,6 @@ performed manually, such as:
=20
 - `remove` to remove a linked working tree and its administrative file=
s (and
   warn if the working tree is dirty)
-- `mv` to move or rename a working tree and update its administrative =
files
=20
 GIT
 ---
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 13f4083..a988913 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -15,6 +15,7 @@ static const char * const worktree_usage[] =3D {
 	N_("git worktree add [<options>] <path> [<branch>]"),
 	N_("git worktree list [<options>]"),
 	N_("git worktree lock [<options>] <path>"),
+	N_("git worktree move <path> <new-path>"),
 	N_("git worktree prune [<options>]"),
 	N_("git worktree unlock <path>"),
 	NULL
@@ -520,6 +521,63 @@ static int unlock_worktree(int ac, const char **av=
, const char *prefix)
 	return unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id))=
;
 }
=20
+static int move_worktree(int ac, const char **av, const char *prefix)
+{
+	struct option options[] =3D {
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+	struct strbuf dst =3D STRBUF_INIT;
+	struct strbuf src =3D STRBUF_INIT;
+	const char *reason;
+
+	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac !=3D 2)
+		usage_with_options(worktree_usage, options);
+
+	strbuf_addstr(&dst, prefix_filename(prefix,
+					    strlen(prefix),
+					    av[1]));
+	if (file_exists(dst.buf))
+		die(_("target '%s' already exists"), av[1]);
+
+	worktrees =3D get_worktrees();
+	strbuf_addstr(&src, prefix_filename(prefix,
+					     strlen(prefix),
+					     av[0]));
+	wt =3D find_worktree_by_path(worktrees, src.buf);
+	if (!wt)
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+	if ((reason =3D is_worktree_locked(wt))) {
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
+	if (rename(src.buf, dst.buf) =3D=3D -1) {
+		if (errno !=3D EXDEV)
+			die_errno(_("failed to move '%s' to '%s'"),
+				  src.buf, dst.buf);
+
+		/* second try.. */
+		if (copy_dir_recursively(src.buf, dst.buf))
+			die(_("failed to copy '%s' to '%s'"),
+			    src.buf, dst.buf);
+		else
+			(void)remove_dir_recursively(&src, 0);
+	}
+
+	return update_worktree_location(wt, dst.buf);
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -540,5 +598,7 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
 		return lock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "unlock"))
 		return unlock_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "move"))
+		return move_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index d7d92ac..022d990 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2596,7 +2596,7 @@ _git_whatchanged ()
=20
 _git_worktree ()
 {
-	local subcommands=3D"add list lock prune unlock"
+	local subcommands=3D"add list lock move prune unlock"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index f4b2816..83fbab5 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -45,4 +45,33 @@ test_expect_success 'unlock worktree twice' '
 	test_path_is_missing .git/worktrees/source/locked
 '
=20
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
+	EOF
+	test_cmp expected actual &&
+	git -C destination log --format=3D%s >actual2 &&
+	echo init >expected2 &&
+	test_cmp expected2 actual2
+'
+
+test_expect_success 'move main worktree' '
+	test_must_fail git worktree move . def
+'
+
 test_done
--=20
2.8.0.rc0.210.gd302cd2
