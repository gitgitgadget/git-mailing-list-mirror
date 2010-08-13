From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/10] tests: Move FILEMODE prerequisite to lib-prereq-FILEMODE.sh
Date: Fri, 13 Aug 2010 20:40:04 +0000
Message-ID: <1281732013-18284-2-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok145-0007V9-K2
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab0HMUkz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:40:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51636 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab0HMUkv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:40:51 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so3432822wwj.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ql52uFfnfdHvaCgswTb+g8O9bmb3Vp0AJY3CcOzldH8=;
        b=SV7LTmaKignhPZxCHQKZy1FFcTcqDG9dpRsngNlcliDurka1LPhGs+OKD6C7y8uzSr
         WuuihgrAy9S+bqlPlT9Z4XFLvKdwuNvOHpaLGkV1Wj57dT21uNeYhEc5voaCdPkwtMA1
         XJHMcnQoSBOopMy5tZn8y3dJmx3vhhOFxAezc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=x0CyC430yBbMdq7+vIYNkyxSE66uTVCopvcNriqUCYBPBkNQV5CWIQY8EojcQRwBfr
         ShTGLAEqAEyKOP6V4wJize90fMeSjxXczVsUym7YsEPqa9Fy5G45frz7AyFTUgL1Rliu
         f9Mk672dpFRdVZGWNGwrcGmD7bmNCYWNqcWPk=
Received: by 10.216.1.77 with SMTP id 55mr1699194wec.72.1281732050371;
        Fri, 13 Aug 2010 13:40:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.40.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:40:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153502>

Change the five tests that were all checking "git config --bool
core.filemode" to use a new FILEMODE prerequisite in
lib-prereq-FILEMODE.sh.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/lib-prereq-FILEMODE.sh       |   11 +++++++++++
 t/t3701-add-interactive.sh     |    8 +-------
 t/t4102-apply-rename.sh        |    8 +-------
 t/t4129-apply-samemode.sh      |    8 +-------
 t/t6031-merge-recursive.sh     |    6 +-----
 t/t9200-git-cvsexportcommit.sh |    6 +-----
 6 files changed, 16 insertions(+), 31 deletions(-)
 create mode 100644 t/lib-prereq-FILEMODE.sh

diff --git a/t/lib-prereq-FILEMODE.sh b/t/lib-prereq-FILEMODE.sh
new file mode 100644
index 0000000..bce5a4c
--- /dev/null
+++ b/t/lib-prereq-FILEMODE.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+if test "$(git config --bool core.filemode)" =3D false
+then
+	say 'filemode disabled on the filesystem'
+else
+	test_set_prereq FILEMODE
+fi
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 7ad8465..75ec90b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'add -i basic tests'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 if ! test_have_prereq PERL; then
 	skip_all=3D'skipping git add -i tests, perl not available'
@@ -152,13 +153,6 @@ test_expect_success 'skip files similarly as commi=
t -a' '
 '
 rm -f .gitignore
=20
-if test "$(git config --bool core.filemode)" =3D false
-then
-	say '# skipping filemode tests (filesystem does not properly support =
modes)'
-else
-	test_set_prereq FILEMODE
-fi
-
 test_expect_success FILEMODE 'patch does not affect mode' '
 	git reset --hard &&
 	echo content >>file &&
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index 1597965..e3ea3d5 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -7,6 +7,7 @@ test_description=3D'git apply handling copy/rename patc=
h.
=20
 '
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 # setup
=20
@@ -31,13 +32,6 @@ test_expect_success setup \
 test_expect_success apply \
     'git apply --index --stat --summary --apply test-patch'
=20
-if test "$(git config --bool core.filemode)" =3D false
-then
-	say 'filemode disabled on the filesystem'
-else
-	test_set_prereq FILEMODE
-fi
-
 test_expect_success FILEMODE validate \
 	    'test -f bar && ls -l bar | grep "^-..x......"'
=20
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index fc7af04..0d36ebd 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -3,13 +3,7 @@
 test_description=3D'applying patch with mode bits'
=20
 . ./test-lib.sh
-
-if test "$(git config --bool core.filemode)" =3D false
-then
-	say 'filemode disabled on the filesystem'
-else
-	test_set_prereq FILEMODE
-fi
+. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 test_expect_success setup '
 	echo original >file &&
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index 8a3304f..66167e3 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -2,11 +2,7 @@
=20
 test_description=3D'merge-recursive: handle file mode'
 . ./test-lib.sh
-
-if ! test "$(git config --bool core.filemode)" =3D false
-then
-	test_set_prereq FILEMODE
-fi
+. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 test_expect_success 'mode change in one branch: keep changed version' =
'
 	: >file1 &&
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index ee39b36..e5da65b 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -5,6 +5,7 @@
 test_description=3D'Test export of commits to CVS'
=20
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
=20
 if ! test_have_prereq PERL; then
 	skip_all=3D'skipping git cvsexportcommit tests, perl not available'
@@ -229,11 +230,6 @@ test_expect_success \
       test_must_fail git cvsexportcommit -c $id
       )'
=20
-if ! test "$(git config --bool core.filemode)" =3D false
-then
-	test_set_prereq FILEMODE
-fi
-
 test_expect_success FILEMODE \
      'Retain execute bit' \
      'mkdir G &&
--=20
1.7.2.1.338.gf2379
