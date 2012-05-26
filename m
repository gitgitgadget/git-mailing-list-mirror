From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t7403-*.sh: Avoid use of the nonportable '==' operator
Date: Sat, 26 May 2012 17:51:23 +0100
Message-ID: <4FC10A0B.5080407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Sat May 26 19:53:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYLBY-00017i-U4
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 19:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab2EZRxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 13:53:48 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:54474 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353Ab2EZRxr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2012 13:53:47 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SYLBR-0007Fn-Xm; Sat, 26 May 2012 17:53:46 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198567>


Some shells, including dash, do not support using the '==' string
equality operator. This results in the failure of tests 7-12 with
'test' complaining of an "unexpected operator".

In order to suppress the errors, we replace the '==' operator with
'=', which must be supported by any POSIX shell.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jon,

If you need to re-roll your patches from the 'js/submodule-relative'
branch (commits 3f4542e and efa4c90), could you please squash this
fix into them.

Thanks!

ATB,
Ramsay Jones

 t/t7403-submodule-sync.sh |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 583fe21..3d85739 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -93,7 +93,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form foo' '
 	 git remote set-url origin foo
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "../submodule"
+	 test "$(git config remote.origin.url)" = "../submodule"
 	)
 	)
 '
@@ -103,7 +103,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form foo/bar
 	 git remote set-url origin foo/bar
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "../foo/submodule"
+	 test "$(git config remote.origin.url)" = "../foo/submodule"
 	)
 	)
 '
@@ -113,7 +113,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ./foo'
 	 git remote set-url origin ./foo
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "../submodule"
+	 test "$(git config remote.origin.url)" = "../submodule"
 	)
 	)
 '
@@ -123,7 +123,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ./foo/b
 	 git remote set-url origin ./foo/bar
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "../foo/submodule"
+	 test "$(git config remote.origin.url)" = "../foo/submodule"
 	)
 	)
 '
@@ -133,7 +133,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ../foo'
 	 git remote set-url origin ../foo
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "../../submodule"
+	 test "$(git config remote.origin.url)" = "../../submodule"
 	)
 	)
 '
@@ -143,7 +143,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ../foo/
 	 git remote set-url origin ../foo/bar
 	 git submodule sync &&
 	(cd submodule &&
-	 test "$(git config remote.origin.url)" == "../../foo/submodule"
+	 test "$(git config remote.origin.url)" = "../../foo/submodule"
 	)
 	)
 '
-- 
1.7.10
