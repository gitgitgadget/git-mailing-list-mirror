From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] core.logallrefupdates: log remotes/ tracking branches.
Date: Thu, 28 Dec 2006 16:32:05 -0800
Message-ID: <7vodpntud6.fsf_-_@assigned-by-dhcp.cox.net>
References: <1167251519.2247.10.camel@dv>
	<7vfyb159dn.fsf@assigned-by-dhcp.cox.net>
	<1167341346.12660.17.camel@dv>
	<7vzm97tzbt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 29 01:32:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H05fQ-0005nl-BN
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 01:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbWL2AcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 19:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbWL2AcI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 19:32:08 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52772 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbWL2AcG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 19:32:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229003206.HPZD15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 19:32:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4QYK1W00f1kojtg0000000; Thu, 28 Dec 2006 19:32:20 -0500
To: git@vger.kernel.org
In-Reply-To: <7vzm97tzbt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 28 Dec 2006 14:44:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35568>

Not using reflog for tags/ was very sensible; not giving reflog
for the remotes/ was not.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 refs.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 8b2a3c1..e88ed8b 100644
--- a/refs.c
+++ b/refs.c
@@ -925,7 +925,8 @@ static int log_ref_write(struct ref_lock *lock,
 	const char *committer;
 
 	if (log_all_ref_updates &&
-	    !strncmp(lock->ref_name, "refs/heads/", 11)) {
+	    (!strncmp(lock->ref_name, "refs/heads/", 11) ||
+	     !strncmp(lock->ref_name, "refs/remotes/", 13))) {
 		if (safe_create_leading_directories(lock->log_file) < 0)
 			return error("unable to create directory for %s",
 				lock->log_file);
-- 
1.5.0.rc0.gf5c587
