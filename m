From: tboegi@web.de
Subject: [PATCH v2 4/7] convert.c: Use text_eol_is_crlf()
Date: Thu,  4 Feb 2016 18:49:54 +0100
Message-ID: <1454608194-5417-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 18:49:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRO1g-0001FL-ON
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 18:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041AbcBDRs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 12:48:58 -0500
Received: from mout.web.de ([212.227.17.12]:52651 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758005AbcBDRsz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 12:48:55 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M8Qtq-1a4mjn30za-00w1Hp; Thu, 04 Feb 2016 18:48:53
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:YO7yrlTD+vGFMtOOnCSrd/AYz6bqjMcekDYKrP68hcA9J6mg96O
 kltHuMRV2eju8Gdyyk6cIDzNlKIjtmCfEfpovpqJ1+EYL0qB05YupS4N5pVTxNWeA5unaCv
 ezb3HccS43H7e724uL8S9DtZfc+JN+UT1B5eiDZg/CefTfBMJ8C0wClEsFgffr5Ksn5WN9E
 F600yod/OpdBZKQaK8N3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uule235FlKY=:LL4jOa38T/Q7QpWVwBf4tn
 PXgynWdtXh3zU5SqgzXEEtly5bzb1h1+6jBuTj29kel9cnSFkdPzZozo+OAdrwxuAIMehv/iW
 fKOvCSS5YO8YSMUf9J4sIVNlBY43/7nhzRlAcVZF/di/iO6U6HqXXvF1sIfsUP/M1rinezDiw
 F215DUqGOJMyOBHypdv1IxYwRNyKson+eAqc5BrNiFwFYdZ+S2Qi+92edPYsYas8ZPARMvWEE
 6+tXIEsG3ys03yJIAVB0c3uTLtAG9xhz5VejoXtEXvwK4lBffJssfepmjKejFxaaSnYYw3z5W
 gOTaWCWcjWcmEa+c3Ax2pYPrnU74ZDELxERDLAj3LrCE5DSkz+rfmqnDBNtx4nEK+86OrEy7J
 UuToxDj3uHm75J6+VWDdTDUJ/TMKt0aWpNkdK5XhX2iwSPFw+OFfRowE5Zxjb3ZGJd0Mt9r2K
 nXgKWgqFwpOoeYskkvvFgb2HSVuWGdd9k0usFY6mZKYypdAnf3eLiB87mHqUyjkQamcO0qTAV
 axLjCuesnJUpSsSYUty0l7vb2wEXhETZc/of9m1R9fKVqYMU/tGflqtwe1w8oreFymIIvnpNs
 S8+eLIUKiOQeTwYmJITy0mUOiT26dwIGA6aL1XbtZDmAYtANoKKuz48MhM6zyQxGRnpN9oBBv
 5cErMeHuIL1RzxMcspKS8CCpSPVcG+O2BMpzTRThhfZT5Kvm0XgDl8TlmWKPod9KRly5CaeJF
 gGoS8UmtgAFpuk3li9bjv36U+fW023SJQh8LSxUYXxYA2nlidyZFH45+UYLKczE0TuEc01em 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285474>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Add a helper function to find out, which line endings
text files should get at checkout, depending on
core.autocrlf and core.eol

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/convert.c b/convert.c
index d0c8c66..9ffd043 100644
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
@@ -1378,8 +1386,9 @@ struct stream_filter *get_stream_filter(const cha=
r *path, const unsigned char *s
 	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E))
 		filter =3D cascade_filter(filter, &null_filter_singleton);
=20
-	else if (output_eol(crlf_action) =3D=3D EOL_CRLF &&
-		 !(crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS))
+	else if ((crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUE=
SS))
+		;
+	else if (output_eol(crlf_action) =3D=3D EOL_CRLF)
 		filter =3D cascade_filter(filter, lf_to_crlf_filter());
=20
 	return filter;
--=20
2.7.0.303.g2c4f448.dirty
