From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 054/144] t5300-pack-object.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:59 -0700
Message-ID: <1395735989-3396-55-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:33:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMnU-0005vM-DY
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbaCYIdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:33:18 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38018 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbaCYI1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:37 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so132848pab.6
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FrJUumSRfM2x0FA7JAyI8zyY4fqbGYwhMR3G1V9rtGA=;
        b=ngiQsbnE2L9TudMliAL+MdYY3x/iHuQ5+D10FkPygUWZlB7w4s23wSBBrM+HRXGFHh
         2UNqtob3RDnGhh7vlPWDo1P48sY5raPjc+RcDNkgPl1hQfpzVrBhsPswBahgJFFyfOaO
         lok5cAgaTtbgRLdqVTHI0ZOVIi66SnBT+CD3NuVZLgWYaQ4KV+mBTkTiCi0R5DxUKssX
         KBeqJh3+G1eQ4FM4k9TXFG0Sl9W8wFdk1eE2V7F4ZlX58OazhUe5N4IQT8id/Z6NB9tz
         Gu2W/hl1S8BfE/LptwzLvvVP9QWF1fAMkzw5QLYgmUhNDxbDZlfOHhDS0CGcY0q4Wneu
         tyqg==
X-Received: by 10.68.218.3 with SMTP id pc3mr77763464pbc.71.1395736057523;
        Tue, 25 Mar 2014 01:27:37 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244974>

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
 t/t5300-pack-object.sh |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 20c1961..fc2be63 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -8,7 +8,7 @@ test_description=3D'git pack-object
 '
 . ./test-lib.sh
=20
-TRASH=3D`pwd`
+TRASH=3D$(pwd)
=20
 test_expect_success \
     'setup' \
@@ -20,8 +20,8 @@ test_expect_success \
      test-genrandom "seed b" 2097152 > b_big &&
      git update-index --add a a_big b b_big c &&
      cat c >d && echo foo >>d && git update-index --add d &&
-     tree=3D`git write-tree` &&
-     commit=3D`git commit-tree $tree </dev/null` && {
+     tree=3D$(git write-tree) &&
+     commit=3D$(git commit-tree $tree </dev/null) && {
 	 echo $tree &&
 	 echo $commit &&
 	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
@@ -29,7 +29,7 @@ test_expect_success \
 	 git diff-tree --root -p $commit &&
 	 while read object
 	 do
-	    t=3D`git cat-file -t $object` &&
+	    t=3D$(git cat-file -t $object) &&
 	    git cat-file $t $object || return 1
 	 done <obj-list
      } >expect'
@@ -147,7 +147,7 @@ test_expect_success \
 	 git diff-tree --root -p $commit &&
 	 while read object
 	 do
-	    t=3D`git cat-file -t $object` &&
+	    t=3D$(git cat-file -t $object) &&
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
@@ -162,7 +162,7 @@ test_expect_success \
 	 git diff-tree --root -p $commit &&
 	 while read object
 	 do
-	    t=3D`git cat-file -t $object` &&
+	    t=3D$(git cat-file -t $object) &&
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
@@ -177,7 +177,7 @@ test_expect_success \
 	 git diff-tree --root -p $commit &&
 	 while read object
 	 do
-	    t=3D`git cat-file -t $object` &&
+	    t=3D$(git cat-file -t $object) &&
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
@@ -252,8 +252,8 @@ test_expect_success \
=20
 test_expect_success \
     'verify-pack catches a corrupted sum of the index file itself' \
-    'l=3D`wc -c <test-3.idx` &&
-     l=3D`expr $l - 20` &&
+    'l=3D$(wc -c <test-3.idx) &&
+     l=3D$(expr $l - 20) &&
      cat test-1-${packname_1}.pack >test-3.pack &&
      printf "%20s" "" | dd of=3Dtest-3.idx count=3D20 bs=3D1 conv=3Dno=
trunc seek=3D$l &&
      if git verify-pack test-3.pack
--=20
1.7.10.4
