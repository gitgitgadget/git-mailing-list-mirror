From: tboegi@web.de
Subject: [PATCH v4 3/6] convert.c: remove input_crlf_action()
Date: Wed, 10 Feb 2016 17:24:38 +0100
Message-ID: <1455121478-16351-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 17:23:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTXY3-0000Yi-3o
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 17:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbcBJQXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2016 11:23:20 -0500
Received: from mout.web.de ([212.227.15.4]:62663 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbcBJQXS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 11:23:18 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LkPmd-1ZrSZj3X8l-00cOOu; Wed, 10 Feb 2016 17:23:16
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:krc8xeivirnZXNNJHVspIXhMLDuVIJR79v8Kadhx5R1TcCEcltO
 b1j3HTdksIZ/ivDZ5rH+xZSNOWRIfpqUqmxvt4VTBtCnpGzfCF+AwiTX265miK05A6Fq5k0
 GgXiNg3MJTG+y7a6bxEy9AnN5cLsgb9v6OxI5EXZae7QSGK/fPB5dNO0MuuRV+tr6G88qqU
 lCCegJ1kSt087E32dH05Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G96kD6WeUtY=:K3uzsq5ahxAeimclnsy8KI
 40ODb48uzMyAdvTIVpe1WIlo/98DH9hpRRp2Nv/hgFMazfc8m0MPykrFgW3y9CXPtnCjcEzXo
 WC/lelzGnu79w9y3I6zMsZw7KGaE+5SZiI9eH9H2cVuNvCfHyZ2AacTeNVuVA4jv8+Cqt2mJX
 4xoB3Lk9z7cSka0IswdU/aKTRXxP0re03fGcA2sgxTXrikTKxqp7wx9zBhvaNf8ADguwnG4M7
 izaZU/IZN1K1T2t5J95nGwur4WSMMD0i9zTvtbXlAV2Xdgdo79EzviV4xn3u9BXSiKgpHtxJh
 lNQLwqnlI1ITCnlS2m9XK4zUgewLJkilth856Xu/VTYzw1I5S0wm1wx5cAfzEjxNpBIKgbRNn
 MLw0Ku0EkdF0outoEqo76qhVi1z/RT+XK5KeB0bp/Xrddjg2K6Y0iPDAsGTV8BurSvdUfc0QZ
 +B2l1QhHEVmVQY2GZp/ABWL3KRzLuaIRbJwh/9z4MFbOTpE097T5svHLiVOhCsDdbqK2nuYKB
 eeLf2Z6gYV33vntY/6h5EiCbHBVFasbVKfOAwM3AY5XotH+v6xLVjKstaFN1m2YJysmgGcpN6
 w/WBTNlOdkurMq8CtDj7dyckXEj+wUCtBcqi9cCR5LQbLjCDvhuAK7El2kZscnfog7/nzuWHf
 MaRAe7IJsOLgo6RoIVDuK309A+kMHLCCdJySn5TQH8ke2Y1RSeLY/Ia0j0HYmvTTnCCezyyF5
 UW6czjegff2IyRbPidfSlYDcUF8uwrSXACD9PUeTY2RIO/RBsmUkNPaguDRMbELqH8vy9GaH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285911>

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
