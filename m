From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7 04/11] show --stat: use the full terminal width
Date: Fri, 24 Feb 2012 21:32:11 +0100
Message-ID: <1330115538-1576-4-git-send-email-zbyszek@in.waw.pl>
References: <4F47F394.5070007@in.waw.pl>
 <1330115538-1576-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 24 21:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11qH-0000vk-NQ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093Ab2BXUeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 15:34:09 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55100 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758001Ab2BXUeI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:34:08 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S11qA-00042s-KM; Fri, 24 Feb 2012 21:34:06 +0100
X-Mailer: git-send-email 1.7.9.2.332.g05f13
In-Reply-To: <1330115538-1576-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191464>

Make show --stat behave like diff --stat and use the full terminal
width.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 builtin/log.c          | 2 ++
 t/t4052-stat-output.sh | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7d1f6f8..d37ae26 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -447,6 +447,8 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 	rev.diff =3D 1;
 	rev.always_show_header =3D 1;
 	rev.no_walk =3D 1;
+	rev.diffopt.stat_width =3D -1; 	/* Scale to real terminal size */
+
 	memset(&opt, 0, sizeof(opt));
 	opt.def =3D "HEAD";
 	opt.tweak =3D show_rev_tweak_rev;
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 4bfd6a5..91c4ba8 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -95,7 +95,7 @@ do
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
-ignores expect80 show --stat
+respects expect200 show --stat
 ignores expect80 log -1 --stat
 EOF
=20
@@ -163,7 +163,7 @@ do
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
-ignores expect80 show --stat
+respects expect200 show --stat
 ignores expect80 log -1 --stat
 EOF
=20
--=20
1.7.9.2.332.g05f13
