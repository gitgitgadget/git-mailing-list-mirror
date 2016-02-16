From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 24/26] worktree: add "move" commmand
Date: Tue, 16 Feb 2016 20:29:25 +0700
Message-ID: <1455629367-26193-25-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjE-00047S-Iq
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbcBPNbk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:40 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33807 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbcBPNbh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:31:37 -0500
Received: by mail-pf0-f180.google.com with SMTP id x65so105418148pfb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fLEyx6oaZSZLJUOVjXahpVnZxTyH/EIVItHeSt5pB90=;
        b=Ha9KpwsZDOjsWad9a8cU+LGOMpWRen7itbjP3EQCaff+ceVobJHuLxmaklYbGWF8r2
         KKJJWLdu4CqMNXcMxlcDDO6omr2yqi5T3LvkkOtrdWLsBxOCmfC8mH9o9vNWdE7vtdlT
         qnxRpZtq2LPUH0C+JZNjZDPtCqZU4f/nDbYNJ78lTtWkQl3F1K0z5lU/GVlx5OGOhmcO
         efXWKWfbjCZCaLZu6tEsCbip+MCqvH39GpxI09YH265qYR2/URSl94mvpeq1S8xPiCUl
         Ra3DTN5lQYfe2+co/rm2D3W+trQY7guhnQ8IXA2lciQ8dA0PFANjNiwxzXTUYAbM32iQ
         ofKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=fLEyx6oaZSZLJUOVjXahpVnZxTyH/EIVItHeSt5pB90=;
        b=Wq66IkJBP3OwGRmPA+9Iglb/Q+oYxg00bPM7toJfM+gYVH7RRcx4qYWXga43aWO5RN
         AJnOFoQOQd7UIo2eAo4ejs3S3J286HCgomakg5lRm82XsZ2K4RZlgPkDyRtEgbWP1CZO
         X5UP5bdcH9TySbutZYWsOwOylGgVzrp+/5Gzve0Q+1A7yhHgnlVWxqRZKl5Sizo1LjQj
         r0caS3swAtJuEXSjpcgu/KJSLAh7BNJlqt0Yd0TAp5e27BTAblRqPm9q20RaGGiHEk6G
         +s58ITk54nmNdZWYwU2vFntd79FAH1ENfihaqri7MWE7GcxwaoB4lA7BUdp+FZ0e/IQt
         epvQ==
X-Gm-Message-State: AG10YORAvVzkKOOkc4jun8Nyiru5r31Kz81aZB0BddartDuDWlSxjCLdp++dfJe7v9Wwdw==
X-Received: by 10.98.0.148 with SMTP id 142mr5828052pfa.84.1455629497248;
        Tue, 16 Feb 2016 05:31:37 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id tp6sm46068771pab.25.2016.02.16.05.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:31:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:32:00 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286394>

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
index c5b26e7..acd49da 100644
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
@@ -513,6 +514,63 @@ static int unlock_worktree(int ac, const char **av=
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
@@ -533,5 +591,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index 8d7867c..4e01841 100644
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
2.7.0.377.g4cd97dd
