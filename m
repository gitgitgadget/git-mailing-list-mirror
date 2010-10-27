From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/34] t1510: setup case #16
Date: Wed, 27 Oct 2010 21:49:22 +0700
Message-ID: <1288190977-30875-20-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:52:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Mm-0007lz-Jb
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760628Ab0J0OwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:52:09 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38515 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681Ab0J0OwH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:52:07 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so427157gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+oWodTEfphBGySAp1TblWNGRIUkLWypIUWB8e77VP8U=;
        b=B9TajujWhaTD/tifgWpWRGrLCgGFgZUxJ+HGGXPhJ6e90M+S8oM74Zhc/lcRy+ofpD
         d4tzHI5jHRWa9xz5eIx//YZk5BZJ8ilDdKAoHmT7yiJ1Ql53rSalJ8tkrBRRADY5gE+r
         Qz0yPUUdSD/Uw8tbFLVo7I6AF7p9bauhFdKVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OTW+5bNzpH+ata1T1oxbqN3lBOY07qEw1BLb6QZtNvQazkuR9PGw2269zmigMg6FDz
         nKMAiG+221Y5DQj9jevLrCUCJBGT30/FDsgrJk13rFgoFHm732Y/k5MKJKpAN8VrZxsX
         8O4CkKLan627N3Vj7deaZbM8tYhhUhdkpriO8=
Received: by 10.150.11.16 with SMTP id 16mr17999673ybk.299.1288191127030;
        Wed, 27 Oct 2010 07:52:07 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id n28sm7710960yha.16.2010.10.27.07.52.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:52:06 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:52:04 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160060>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  135 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 47c8814..a856d7c 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2218,4 +2218,139 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 15/sub/sub
 '
=20
+#
+# case #16.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+#  - no worktree
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set
+#  - cwd can't be outside worktree
+
+test_expect_success '#16.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 16 16/sub &&
+	cd 16 &&
+	git init &&
+	mkdir .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_success '#16.1: at .git' '
+	cat >16/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git
+setup: prefix: (null)
+EOF
+	test_repo 16/.git
+'
+
+test_expect_success '#16.1: in .git/wt' '
+	cat >16/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/16/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 16/.git/wt
+'
+
+test_expect_success '#16.1: in .git/wt/sub' '
+	cat >16/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/16/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 16/.git/wt/sub
+'
+
+#
+# case #16.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+#  - no worktree
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set
+#  - cwd can't be outside worktree
+
+test_expect_success '#16.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/16/.git/config" core.bare true
+'
+
+test_expect_success '#16.2: at .git' '
+	cat >16/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git
+setup: prefix: (null)
+EOF
+	test_repo 16/.git
+'
+
+test_expect_success '#16.2: in .git/wt' '
+	cat >16/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/16/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 16/.git/wt
+'
+
+test_expect_success '#16.2: in .git/wt/sub' '
+	cat >16/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/16/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 16/.git/wt/sub
+'
+
+test_expect_success '#16.2: at root' '
+	cat >16/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16
+setup: prefix: (null)
+EOF
+	test_repo 16
+'
+
+test_expect_failure '#16.2: in subdir' '
+	cat >16/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/sub
+setup: prefix: (null)
+EOF
+	test_repo 16/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
