From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7a 3/9] show --stat: use the full terminal width
Date: Thu,  1 Mar 2012 13:26:40 +0100
Message-ID: <1330604806-30288-3-git-send-email-zbyszek@in.waw.pl>
References: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
 <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 01 13:28:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S357x-0005So-8r
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 13:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759033Ab2CAM2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 07:28:52 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55375 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759011Ab2CAM2v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 07:28:51 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S357d-00026K-2n; Thu, 01 Mar 2012 13:28:38 +0100
X-Mailer: git-send-email 1.7.9.2.399.gdf4d.dirty
In-Reply-To: <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191921>

Make show --stat behave like diff --stat and use the full terminal
width.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c          |    2 ++
 t/t4052-stat-output.sh |    4 ++--
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
index 29c06e5..56d3899 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -97,7 +97,7 @@ do
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
1.7.9.2.399.gdf4d.dirty
