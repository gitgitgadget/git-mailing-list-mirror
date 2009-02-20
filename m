From: Jeff King <peff@peff.net>
Subject: [tig PATCH] add missing NULL in blame_grep
Date: Thu, 19 Feb 2009 22:23:43 -0500
Message-ID: <20090220032343.GA25022@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Feb 20 04:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaM0r-0005pX-8U
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 04:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbZBTDXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 22:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbZBTDXr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 22:23:47 -0500
Received: from peff.net ([208.65.91.99]:51159 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbZBTDXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 22:23:46 -0500
Received: (qmail 31240 invoked by uid 107); 20 Feb 2009 03:24:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 22:24:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 22:23:43 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110786>

Commit 436674f introduced a grep_text utility function which
takes a NULL-terminated list; the callsite in blame_grep
forgot to put in a NULL, leading to segmentation faults.

Signed-off-by: Jeff King <peff@peff.net>
---
 tig.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tig.c b/tig.c
index 5acb398..1de732c 100644
--- a/tig.c
+++ b/tig.c
@@ -4595,6 +4595,7 @@ blame_grep(struct view *view, struct line *line)
 		commit ? commit->id : "",
 		commit && opt_author ? commit->author : "",
 		commit && opt_date ? mkdate(&commit->time) : "",
+		NULL
 	};
 
 	return grep_text(view, text);
-- 
1.6.2.rc1.242.g8d690
