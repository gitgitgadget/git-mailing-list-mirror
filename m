From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 2/2] builtin-apply: stronger indent-with-on-tab fixing
Date: Sun, 16 Dec 2007 12:58:02 -0500
Message-ID: <1197827882-11710-3-git-send-email-bfields@citi.umich.edu>
References: <1197822702-5262-7-git-send-email-bfields@citi.umich.edu>
 <1197827882-11710-1-git-send-email-bfields@citi.umich.edu>
 <1197827882-11710-2-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 18:59:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3xlT-0003Q5-CM
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 18:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934488AbXLPR6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 12:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934395AbXLPR6G
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 12:58:06 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39131 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765793AbXLPR6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 12:58:05 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3xkY-000370-Do; Sun, 16 Dec 2007 12:58:02 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197827882-11710-2-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68473>

Fix any sequence of 8 spaces in initial indent, not just the case where
the 8 spaces are the first thing on the line.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 builtin-apply.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index bd94a4b..5e3b4a1 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1587,8 +1587,7 @@ static int apply_line(char *output, const char *patch, int plen,
 		} else if (ch == ' ') {
 			last_space_in_indent = i;
 			if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
-			    last_tab_in_indent <= 0 &&
-			    8 <= i)
+			    8 <= i - last_tab_in_indent)
 				need_fix_leading_space = 1;
 		}
 		else
-- 
1.5.4.rc0.44.g21147
