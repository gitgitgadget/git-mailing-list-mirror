From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/34] t1510: setup case #2
Date: Wed, 27 Oct 2010 21:49:08 +0700
Message-ID: <1288190977-30875-6-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:50:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Kj-0006PU-W7
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352Ab0J0OuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:50:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40712 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab0J0OuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:50:19 -0400
Received: by gwj21 with SMTP id 21so424506gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TFFRndWZ1rVmjrvqwK8Sfr8nK/bipttYoWhks5yLGYQ=;
        b=ElEmTeC1ogqPzaKaa1NDtTRaDzyut0cyJWu0yWJNFxJkilTW9mVEZiAF1TKJUdfRCO
         MQng6eoB9uOa9XZaMHgcbTLOIM8qMxTKFOpavnCfI0LAQ0jkKOaSdkjn0PiCzlPNBqfZ
         Uwwx7HBvwaXvoeh1hwvLNLIbX9A2Ge4xIhYh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XmHE5Weyyv5qLdDkb0aLhlpUusbShxbgvIb6mab0LGB22yHpGdTfi29VD9kNLtu8Xq
         PeQYZCztFDhem9qN5z5JNBxwQDdd49M+0KKaslxKtTz2RtgGTEmzznbZP7e+2cjj1K5V
         m7z/fNDNJ3+EF+PoLzsAcFwE+kuqzQuTL6sMY=
Received: by 10.91.55.13 with SMTP id h13mr1052420agk.144.1288191018204;
        Wed, 27 Oct 2010 07:50:18 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id n48sm4768505yha.7.2010.10.27.07.50.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:50:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:50:15 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160045>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   67 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 0ff659a..bf008c6 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -149,4 +149,71 @@ EOF
 	test_repo 1/sub
 '
=20
+#
+# case #2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is at original cwd
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set to $GIT_DIR
+#  - cwd can't be outside worktree
+
+test_expect_success '#2: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 2 2/sub &&
+	cd 2 && git init && cd ..
+'
+
+test_expect_success '#2: at root' '
+	cat >2/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/2/.git
+setup: worktree: $TRASH_DIRECTORY/2
+setup: cwd: $TRASH_DIRECTORY/2
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/2/.git" test_repo 2
+'
+
+test_expect_success '#2: in subdir' '
+	cat >2/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/2/.git
+setup: worktree: $TRASH_DIRECTORY/2/sub
+setup: cwd: $TRASH_DIRECTORY/2/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/2/.git" test_repo 2/sub
+'
+
+test_expect_success '#2: relative GIT_DIR at root' '
+	cat >2/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/2
+setup: cwd: $TRASH_DIRECTORY/2
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git test_repo 2
+'
+
+test_expect_success '#2: relative GIT_DIR in subdir' '
+	cat >2/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: $TRASH_DIRECTORY/2/sub
+setup: cwd: $TRASH_DIRECTORY/2/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../.git test_repo 2/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
