From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] i18n: leave \n out of translated diffstat
Date: Thu, 26 Jul 2012 19:52:36 +0700
Message-ID: <1343307156-16528-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 14:53:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuNZT-0000hn-MV
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 14:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab2GZMx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jul 2012 08:53:28 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56631 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab2GZMx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 08:53:27 -0400
Received: by gglu4 with SMTP id u4so1881415ggl.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=8CK48abz7gOAMu+sd27IlBDHYn62aJoQJK+GZ0hPZQA=;
        b=ecan8zjZUXH4gMQ3T5GIAFnvYbbq4iuB/bAxc8i7kY24sWJsQAN62HoJtnVYy9EET+
         XFbbTOuTBDYYUqzZ4nQf36E5DTi5c5dUL6bH4Ad5vt1zdw+xbg+QgjEl0WpVEozEYknT
         R8ElQHXVc+u6/JNPK1VDqJQ3ZGQ2QVZA2SYAJNZOy+rnWUVAXDRKGJe2QVTymrkwALTB
         BzJCDP6eySkd5WC9hOj4AwIIg+Al/3p68mc5k5nGtbWx/30fKMuwmWmRU9pVyBlcJLOQ
         tFaW4Ha0DAyM2bpP6vSwO3x52puF+ArQ1EiVi4sJ/wSVMBfDdhpOAKRTENldI8OWPngv
         e+pg==
Received: by 10.66.75.228 with SMTP id f4mr20402690paw.52.1343307206821;
        Thu, 26 Jul 2012 05:53:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.32.150])
        by mx.google.com with ESMTPS id pt2sm16501770pbb.58.2012.07.26.05.53.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 05:53:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Jul 2012 19:52:38 +0700
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202260>

GETTEXT_POISON scrapes everything in translated strings, including \n.
t4205.12 however needs this \n in matching the end result. Keep this
\n out of translation to make t4205.12 happy.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I haven't followed recent i18n patches closely. Jiang may have
 already fixed this in one of his patches. Anyway just in case
 everybody does miss this..

 Should I resend parseopt i18n marking series now or wait until rc
 period is over?

 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 62cbe14..95706a5 100644
--- a/diff.c
+++ b/diff.c
@@ -1397,7 +1397,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
=20
 	if (!files) {
 		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
-		return fputs(_(" 0 files changed\n"), fp);
+		return fprintf(fp, "%s\n", _(" 0 files changed"));
 	}
=20
 	strbuf_addf(&sb,
--=20
1.7.8
