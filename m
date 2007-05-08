From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Change all git-status output to be "comments"
Date: Mon, 7 May 2007 22:13:56 -0400
Message-ID: <20070508021355.GA22383@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 04:14:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlFDP-00087h-Va
	for gcvg-git@gmane.org; Tue, 08 May 2007 04:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966870AbXEHCOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 22:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967561AbXEHCOE
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 22:14:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51850 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966870AbXEHCOD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 22:14:03 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlFD2-000375-3W; Mon, 07 May 2007 22:13:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3F43920FBAE; Mon,  7 May 2007 22:13:56 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46517>

You wouldn't believe how many of my merge commits end with
the following message from git-status:

  "nothing to commit (working directory clean)"

This happens because of the way I sometimes create (and resolve)
some types of merges.  My commit message buffer gets prepped with
the output of git-status, which has this nice message way down at the
bottom of the file, below a large-ish block of lines that start with
"#".  Since git-commit strips those lines, I always fail to see the
trailing line that doesn't start with "#" and consequently fail to
see that "nothing to commit ..." will be part of my merge message.

So always comment out the output of git-status.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 wt-status.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index a055990..a9ba1ae 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -336,13 +336,13 @@ void wt_status_print(struct wt_status *s)
 		if (s->amend)
 			printf("# No changes\n");
 		else if (s->workdir_dirty)
-			printf("no changes added to commit (use \"git add\" and/or \"git commit -a\")\n");
+			printf("# no changes added to commit (use \"git add\" and/or \"git commit -a\")\n");
 		else if (s->workdir_untracked)
-			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
+			printf("# nothing added to commit but untracked files present (use \"git add\" to track)\n");
 		else if (s->is_initial)
-			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
+			printf("# nothing to commit (create/copy files and use \"git add\" to track)\n");
 		else
-			printf("nothing to commit (working directory clean)\n");
+			printf("# nothing to commit (working directory clean)\n");
 	}
 }
 
-- 
1.5.2.rc2.716.gba45c
