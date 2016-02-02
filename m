From: tboegi@web.de
Subject: [PATCH v1 3/6] convert.c: Remove input_crlf_action()
Date: Tue,  2 Feb 2016 17:53:12 +0100
Message-ID: <1454431992-2019-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 17:52:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQeBq-00033q-GW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 17:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633AbcBBQwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2016 11:52:23 -0500
Received: from mout.web.de ([212.227.15.4]:59942 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756628AbcBBQwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 11:52:19 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LuLxv-1a1znz42Ol-011iXe; Tue, 02 Feb 2016 17:52:17
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:1OttK0l8Y1BbPjGNMRbom1/ARGR9XcTlHOL3py2bmviTUVWTmLb
 PvVUnh7QM4mvc2InEuiXr2p4BVRpBEMpgQoc9QnylEm7ZI/9v6z6ZMfnlDVcBgkdgRnxSbd
 l5rCHSGdDWzjsDRTG4xsxbo9INwcXwYmyfTbxGPKozfrt3k6BngK/ZnH2y+o1pgIxtOCnvk
 dCp7KnTg48d4bxTyeWgdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GXizzuXrV2Y=:X0CYD4Wb1fmPD9H9LPU9xN
 us4tY2q5ad89WIIlytmqKgJmeEtPs5dcQvGReOg4/oIN6KX+3D6TG2gCGm70ZVY3bzp9yurwY
 RMA3DFOUFTfpMzMtgXY4X65dmoUpxlelkz2vAi4rwKZ6Ks6QvTfLf5iT81iOVEXvyMdqC4CZ5
 SXcf00R5xb2gn56FnWt8s5X6jYcWSNgCypsiFCEMN5lAmpcoyXy2UISCoJoei1D/zzRlrP75Q
 t9y3iIzMrju4YTHJnlSjaZMpfMTcioYOY3gKV7kbi8v6kPU6qNan38q1IbsiLBcozkyrvGbGA
 obt+ENht0DgY7D57Mm5YqzPuOoAX2H1RKlnxJ6GfYwtTChBhAV6hHm3AD5LONEc6xrpwubDFR
 dYc1xQvjluZmx1amGO7Iako9pSpAAW1x2POjzYwBDlhVD6I6/p9WsAs3zN6BCz35JtsR6KDxn
 we7G0Inyzg93RfU/RtwtcABAHdGdLZWnQuy1Pv5dzGd36NHs785Gi3aNSKWW4nP2RNtVSS8wb
 0IugLNuAeyLwfrfy6lDkdYCVswJYAgckGDGYS3iRqJd7/AW1KnsOn46zC84mQD8B7HPUvx7DD
 6PQU2y58EUwyXdwyN0/rkptBRKmmfx2EEc3L/euj4KCnURBOkt6nlgE7Qv1lL4oLG5cpVJ2oH
 TxZUK34xs52RcDc/H6/1jv+MUwvTrvquVXB4LYGokHl6ljlW7Yjz1btAAHW7rV6Le2kDqOC+g
 7FZsSE6fgZPb65ymOqRiD69G/hOijT2fkfAzhUOYcrFubB48e3iyfJfZubCHOEj2TfuqLlcc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285277>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Integrate the code of input_crlf_action() into convert_attrs(),
so that ca.crlf_action is aleays valid after calling convert_attrs().
Keep a copy of crlf_action in attr_action, this is needed for
get_convert_attr_ascii().

Remove eol_attr from struct conv_attrs, as it is now used temporally.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/convert.c b/convert.c
index a24c2a2..bca3d0c 100644
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
+		enum eol eol_attr;
 		ca->crlf_action =3D git_path_check_crlf( ccheck + 4);
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
