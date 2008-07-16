From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH] Reformat "your branch has diverged..." lines to reduce line length.
Date: Wed, 16 Jul 2008 15:19:27 -0400
Message-ID: <1216235967-9510-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 21:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCh2-00008C-Tb
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957AbYGPT2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756705AbYGPT2h
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:28:37 -0400
Received: from host.238.217.mtl.cablemodem.vdn.ca ([206.223.238.217]:41663
	"EHLO insight.mtl.versabanq.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756894AbYGPT2g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jul 2008 15:28:36 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2008 15:28:36 EDT
Received: by insight.mtl.versabanq.com (Postfix, from userid 1000)
	id D139AE7C04A; Wed, 16 Jul 2008 15:19:27 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.3.385.g94745
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88731>

The message length depends on the length of the branch name.  In my case,
the branch name "origin/add-chickens2" put the first line of the "your
branch has diverged" message over 80 characters, which triggered "less -FS"
to not exit automatically as expected.

This patch puts the newlines in slightly different places to reduce the
probability of this happening.  Now you'd need a significantly longer
branch name to trigger the problem.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 remote.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
 
I suppose a full-on automatic wordwrapper would be nicer :)
 

diff --git a/remote.c b/remote.c
index df8bd72..4f32032 100644
--- a/remote.c
+++ b/remote.c
@@ -1321,19 +1321,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		remote_msg = "";
 	}
 	if (!num_theirs)
-		strbuf_addf(sb, "Your branch is ahead of the tracked%s branch '%s' "
+		strbuf_addf(sb, "Your branch is ahead of the tracked%s branch '%s'\n"
 			    "by %d commit%s.\n",
 			    remote_msg, base,
 			    num_ours, (num_ours == 1) ? "" : "s");
 	else if (!num_ours)
-		strbuf_addf(sb, "Your branch is behind the tracked%s branch '%s' "
-			    "by %d commit%s,\n"
+		strbuf_addf(sb, "Your branch is behind the tracked%s branch '%s'\n"
+			    "by %d commit%s, "
 			    "and can be fast-forwarded.\n",
 			    remote_msg, base,
 			    num_theirs, (num_theirs == 1) ? "" : "s");
 	else
-		strbuf_addf(sb, "Your branch and the tracked%s branch '%s' "
-			    "have diverged,\nand respectively "
+		strbuf_addf(sb, "Your branch and the tracked%s branch '%s'\n"
+			    "have diverged, and respectively "
 			    "have %d and %d different commit(s) each.\n",
 			    remote_msg, base,
 			    num_ours, num_theirs);
-- 
1.5.6.3.385.g94745
