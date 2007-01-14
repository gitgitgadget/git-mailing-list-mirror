From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Hide output about SVN::Core not being found during tests.
Date: Sun, 14 Jan 2007 03:22:47 -0500
Message-ID: <20070114082247.GA19622@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 09:23:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H60dr-0006tV-H1
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 09:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbXANIWv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 03:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbXANIWv
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 03:22:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50841 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbXANIWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 03:22:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H60db-0004Wf-2W; Sun, 14 Jan 2007 03:22:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5527D20FBAE; Sun, 14 Jan 2007 03:22:47 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36798>

If the user doesn't have SVN::Core installed or working then the
SVN tests properly turn themselves off.  But the user doesn't need
to know that SVN::Core isn't loadable as a Perl module.  Unless of
course they are trying to debug the test, so lets relegate the Perl
failures to --verbose only.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/lib-git-svn.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index a0f2814..bb1d7b8 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -26,7 +26,7 @@ use SVN::Core;
 use SVN::Repos;
 \$SVN::Core::VERSION gt '1.1.0' or exit(42);
 system(qw/svnadmin create --fs-type fsfs/, '$svnrepo') == 0 or exit(41);
-"
+" >&3 2>&4
 x=$?
 if test $x -ne 0
 then
-- 
1.5.0.rc1.g4494
