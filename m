From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 31/38] refs: add method iterator_begin
Date: Fri,  3 Jun 2016 23:04:06 +0200
Message-ID: <3775f2713c0a8070b2a8424ae3d4176585748479.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:06:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wIV-0001b3-BF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbcFCVGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:09 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53980 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932290AbcFCVFV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:21 -0400
X-AuditID: 12074412-52fff700000009f7-25-5751f1119f6a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 28.A4.02551.111F1575; Fri,  3 Jun 2016 17:05:21 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcv003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:19 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqCv4MTDcYNIsKYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGdMOD2FveCpZMXjW1dYGhjfiXQx
	cnJICJhITLjUwNbFyMUhJLCVUeLe3T5mCOc4k8S0b9fYQKrYBHQlFvU0M4HYIgIREg2vWhhB
	ipgF5jBJ3H7YyQySEBYwk3j9cCMriM0ioCqxYM9SoGYODl6BKIm1a/UhtslJXJ7+AGwmp4CF
	RMvnVWDlQgLmEo2nDrNMYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0
	EyMk6IR2MK4/KXeIUYCDUYmHt+BZYLgQa2JZcWXuIUZJDiYlUd69d4BCfEn5KZUZicUZ8UWl
	OanFhxglOJiVRHhTXgPleFMSK6tSi/JhUtIcLErivD8Xq/sJCaQnlqRmp6YWpBbBZGU4OJQk
	eOU/ADUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2IgvhgYBSApHqC93CDtvMUF
	iblAUYjWU4yKUuK8h94DJQRAEhmleXBjYankFaM40JfCvMkgVTzANATX/QpoMBPQ4IJH/iCD
	SxIRUlINjK7ffh+0d2Gv7FOO17VU7/SfzbRo//XDSy1Z1L8+57A9o3mt5uivxZa7L53x4GKt
	uGL8pr6BzyintD716zWfq6yfJodvuTqNY8K3p68tOPtnrGE8t/Td0QrpTwem9rA+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296395>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  2 +-
 refs/files-backend.c |  3 ++-
 refs/refs-internal.h | 24 ++++++++++++------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index bda8fc1..d1ab20b 100644
--- a/refs.c
+++ b/refs.c
@@ -1157,7 +1157,7 @@ static int do_for_each_ref(const char *submodule, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = files_ref_iterator_begin(refs, prefix, flags);
+	iter = refs->be->iterator_begin(refs, prefix, flags);
 	iter = prefix_ref_iterator_begin(iter, prefix, trim);
 
 	return do_for_each_ref_iterator(iter, fn, cb_data);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6699ad3..40c05b2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1866,7 +1866,7 @@ struct ref_iterator_vtable files_ref_iterator_vtable = {
 	files_ref_iterator_abort
 };
 
-struct ref_iterator *files_ref_iterator_begin(
+static struct ref_iterator *files_ref_iterator_begin(
 		struct ref_store *ref_store,
 		const char *prefix, unsigned int flags)
 {
@@ -4047,6 +4047,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 
+	files_ref_iterator_begin,
 	files_read_raw_ref,
 	files_verify_refname_available
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a5caecc..797d44f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -399,18 +399,6 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 					       const char *prefix,
 					       int trim);
 
-struct ref_store;
-
-/*
- * Iterate over the packed and loose references in the specified
- * ref_store that are within find_containing_dir(prefix). If prefix is
- * NULL or the empty string, iterate over all references in the
- * submodule.
- */
-struct ref_iterator *files_ref_iterator_begin(struct ref_store *ref_store,
-					      const char *prefix,
-					      unsigned int flags);
-
 /*
  * Iterate over the references in the main ref_store that have a
  * reflog. The paths within a directory are iterated over in arbitrary
@@ -483,6 +471,8 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 
 /* refs backends */
 
+struct ref_store;
+
 /*
  * Initialize the ref_store for the specified submodule, or for the
  * main repository if submodule == NULL. These functions should call
@@ -504,6 +494,15 @@ typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *logmsg);
 
 /*
+ * Iterate over the references in the specified ref_store that are
+ * within find_containing_dir(prefix). If prefix is NULL or the empty
+ * string, iterate over all references in the submodule.
+ */
+typedef struct ref_iterator *ref_iterator_begin_fn(
+		struct ref_store *ref_store,
+		const char *prefix, unsigned int flags);
+
+/*
  * Read a reference from the specified reference store, non-recursively.
  * Set type to describe the reference, and:
  *
@@ -561,6 +560,7 @@ struct ref_storage_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 
+	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
 };
-- 
2.8.1
