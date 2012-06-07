From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] Unindent excluded_from_list()
Date: Thu,  7 Jun 2012 14:53:34 +0700
Message-ID: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 09:53:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScXXb-0005bd-5z
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 09:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260Ab2FGHxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 03:53:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36260 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988Ab2FGHxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 03:53:53 -0400
Received: by pbbrp8 with SMTP id rp8so706664pbb.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=mHraU0u8TXliugZnZdP8CS1onr49hF4uGNviGGnv5EE=;
        b=dlVwlEEuK9C742H+TMkLGlviCAqB+mPTeIn0ltTvGDzelLlnBpw+U80KbS2gisdkej
         JltzgZWuAFVxtA59BrH1DX1nEPxBfesC85QpM5tGwitrCU5iVnCfatdNZblbBJFqfn2p
         P7bPRqLgKjMnGSBYE5y08IqazmLQAuondow85yh4xr4xCni5Oe2ILNhdsU06vxeNBApL
         bewELtCxp3kdym23CA1ctyqpzXNPvxidTSVcA5WDj25FZWccdH34CYcXuVOuOFv/TBG0
         aTvlw6dx4FUjI++grhLfYODwEErXIoAXaJ99X9n3Cn0xw6el0yCHNquRCNmlv+t7vZeb
         pyEw==
Received: by 10.68.195.97 with SMTP id id1mr6371315pbc.91.1339055632735;
        Thu, 07 Jun 2012 00:53:52 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ql3sm3246471pbc.72.2012.06.07.00.53.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 00:53:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Jun 2012 14:53:38 +0700
X-Mailer: git-send-email 1.7.11.rc1.185.g281ad67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199376>

Return early if el->nr =3D=3D 0. Unindent one more level for FNM_PATHNA=
ME
code block as this block is getting complex and may need more
indentation.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 nd/exclude-workaround-top-heavy updates. no changes on this patch.

 dir.c | 96 +++++++++++++++++++++++++++++++++--------------------------=
--------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/dir.c b/dir.c
index ed1510f..e756de1 100644
--- a/dir.c
+++ b/dir.c
@@ -498,56 +498,56 @@ int excluded_from_list(const char *pathname,
 {
 	int i;
=20
-	if (el->nr) {
-		for (i =3D el->nr - 1; 0 <=3D i; i--) {
-			struct exclude *x =3D el->excludes[i];
-			const char *exclude =3D x->pattern;
-			int to_exclude =3D x->to_exclude;
-
-			if (x->flags & EXC_FLAG_MUSTBEDIR) {
-				if (*dtype =3D=3D DT_UNKNOWN)
-					*dtype =3D get_dtype(NULL, pathname, pathlen);
-				if (*dtype !=3D DT_DIR)
-					continue;
-			}
+	if (!el->nr)
+		return -1;	/* undefined */
+
+	for (i =3D el->nr - 1; 0 <=3D i; i--) {
+		struct exclude *x =3D el->excludes[i];
+		const char *exclude =3D x->pattern;
+		int to_exclude =3D x->to_exclude;
+
+		if (x->flags & EXC_FLAG_MUSTBEDIR) {
+			if (*dtype =3D=3D DT_UNKNOWN)
+				*dtype =3D get_dtype(NULL, pathname, pathlen);
+			if (*dtype !=3D DT_DIR)
+				continue;
+		}
=20
-			if (x->flags & EXC_FLAG_NODIR) {
-				/* match basename */
-				if (x->flags & EXC_FLAG_NOWILDCARD) {
-					if (!strcmp_icase(exclude, basename))
-						return to_exclude;
-				} else if (x->flags & EXC_FLAG_ENDSWITH) {
-					if (x->patternlen - 1 <=3D pathlen &&
-					    !strcmp_icase(exclude + 1, pathname + pathlen - x->patternlen=
 + 1))
-						return to_exclude;
-				} else {
-					if (fnmatch_icase(exclude, basename, 0) =3D=3D 0)
-						return to_exclude;
-				}
-			}
-			else {
-				/* match with FNM_PATHNAME:
-				 * exclude has base (baselen long) implicitly
-				 * in front of it.
-				 */
-				int baselen =3D x->baselen;
-				if (*exclude =3D=3D '/')
-					exclude++;
-
-				if (pathlen < baselen ||
-				    (baselen && pathname[baselen-1] !=3D '/') ||
-				    strncmp_icase(pathname, x->base, baselen))
-				    continue;
-
-				if (x->flags & EXC_FLAG_NOWILDCARD) {
-					if (!strcmp_icase(exclude, pathname + baselen))
-						return to_exclude;
-				} else {
-					if (fnmatch_icase(exclude, pathname+baselen,
-						    FNM_PATHNAME) =3D=3D 0)
-					    return to_exclude;
-				}
+		if (x->flags & EXC_FLAG_NODIR) {
+			/* match basename */
+			if (x->flags & EXC_FLAG_NOWILDCARD) {
+				if (!strcmp_icase(exclude, basename))
+					return to_exclude;
+			} else if (x->flags & EXC_FLAG_ENDSWITH) {
+				if (x->patternlen - 1 <=3D pathlen &&
+				    !strcmp_icase(exclude + 1, pathname + pathlen - x->patternlen =
+ 1))
+					return to_exclude;
+			} else {
+				if (fnmatch_icase(exclude, basename, 0) =3D=3D 0)
+					return to_exclude;
 			}
+			continue;
+		}
+
+
+		/* match with FNM_PATHNAME:
+		 * exclude has base (baselen long) implicitly in front of it.
+		 */
+		if (*exclude =3D=3D '/')
+			exclude++;
+
+		if (pathlen < x->baselen ||
+		    (x->baselen && pathname[x->baselen-1] !=3D '/') ||
+		    strncmp_icase(pathname, x->base, x->baselen))
+			continue;
+
+		if (x->flags & EXC_FLAG_NOWILDCARD) {
+			if (!strcmp_icase(exclude, pathname + x->baselen))
+				return to_exclude;
+		} else {
+			if (fnmatch_icase(exclude, pathname+x->baselen,
+					  FNM_PATHNAME) =3D=3D 0)
+				return to_exclude;
 		}
 	}
 	return -1; /* undecided */
--=20
1.7.11.rc1.185.g281ad67
