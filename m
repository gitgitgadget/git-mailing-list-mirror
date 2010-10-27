From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/34] t1510: setup case #21
Date: Wed, 27 Oct 2010 21:49:27 +0700
Message-ID: <1288190977-30875-25-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:53:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7NW-0008P7-Sj
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933417Ab0J0Owo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:52:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51568 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933408Ab0J0Owo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:52:44 -0400
Received: by gwj21 with SMTP id 21so426855gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nfK8FXYuvdaivxAR5ofjIa6q2zxy7BZUP4CnctY+xOw=;
        b=kmE6OHPEUxZFNPsuQyK1ckzYVZEkjKgjBSTfYy+QzdwqrJ9oe1n21g8rBoZMND5B9j
         qmfR8AmwYkOjWhjj8R7Jhq6kCjSgkU9FboFP9jPbk+Unu0O6vGNdsOfU+8mVBZnGjutu
         LADzd5Rkp/lthFE+E/5p9Z5Lz9HlpPKmuEd+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aVgFwy5i7Rg7Rwg/2IKud4rMjO8yfO1mx6b5Hhtge/mZ1db2yL1eUGlMZl9u4w0HAN
         1qtwD0J9Gbia3GoXT6ykykw2khEdi0zLR/PNzWtHpl7svkc4AF9nAOpqblKpeB1pEBiA
         ShKZk2S7cAgtjh37YQEJlAsY0XASkNRLmFxp0=
Received: by 10.100.140.14 with SMTP id n14mr4301676and.150.1288191163483;
        Wed, 27 Oct 2010 07:52:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x32sm11922486anx.24.2010.10.27.07.52.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:52:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:52:41 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160064>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  129 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 129 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index dc82736..8e3fffb 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2946,4 +2946,133 @@ EOF
 	test_repo 20/sub
 '
=20
+#
+# case #21.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# GIT_WORK_TREE/core.worktree are ignored -> #20.1
+
+test_expect_success '#21.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 21 21/sub &&
+	cd 21 &&
+	git init &&
+	git config core.worktree non-existent &&
+	export GIT_WORK_TREE=3Dnon-existent-too &&
+	mkdir .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_failure '#21.1: at .git' '
+	cat >21/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git
+setup: prefix: (null)
+EOF
+	test_repo 21/.git
+'
+
+test_expect_failure '#21.1: in .git/wt' '
+	cat >21/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt
+'
+
+test_expect_failure '#21.1: in .git/wt/sub' '
+	cat >21/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt/sub
+'
+
+#
+# case #21.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# GIT_WORK_TREE/core.worktree are ignored -> #20.2
+
+test_expect_success '#21.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/21/.git/config" core.bare true
+'
+
+test_expect_failure '#21.2: at .git' '
+	cat >21/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git
+setup: prefix: (null)
+EOF
+	test_repo 21/.git
+'
+
+test_expect_failure '#21.2: in .git/wt' '
+	cat >21/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt
+'
+
+test_expect_failure '#21.2: in .git/wt/sub' '
+	cat >21/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt/sub
+'
+
+test_expect_failure '#21.2: at root' '
+	cat >21/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21
+setup: prefix: (null)
+EOF
+	test_repo 21
+'
+
+test_expect_failure '#21.2: in subdir' '
+	cat >21/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/sub
+setup: prefix: (null)
+EOF
+	test_repo 21/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
