From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/3] index-helper: convert strncpy to memcpy
Date: Mon, 11 Apr 2016 00:02:00 +0100
Message-ID: <570ADB68.8000705@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 01:02:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apOMu-00006Q-IV
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 01:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbcDJXCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 19:02:07 -0400
Received: from avasout08.plus.net ([212.159.14.20]:49856 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcDJXCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 19:02:06 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id gn221s0012D2Veb01n23tT; Mon, 11 Apr 2016 00:02:03 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=1QNrz07aY8PI1Upm9jUA:9 a=2WthAYlaspQDdI4r:21
 a=kgL4_f_MEteXxkh9:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291192>


see commit eddda371 ("convert strncpy to memcpy", 24-09-2015).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 index-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/index-helper.c b/index-helper.c
index 4a8e2ae..00f286a 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -317,7 +317,7 @@ static int setup_socket(const char *socket_path)
 		return -1;
 
 	address.sun_family = AF_UNIX;
-	strncpy(address.sun_path, socket_path, sizeof(address.sun_path));
+	memcpy(address.sun_path, socket_path, len+1); /* include '\0' */
 
 	if (bind(fd, (struct sockaddr *) &address, sizeof(address)))
 		die_errno(_("failed to bind to socket %s"), socket_path);
-- 
2.8.0
