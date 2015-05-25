From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 53/56] rev_list_insert_ref(): remove unneeded arguments
Date: Mon, 25 May 2015 18:39:19 +0000
Message-ID: <1432579162-411464-54-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJN-0001Mp-GT
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbbEYSlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:04 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50786 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751520AbbEYSki (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B53F1280A1;
	Mon, 25 May 2015 18:40:34 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269873>

From: Michael Haggerty <mhagger@alum.mit.edu>

Now that the function is not being used as an each_ref_sha1_fn, we can
delete the unused arguments in its signature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 28c54c3..a1dcb27 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -60,7 +60,7 @@ static void rev_list_push(struct commit *commit, int mark)
 	}
 }
 
-static int rev_list_insert_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int rev_list_insert_ref(const char *refname, const unsigned char *sha1)
 {
 	struct object *o = deref_tag(parse_object(sha1), refname, 0);
 
@@ -73,7 +73,7 @@ static int rev_list_insert_ref(const char *refname, const unsigned char *sha1, i
 static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
 				   int flag, void *cb_data)
 {
-	return rev_list_insert_ref(refname, oid->hash, flag, cb_data);
+	return rev_list_insert_ref(refname, oid->hash);
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
@@ -233,7 +233,7 @@ static void send_request(struct fetch_pack_args *args,
 
 static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 {
-	rev_list_insert_ref(NULL, ref->old_sha1, 0, NULL);
+	rev_list_insert_ref(NULL, ref->old_sha1);
 }
 
 #define INITIAL_FLUSH 16
-- 
2.4.0
