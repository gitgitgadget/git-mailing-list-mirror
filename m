From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Test :/string form for checkout
Date: Sat, 2 Feb 2008 04:37:01 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802020435560.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 10:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLEod-0003hH-0s
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 10:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbYBBJhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 04:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758188AbYBBJhF
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 04:37:05 -0500
Received: from iabervon.org ([66.92.72.58]:49609 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbYBBJhD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 04:37:03 -0500
Received: (qmail 29807 invoked by uid 1000); 2 Feb 2008 09:37:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Feb 2008 09:37:01 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72239>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Here it is as a case in the test suite.

 t/t7201-co.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 73d8a00..dbf1ace 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -214,6 +214,22 @@ test_expect_success 'checkout to detach HEAD with branchname^' '
 	fi
 '
 
+test_expect_success 'checkout to detach HEAD with :/message' '
+
+	git checkout -f master && git clean -f &&
+	git checkout ":/Initial" &&
+	H=$(git rev-parse --verify HEAD) &&
+	M=$(git show-ref -s --verify refs/heads/master) &&
+	test "z$H" = "z$M" &&
+	if git symbolic-ref HEAD >/dev/null 2>&1
+	then
+		echo "OOPS, HEAD is still symbolic???"
+		false
+	else
+		: happy
+	fi
+'
+
 test_expect_success 'checkout to detach HEAD with HEAD^0' '
 
 	git checkout -f master && git clean -f &&
-- 
1.5.4
