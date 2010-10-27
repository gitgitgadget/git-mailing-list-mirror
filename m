From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 34/34] t1510: setup case #31
Date: Wed, 27 Oct 2010 21:49:37 +0700
Message-ID: <1288190977-30875-35-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:54:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7OC-0000NW-TF
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933624Ab0J0OyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:54:00 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33236 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521Ab0J0Ox6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:53:58 -0400
Received: by gwj21 with SMTP id 21so428182gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=DrvPX3yX6B800Gnq23yr++v9z68eDEGLYQjU/Sdt820=;
        b=h4+Z0eQsLTOa9AV9eoPfkZj6F/Oi8ELFmxoTu7td37Ciw/ANtzsbU5TIki5smqN/4Q
         yWNkMJwMuvLcAlQHXW0vUJWcwKuvcy/lWM1wMM7hZ38SLw4yYw6W808Zg4n7ksYd98Vr
         RGeUGDfwcW5/cFsTFsfMXLu1TGCoiDC7t1zr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=O97vz0hLsfDlF88N+0MVU4Qe2G89yF7MkVyGtCJwk5Nezb12ezF6iqsLhlbeZJ9U9a
         BlQPp7sd4GNOJ1h7D0SOz/ZyTVoGq0tl/hi1MnSoVzR4KNQIC7Ne0B2TRdKZ7JWN3Dyi
         8tpWzvMq/tYtJVJoucJYFdMy/SL4jLlimfSFI=
Received: by 10.151.79.2 with SMTP id g2mr17589950ybl.84.1288191238250;
        Wed, 27 Oct 2010 07:53:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q41sm8782660ybk.13.2010.10.27.07.53.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:53:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:53:55 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160070>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  269 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 269 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index b095e24..9d24a0f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4243,4 +4243,273 @@ test_expect_failure '#30: at root' '
 	)
 '
=20
+#
+# case #31
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# #23 except git_dir is set according to .git file
+
+test_expect_success '#31: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 31 31/sub 31/sub/sub 31.wt 31.wt/sub 31/wt 31/wt/sub &&
+	cd 31 &&
+	git init &&
+	git config core.bare true &&
+	git config core.worktree non-existent &&
+	mv .git ../31.git &&
+	echo gitdir: ../31.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31" test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31" test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D. test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31" test_repo =
31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >31/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31" test_repo 31/sub
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../.. test_repo =
31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31/wt" test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3Dwt test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31/wt" test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31/wt" test_re=
po 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../../wt test_re=
po 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31/wt" test_repo 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D.. test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 31/=
sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 31/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
