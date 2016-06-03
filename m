From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 30/38] files_ref_iterator_begin(): take a ref_store argument
Date: Fri,  3 Jun 2016 23:04:05 +0200
Message-ID: <74aa9408e6ff1f0e26cd424d27e43c3606eb5a80.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ0-00025e-4a
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbcFCVGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:14 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61312 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422666AbcFCVFV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:21 -0400
X-AuditID: 1207440c-c3fff70000000b85-ff-5751f10f37e9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 21.65.02949.F01F1575; Fri,  3 Jun 2016 17:05:19 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcu003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:17 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqMv/MTDc4M1XJYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGdsv/OMveCjUMWO/l6mBsZV/F2M
	HBwSAiYSq67VdjFycQgJbGWUmLmmjxXCOc4k0TjlCksXIycHm4CuxKKeZiYQW0QgQqLhVQsj
	SBGzwBwmidsPO5lBEsICPhJPL3xiA7FZBFQlLjx5DhbnFYiS+NbRxA5iSwjISVye/gCshlPA
	QqLl8ypWEFtIwFyi8dRhlgmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWm
	lG5ihAQdzw7Gb+tkDjEKcDAq8fAWPAsMF2JNLCuuzD3EKMnBpCTKu/cOUIgvKT+lMiOxOCO+
	qDQntfgQowQHs5IIb8proBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFqEUxWhoND
	SYJ30XugRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQDMQXA6MAJMUDtPccSDtv
	cUFiLlAUovUUo6KUOO8hkIQASCKjNA9uLCyVvGIUB/pSmPc2SBUPMA3Bdb8CGswENLjgkT/I
	4JJEhJRUA2N6+zy5yLQzOpY1JZulttTIzepuzP765O3b2qd/tusa/TVWmFvOt+XFxfiQxF3+
	R3MfXwidttFE7P46DqaEra1198W6Xr86J1Ujc3gNt6/9EvbkpuMZQhcbdzxKfF/Q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296403>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 2 +-
 refs/files-backend.c | 4 ++--
 refs/refs-internal.h | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 2d84c5c..bda8fc1 100644
--- a/refs.c
+++ b/refs.c
@@ -1157,7 +1157,7 @@ static int do_for_each_ref(const char *submodule, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = files_ref_iterator_begin(submodule, prefix, flags);
+	iter = files_ref_iterator_begin(refs, prefix, flags);
 	iter = prefix_ref_iterator_begin(iter, prefix, trim);
 
 	return do_for_each_ref_iterator(iter, fn, cb_data);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8d3cf96..6699ad3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1867,11 +1867,11 @@ struct ref_iterator_vtable files_ref_iterator_vtable = {
 };
 
 struct ref_iterator *files_ref_iterator_begin(
-		const char *submodule,
+		struct ref_store *ref_store,
 		const char *prefix, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(submodule, "ref_iterator_begin");
+		files_downcast(ref_store, 1, "ref_iterator_begin");
 	struct ref_dir *loose_dir, *packed_dir;
 	struct ref_iterator *loose_iter, *packed_iter;
 	struct files_ref_iterator *iter;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ae67b49..a5caecc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -399,13 +399,15 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 					       const char *prefix,
 					       int trim);
 
+struct ref_store;
+
 /*
  * Iterate over the packed and loose references in the specified
- * submodule that are within find_containing_dir(prefix). If prefix is
+ * ref_store that are within find_containing_dir(prefix). If prefix is
  * NULL or the empty string, iterate over all references in the
  * submodule.
  */
-struct ref_iterator *files_ref_iterator_begin(const char *submodule,
+struct ref_iterator *files_ref_iterator_begin(struct ref_store *ref_store,
 					      const char *prefix,
 					      unsigned int flags);
 
@@ -479,8 +481,6 @@ extern struct ref_iterator *current_ref_iter;
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);
 
-struct ref_store;
-
 /* refs backends */
 
 /*
-- 
2.8.1
