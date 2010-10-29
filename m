From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/42] t1510: setup case #3
Date: Fri, 29 Oct 2010 13:48:18 +0700
Message-ID: <1288334934-17216-7-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBin6-00061E-BW
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab0J2GuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:50:14 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602Ab0J2GuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:50:11 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=koZy++WRFvotxgapDtVdixYwYiah9YUR66Z6DXTaxAY=;
        b=jPyoV2MMaGi3fc1cFQs0/I4fEiI0U3HMjmm+RpWQIkqPkgoreMo4jKCTltfj9OZlC+
         H8aO6WjAn4pnVVDlbEmwAYmZv+bkjyrtf5n50H5lvRh3/+dihU6lQpsw6LCYfqt2YFn1
         QLFGV4HG/ou08bgU7Gi89LAlms/XoWreX5ZI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RCQR5t0u+R83iC+FmRB++8NzkrvaRpasCFem1DHhnEFi4/eDtbqgfam7mh2+aZDKse
         kivQRSzasxOWDTvQgh4KIW0NtEJ3SQolMUxUxLUvui8m4TQKhljoc0QFZSwkBQPoFk6C
         nWMnt3gqbCdipXg4wLVXRZof6nPYr17EQgqck=
Received: by 10.142.116.15 with SMTP id o15mr1023704wfc.12.1288335010896;
        Thu, 28 Oct 2010 23:50:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e36sm1030890wfj.2.2010.10.28.23.50.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:50:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:50:09 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160274>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  267 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 9b3ec8f..3a163d0 100755
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
