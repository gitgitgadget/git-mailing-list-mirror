From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/34] t1510: setup case #6
Date: Wed, 27 Oct 2010 21:49:12 +0700
Message-ID: <1288190977-30875-10-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:51:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Ln-000797-Pq
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454Ab0J0Ouw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:50:52 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60395 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab0J0Out (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:50:49 -0400
Received: by mail-gy0-f174.google.com with SMTP id 4so415888gyg.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=baaWKE2dKbMfO9pufiaA2elMvt4I0WONV8NKnsnQyk4=;
        b=ecUXi8uc7RyhfWZ3PYE4NKIbCtMOH9B59GO7Fl+uj60T5LhCaG0H2HmA0ysWduoOvi
         RfUixw7v5iPf+e8bp324PVySGOImshwHrYSGLyGwwP0N2AfMlhJzWTm3/ysrW0mF3hkW
         +BktJ8pThRGD7fPblzSogJmy4rJdzX1VaZz08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=E8eo5+peg6H4hl5rdcDemsY4KhWi/98cJCwrsQK7w4FgGmJ/2z5RqSsf7MOjBE5YaE
         w5QscImrNczKR1VnX5LCdIyc904QuH0m/HWTg22v57q3KGANXVH97di4ErSeP5jiPNYC
         dukJ14bIM3HBmRIBzdGizWcPD6K4uAnviwS4c=
Received: by 10.100.13.19 with SMTP id 19mr4438247anm.129.1288191048689;
        Wed, 27 Oct 2010 07:50:48 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id 25sm11921046anq.8.2010.10.27.07.50.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:50:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:50:45 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160049>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  291 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 291 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 3d0498a..6e69ad7 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -576,4 +576,295 @@ EOF
 	test_repo 5/sub
 '
=20
+#
+# case #6
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is at core.worktree
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is at $GIT_DIR
+#  - cwd can be outside worktree
+
+test_expect_success '#6: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 6 6/sub 6/sub/sub 6.wt 6.wt/sub 6/wt 6/wt/sub &&
+	cd 6 && git init && cd ..
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D.. at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6" &&
+	GIT_DIR=3D.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D..(rel) at root=
' '
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D.. at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D..(rel) at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D.. in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6" &&
+	GIT_DIR=3D../../.git test_repo 6/sub/sub
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D..(rel) in subd=
ir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D../../.git test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D.. in subdir' '
+	cat >6/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6/sub
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D..(rel) in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../wt at root' =
'
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6/wt" &&
+	GIT_DIR=3D.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../wt(rel) at r=
oot' '
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/wt &&
+	GIT_DIR=3D.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../wt(rel) at root' =
'
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/wt &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../wt at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6/wt" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../wt in subdir=
' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6/wt" &&
+	GIT_DIR=3D../../.git test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../wt(rel) in s=
ubdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/wt &&
+	GIT_DIR=3D../../.git test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../wt(rel) in subdir=
' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/wt &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../wt in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6/wt" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../.. at root' =
'
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../..(rel) at r=
oot' '
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/../ &&
+	GIT_DIR=3D.git test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../..(rel) at root' =
'
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/../ &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../.. at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../.. in subdir=
' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D../../.git test_repo 6/sub/sub
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../..(rel) in s=
ubdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/.. &&
+	GIT_DIR=3D../../.git test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../..(rel) in subdir=
' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/.. &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../.. in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
