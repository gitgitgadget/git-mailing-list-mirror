From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 048/144] t4116-apply-reverse.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:53 -0700
Message-ID: <1395735989-3396-49-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMi2-0007gS-QC
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbaCYI1g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:36 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:41751 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbaCYI1b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:31 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so130480pde.29
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DrSo3ACCoijZk+wrmHthwnEabodZNJqend/zgYkoclc=;
        b=drUxdi3RtSOHdfw1bZjlLvhlDFjaOhBzTXfm77FGl8l8PDN4Nb/ch51bhGSD/KIVrW
         9aV4IQEvDgmFtphAMXvX4W9lqSIfgDz7tmV+lLDJ/oRoaWb91Lo72KsigmkXG/2qCf4N
         QoJekebFNHCyNJ25GBEVOcukhSDiRkArGImA7lYshYILlyA8StID2EGzX5UrB1h3cdRv
         37+ZZdysj6vh3tw+K7pcS6ZjDRdqEkL2tFBRhpQLFekgf5A5eWeSfirZ8aS3Syp8vFWg
         QB0X+kOf9gznineLac/knXve9PY4ondGXiV3HDUkKntkBydr0X7lesFAr9ZbASxEMNeE
         O61Q==
X-Received: by 10.68.244.229 with SMTP id xj5mr78740660pbc.108.1395736051245;
        Tue, 25 Mar 2014 01:27:31 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244922>

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
 t/t4116-apply-reverse.sh |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 1e4d438..ce8567f 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -30,10 +30,10 @@ test_expect_success setup '
=20
 test_expect_success 'apply in forward' '
=20
-	T0=3D`git rev-parse "second^{tree}"` &&
+	T0=3D$(git rev-parse "second^{tree}") &&
 	git reset --hard initial &&
 	git apply --index --binary patch &&
-	T1=3D`git write-tree` &&
+	T1=3D$(git write-tree) &&
 	test "$T0" =3D "$T1"
 '
=20
@@ -62,22 +62,22 @@ test_expect_success 'setup separate repository lack=
ing postimage' '
=20
 test_expect_success 'apply in forward without postimage' '
=20
-	T0=3D`git rev-parse "second^{tree}"` &&
+	T0=3D$(git rev-parse "second^{tree}") &&
 	(
 		cd initial &&
 		git apply --index --binary ../patch &&
-		T1=3D`git write-tree` &&
+		T1=3D$(git write-tree) &&
 		test "$T0" =3D "$T1"
 	)
 '
=20
 test_expect_success 'apply in reverse without postimage' '
=20
-	T0=3D`git rev-parse "initial^{tree}"` &&
+	T0=3D$(git rev-parse "initial^{tree}") &&
 	(
 		cd second &&
 		git apply --index --binary --reverse ../patch &&
-		T1=3D`git write-tree` &&
+		T1=3D$(git write-tree) &&
 		test "$T0" =3D "$T1"
 	)
 '
--=20
1.7.10.4
