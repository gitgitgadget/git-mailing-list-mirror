From: Asheesh Laroia <asheesh@asheesh.org>
Subject: [PATCH] git-mergetool: print filename when it contains %
Date: Thu,  7 Feb 2013 17:16:24 -0800
Message-ID: <1360286184-14278-1-git-send-email-asheesh@asheesh.org>
Cc: Asheesh Laroia <asheesh@asheesh.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 02:23:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3cgw-0006dm-H5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 02:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab3BHBX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 20:23:27 -0500
Received: from rose.makesad.us ([199.199.210.158]:37300 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab3BHBX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 20:23:26 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2013 20:23:26 EST
Received: from pathi.makesad.us (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id CC7E23FC5583;
	Thu,  7 Feb 2013 20:16:28 -0500 (EST)
Received: by pathi.makesad.us (Postfix, from userid 1000)
	id 1DB244400B4; Fri,  8 Feb 2013 12:16:27 +1100 (EST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215740>

Before this change, if git-mergetool was invoked with regard to
files with a percent sign (%) in their names, it would print an
error. For example, if you were calling mergetool on a file called
"%2F":

    printf: %2F: invalid directive

This changes the behavior to pass "%s" to printf as its first argument
to avoid processing the filename as a format string.

Signed-off-by: Asheesh Laroia <asheesh@asheesh.org>
---
 git-mergetool.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index c50e18a..d2b9289 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -440,7 +440,7 @@ then
 fi
 
 printf "Merging:\n"
-printf "$files\n"
+printf "%s" "$files\n"
 
 IFS='
 '
-- 
1.7.10.4
