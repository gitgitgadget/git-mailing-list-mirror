From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/6] sha1_file.c: don't ignore an error condition in
 sha1_loose_object_info()
Date: Mon, 26 Feb 2007 14:55:57 -0500
Message-ID: <11725197622423-git-send-email-nico@cam.org>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org>
 <11725197613482-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:56:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlxa-0004Dt-JE
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbXBZT4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbXBZT4I
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:56:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35563 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030499AbXBZT4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:56:05 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE3007SW61CD1Q1@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 14:56:03 -0500 (EST)
In-reply-to: <11725197613482-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.572.ge86d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40656>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8147a4f..8b7b68c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1461,7 +1461,7 @@ static int sha1_loose_object_info(const unsigned char *sha1, char *type, unsigne
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
-	if (parse_sha1_header(hdr, type, &size) < 0)
+	else if (parse_sha1_header(hdr, type, &size) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	else {
 		status = 0;
-- 
1.5.0.572.ge86d
