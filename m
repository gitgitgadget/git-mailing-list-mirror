From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] Documentation/git-gc.txt: change --aggressive description
Date: Tue, 13 May 2008 11:53:33 +0200
Message-ID: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 11:55:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvrDH-0006ls-4a
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 11:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYEMJxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 05:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbYEMJxg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 05:53:36 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:54139 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbYEMJxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 05:53:36 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6112.orange.nl (SMTP Server) with ESMTP id 533B51C00087;
	Tue, 13 May 2008 11:53:34 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6112.orange.nl (SMTP Server) with ESMTP id EAA191C00086;
	Tue, 13 May 2008 11:53:33 +0200 (CEST)
X-ME-UUID: 20080513095333961.EAA191C00086@mwinf6112.orange.nl
X-Mailer: git-send-email 1.5.5.1.174.g32fa0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82012>

The documentation for the --aggressive flag was misleading, hinting that
running git gc with --aggressive is a good thing. However, --aggressive only
really makes sense if you have a bad pack file, such as from git-fast-import.
---

I keep seeing people regularly packing their repo with git gc --aggressive.
However, in my experience, this seldom results in a smaller repository. This
can be because the repository was repacked tightly previously (for example,
with a high --window value) or because incremental "git gc" just makes better
packs anyway. Throwing away that information is often not a good idea.

The documentation for the --aggressive flag was misleading, in that it hints that you'll get a smaller pack, which is often not the case.



 Documentation/git-gc.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index b6b5ce1..ebf972c 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -36,9 +36,11 @@ OPTIONS
 	Usually 'git-gc' runs very quickly while providing good disk
 	space utilization and performance.  This option will cause
 	git-gc to more aggressively optimize the repository at the expense
-	of taking much more time.  The effects of this optimization are
-	persistent, so this option only needs to be used occasionally; every
-	few hundred changesets or so.
+	of taking much more time. Note that this will throw away all previous
+	optimizations. As a result, running git gc with --aggressive will not
+	necessarily create a smaller pack file, especially when the repository was
+	packed tightly already. Using --aggressive only makes sense if you have a
+	badly packed repository, such as created by git-fast-import.
 
 --auto::
 	With this option, `git gc` checks whether any housekeeping is
-- 
1.5.5.1.174.g32fa0.dirty
