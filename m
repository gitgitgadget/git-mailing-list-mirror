From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH 1/2] Added use of xmalloc() on diff-delta.c
Date: Wed,  4 Apr 2007 15:50:08 -0300
Message-ID: <11757126093105-git-send-email-ribas@c3sl.ufpr.br>
Cc: Junio C Hamano <junkio@cox.net>, Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 20:51:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZAZt-00006j-RL
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 20:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbXDDSuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 14:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993013AbXDDSuS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 14:50:18 -0400
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:58331 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbXDDSuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 14:50:15 -0400
Received: from localhost (labatt.c3sl.ufpr.br [200.17.202.89])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 5E395301B42F;
	Wed,  4 Apr 2007 15:50:11 -0300 (BRT)
X-Mailer: git-send-email 1.5.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43766>


Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 diff-delta.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 9f998d0..74a8377 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -157,9 +157,8 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	memsize = sizeof(*index) +
 		  sizeof(*hash) * hsize +
 		  sizeof(*entry) * entries;
-	mem = malloc(memsize);
-	if (!mem)
-		return NULL;
+	mem = xmalloc(memsize);
+
 	index = mem;
 	mem = index + 1;
 	hash = mem;
@@ -258,9 +257,7 @@ create_delta(const struct delta_index *index,
 	outsize = 8192;
 	if (max_size && outsize >= max_size)
 		outsize = max_size + MAX_OP_SIZE + 1;
-	out = malloc(outsize);
-	if (!out)
-		return NULL;
+	out = xmalloc(outsize);
 
 	/* store reference buffer size */
 	i = index->src_size;
-- 
1.5.0.3
