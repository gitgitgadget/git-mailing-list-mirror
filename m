From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] worktree: add "unlock" command
Date: Tue, 10 May 2016 21:17:29 +0700
Message-ID: <20160510141729.23063-5-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160510141729.23063-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:18:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08UH-0000f2-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbcEJOSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:18:08 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33775 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbcEJOSF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:18:05 -0400
Received: by mail-pa0-f67.google.com with SMTP id gh9so1007565pac.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ldv48rKU7QD3GTRPU3DsEzQiuW9DLEDwd9qKewgan8Q=;
        b=aLSeMlkHlrWFTLUA76z7+vaM4B2vVTz5qDHzntjiynE+SYHlbvymeHf4EQLC6kiW9r
         b1/ChpiBJ4AYHrB5hzHW75ELi0xXlNhTVBM/Aq2m+4tsgg8f3LWhcVu/LnfiYydm1IlC
         i0yBEhDcaW0olFi4HsiywQraiZpQxpPLMfUGn/3B9ZghZe6YuB1AJ4tkADWL1EpG75c7
         n90jCc+gEQHbZdnwfDipQs+sV74LEezP+Cs+2Xzrl0BEAybT4f+9ELQqzEwEFcUqmjjb
         4CPJb/1k1adstJS2B4sXzUsdQjabpu7XhcLFjy5nwKJmwOvKLojWpTgirGC6PMAzOPpi
         swXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ldv48rKU7QD3GTRPU3DsEzQiuW9DLEDwd9qKewgan8Q=;
        b=Wn2gHK1V8763GSCAKv6axCaLc8pE7Bllq45xilJVu2TfiJgWBLJNsl+kvktUI0f3uG
         hhN/GGsgotUfyK45edTNS+E65VOpIjF1hmarjso+ISdWI+m7g8ibanUJzPfLn9RSaQXC
         tfZci1D3v+fhkQeUasR80HghJtxy5W9SG2P/K9k+RFeqB4dJcY6o5DhZq1VgvEiw349U
         Ij9g73eQrsIx47FugJNLe1I9B8toKWhY0EG3WWGpm+AtvDaijY8UL6PJQoIxEL7edHm7
         RkfSa69w6KxaMmg0ihJ18TAseKsdhiISOQnu5FUb3NkvYXaAwGiR2vQWYH3CKVz+dnRg
         +c2A==
X-Gm-Message-State: AOPr4FUt2z0IVQZMeniZ/w3kU3kZlavaLzx2PvqbUhsCImXNE2Je2pr06VxAxZ3iDwfrXw==
X-Received: by 10.66.182.134 with SMTP id ee6mr59753654pac.89.1462889884535;
        Tue, 10 May 2016 07:18:04 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id v75sm4938565pfa.94.2016.05.10.07.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:18:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:18:06 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141729.23063-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294146>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt         |  5 +++++
 builtin/worktree.c                     | 31 ++++++++++++++++++++++++++=
+++++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 14 ++++++++++++++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 74583c1..9ac1129 100644
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
@@ -72,6 +73,10 @@ prune::
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
index 51fa103..53e5f5a 100644
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
@@ -498,6 +499,34 @@ static int lock_worktree(int ac, const char **av, =
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
+	if (!is_worktree_locked(wt))
+		die(_("not locked"));
+
+	return unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id))=
;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -516,5 +545,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index 6c321aa..db4b0e7 100644
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
index 97434be..f4b2816 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -31,4 +31,18 @@ test_expect_success 'lock worktree twice' '
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
