From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Fix some remaining old-style stg id calls
Date: Fri, 25 Jul 2008 02:47:34 +0200
Message-ID: <20080725004430.12440.49829.stgit@yoghurt>
References: <20080713114047.18845.34899.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:48:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMBUD-00055I-UM
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbYGYArq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 20:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753227AbYGYArq
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:47:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1708 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbYGYArq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:47:46 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KMBoc-0005U0-00; Fri, 25 Jul 2008 02:09:50 +0100
In-Reply-To: <20080713114047.18845.34899.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89985>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

You'll want to add this (just squash it into your patch). The calls
were failing, but since both sides produced the empty string on
stdout, the test was happy anyway.

 t/t1300-uncommit.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index a906d13..472baa4 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -42,7 +42,7 @@ test_expect_success \
 	'Uncommit the patches using names' \
 	'
 	stg uncommit bar foo &&
-	[ "$(stg id foo//top)" =3D "$(stg id bar//bottom)" ] &&
+	[ "$(stg id foo)" =3D "$(stg id bar^)" ] &&
 	stg commit --all
 	'
=20
@@ -50,7 +50,7 @@ test_expect_success \
 	'Uncommit the patches using prefix' \
 	'
 	stg uncommit --number=3D2 foobar &&
-	[ "$(stg id foobar1//top)" =3D "$(stg id foobar2//bottom)" ] &&
+	[ "$(stg id foobar1)" =3D "$(stg id foobar2^)" ] &&
 	stg commit --all
 	'
=20
@@ -58,7 +58,7 @@ test_expect_success \
 	'Uncommit the patches using auto names' \
 	'
 	stg uncommit --number=3D2 &&
-	[ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &&
+	[ "$(stg id foo-patch)" =3D "$(stg id bar-patch^)" ] &&
 	stg commit --all
 	'
=20
@@ -67,14 +67,14 @@ test_expect_success \
 	'
 	stg uncommit &&
 	stg uncommit &&
-	[ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &&
+	[ "$(stg id foo-patch)" =3D "$(stg id bar-patch^)" ] &&
 	stg commit --all
 	'
=20
 test_expect_success \
     'Uncommit the patches with --to' '
     stg uncommit --to HEAD^ &&
-    [ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &=
&
+    [ "$(stg id foo-patch)" =3D "$(stg id bar-patch^)" ] &&
     stg commit --all
 '
=20
