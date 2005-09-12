From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 03/22] teach diff.c about cache iterators
Date: Mon, 12 Sep 2005 10:55:50 -0400
Message-ID: <20050912145549.28120.8321.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:00:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjm-0000SG-QZ
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVILO4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVILOz4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:55:56 -0400
Received: from citi.umich.edu ([141.211.133.111]:58986 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751293AbVILOzu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:55:50 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id EC52F1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:55:49 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8392>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 diff.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -258,7 +258,7 @@ static int work_tree_matches(const char 
 	 * by diff-cache --cached, which does read the cache before
 	 * calling us.
 	 */
-	if (!active_cache)
+	if (read_cache_needed())
 		return 0;
 
 	len = strlen(name);
@@ -677,12 +677,12 @@ void diff_setup(int flags)
 	if (flags & DIFF_SETUP_REVERSE)
 		reverse_diff = 1;
 	if (flags & DIFF_SETUP_USE_CACHE) {
-		if (!active_cache)
+		if (read_cache_needed())
 			/* read-cache does not die even when it fails
 			 * so it is safe for us to do this here.  Also
 			 * it does not smudge active_cache or active_nr
 			 * when it fails, so we do not have to worry about
-			 * cleaning it up oufselves either.
+			 * cleaning it up ourselves either.
 			 */
 			read_cache();
 	}
