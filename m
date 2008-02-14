From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] http-push: avoid a needless goto
Date: Thu, 14 Feb 2008 23:26:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802142326040.30505@racer.site>
References: <alpine.LSU.1.00.0802142319340.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, mh@glandium.org
X-From: git-owner@vger.kernel.org Fri Feb 15 00:26:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPnTd-00015y-UH
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 00:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758040AbYBNX0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 18:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757933AbYBNX0Q
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 18:26:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:59864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758020AbYBNX0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 18:26:15 -0500
Received: (qmail invoked by alias); 14 Feb 2008 23:26:13 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp010) with SMTP; 15 Feb 2008 00:26:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19yHUEAuEhyQRwq+rXinMt9IRfYK57H1AT8x2W+AP
	1d8vNnASpEHSon
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802142319340.30505@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73926>


There was a goto, and while it is not half as harmful as some people
believe, it was unnecessary here.  So remove it for readability.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-push.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index 93bd87d..4862db6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2404,12 +2404,9 @@ int main(int argc, char **argv)
 		} while (request_queue_head && !aborted);
 
 		/* Update the remote branch if all went well */
-		if (aborted || !update_remote(ref->new_sha1, ref_lock)) {
+		if (aborted || !update_remote(ref->new_sha1, ref_lock))
 			rc = 1;
-			goto unlock;
-		}
 
-	unlock:
 		if (!rc)
 			fprintf(stderr, "    done\n");
 		unlock_remote(ref_lock);
-- 
1.5.4.1.1353.g0d5dd
