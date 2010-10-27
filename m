From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/34] t1510: setup case #18
Date: Wed, 27 Oct 2010 21:49:24 +0700
Message-ID: <1288190977-30875-22-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Mn-0007lz-Mc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760855Ab0J0OwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:52:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38515 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681Ab0J0OwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:52:21 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so427157gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=aBr8gmg/yVyNZZEbam/zMTTFd0fZRQ4XzMTmle3D9ZE=;
        b=vEdZrFXJSbqClZpye1GZ/ZjdS1WDSBba5QIkR4XEd1YmChLTM81RWPkaUccc5PzSyV
         mnEGI6DI/F0ixlH6isi3pvsUXv4HOVxcPrzQaOUxiJ+ogaalgVjUoSwQCpQw8HkN76Mm
         G8cSVvmU+IJqhiklVmDQ4vzb2KoP58B402+Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kTBHnUj69/aoibBWOQylaKqPd6qndFwN+4z6Do217THBN8Y4l2fZrgJIehS3YRG6Ui
         9SBbi3ZjC4xTy2WHlhhz9v8uWmavzIhGmjxC83/KrWUXanL8jcTzcOrij2/QjFEL2Ah1
         60YgWvvZRRaxOJHC2uf14Y8fxVmxYPUEI7mhs=
Received: by 10.91.209.14 with SMTP id l14mr1035763agq.107.1288191141566;
        Wed, 27 Oct 2010 07:52:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id y21sm6443385yhc.14.2010.10.27.07.52.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:52:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:52:19 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160056>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   71 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index b015f91..0d32a6d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2481,4 +2481,75 @@ EOF
 	test_repo 17/sub
 '
=20
+#
+# case #18
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+#  - no worktree (rule #8)
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set to $GIT_DIR
+#  - cwd can't be outside worktree
+
+test_expect_success '#18: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 18 18/sub &&
+	cd 18 &&
+	git init &&
+	mkdir .git/wt .git/wt/sub &&
+	git config core.bare true &&
+	cd ..
+'
+
+test_expect_success '#18: (rel) at root' '
+	cat >18/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18
+setup: prefix: (null)
+EOF
+	 GIT_DIR=3D.git test_repo 18
+'
+
+test_expect_success '#18: at root' '
+	cat >18/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/18/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18
+setup: prefix: (null)
+EOF
+	 GIT_DIR=3D"$TRASH_DIRECTORY/18/.git" test_repo 18
+'
+
+test_expect_success '#18: (rel) in subdir' '
+	cat >18/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../.git test_repo 18/sub
+'
+
+test_expect_success '#18: in subdir' '
+	cat >18/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/18/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/18/.git" test_repo 18/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
