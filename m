From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 01/26] http-push: fix check condition on http.c::finish_http_pack_request()
Date: Wed, 28 Oct 2009 17:00:23 -0700
Message-ID: <1256774448-7625-2-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISu-0000kN-Pe
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbZJ2AAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755394AbZJ2AAq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:00:46 -0400
Received: from george.spearce.org ([209.20.77.23]:36216 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbZJ2AAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:45 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E3551381D3; Thu, 29 Oct 2009 00:00:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id EEE0A381D3;
	Thu, 29 Oct 2009 00:00:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131535>

From: Tay Ray Chuan <rctay89@gmail.com>

Check that http.c::finish_http_pack_request() returns 0 (for success).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 00e83dc..cc5d4b8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -604,7 +604,7 @@ static void finish_request(struct transfer_request *request)
 			preq = (struct http_pack_request *)request->userData;
 
 			if (preq) {
-				if (finish_http_pack_request(preq) > 0)
+				if (finish_http_pack_request(preq) == 0)
 					fail = 0;
 				release_http_pack_request(preq);
 			}
-- 
1.6.5.2.181.gd6f41
