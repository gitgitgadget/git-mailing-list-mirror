From: Luke Dashjr <luke-jr+git@utopios.org>
Subject: [PATCH 2/5] fix "git add --ignore-errors" to ignore pathspec errors
Date: Wed, 12 Aug 2009 22:20:21 -0500
Message-ID: <1250133624-2272-2-git-send-email-luke-jr+git@utopios.org>
References: <200908121726.52121.luke-jr@utopios.org>
 <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
Cc: Luke Dashjr <luke-jr+git@utopios.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 05:21:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbQsL-0007QD-St
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 05:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbZHMDUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 23:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbZHMDUo
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 23:20:44 -0400
Received: from unused ([66.216.20.21]:45438 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbZHMDUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 23:20:41 -0400
Received: from tsuruki (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	by zinan.dashjr.org (Postfix) with SMTP id 7D324B9DB7D;
	Thu, 13 Aug 2009 03:20:39 +0000 (UTC)
Received: by tsuruki (sSMTP sendmail emulation); Wed, 12 Aug 2009 22:20:39 -0500
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125769>

Unmatched files are errors, and should be ignored with the rest of them.

Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
---
 builtin-add.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 0597fb9..e3132c8 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -280,6 +280,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		add_interactive = 1;
 	if (add_interactive)
 		exit(interactive_add(argc - 1, argv + 1, prefix));
+	if (ignore_add_errors)
+		ignore_unmatch = 1;
 
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
-- 
1.6.3.3
