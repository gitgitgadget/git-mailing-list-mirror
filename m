From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: bisect: "start" accepts one bad and many
 good commits
Date: Thu, 5 Apr 2007 05:33:53 +0200
Message-ID: <20070405053353.f4cebf57.chriscool@tuxfamily.org>
References: <20070404071202.483030b8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 05:25:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZIbe-000498-Cx
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 05:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbXDEDZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 23:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbXDEDZo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 23:25:44 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53168 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161110AbXDEDZm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 23:25:42 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id AFC85B9297;
	Thu,  5 Apr 2007 05:25:41 +0200 (CEST)
In-Reply-To: <20070404071202.483030b8.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43791>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index b2bc58d..5f68ee1 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 The command takes various subcommands, and different options depending
 on the subcommand:
 
- git bisect start [<paths>...]
+ git bisect start [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad <rev>
  git bisect good <rev>
  git bisect reset [<branch>]
@@ -134,15 +134,26 @@ $ git reset --hard HEAD~3		# try 3 revs before what
 Then compile and test the one you chose to try. After that, tell
 bisect what the result was as usual.
 
-Cutting down bisection by giving path parameter to bisect start
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Cutting down bisection by giving more parameters to bisect start
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 You can further cut down the number of trials if you know what part of
 the tree is involved in the problem you are tracking down, by giving
 paths parameters when you say `bisect start`, like this:
 
 ------------
-$ git bisect start arch/i386 include/asm-i386
+$ git bisect start -- arch/i386 include/asm-i386
+------------
+
+If you know beforehand more than one good commits, you can narrow the
+bisect space down without doing the whole tree checkout every time you
+give good commits. You give the bad revision immediately after `start`
+and then you give all the good revisions you have:
+
+------------
+$ git bisect start v2.6.20-rc6 v2.6.20-rc4 v2.6.20-rc1 --
+                   # v2.6.20-rc6 is bad
+                   # v2.6.20-rc4 and v2.6.20-rc1 are good
 ------------
 
 Bisect run
-- 
1.5.1.rc3.21.g02918
