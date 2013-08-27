From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 19/23] pack v4: relax commit parsing a bit
Date: Tue, 27 Aug 2013 00:26:03 -0400
Message-ID: <1377577567-27655-20-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:26:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEArX-000780-1o
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab3H0E0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab3H0E0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:34 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600G0G9O51090@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 07DF82DA056B	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:30 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233049>

At least commit af25e94d4dcfb9608846242fabdd4e6014e5c9f0 in the Linux
kernel repository has "author  <> 1120285620 -0700"

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 2d46d11..63dc3d2 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -157,12 +157,12 @@ static char *get_nameend_and_tz(char *from, int *tz_val)
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
1.8.4.22.g54757b7
