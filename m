From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Simplify crud() in ident.c
Date: Mon, 3 Dec 2007 20:11:43 +0100
Message-ID: <20071203191143.GB17671@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 21:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzHeC-0001fV-4O
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 21:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbXLCULs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 15:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbXLCULr
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 15:11:47 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:15037 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXLCULr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 15:11:47 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzALVrg==
Received: from tigra.home (Fc94e.f.strato-dslnet.de [195.4.201.78])
	by post.webmailer.de (fruni mo37) (RZmta 14.5)
	with ESMTP id 40212cjB3IS4s4 ; Mon, 3 Dec 2007 21:11:44 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 658E2277AE;
	Mon,  3 Dec 2007 21:11:44 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 1140956D22; Mon,  3 Dec 2007 20:11:43 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66951>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Noticed it accidentally.

 ident.c |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/ident.c b/ident.c
index 9b2a852..dbd0f52 100644
--- a/ident.c
+++ b/ident.c
@@ -113,25 +113,15 @@ static int add_raw(char *buf, size_t size, int offset, const char *str)
 
 static int crud(unsigned char c)
 {
-	static char crud_array[256];
-	static int crud_array_initialized = 0;
-
-	if (!crud_array_initialized) {
-		int k;
-
-		for (k = 0; k <= 31; ++k) crud_array[k] = 1;
-		crud_array[' '] = 1;
-		crud_array['.'] = 1;
-		crud_array[','] = 1;
-		crud_array[':'] = 1;
-		crud_array[';'] = 1;
-		crud_array['<'] = 1;
-		crud_array['>'] = 1;
-		crud_array['"'] = 1;
-		crud_array['\''] = 1;
-		crud_array_initialized = 1;
-	}
-	return crud_array[c];
+	return  c <= 32  ||
+		c == '.' ||
+		c == ',' ||
+		c == ':' ||
+		c == ';' ||
+		c == '<' ||
+		c == '>' ||
+		c == '"' ||
+		c == '\'';
 }
 
 /*
-- 
1.5.3.6.1022.g35305
