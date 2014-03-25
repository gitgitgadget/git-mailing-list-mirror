From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 013/144] t0026-eol-config.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:18 -0700
Message-ID: <1395735989-3396-14-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhM-0006r1-75
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbaCYI06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:26:58 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:57035 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbaCYI0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:54 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so132738pdj.4
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kbqKyiDIM29HjqHg4xpf5+NbC49FZUQbwiMBUW5D5E4=;
        b=KrRaSUMq8hzxVt+H5ZVHHW7tRtGD4NCK5agyPjl9bZyA7IBBc8YRIZueMfIJmI8P8C
         YWx+3HGaG4Lvi8BdUJpTHGJN2Y0rz+fJe7j6ewQ/TX3BqVJ1l4EuiuA86PsFofmhDlBJ
         gEFfaa9FSWA0S62aS8lCjbshLmPQL2YdLEINq/vjp7ukPW1SLKwghxIjMxC2uSAlrEqC
         lhfwTNZ5Go9fsXF6k5lAtHURIidannD4y13mSyjLxPOnjOupQs3vZi4ph5d59p8s4Sw1
         GKhYqYrBsNZhxqsYlCb1Gd+2cODM3pjKyeT+lAuZ+y2X9P40c4GCfN0GpQK/I2415gW3
         oZ2g==
X-Received: by 10.68.218.3 with SMTP id pc3mr77760101pbc.71.1395736013497;
        Tue, 25 Mar 2014 01:26:53 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244914>

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
 t/t0026-eol-config.sh |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index fe0164b..e1126aa 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -20,8 +20,8 @@ test_expect_success setup '
=20
 	git commit -m initial &&
=20
-	one=3D`git rev-parse HEAD:one` &&
-	two=3D`git rev-parse HEAD:two` &&
+	one=3D$(git rev-parse HEAD:one) &&
+	two=3D$(git rev-parse HEAD:two) &&
=20
 	echo happy.
 '
@@ -34,8 +34,8 @@ test_expect_success 'eol=3Dlf puts LFs in normalized =
file' '
=20
 	! has_cr one &&
 	! has_cr two &&
-	onediff=3D`git diff one` &&
-	twodiff=3D`git diff two` &&
+	onediff=3D$(git diff one) &&
+	twodiff=3D$(git diff two) &&
 	test -z "$onediff" -a -z "$twodiff"
 '
=20
@@ -47,8 +47,8 @@ test_expect_success 'eol=3Dcrlf puts CRLFs in normali=
zed file' '
=20
 	has_cr one &&
 	! has_cr two &&
-	onediff=3D`git diff one` &&
-	twodiff=3D`git diff two` &&
+	onediff=3D$(git diff one) &&
+	twodiff=3D$(git diff two) &&
 	test -z "$onediff" -a -z "$twodiff"
 '
=20
@@ -61,8 +61,8 @@ test_expect_success 'autocrlf=3Dtrue overrides eol=3D=
lf' '
=20
 	has_cr one &&
 	has_cr two &&
-	onediff=3D`git diff one` &&
-	twodiff=3D`git diff two` &&
+	onediff=3D$(git diff one) &&
+	twodiff=3D$(git diff two) &&
 	test -z "$onediff" -a -z "$twodiff"
 '
=20
@@ -75,8 +75,8 @@ test_expect_success 'autocrlf=3Dtrue overrides unset =
eol' '
=20
 	has_cr one &&
 	has_cr two &&
-	onediff=3D`git diff one` &&
-	twodiff=3D`git diff two` &&
+	onediff=3D$(git diff one) &&
+	twodiff=3D$(git diff two) &&
 	test -z "$onediff" -a -z "$twodiff"
 '
=20
--=20
1.7.10.4
