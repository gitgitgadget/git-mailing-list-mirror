From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/5] pick: simplify bogus comment about commiting
	immediately
Date: Sat, 01 Aug 2009 17:46:06 +0200
Message-ID: <20090801154607.20922.26129.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 17:49:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXGpP-0000FT-97
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 17:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbZHAPsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 11:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZHAPsU
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 11:48:20 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36495 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbZHAPsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 11:48:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E624D81807C;
	Sat,  1 Aug 2009 17:48:00 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E2F3F8180D3;
	Sat,  1 Aug 2009 17:47:57 +0200 (CEST)
X-git-sha1: 8a5c8a79ab9393a556a77969ce68a9cd4c3eac9e 
X-Mailer: git-mail-commits v0.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124633>

as suggested by Junio, and add some interesting comments from Junio.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pick.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/pick.c b/pick.c
index a6b1d6f..128a191 100644
--- a/pick.c
+++ b/pick.c
@@ -63,6 +63,14 @@ static struct tree *empty_tree(void)
  * Pick changes introduced by "commit" argument into current working
  * tree and index.
  *
+ * It starts from the current index (not HEAD), and allow the effect
+ * of one commit replayed (either forward or backward) to that state,
+ * leaving the result in the index.
+ *
+ * You do not have to start from a commit, so you can replay many
+ * commits to the index in sequence without commiting in between to
+ * squash multiple steps if you wanted to.
+ *
  * Return 0 on success.
  * Return negative value on error before picking,
  * and a positive value after picking,
@@ -85,10 +93,8 @@ int pick_commit(struct commit *pick_commit, int mainline, int flags,
 	commit = pick_commit;
 
 	/*
-	 * We do not intend to commit immediately.  We just want to
-	 * merge the differences in, so let's compute the tree
-	 * that represents the "current" state for merge-recursive
-	 * to work on.
+	 * Let's compute the tree that represents the "current" state
+	 * for merge-recursive to work on.
 	 */
 	if (write_cache_as_tree(head, 0, NULL))
 		return error("Your index file is unmerged.");
-- 
1.6.4.133.g8a5c8
