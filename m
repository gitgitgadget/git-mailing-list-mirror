From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-revert: Revert revert message to old behaviour
Date: Fri, 23 Mar 2007 17:06:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703231705150.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0703230805450.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 17:06:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUmHR-0001ns-TV
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 17:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992486AbXCWQGO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 12:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992485AbXCWQGO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 12:06:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:60807 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992486AbXCWQGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 12:06:13 -0400
Received: (qmail invoked by alias); 23 Mar 2007 16:06:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 23 Mar 2007 17:06:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DcQsuY8ZDnfO+1f6pdxA2XhQHb8GKG79kH9RXfb
	/HGz3MJVySeQVE
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703230805450.6730@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42944>


When converting from the shell script, based on a misreading of the
sed invocation, the builtin included the abbreviated commit name,
and did _not_ include the quotes around the oneline message.

This fixes it.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Fri, 23 Mar 2007, Linus Torvalds wrote:
	
	> 
	> Can we please revert the "revert" changes to the default message?
	> 
	> Dscho?

	Yeah?

 builtin-revert.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index f3f3f5c..f4e1e22 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -296,11 +296,9 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (action == REVERT) {
 		base = commit;
 		next = commit->parents->item;
-		add_to_msg("Revert ");
-		add_to_msg(find_unique_abbrev(commit->object.sha1,
-					DEFAULT_ABBREV));
+		add_to_msg("Revert \"");
 		add_to_msg(oneline);
-		add_to_msg("\nThis reverts commit ");
+		add_to_msg("\"\nThis reverts commit ");
 		add_to_msg(sha1_to_hex(commit->object.sha1));
 		add_to_msg(".\n");
 	} else {
-- 
1.5.1.rc1.2356.g2054
