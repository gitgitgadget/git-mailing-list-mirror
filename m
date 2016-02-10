From: tboegi@web.de
Subject: [PATCH v4 6/6] convert.c: simplify text_stat
Date: Wed, 10 Feb 2016 17:24:43 +0100
Message-ID: <1455121483-16470-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 17:23:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTXY9-0000im-DS
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 17:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbcBJQX0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2016 11:23:26 -0500
Received: from mout.web.de ([212.227.15.3]:60584 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbcBJQXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 11:23:23 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M0f1C-1aAN0B2OUw-00uqzd; Wed, 10 Feb 2016 17:23:21
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:unq2UA2aCWOywwT5swt0y24Pq1fWSmPTvxiF3m7fBiAsjItGq/Q
 bcOwdHPQqF1L7bLCSQuLZyGG1AXbxKrNE66/sNJ9G5u4ggMTvhRUpKcMGcrkp/iurTRgdig
 WOrt4fZG0R9Fdvnt/JZ+pf3Wdu9kKfplVFQrKLWbKHItvEH3BjL1kQym2yfPUOMu7WLndJu
 nDVXhykJuXq+yaEc9rtqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vihErS0XFvI=:D6qCLeoji4pPJn7eYi/pa0
 mnHs2XjjgylB89LlG074QAn3tbb5WBgx7/ks4FAtJq6UQM4gwIJKgRsY5sG5Rv2Apl9dgEmrd
 kWZpth64JXHewRXDuquMhdP5+oG4PH46ra0iBReqWVlGGhGd4rrjr7xqJx2DPSCAEZBN6j8eD
 1HPNNEeBcjObGrHc8Xym/819yyDYLeoJCk7V9ujgy54vLTR/v0eYHJ/T+6vkzhyNlOKl/sw4M
 hSFvo0zKUZHtA2CdR3nGFaKvjwuEuqdPauFOwm7Ts6P2TfFPM+Qumh26AAaNjWDIAUwTn4/aS
 VWcBAVOi0pbGAd5wA+PeXa7T6IetrEbSDEXsguQNwhhYCnV6fNL2G+bUUmH/yvOj/m7vOkJuQ
 SsBM2V+pyRFAW2smK1rnzg/7OlNuJAw/23SqRaggKj1ZyvCS92WzV+j9giXjBhWwYiUmFugG6
 BMhZ9yzATy24zMdh+frHnBzrckC9mjf+GThDAj8k+m9sLUdYs4MxSVGQftxlruYCby7ie5MJv
 i9GRmujcncoUEK+J3dymCF9K/r0owJ4wOEOFoKlR9TIfGzVLi/c3QmA3KOp9iU9/TQaPQZ1aW
 Vu0ue1CjO5vFFeNepXE919mY+1e0FXC2Q5Y2eJIf62wKCnLhLJJzZd2vSUF9Q58ykg2Sq3Inq
 WATRUcxMWezlFn2/9lwRppU7O5RwO/b79nJOJe3R/tmTjHIKx7FDlDIIYHtd7/qGWqCtaTLgf
 AqHYhHNNahPpcXrnbK1XJ2o5egryAFycMfPrN8M9kU1QjeS6V8qVFJxN3wCHyeoHdSKXqgc0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285912>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Simplify the statistics:
lonecr counts the CR which is not followed by a LF,
lonelf counts the LF which is not preceded by a CR,
crlf counts CRLF combinations.
This simplifies the evaluation of the statistics.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/convert.c b/convert.c
index e4e2877..18af685 100644
--- a/convert.c
+++ b/convert.c
@@ -31,7 +31,7 @@ enum crlf_action {
=20
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
-	unsigned nul, cr, lf, crlf;
+	unsigned nul, lonecr, lonelf, crlf;
=20
 	/* These are just approximations! */
 	unsigned printable, nonprintable;
@@ -46,13 +46,15 @@ static void gather_stats(const char *buf, unsigned =
long size, struct text_stat *
 	for (i =3D 0; i < size; i++) {
 		unsigned char c =3D buf[i];
 		if (c =3D=3D '\r') {
-			stats->cr++;
-			if (i+1 < size && buf[i+1] =3D=3D '\n')
+			if (i+1 < size && buf[i+1] =3D=3D '\n') {
 				stats->crlf++;
+				i++;
+			} else
+				stats->lonecr++;
 			continue;
 		}
 		if (c =3D=3D '\n') {
-			stats->lf++;
+			stats->lonelf++;
 			continue;
 		}
 		if (c =3D=3D 127)
@@ -86,7 +88,7 @@ static void gather_stats(const char *buf, unsigned lo=
ng size, struct text_stat *
  */
 static int convert_is_binary(unsigned long size, const struct text_sta=
t *stats)
 {
-	if (stats->cr !=3D stats->crlf)
+	if (stats->lonecr)
 		return 1;
 	if (stats->nul)
 		return 1;
@@ -98,19 +100,18 @@ static int convert_is_binary(unsigned long size, c=
onst struct text_stat *stats)
 static unsigned int gather_convert_stats(const char *data, unsigned lo=
ng size)
 {
 	struct text_stat stats;
+	int ret =3D 0;
 	if (!data || !size)
 		return 0;
 	gather_stats(data, size, &stats);
 	if (convert_is_binary(size, &stats))
-		return CONVERT_STAT_BITS_BIN;
-	else if (stats.crlf && stats.crlf =3D=3D stats.lf)
-		return CONVERT_STAT_BITS_TXT_CRLF;
-	else if (stats.crlf && stats.lf)
-		return CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_TXT_LF;
-	else if (stats.lf)
-		return CONVERT_STAT_BITS_TXT_LF;
-	else
-		return 0;
+		ret |=3D CONVERT_STAT_BITS_BIN;
+	if (stats.crlf)
+		ret |=3D CONVERT_STAT_BITS_TXT_CRLF;
+	if (stats.lonelf)
+		ret |=3D  CONVERT_STAT_BITS_TXT_LF;
+
+	return ret;
 }
=20
 static const char *gather_convert_stats_ascii(const char *data, unsign=
ed long size)
@@ -207,7 +208,7 @@ static void check_safe_crlf(const char *path, enum =
crlf_action crlf_action,
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
 		 */
-		if (stats->lf !=3D stats->crlf) {
+		if (stats->lonelf) {
 			if (checksafe =3D=3D SAFE_CRLF_WARN)
 				warning("LF will be replaced by CRLF in %s.\nThe file will have it=
s original line endings in your working directory.", path);
 			else /* i.e. SAFE_CRLF_FAIL */
@@ -266,8 +267,8 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
=20
 	check_safe_crlf(path, crlf_action, &stats, checksafe);
=20
-	/* Optimization: No CR? Nothing to convert, regardless. */
-	if (!stats.cr)
+	/* Optimization: No CRLF? Nothing to convert, regardless. */
+	if (!stats.crlf)
 		return 0;
=20
 	/*
@@ -314,19 +315,15 @@ static int crlf_to_worktree(const char *path, con=
st char *src, size_t len,
=20
 	gather_stats(src, len, &stats);
=20
-	/* No LF? Nothing to convert, regardless. */
-	if (!stats.lf)
-		return 0;
-
-	/* Was it already in CRLF format? */
-	if (stats.lf =3D=3D stats.crlf)
+	/* No "naked" LF? Nothing to convert, regardless. */
+	if (!stats.lonelf)
 		return 0;
=20
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
 			/* If we have any CR or CRLF line endings, we do not touch it */
 			/* This is the new safer autocrlf-handling */
-			if (stats.cr > 0 || stats.crlf > 0)
+			if (stats.lonecr || stats.crlf )
 				return 0;
 		}
=20
@@ -338,7 +335,7 @@ static int crlf_to_worktree(const char *path, const=
 char *src, size_t len,
 	if (src =3D=3D buf->buf)
 		to_free =3D strbuf_detach(buf, NULL);
=20
-	strbuf_grow(buf, len + stats.lf - stats.crlf);
+	strbuf_grow(buf, len + stats.lonelf);
 	for (;;) {
 		const char *nl =3D memchr(src, '\n', len);
 		if (!nl)
--=20
2.7.0.303.g2c4f448.dirty
