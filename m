From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 044/144] t4014-format-patch.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:49 -0700
Message-ID: <1395735989-3396-45-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:34:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMoR-00075z-CI
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbaCYIeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:34:14 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:54490 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbaCYI11 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:27 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so134196pde.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/Bk5FVUbc3+YM62AVR8aXlkple8g5sqVg9+RotwZkvk=;
        b=M/h3s6Tda1bfiDJY+AtihI79oFDHOZey+BSLakjWAu16XHRI1HGycChut6n4eKU7DD
         u8P8cIJ6d5e5u6/y20lxjmGNk6JEkJLPso/ItfQzRRTKQpbUKQjFp/itfg+c+NytW0Qy
         RgoZzKjOiED9wQ2FA/R+5ISI3HmJOpQK85U8C7BXc2xfxc2Jelte3KvfxDyzSTkeArxc
         ybanbc0k5f4MlR6bFeKPYJfkNwfTSi7Fhs74kHVI1cXbIwSKe9mVXV/J4tMCQ9mcA7/I
         zBvd+gCVCS+amxN8NUqaS86/yDipcqvo3q2IQLSNBLVhefyeEk28dFIacfMXpfjS2zwn
         66jA==
X-Received: by 10.66.218.170 with SMTP id ph10mr76594927pac.53.1395736046979;
        Tue, 25 Mar 2014 01:27:26 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244984>

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
 t/t4014-format-patch.sh |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 73194b2..f9ed598 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -43,7 +43,7 @@ test_expect_success setup '
 test_expect_success "format-patch --ignore-if-in-upstream" '
=20
 	git format-patch --stdout master..side >patch0 &&
-	cnt=3D`grep "^From " patch0 | wc -l` &&
+	cnt=3D$(grep "^From " patch0 | wc -l) &&
 	test $cnt =3D 3
=20
 '
@@ -52,7 +52,7 @@ test_expect_success "format-patch --ignore-if-in-upst=
ream" '
=20
 	git format-patch --stdout \
 		--ignore-if-in-upstream master..side >patch1 &&
-	cnt=3D`grep "^From " patch1 | wc -l` &&
+	cnt=3D$(grep "^From " patch1 | wc -l) &&
 	test $cnt =3D 2
=20
 '
@@ -69,7 +69,7 @@ test_expect_success "format-patch doesn't consider me=
rge commits" '
 	git checkout -b merger master &&
 	test_tick &&
 	git merge --no-ff slave &&
-	cnt=3D`git format-patch -3 --stdout | grep "^From " | wc -l` &&
+	cnt=3D$(git format-patch -3 --stdout | grep "^From " | wc -l) &&
 	test $cnt =3D 3
 '
=20
@@ -77,7 +77,7 @@ test_expect_success "format-patch result applies" '
=20
 	git checkout -b rebuild-0 master &&
 	git am -3 patch0 &&
-	cnt=3D`git rev-list master.. | wc -l` &&
+	cnt=3D$(git rev-list master.. | wc -l) &&
 	test $cnt =3D 2
 '
=20
@@ -85,7 +85,7 @@ test_expect_success "format-patch --ignore-if-in-upst=
ream result applies" '
=20
 	git checkout -b rebuild-1 master &&
 	git am -3 patch1 &&
-	cnt=3D`git rev-list master.. | wc -l` &&
+	cnt=3D$(git rev-list master.. | wc -l) &&
 	test $cnt =3D 2
 '
=20
--=20
1.7.10.4
