From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] status: remove i18n legos
Date: Thu,  6 Sep 2012 22:16:50 +0700
Message-ID: <1346944610-15815-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 17:23:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9dvb-0007Zh-GR
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 17:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757523Ab2IFPX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 11:23:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61760 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab2IFPX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 11:23:26 -0400
Received: by iahk25 with SMTP id k25so2163797iah.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=jx4XXcni9xjglSAFS6CTCa8DzFaXGSKRfCDSWD6mwLc=;
        b=nM5W9jFxQeK1SQxD5cl0/4FyHFiS5ZepEIkof2Dt2PMN4QOyOWG8AZblQfFs9RoW9a
         TO6Av8U4qdoJiXhKTU3/xoJJI7uAJpNRGVUHGvy3AxyFB7qc+T8HMNigr8HaZhWzxNwR
         YBYSzQVX0co2DS7UVqYl6i4/IouVwy8GMsttfpfU2+yx5BM04d3xTKS3c046xxREznLV
         84wzswZMbfyImtEJSjbGemXZaa6SkVami5oUTlllqCeslAh8YDvrJF12gVkkaAxBpVLX
         +wwPzQMJ2n1ieKA5LqnntR3cUeCH+TgfTvLDvWyzpoayjYXFoi3j5+lY90jp2rAJeSm6
         AjxA==
Received: by 10.50.187.170 with SMTP id ft10mr23519183igc.36.1346945005929;
        Thu, 06 Sep 2012 08:23:25 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.40.250])
        by mx.google.com with ESMTPS id i17sm3910257igd.5.2012.09.06.08.23.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 08:23:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 06 Sep 2012 22:16:52 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204898>

"%s files" gives no sense what "%s" might be. Give translators full
phrases.

"blah blah blah%s\n" where %s is another sentence does not show the rea=
l
length of full line. As a result, l10n messages may exceed 80 columns
unintentionally. Make it two sentences.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c110cbc..4eeaf23 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -221,7 +221,7 @@ static void wt_status_print_other_header(struct wt_=
status *s,
 					 const char *how)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
-	status_printf_ln(s, c, _("%s files:"), what);
+	status_printf_ln(s, c, "%s:", what);
 	if (!advice_status_hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in w=
hat will be committed)"), how);
@@ -1008,9 +1008,9 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files) {
-		wt_status_print_other(s, &s->untracked, _("Untracked"), "add");
+		wt_status_print_other(s, &s->untracked, _("Untracked files"), "add")=
;
 		if (s->show_ignored_files)
-			wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
+			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f")=
;
 	} else if (s->commitable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%=
s"),
 			advice_status_hints
@@ -1023,23 +1023,31 @@ void wt_status_print(struct wt_status *s)
 			status_printf_ln(s, GIT_COLOR_NORMAL, _("No changes"));
 		else if (s->nowarn)
 			; /* nothing */
-		else if (s->workdir_dirty)
-			printf(_("no changes added to commit%s\n"),
-				advice_status_hints
-				? _(" (use \"git add\" and/or \"git commit -a\")") : "");
-		else if (s->untracked.nr)
-			printf(_("nothing added to commit but untracked files present%s\n")=
,
-				advice_status_hints
-				? _(" (use \"git add\" to track)") : "");
-		else if (s->is_initial)
-			printf(_("nothing to commit%s\n"), advice_status_hints
-				? _(" (create/copy files and use \"git add\" to track)") : "");
-		else if (!s->show_untracked_files)
-			printf(_("nothing to commit%s\n"), advice_status_hints
-				? _(" (use -u to show untracked files)") : "");
-		else
-			printf(_("nothing to commit%s\n"), advice_status_hints
-				? _(" (working directory clean)") : "");
+		else if (s->workdir_dirty) {
+			if (advice_status_hints)
+				printf(_("no changes added to commit "
+					 "(use \"git add\" and/or \"git commit -a\")\n"));
+			else
+				printf(_("no changes added to commit\n"));
+		} else if (s->untracked.nr) {
+			if (advice_status_hints)
+				printf(_("nothing added to commit but untracked files "
+					 "present (use \"git add\" to track)\n"));
+			else
+				printf(_("nothing added to commit but untracked files present\n"))=
;
+		} else if (s->is_initial) {
+			if (advice_status_hints)
+				printf(_("nothing to commit (create/copy files "
+					 "and use \"git add\" to track)\n"));
+			else
+				printf(_("nothing to commit\n"));
+		} else if (!s->show_untracked_files) {
+			if (advice_status_hints)
+				printf(_("nothing to commit (use -u to show untracked files)\n"));
+			else
+				printf(_("nothing to commit\n"));
+		} else
+			printf(_("nothing to commit, working directory clean\n"));
 	}
 }
=20
--=20
1.7.12.rc2.18.g61b472e
