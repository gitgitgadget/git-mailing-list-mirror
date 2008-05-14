From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] graph.c: fix padding
Date: Wed, 14 May 2008 15:22:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141522060.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 16:24:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwHtL-0001FZ-4H
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 16:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbYENOWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 10:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755366AbYENOWj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 10:22:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:54934 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754762AbYENOWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 10:22:38 -0400
Received: (qmail invoked by alias); 14 May 2008 14:22:36 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp031) with SMTP; 14 May 2008 16:22:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KctACeyrKLvooImZpHG/AyteIqnhiMn6m9y+5LM
	sRhzMRbc+/qoXj
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82100>


There were two instances of "%*s" which want to be "%.*s" instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 graph.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/graph.c b/graph.c
index 9d6ed30..f3e2eed 100644
--- a/graph.c
+++ b/graph.c
@@ -422,7 +422,7 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb)
 		return;
 
 	extra = graph->width - sb->len;
-	strbuf_addf(sb, "%*s", (int) extra, "");
+	strbuf_addf(sb, "%.*s", (int) extra, "");
 }
 
 static void graph_output_padding_line(struct git_graph *graph,
@@ -496,7 +496,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
 			seen_this = 1;
-			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
+			strbuf_addf(sb, "| %.*s", graph->expansion_row, "");
 		} else if (seen_this) {
 			strbuf_addstr(sb, "\\ ");
 		} else {
-- 
1.5.5.1.375.g1becb
