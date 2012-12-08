From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 7/8] t9402: Rename check.cvsCount and check.list
Date: Sat, 8 Dec 2012 22:35:39 +0100
Message-ID: <201212082235.40520.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, mmogilvi_git@miniinfo.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 22:36:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThS42-0002Nl-Va
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 22:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206Ab2LHVfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2012 16:35:47 -0500
Received: from mout.web.de ([212.227.15.3]:62585 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758189Ab2LHVfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2012 16:35:46 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MKa2F-1ThjJG1Fv5-00246S; Sat, 08 Dec 2012 22:35:45 +0100
X-Provags-ID: V02:K0:gXjul9tTaV1PR89M5eHke6m4repILClcPDR4gCF7CCk
 wRJoY9+CI8bpSSaZA4yTswfi+cjo8+rPRhjYLCKbPyiCL78qke
 AkRbNJosoOWjwtD+K7f5QH8garaGvjFHIiDp6EZPAn7ZHhaqXL
 MlBKjcRjdZTnvhj+kQvJDBlWt7yYJv1iI998PXo2TKHOLJCNsc
 ekI4KRNXgKCYRoiOgPeig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211222>

Checking and comparing the number of line in check.list and check.cvsCo=
unt
had been replaced by comparing both files line by line.
Rename the filenames to make clear which is expected and which is actua=
l:
check.list    -> list.expected
check.cvsCount-> list.actual

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9402-git-cvsserver-refs.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs=
=2Esh
index fadc80a..8dc4848 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -10,7 +10,7 @@ tags, branches and other git refspecs'
 #########
=20
 check_start_tree() {
-    rm -f "$WORKDIR/check.list"
+    rm -f "$WORKDIR/list.expected"
     echo "start $1" >>"${WORKDIR}/check.log"
 }
=20
@@ -23,22 +23,22 @@ check_file() {
     test_cmp "$WORKDIR/check.got" "$sandbox/$file"
     stat=3D$?
     echo "check_file $sandbox $file $ver : $stat" >>"$WORKDIR/check.lo=
g"
-    echo "$file" >>"$WORKDIR/check.list"
+    echo "$file" >>"$WORKDIR/list.expected"
     return $stat
 }
=20
 check_end_tree() {
     sandbox=3D"$1" &&
-    find "$sandbox" -name CVS -prune -o -type f -print >"$WORKDIR/chec=
k.cvsCount" &&
-		sort <"$WORKDIR/check.list" >expected &&
-		sort <"$WORKDIR/check.cvsCount" | sed -e "s%cvswork/%%" >actual &&
+    find "$sandbox" -name CVS -prune -o -type f -print >"$WORKDIR/list=
=2Eactual" &&
+		sort <"$WORKDIR/list.expected" >expected &&
+		sort <"$WORKDIR/list.actual" | sed -e "s%cvswork/%%" >actual &&
     test_cmp expected actual &&
 		rm expected actual
 }
=20
 check_end_full_tree() {
     sandbox=3D"$1" &&
-    sort <"$WORKDIR/check.list" >expected &&
+    sort <"$WORKDIR/list.expected" >expected &&
     find "$sandbox" -name CVS -prune -o -type f -print | sed -e "s%$sa=
ndbox/%%" | sort >act1 &&
 		test_cmp expected act1 &&
     git ls-tree --name-only -r "$2" | sort >act2 &&
--=20
1.8.0.197.g5a90748
