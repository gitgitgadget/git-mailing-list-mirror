From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 51/56] mark_complete(): remove unneeded arguments
Date: Mon, 25 May 2015 18:39:17 +0000
Message-ID: <1432579162-411464-52-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJV-0001Qj-Kk
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbbEYSlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:18 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50768 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751503AbbEYSkf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:35 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AC0142809E;
	Mon, 25 May 2015 18:40:33 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269876>

From: Michael Haggerty <mhagger@alum.mit.edu>

Now that the function is not being used as an each_ref_sha1_fn, we can
delete the unused arguments in its signature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index d7a4a48..13a5000 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -469,7 +469,7 @@ done:
 
 static struct commit_list *complete;
 
-static int mark_complete(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int mark_complete(const unsigned char *sha1)
 {
 	struct object *o = parse_object(sha1);
 
@@ -493,7 +493,7 @@ static int mark_complete(const char *refname, const unsigned char *sha1, int fla
 static int mark_complete_oid(const char *refname, const struct object_id *oid,
 			     int flag, void *cb_data)
 {
-	return mark_complete(refname, oid->hash, flag, cb_data);
+	return mark_complete(oid->hash);
 }
 
 static void mark_recent_complete_commits(struct fetch_pack_args *args,
@@ -573,7 +573,7 @@ static void filter_refs(struct fetch_pack_args *args,
 
 static void mark_alternate_complete(const struct ref *ref, void *unused)
 {
-	mark_complete(NULL, ref->old_sha1, 0, NULL);
+	mark_complete(ref->old_sha1);
 }
 
 static int everything_local(struct fetch_pack_args *args,
-- 
2.4.0
