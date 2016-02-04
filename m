From: tboegi@web.de
Subject: [PATCH v2 3/7] convert.c: Remove input_crlf_action()
Date: Thu,  4 Feb 2016 18:49:53 +0100
Message-ID: <1454608193-5378-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 18:49:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRO1n-0001Qh-C6
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 18:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbcBDRs5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 12:48:57 -0500
Received: from mout.web.de ([212.227.17.12]:63539 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758015AbcBDRsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 12:48:53 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MQedF-1adIgI2Snl-00U4H6; Thu, 04 Feb 2016 18:48:51
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:tPb0b+QVPURHGFLKBxtpJqPK63eXt8aLsEV531hqx+RpqciNuOk
 Uyp6cBnQd/4jA0zLcrIajSnTInHiSjz1vxCvpAxquFK44jRYC/xfCmpH1IrW7kmlo9WkeGp
 vYb1wXZ7MtDtTGFgz/n6wN8UEZnSMY8DbxmUxrSGnnQQ8ML6RoO9tRllavDiIrA1XNWevzy
 a/Mqm8gru8365ZmSjesqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0dY3n9arXic=:H++1c3Zr9nFgVxVOJ/OHZp
 pmG0rCqmpRHPFgOL/2EQH7BfE2TuBBB8tKHwv0kBurGYyQZneopbVJuvn8RyElUy6glkWc9Yp
 36Szc8l4pePZqXArbSYv4WCci82cPi59MIEdgshSR/pIlHnkldAJjMifsxJq6aQA7/Iswq3JO
 m7xNbuB4ihfwjV9rwai/VsynUw6+j4Ew2cULn+IM5AIZbB0h1iFnLsZy3w0qa2f0dC/+BgpFy
 +acMJpjiHVWZuoX3ve066tmpHMpCu7o//gSEvv6ZEwhMc5SfjFsrDXRBitMYduzKMdLENLWpb
 s51eEAwCSNi2vr/66pk6xlcg+U2UgLZXgwUYZSUdB9MpJrQHdDJ9jv669wZ/leVIvKRsf/A/M
 SnvF5LTrde2MbydIcIEFoIPnY4us6FDrn13go7Owh4sxFnKCKqvW8fjRBgXn2dl2OEPxGa8EY
 02bENuujRwQUx90km+uoLSZRUMvouW7TPggP9KfDxQrfvitAq2Qq+Gk/OzSyf97hbTEOizOfr
 eaFiuGaH6tXwReVpoCaQex0y7NR7enpHaZ664+7zoKF6/7gETEJv1bCw3SPtUb5SuNbCqbRZq
 VseE6s37lgJV5QWR4hf+GpRAQKS4GiPr+x/6InWR83VNuJC7bJw1cnzx/R64kCG5vhkHGRvZR
 WarYo4yLXvii1RXLhDC+NL1EnppA8BX3hZKC6HIlHDiWrzP7pSxm6Zcg9CQBtGlKcMYZzR8pV
 U0B2i3wdp2l0VgssTVlwQORrGVgnZoxURLM4TAI7VdGj5IwuAPdqb8bI2dhXm90xhLYMkiTU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285473>

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
