From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 23/26] worktree: add "unlock" command
Date: Tue, 16 Feb 2016 20:29:24 +0700
Message-ID: <1455629367-26193-24-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjA-0003yA-8R
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbcBPNbe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:34 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34728 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbcBPNbb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:31:31 -0500
Received: by mail-pa0-f48.google.com with SMTP id fy10so64118447pac.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5EiEJS4z7iqWXTEcok6yZqMSJvdoRmUYLVezUCoHYvc=;
        b=Ws+De6nGukawOYIGI0WDzX/k3wZxaYi7Mel5YJeRhEmyXb6xGdJW28XbRoyFvwJxtY
         cPFWq1oPrD6b4o1po64yUZCOtN5ftR0DhK3sxmkQPJVMg00q6EZEpEvvsVdJVoH49OLv
         AhNqiLGpkx3NKG76NBf7F+EzchaNCBv/vZQtKWYCxUph+ALCtjy1PrPUWX1NDQHuspN0
         LmL5erYfqktImvnydJ9xQkmZXSdUtPkI08GZQJDGmTWS2UAQu6OcUyXfbKuk+NrG6WBg
         m6iXrC/NKICTZfKQz54Brw1jn2kVV2qGeTUER8XabcrKny0Uhe8xiU+Q46TRIhX+SJBl
         A6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=5EiEJS4z7iqWXTEcok6yZqMSJvdoRmUYLVezUCoHYvc=;
        b=TJDHYc1kidPKEAxccYaYQHR7CxcY4nhqdOcaGSFkaOYEpJdFbJcdi00lWGKlEfsMkZ
         9FGBarsnSOFvsrZneT/SVzjJdrOIz7eE9GL37dRIQHcpEa3YBoohKAmWM26UYLckgxnE
         QYNUSrJlKTD92jaP8pLzq6sz8J0/v7CXGWETKQ0GaqdTdctrv5LNksndwxzf0WTwt8Me
         aASvc52buNLcrivzDMGBDTYK50EW7l6+6ci9GG5GddfWwO7hG5D3c/vNR778Hzfua8jM
         GXYHtnDcHI/FSEEoML6od0meNKMFGj1eSxD5KoZpCQObBjwBzal3bE6vZxBZTyKfN+AF
         thVg==
X-Gm-Message-State: AG10YOQk4TMHfiabsP7PCUO4gyUwEbh6n4+Cw2YWQ7ACceTJQpANLaYIszyk3QEAe6/oAA==
X-Received: by 10.66.225.177 with SMTP id rl17mr31016634pac.46.1455629491220;
        Tue, 16 Feb 2016 05:31:31 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id s21sm45965916pfi.29.2016.02.16.05.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:31:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:54 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286389>

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
index 9f0c9f0..8315e5b 100644
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
index f45a425..c5b26e7 100644
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
@@ -484,6 +485,34 @@ static int lock_worktree(int ac, const char **av, =
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
@@ -502,5 +531,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index c9a8d04..8d7867c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2596,7 +2596,7 @@ _git_whatchanged ()
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
2.7.0.377.g4cd97dd
