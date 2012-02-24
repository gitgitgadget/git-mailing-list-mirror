From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7 05/11] log --stat: use the full terminal width
Date: Fri, 24 Feb 2012 21:32:12 +0100
Message-ID: <1330115538-1576-5-git-send-email-zbyszek@in.waw.pl>
References: <4F47F394.5070007@in.waw.pl>
 <1330115538-1576-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 24 21:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11ri-0001px-6i
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab2BXUfi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 15:35:38 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55105 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab2BXUfh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:35:37 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S11rc-00042s-KD; Fri, 24 Feb 2012 21:35:36 +0100
X-Mailer: git-send-email 1.7.9.2.332.g05f13
In-Reply-To: <1330115538-1576-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191465>

Make log --stat behave like diff --stat and use the full terminal
width.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 builtin/log.c          | 1 +
 t/t4052-stat-output.sh | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d37ae26..075a427 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -77,6 +77,7 @@ static void cmd_log_init_defaults(struct rev_info *re=
v)
 		get_commit_format(fmt_pretty, rev);
 	rev->verbose_header =3D 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
+	rev->diffopt.stat_width =3D -1; /* use full terminal width */
 	rev->abbrev_commit =3D default_abbrev_commit;
 	rev->show_root_diff =3D default_show_root;
 	rev->subject_prefix =3D fmt_patch_subject_prefix;
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 91c4ba8..acc54cd 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
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
1.7.9.2.332.g05f13
