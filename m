From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7a 4/9] log --stat: use the full terminal width
Date: Thu,  1 Mar 2012 13:26:41 +0100
Message-ID: <1330604806-30288-4-git-send-email-zbyszek@in.waw.pl>
References: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
 <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 01 13:29:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S358V-0005n2-75
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 13:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759045Ab2CAM3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 07:29:06 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55379 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759036Ab2CAM3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 07:29:05 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S3583-00026K-AH; Thu, 01 Mar 2012 13:29:03 +0100
X-Mailer: git-send-email 1.7.9.2.399.gdf4d.dirty
In-Reply-To: <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191922>

Make log --stat behave like diff --stat and use the full terminal
width.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c          |    1 +
 t/t4052-stat-output.sh |    4 ++--
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
index 56d3899..f81d427 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -98,7 +98,7 @@ done <<\EOF
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
1.7.9.2.399.gdf4d.dirty
