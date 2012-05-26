From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] Unindent excluded_from_list()
Date: Sat, 26 May 2012 19:31:12 +0700
Message-ID: <1338035474-4346-2-git-send-email-pclouds@gmail.com>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 14:35:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYGDW-00032k-1X
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 14:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab2EZMf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 08:35:27 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42457 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab2EZMf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 08:35:26 -0400
Received: by dady13 with SMTP id y13so2318016dad.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=klFPUvh1CBEx8fDS5BM2k4nRQyhJbeZ9/d6O5ekKfbU=;
        b=jHoUYYsxebHes0diLTMqUpJZgSZHmdNMbtimUug5zwxuqQyZVevy5UE2tWnz2ErGi0
         OMBCbVGCs8POc+keSWBvrSz/iR90OB0djGhEYE4U1hxet/ycpyebMvGo3QUbszhJBvnf
         3qrHkOq131fXqJnJ1TlBDckbw/BqI8zYsaQxFeKnoFuiP/gg9Rj3ssVMM8Pc9SrMTv9S
         frAO3FHahzlURXLQVzapOIxZC7tq1wmQvrHMeJTNc8ZOcsraVCzBR714FPQVKgHv8avA
         QwKgjaxwmfy8WSxfAPS4lvbQPeMevTJpK3B0Ib3ddBPRs3geY8tVeJbrafE8X+/KV3Xm
         O+uw==
Received: by 10.68.204.165 with SMTP id kz5mr7373420pbc.80.1338035726576;
        Sat, 26 May 2012 05:35:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.50.33])
        by mx.google.com with ESMTPS id x1sm12419678pbp.50.2012.05.26.05.35.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 05:35:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 26 May 2012 19:31:24 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198554>

Return early if el->nr =3D=3D 0. Unindent one more level for FNM_PATHNA=
ME
code block as this block is getting complex and may need more
indentation.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 96 +++++++++++++++++++++++++++++++++--------------------------=
--------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/dir.c b/dir.c
index b65d37c..8535cf2 100644
--- a/dir.c
+++ b/dir.c
@@ -508,56 +508,56 @@ int excluded_from_list(const char *pathname,
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
1.7.10.2.549.g9354186
