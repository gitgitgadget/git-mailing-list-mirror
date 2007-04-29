From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/2] String comparison is done with "=", not "=="
Date: Sun, 29 Apr 2007 23:09:50 +0200
Message-ID: <20070429210950.4004.86948.stgit@yoghurt>
References: <20070429210713.4004.60467.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 23:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiH06-0001iT-2K
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 23:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbXD2VcE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 29 Apr 2007 17:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbXD2VcE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 17:32:04 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:41755 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161459AbXD2VcA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Apr 2007 17:32:00 -0400
X-Greylist: delayed 1334 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Apr 2007 17:32:00 EDT
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:38715 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <kha@treskal.com>)
	id 1HiGf8-0004cP-3u; Sun, 29 Apr 2007 23:10:30 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HiGeU-000148-GM; Sun, 29 Apr 2007 23:09:50 +0200
In-Reply-To: <20070429210713.4004.60467.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HiGf8-0004cP-3u.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HiGf8-0004cP-3u 72fbd02daf638269217b16299381a947
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45843>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

The "test" builtin in bash accepts both "=3D=3D" and "=3D", but it didn=
't
work with dash as /bin/sh.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1300-uncommit.sh |    8 ++++----
 t/t1800-import.sh   |   26 +++++++++++++-------------
 t/t1900-mail.sh     |    2 +-
 t/t2000-sync.sh     |   14 +++++++-------
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index 497c354..519234e 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -42,7 +42,7 @@ test_expect_success \
 	'Uncommit the patches using names' \
 	'
 	stg uncommit bar foo &&
-	[ "$(stg id foo//top)" =3D=3D "$(stg id bar//bottom)" ] &&
+	[ "$(stg id foo//top)" =3D "$(stg id bar//bottom)" ] &&
 	stg commit
 	'
=20
@@ -50,7 +50,7 @@ test_expect_success \
 	'Uncommit the patches using prefix' \
 	'
 	stg uncommit --number=3D2 foobar &&
-	[ "$(stg id foobar1//top)" =3D=3D "$(stg id foobar2//bottom)" ] &&
+	[ "$(stg id foobar1//top)" =3D "$(stg id foobar2//bottom)" ] &&
 	stg commit
 	'
=20
@@ -58,7 +58,7 @@ test_expect_success \
 	'Uncommit the patches using auto names' \
 	'
 	stg uncommit --number=3D2 &&
-	[ "$(stg id foo-patch//top)" =3D=3D "$(stg id bar-patch//bottom)" ] &=
&
+	[ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &&
 	stg commit
 	'
=20
@@ -67,7 +67,7 @@ test_expect_success \
 	'
 	stg uncommit &&
 	stg uncommit &&
-	[ "$(stg id foo-patch//top)" =3D=3D "$(stg id bar-patch//bottom)" ] &=
&
+	[ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &&
 	stg commit
 	'
 test_done
diff --git a/t/t1800-import.sh b/t/t1800-import.sh
index 0c1baa3..ed10fa8 100755
--- a/t/t1800-import.sh
+++ b/t/t1800-import.sh
@@ -19,7 +19,7 @@ test_expect_success \
     '
     stg import ../t1800-import/git-diff &&
     [ $(git cat-file -p $(stg id) \
-        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
=3D 1 ] &&
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
 1 ] &&
     stg delete ..
     '
=20
@@ -28,7 +28,7 @@ test_expect_success \
     '
     stg import ../t1800-import/gnu-diff &&
     [ $(git cat-file -p $(stg id) \
-        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
=3D 1 ] &&
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
 1 ] &&
     stg delete ..
     '
=20
@@ -37,7 +37,7 @@ test_expect_success \
     '
     stg import ../t1800-import/stg-export &&
     [ $(git cat-file -p $(stg id) \
-        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
=3D 1 ] &&
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
 1 ] &&
     stg delete ..
     '
=20
@@ -46,9 +46,9 @@ test_expect_success \
     '
     stg import -m ../t1800-import/email-8bit &&
     [ $(git cat-file -p $(stg id) \
-        | grep -c "tree 030be42660323ff2a1958f9ee79589a4f3fbee2f") =3D=
=3D 1 ] &&
+        | grep -c "tree 030be42660323ff2a1958f9ee79589a4f3fbee2f") =3D=
 1 ] &&
     [ $(git cat-file -p $(stg id) \
-        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D 1 ] &=
&
     stg delete ..
     '
=20
@@ -57,9 +57,9 @@ test_expect_success \
     '
     stg import -m ../t1800-import/email-qp &&
     [ $(git cat-file -p $(stg id) \
-        | grep -c "tree 030be42660323ff2a1958f9ee79589a4f3fbee2f") =3D=
=3D 1 ] &&
+        | grep -c "tree 030be42660323ff2a1958f9ee79589a4f3fbee2f") =3D=
 1 ] &&
     [ $(git cat-file -p $(stg id) \
-        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D 1 ] &=
&
     stg delete ..
     '
=20
@@ -68,17 +68,17 @@ test_expect_success \
     '
     stg import -M ../t1800-import/email-mbox &&
     [ $(git cat-file -p $(stg id change-1) \
-        | grep -c "tree 401bef82cd9fb403aba18f480a63844416a2e023") =3D=
=3D 1 ] &&
+        | grep -c "tree 401bef82cd9fb403aba18f480a63844416a2e023") =3D=
 1 ] &&
     [ $(git cat-file -p $(stg id change-1) \
-        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D 1 ] &=
&
     [ $(git cat-file -p $(stg id change-2) \
-        | grep -c "tree e49dbce010ec7f441015a8c64bce0b99108af4cc") =3D=
=3D 1 ] &&
+        | grep -c "tree e49dbce010ec7f441015a8c64bce0b99108af4cc") =3D=
 1 ] &&
     [ $(git cat-file -p $(stg id change-2) \
-        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D 1 ] &=
&
     [ $(git cat-file -p $(stg id change-3) \
-        | grep -c "tree 166bbaf27a44aee21ba78c98822a741e6f7d78f5") =3D=
=3D 1 ] &&
+        | grep -c "tree 166bbaf27a44aee21ba78c98822a741e6f7d78f5") =3D=
 1 ] &&
     [ $(git cat-file -p $(stg id change-3) \
-        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D 1 ] &=
&
     stg delete ..
     '
=20
diff --git a/t/t1900-mail.sh b/t/t1900-mail.sh
index 3eed7f8..78050db 100755
--- a/t/t1900-mail.sh
+++ b/t/t1900-mail.sh
@@ -29,7 +29,7 @@ test_expect_success \
     stg pop -a &&
     stg import -M mbox0 &&
     t2=3D$(git cat-file -p $(stg id) | grep ^tree) &&
-    [ "$t1" =3D=3D "$t2" ]
+    [ "$t1" =3D "$t2" ]
     '
=20
 test_done
diff --git a/t/t2000-sync.sh b/t/t2000-sync.sh
index 3dd1cd6..02345bb 100755
--- a/t/t2000-sync.sh
+++ b/t/t2000-sync.sh
@@ -47,7 +47,7 @@ test_expect_success \
     '
     stg sync -b master p2 &&
     test $(stg applied -c) -eq 3 &&
-    test $(cat foo2.txt) =3D=3D "foo2"
+    test $(cat foo2.txt) =3D "foo2"
     '
=20
 test_expect_success \
@@ -55,8 +55,8 @@ test_expect_success \
     '
     stg sync -b master -a &&
     test $(stg applied -c) -eq 3 &&
-    test $(cat foo1.txt) =3D=3D "foo1" &&
-    test $(cat foo2.txt) =3D=3D "foo2"
+    test $(cat foo1.txt) =3D "foo1" &&
+    test $(cat foo2.txt) =3D "foo2"
     '
=20
 test_expect_success \
@@ -64,9 +64,9 @@ test_expect_success \
     '
     stg sync -s patches-master/series -a &&
     test $(stg applied -c) -eq 3 &&
-    test $(cat foo1.txt) =3D=3D "foo1" &&
-    test $(cat foo2.txt) =3D=3D "foo2" &&
-    test $(cat foo3.txt) =3D=3D "foo3"
+    test $(cat foo1.txt) =3D "foo1" &&
+    test $(cat foo2.txt) =3D "foo2" &&
+    test $(cat foo3.txt) =3D "foo3"
     '
=20
 test_expect_success \
@@ -92,7 +92,7 @@ test_expect_success \
     '
     stg sync -b master p2 &&
     test $(stg applied -c) -eq 3 &&
-    test $(cat bar2.txt) =3D=3D "bar2"
+    test $(cat bar2.txt) =3D "bar2"
     '
=20
 test_expect_failure \
