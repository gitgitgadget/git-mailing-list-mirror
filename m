From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Use long for timezone in pretty.c:show_ident_date()
Date: Fri,  7 Mar 2014 13:47:56 -0500
Message-ID: <1394218076-70398-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 19:57:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLzxh-00088Q-C3
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 19:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbaCGS5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 13:57:33 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:43819 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbaCGS5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 13:57:32 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Mar 2014 13:57:32 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 526B427364FC; Fri,  7 Mar 2014 18:48:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (u-of-rochester-128-151-150-17.wireless.rochester.edu [128.151.150.17])
	by silverinsanity.com (Postfix) with ESMTPA id BF95327364FA;
	Fri,  7 Mar 2014 18:48:01 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.281.gfc51f0a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243623>

The value is parsed with strtol and compared against LONG_MIN and
LONG_MAX, which doesn't make much sense for an int.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 pretty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 3b811ed..29ebc4f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -397,7 +397,7 @@ static const char *show_ident_date(const struct ident_split *ident,
 				   enum date_mode mode)
 {
 	unsigned long date = 0;
-	int tz = 0;
+	long tz = 0;
 
 	if (ident->date_begin && ident->date_end)
 		date = strtoul(ident->date_begin, NULL, 10);
-- 
1.9.0.281.gfc51f0a.dirty
