From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 018/144] t1001-read-tree-m-2way.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:23 -0700
Message-ID: <1395735989-3396-19-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhY-00079D-K3
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbaCYI1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:08 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:48893 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694AbaCYI1A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:00 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so122973pab.40
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KTOzb/+HWaf7TQM+9WQO4Jf6xFPu6NNmjot49RGniIY=;
        b=GsS59adkAQ5TFLYhBs2wwX3jtYdJ83UEQEdBnPDrKg6S6c1gHayu4l4i0oAIfBvXZJ
         1c/PwFD+caSBnImew6gDunAifT/dlK1OflG5+TnqoqMB+ybNncOL9n2fFAF5b7S6Wev7
         rtGetCTANh+CSdYMXyG48Bv2x+lc2PogO/9j68RoLX8V4mQ741VyHlwHQv/tpfg6YNGp
         wM3uS9q+79Uv9HhS8oo7ohFtbKL2mQr5Urc4l7MNSc4SMmYNfftMb89eUX1ogx085BKa
         WHgErm0u47g6BNMwTKWUXCkt+82sUgPFrsTNOsPZft94dP32eMspQn3GwoAnmmBFuo3H
         a03A==
X-Received: by 10.66.156.137 with SMTP id we9mr77889464pab.30.1395736019937;
        Tue, 25 Mar 2014 01:26:59 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244916>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t1001-read-tree-m-2way.sh |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index acaab07..f0d8eb9 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -36,7 +36,7 @@ compare_change () {
 }
=20
 check_cache_at () {
-	clean_if_empty=3D`git diff-files -- "$1"`
+	clean_if_empty=3D$(git diff-files -- "$1")
 	case "$clean_if_empty" in
 	'')  echo "$1: clean" ;;
 	?*)  echo "$1: dirty" ;;
@@ -68,14 +68,14 @@ test_expect_success \
      echo rezrov >rezrov &&
      echo yomin >yomin &&
      git update-index --add nitfol bozbar rezrov &&
-     treeH=3D`git write-tree` &&
+     treeH=3D$(git write-tree) &&
      echo treeH $treeH &&
      git ls-tree $treeH &&
=20
      cat bozbar-new >bozbar &&
      git update-index --add frotz bozbar --force-remove rezrov &&
      git ls-files --stage >M.out &&
-     treeM=3D`git write-tree` &&
+     treeM=3D$(git write-tree) &&
      echo treeM $treeM &&
      git ls-tree $treeM &&
      git diff-tree $treeH $treeM'
@@ -315,7 +315,7 @@ test_expect_success \
     'rm -f .git/index &&
      echo DF >DF &&
      git update-index --add DF &&
-     treeDF=3D`git write-tree` &&
+     treeDF=3D$(git write-tree) &&
      echo treeDF $treeDF &&
      git ls-tree $treeDF &&
=20
@@ -323,7 +323,7 @@ test_expect_success \
      mkdir DF &&
      echo DF/DF >DF/DF &&
      git update-index --add --remove DF DF/DF &&
-     treeDFDF=3D`git write-tree` &&
+     treeDFDF=3D$(git write-tree) &&
      echo treeDFDF $treeDFDF &&
      git ls-tree $treeDFDF &&
      git ls-files --stage >DFDF.out'
@@ -345,7 +345,7 @@ test_expect_success \
     'rm -f .git/index &&
      : >a &&
      git update-index --add a &&
-     treeM=3D`git write-tree` &&
+     treeM=3D$(git write-tree) &&
      echo treeM $treeM &&
      git ls-tree $treeM &&
      git ls-files --stage >treeM.out &&
@@ -354,7 +354,7 @@ test_expect_success \
      git update-index --remove a &&
      mkdir a &&
      : >a/b &&
-     treeH=3D`git write-tree` &&
+     treeH=3D$(git write-tree) &&
      echo treeH $treeH &&
      git ls-tree $treeH'
=20
@@ -372,7 +372,7 @@ test_expect_success \
      mkdir c &&
      : >c/d &&
      git update-index --add a c/d &&
-     treeM=3D`git write-tree` &&
+     treeM=3D$(git write-tree) &&
      echo treeM $treeM &&
      git ls-tree $treeM &&
      git ls-files --stage >treeM.out &&
@@ -381,7 +381,7 @@ test_expect_success \
      mkdir a &&
      : >a/b &&
      git update-index --add --remove a a/b &&
-     treeH=3D`git write-tree` &&
+     treeH=3D$(git write-tree) &&
      echo treeH $treeH &&
      git ls-tree $treeH'
=20
--=20
1.7.10.4
