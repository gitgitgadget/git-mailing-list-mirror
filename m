From: Jeff King <peff@peff.net>
Subject: [PATCH] Fix "--pretty=format:" encoding item
Date: Wed, 28 Mar 2007 17:09:05 -0400
Message-ID: <20070328210905.GB7898@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:09:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWfOK-00030K-D8
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 23:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbXC1VJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 17:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbXC1VJI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 17:09:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3395 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbXC1VJH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 17:09:07 -0400
Received: (qmail 13716 invoked from network); 28 Mar 2007 21:09:38 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 21:09:38 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2007 17:09:05 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43388>

It printed the header "encoding " instead of just showing
the encoding, as all other items do.

This now passes t6006.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index 9ac533c..a4f2e74 100644
--- a/commit.c
+++ b/commit.c
@@ -888,7 +888,8 @@ static long format_commit_message(const struct commit *commit,
 			fill_person(table + ICOMMITTER_NAME,
 					msg + i + 10, eol - i - 10);
 		else if (!prefixcmp(msg + i, "encoding "))
-			table[IENCODING].value = xstrndup(msg + i, eol - i);
+			table[IENCODING].value =
+				xstrndup(msg + i + 9, eol - i - 9);
 		i = eol;
 	}
 	if (msg[i])
-- 
1.5.1.rc2.636.gff57
