From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Use extended SHA1 syntax in merge-recursive conflicts.
Date: Sat, 23 Dec 2006 03:44:00 -0500
Message-ID: <20061223084400.GA10203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 09:44:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy2UM-0000zx-1s
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 09:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbWLWIoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 03:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbWLWIoF
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 03:44:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40588 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbWLWIoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 03:44:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy2Th-0006S0-OR; Sat, 23 Dec 2006 03:43:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ADDFC20FB65; Sat, 23 Dec 2006 03:44:00 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35302>

When we get a line-level conflict in merge-recursive and print out
the two sides in the conflict hunk header and footer we should use
the standard extended SHA1 syntax to specify the specific blob,
as this allows the user to copy and paste the line right into
'git show' to view the complete version.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-recursive.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ae7ae4c..abebb95 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -649,8 +649,8 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 			char *name1, *name2;
 			int merge_status;
 
-			name1 = xstrdup(mkpath("%s/%s", branch1, a->path));
-			name2 = xstrdup(mkpath("%s/%s", branch2, b->path));
+			name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
+			name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
 
 			fill_mm(o->sha1, &orig);
 			fill_mm(a->sha1, &src1);
-- 
1.4.4.3.g87d8
