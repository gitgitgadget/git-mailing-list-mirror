From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 3/3] base85: Make the code more obvious instead of explaining the non-obvious
Date: Fri,  8 Jan 2010 14:40:00 +0100
Message-ID: <1262958000-27181-3-git-send-email-agruen@suse.de>
References: <alpine.LFD.2.00.1001071253400.21025@xanadu.home>
Cc: Andreas Gruenbacher <agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 14:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTFEa-0006rC-JX
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 14:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab0AHNuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 08:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299Ab0AHNua
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 08:50:30 -0500
Received: from mail09.linbit.com ([212.69.161.110]:43938 "EHLO
	mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab0AHNua (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 08:50:30 -0500
Received: from murkel-lan.suse.de (unknown [78.142.182.101])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C6B8C1072EE6;
	Fri,  8 Jan 2010 14:42:46 +0100 (CET)
Received: by murkel-lan.suse.de (Postfix, from userid 1000)
	id 0DDC93A142; Fri,  8 Jan 2010 14:40:06 +0100 (CET)
X-Mailer: git-send-email 1.6.6.75.g37bae
In-Reply-To: <alpine.LFD.2.00.1001071253400.21025@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136434>

Here is another cleanup ...

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 base85.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/base85.c b/base85.c
index 7204ce2..e459fee 100644
--- a/base85.c
+++ b/base85.c
@@ -57,14 +57,8 @@ int decode_85(char *dst, const char *buffer, int len)
 		de = de85[ch];
 		if (--de < 0)
 			return error("invalid base85 alphabet %c", ch);
-		/*
-		 * Detect overflow.  The largest
-		 * 5-letter possible is "|NsC0" to
-		 * encode 0xffffffff, and "|NsC" gives
-		 * 0x03030303 at this point (i.e.
-		 * 0xffffffff = 0x03030303 * 85).
-		 */
-		if (0x03030303 < acc ||
+		/* Detect overflow. */
+		if (0xffffffff / 85 < acc ||
 		    0xffffffff - de < (acc *= 85))
 			return error("invalid base85 sequence %.5s", buffer-5);
 		acc += de;
-- 
1.6.6.75.g37bae
