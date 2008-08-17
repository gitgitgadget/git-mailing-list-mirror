From: Eric Hanchrow <offby1@blarg.net>
Subject: [PATCH] Note the use of "rebase -i" to squash consecutive commits into one.
Date: Sun, 17 Aug 2008 15:32:20 -0700
Message-ID: <1219012340-23376-1-git-send-email-offby1@blarg.net>
Cc: Eric Hanchrow <offby1@blarg.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 01:04:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUrI0-0006pp-3o
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 01:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYHQXC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 19:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbYHQXC4
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 19:02:56 -0400
Received: from smtp61.avvanta.com ([206.124.128.61]:34555 "EHLO
	mail.avvanta.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751855AbYHQXC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 19:02:56 -0400
Received: from mail.avvanta.com (localhost [127.0.0.1])
	by mail.avvanta.com (Postfix) with ESMTP id BC178276C5C;
	Sun, 17 Aug 2008 15:32:20 -0700 (PDT)
Received: from localhost.localdomain (q-static-138-125.avvanta.com [206.124.138.125])
	by mail.avvanta.com (Postfix) with ESMTP id 778F7276C58;
	Sun, 17 Aug 2008 15:32:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.8.ge92a4
X-BlargAV-Status: No viruses detected, BlargAV v1.1 on localhost.scooter.p.blarg.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92669>

---
 Documentation/git-rebase.txt |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 59c1b02..074f38b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -341,7 +341,29 @@ was HEAD~4 becomes the new HEAD. To achieve that, you would call
 $ git rebase -i HEAD~5
 ----------------------
 
-And move the first patch to the end of the list.
+And move the first patch to the end of the list.  Similarly, you can
+squash a bunch of consecutive commits into one commit.  If you start
+with this:
+
+------------
+    Q---R---S---T---U master
+------------
+
+then the command
+
+----------------------
+$ git rebase -i HEAD~3
+----------------------
+
+would let you edit the last three commits -- S, T, and U; if you
+edit the lines corresponding to T and U by changing "pick" to
+"squash", the result will be
+
+------------
+    Q---R---S' master
+------------
+
+where S' contains all the changes that were in S, T, and U.
 
 You might want to preserve merges, if you have a history like this:
 
-- 
1.6.0.rc3.6.gf8030
