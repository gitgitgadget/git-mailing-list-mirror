From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Use nice names in conflict markers during cherry-pick/revert.
Date: Mon, 15 Jan 2007 01:41:22 -0500
Message-ID: <20070115064122.GA12372@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:18:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2J-0000NL-04
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:23 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V93-0003eK-LC
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbXAOGl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 01:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbXAOGl3
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 01:41:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40977 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbXAOGl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 01:41:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6LX4-0000ZA-7s; Mon, 15 Jan 2007 01:41:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A61A20FBAE; Mon, 15 Jan 2007 01:41:23 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36871>

Always call the current HEAD 'HEAD', and name the patch being
cherry-picked or reverted by its oneline subject rather than
its SHA1.  This matches git am's behavior and is done because
users most commonly are cherry-picking by SHA1 rather than by
ref name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is on top of your prior patch "Use merge-recursive in
 git-revert/git-cherry-pick".

 git-revert.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-revert.sh b/git-revert.sh
index c74af99..bb8f1ca 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -146,6 +146,12 @@ cherry-pick)
 
 esac >.msg
 
+eval GITHEAD_$head=HEAD
+eval GITHEAD_$next='`git show -s \
+	--pretty=oneline --encoding="$encoding" "$commit" |
+	sed -e "s/^[^ ]* //"`'
+export GITHEAD_$head GITHEAD_$next
+
 # This three way merge is an interesting one.  We are at
 # $head, and would want to apply the change between $commit
 # and $prev on top of us (when reverting), or the change between
-- 
1.5.0.rc1.g4494
