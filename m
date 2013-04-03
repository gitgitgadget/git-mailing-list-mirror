From: =?UTF-8?q?Mihai=20Capot=C4=83?= <mihai@mihaic.ro>
Subject: [PATCH v2] count-objects: output "KiB" instead of "kilobytes"
Date: Wed,  3 Apr 2013 14:48:51 +0200
Message-ID: <1364993331-20199-1-git-send-email-mihai@mihaic.ro>
References: <7vip44a8xl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 03 14:49:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNN88-0003Fa-4t
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 14:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759149Ab3DCMtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 08:49:01 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:53936 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758541Ab3DCMtA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 08:49:00 -0400
Received: by mail-ea0-f178.google.com with SMTP id o10so660162eaj.9
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 05:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=pkyeQQh2LsKmSZMlTs1Rk/GMt/bS26id6XlSfh8Z5VU=;
        b=BqzFz6sVcP9uKnkBYDfylkUfRVEXYpO2Oj/FVAqfZnGvYI/nBnzXy5WQK7cBdcMgLJ
         blUeTNc2j94I5x6muG8H89pSpOxKTQ1u+mK8vD/28zIDIZAmHwB7Nn4qR00HU60ywBq4
         A9LXUjLa1dRFpIa0K6GJCd/3mmzeCYGw+1uWqChIK2Yz8JnDKzZKvXbc6liazSdBqtnE
         iag0gm2RSsWARHJpOvyeyYzPl000alP8nqE1amEYsVsEcddJTM9Q3WcFlnSLVKF8W4Ng
         6EAF+Y2KLtjBcn8Wj5SNfSufDEHwaLpBsPwAnh6aRR3X/f66vGeQvjg4E6oUToFWSC5n
         2zPg==
X-Received: by 10.15.36.135 with SMTP id i7mr3194689eev.34.1364993338930;
        Wed, 03 Apr 2013 05:48:58 -0700 (PDT)
Received: from dutier.st.ewi.tudelft.nl (dutier.st.ewi.tudelft.nl. [130.161.159.51])
        by mx.google.com with ESMTPS id 3sm7700945eej.6.2013.04.03.05.48.57
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Apr 2013 05:48:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vip44a8xl.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQndhFnxmVJa64zNY63IfOXvYXCSjYP3ZSOfB5Ik1jy3i8x32q7txbsYUYE7wRjIpEBvOCez
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219933>

The code uses division by 1024. The master branch count-objects manual =
also
uses "KiB".

Also updated the code that reads count-objects output (t5301, t5700, t7=
408, and
git-cvsimport) and the Git User's Manual.

Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
---
 Documentation/user-manual.txt  |    4 ++--
 builtin/count-objects.c        |    2 +-
 git-cvsimport.perl             |    8 ++++----
 t/t5301-sliding-window.sh      |    4 ++--
 t/t5700-clone-reference.sh     |    4 ++--
 t/t7408-submodule-reference.sh |    4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index e831cc2..b61a09c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3175,7 +3175,7 @@ lot of objects.  Try this on an old project:
=20
 ------------------------------------------------
 $ git count-objects
-6930 objects, 47620 kilobytes
+6930 objects, 47620 KiB
 ------------------------------------------------
=20
 The first number is the number of objects which are kept in
@@ -3215,7 +3215,7 @@ You can verify that the loose objects are gone by=
 looking at the
=20
 ------------------------------------------------
 $ git count-objects
-0 objects, 0 kilobytes
+0 objects, 0 KiB
 ------------------------------------------------
=20
 Although the object files are gone, any commands that refer to those
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 9afaa88..ecc13b0 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -124,7 +124,7 @@ int cmd_count_objects(int argc, const char **argv, =
const char *prefix)
 		printf("garbage: %lu\n", garbage);
 	}
 	else
-		printf("%lu objects, %lu kilobytes\n",
+		printf("%lu objects, %lu KiB\n",
 		       loose, (unsigned long) (loose_size / 1024));
 	return 0;
 }
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 73d367c..de44e33 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1126,12 +1126,12 @@ unless ($opt_P) {
 }
=20
 # The heuristic of repacking every 1024 commits can leave a
-# lot of unpacked data.  If there is more than 1MB worth of
+# lot of unpacked data.  If there is more than 1MiB worth of
 # not-packed objects, repack once more.
 my $line =3D `git count-objects`;
-if ($line =3D~ /^(\d+) objects, (\d+) kilobytes$/) {
-  my ($n_objects, $kb) =3D ($1, $2);
-  1024 < $kb
+if ($line =3D~ /^(\d+) objects, (\d+) KiB$/) {
+  my ($n_objects, $kib) =3D ($1, $2);
+  1024 < $kib
     and system(qw(git repack -a -d));
 }
=20
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 2fc5af6..37931d2 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -20,7 +20,7 @@ test_expect_success \
      commit1=3D`git commit-tree $tree </dev/null` &&
      git update-ref HEAD $commit1 &&
      git repack -a -d &&
-     test "`git count-objects`" =3D "0 objects, 0 kilobytes" &&
+     test "`git count-objects`" =3D "0 objects, 0 KiB" &&
      pack1=3D`ls .git/objects/pack/*.pack` &&
      test -f "$pack1"'
=20
@@ -46,7 +46,7 @@ test_expect_success \
      commit2=3D`git commit-tree $tree -p $commit1 </dev/null` &&
      git update-ref HEAD $commit2 &&
      git repack -a -d &&
-     test "`git count-objects`" =3D "0 objects, 0 kilobytes" &&
+     test "`git count-objects`" =3D "0 objects, 0 KiB" &&
      pack2=3D`ls .git/objects/pack/*.pack` &&
      test -f "$pack2" &&
      test "$pack1" \!=3D "$pack2"'
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index c47d450..e5cfd6a 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -46,7 +46,7 @@ cd "$base_dir"
=20
 test_expect_success 'that reference gets used' \
 'cd C &&
-echo "0 objects, 0 kilobytes" > expected &&
+echo "0 objects, 0 KiB" > expected &&
 git count-objects > current &&
 test_cmp expected current'
=20
@@ -73,7 +73,7 @@ test_expect_success 'pulling from reference' \
 cd "$base_dir"
=20
 test_expect_success 'that reference gets used' \
-'cd D && echo "0 objects, 0 kilobytes" > expected &&
+'cd D && echo "0 objects, 0 KiB" > expected &&
 git count-objects > current &&
 test_cmp expected current'
=20
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-referen=
ce.sh
index b770b2f..aeface6 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -49,7 +49,7 @@ cd "$base_dir"
=20
 test_expect_success 'that reference gets used with add' \
 'cd super/sub &&
-echo "0 objects, 0 kilobytes" > expected &&
+echo "0 objects, 0 KiB" > expected &&
 git count-objects > current &&
 diff expected current'
=20
@@ -72,7 +72,7 @@ cd "$base_dir"
=20
 test_expect_success 'that reference gets used with update' \
 'cd super-clone/sub &&
-echo "0 objects, 0 kilobytes" > expected &&
+echo "0 objects, 0 KiB" > expected &&
 git count-objects > current &&
 diff expected current'
=20
--=20
1.7.9.5
