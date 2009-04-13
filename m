From: Tim Retout <tim@retout.co.uk>
Subject: [PATCH] builtin-reset.c: Extend hard reset error message when using paths.
Date: Mon, 13 Apr 2009 19:14:04 +0100
Message-ID: <1239646444-11653-1-git-send-email-tim@retout.co.uk>
Cc: Tim Retout <tim@retout.co.uk>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 20:22:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQn8-0005wn-4l
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbZDMSUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZDMSUY
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:20:24 -0400
Received: from jabba.london.02.net ([82.132.130.169]:42418 "EHLO mail.o2.co.uk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751083AbZDMSUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:20:24 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2009 14:20:23 EDT
Received: from arneb.retout.co.uk (87.194.215.58) by mail.o2.co.uk (8.0.013.3) (authenticated as timretout)
        id 49E06F1C0072F9AA; Mon, 13 Apr 2009 19:25:10 +0100
Received: by arneb.retout.co.uk (Postfix, from userid 1000)
	id 493C110000D; Mon, 13 Apr 2009 19:14:04 +0100 (BST)
X-Mailer: git-send-email 1.6.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116460>

Users who invoke 'git reset --hard <paths>' are probably trying to
update paths in their working directory.  The error message should
point them in the direction of git-checkout(1).

Signed-off-by: Tim Retout <tim@retout.co.uk>
---
 builtin-reset.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index c0cb915..885ca9a 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -257,6 +257,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (i < argc) {
 		if (reset_type == MIXED)
 			warning("--mixed option is deprecated with paths.");
+		else if (reset_type == HARD)
+			die("Cannot do %s reset with paths.\n"
+			    "See git-checkout(1) to update paths in the working tree.",
+					reset_type_names[reset_type]);
 		else if (reset_type != NONE)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
-- 
1.6.2.2
