From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix suggested branch creation command when detaching head
Date: Fri, 26 Jan 2007 11:50:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701261120020.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 17:59:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAUQP-0004sx-4M
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 17:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbXAZQ7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 11:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030834AbXAZQuY
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 11:50:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28267 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030786AbXAZQuH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 11:50:07 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCH00D7HIRISK80@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Jan 2007 11:50:06 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37873>

Doing:

$ git checkout HEAD^

Generates the following message:

|warning: you are not on ANY branch anymore.
|If you meant to create a new branch from the commit, you need -b to
|associate a new branch with the wanted checkout.  Example:
|  git checkout -b <new_branch_name> HEAD^

Of course if the user does as told at this point the created branch 
won't be located at the expected commit.  Reword this message a bit to 
avoid such confusion.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/git-checkout.sh b/git-checkout.sh
index c52f352..1929424 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -156,9 +156,9 @@ then
 	if test -n "$oldbranch"
 	then
 		detach_warn="warning: you are not on ANY branch anymore.
-If you meant to create a new branch from the commit, you need -b to
-associate a new branch with the wanted checkout.  Example:
-  git checkout -b <new_branch_name> $arg"
+If you meant to create a new branch from this checkout, you may still do
+so (now or later) by using -b with the checkout command again.  Example:
+  git checkout -b <new_branch_name>"
 	fi
 elif test -z "$oldbranch" && test -n "$branch"
 then
