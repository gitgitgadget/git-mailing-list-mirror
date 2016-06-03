From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/38] add_packed_ref(): add a files_ref_store argument
Date: Fri,  3 Jun 2016 23:03:41 +0200
Message-ID: <9f629d0d60f77414961b966ddbd00eff32014037.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ3-00025e-Js
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946AbcFCVGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:38 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47042 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752970AbcFCVEg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:36 -0400
X-AuditID: 1207440d-bb3ff7000000090b-c7-5751f0e32f31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 53.32.02315.3E0F1575; Fri,  3 Jun 2016 17:04:35 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcW003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:33 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqPv4Q2C4QedTWYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGfcXruVveA9T8WMhToNjK+4uhg5
	OSQETCS+33vH2sXIxSEksJVR4sjcA8wQznEmiTmTdjCCVLEJ6Eos6mlmArFFBCIkGl61MIIU
	MQvMYZK4/bCTGSQhLOAuMeP8QTYQm0VAVeLg9tlgDbwCURIXjqxmhlgnJ3F5+gOwGk4BC4mW
	z6tYQWwhAXOJxlOHWSYw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJ
	ERJ0vDsY/6+TOcQowMGoxMN74kVguBBrYllxZe4hRkkOJiVR3r13gEJ8SfkplRmJxRnxRaU5
	qcWHGCU4mJVEeFNeA+V4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
	i94DNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYiC+GBgFICkeoL3nQNp5iwsS
	c4GiEK2nGBWlxHkPgSQEQBIZpXlwY2Gp5BWjONCXwry3Qap4gGkIrvsV0GAmoMEFj/xBBpck
	IqSkGhinij8Iv6iewLYrSuDyqy6HLJF7dRszNtlUHstOe6/18Z5KXEz+vKTFi5fnbzyT6CQX
	sWtO+lSZ71pzM15k109ckVrsbv9fU0Ypw9d6hRiTh8R1r4PbV0ftP3k04fzBxo3S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296399>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8ef79c2..5bfa912 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1196,10 +1196,9 @@ static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
  * lock_packed_refs()).  To actually write the packed-refs file, call
  * commit_packed_refs().
  */
-static void add_packed_ref(const char *refname, const unsigned char *sha1)
+static void add_packed_ref(struct files_ref_store *refs,
+			   const char *refname, const unsigned char *sha1)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "add_packed_ref");
 	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
 	if (!packed_ref_cache->lock)
@@ -3873,6 +3872,8 @@ static int ref_present(const char *refname,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "initial_ref_transaction_commit");
 	int ret = 0, i;
 	struct ref_update **updates = transaction->updates;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
@@ -3932,7 +3933,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 
 		if ((update->flags & REF_HAVE_NEW) &&
 		    !is_null_sha1(update->new_sha1))
-			add_packed_ref(update->refname, update->new_sha1);
+			add_packed_ref(refs, update->refname, update->new_sha1);
 	}
 
 	if (commit_packed_refs()) {
-- 
2.8.1
