From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Subject: [PATCH] Clarify commit error message for unmerged files
Date: Mon, 29 Sep 2008 18:04:41 +0200
Message-ID: <1222704281-10194-1-git-send-email-rgarciasuarez@gmail.com>
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 18:06:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkLFP-0000gH-OT
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 18:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYI2QEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbYI2QEH
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 12:04:07 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:48278 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbYI2QEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 12:04:06 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 0A012B01C5;
	Mon, 29 Sep 2008 18:04:05 +0200 (CEST)
Received: from localhost.localdomain (inv75-3-82-241-119-67.fbx.proxad.net [82.241.119.67])
	by smtp7-g19.free.fr (Postfix) with ESMTP id DFC4FB016B;
	Mon, 29 Sep 2008 18:04:04 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.307.gc4275.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97028>

Currently, trying to use git-commit with unmerged files in the index
will show the message "Error building trees", which can be a bit
obscure to the end user. This patch makes the error message clearer, and
consistent with what git-write-tree reports in a similar situation.

Signed-off-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
---
 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 8165bb3..6b23143 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -639,7 +639,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		active_cache_tree = cache_tree();
 	if (cache_tree_update(active_cache_tree,
 			      active_cache, active_nr, 0, 0) < 0) {
-		error("Error building trees");
+		error("Error building trees; the index is unmerged?");
 		return 0;
 	}
 
-- 
1.6.0.2.307.gc4275.dirty
