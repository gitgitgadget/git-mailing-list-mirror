From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/4] Reformat ctype.c
Date: Sat, 17 Jan 2009 16:50:29 +0100
Message-ID: <1232207429.16172.105.camel@ubuntu.ubuntu-domain>
References: <4967D8F8.9070508@lsrfire.ath.cx>
	 <4967DB4A.2000702@lsrfire.ath.cx>
	 <81b0412b0901120732t1bd1978awdc4be47767e02863@mail.gmail.com>
	 <496B9780.3030000@lsrfire.ath.cx>
	 <7vy6xfd3oh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODT1-0003lH-Gk
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763360AbZAQPud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763086AbZAQPuc
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:50:32 -0500
Received: from india601.server4you.de ([85.25.151.105]:38801 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762726AbZAQPub (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:50:31 -0500
Received: from [10.0.1.101] (p57B7D6A5.dip.t-dialin.net [87.183.214.165])
	by india601.server4you.de (Postfix) with ESMTPSA id CDCCD2F81B7;
	Sat, 17 Jan 2009 16:50:29 +0100 (CET)
In-Reply-To: <7vy6xfd3oh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106071>

Enhance the readability of ctype.c by using an enum instead of macros
to initialize the character class table.  This allows the use of a single
letter to mark a char, making the table fit within 80 columns.

Also list the index of the last entry in each row in the following comment.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 ctype.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/ctype.c b/ctype.c
index 9208d67..6528687 100644
--- a/ctype.c
+++ b/ctype.c
@@ -5,25 +5,21 @@
  */
 #include "cache.h"
 
-/* Just so that no insane platform contaminate namespace with these symbols */
-#undef SS
-#undef AA
-#undef DD
-#undef GS
-
-#define SS GIT_SPACE
-#define AA GIT_ALPHA
-#define DD GIT_DIGIT
-#define GS GIT_SPECIAL  /* \0, *, ?, [, \\ */
+enum {
+	S = GIT_SPACE,
+	A = GIT_ALPHA,
+	D = GIT_DIGIT,
+	G = GIT_SPECIAL,	/* \0, *, ?, [, \\ */
+};
 
 unsigned char sane_ctype[256] = {
-	GS,  0,  0,  0,  0,  0,  0,  0,  0, SS, SS,  0,  0, SS,  0,  0,		/* 0-15 */
-	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 16-15 */
-	SS,  0,  0,  0,  0,  0,  0,  0,  0,  0, GS,  0,  0,  0,  0,  0,		/* 32-15 */
-	DD, DD, DD, DD, DD, DD, DD, DD, DD, DD,  0,  0,  0,  0,  0, GS,		/* 48-15 */
-	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 64-15 */
-	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, GS, GS,  0,  0,  0,		/* 80-15 */
-	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 96-15 */
-	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 112-15 */
+	G, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  16.. 31 */
+	S, 0, 0, 0, 0, 0, 0, 0, 0, 0, G, 0, 0, 0, 0, 0,		/*  32.. 47 */
+	D, D, D, D, D, D, D, D, D, D, 0, 0, 0, 0, 0, G,		/*  48.. 63 */
+	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
+	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, 0, 0,		/*  80.. 95 */
+	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
+	A, A, A, A, A, A, A, A, A, A, A, 0, 0, 0, 0, 0,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
-- 
1.6.1
