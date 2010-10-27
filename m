From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/34] t1510: setup case #14
Date: Wed, 27 Oct 2010 21:49:20 +0700
Message-ID: <1288190977-30875-18-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Mk-0007lz-O5
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348Ab0J0Ovw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:51:52 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38515 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab0J0Ovu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:51:50 -0400
Received: by gxk23 with SMTP id 23so427157gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=DY/5Vclo59fCzU1VbRMLrQJuR0vC2/NqhzhYmwoell0=;
        b=LHec9BZk5aB8GM5gTgz4yWlXzgqkaH20G7n44ReoQT501lioUKfNfkVM4Rds4bqERn
         um9GTmhcSRicQ2cN6DM8BpFP/KrmN3BMruSdQagS/JeKoEUn/RCvM4dKsuYVyNyg6KGN
         C/3sDh+aWtiNj9xxUVPZEMzx6DCrTntyAeM38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TPT4WZgM8O9l+x3b+RUc1zbEWtUkh4h80zOsoWHDS0Q9NJBZClGeEiSz8VVbZCh6sp
         0zILhuGg7yd9anguaAPedkZyZokBdM8/gHnAfJwRCKojzVgg7es3F1S4rEyQHBsz0vQy
         MBeVeB4IWWG5IWrgTqqNnzymRY3+IeC/7Vw9w=
Received: by 10.150.143.10 with SMTP id q10mr4982303ybd.46.1288191109942;
        Wed, 27 Oct 2010 07:51:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id i2sm7697591yha.31.2010.10.27.07.51.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:51:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:51:47 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160061>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  291 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 291 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index ec0a993..0cd00ea 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1659,4 +1659,295 @@ EOF
 	test_repo 13/sub
 '
=20
+#
+# case #14
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #6 except that git_dir is set by .git file
+
+test_expect_success '#14: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 14 14/sub 14/sub/sub 14.wt 14.wt/sub 14/wt 14/wt/sub &&
+	cd 14 &&
+	git init &&
+	mv .git ../14.git &&
+	echo gitdir: ../14.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) at roo=
t' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D.. at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. in subdir' =
'
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) in sub=
dir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D.. in subdir' '
+	cat >14/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) in subdir' =
'
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../wt at root'=
 '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../wt(rel) at =
root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/wt &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../wt(rel) at root'=
 '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/wt &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../wt at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../wt in subdi=
r' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../wt(rel) in =
subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/wt &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../wt(rel) in subdi=
r' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/wt &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../wt in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../.. at root'=
 '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../..(rel) at =
root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/../ &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../..(rel) at root'=
 '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/../ &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../.. at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../.. in subdi=
r' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../..(rel) in =
subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/.. &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../..(rel) in subdi=
r' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/.. &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../.. in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
