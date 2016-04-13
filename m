From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/25] worktree: add "unlock" command
Date: Wed, 13 Apr 2016 20:15:43 +0700
Message-ID: <1460553346-12985-23-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:18:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKgB-0004wX-Ep
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760693AbcDMNRw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:52 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36750 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760687AbcDMNRt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:49 -0400
Received: by mail-pa0-f68.google.com with SMTP id k3so3915965pav.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hg8vxjpoJsQTYadqJmOkHvN+Y7aMLKnfKhSb3QDSJPw=;
        b=QRuv4OiAIS9Wvk6PWOK/7FO/SnjLWuS61Y0JQpVaHDBDbptAv2yL1PeGfPA45QqSgF
         ytNZX0i0Sn/YF369SaxiMEezfgV2oDJVHTKjftnfXY2hCkW3ZNi4yUlkwEmo4XzwhMG+
         +zZZqhGpw5E2I1RXvWrpZLo3fYQ1ohmg7MZ1RT67KvuChGl2eyYqDsHmcdoJBD6t0Kal
         PwcQZf3hxNJQubIPw9jP+12k8Qu/u5ds8QYlyJ83XRGub2gyyakpaCWHKhSmXFD6S4x2
         3cqSKEnA1xzqyR+KtfNMgpmQ25LrzPElqDEFgfyXtdJKZkJP9TWFAD0C754UBbZ8Jway
         DOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hg8vxjpoJsQTYadqJmOkHvN+Y7aMLKnfKhSb3QDSJPw=;
        b=dK2fcQGXRnvyaQM1KehHdZhvVqJTLMOHvo6iqaR54EUK/+8aL2OzVa3TS8inL0CwaU
         t5f6CbgmoU5DlOgpWV0bwAhL6D/Y9VRHKWGkhvR8Xv2dgOaVj/wPASHHWWuw72rQ8t/I
         oNVCtOVCXsjclhfqGaEw1DVnA5bbVCaYui+AAUSiAiwWDz5/wwkVfcQbHvQ+F7kr7ark
         A12V8JCv8iev7I5pKX6qJ/8Kct/pbp5MuLJj0/XwwqkbcY0ZfMOm//5VrQFe/1QtG/XJ
         uZaD2xuhkBa0FXchhSdphRILJAcjSHfpitPcqFcLWJtCWb7HUlYXe2xSBVv++OrVKoqQ
         VQIQ==
X-Gm-Message-State: AOPr4FXMdfmhK6PCTRPN/ytyVe7rBiFmOW9NH+awJ+kOPK5NSwkFIswV/JI4bJ2xooWBQQ==
X-Received: by 10.66.150.163 with SMTP id uj3mr12895659pab.23.1460553468596;
        Wed, 13 Apr 2016 06:17:48 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id d2sm11212260pfd.80.2016.04.13.06.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:54 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291444>

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
index 736caff..13f4083 100644
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
@@ -491,6 +492,34 @@ static int lock_worktree(int ac, const char **av, =
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
@@ -509,5 +538,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index cdae408..d7d92ac 100644
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
2.8.0.rc0.210.gd302cd2
