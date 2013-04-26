From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 3/5] test-hg-bidi.sh: do not use export X=Y
Date: Fri, 26 Apr 2013 11:17:56 +0200
Message-ID: <201304261117.57010.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 11:18:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVen9-0000A4-VW
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 11:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758733Ab3DZJSD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 05:18:03 -0400
Received: from mout.web.de ([212.227.15.3]:52581 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758201Ab3DZJSC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 05:18:02 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MTQ07-1U62lr3CYJ-00SMf3 for <git@vger.kernel.org>; Fri,
 26 Apr 2013 11:18:00 +0200
X-Provags-ID: V02:K0:Ewg8GRgL3u7MVXUd9J7tzbx4/AFZfQnsBHAsDa6xA7/
 d7pQZ2EbAc5ifK5I+2SQpzvPvwISwnwiE5vNlTrT52l3kTqIMA
 7qId1Obaq/spElCR2UmaUv1YA2KKf6CpVZQt3BzyyzJCyqCDfo
 Um/iT6lsnTr6tmdlv4l6QK2Bn4z8qcp1/q1WaxEUU25rDEHk2Z
 6aQEUy34tqvrgqJPi/W4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222518>

The shell syntax "export X=3DY A=3DB" is not understood by all shells.
Split the non portable line into separate lines like this:
A=3DB
X=3DY
export A X

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 contrib/remote-helpers/test-hg-bidi.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-he=
lpers/test-hg-bidi.sh
index f368953..f569697 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -68,10 +68,10 @@ setup () {
 	) >> "$HOME"/.hgrc &&
 	git config --global remote-hg.hg-git-compat true
=20
-	export HGEDITOR=3D/usr/bin/true
-
-	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
-	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+	HGEDITOR=3D/usr/bin/true
+	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
+	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+	export HGEDITOR GIT_AUTHOR_DATE GIT_COMMITTER_DATE
 }
=20
 setup
@@ -88,7 +88,8 @@ test_expect_success 'encoding' '
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
