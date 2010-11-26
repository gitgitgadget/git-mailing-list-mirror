From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/47] t1510: setup case #22
Date: Fri, 26 Nov 2010 22:32:21 +0700
Message-ID: <1290785563-15339-26-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:43:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Sp-00064s-Hn
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab0KZPns convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:43:48 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35877 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0KZPnr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:43:47 -0500
Received: by pwj3 with SMTP id 3so401671pwj.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ByUTXZZ44zGi6CP3qT34/mGaEvg3s6PhbrHKx78GLbM=;
        b=u0MOr5vxJKIWKrDAG50BZjtdIwMM0bfqSHL7s+exqosMqfeTvwDjC/oqxj0lutodhc
         KMTAWVYddch0uINuVio/oN7ReI6DcfPcBP93H5Nds+yZvYkiM+hhArFd/4AcvYmprRwm
         gz/sFsza/itxyndLoMgKM9kJkmbhLy/7jzWGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jHb+FvaS5wqhGQEujPkmAQ2XVfW5L97AgvdM1kJsmRwfKrwWlRGoPl3om5oLSKOvfV
         WpXtQ1pDU8eBBqZY/99KXRcYcYmZ6Tp5FQs0M3kdoxA53ZKtQlMVf+9tZHsqASVZ8xGz
         VPiTj6oXbKnMA5YK7fE+wjQK8ctfC9Y3eovqk=
Received: by 10.142.157.8 with SMTP id f8mr2535316wfe.1.1290786227251;
        Fri, 26 Nov 2010 07:43:47 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id q13sm2685629wfc.5.2010.11.26.07.43.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:43:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:42:26 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162241>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  337 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 337 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 47d6c4b..0027274 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3084,4 +3084,341 @@ EOF
 	test_repo 21/sub
 '
=20
+#
+# case #22.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# bare attribute is ignored
+#
+#  - worktree is at core.worktree
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is at $GIT_DIR
+#  - cwd can be outside worktree
+
+test_expect_success '#22.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 22 &&
+	cd 22 &&
+	git init &&
+	mkdir .git/sub .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D. at .git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git" &&
+	test_repo 22/.git .
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) at .g=
it' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
 &&
+	test_repo 22/.git .
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D. at .git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git" &&
+	test_repo 22/.git "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D.(rel) at root' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
 &&
+	test_repo 22/.git "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D. in .git/su=
b' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git" &&
+	test_repo 22/.git/sub ..
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) in .g=
it/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
 &&
+	test_repo 22/.git/sub/ ..
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D. in .git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git" &&
+	test_repo 22/.git/sub "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D.(rel) in .git/su=
b' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
 &&
+	test_repo 22/.git/sub "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3Dwt at .git' =
'
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git/wt" &&
+	test_repo 22/.git .
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3Dwt(rel) at .=
git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree w=
t &&
+	test_repo 22/.git .
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3Dwt(rel) at .git' =
'
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree w=
t &&
+	test_repo 22/.git "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3Dwt at .git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git/wt" &&
+	test_repo 22/.git "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3Dwt in .git/s=
ub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: ..
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git/wt" &&
+	test_repo 22/.git/sub ..
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3Dwt(rel) in .=
git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: ..
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree w=
t &&
+	test_repo 22/.git/sub ..
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3Dwt(rel) in .git/s=
ub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree w=
t &&
+	test_repo 22/.git/sub "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3Dwt in .git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git/wt" &&
+	test_repo 22/.git/sub "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. at .git' =
'
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22" &&
+	test_repo 22/.git .
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) at .=
git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
=2E &&
+	test_repo 22/.git .
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D..(rel) at .git' =
'
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
=2E &&
+	test_repo 22/.git "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D.. at .git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22" &&
+	test_repo 22/.git "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. in .git/s=
ub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22" &&
+	test_repo 22/.git/sub ..
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) in .=
git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
=2E &&
+	test_repo 22/.git/sub ..
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D..(rel) in .git/s=
ub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
=2E &&
+	test_repo 22/.git/sub "$TRASH_DIRECTORY/22/.git"
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D.. in .git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22" &&
+	test_repo 22/.git/sub "$TRASH_DIRECTORY/22/.git"
+'
+
+#
+# case #22.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree and core.bare conflict, won't fly.
+
+test_expect_success '#22.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.bare true
+'
+
+test_expect_failure '#22.2: at .git' '
+	(
+	cd 22/.git &&
+	GIT_DIR=3D. &&
+	export GIT_DIR &&
+	test_must_fail git symbolic-ref HEAD 2>result &&
+	grep "core.bare and core.worktree do not make sense" result
+	)
+'
+
+test_expect_failure '#22.2: at root' '
+	(
+	cd 22 &&
+	GIT_DIR=3D.git &&
+	export GIT_DIR &&
+	test_must_fail git symbolic-ref HEAD 2>result &&
+	grep "core.bare and core.worktree do not make sense" result
+	)
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
