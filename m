From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Handle commit messages without new line at end correctly
Date: Wed, 29 Jun 2005 23:24:37 +0200
Message-ID: <20050629212437.GA14683@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Jun 29 23:21:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnjzw-00086s-Nb
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 23:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVF2V1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 17:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVF2V1h
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 17:27:37 -0400
Received: from [85.8.31.11] ([85.8.31.11]:56800 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S262680AbVF2VYm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 17:24:42 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 837CE40FD; Wed, 29 Jun 2005 23:25:12 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Dnk2v-0003r8-00; Wed, 29 Jun 2005 23:24:37 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Currently, if a commit message doesn't end with a new line the last
line in the message is omitted from the output. The following patch
fixes this bug.


Signed-Off-By: Fredrik Kuivinen <freku045@student.liu.se>
---

diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -202,11 +202,11 @@ static int get_one_line(const char *msg,
 
 	while (len--) {
 		char c = *msg++;
+		if (!c)
+			break;
 		ret++;
 		if (c == '\n')
 			break;
-		if (!c)
-			return 0;
 	}
 	return ret;
 }
