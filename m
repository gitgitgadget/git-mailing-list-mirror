From: tboegi@web.de
Subject: [PATCH v2 3/3] t6038; use crlf on all platforms
Date: Sun, 15 May 2016 15:02:30 +0200
Message-ID: <1463317350-2749-1-git-send-email-tboegi@web.de>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 14:57:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1vbt-00053D-9P
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 14:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbcEOM5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 08:57:25 -0400
Received: from mout.web.de ([212.227.15.14]:65233 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227AbcEOM5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 08:57:24 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MJkvs-1b324U1b1w-0017cP; Sun, 15 May 2016 14:57:22
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <20160513134953.GE2345@dinwoodie.org>
X-Provags-ID: V03:K0:FlAI8Ai58QHK08mLHmulzq3fOFllLFrKSr6XQul9xhPWwG4II3m
 WObpVumIDBQktKcK2DdNGaRI7jRi1GGrnxyeQMY8VIcDJwhIP8OxJFfTZahWElNft6WpF+N
 seFtQ9myc5f4JatvFRO1edOOiuwOoN68GqBtk51y4Z5XA6Nn7RsrqfzVlZtFmQNDJXxOHHj
 Z8vn8oqljNHi6J2aY0EEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BnUJQLRs0xk=:H+icYdPx5mDATNa4g9St2G
 X5+9guj9oanVlijI6SqCKtic/eoabHNGy/mYLX/yDLiGyH9s0End+3mWBUqPlsXsVDtvUNLDV
 vl3rRPBwU8Jz3g6S9lomC9DwJSTLSf9TgRv8Gn0guD+QXFS2LRT3KChpPp5Kbmp8i8xAikRy5
 VBnJ3rRhRKXHZi6Jmu5iDvA/7vGPqD3UcXOBf/+vl42/epmFM5oorHuuu5l5PQcb+7b186IcP
 GtwvxXaZx6I5MqdJ+UZ5XMJ6tBck0GhbRb65pnL4iYe6copJSsvfIYoXxqMLX7eCRAYieFfgw
 eKa2mZXuLYli6vj4w/2bRe9czf84PvF85dt4hvGVrOJ6f2eL9r39gyNODEbd2LedK44gbGm2O
 xNxeJnCZs5DovAVgDtr+MgnQw1Ha/0bjny7AqdQfslMieahTsJUvOIE9AJfz/kVNaZP4sQwYk
 /g1Jqlppa6F8VkqBQMzQVaDhEArX05079zmoJ6EKMNepjs4evchEFjVLLa+z8XZSI2KbsVfhm
 t8++TMMyiJI0Jpt8VrYTBkXuY6AM3aXZuZNN971vpeyrRcTbD1qJp3nP+X9cSpHCEbNXnpWYZ
 BTBzNekvgmD46zUVpjGBMQ0cBp3nvDJ3hM/ZB4qianDUOmcoUvEwsmVFnYz9JeLwF9eZOWWDl
 DJmhL95dr2FbklxPyKPT/55aeA2JyqqyaNgiX2TxtTZwz3LP7u5oPuvKV691YPwy+vS11uEAN
 jGIS5+qjh78hwe++w/+RpAk8T68LnJvgW4LmT1Q0/+CwK6xaOi24uE3RpyL35zzgfXhJsx// 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294670>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

t6038 uses different code, dependig if NATIVE_CRLF is set ot not.
When the native line endings are LF, merge.renormalize is not tested ve=
ry well.
Change the test to always use CRLF by setting core.eol=3Dcrlf.
---
 t/t6038-merge-text-auto.sh | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 85c10b0..4dc8c1a 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -18,6 +18,7 @@ test_have_prereq SED_STRIPS_CR && SED_OPTIONS=3D-b
=20
 test_expect_success setup '
 	git config core.autocrlf false &&
+	git config core.eol crlf &&
=20
 	echo first line | append_cr >file &&
 	echo first line >control_file &&
@@ -72,10 +73,8 @@ test_expect_success 'Merge after setting text=3Dauto=
' '
 	same line
 	EOF
=20
-	if test_have_prereq NATIVE_CRLF; then
-		append_cr <expected >expected.temp &&
-		mv expected.temp expected
-	fi &&
+	append_cr <expected >expected.temp &&
+	mv expected.temp expected &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -90,10 +89,8 @@ test_expect_success 'Merge addition of text=3Dauto' =
'
 	same line
 	EOF
=20
-	if test_have_prereq NATIVE_CRLF; then
-		append_cr <expected >expected.temp &&
-		mv expected.temp expected
-	fi &&
+	append_cr <expected >expected.temp &&
+	mv expected.temp expected &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -104,15 +101,9 @@ test_expect_success 'Merge addition of text=3Dauto=
' '
=20
 test_expect_success 'Detect CRLF/LF conflict after setting text=3Dauto=
' '
 	echo "<<<<<<<" >expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected &&
-		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected
-	else
-		echo first line >>expected &&
-		echo same line >>expected &&
-		echo =3D=3D=3D=3D=3D=3D=3D >>expected
-	fi &&
+	echo first line | append_cr >>expected &&
+	echo same line | append_cr >>expected &&
+	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
@@ -128,15 +119,9 @@ test_expect_success 'Detect LF/CRLF conflict from =
addition of text=3Dauto' '
 	echo "<<<<<<<" >expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected
-	else
-		echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
-		echo first line >>expected &&
-		echo same line >>expected
-	fi &&
+	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
+	echo first line | append_cr >>expected &&
+	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
--=20
2.0.0.rc1.6318.g0c2c796
