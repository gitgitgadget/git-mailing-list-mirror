From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] rebase -p: Preserve --no-ff merges
Date: Fri, 20 Mar 2009 16:38:22 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0903201633440.4457@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 20 21:40:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LklVc-0003pX-75
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 21:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbZCTUif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 16:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753666AbZCTUif
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 16:38:35 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52756 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753257AbZCTUie (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 16:38:34 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n2KKcObe018211;
	Fri, 20 Mar 2009 16:38:24 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n2KKcMVk029135;
	Fri, 20 Mar 2009 16:38:23 -0400 (EDT)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114003>

Previously, git rebase -p would turn some merges that had been constructed 
with git merge --no-ff into fast-forwards.  Now it reconstructs those 
merges using --no-ff as well.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3dc659d..39545cc 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -275,7 +275,7 @@ pick_one_preserving_merges () {
 			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
 				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-				output git merge $STRATEGY -m "$msg" \
+				output git merge --no-ff $STRATEGY -m "$msg" \
 					$new_parents
 			then
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
-- 
1.6.2
