From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] Fix tests under GETTEXT_POISON on git-apply
Date: Tue, 21 Aug 2012 11:31:01 +0700
Message-ID: <1345523464-14586-5-git-send-email-pclouds@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 06:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3gFs-0001ta-2Z
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 06:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab2HUEjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 00:39:47 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52466 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2HUEjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 00:39:45 -0400
Received: by dakf10 with SMTP id f10so3250841dak.11
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 21:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GIJpFWWbvqTZ0wDTq+IrJW/pEJuYq02DCPUmf8A6jp0=;
        b=hIkYXql/Aq9AJALlvbIqn/j/VLwE31Y7voBVu0ptgBeVx4+/dA7+asSp1ZCdeg7ApT
         UJK3yM104bMSTHrg82qZLSCn08C924UV6G0wz2XmH4sd2xC8JSZ4cWD/KrGSny8ryJV+
         13zrkpMZvnajQyj1ejCkNaqoXTqe6qxWofkY+HpiI/fhW7mtUtojrsU9m44VqqVmMa+7
         6XybvdWG0Pmls+yl2WfdthMT59ChXtTHuF2LY/JqoBvbxuZlwsimi9MdhkWJjAqMkBP1
         h38gAGqhSK9EF0N+l3xcLwqZUJRN6LIhIrVeTgVZDe/zRhCZePES9xRPsIQys1azvHNT
         25rg==
Received: by 10.68.240.7 with SMTP id vw7mr1104380pbc.152.1345523527779;
        Mon, 20 Aug 2012 21:32:07 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id nd2sm601774pbc.7.2012.08.20.21.32.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 21:32:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Aug 2012 11:31:53 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203935>

=46rom: Jiang Xin <worldhello.net@gmail.com>

Use i18n-specific test functions in test scripts for git-apply.
This issue was was introduced in the following commits:

    de373 i18n: apply: mark parseopt strings for translation
    3638e i18n: apply: mark strings for translation

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4012-diff-binary.sh     | 4 ++--
 t/t4120-apply-popt.sh      | 4 ++--
 t/t4133-apply-filenames.sh | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index ec4deea..1215ae5 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -63,7 +63,7 @@ test_expect_success 'apply --numstat understands diff=
 --binary format' '
=20
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
-test_expect_success 'apply detecting corrupt patch correctly' '
+test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch cor=
rectly' '
 	git diff >output &&
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
@@ -73,7 +73,7 @@ test_expect_success 'apply detecting corrupt patch co=
rrectly' '
 	test "$detected" =3D xCIT
 '
=20
-test_expect_success 'apply detecting corrupt patch correctly' '
+test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch cor=
rectly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=3D`cat detected` &&
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index a33d510..c5fecdf 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -32,7 +32,7 @@ test_expect_success 'apply git diff with -p2' '
 test_expect_success 'apply with too large -p' '
 	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.file 2>err &&
-	grep "removing 3 leading" err
+	test_i18ngrep "removing 3 leading" err
 '
=20
 test_expect_success 'apply (-p2) traditional diff with funny filenames=
' '
@@ -54,7 +54,7 @@ test_expect_success 'apply (-p2) traditional diff wit=
h funny filenames' '
 test_expect_success 'apply with too large -p and fancy filename' '
 	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.escaped 2>err &&
-	grep "removing 3 leading" err
+	test_i18ngrep "removing 3 leading" err
 '
=20
 test_expect_success 'apply (-p2) diff, mode change only' '
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 94da990..2ecb421 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -30,9 +30,9 @@ EOF
=20
 test_expect_success 'apply diff with inconsistent filenames in headers=
' '
 	test_must_fail git apply bad1.patch 2>err &&
-	grep "inconsistent new filename" err &&
+	test_i18ngrep "inconsistent new filename" err &&
 	test_must_fail git apply bad2.patch 2>err &&
-	grep "inconsistent old filename" err
+	test_i18ngrep "inconsistent old filename" err
 '
=20
 test_done
--=20
1.7.12.rc2
