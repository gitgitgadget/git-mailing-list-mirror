From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/34] t1510: setup case #23
Date: Wed, 27 Oct 2010 21:49:29 +0700
Message-ID: <1288190977-30875-27-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:53:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7NY-0008P7-3K
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933577Ab0J0OxB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:53:01 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56279 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933575Ab0J0OxA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:53:00 -0400
Received: by yxk8 with SMTP id 8so67902yxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CcOym39u4Q87busFoaq8NdFc9Okam+oy3GA0PttBfT4=;
        b=Bu5ZJzT3Dpa6tMNQk5nRSiKn6ERzOYF8Quiearymk1ABf1MfKO3qaLiS2Y+UNLM3jS
         FX0qCLvaOxIC77O8+I8ARSGVnAykh6Yc9q63l3R6gRyKheolC9dTR/lEty5C001CdKZa
         tV0782hcNzvW8ptEXiW4n8VprHKWqDZV05ZJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vPhAo7FpNsFQZDLfbc1KxMKCjT/C1LgGrkfb7jZc5Gz6qrIcOT7K/8dzfNCwvo1akB
         gdLo52mkCeb6ycKbYLMetAwCYBM+ICHHUp//AftpCC53uns5ZMiHVKzeGrErtUyTslCW
         JI9MppRHZZ34lghrJdey6yzI0yn2BxKOnbVvI=
Received: by 10.91.50.11 with SMTP id c11mr1082773agk.156.1288191178847;
        Wed, 27 Oct 2010 07:52:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id z30sm7713648yhc.9.2010.10.27.07.52.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:52:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:52:56 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160066>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  267 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 5d66c34..30743d6 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3408,4 +3408,271 @@ test_expect_failure '#22.2: at root' '
 	)
 '
=20
+#
+# case #23
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree is overridden by GIT_WORK_TREE -> #19
+
+test_expect_success '#23: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 23 23/sub 23/sub/sub 23.wt 23.wt/sub 23/wt 23/wt/sub &&
+	cd 23 &&
+	git init &&
+	git config core.bare true &&
+	git config core.worktree non-existent &&
+	cd ..
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/23" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/23" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D. test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/23" test_repo =
23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >23/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/23" test_repo 23/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D../.. test_repo =
23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/23/wt" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3Dwt test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/23/wt" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/23/wt" test_re=
po 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D../../wt test_re=
po 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/23/wt" test_repo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D.. test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 23/=
sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 23/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
