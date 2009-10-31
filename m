From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 01/28] http-push: fix check condition on http.c::finish_http_pack_request()
Date: Fri, 30 Oct 2009 17:47:20 -0700
Message-ID: <1256950067-27938-3-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N428b-0001cH-Jh
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbZJaAr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757585AbZJaArx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:47:53 -0400
Received: from george.spearce.org ([209.20.77.23]:36903 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563AbZJaArp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:47:45 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5007738239; Sat, 31 Oct 2009 00:47:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8DA88381FF;
	Sat, 31 Oct 2009 00:47:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131787>

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
