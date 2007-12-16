From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 2/6] whitespace: reorganize initial-indent check
Date: Sun, 16 Dec 2007 11:31:38 -0500
Message-ID: <1197822702-5262-3-git-send-email-bfields@citi.umich.edu>
References: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
 <1197822702-5262-1-git-send-email-bfields@citi.umich.edu>
 <1197822702-5262-2-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 17:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3wPW-0006dk-01
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 17:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933128AbXLPQbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 11:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933071AbXLPQbr
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 11:31:47 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60080 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932994AbXLPQbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 11:31:43 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3wP0-0001Qj-Pu; Sun, 16 Dec 2007 11:31:42 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197822702-5262-2-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68465>

Reorganize to emphasize the most complicated part of the code (the tab
case).

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 ws.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/ws.c b/ws.c
index 5ebd109..7165874 100644
--- a/ws.c
+++ b/ws.c
@@ -146,16 +146,15 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 
 	/* Check for space before tab in initial indent. */
 	for (i = 0; i < len; i++) {
-		if (line[i] == '\t') {
-			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
-			    (leading_space != -1))
-				result |= WS_SPACE_BEFORE_TAB;
-			break;
-		}
-		else if (line[i] == ' ')
+		if (line[i] == ' ') {
 			leading_space = i;
-		else
+			continue;
+		}
+		if (line[i] != '\t')
 			break;
+		if ((ws_rule & WS_SPACE_BEFORE_TAB) && (leading_space != -1))
+			result |= WS_SPACE_BEFORE_TAB;
+		break;
 	}
 
 	/* Check for indent using non-tab. */
-- 
1.5.4.rc0.41.gf723
