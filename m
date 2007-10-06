From: mike@csa.net
Subject: [PATCH 1/2] instaweb: allow for use of auto-generated scripts
Date: Sat, 06 Oct 2007 13:29:48 -0400
Message-ID: <11916917892652-git-send-email-mike@csa.net>
References: <7vodfztviv.fsf@gitster.siamese.dyndns.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Mike Dalessio <mike@csa.net>
To: normalperson@yhbt.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 06 19:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeDTX-0000nO-Ac
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 19:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672AbXJFR3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 13:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756480AbXJFR3v
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 13:29:51 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:43016 "EHLO
	mta4.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbXJFR3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 13:29:51 -0400
Received: from ubuntu704-desktop
 (ool-44c1f12b.dyn.optonline.net [68.193.241.43]) by mta4.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0JPI00I1339PMW50@mta4.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Sat, 06 Oct 2007 13:29:50 -0400 (EDT)
Received: by ubuntu704-desktop (Postfix, from userid 1000)	id B32DD5C0BD; Sat,
 06 Oct 2007 13:29:49 -0400 (EDT)
In-reply-to: <7vodfztviv.fsf@gitster.siamese.dyndns.org>
In-reply-to: <7vodfztviv.fsf@gitster.siamese.dyndns.org>
Message-id: <55e906d58f15c79c61d83ad4c52ef085de8ad736.1191687881.git.mike@csa.net>
X-Mailer: git-send-email 1.5.3.1.47.g88b7d-dirty
X-Antivirus: avast! (VPS 000778-4, 10/05/2007), Outbound message
X-Antivirus-Status: Clean
References: <7vodfztviv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

this patch allows scripts that reside in $fqgitdir/gitweb to be used
for firing up an instaweb server. this lays the groundwork for
extending instaweb support to non-standard web servers, which may
require a script for proper invocation.

Signed-off-by: Mike Dalessio <mike@csa.net>
---
 git-instaweb.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index b79c6b6..42d9c34 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -37,7 +37,9 @@ start_httpd () {
 	else
 		# many httpds are installed in /usr/sbin or /usr/local/sbin
 		# these days and those are not in most users $PATHs
-		for i in /usr/local/sbin /usr/sbin
+		# in addition, we may have generated a server script
+		# in $fqgitdir/gitweb.
+		for i in /usr/local/sbin /usr/sbin "$fqgitdir/gitweb"
 		do
 			if test -x "$i/$httpd_only"
 			then
-- 
1.5.2.5
