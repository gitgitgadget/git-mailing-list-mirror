From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 2/5] t9501: do not use export X=Y
Date: Fri, 26 Apr 2013 11:18:07 +0200
Message-ID: <201304261118.07762.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 11:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVenK-0000LI-1w
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 11:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758901Ab3DZJSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 05:18:14 -0400
Received: from mout.web.de ([212.227.17.11]:50911 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758863Ab3DZJSN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 05:18:13 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LcPhu-1Uwlso07tu-00k8rF for <git@vger.kernel.org>; Fri,
 26 Apr 2013 11:18:12 +0200
X-Provags-ID: V02:K0:0iWMbtr5MMSl5JiOQ1WT4PUeEieOpH7SNRyKolURNDc
 TE1b7NsCPWL5uLJ8cVIxX86mfpBrzAt9veynIwoQ5X8Ggg+90X
 0mUhjeKuJ3RF4OpUeAIORVOyn49VNhBspBwTlPP13RIjfxtXwD
 xcniIWyZz464qMx5Y1nG0PqjVlA2vARWdljoKUnX6igGgRrc0T
 z3Wo9Eh9zjRDUaNcP1BZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222519>

The shell syntax "export X=3DY" is not understood by all shells.
Split the non portable line into separate lines like this:
X=3DY
export X

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9501-gitweb-standalone-http-status.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-=
standalone-http-status.sh
index ef86948..d3a5bac 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -130,7 +130,8 @@ test_expect_success DATE_PARSER 'modification: feed=
 last-modified' '
 test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: feed if-modified-since =
(modified)' '
-	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
 	grep "Status: 200 OK" gitweb.headers
@@ -138,7 +139,8 @@ test_expect_success DATE_PARSER 'modification: feed=
 if-modified-since (modified)
 test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: feed if-modified-since =
(unmodified)' '
-	export HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
 	grep "Status: 304 Not Modified" gitweb.headers
@@ -153,7 +155,8 @@ test_expect_success DATE_PARSER 'modification: snap=
shot last-modified' '
 test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: snapshot if-modified-si=
nce (modified)' '
-	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
 	grep "Status: 200 OK" gitweb.headers
@@ -161,7 +164,8 @@ test_expect_success DATE_PARSER 'modification: snap=
shot if-modified-since (modif
 test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: snapshot if-modified-si=
nce (unmodified)' '
-	export HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
 	grep "Status: 304 Not Modified" gitweb.headers
@@ -170,7 +174,8 @@ test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: tree snapshot' '
 	ID=3D`git rev-parse --verify HEAD^{tree}` &&
-	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3D$ID;sf=3Dtgz" &&
 	grep "Status: 200 OK" gitweb.headers &&
--=20
1.8.2.1.614.g66d7af5
