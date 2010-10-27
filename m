From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/34] t1510: setup case #11
Date: Wed, 27 Oct 2010 21:49:17 +0700
Message-ID: <1288190977-30875-15-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Ls-000797-42
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933561Ab0J0Ova convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:51:30 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63769 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933455Ab0J0Ov2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:51:28 -0400
Received: by gyg4 with SMTP id 4so417352gyg.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=S2kGJSbXkDQ/ogHSuznil2o0IJL18fAMC28x4KuBRQg=;
        b=ONuDFdVyHa9xRs+mi/v1dtnMAXPPeqgPdf9Zmhi5oJrW3yXeLjKLA9zvfiwREpTYNg
         1MrrBWmUlLIn3+L2oPVJZJNYQzPY6EAtmvJ+KhNA2wikiWTIdUyOs8gUwCVO/ZSurwFQ
         ENn/ikgVEJtEfp7dN8cYFq86/3Zpdk8Wam6TY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CwYFcMmavQ0Jb9kLex8ooWsFvhTxqEWLsWHvVvPVH/s0uvht5OoCMSVHW05JpKNZJd
         xBf6WzExCNoKT+L3muhXq3pS9tJ+7vYRf+cqYpzEp/ZAsTYJVMP4oKBDQw0VFcFryorW
         hE41V6MTAWdgVbygOxl0SfurFwkY0j0xkcSIA=
Received: by 10.151.44.3 with SMTP id w3mr17823054ybj.247.1288191087627;
        Wed, 27 Oct 2010 07:51:27 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q36sm8780342ybk.6.2010.10.27.07.51.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:51:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:51:24 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160054>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  267 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 73b18a2..844d204 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1294,4 +1294,271 @@ EOF
 	GIT_DIR=3D../.git test_repo 10/sub
 '
=20
+#
+# case #11
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #3 except that git_dir is set by .git file
+
+test_expect_success '#11: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 11 11/sub 11/sub/sub 11.wt 11.wt/sub 11/wt 11/wt/sub &&
+	cd 11 &&
+	git init &&
+	mv .git ../11.git &&
+	echo gitdir: ../11.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11" test_repo =
11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >11/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11" test_repo 11/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../.. test_repo =
11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11/wt" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3Dwt test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11/wt" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11/wt" test_re=
po 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../../wt test_re=
po 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11/wt" test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D.. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 11/=
sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 11/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
