From: Florian Forster <octo@verplant.org>
Subject: [PATCH 4/7] Cast pointers to `void *' when used in a format.
Date: Sun, 18 Jun 2006 17:18:06 +0200
Message-ID: <11506438893167-git-send-email-octo@verplant.org>
References: <11506438892551-git-send-email-octo@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 17:18:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frz2Z-0005I9-2M
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 17:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWFRPSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 11:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWFRPSR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 11:18:17 -0400
Received: from verplant.org ([213.95.21.52]:36233 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1751175AbWFRPSN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 11:18:13 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Frz2S-0004Za-8r; Sun, 18 Jun 2006 17:18:12 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1Frz2P-00028O-BM; Sun, 18 Jun 2006 17:18:09 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
In-Reply-To: <11506438892551-git-send-email-octo@verplant.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22084>

ANSI C99 requires void-pointers when using the `%p' format. This patch adds the
neccessary cast in `blame.c'.

Signed-off-by: Florian Forster <octo@verplant.org>


---

 blame.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

372bb52dd567d39c3e64919e100ae9bd8af603ca
diff --git a/blame.c b/blame.c
index 25d3bcf..51eab2e 100644
--- a/blame.c
+++ b/blame.c
@@ -301,9 +301,9 @@ static void fill_line_map(struct commit 
 				if (DEBUG)
 					printf("map: i1: %d %d %p i2: %d %d %p\n",
 					       i1, map[i1],
-					       i1 != -1 ? blame_lines[map[i1]] : NULL,
+					       (void *) (i1 != -1 ? blame_lines[map[i1]] : NULL),
 					       i2, map2[i2],
-					       i2 != -1 ? blame_lines[map2[i2]] : NULL);
+					       (void *) (i2 != -1 ? blame_lines[map2[i2]] : NULL));
 				if (map2[i2] != -1 &&
 				    blame_lines[map[i1]] &&
 				    !blame_lines[map2[i2]])
-- 
1.3.3
