From: Bernd Ahlers <bernd@ba-net.org>
Subject: [PATCH] Use 'grep -a' to fix some errors with non-GNU grep(1).
Date: Fri, 28 Mar 2008 23:40:11 +0100
Message-ID: <20080328224011.GB5486@dengar.tuneafish.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 00:01:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfNZu-0007FB-Ly
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 00:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbYC1XBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 19:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756003AbYC1XA7
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 19:00:59 -0400
Received: from mail1.bytemine.net ([193.41.144.77]:2923 "EHLO
	mail1.bytemine.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924AbYC1XA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 19:00:59 -0400
X-Greylist: delayed 1235 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Mar 2008 19:00:59 EDT
Received: from [134.106.146.206] (port=58232 helo=dengar.tuneafish.de)
	by mail1.bytemine.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <bernd@ba-net.org>)
	id 1JfNFC-0007QX-EM
	for git@vger.kernel.org; Fri, 28 Mar 2008 23:40:21 +0100
Received: (qmail 26215 invoked by uid 1000); 28 Mar 2008 22:40:11 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78443>

This fixes test errors on OpenBSD.

Signed-off-by: Bernd Ahlers <bernd@ba-net.org>
---
 t/t4019-diff-wserror.sh        |   28 ++++++++++++++--------------
 t/t9200-git-cvsexportcommit.sh |    2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 0d9cbb6..275b41a 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -22,8 +22,8 @@ blue_grep='7;34m' ;# ESC [ 7 ; 3 4 m
 test_expect_success default '
 
 	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	grep -a "$blue_grep" output >error
+	grep -a -v "$blue_grep" output >normal
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -37,8 +37,8 @@ test_expect_success 'without -trail' '
 
 	git config core.whitespace -trail
 	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	grep -a "$blue_grep" output >error
+	grep -a -v "$blue_grep" output >normal
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -53,8 +53,8 @@ test_expect_success 'without -trail (attribute)' '
 	git config --unset core.whitespace
 	echo "F whitespace=-trail" >.gitattributes
 	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	grep -a "$blue_grep" output >error
+	grep -a -v "$blue_grep" output >normal
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -69,8 +69,8 @@ test_expect_success 'without -space' '
 	rm -f .gitattributes
 	git config core.whitespace -space
 	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	grep -a "$blue_grep" output >error
+	grep -a -v "$blue_grep" output >normal
 
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -85,8 +85,8 @@ test_expect_success 'without -space (attribute)' '
 	git config --unset core.whitespace
 	echo "F whitespace=-space" >.gitattributes
 	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	grep -a "$blue_grep" output >error
+	grep -a -v "$blue_grep" output >normal
 
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -101,8 +101,8 @@ test_expect_success 'with indent-non-tab only' '
 	rm -f .gitattributes
 	git config core.whitespace indent,-trailing,-space
 	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	grep -a "$blue_grep" output >error
+	grep -a -v "$blue_grep" output >normal
 
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -117,8 +117,8 @@ test_expect_success 'with indent-non-tab only (attribute)' '
 	git config --unset core.whitespace
 	echo "F whitespace=indent,-trailing,-space" >.gitattributes
 	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	grep -a "$blue_grep" output >error
+	grep -a -v "$blue_grep" output >normal
 
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 42b144b..d3bd48c 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -30,7 +30,7 @@ exit 1
 
 check_entries () {
 	# $1 == directory, $2 == expected
-	grep '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
+	grep -a '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
 	if test -z "$2"
 	then
 		>expected
-- 
1.5.4.5
