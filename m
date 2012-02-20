From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 5/8 v6] log --stat: use the full terminal width
Date: Mon, 20 Feb 2012 22:57:11 +0100
Message-ID: <1329775034-21551-6-git-send-email-zbyszek@in.waw.pl>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 20 22:58:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbFg-0004Zv-JA
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 22:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501Ab2BTV6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 16:58:17 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52851 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091Ab2BTV6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 16:58:03 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RzbFB-0007o6-Vy; Mon, 20 Feb 2012 22:58:02 +0100
X-Mailer: git-send-email 1.7.9.1.353.g684b4
In-Reply-To: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191115>

Make log --stat behave like diff --stat and use the full terminal
width.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 builtin/log.c          | 1 +
 t/t4052-stat-output.sh | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git builtin/log.c builtin/log.c
index d37ae26..075a427 100644
--- builtin/log.c
+++ builtin/log.c
@@ -77,6 +77,7 @@ static void cmd_log_init_defaults(struct rev_info *re=
v)
 		get_commit_format(fmt_pretty, rev);
 	rev->verbose_header =3D 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
+	rev->diffopt.stat_width =3D -1; /* use full terminal width */
 	rev->abbrev_commit =3D default_abbrev_commit;
 	rev->show_root_diff =3D default_show_root;
 	rev->subject_prefix =3D fmt_patch_subject_prefix;
diff --git t/t4052-stat-output.sh t/t4052-stat-output.sh
index 91c4ba8..acc54cd 100755
--- t/t4052-stat-output.sh
+++ t/t4052-stat-output.sh
@@ -96,7 +96,7 @@ done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
 respects expect200 show --stat
-ignores expect80 log -1 --stat
+respects expect200 log -1 --stat
 EOF
=20
 cat >expect <<'EOF'
@@ -164,7 +164,7 @@ done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
 respects expect200 show --stat
-ignores expect80 log -1 --stat
+respects expect200 log -1 --stat
 EOF
=20
 cat >expect <<'EOF'
--=20
1.7.9.1.353.g684b4
