From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 4/5] test-hg-hg-git.sh: do not use export X=Y
Date: Fri, 26 Apr 2013 11:17:43 +0200
Message-ID: <201304261117.44336.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 11:18:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVen0-0008ND-67
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 11:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193Ab3DZJRv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 05:17:51 -0400
Received: from mout.web.de ([212.227.17.11]:59199 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938Ab3DZJRu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 05:17:50 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MQNzw-1U482L04I0-00TkDo for <git@vger.kernel.org>; Fri,
 26 Apr 2013 11:17:49 +0200
X-Provags-ID: V02:K0:odbBnO8Dtn9XXetVP9LMH5MG6e856bUIuBh042/xSOk
 qWp1nYNvHRbdIbnt2L1F7OUh+BB9jZTBAa67MA+pqT8MBWcsXK
 J1Pdbu/EKaM3LP9DV8KHbqsyKA43rQzG+HNWnjSstH1GPs4UVa
 TA6HEymIcGN7+Mjcy6KRBAcWD0P3dA4DxWN6usKFwPD5dM+Ob7
 8vVGdCUPuyffSXSZjQ+8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222517>

The shell syntax "export X=3DY" is not understood by all shells.
Split the non portable line into separate lines like this:
X=3DY
export X

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 contrib/remote-helpers/test-hg-hg-git.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-=
helpers/test-hg-hg-git.sh
index 253e65a..8440341 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -103,10 +103,11 @@ setup () {
 	git config --global receive.denycurrentbranch warn
 	git config --global remote-hg.hg-git-compat true
=20
-	export HGEDITOR=3D/usr/bin/true
+	HGEDITOR=3D/usr/bin/true
=20
-	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
-	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
+	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+	export HGEDITOR GIT_AUTHOR_DATE GIT_COMMITTER_DATE
 }
=20
 setup
@@ -296,7 +297,8 @@ test_expect_success 'encoding' '
 	git add alpha &&
 	git commit -m "add =C3=A4lph=C3=A0" &&
=20
-	export GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
+	GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
+	export GIT_AUTHOR_NAME &&
 	echo beta > beta &&
 	git add beta &&
 	git commit -m "add beta" &&
--=20
1.8.2.1.614.g66d7af5
