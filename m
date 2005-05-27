From: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Subject: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 15:20:52 +0200
Organization: oberhumer.com
Message-ID: <42971EB4.2050403@oberhumer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070601020809050200000006"
X-From: git-owner@vger.kernel.org Fri May 27 15:20:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbejg-0001qy-Hq
	for gcvg-git@gmane.org; Fri, 27 May 2005 15:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVE0NUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 09:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVE0NUW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 09:20:22 -0400
Received: from mail.servus.at ([193.170.194.20]:3597 "EHLO mail.servus.at")
	by vger.kernel.org with ESMTP id S262463AbVE0NTp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 09:19:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.servus.at (Postfix) with ESMTP id 934DB1E9607
	for <git@vger.kernel.org>; Fri, 27 May 2005 15:19:56 +0200 (CEST)
Received: from mail.servus.at ([127.0.0.1])
 by localhost (aarh.servus.at [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 73089-04 for <git@vger.kernel.org>;
 Fri, 27 May 2005 15:19:54 +0200 (CEST)
Received: from [83.164.47.228] (unknown [83.164.47.228])
	by mail.servus.at (Postfix) with ESMTP id 6D8001E961B
	for <git@vger.kernel.org>; Fri, 27 May 2005 15:19:54 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2-1.4.1.centos4 (X11/20050323)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-no-Archive: yes
X-Oberhumer-Conspiracy: There is no conspiracy. Trust us.
X-Virus-Scanned: amavisd-new at servus.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-Gmane-Expiry: 2005-06-10

This is a multi-part message in MIME format.
--------------070601020809050200000006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This trivial patch fixes an obvious ptrdiff_t vs. int mismatch. Which
makes we wonder why Linus isn't hitting this on his ppc64 - maybe it's
time to start using -Werror...

Signed-off-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/






--------------070601020809050200000006
Content-Type: text/x-patch;
 name="diff-tree.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-tree.c.patch"

This trivial patch fixes an obvious ptrdiff_t vs. int mismatch.

Signed-off-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>

Index: diff-tree.c
===================================================================
--- 1348af9952a1d26b2ad14ec8f433322fd79510f3/diff-tree.c  (mode:100644)
+++ 61dcf68d605a8d9204c24278dbdc73b4cf7ccc90/diff-tree.c  (mode:100644)
@@ -274,7 +274,7 @@
 			for (cp = header; *cp; cp = ep) {
 				ep = strchr(cp, '\n');
 				if (ep == 0) ep = cp + strlen(cp);
-				printf("%.*s%c", ep-cp, cp, 0);
+				printf("%.*s%c", (int) (ep-cp), cp, 0);
 				if (*ep) ep++;
 			}
 		}

--------------070601020809050200000006--
