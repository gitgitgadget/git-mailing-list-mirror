From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 32/56] add_ref_decoration(): convert local variable original_sha1 to object_id
Date: Mon, 25 May 2015 18:38:58 +0000
Message-ID: <1432579162-411464-33-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxK5-0001jF-4R
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbbEYSl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:57 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50695 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751432AbbEYSkW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C117828093;
	Mon, 25 May 2015 18:40:20 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269888>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 log-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index abf5cc3..01beb11 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -98,14 +98,14 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 	assert(cb_data == NULL);
 
 	if (starts_with(refname, "refs/replace/")) {
-		unsigned char original_sha1[20];
+		struct object_id original_oid;
 		if (!check_replace_refs)
 			return 0;
-		if (get_sha1_hex(refname + 13, original_sha1)) {
+		if (get_oid_hex(refname + 13, &original_oid)) {
 			warning("invalid replace ref %s", refname);
 			return 0;
 		}
-		obj = parse_object(original_sha1);
+		obj = parse_object(original_oid.hash);
 		if (obj)
 			add_name_decoration(DECORATION_GRAFTED, "replaced", obj);
 		return 0;
-- 
2.4.0
