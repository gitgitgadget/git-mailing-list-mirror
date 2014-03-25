From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 095/144] t7602-merge-octopus-many.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:40 -0700
Message-ID: <1395735989-3396-96-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMik-00008U-0q
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbaCYI2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:22 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:39151 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCYI2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:21 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so131642pdi.19
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=f1acJ/qEGmeLilCHNihmNdERY8lDljeFqj4bsKQYkbo=;
        b=kd5jTLxYQYYwcAx8ZZkC0Jt1p7NFHAYhIODAotmEnB9b3QYZGx8y+LeK4qcohA/Lsl
         oS1gujhn1VFlbTYRJHFSx4XQUhK2Rv0eME1MzbxBfFfFNQyAUHAgxf2yGooTGrRJy8RQ
         8dqm/vz1Dkd7Op5O7L2mscOfvp/64k8voo7a7seGj4Ac/Cg8QNNPEjjmw62cgttJm1cn
         9hZy6CmxsfyV3iqvon8Qf0h9Lq5PMcyXKK0/3nFIXpoRuwM3o2mNxP+NuIkV3/y3qaQO
         xK5b0sw9ZfLjOZIOUOcA6h0+cc7T9b/t9TzgYjfZO1WCBm2l8sJd4cxAJJtNshjFKL28
         x55A==
X-Received: by 10.68.108.1 with SMTP id hg1mr77259880pbb.80.1395736100715;
        Tue, 25 Mar 2014 01:28:20 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244934>

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
 t/t7602-merge-octopus-many.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many=
=2Esh
index 955f09f..6abe441 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 		git add c$i.c &&
 		git commit -m c$i &&
 		git tag c$i &&
-		i=3D`expr $i + 1` || return 1
+		i=3D$(expr $i + 1) || return 1
 	done
 '
=20
@@ -30,7 +30,7 @@ test_expect_success 'merge c1 with c2, c3, c4, ... c2=
9' '
 	while test $i -le 30
 	do
 		refs=3D"$refs c$i"
-		i=3D`expr $i + 1`
+		i=3D$(expr $i + 1)
 	done &&
 	git merge $refs &&
 	test "$(git rev-parse c1)" !=3D "$(git rev-parse HEAD)" &&
@@ -38,14 +38,14 @@ test_expect_success 'merge c1 with c2, c3, c4, ... =
c29' '
 	while test $i -le 30
 	do
 		test "$(git rev-parse c$i)" =3D "$(git rev-parse HEAD^$i)" &&
-		i=3D`expr $i + 1` || return 1
+		i=3D$(expr $i + 1) || return 1
 	done &&
 	git diff --exit-code &&
 	i=3D1 &&
 	while test $i -le 30
 	do
 		test -f c$i.c &&
-		i=3D`expr $i + 1` || return 1
+		i=3D$(expr $i + 1) || return 1
 	done
 '
=20
--=20
1.7.10.4
