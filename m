From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 6/6] worktree: add "unlock" command
Date: Mon, 30 May 2016 17:49:39 +0700
Message-ID: <20160530104939.28407-7-pclouds@gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com>
 <20160530104939.28407-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 12:50:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KmT-0005RL-Ci
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbcE3Kul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 06:50:41 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35855 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbcE3Kuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 06:50:40 -0400
Received: by mail-pa0-f65.google.com with SMTP id fg1so21083874pad.3
        for <git@vger.kernel.org>; Mon, 30 May 2016 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mwxomlSSi1tLyqQxK+msrLiPOyFHJjTgwIY1gyko7jw=;
        b=mf033OWIqqGZHSuPTXOPeONARuNLB6U0fzJcwGoSB82V/+zGxtE6aHdmBvr6Fe5oHs
         2SNJUki3veZFynTuosiyk3H+nmeCCgH2C+Ogx8bOMVfwmZ+gItdJOqNUYw3Bvd6+nfN8
         arBdVr/AGlw5QWJlQIlc3RYB2pYRaYmwTGEOZEz4NLX8eQYaz4qbfEZEYn25G0UDI9yu
         YutE39Fj9zDX5Z5t2jaVV6U/RJQom/pGWKk3OlmFVI8Mg01f/QGoMK9Ca4HcJyinD/tD
         tVhfrKgQMWQvixu3hbZ5NxhXjHLMx7JIg0e9ix2Vmh4t7x9nxR2ik2hFdVr/plq/HFcJ
         jhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mwxomlSSi1tLyqQxK+msrLiPOyFHJjTgwIY1gyko7jw=;
        b=NX4XrXvBh8NKgoKLi80skC8MeV3SCHroMbc2lQRfuFZEsjyPXcJChC9BanEswxINmW
         loLX7ofiaw9YpXThnC3BCFIJxO+UFEQh+33ADW6YGnoOH9rtwBoZJA2jYB41NsM69YXt
         KnyhK36zYUWSGVQjxjm6+Q5ay9hPWKVQoLrhSpTHlLwbE+Hn82BS6leA303+LrDOsnxS
         kEDnRJPNo6BKGgpOEZ7Q2Tm7NEaJjjwCxUr3FtvYw4EeK97eGS8OS8xtyZlFd62BSP7M
         f/9/GtcAAgqjVBHk7iZDaBhKP9NRlV/zqcOQLPNUqdO/JoBD2W5fmXLb6s8TXKYLr2Xl
         Ti4Q==
X-Gm-Message-State: ALyK8tJ1g21Dx/QvS77Mxn3AyVt6LZkhjmvJji1NZXXnEiFwp3L+ZbIEW+urXlEaVZ3Vjg==
X-Received: by 10.67.30.6 with SMTP id ka6mr34602426pad.120.1464605439714;
        Mon, 30 May 2016 03:50:39 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id o87sm31995121pfa.75.2016.05.30.03.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 03:50:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 30 May 2016 17:50:34 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160530104939.28407-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295884>

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
index 6fca6cf..6a5ff47 100644
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
+Unlock a worktree, allowing it to be pruned, moved or deleted.
+
 OPTIONS
 -------
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 84fe63b..5fe9323 100644
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
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+	if (!wt->lock_reason)
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
