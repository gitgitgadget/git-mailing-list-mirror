From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 011/144] t0020-crlf.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:16 -0700
Message-ID: <1395735989-3396-12-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:37:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMrc-0002au-LQ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbaCYI04 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:26:56 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34999 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbaCYI0w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:52 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so130384pdj.6
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=se/PDecyw/erx3J7pi/5EY8G0dmhl+4lDRuf8uM+ncw=;
        b=elpWyHRV1RWKV+aEK25/bpXqO2BidpQTIXhc3ku/fPxTWPODrNep5OiDXXYvDGa1jp
         iUvxvXd/cVd5nxDYs9vQKWl2LkYTx5wGnEgKdIiQQSvFZcRc5hiYV7jHC0rIhcZ4PYGR
         rvBp7K3kOeUS2aUbKFV+AlOTDCh9Bez1w435CeTXOpuJ5fEMV9ApP0710icGI6+hU6C3
         S7BmyZ6zHvdeDkZhG5qXeghZVdMal2QNkb4vCeAzR3I4Hg+Pc+xFLsSigNDbtxyewcNt
         uiJ/Ikf5fk9zX6zNYrs0JzBk/dy+xUVI0wKHxaSoXCzMr6k7A8Bq8KJwSy+57sbO+G2t
         durA==
X-Received: by 10.66.121.164 with SMTP id ll4mr14230000pab.129.1395736011584;
        Tue, 25 Mar 2014 01:26:51 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245007>

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
 t/t0020-crlf.sh |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index e526184..d2e51a8 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -20,14 +20,14 @@ test_expect_success setup '
=20
 	git commit -m initial &&
=20
-	one=3D`git rev-parse HEAD:one` &&
-	dir=3D`git rev-parse HEAD:dir` &&
-	two=3D`git rev-parse HEAD:dir/two` &&
-	three=3D`git rev-parse HEAD:three` &&
+	one=3D$(git rev-parse HEAD:one) &&
+	dir=3D$(git rev-parse HEAD:dir) &&
+	two=3D$(git rev-parse HEAD:dir/two) &&
+	three=3D$(git rev-parse HEAD:three) &&
=20
 	for w in Some extra lines here; do echo $w; done >>one &&
 	git diff >patch.file &&
-	patched=3D`git hash-object --stdin <one` &&
+	patched=3D$(git hash-object --stdin <one) &&
 	git read-tree --reset -u HEAD &&
=20
 	echo happy.
@@ -111,7 +111,7 @@ test_expect_success 'update with autocrlf=3Dinput' =
'
 		}
 	done &&
=20
-	differs=3D`git diff-index --cached HEAD` &&
+	differs=3D$(git diff-index --cached HEAD) &&
 	test -z "$differs" || {
 		echo Oops "$differs"
 		false
@@ -135,7 +135,7 @@ test_expect_success 'update with autocrlf=3Dtrue' '
 		}
 	done &&
=20
-	differs=3D`git diff-index --cached HEAD` &&
+	differs=3D$(git diff-index --cached HEAD) &&
 	test -z "$differs" || {
 		echo Oops "$differs"
 		false
@@ -158,9 +158,9 @@ test_expect_success 'checkout with autocrlf=3Dtrue'=
 '
 			break
 		}
 	done &&
-	test "$one" =3D `git hash-object --stdin <one` &&
-	test "$two" =3D `git hash-object --stdin <dir/two` &&
-	differs=3D`git diff-index --cached HEAD` &&
+	test "$one" =3D $(git hash-object --stdin <one) &&
+	test "$two" =3D $(git hash-object --stdin <dir/two) &&
+	differs=3D$(git diff-index --cached HEAD) &&
 	test -z "$differs" || {
 		echo Oops "$differs"
 		false
@@ -184,9 +184,9 @@ test_expect_success 'checkout with autocrlf=3Dinput=
' '
 			git update-index -- $f
 		fi
 	done &&
-	test "$one" =3D `git hash-object --stdin <one` &&
-	test "$two" =3D `git hash-object --stdin <dir/two` &&
-	differs=3D`git diff-index --cached HEAD` &&
+	test "$one" =3D $(git hash-object --stdin <one) &&
+	test "$two" =3D $(git hash-object --stdin <dir/two) &&
+	differs=3D$(git diff-index --cached HEAD) &&
 	test -z "$differs" || {
 		echo Oops "$differs"
 		false
@@ -200,7 +200,7 @@ test_expect_success 'apply patch (autocrlf=3Dinput)=
' '
 	git read-tree --reset -u HEAD &&
=20
 	git apply patch.file &&
-	test "$patched" =3D "`git hash-object --stdin <one`" || {
+	test "$patched" =3D "$(git hash-object --stdin <one)" || {
 		echo "Eh?  apply without index"
 		false
 	}
@@ -213,7 +213,7 @@ test_expect_success 'apply patch --cached (autocrlf=
=3Dinput)' '
 	git read-tree --reset -u HEAD &&
=20
 	git apply --cached patch.file &&
-	test "$patched" =3D `git rev-parse :one` || {
+	test "$patched" =3D $(git rev-parse :one) || {
 		echo "Eh?  apply with --cached"
 		false
 	}
@@ -226,8 +226,8 @@ test_expect_success 'apply patch --index (autocrlf=3D=
input)' '
 	git read-tree --reset -u HEAD &&
=20
 	git apply --index patch.file &&
-	test "$patched" =3D `git rev-parse :one` &&
-	test "$patched" =3D `git hash-object --stdin <one` || {
+	test "$patched" =3D $(git rev-parse :one) &&
+	test "$patched" =3D $(git hash-object --stdin <one) || {
 		echo "Eh?  apply with --index"
 		false
 	}
@@ -240,7 +240,7 @@ test_expect_success 'apply patch (autocrlf=3Dtrue)'=
 '
 	git read-tree --reset -u HEAD &&
=20
 	git apply patch.file &&
-	test "$patched" =3D "`remove_cr <one | git hash-object --stdin`" || {
+	test "$patched" =3D "$(remove_cr <one | git hash-object --stdin)" || =
{
 		echo "Eh?  apply without index"
 		false
 	}
@@ -253,7 +253,7 @@ test_expect_success 'apply patch --cached (autocrlf=
=3Dtrue)' '
 	git read-tree --reset -u HEAD &&
=20
 	git apply --cached patch.file &&
-	test "$patched" =3D `git rev-parse :one` || {
+	test "$patched" =3D $(git rev-parse :one) || {
 		echo "Eh?  apply without index"
 		false
 	}
@@ -266,8 +266,8 @@ test_expect_success 'apply patch --index (autocrlf=3D=
true)' '
 	git read-tree --reset -u HEAD &&
=20
 	git apply --index patch.file &&
-	test "$patched" =3D `git rev-parse :one` &&
-	test "$patched" =3D "`remove_cr <one | git hash-object --stdin`" || {
+	test "$patched" =3D $(git rev-parse :one) &&
+	test "$patched" =3D "$(remove_cr <one | git hash-object --stdin)" || =
{
 		echo "Eh?  apply with --index"
 		false
 	}
--=20
1.7.10.4
