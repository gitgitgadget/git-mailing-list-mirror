From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/4] Correct comment in prepare_packed_git_one.
Date: Thu, 1 Feb 2007 15:52:27 -0500
Message-ID: <20070201205227.GB19009@spearce.org>
References: <a0b03fc086bb66e2aa2e386dcb4ff97fc837f07f.1170363130.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 21:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCivA-0000UD-DI
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 21:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423004AbXBAUwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 15:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423005AbXBAUwa
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 15:52:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43558 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423004AbXBAUwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 15:52:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCiuq-0005Jw-Pz; Thu, 01 Feb 2007 15:52:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 239C120FBAE; Thu,  1 Feb 2007 15:52:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <a0b03fc086bb66e2aa2e386dcb4ff97fc837f07f.1170363130.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38399>

After staring at the comment and the associated for loop, I
realized the comment was completely bogus.  The section of
code its talking about is trying to avoid duplicate mapping
of the same packfile.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a42f94a..4aef244 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -779,7 +779,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (!has_extension(de->d_name, ".idx"))
 			continue;
 
-		/* we have .idx.  Is it a file we can map? */
+		/* Don't reopen a pack we already have. */
 		strcpy(path + len, de->d_name);
 		for (p = packed_git; p; p = p->next) {
 			if (!memcmp(path, p->pack_name, len + namelen - 4))
-- 
1.5.0.rc3.1.ge4b0e
