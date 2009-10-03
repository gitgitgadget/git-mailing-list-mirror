From: Johan Sageryd <j416@1616.se>
Subject: [PATCH] Fix '--relative-date'
Date: Sat,  3 Oct 2009 13:20:18 +0900
Message-ID: <1254543618-3772-1-git-send-email-j416@1616.se>
Cc: Johan Sageryd <j416@1616.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 06:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtwWn-0004eG-5Z
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 06:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbZJCEpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 00:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbZJCEpd
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 00:45:33 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:39293 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbZJCEpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 00:45:33 -0400
X-Greylist: delayed 1506 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Oct 2009 00:45:33 EDT
Received: from mail.1616.se (attsi1-src.asahi-net.or.jp [220.157.253.2])
	by mail1.asahi-net.or.jp (Postfix) with ESMTP id 1C25A741F0
	for <git@vger.kernel.org>; Sat,  3 Oct 2009 13:20:30 +0900 (JST)
Received: by mail.1616.se (Postfix, from userid 501)
	id E83421A78EA9; Sat,  3 Oct 2009 13:20:30 +0900 (JST)
X-Mailer: git-send-email 1.6.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129478>

This fixes '--relative-date' so that it does not give '0 year, 12 months', for the interval 360 <= diff < 365.

Signed-off-by: Johan Sageryd <j416@1616.se>
---
 date.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index e9ee4aa..5d05ef6 100644
--- a/date.c
+++ b/date.c
@@ -123,7 +123,7 @@ const char *show_date_relative(unsigned long time, int tz,
 		return timebuf;
 	}
 	/* Say months for the past 12 months or so */
-	if (diff < 360) {
+	if (diff < 365) {
 		snprintf(timebuf, timebuf_size, "%lu months ago", (diff + 15) / 30);
 		return timebuf;
 	}
-- 
1.6.4.4
