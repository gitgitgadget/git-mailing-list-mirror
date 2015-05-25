From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 55/56] warn_if_dangling_symref(): convert local variable "junk" to object_id
Date: Mon, 25 May 2015 18:39:21 +0000
Message-ID: <1432579162-411464-56-git-send-email-sandals@crustytoothpaste.net>
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
	id 1YwxJO-0001Mp-MP
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbbEYSlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:07 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50739 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751518AbbEYSki (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A572D280A4;
	Mon, 25 May 2015 18:40:35 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269871>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 162760c..7515c2e 100644
--- a/refs.c
+++ b/refs.c
@@ -1757,7 +1757,7 @@ int ref_exists(const char *refname)
 }
 
 static int filter_refs(const char *refname, const struct object_id *oid,
-		       int flags, void *data)
+			   int flags, void *data)
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 
@@ -1903,12 +1903,12 @@ static int warn_if_dangling_symref(const char *refname, const struct object_id *
 {
 	struct warn_if_dangling_data *d = cb_data;
 	const char *resolves_to;
-	unsigned char junk[20];
+	struct object_id junk;
 
 	if (!(flags & REF_ISSYMREF))
 		return 0;
 
-	resolves_to = resolve_ref_unsafe(refname, 0, junk, NULL);
+	resolves_to = resolve_ref_unsafe(refname, 0, junk.hash, NULL);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
-- 
2.4.0
