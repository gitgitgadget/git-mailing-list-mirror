From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/34] t1510: setup case #3
Date: Wed, 27 Oct 2010 21:49:09 +0700
Message-ID: <1288190977-30875-7-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:50:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Kk-0006PU-GQ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933370Ab0J0Ou2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:50:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40712 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab0J0Ou0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:50:26 -0400
Received: by mail-gw0-f46.google.com with SMTP id 21so424506gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TbhZvVU2gLfWupKjuBOKfOPnqiAAhghI2OMq7Q8//TI=;
        b=LKGWTY6DomKS6/UzjICk+ekh7iLPtaC0qZUs7hbBrVhZ82zqOI9iVUkxtt2NcMR53B
         4hZJIhg46L0TQ8Do1+ckEGq1GSeNZAcBANZCsqSbHsYK5EI1mJ9rDDkS04chEtJPu3OV
         aKwyckDdGRkN2mRM9c1DLvLQNr8VWpIPwdrTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=h+PCrYqRbTbx+uqx9t0zGvm+YjXC2vmky4Tl9IOEKczowyg0yGZvLkemWI7uRzeAnB
         2OykTwJesydfIbxECXSH7PyClVhPctV92gOwDeGVfekA3m0oQ3+c+Dnf8OxA875+HP3F
         BBDIV3kSbDwijiH8nYwV92nG0EE8e/4XIlglY=
Received: by 10.100.136.7 with SMTP id j7mr7993261and.64.1288191026142;
        Wed, 27 Oct 2010 07:50:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id b22sm11919886anb.15.2010.10.27.07.50.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:50:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:50:23 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160046>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  267 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index bf008c6..e1b8958 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -216,4 +216,271 @@ EOF
 	GIT_DIR=3D../.git test_repo 2/sub
 '
=20
+#
+# case #3
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is set to $GIT_WORK_TREE
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is set to $GIT_DIR
+#  - cwd can be outside worktree
+
+test_expect_success '#3: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 3 3/sub 3/sub/sub 3.wt 3.wt/sub 3/wt 3/wt/sub &&
+	cd 3 && git init && cd ..
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/3" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at ro=
ot' '
+	cat >3/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/3" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D. test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir' =
'
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/3" test_repo 3=
/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in sub=
dir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >3/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/3" test_repo 3/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir' =
'
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D../.. test_repo 3=
/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/3/wt" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at root=
' '
+	cat >3/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3Dwt test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/3/wt" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/3/wt" test_rep=
o 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in subd=
ir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D../../wt test_rep=
o 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/3/wt" test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at root=
' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D.. test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
" test_repo 3
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 3/s=
ub/sub
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in subd=
ir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D../../../ test_re=
po 3/sub/sub
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
" test_repo 3/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
