From: tboegi@web.de
Subject: [PATCH v3 3/7] convert.c: Remove input_crlf_action()
Date: Fri,  5 Feb 2016 17:13:23 +0100
Message-ID: <1454688803-20792-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 17:12:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRj07-0002Uv-Id
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 17:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbcBEQMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 11:12:23 -0500
Received: from mout.web.de ([212.227.17.12]:58968 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbcBEQMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 11:12:20 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Le4Po-1ZgKx50MpA-00pr3s; Fri, 05 Feb 2016 17:12:19
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:yS1VQxERn6QTKF6hGsOUlimrBGogebjhq6esD4yJ05yIhcP2b7W
 bieEe1NKAKlxvMiJicXEn/DbG9YKw3MR0Q7SYBKUobWPKRBDcXQP4fLWbB52D83zSU2l+R4
 sWe3Y0sArYRH533WVYrUMbpnvBuggNNZghsdSf3PpMO9SbnlrsQQ0N8nyO37jtbksbhnN8v
 JdFN3fFAc05Y1XYKrWU+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+gm28XEoH4E=:TuGktEYXpyMn0EZYzMsJJ8
 ZXYJnKEs4w/80T8mSau2VCw6YSSdCPPLM1e8EVcTjLteup2nVl4SrX7VyDQYaNzfVa96rstML
 pMXe2pGEHEcd5tjzNxL3tAhn/mtfBO73eZVbzXoW6LgYMxiTlVBF76NbEhE5ey77PIiEQA3ED
 Me7T+mKki1MGidRSioyLodQPhwwJG+CT5LJZJQmyJEieBf1MPInJdjStfI6GlrukMgPEbr5He
 ASFNh3XcZnrNPUjGyeFMCGbXD2rkONNWXGIzXI4BSkT145ncl0+Id6lg94B2sYmHx2bJZ3YhF
 cgLEKprDLoTOmJndGQY7sKN5s+ec/nwJGCc4oufg6Ed8sfzjkIfvVx/g9XOBTfWWB2+8RCahL
 bxmwJMRPD7cx9aLedru6FnWJVJ9cXqv5zZD10iXzs7ZjCYnKm51nncfiXCoW6/YC5M/FubW1C
 a+FWvEhWHWoA/6/kEDGwdQW7h+j3eUpPLW8+lIpv1YsUd7gCx1nbBrKuTbN4mCYur3YVR7DBx
 Tdrpz4TvIc/9XtmSPFlm4/WGYxn6fQ1siLDSqw03fURxxZNeAozsup9a7k1tGNOI6Go0XGu4p
 vy7MlO+H/yIVvwyPFjZh4Ad1598V7PCg/QWKlFBlcdDKVW+7L/O2mw5af615WwnAJPPSPh9sX
 s6wDuCZS9l5ibtbIub5E2Ou2nlKVI48UH3hm3ZXYSKZdVPyAl/+/Unin4DqJ2neO3ldNzKqSi
 PKIzc6/mou+6F4zKmJaF/Yad3Fij0O+FfLPSqYxTS3vjrd17kFa21t0mmBIJjZXOALIEENRm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285586>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Integrate the code of input_crlf_action() into convert_attrs(),
so that ca.crlf_action is always valid after calling convert_attrs().
Keep a copy of crlf_action in attr_action, this is needed for
get_convert_attr_ascii().

Remove eol_attr from struct conv_attrs, as it is now used temporally.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/convert.c b/convert.c
index a24c2a2..d0c8c66 100644
--- a/convert.c
+++ b/convert.c
@@ -746,21 +746,10 @@ static int git_path_check_ident(struct git_attr_c=
heck *check)
 	return !!ATTR_TRUE(value);
 }
=20
-static enum crlf_action input_crlf_action(enum crlf_action text_attr, =
enum eol eol_attr)
-{
-	if (text_attr =3D=3D CRLF_BINARY)
-		return CRLF_BINARY;
-	if (eol_attr =3D=3D EOL_LF)
-		return CRLF_INPUT;
-	if (eol_attr =3D=3D EOL_CRLF)
-		return CRLF_CRLF;
-	return text_attr;
-}
-
 struct conv_attrs {
 	struct convert_driver *drv;
-	enum crlf_action crlf_action;
-	enum eol eol_attr;
+	enum crlf_action attr_action; /* What attr says */
+	enum crlf_action crlf_action; /* When no attr is set, use core.autocr=
lf */
 	int ident;
 };
=20
@@ -782,16 +771,23 @@ static void convert_attrs(struct conv_attrs *ca, =
const char *path)
 	}
=20
 	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
-		ca->crlf_action =3D git_path_check_crlf( ccheck + 4);
+		enum eol eol_attr;
+		ca->crlf_action =3D git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action =3D=3D CRLF_GUESS)
 			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
+		ca->attr_action =3D ca->crlf_action;
 		ca->ident =3D git_path_check_ident(ccheck + 1);
 		ca->drv =3D git_path_check_convert(ccheck + 2);
-		ca->eol_attr =3D git_path_check_eol(ccheck + 3);
+		if (ca->crlf_action =3D=3D CRLF_BINARY)
+			return;
+		eol_attr =3D git_path_check_eol(ccheck + 3);
+		if (eol_attr =3D=3D EOL_LF)
+			ca->crlf_action =3D CRLF_INPUT;
+		else if (eol_attr =3D=3D EOL_CRLF)
+			ca->crlf_action =3D CRLF_CRLF;
 	} else {
 		ca->drv =3D NULL;
 		ca->crlf_action =3D CRLF_GUESS;
-		ca->eol_attr =3D EOL_UNSET;
 		ca->ident =3D 0;
 	}
 }
@@ -818,11 +814,9 @@ int would_convert_to_git_filter_fd(const char *pat=
h)
 const char *get_convert_attr_ascii(const char *path)
 {
 	struct conv_attrs ca;
-	enum crlf_action crlf_action;
=20
 	convert_attrs(&ca, path);
-	crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
-	switch (crlf_action) {
+	switch (ca.attr_action) {
 	case CRLF_GUESS:
 		return "";
 	case CRLF_BINARY:
@@ -861,7 +855,6 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	ca.crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
 	ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
 	if (ret && dst) {
 		src =3D dst->buf;
@@ -882,7 +875,6 @@ void convert_to_git_filter_fd(const char *path, int=
 fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
=20
-	ca.crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe)=
;
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -912,7 +904,6 @@ static int convert_to_working_tree_internal(const c=
har *path, const char *src,
 	 * is a smudge filter.  The filter might expect CRLFs.
 	 */
 	if (filter || !normalizing) {
-		ca.crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
 		ret |=3D crlf_to_worktree(path, src, len, dst, ca.crlf_action);
 		if (ret) {
 			src =3D dst->buf;
@@ -1381,7 +1372,7 @@ struct stream_filter *get_stream_filter(const cha=
r *path, const unsigned char *s
 	if (ca.ident)
 		filter =3D ident_filter(sha1);
=20
-	crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
+	crlf_action =3D ca.crlf_action;
=20
 	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_INPU=
T) ||
 	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E))
--=20
2.7.0.303.g2c4f448.dirty
