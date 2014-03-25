From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 012/144] t0025-crlf-auto.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:17 -0700
Message-ID: <1395735989-3396-13-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhL-0006r1-MS
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbaCYI0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:26:55 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:50075 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbaCYI0x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:53 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so134122pbc.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZlMB53XrcJBJgUiPKhdwQV6uEu4XSVPKQUbiW098rYY=;
        b=iBf1PSOoGRScBwLTs9HLN9uXzGxuc4welCljeHYL6cQxX1aQrTns8SOEPWOkJGybOJ
         FtMaor0fCAxiEEUSpqhT6QeJcT1607IDhVHQOHxKvSYD36WJ9+8KqfaOIY1RLhM34IOP
         ppG9nDZ1YJMlOojy7bjRwRxbqy67Gp19d7Z4+VqiuPQKrijBJ3UNFVPEQAovM/J8luil
         Jrt7Hsn2Qrh9Pv5mWkknG3Y7oLI3ZhkIociUbfVpoA47uhZfEHteORuXhPtXREOHTcjT
         IgmUp7Xnr1xJYdYeinZgNVpmwAp9QHQYAMSh+O4POypD2dzrhB9niLv7p6P/mKxTbphi
         U0Sg==
X-Received: by 10.68.202.8 with SMTP id ke8mr78006141pbc.86.1395736012548;
        Tue, 25 Mar 2014 01:26:52 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244912>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t0025-crlf-auto.sh |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index f5f67a6..b0e5694 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -19,9 +19,9 @@ test_expect_success setup '
=20
 	git commit -m initial &&
=20
-	one=3D`git rev-parse HEAD:one` &&
-	two=3D`git rev-parse HEAD:two` &&
-	three=3D`git rev-parse HEAD:three` &&
+	one=3D$(git rev-parse HEAD:one) &&
+	two=3D$(git rev-parse HEAD:two) &&
+	three=3D$(git rev-parse HEAD:three) &&
=20
 	echo happy.
 '
@@ -33,9 +33,9 @@ test_expect_success 'default settings cause no change=
s' '
=20
 	! has_cr one &&
 	has_cr two &&
-	onediff=3D`git diff one` &&
-	twodiff=3D`git diff two` &&
-	threediff=3D`git diff three` &&
+	onediff=3D$(git diff one) &&
+	twodiff=3D$(git diff two) &&
+	threediff=3D$(git diff three) &&
 	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
 '
=20
@@ -48,7 +48,7 @@ test_expect_success 'crlf=3Dtrue causes a CRLF file t=
o be normalized' '
=20
 	# Note, "normalized" means that git will normalize it if added
 	has_cr two &&
-	twodiff=3D`git diff two` &&
+	twodiff=3D$(git diff two) &&
 	test -n "$twodiff"
 '
=20
@@ -60,7 +60,7 @@ test_expect_success 'text=3Dtrue causes a CRLF file t=
o be normalized' '
=20
 	# Note, "normalized" means that git will normalize it if added
 	has_cr two &&
-	twodiff=3D`git diff two` &&
+	twodiff=3D$(git diff two) &&
 	test -n "$twodiff"
 '
=20
@@ -72,7 +72,7 @@ test_expect_success 'eol=3Dcrlf gives a normalized fi=
le CRLFs with autocrlf=3Dfalse'
 	git read-tree --reset -u HEAD &&
=20
 	has_cr one &&
-	onediff=3D`git diff one` &&
+	onediff=3D$(git diff one) &&
 	test -z "$onediff"
 '
=20
@@ -84,7 +84,7 @@ test_expect_success 'eol=3Dcrlf gives a normalized fi=
le CRLFs with autocrlf=3Dinput'
 	git read-tree --reset -u HEAD &&
=20
 	has_cr one &&
-	onediff=3D`git diff one` &&
+	onediff=3D$(git diff one) &&
 	test -z "$onediff"
 '
=20
@@ -96,7 +96,7 @@ test_expect_success 'eol=3Dlf gives a normalized file=
 LFs with autocrlf=3Dtrue' '
 	git read-tree --reset -u HEAD &&
=20
 	! has_cr one &&
-	onediff=3D`git diff one` &&
+	onediff=3D$(git diff one) &&
 	test -z "$onediff"
 '
=20
@@ -108,9 +108,9 @@ test_expect_success 'autocrlf=3Dtrue does not norma=
lize CRLF files' '
=20
 	has_cr one &&
 	has_cr two &&
-	onediff=3D`git diff one` &&
-	twodiff=3D`git diff two` &&
-	threediff=3D`git diff three` &&
+	onediff=3D$(git diff one) &&
+	twodiff=3D$(git diff two) &&
+	threediff=3D$(git diff three) &&
 	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
 '
=20
@@ -123,9 +123,9 @@ test_expect_success 'text=3Dauto, autocrlf=3Dtrue _=
does_ normalize CRLF files' '
=20
 	has_cr one &&
 	has_cr two &&
-	onediff=3D`git diff one` &&
-	twodiff=3D`git diff two` &&
-	threediff=3D`git diff three` &&
+	onediff=3D$(git diff one) &&
+	twodiff=3D$(git diff two) &&
+	threediff=3D$(git diff three) &&
 	test -z "$onediff" -a -n "$twodiff" -a -z "$threediff"
 '
=20
@@ -137,7 +137,7 @@ test_expect_success 'text=3Dauto, autocrlf=3Dtrue d=
oes not normalize binary files' '
 	git read-tree --reset -u HEAD &&
=20
 	! has_cr three &&
-	threediff=3D`git diff three` &&
+	threediff=3D$(git diff three) &&
 	test -z "$threediff"
 '
=20
@@ -148,7 +148,7 @@ test_expect_success 'eol=3Dcrlf _does_ normalize bi=
nary files' '
 	git read-tree --reset -u HEAD &&
=20
 	has_cr three &&
-	threediff=3D`git diff three` &&
+	threediff=3D$(git diff three) &&
 	test -z "$threediff"
 '
=20
--=20
1.7.10.4
