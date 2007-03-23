From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-bisect.sh: properly dq $GIT_DIR
Date: Fri, 23 Mar 2007 14:57:15 -0700
Message-ID: <7vvegroc78.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 22:57:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUrlg-0007e5-L5
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 22:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992580AbXCWV5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 17:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992585AbXCWV5T
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 17:57:19 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63199 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992580AbXCWV5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 17:57:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323215715.RDPB28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Mar 2007 17:57:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id eMxF1W00j1kojtg0000000; Fri, 23 Mar 2007 17:57:16 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42964>

Otherwise you would be in trouble if your GIT_DIR has IFS letters in it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 8eaea7c..936b4a4 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -141,7 +141,7 @@ bisect_next() {
 	bad=$(git-rev-parse --verify refs/bisect/bad) &&
 	good=$(git-rev-parse --sq --revs-only --not \
 		$(cd "$GIT_DIR" && ls refs/bisect/good-*)) &&
-	rev=$(eval "git-rev-list --bisect $good $bad -- $(cat $GIT_DIR/BISECT_NAMES)") || exit
+	rev=$(eval "git-rev-list --bisect $good $bad -- $(cat "$GIT_DIR/BISECT_NAMES")") || exit
 	if [ -z "$rev" ]; then
 	    echo "$bad was both good and bad"
 	    exit 1
-- 
1.5.1.rc1.651.g2ca06
