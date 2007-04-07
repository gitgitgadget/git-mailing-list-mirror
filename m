From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/5] t1000: fix case table.
Date: Sat, 07 Apr 2007 07:39:32 -0700
Message-ID: <7vbqi0ckpn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 16:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaC4u-0003py-D2
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 16:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965898AbXDGOjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 10:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965907AbXDGOjm
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 10:39:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34452 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965898AbXDGOje (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 10:39:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407143933.MLZC792.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 10:39:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kEfY1W00H1kojtg0000000; Sat, 07 Apr 2007 10:39:33 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43967>

Case #10 is not handled with unpack-trees.c:threeway_merge()
internally, unless under the agressive rule, and it is not a
bug.  As the test expects, ND (one side did not do anything,
other side deleted) case was meant to be handled by the caller's
policy (e.g. git-merge-one-file or git-merge-recursive).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t1000-read-tree-m-3way.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index e26a36c..de4e5eb 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -184,7 +184,7 @@ checked.
   9  exists  O!=A    missing   no merge    must match A and be
                                            up-to-date, if exists.
  ------------------------------------------------------------------
- 10  exists  O==A    missing   remove      ditto
+ 10  exists  O==A    missing   no merge    must match A
  ------------------------------------------------------------------
  11  exists  O!=A    O!=B      no merge    must match A and be
                      A!=B                  up-to-date, if exists.
-- 
1.5.1.81.gee969
