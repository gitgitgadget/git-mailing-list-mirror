From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Stop displaying "Pack pack-$ID created." during git-gc
Date: Fri, 19 Oct 2007 01:03:35 -0400
Message-ID: <20071019050335.GA17222@spearce.org>
References: <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 07:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iik1g-0004RB-BU
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 07:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbXJSFDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 01:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbXJSFDs
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 01:03:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47050 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbXJSFDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 01:03:47 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iik1J-000128-0g; Fri, 19 Oct 2007 01:03:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E9DE420FBAE; Fri, 19 Oct 2007 01:03:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61650>

Discussion on the list tonight came to the conclusion that showing
the name of the packfile we just created during git-repack is not
a very useful message for any end-user.  For the really technical
folk who need to have the name of the newest packfile they can use
something such as `ls -t .git/objects/pack | head -2` to find the
most recently created packfile.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Nicolas Pitre <nico@cam.org> wrote:
 > On Thu, 18 Oct 2007, Jeff King wrote:
 > >     Can we get rid of total statistics (I think this is useful for some
 > >     power users, but perhaps there should be a verbosity level), the
 > >     name of the pack file (same deal), and the totally useless "Done."?
 >
 > Agreed for the pack name.  Certainly no one cares.

 This makes it so.

 git-repack.sh |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index e72adc4..7220635 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -83,9 +83,6 @@ for name in $names ; do
 	fullbases="$fullbases pack-$name"
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
-	if test "$quiet" != '-q'; then
-	    echo "Pack pack-$name created."
-	fi
 	mkdir -p "$PACKDIR" || exit
 
 	for sfx in pack idx
-- 
1.5.3.4.1249.g895be
