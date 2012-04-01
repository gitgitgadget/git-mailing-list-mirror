From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 1/2] gitk: fix tabbed preferences construction when using tcl 8.4
Date: Sun,  1 Apr 2012 23:00:51 +0100
Message-ID: <1333317652-1464-2-git-send-email-patthoyts@users.sourceforge.net>
References: <4F749C71.7050201@ramsay1.demon.co.uk>
 <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: <git@vger.kernel.org>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 00:04:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SESsf-0008MR-0F
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 00:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab2DAWDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 18:03:37 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:55315 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752713Ab2DAWDg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Apr 2012 18:03:36 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120401220335.DDKZ3740.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sun, 1 Apr 2012 23:03:35 +0100
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1SESs3-0006ob-5o; Sun, 01 Apr 2012 23:03:35 +0100
Received: from localhost.localdomain (frog.patthoyts.tk [192.168.0.25])
	by fox.patthoyts.tk (Postfix) with ESMTP id BEE4720054;
	Sun,  1 Apr 2012 23:03:34 +0100 (BST)
X-Mailer: git-send-email 1.7.9.msysgit.0
In-Reply-To: <1333317652-1464-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=b6FCpATyD-EA:10 a=i_RdsMQ9AAAA:8 a=FP58Ms26AAAA:8 a=VAqSxcoB84_ssdWeK-MA:9 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194486>

In 8.5 the incr command creates the target variable if it does not exist
but in 8.4 using incr on a non-existing variable raises an error. Ensure
we have created our counter variable when creating the tabbed dialog for
non-themed preferences.

Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 651b740..68cd1a1 100755
--- a/gitk
+++ b/gitk
@@ -11012,6 +11012,7 @@ proc doprefs {} {
     lappend pages [prefspage_general $notebook] [mc "General"]
     lappend pages [prefspage_colors $notebook] [mc "Colors"]
     lappend pages [prefspage_fonts $notebook] [mc "Fonts"]
+    set col 0
     foreach {page title} $pages {
 	if {$use_notebook} {
 	    $notebook add $page -text $title
-- 
1.7.9.msysgit.0
