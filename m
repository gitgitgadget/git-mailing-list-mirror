From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] parse_object: check if buffer is non-NULL before freeing it
Date: Mon, 28 Aug 2006 02:31:29 +0200
Message-ID: <20060828003129.GE20904@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 28 02:32:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHV2l-0000vb-03
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 02:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWH1Abo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 20:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWH1Abo
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 20:31:44 -0400
Received: from [130.225.96.91] ([130.225.96.91]:54444 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751273AbWH1Abn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 20:31:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 87EFF77000B
	for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:31:31 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32140-19 for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:31:30 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 23AB5770004
	for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:31:30 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 2D6436DF823
	for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:30:08 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id BB8CA62A02; Mon, 28 Aug 2006 02:31:29 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26132>

Two code paths may cause this and other places in the source have the
courtesy to do the check.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 object.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/object.c b/object.c
index 9281300..c08347f 100644
--- a/object.c
+++ b/object.c
@@ -173,7 +173,8 @@ struct object *parse_object(const unsign
 		} else {
 			obj = NULL;
 		}
-		free(buffer);
+		if (buffer)
+			free(buffer);
 		return obj;
 	}
 	return NULL;
-- 
1.4.2.g2f76-dirty

-- 
Jonas Fonseca
