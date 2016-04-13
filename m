From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/25] worktree: add "remove" command
Date: Wed, 13 Apr 2016 20:15:46 +0700
Message-ID: <1460553346-12985-26-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:18:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKgP-00056X-2l
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758417AbcDMNSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:18:07 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33476 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527AbcDMNSG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:18:06 -0400
Received: by mail-pf0-f194.google.com with SMTP id e190so4123681pfe.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjPuDFx8oIy9/xSf1mGnS8UxQJqPYndz36Jt2UogPK4=;
        b=cBbNhhxln4vWVIrt5NAjAPbk9SD1nZkjbDlHLCxgXouJBoo0iBP6fE41JU+GgaZrzv
         AHkg+Gab9J1GpoFGYG76iggggV7uKFGM3145jQYs+TqzwleTMqiM9IUq00X4DgGDbI9l
         OZRKluHDyFWjs56RLVEyEl1yKJ+PpOYb6VDzYSpu1WUGPdTgv8akKeJY/g/szIWPNPVm
         8lzZq9gvURon1CDbl7iKhZndZhIhRYXQJrjKRx4+4BNwwqr0Olml3J24eZi1l9U8vhCn
         /yJI8RQPB2KIOMq+7CxkpBtCQNlJaLQ0bHHUKTN7DGjukKUp+cltXvJeLSxFBjqLhF0w
         lsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjPuDFx8oIy9/xSf1mGnS8UxQJqPYndz36Jt2UogPK4=;
        b=QCNIgSletNWPVWpUWbTY/l3DJMYa+CM4hmzoqbsw9P5Q0qbH/ssTs26i20ePmpvbkw
         SPFoN5fmYEMYUCc4HeUpdnBpfFkBotzU1M8TlisFfnYLW4pwvUxF05Nq84ZpdNZAls2v
         A4Q6abuvgNE8gpZyqq8e+MtjL0EXl6H3iScChyIWHG09JqYkBw1/4GbEXpwRf1Ne7+Hr
         fyIwr+1e3cWfLaZgBpKtNUSjab3QwxxHOf1b3PzgOB41nVOGTw6UIyZsegDfYk/weM0d
         2dXWnkK2+omaH1Ot5Oxqm5VHLMVZ6DFLDbE3fMa0VLWNmDMcAXDQpCImMpVUfDURTiq9
         AtMA==
X-Gm-Message-State: AOPr4FX1e++GTIm/ArnKIYfThyAlJLGv6VHGmwN3ISWMG/khGSSiNeFrus2Pa4KDYgqOGA==
X-Received: by 10.98.42.150 with SMTP id q144mr12869605pfq.73.1460553485405;
        Wed, 13 Apr 2016 06:18:05 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id q26sm51194513pfi.57.2016.04.13.06.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:18:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:18:11 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291446>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt         | 22 +++++----
 builtin/worktree.c                     | 81 ++++++++++++++++++++++++++=
++++++++
 contrib/completion/git-completion.bash |  5 ++-
 t/t2028-worktree-move.sh               | 26 +++++++++++
 4 files changed, 124 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index a302f0a..60ad465 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git worktree lock' [--reason <string>] <path>
 'git worktree move' <path> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree remove' [--force] <path>
 'git worktree unlock' <path>
=20
 DESCRIPTION
@@ -78,6 +79,14 @@ prune::
=20
 Prune working tree information in $GIT_DIR/worktrees.
=20
+remove::
+
+Remove a worktree. Only clean worktrees, no untracked files and no
+modification in tracked files, can be removed. Unclean worktrees can
+be removed with `--force`. Main worktree cannot be removed. It needs
+to be converted to a linked worktree first by moving the repository
+away.
+
 unlock::
=20
 Unlock a worktree, allowing it to be pruned, moved or deleted.
@@ -87,9 +96,10 @@ OPTIONS
=20
 -f::
 --force::
-	By default, `add` refuses to create a new working tree when `<branch>=
`
-	is already checked out by another working tree. This option overrides
-	that safeguard.
+	By default, `add` refuses to create a new working tree when
+	`<branch>` is already checked out by another working tree and
+	`remove` refuses to remove an unclean worktree. This option
+	overrides that safeguard.
=20
 -b <new-branch>::
 -B <new-branch>::
@@ -234,12 +244,6 @@ Multiple checkout in general is still experimental=
, and the support
 for submodules is incomplete. It is NOT recommended to make multiple
 checkouts of a superproject.
=20
-git-worktree could provide more automation for tasks currently
-performed manually, such as:
-
-- `remove` to remove a linked working tree and its administrative file=
s (and
-  warn if the working tree is dirty)
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5402a4e..084f8fd 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -17,6 +17,7 @@ static const char * const worktree_usage[] =3D {
 	N_("git worktree lock [<options>] <path>"),
 	N_("git worktree move <path> <new-path>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree remove [<options>] <path>"),
 	N_("git worktree unlock <path>"),
 	NULL
 };
@@ -595,6 +596,84 @@ static int move_worktree(int ac, const char **av, =
const char *prefix)
 	return update_worktree_location(wt, dst.buf);
 }
=20
+static int remove_worktree(int ac, const char **av, const char *prefix=
)
+{
+	int force =3D 0;
+	struct option options[] =3D {
+		OPT_BOOL(0, "force", &force,
+			 N_("force removing even if the worktree is dirty")),
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+	struct strbuf dst =3D STRBUF_INIT;
+	const char *reason;
+	int ret =3D 0;
+
+	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac !=3D 1)
+		usage_with_options(worktree_usage, options);
+
+	strbuf_addstr(&dst, prefix_filename(prefix,
+					    strlen(prefix),
+					    av[0]));
+
+	worktrees =3D get_worktrees();
+	wt =3D find_worktree_by_path(worktrees, dst.buf);
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
+	if (!force) {
+		struct argv_array child_env =3D ARGV_ARRAY_INIT;
+		struct child_process cp;
+		char buf[1];
+
+		argv_array_pushf(&child_env, "%s=3D%s/.git",
+				 GIT_DIR_ENVIRONMENT, wt->path);
+		argv_array_pushf(&child_env, "%s=3D%s",
+				 GIT_WORK_TREE_ENVIRONMENT, wt->path);
+		memset(&cp, 0, sizeof(cp));
+		argv_array_pushl(&cp.args, "status", "--porcelain", NULL);
+		cp.env =3D child_env.argv;
+		cp.git_cmd =3D 1;
+		cp.dir =3D wt->path;
+		cp.out =3D -1;
+		ret =3D start_command(&cp);
+		if (ret)
+			die_errno(_("failed to run git-status on '%s', code %d"),
+				  av[0], ret);
+		ret =3D xread(cp.out, buf, sizeof(buf));
+		if (ret)
+			die(_("'%s' is dirty, use --force to delete it"), av[0]);
+		close(cp.out);
+		ret =3D finish_command(&cp);
+		if (ret)
+			die_errno(_("failed to run git-status on '%s', code %d"),
+				  av[0], ret);
+	}
+	if (remove_dir_recursively(&dst, 0)) {
+		sys_error(_("failed to delete '%s'"), wt->path);
+		ret =3D -1;
+	}
+	strbuf_reset(&dst);
+	strbuf_addstr(&dst, git_common_path("worktrees/%s", wt->id));
+	if (remove_dir_recursively(&dst, 0)) {
+		sys_error(_("failed to delete '%s'"), dst.buf);
+		ret =3D -1;
+	}
+	strbuf_release(&dst);
+	free_worktrees(worktrees);
+	return ret;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -617,5 +696,7 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
 		return unlock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "move"))
 		return move_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "remove"))
+		return remove_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 022d990..6fb45ea 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2596,7 +2596,7 @@ _git_whatchanged ()
=20
 _git_worktree ()
 {
-	local subcommands=3D"add list lock move prune unlock"
+	local subcommands=3D"add list lock move prune remove unlock"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2614,6 +2614,9 @@ _git_worktree ()
 		prune,--*)
 			__gitcomp "--dry-run --expire --verbose"
 			;;
+		remove,--*)
+			__gitcomp "--force"
+			;;
 		*)
 			;;
 		esac
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 83fbab5..668ee05 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -74,4 +74,30 @@ test_expect_success 'move main worktree' '
 	test_must_fail git worktree move . def
 '
=20
+test_expect_success 'remove main worktree' '
+	test_must_fail git worktree remove .
+'
+
+test_expect_success 'remove locked worktree' '
+	git worktree lock destination &&
+	test_must_fail git worktree remove destination &&
+	git worktree unlock destination
+'
+
+test_expect_success 'remove worktree with dirty tracked file' '
+	echo dirty >>destination/init.t &&
+	test_must_fail git worktree remove destination
+'
+
+test_expect_success 'remove worktree with untracked file' '
+	git -C destination checkout init.t &&
+	: >destination/untracked &&
+	test_must_fail git worktree remove destination
+'
+
+test_expect_success 'force remove worktree with untracked file' '
+	git worktree remove --force destination &&
+	test_path_is_missing destination
+'
+
 test_done
--=20
2.8.0.rc0.210.gd302cd2
