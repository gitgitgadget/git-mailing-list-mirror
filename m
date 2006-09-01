From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fmt-merge-msg: fix off-by-one bug
Date: Fri, 1 Sep 2006 10:49:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609011048590.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Sep 01 10:49:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJ4iV-0008ED-6l
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 10:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWIAItc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 04:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWIAItc
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 04:49:32 -0400
Received: from mail.gmx.de ([213.165.64.20]:37549 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932399AbWIAItb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 04:49:31 -0400
Received: (qmail invoked by alias); 01 Sep 2006 08:49:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 01 Sep 2006 10:49:29 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26297>


Thanks to the recent malloc()->xmalloc() change, and XMALLOC_POISON, this bug
was found.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-fmt-merge-msg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index ed59e77..432963d 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -142,7 +142,7 @@ static int handle_line(char *line)
 		if (origin[0] == '\'' && origin[len - 1] == '\'') {
 			char *new_origin = xmalloc(len - 1);
 			memcpy(new_origin, origin + 1, len - 2);
-			new_origin[len - 1] = 0;
+			new_origin[len - 2] = 0;
 			origin = new_origin;
 		} else
 			origin = strdup(origin);
-- 
1.4.2.gc2fc-dirty
