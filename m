From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/34] t1510: setup case #17
Date: Wed, 27 Oct 2010 21:49:23 +0700
Message-ID: <1288190977-30875-21-git-send-email-pclouds@gmail.com>
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
	id 1PB7Mn-0007lz-4x
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760833Ab0J0OwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:52:16 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38515 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681Ab0J0OwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:52:14 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so427157gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dkq5lCri67OCccK8N2tjh7cT1SOLrNjzW/WUHgrmfJ0=;
        b=ldWZmeWmCVs7W+nEJUXJrEQGLOg3TbgFuua0SsPbRuSMTrjezRjarppvNPhTBDo0MR
         Y+0hjldOm5QG8ivtkjcZzEJqp9QnSrkSKhGH1Nb0436VChVl7ctwY6SMYU2AOBNn3pG/
         BB7wxrE2F0DchHtKpM9Y5kpxbJg/SK3UrX0yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=m5/VPHg5T4VncvAe+CRYvay1y97nAVDd3CTyolc7KRDeQvsiaMT/97kp+yESTnj8Fc
         FVnFquXbTQrFhom3Oppwad+htC4yFdnKyeR5mvMBpWsNwU/vAz7Im3bDB275uettq04+
         iTi1SR2mEjXWQeI0ITlTeDEOU86aZq9tozfRY=
Received: by 10.151.41.11 with SMTP id t11mr5025112ybj.244.1288191134292;
        Wed, 27 Oct 2010 07:52:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id a32sm7699401yhc.25.2010.10.27.07.52.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:52:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:52:12 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160059>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  128 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index a856d7c..b015f91 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2353,4 +2353,132 @@ EOF
 	test_repo 16/sub
 '
=20
+#
+# case #17.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# GIT_WORK_TREE is ignored -> #16.1 (with warnings perhaps)
+
+test_expect_success '#17.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 17 17/sub &&
+	cd 17 &&
+	git init &&
+	mkdir .git/wt .git/wt/sub &&
+	export GIT_WORK_TREE=3Dnon-existent &&
+	cd ..
+'
+
+test_expect_failure '#17.1: at .git' '
+	cat >17/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git
+setup: prefix: (null)
+EOF
+	test_repo 17/.git
+'
+
+test_expect_failure '#17.1: in .git/wt' '
+	cat >17/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt
+'
+
+test_expect_failure '#17.1: in .git/wt/sub' '
+	cat >17/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt/sub
+'
+
+#
+# case #17.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# GIT_WORK_TREE is ignored -> #16.2 (with warnings perhaps)
+
+test_expect_success '#17.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/17/.git/config" core.bare true
+'
+
+test_expect_failure '#17.2: at .git' '
+	cat >17/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git
+setup: prefix: (null)
+EOF
+	test_repo 17/.git
+'
+
+test_expect_failure '#17.2: in .git/wt' '
+	cat >17/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt
+'
+
+test_expect_failure '#17.2: in .git/wt/sub' '
+	cat >17/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt/sub
+'
+
+test_expect_failure '#17.2: at root' '
+	cat >17/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17
+setup: prefix: (null)
+EOF
+	test_repo 17
+'
+
+test_expect_failure '#17.2: in subdir' '
+	cat >17/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/sub
+setup: prefix: (null)
+EOF
+	test_repo 17/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
