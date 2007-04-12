From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't yap about merge-subtree during make
Date: Thu, 12 Apr 2007 01:21:18 -0400
Message-ID: <20070412052118.GA13119@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:21:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbrkR-0003nG-SJ
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 07:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbXDLFV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 01:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbXDLFV0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 01:21:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53761 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422667AbXDLFVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 01:21:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HbrkH-0007yI-2I; Thu, 12 Apr 2007 01:21:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0677120FBAE; Thu, 12 Apr 2007 01:21:18 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44322>

By default we are pretty quiet about the actual commands that
we are running.  So we should continue to be quiet about the new
merge-subtree hardlink to merge-recursive.  Technically this is not
a builtin, but it is close because subtree is actually builtin to
a non-builtin.  So lets just make things easy and call it a builtin.
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 2b34dd8..cb28d7a 100644
--- a/Makefile
+++ b/Makefile
@@ -729,7 +729,7 @@ git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS) GIT-CFLAGS
 help.o: common-cmds.h
 
 git-merge-subtree$X: git-merge-recursive$X
-	rm -f $@ && ln git-merge-recursive$X $@
+	$(QUIET_BUILT_IN)rm -f $@ && ln git-merge-recursive$X $@
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)rm -f $@ && ln git$X $@
-- 
1.5.1.1.772.gab9f7
