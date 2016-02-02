From: tboegi@web.de
Subject: [PATCH v1 4/6] convert.c: Use text_eol_is_crlf()
Date: Tue,  2 Feb 2016 17:53:13 +0100
Message-ID: <1454431993-2058-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 17:52:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQeBw-0003F9-Jz
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 17:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbcBBQwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2016 11:52:22 -0500
Received: from mout.web.de ([212.227.15.14]:50195 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756621AbcBBQwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 11:52:19 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0M0yjP-1aCx5h1f4x-00v3ir; Tue, 02 Feb 2016 17:52:18
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:rJPlAiHwNWd3q+HOKJa8Gv/6LjxJ4lorEcsRiw1WLIhAJ038kPW
 zY5i9wzEbIuSA+L2jSrEFRFNJObAbmuiH9SRDl8gWxy0nrczDRgw7Tf0242rUTGg9WfwOA7
 xgHozbQadkf3og9nNB11J174Cqh89C9lmPYCZCv0ZZ0IQdOIvQsLdQHb3Jf3xh8RFIi4vUg
 w8bcvvFQGya1O7TndmxKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1MrWGTQa0uY=:aF9fMcnekMeKTqQSF6ZM8j
 eXDfmuNwh2VUuzLDqx6RCr6nTftYvnyAXqPipoGNb6IhMLXmyjB6sDLJePGT26MVqO1X5tDrO
 gr7+EhwH9g9JXpB8potr9ab4dlxO4rDbqog0ESQbWGMXtKiFtn+5Njoqsx7lq+pdsWIJfD4G+
 SAJtuyaG0GmsQdiT5cZTBhNfFIJHKvdu1NaNSJPyTji+dWtXLhhxDl44Ryx3SM32tyRl7CqL4
 einu3QL/BphTLha0HUJMwYrFbpznCbDDdMAwUwUDskxK6WvStJxs6nXb9iRR/T3OSZNhmkn5I
 1GutxM7243FQcu9BITLM/KDo0GtI1scJ2vNB9JnoLUphix4+mNpnsdoe4JSBBQMcbSlzNCEGY
 PB3+4ZpesQAv/ccOyjSWgjTRSq2KVRkcwcQcALrWYsOYCyekwfxTZWlxT+Lo8Qv3NFe//TuZZ
 NmH8XPtc1pl7z51epsFP5XDudqyyWNOJPQumU2OKSZR3zzWeFuplCGA0dJea6BM5L83G2J7sO
 uvFH0P96+ABJ1NkAkkgyBE8Mm/a0lG3KIafLtNOhottucpADrGHg+ewjDFhohvmSFWlUGmUjT
 Vf5QiVlqjE5ftR4+IngXLFDmK26cbYM4GKLwkwVQeflANSUF3jcNTX9Da0eUkP+l6gvMWQEyR
 BHeQP/CKxENhQ6JNW2lCnR37y9VRbDwJ5mkQLEZvqTRHV4H5K5v6Cg9qwbDJqyqBefWt8H47G
 PzN6gy9lByuKbdKjW9szOzvv6od23z4LrPkoob3sTHXiDJPVtgJHx5Rq6HMAvFQtVoz1C5v5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285279>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Add a helper function to find out, which line endings
text files should get at checkout, depending on
core.autocrlf and core.eol

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/convert.c b/convert.c
index bca3d0c..a5701a1 100644
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
