From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 056/144] t5302-pack-index.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:01 -0700
Message-ID: <1395735989-3396-57-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiG-0007wX-Fc
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbaCYI1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:51 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57621 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbaCYI1k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:40 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so129013pab.18
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EIMGQRMLGNBC0NZmiN+OpdhxQW8dry4bQqnXEtlZj8k=;
        b=F578Yj4ueJqC8g5GSYYZcQ5O+v7smEyFk2kcIL8SYGtCNydnma7AckBQMmbT76Ki38
         wcRupKVZfS2Ktjs+KVkq9k+WYY9fgY7dEjuxLxftkEaTOWOHGFlSpmXD/mFJj8flQ25L
         M2Vz5UR1SgKrXYhAtZDHGz1YI9BCxo7VEArDsVS2T5+bPHilmLxJqzeBb0yApbSaCloG
         w0CfMpIQe8pVSb6jbJi5UYDrebjkw4Hh1oVvBslXtJg7IKE36z5lATFbdiodNgnUJumy
         hGatlAgi7aF0axAW8FwF8i6EGoDabTPQ6/j1orCHScQSiL5kFeR/9LlPeDcMKXa+wJ1u
         SzAQ==
X-Received: by 10.66.121.164 with SMTP id ll4mr14233717pab.129.1395736060001;
        Tue, 25 Mar 2014 01:27:40 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244926>

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
 t/t5302-pack-index.sh |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 4bbb718..442ee5c 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -14,21 +14,21 @@ test_expect_success \
      i=3D1 &&
      while test $i -le 100
      do
-         iii=3D`printf '%03i' $i`
+         iii=3D$(printf '%03i' $i)
          test-genrandom "bar" 200 > wide_delta_$iii &&
          test-genrandom "baz $iii" 50 >> wide_delta_$iii &&
          test-genrandom "foo"$i 100 > deep_delta_$iii &&
-         test-genrandom "foo"`expr $i + 1` 100 >> deep_delta_$iii &&
-         test-genrandom "foo"`expr $i + 2` 100 >> deep_delta_$iii &&
+         test-genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+         test-genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
          echo $iii >file_$iii &&
          test-genrandom "$iii" 8192 >>file_$iii &&
          git update-index --add file_$iii deep_delta_$iii wide_delta_$=
iii &&
-         i=3D`expr $i + 1` || return 1
+         i=3D$(expr $i + 1) || return 1
      done &&
      { echo 101 && test-genrandom 100 8192; } >file_101 &&
      git update-index --add file_101 &&
-     tree=3D`git write-tree` &&
-     commit=3D`git commit-tree $tree </dev/null` && {
+     tree=3D$(git write-tree) &&
+     commit=3D$(git commit-tree $tree </dev/null) && {
 	 echo $tree &&
 	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
      } >obj-list &&
@@ -152,10 +152,10 @@ test_expect_success \
     '[index v1] 2) create a stealth corruption in a delta base referen=
ce' \
     '# This test assumes file_101 is a delta smaller than 16 bytes.
      # It should be against file_100 but we substitute its base for fi=
le_099
-     sha1_101=3D`git hash-object file_101` &&
-     sha1_099=3D`git hash-object file_099` &&
-     offs_101=3D`index_obj_offset 1.idx $sha1_101` &&
-     nr_099=3D`index_obj_nr 1.idx $sha1_099` &&
+     sha1_101=3D$(git hash-object file_101) &&
+     sha1_099=3D$(git hash-object file_099) &&
+     offs_101=3D$(index_obj_offset 1.idx $sha1_101) &&
+     nr_099=3D$(index_obj_nr 1.idx $sha1_099) &&
      chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
      dd of=3D".git/objects/pack/pack-${pack1}.pack" seek=3D$(($offs_10=
1 + 1)) \
         if=3D".git/objects/pack/pack-${pack1}.idx" \
@@ -193,10 +193,10 @@ test_expect_success \
     '[index v2] 2) create a stealth corruption in a delta base referen=
ce' \
     '# This test assumes file_101 is a delta smaller than 16 bytes.
      # It should be against file_100 but we substitute its base for fi=
le_099
-     sha1_101=3D`git hash-object file_101` &&
-     sha1_099=3D`git hash-object file_099` &&
-     offs_101=3D`index_obj_offset 1.idx $sha1_101` &&
-     nr_099=3D`index_obj_nr 1.idx $sha1_099` &&
+     sha1_101=3D$(git hash-object file_101) &&
+     sha1_099=3D$(git hash-object file_099) &&
+     offs_101=3D$(index_obj_offset 1.idx $sha1_101) &&
+     nr_099=3D$(index_obj_nr 1.idx $sha1_099) &&
      chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
      dd of=3D".git/objects/pack/pack-${pack1}.pack" seek=3D$(($offs_10=
1 + 1)) \
         if=3D".git/objects/pack/pack-${pack1}.idx" \
@@ -222,11 +222,11 @@ test_expect_success \
     'rm -f .git/objects/pack/* &&
      git index-pack --index-version=3D2 --stdin < "test-1-${pack1}.pac=
k" &&
      git verify-pack ".git/objects/pack/pack-${pack1}.pack" &&
-     obj=3D`git hash-object file_001` &&
-     nr=3D`index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj` &&
+     obj=3D$(git hash-object file_001) &&
+     nr=3D$(index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj) &=
&
      chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
      printf xxxx | dd of=3D".git/objects/pack/pack-${pack1}.idx" conv=3D=
notrunc \
-        bs=3D1 count=3D4 seek=3D$((8 + 256 * 4 + `wc -l <obj-list` * 2=
0 + $nr * 4)) &&
+        bs=3D1 count=3D4 seek=3D$((8 + 256 * 4 + $(wc -l <obj-list) * =
20 + $nr * 4)) &&
      ( while read obj
        do git cat-file -p $obj >/dev/null || exit 1
        done <obj-list ) &&
--=20
1.7.10.4
