From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] tests: remove xargs in favor of --stdin where possible
Date: Thu, 23 Apr 2009 16:31:21 +1000
Message-ID: <1240468281-23815-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 08:33:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwsUe-0000ht-9H
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 08:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZDWGba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 02:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbZDWGba
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 02:31:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:61923 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZDWGb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 02:31:29 -0400
Received: by rv-out-0506.google.com with SMTP id f9so327511rvb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=G55qSFJPWDF0taQfQqvABh18Ij1hwrmjlWZb0YhURwc=;
        b=b+lZlz7Gr9KWEncqWP2zYQcho+joIcAU/wFsgtUSq72lnlPQc1gKyaWON30ExAyWXo
         rbGcBtygF8sLlDJpajUMInjKDbXsXxAmL4PVmk3tKM+s0FUgf6E8Dj/dhqHfdTPEnQAa
         i7hfsPFUGzMRf0Y/8C9xM9whBez3ZhjRtNMcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Pqsz3utw8VT10bXpHR1joZIuhLe33oXJ+tzuYTuVoCqRF1JMww+unHqDjmELRfdXl/
         W7Lu8lW1p0QVR/XCulSzBpDkYXMk1tRfXot4ddrqAQ6Q08kGepBoyHfsMuPrx2Qq+uvh
         y4afPd4V0w2vDZyTPN8WPIOZpyyobGTxtJLws=
Received: by 10.142.217.17 with SMTP id p17mr226485wfg.161.1240468289113;
        Wed, 22 Apr 2009 23:31:29 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id 24sm842376wfc.37.2009.04.22.23.31.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 23:31:28 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 23 Apr 2009 16:31:23 +1000
X-Mailer: git-send-email 1.6.2.2.693.g5a1be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117303>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Patch "Convert to use quiet option when available" reminds me I had a =
similar
 patch to remove (mostly) xargs usage from tests.

 t/t0000-basic.sh            |    2 +-
 t/t3100-ls-tree-restrict.sh |    2 +-
 t/t3101-ls-tree-dirname.sh  |    2 +-
 t/t4112-apply-renames.sh    |    2 +-
 t/t5000-tar-tree.sh         |    4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ca4fc..5c07645 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -142,7 +142,7 @@ fi
=20
 test_expect_success \
     'adding various types of objects with git update-index --add.' \
-    'find path* ! -type d -print | xargs git update-index --add'
+    'find path* ! -type d -print | git update-index --add --stdin'
=20
 # Show them and see that matches what we expect.
 test_expect_success \
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index ee60d03..6e4faf8 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -39,7 +39,7 @@ test_expect_success \
      echo Lo >path2/foo &&
      echo Mi >path2/baz/b &&
      find path? \( -type f -o -type l \) -print |
-     xargs git update-index --add &&
+     git update-index --add --stdin &&
      tree=3D`git write-tree` &&
      echo $tree'
=20
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 51cb4a3..e0bf312 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -35,7 +35,7 @@ test_expect_success \
      echo 111 >path3/1.txt &&
      echo 222 >path3/2.txt &&
      find *.txt path* \( -type f -o -type l \) -print |
-     xargs git update-index --add &&
+     git update-index --add --stdin &&
      tree=3D`git write-tree` &&
      echo $tree'
=20
diff --git a/t/t4112-apply-renames.sh b/t/t4112-apply-renames.sh
index f9ad183..6e56fa6 100755
--- a/t/t4112-apply-renames.sh
+++ b/t/t4112-apply-renames.sh
@@ -135,7 +135,7 @@ copy to klibc/arch/README
 +add a few lines at the end of it.
 EOF
=20
-find klibc -type f -print | xargs git update-index --add --
+find klibc -type f -print | git update-index --add --stdin
=20
 test_expect_success 'check rename/copy patch' 'git apply --check patch=
'
=20
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index abb41b0..f036988 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -54,8 +54,8 @@ test_expect_success \
=20
 test_expect_success \
     'add files to repository' \
-    'find a -type f | xargs git update-index --add &&
-     find a -type l | xargs git update-index --add &&
+    'find a -type f | git update-index --add --stdin &&
+     find a -type l | git update-index --add --stdin &&
      treeid=3D`git write-tree` &&
      echo $treeid >treeid &&
      git update-ref HEAD $(TZ=3DGMT GIT_COMMITTER_DATE=3D"2005-05-27 2=
2:00:00" \
--=20
1.6.2.2.693.g5a1be
