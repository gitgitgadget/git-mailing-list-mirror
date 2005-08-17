From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Also handle CVS branches with a '/' in their name
Date: Wed, 17 Aug 2005 08:39:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508170839030.27628@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 17 08:41:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5HaM-0002La-1L
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 08:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVHQGjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 02:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVHQGjf
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 02:39:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44421 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750924AbVHQGjf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 02:39:35 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F1C40E2550; Wed, 17 Aug 2005 08:39:31 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D2297AD7AA; Wed, 17 Aug 2005 08:39:31 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B91E4AD5B5; Wed, 17 Aug 2005 08:39:31 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7692BE2550; Wed, 17 Aug 2005 08:39:31 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I track a CVS project which has a branch with a '/' in the branch name.
Since git wants the branch name to be a file name at the same time,
translate that character to a '-'. This should work well, despite the
fact that a division and a difference are completely different :-)

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

 git-cvsimport-script |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

787879e1e16d6cece75dc4744358ba0073e908cc
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -621,6 +621,7 @@ while(<CVS>) {
 		$state = 4;
 	} elsif($state == 4 and s/^Branch:\s+//) {
 		s/\s+$//;
+		s/\//-/g;
 		$branch = $_;
 		$state = 5;
 	} elsif($state == 5 and s/^Ancestor branch:\s+//) {
