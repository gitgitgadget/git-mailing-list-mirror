From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/34] t1510: setup case #9
Date: Wed, 27 Oct 2010 21:49:15 +0700
Message-ID: <1288190977-30875-13-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Lq-000797-1e
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933536Ab0J0OvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:51:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44977 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933455Ab0J0OvN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:51:13 -0400
Received: by yxk8 with SMTP id 8so66060yxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EnrBLGN3KK9LpKfVLbwQMemF+ivJW491j7JwBqNB0lo=;
        b=Y9hxyn8tLRbiUrKCYG8gW1KzRY6Zoymrv8kCXo5DfVGWWku1Y9CcS/g+a6nEsDK50C
         0ByY5A2sIGZPK/20HFMcBrZ1dFgPDUqgA659Z+38NuA7QeaO0q9BI+ixUSPnBK6Hb3eJ
         8CqfFUA2HXmo9L7d7hCrQdKPwxoOR/sZbgf+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KhDVInXdktX8gXrrLIyTghcyYwXRKiemA4lM3n0d+/Fk6wist9CyBm+fTxY2Xv9L5c
         Of7XGgRYeyp9JXHFrQC/j9CuxPkYWd2pbgaJhBqR432rFwRDrT20ZMqSwAqPpusHHNAv
         DkBqlr45ehf6iA38YYpuvyPunI3mN1V3FoY5E=
Received: by 10.101.51.5 with SMTP id d5mr4929217ank.110.1288191072084;
        Wed, 27 Oct 2010 07:51:12 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id u3sm11924518ani.39.2010.10.27.07.51.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:51:11 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:51:09 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160055>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 5ca9f4a..1406a8d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1180,4 +1180,51 @@ EOF
 	test_repo 8/sub
 '
=20
+#
+# case #9
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #1 except that git_dir is set by .git file
+
+test_expect_success '#9: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 9 9/sub 9.wt 9.wt/sub 9/wt 9/wt/sub &&
+	cd 9 &&
+	git init &&
+	mv .git ../9.git &&
+	echo gitdir: ../9.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#9: at root' '
+	cat >9/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/9.git
+setup: worktree: $TRASH_DIRECTORY/9
+setup: cwd: $TRASH_DIRECTORY/9
+setup: prefix: (null)
+EOF
+	GIT_WORK_TREE=3Dnon-existent test_repo 9
+'
+
+test_expect_failure '#9: in subdir' '
+	cat >9/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/9.git
+setup: worktree: $TRASH_DIRECTORY/9
+setup: cwd: $TRASH_DIRECTORY/9
+setup: prefix: sub/
+EOF
+	GIT_WORK_TREE=3Dnon-existent test_repo 9/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
