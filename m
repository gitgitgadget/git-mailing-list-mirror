From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 26/26] worktree: add "remove" command
Date: Tue, 16 Feb 2016 20:29:27 +0700
Message-ID: <1455629367-26193-27-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjX-0004Ji-4U
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbcBPNbw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:52 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33849 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262AbcBPNbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:31:49 -0500
Received: by mail-pa0-f49.google.com with SMTP id fy10so64122106pac.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OHw11GueXiFS/6k8ppIUxsMarOTWYL4AdJWHNwL+x0k=;
        b=UfIeO4ukU8LC85HuL12kedj1/wGCBFl6BF0LVFe43QoGOTfHyB4VUwJD1iyH+eyEt1
         vjG0kK+PKEztKaASgSRwjCCjUxTbofwSpc/0zxePSsxFDXnOTP76mbJG+cssJ8gkYHz8
         Me+S36Zw7ct2c88NIYDz2lJ/qOJmCh+ZVmM3kzDBY+QIrU/NuNQbq0dsOvPpsZwnnst4
         pq0pQZ2PSgEuxvo8I/OxIBSHObxiF53OArmctAX04CHx1n8mv/tTfSbSZhTy8nhXTofl
         QuMNgE1S59WaWsnMqJMqGeTbC2oWBOQCc40AQnTBrWXmzi1DOue9+ntezJFrHzwfHnv+
         Gegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OHw11GueXiFS/6k8ppIUxsMarOTWYL4AdJWHNwL+x0k=;
        b=DVYepDGcDJFUQTzvLmBh6Lk3LdwAAJmWO0vVKJ2pRIhgBKBOKBq/nAQNRrz33VPWyI
         gtvonz8MoWe9QlmwtAXPgTKtiUumFMPWAu3z4+7hDy6RCvU9gIv2RpCZtR5r9MTPBnHz
         /P2nTHCwXRP/yEcrbIAyXE46tJrU8vCWSXna/aXQBtb3TtSWX5YmJ1c/zfDDL852VRyJ
         StRyfFhAcgXMsIHjVZwJqXBj9tOPwA2+VSrxJrCBRsFGcUYEYIxgS5YY2RNWQmBTkKDL
         zagqT7+eyWwnjVQchUsXZeMyKZO1wGW4NiSt7QD1CWCeb4iQ3ofzvKcQFI9d/Gl4CLT+
         ZiGw==
X-Gm-Message-State: AG10YORJxuc8tZjIMl46JvpmNamCEbI04Qh/46eMMhYY74VOXM+lOsgCiczgf2JVchhE9g==
X-Received: by 10.66.100.163 with SMTP id ez3mr31171595pab.27.1455629509231;
        Tue, 16 Feb 2016 05:31:49 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id n68sm45987924pfj.46.2016.02.16.05.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:31:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:32:12 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286396>

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
index d4ce987..8cff943 100644
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
@@ -588,6 +589,84 @@ static int move_worktree(int ac, const char **av, =
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
@@ -610,5 +689,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index 4e01841..6eda7ed 100644
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
2.7.0.377.g4cd97dd
