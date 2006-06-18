From: Florian Forster <octo@verplant.org>
Subject: [PATCH 2/7] Initialize FAMs using `FLEX_ARRAY'.
Date: Sun, 18 Jun 2006 17:18:04 +0200
Message-ID: <11506438893796-git-send-email-octo@verplant.org>
References: <1150643889264-git-send-email-octo@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 17:18:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frz2Y-0005I9-Ha
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 17:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWFRPSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 11:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWFRPSO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 11:18:14 -0400
Received: from verplant.org ([213.95.21.52]:35465 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1751164AbWFRPSN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 11:18:13 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Frz2R-0004ZY-V6; Sun, 18 Jun 2006 17:18:12 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1Frz2P-00028O-7V; Sun, 18 Jun 2006 17:18:09 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
In-Reply-To: <1150643889264-git-send-email-octo@verplant.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22087>

When initializing a `flexible array member' the macro `FLEX_ARRAY' should be
used. This was forgotten in `diff-delta.c'.

Signed-off-by: Florian Forster <octo@verplant.org>


---

 diff-delta.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

e587fd59510f2ed8326d280054d78cfb78d482dc
diff --git a/diff-delta.c b/diff-delta.c
index 25a798d..74486b1 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -22,6 +22,7 @@ #include <stdlib.h>
 #include <string.h>
 #include "delta.h"
 
+#include "git-compat-util.h"
 
 /* maximum hash entry list for the same hash bucket */
 #define HASH_LIMIT 64
@@ -131,7 +132,7 @@ struct delta_index {
 	const void *src_buf;
 	unsigned long src_size;
 	unsigned int hash_mask;
-	struct index_entry *hash[0];
+	struct index_entry *hash[FLEX_ARRAY];
 };
 
 struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
-- 
1.3.3
