From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 26/56] show_ref(): convert local variable peeled to object_id
Date: Mon, 25 May 2015 18:38:52 +0000
Message-ID: <1432579162-411464-27-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIq-00013c-7i
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbbEYSkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:31 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50652 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417AbbEYSkS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:18 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 35E7A2809E;
	Mon, 25 May 2015 18:40:17 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269862>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-ref.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 18f84fb..dfbc314 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -30,7 +30,7 @@ static int show_ref(const char *refname, const struct object_id *oid,
 		    int flag, void *cbdata)
 {
 	const char *hex;
-	unsigned char peeled[20];
+	struct object_id peeled;
 
 	if (show_head && !strcmp(refname, "HEAD"))
 		goto match;
@@ -82,8 +82,8 @@ match:
 	if (!deref_tags)
 		return 0;
 
-	if (!peel_ref(refname, peeled)) {
-		hex = find_unique_abbrev(peeled, abbrev);
+	if (!peel_ref(refname, peeled.hash)) {
+		hex = find_unique_abbrev(peeled.hash, abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
 	return 0;
-- 
2.4.0
