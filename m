From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 5/6] worktree: add "unlock" command
Date: Mon, 13 Jun 2016 19:18:25 +0700
Message-ID: <20160613121826.21631-6-pclouds@gmail.com>
References: <20160603121944.28980-1-pclouds@gmail.com>
 <20160613121826.21631-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 14:19:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQq7-0004he-QO
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 14:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbcFMMTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 08:19:32 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34176 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965049AbcFMMTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 08:19:30 -0400
Received: by mail-pa0-f65.google.com with SMTP id ug1so10443031pab.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ovDVmnrgGwPPA+TAbSvqpYHyxPBkPILTL5nZNlNGcgQ=;
        b=C7Km5H1SyrT9oz9NAhqBhXfPijtOdGj15h4PMMm3yjSrjJs7n90Zd9zppajjgCd335
         fxwhja0Z0EkwqJHdOlx0/eu6WSIBnvV2K0FTY+mVepDapAOORoiPDqS14u2ScyEy3/Ui
         jrOzw9u0Ox7VpDYXaNpg9+fP0rhuaJnrOVSMppSECIpNLDaadW553C9imnUCEFJPxge/
         r9AQusuQ4ASUqdHCU0n5pgRNZJB320qcJcejinuIBbVe31Hco5aVAu//S5HqJO6/hvEp
         ZtAe0r3AHog+eS2DiGPJsCGooW4ViCcG8tThmd7gmUPtCi7Sf2qzyWSDWk9oPqAfUPog
         98gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ovDVmnrgGwPPA+TAbSvqpYHyxPBkPILTL5nZNlNGcgQ=;
        b=DXHA0qYnS34lMgyztOtQc0hF1Z9/slIgc7OkCQnOKEhZBIrdNUFGt2tLzo0R8v5suA
         DcnbSMcvLfEqdMBan5rkhO5qpShfzZK7y5nZYhYR1xGv36W+b6Iexmfmy3TpJDIQF1k2
         oZDO9w19utNHU8w//3QB3zZSu/1+cTUVzLTJKQUikq6mBquZ88aKwOM5W42VcTAGT19u
         0o+xgTI1raQdgjDR8etgf7zKcYt8uIchmeSyLqG648Q8+GZUE0WZsB9fY559WzEGPVJv
         RqhUm5+5K5ZlQn5VYD1p6cjeVq/QsbS4mB/2QQlM1HME6BW4hqXb4pYM3iWel4l/YoVn
         7/bQ==
X-Gm-Message-State: ALyK8tIbqIGA1HzWVlCkCN4PtLk80Lr6+35l5/kVu6DxnGHGU+KcDZNKa/3q/CLNFug1DQ==
X-Received: by 10.66.101.136 with SMTP id fg8mr21553570pab.144.1465820365016;
        Mon, 13 Jun 2016 05:19:25 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id d2sm33957025pfk.36.2016.06.13.05.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 05:19:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Jun 2016 19:19:20 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160613121826.21631-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297186>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt         |  5 +++++
 builtin/worktree.c                     | 28 ++++++++++++++++++++++++++=
++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 14 ++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index b49b25b..27330c5 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree unlock' <worktree>
=20
 DESCRIPTION
 -----------
@@ -73,6 +74,10 @@ prune::
=20
 Prune working tree information in $GIT_DIR/worktrees.
=20
+unlock::
+
+Unlock a working tree, allowing it to be pruned, moved or deleted.
+
 OPTIONS
 -------
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3b9220f..4877421 100644
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
@@ -495,6 +496,31 @@ static int lock_worktree(int ac, const char **av, =
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
+	int ret;
+
+	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac !=3D 1)
+		usage_with_options(worktree_usage, options);
+
+	worktrees =3D get_worktrees();
+	wt =3D find_worktree(worktrees, prefix, av[0]);
+	if (!wt)
+		die(_("'%s' is not a working tree"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("The main working tree cannot be locked or unlocked"));
+	if (!is_worktree_locked(wt))
+		die(_("'%s' is not locked"), av[0]);
+	ret =3D unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id)=
);
+	free_worktrees(worktrees);
+	return ret;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -513,5 +539,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index 87afc2e..68d3fe8 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -45,4 +45,18 @@ test_expect_success 'lock worktree twice (from the l=
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
