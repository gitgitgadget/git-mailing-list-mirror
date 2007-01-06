From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/5] Fix timestamp for test-tick
Date: Sat, 06 Jan 2007 02:16:07 -0800
Message-ID: <7vbqlc795k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 06 11:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H38b5-0001Rd-Nv
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 11:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbXAFKQK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 05:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXAFKQJ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 05:16:09 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46675 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbXAFKQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 05:16:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106101608.UISD15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jan 2007 05:16:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7mGN1W00k1kojtg0000000; Sat, 06 Jan 2007 05:16:23 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36078>

The earlier test timestamp was too old; I forgot that the bare
unixtime integer had to be after Jan 1, 2000.  This changes
test_tick to use the git-epoch timestamp.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/test-lib.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bf108d4..72ea2b2 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -99,12 +99,12 @@ trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
 test_tick () {
 	if test -z "${test_tick+set}"
 	then
-		test_tick=432630000
+		test_tick=1112911993
 	else
 		test_tick=$(($test_tick + 60))
 	fi
-	GIT_COMMITTER_DATE=$test_tick
-	GIT_AUTHOR_DATE=$test_tick
+	GIT_COMMITTER_DATE="$test_tick -0700"
+	GIT_AUTHOR_DATE="$test_tick -0700"
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }
 
-- 
1.5.0.rc0.ge0f6
