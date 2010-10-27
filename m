From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/34] t1510: setup case #20
Date: Wed, 27 Oct 2010 21:49:26 +0700
Message-ID: <1288190977-30875-24-git-send-email-pclouds@gmail.com>
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
	id 1PB7Mo-0007lz-Nb
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933406Ab0J0Owh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:52:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37043 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681Ab0J0Owg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:52:36 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so445305ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=da3IGcWlih38GXu6F6aI6bBMJrgXT2pRH3j3YXDwDro=;
        b=TwysiuA9ZjfBAqSK/bL0x+l256mq+V/lua7Ls4d44qxvvnLGrMrtTu5GXZAa/Zeoaa
         ryxYmqRszjmauN2LRrhSpO3V81WuIH9KcynlFCHJJjZxuKrLzpfVLeXClBwSq+7TH5Vv
         OzeMA9oRGpCcsUQTjs5bLHMcAoGLuU9nrhtao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OyDObY5Vkwn1bhdBpI7ulsUnksNCjO90VYQ0wqjSeJ3oOUHoKaF1RuwHUsPP4INXFw
         uyM7/imeP+IZDlL4XESd1IiHLJceev1C+EdRnhha83MRwgD2fbPTzgfy7bfcdWLch18k
         8NNqyo+XF66wcDpikkdcK6bWDn7ymtn4ITiXY=
Received: by 10.100.121.2 with SMTP id t2mr7942151anc.86.1288191156315;
        Wed, 27 Oct 2010 07:52:36 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id r18sm10199919ann.9.2010.10.27.07.52.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:52:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:52:34 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160058>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  128 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 802bd5f..dc82736 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2818,4 +2818,132 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 19/sub/sub
 '
=20
+#
+# case #20.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# core.worktree is ignored -> #16.1
+
+test_expect_success '#20.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 20 20/sub &&
+	cd 20 &&
+	git init &&
+	git config core.worktree non-existent &&
+	mkdir .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_failure '#20.1: at .git' '
+	cat >20/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git
+setup: prefix: (null)
+EOF
+	test_repo 20/.git
+'
+
+test_expect_failure '#20.1: in .git/wt' '
+	cat >20/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt
+'
+
+test_expect_failure '#20.1: in .git/wt/sub' '
+	cat >20/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt/sub
+'
+
+#
+# case #20.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree is ignored -> #16.2
+
+test_expect_success '#20.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/20/.git/config" core.bare true
+'
+
+test_expect_success '#20.2: at .git' '
+	cat >20/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git
+setup: prefix: (null)
+EOF
+	test_repo 20/.git
+'
+
+test_expect_success '#20.2: in .git/wt' '
+	cat >20/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt
+'
+
+test_expect_success '#20.2: in .git/wt/sub' '
+	cat >20/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt/sub
+'
+
+test_expect_success '#20.2: at root' '
+	cat >20/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20
+setup: prefix: (null)
+EOF
+	test_repo 20
+'
+
+test_expect_failure '#20.2: in subdir' '
+	cat >20/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/sub
+setup: prefix: (null)
+EOF
+	test_repo 20/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
