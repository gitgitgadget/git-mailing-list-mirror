From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/42] t1510: setup case #6
Date: Fri, 29 Oct 2010 13:48:21 +0700
Message-ID: <1288334934-17216-10-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:50:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBinY-0006Do-Bi
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab0J2Gue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:50:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab0J2Gud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:50:33 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ohygy/HHk2SF06nnX0hAWtblI6NZPVlDYwnS0JblTAA=;
        b=nl7xbV3BzWlXjSxLAp3VrsrfmQu3NyR3EGCF0wlu7ruGqkq1x7P7rXRbxVit0KIlSc
         v9Zf9z16D0uP1J775SQaWUe/reZ6nO/ftQIO/DN70AvfXWT/w57YUdBItBpmP/6T/35Q
         Hkzvv5V+T4NeQs4d9+VZuirz6vL98QRbuhuhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b5K+49q7IgC93m8zKfyUgjtR8C4RQ7g+ASS/XGtv3ikBom/9/h13yaYClOWWzdQG3g
         v8DM1hQcZueOcqaeeIyf4vNErSUftFYNoRjb37rGtetSX4m9eY2XTV4ciFZG5FPT0BIy
         zYLd/C1HeSLbEuX7sRGUMOX7NN3LWPc2oHLcg=
Received: by 10.142.12.9 with SMTP id 9mr973837wfl.251.1288335032885;
        Thu, 28 Oct 2010 23:50:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q13sm1022982wfc.17.2010.10.28.23.50.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:50:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:50:31 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160277>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  291 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 291 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index a216849..5957c45 100755
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
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../.. at root' =
'
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D.git test_repo 6
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../..(rel) at r=
oot' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
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
