From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] builtin-fetch: fail when fetching refs fails
Date: Tue, 17 Jul 2007 23:50:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707172350050.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 00:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAvsO-00041O-Vk
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 00:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759153AbXGQWui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 18:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758957AbXGQWuh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 18:50:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:44015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756370AbXGQWuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 18:50:37 -0400
Received: (qmail invoked by alias); 17 Jul 2007 22:50:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 18 Jul 2007 00:50:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180b0cnFjM0mwW2nxWHLyC3PNPDVcC/NuCFjzJy7j
	q3UEMpKyhEvvp1
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52811>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-fetch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 2f24c22..f1045ac 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -381,7 +381,10 @@ static int do_fetch(struct transport *transport,
 		}
 	}
 
-	fetch_refs(transport, ref_map);
+	if (fetch_refs(transport, ref_map)) {
+		free_refs(ref_map);
+		return 1;
+	}
 
 	fetch_map = ref_map;
 
-- 
1.5.3.rc1.16.g9d6f-dirty
