From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 21/38] pack v4: relax commit parsing a bit
Date: Thu, 05 Sep 2013 02:19:44 -0400
Message-ID: <1378362001-1738-22-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSwa-0008IS-NV
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757626Ab3IEGVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:21:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab3IEGUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:19 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00ANX2XQCY00@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 7F4D22DA05B8	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233916>

At least commit af25e94d4dcfb9608846242fabdd4e6014e5c9f0 in the Linux
kernel repository has "author  <> 1120285620 -0700"

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 45f8427..a9e9002 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -158,12 +158,12 @@ static char *get_nameend_and_tz(char *from, int *tz_val)
 	char *end, *tz;
 
 	tz = strchr(from, '\n');
-	/* let's assume the smallest possible string to be "x <x> 0 +0000\n" */
-	if (!tz || tz - from < 13)
+	/* let's assume the smallest possible string to be " <> 0 +0000\n" */
+	if (!tz || tz - from < 11)
 		return NULL;
 	tz -= 4;
 	end = tz - 4;
-	while (end - from > 5 && *end != ' ')
+	while (end - from > 3 && *end != ' ')
 		end--;
 	if (end[-1] != '>' || end[0] != ' ' || tz[-2] != ' ')
 		return NULL;
-- 
1.8.4.38.g317e65b
