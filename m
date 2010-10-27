From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/34] t1510: setup case #7
Date: Wed, 27 Oct 2010 21:49:13 +0700
Message-ID: <1288190977-30875-11-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:51:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Lo-000797-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933495Ab0J0Ou6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:50:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54499 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933455Ab0J0Ou4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:50:56 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so426005gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PJptw84wzRo0Paa9ZrtWdU0Mk4PrlZ5MFMmG1FLAj84=;
        b=GxrxOymV9UPRodpv+W/gYDX5FyAa9Aa/gha2h+i0q3o0d/T1stDU7fGCdIoIzEcXIP
         X5ksm/daPqg4fVAR59VAJ+GfaL2VTHY+CN0A1oDRRal3V+ykPti6hDaQWOkAgFmEjXkQ
         ysAT6A8Dw3gpnCD3cXp8b8HvXAYi8dG8EkUeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cvpEQ3CAx+MXLMg3L4n1PoIC3hsbBtAq2Oz46/GNP8wBrhssf0rzBrHrYaZKmHg3f0
         UlL71vVDb9be7OGljkepiW/lKlU6e1LhSJQko5OW3ioukoniqRzidmodjCKSNvEUdjwc
         CXhFfXMvSgyLYDeldun5M02HwGoim9+jRMrYs=
Received: by 10.150.219.7 with SMTP id r7mr7467265ybg.192.1288191056319;
        Wed, 27 Oct 2010 07:50:56 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id n48sm4768911yha.7.2010.10.27.07.50.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:50:55 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:50:53 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160053>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  266 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 266 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 6e69ad7..968a5b2 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -867,4 +867,270 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
 '
=20
+#
+# case #7
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# core.worktree is overridden by GIT_WORK_TREE -> #3
+
+test_expect_success '#7: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 7 7/sub 7/sub/sub 7.wt 7.wt/sub 7/wt 7/wt/sub &&
+	cd 7 &&
+	git init &&
+	git config core.worktree non-existent &&
+	cd ..
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/7" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at ro=
ot' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/7" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir' =
'
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/7" test_repo 7=
/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in sub=
dir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >7/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/7" test_repo 7/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir' =
'
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D../.. test_repo 7=
/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/7/wt" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at root=
' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3Dwt test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/7/wt" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/7/wt" test_rep=
o 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in subd=
ir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D../../wt test_rep=
o 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/7/wt" test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at root=
' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D.. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 7/s=
ub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in subd=
ir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D../../../ test_re=
po 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
" test_repo 7/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
