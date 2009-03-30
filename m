From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] --graph: respect --no-color
Date: Mon, 30 Mar 2009 17:49:50 +0200 (CEST)
Message-ID: <0d85995e0a6b497080e7b02d6468e14a210dbbae.1238428115u.git.johannes.schindelin@gmx.de>
References: <20090330141322.GA6221@linux.vnet> <cover.1238428115u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org, Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 17:52:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoJm7-0001b0-D7
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 17:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbZC3Pt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 11:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbZC3Ptz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 11:49:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:54612 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752021AbZC3Ptz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 11:49:55 -0400
Received: (qmail invoked by alias); 30 Mar 2009 15:49:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp007) with SMTP; 30 Mar 2009 17:49:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LADQEynPLFLiELzRkt4OJHKPeZkNPTzPpWKXPM5
	S8Vow6XVJLQAOK
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1238428115u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115167>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 graph.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/graph.c b/graph.c
index 5e2f224..6a8622c 100644
--- a/graph.c
+++ b/graph.c
@@ -5,7 +5,6 @@
 #include "diff.h"
 #include "revision.h"
 
-extern int diff_use_color_default;
 /* Internal API */
 
 /*
@@ -1253,15 +1252,17 @@ static void strbuf_write_column(struct strbuf *sb, const struct column *c,
 	 * right flag to be checking since --no-color doesn't turn
 	 * this off.
 	 */
-	if (diff_use_color_default)
+	if (c->color)
 		strbuf_addstr(sb, c->color);
 	strbuf_addstr(sb, s);
-	if (diff_use_color_default)
+	if (c->color)
 		strbuf_addstr(sb, GIT_COLOR_RESET);
 }
 
 static char* get_current_column_color (const struct git_graph* graph)
 {
+	if (!DIFF_OPT_TST(&graph->revs->diffopt, COLOR_DIFF))
+		return NULL;
 	return column_colors[graph->default_column_color];
 }
 
-- 
1.6.2.1.493.g67cf3
