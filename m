From: tboegi@web.de
Subject: [PATCH v4 4/6] convert.c: use text_eol_is_crlf()
Date: Wed, 10 Feb 2016 17:24:40 +0100
Message-ID: <1455121480-16390-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 17:23:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTXYF-0000rS-19
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 17:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbcBJQXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2016 11:23:31 -0500
Received: from mout.web.de ([212.227.15.3]:54813 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbcBJQXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 11:23:30 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MQ6KJ-1aOKTl1hpL-005Dvr; Wed, 10 Feb 2016 17:23:18
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:wpavO4di5SoagrFPqHYipKlwq5QptIE6SC6mWhEfCdIOxs9CdQa
 4SM2U+GlDkK5Lcj9CqmCI9m3UbNwy1eEGmnAL8XnbAgxovz6na6ecopH/uZ0UIGx958qmjG
 +H/y8Eskl8ck9RDrRRjsyLyhadmdf0T/69xXJbtvFsU1ihTKN0JqNWDUR/vu9AEaSD7oy08
 nmECvJ5wccsKFFyN2Oi4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dOwHnr5Us0o=:5wNba32i7k1oktM9DkrlqU
 5/X5r9nXRNMfB6Eu4cpWvXZxwF4YBXrgVsP89u18lFAtJ6VhhV1p4QGA7defs1o4y2b7T71BC
 9K4PrCMLAQ3b06RWhFzK/plXiECAm2risAKmj7yAdMISoDP33JhuN4OrYoWcQdUjLyqrxkosZ
 hJMv2v4ujdaotthu/EkgNtX8pZNCfln/qH8n7pOnwHjX0u7bKAU7MmnA1LkK2XlHMopyYfLRn
 DV869ID1k+mIHALhuX7YtOsLyzgiRyNSbveHK886+Pyi0uLhpTcnVA9vKYTSTApF1d3DTVpfC
 Y4SUW6gpYkZJd4vIQfWHhxCYKsM0u5pJK9vextG7q4RkS086JPMh05P4kd/ESgaWaIb6gfoZr
 2/UPKrGD/JzFtQTOos+6MG1DlYYxUDVMCfKR6JZf05QwTrNWU17VSld8wnQ8CK6UA5U4ytYwn
 hEjDUkgODFxPuyMcfrdztDM0nvIAknuIRkA+v1h3ElsvXrKJsMwOZoF6SmxHpBIc1yTPtraa7
 OmNqBB9071Nex4jq4jzGt6zsJzenoHjm/UKyeE/VzS4xQFvb66wBUJrvn4VcpfMq6p9oCKPbJ
 qs66waBPvemWinax+LhxIypdltgc7bRNHorkAFqwTd9pKt9VGL7N3X+eE7r1z8kFKGSk91MKk
 Sd+vC1+Vw6aY1mm4VcPf44Psv9D8xqmr6A0dZODTU7Kcwgnt9fuJt2ioNcLVhfjxp4NvgROOw
 yxz4qqCfcCt1FslbITdwN7yRUWM5Dxe0Hh3TQUiWuMWsCJIYRLKqypb8Xy1BfV1/uPNULdoN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285914>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Add a helper function to find out, which line endings text files
should get at checkout, depending on core.autocrlf and core.eol
configuration variables.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index d0c8c66..557e574 100644
--- a/convert.c
+++ b/convert.c
@@ -149,6 +149,19 @@ const char *get_wt_convert_stats_ascii(const char =
*path)
 	return ret;
 }
=20
+static int text_eol_is_crlf(void)
+{
+	if (auto_crlf =3D=3D AUTO_CRLF_TRUE)
+		return 1;
+	else if (auto_crlf =3D=3D AUTO_CRLF_INPUT)
+		return 0;
+	if (core_eol =3D=3D EOL_CRLF)
+		return 1;
+	if (core_eol =3D=3D EOL_UNSET && EOL_NATIVE =3D=3D EOL_CRLF)
+		return 1;
+	return 0;
+}
+
 static enum eol output_eol(enum crlf_action crlf_action)
 {
 	switch (crlf_action) {
@@ -164,12 +177,7 @@ static enum eol output_eol(enum crlf_action crlf_a=
ction)
 		/* fall through */
 	case CRLF_TEXT:
 	case CRLF_AUTO:
-		if (auto_crlf =3D=3D AUTO_CRLF_TRUE)
-			return EOL_CRLF;
-		else if (auto_crlf =3D=3D AUTO_CRLF_INPUT)
-			return EOL_LF;
-		else if (core_eol =3D=3D EOL_UNSET)
-			return EOL_NATIVE;
+		return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
 	}
 	return core_eol;
 }
--=20
2.7.0.303.g2c4f448.dirty
