From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/5] worktree: add "unlock" command
Date: Sun, 22 May 2016 17:43:41 +0700
Message-ID: <20160522104341.656-6-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160522104341.656-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 12:44:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4QsE-00028h-RA
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 12:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbcEVKoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 06:44:39 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35823 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbcEVKoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 06:44:37 -0400
Received: by mail-pa0-f67.google.com with SMTP id rw9so15154800pab.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrleMp6y8ugb/S/1hFgI82472YtIZh5/ysdDW97hiHI=;
        b=R+uOy3FGL+g2RxYxP0XR0mO68ACFlWtiWPGvz2UzFFCIFrTRBlrYY1G/1vahtl53tj
         pkMYJ7WtEBlENojhbOoczT0VkapqC+s204AsSzKoOuOyxZqaOWT0iRU9rEuQVxVLKQIS
         8+VhhvA+WGto/aiLvt4y5UfTmjGrRzV2ScDF2Y216YK4cLFdwFNu5h1ujQvw++8V6dZ8
         /YPq3tU75800rmyB2dCms/m2xXA9xlzKW66WOADsV8Fp0MPJjWmbcJxplBPVmLDMFT6d
         U4nbW2bELZd0DxFCi4r4bllluBhYkDP90WwN0QT0rInAUQPLOvMsnY2zV3cm6UeTj9B8
         axwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrleMp6y8ugb/S/1hFgI82472YtIZh5/ysdDW97hiHI=;
        b=W6zoVYW9N8/vZDMKkdVfkDzkQdgjaXVvYlKFv4MTVjdDsG16Kas+AXh+F7BemxYq+e
         lf4eWjoIWBgRIGmCw0qDeOkj8+6NUtvRdP9rOaWvxxz01lmwSuZs87fK6aPLm04SJ+GH
         tmg+qJaQp1wVyWAaAQtiH/GsXepbNhFRbepSAgY9bCtYVrfeoHo91DyVJrBtyYAbZfcX
         NMbuh7f/49uEaFxNat6RY9obRwHD3paQm9h29D9ENyvXroLpo/WfV2Zo+bzFPXW9omIR
         J0HvTrpEm3wOYKuq65rn9wGw4C3C3LbUZKq9j4ZqbcQXYkGF5bGRn26sifkWMvXv3/l8
         DNwQ==
X-Gm-Message-State: AOPr4FWYTRMqJSgbb23S2bAgZ6L5+y7rPl7JZ2swf5Cvw0+V9aiVad7INhr7loxyNasIBQ==
X-Received: by 10.66.65.235 with SMTP id a11mr18598705pat.155.1463913877055;
        Sun, 22 May 2016 03:44:37 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id uw2sm39074742pac.10.2016.05.22.03.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 03:44:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 17:44:32 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522104341.656-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295275>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt         |  5 +++++
 builtin/worktree.c                     | 34 ++++++++++++++++++++++++++=
++++++++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 14 ++++++++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 004d770..e0f2605 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree unlock' <path>
=20
 DESCRIPTION
 -----------
@@ -73,6 +74,10 @@ prune::
=20
 Prune working tree information in $GIT_DIR/worktrees.
=20
+unlock::
+
+Unlock a worktree, allowing it to be pruned, moved or deleted.
+
 OPTIONS
 -------
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9008dcd..da9f771 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -16,6 +16,7 @@ static const char * const worktree_usage[] =3D {
 	N_("git worktree list [<options>]"),
 	N_("git worktree lock [<options>] <path>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree unlock <path>"),
 	NULL
 };
=20
@@ -500,6 +501,37 @@ static int lock_worktree(int ac, const char **av, =
const char *prefix)
 	return 0;
 }
=20
+static int unlock_worktree(int ac, const char **av, const char *prefix=
)
+{
+	struct option options[] =3D {
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+	struct strbuf dst =3D STRBUF_INIT;
+	int ret;
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
+	strbuf_release(&dst);
+	if (!wt)
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+	if (!is_worktree_locked(wt))
+		die(_("not locked"));
+	ret =3D unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id)=
);
+	free_worktrees(worktrees);
+	return ret;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -518,5 +550,7 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
 		return list(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "lock"))
 		return lock_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "unlock"))
+		return unlock_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index f88727d..0e3841d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2597,7 +2597,7 @@ _git_whatchanged ()
=20
 _git_worktree ()
 {
-	local subcommands=3D"add list lock prune"
+	local subcommands=3D"add list lock prune unlock"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index aeac848..1927537 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -51,4 +51,18 @@ test_expect_success 'lock worktree twice (from the l=
ocked worktree)' '
 	test_cmp expected .git/worktrees/source/locked
 '
=20
+test_expect_success 'unlock main worktree' '
+	test_must_fail git worktree unlock .
+'
+
+test_expect_success 'unlock linked worktree' '
+	git worktree unlock source &&
+	test_path_is_missing .git/worktrees/source/locked
+'
+
+test_expect_success 'unlock worktree twice' '
+	test_must_fail git worktree unlock source &&
+	test_path_is_missing .git/worktrees/source/locked
+'
+
 test_done
--=20
2.8.2.524.g6ff3d78
