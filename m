Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4601F1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbcIDQNG (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:06 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55354 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754121AbcIDQNB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:01 -0400
X-AuditID: 12074414-c8fff70000000931-36-57cc47394b98
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id B6.9A.02353.9374CC75; Sun,  4 Sep 2016 12:09:29 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5f026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:27 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/38] refs: make read_raw_ref() virtual
Date:   Sun,  4 Sep 2016 18:08:25 +0200
Message-Id: <87a96792de01dcabfbd5adbf521d9110751c4987.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqGvpfibcoOu0nEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l9+hqP8Lm8ax3D6PH
        xUvKHvuXbmPzWPzAy+PzJrkAjigum5TUnMyy1CJ9uwSujJffljIVbFCqeHbnCUsD4xXpLkZO
        DgkBE4kZF0+xdDFycQgJbGWUaHiyggnCOckk8f/kSlaQKjYBXYlFPc1MILaIgJrExLZDYB3M
        IEWzJs5kB0kIC1hL/H7xGyjBwcEioCpx+4IiSJhXIEri/qmXjBDb5CQubfvCDGJzClhInNk9
        lxmkXEjAXKL9RfYERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUIC
        TmQH45GTcocYBTgYlXh4LbTPhAuxJpYVV+YeYpTkYFIS5Z118GS4EF9SfkplRmJxRnxRaU5q
        8SFGCQ5mJRFebRegct6UxMqq1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCd7r
        rkCNgkWp6akVaZk5JQhpJg5OkOE8QMNvgtTwFhck5hZnpkPkTzEqSonzvgRJCIAkMkrz4Hph
        CeEVozjQK8K8CW5AVTzAZALX/QpoMBPQ4HW7T4MMLklESEk1MArHqiqov9un8GavaabQvjNf
        O1fbbbz2ImaBvPerq/LSPEXv1v378qhF4Nv/p1PVFi6e8sZWeO8KVXeWe6tvxsUmvD142eCe
        uc8GrhWnP154/fcEP/PxgKmqiuYSFbXqtwVdjz9ueF5lm7j+6vuaQ24dAsfTrEx5tma4cC9+
        /edARNF+f+1z8jJKLMUZiYZazEXFiQC9re4t4wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reference backends will be able to customize this function to implement
reference reading.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               |  4 ++--
 refs/files-backend.c | 14 ++++++++------
 refs/refs-internal.h | 36 +++++++++++++++++++-----------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index e881874..7a7adeb 100644
--- a/refs.c
+++ b/refs.c
@@ -1251,8 +1251,8 @@ static const char *resolve_ref_recursively(struct ref_store *refs,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (read_raw_ref(refs, refname,
-				 sha1, &sb_refname, &read_flags)) {
+		if (refs->be->read_raw_ref(refs, refname,
+					   sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6382c6b..ff11a51 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1349,9 +1349,9 @@ static int resolve_packed_ref(struct files_ref_store *refs,
 	return -1;
 }
 
-int read_raw_ref(struct ref_store *ref_store,
-		 const char *refname, unsigned char *sha1,
-		 struct strbuf *referent, unsigned int *type)
+static int files_read_raw_ref(struct ref_store *ref_store,
+			      const char *refname, unsigned char *sha1,
+			      struct strbuf *referent, unsigned int *type)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, 1, "read_raw_ref");
@@ -1623,8 +1623,8 @@ static int lock_raw_ref(const char *refname, int mustexist,
 	 * fear that its value will change.
 	 */
 
-	if (read_raw_ref(ref_store, refname,
-			 lock->old_oid.hash, referent, type)) {
+	if (files_read_raw_ref(ref_store, refname,
+			       lock->old_oid.hash, referent, type)) {
 		if (errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
@@ -4029,5 +4029,7 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_ref_store_create,
-	files_transaction_commit
+	files_transaction_commit,
+
+	files_read_raw_ref
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fa41d51..19cb6e1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -486,6 +486,20 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 
 struct ref_store;
 
+/* refs backends */
+
+/*
+ * Initialize the ref_store for the specified submodule, or for the
+ * main repository if submodule == NULL. These functions should call
+ * base_ref_store_init() to initialize the shared part of the
+ * ref_store and to record the ref_store for later lookup.
+ */
+typedef struct ref_store *ref_store_init_fn(const char *submodule);
+
+typedef int ref_transaction_commit_fn(struct ref_store *refs,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err);
+
 /*
  * Read a reference from the specified reference store, non-recursively.
  * Set type to describe the reference, and:
@@ -524,29 +538,17 @@ struct ref_store;
  * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
-int read_raw_ref(struct ref_store *ref_store,
-		 const char *refname, unsigned char *sha1,
-		 struct strbuf *referent, unsigned int *type);
-
-/* refs backends */
-
-/*
- * Initialize the ref_store for the specified submodule, or for the
- * main repository if submodule == NULL. These functions should call
- * base_ref_store_init() to initialize the shared part of the
- * ref_store and to record the ref_store for later lookup.
- */
-typedef struct ref_store *ref_store_init_fn(const char *submodule);
-
-typedef int ref_transaction_commit_fn(struct ref_store *refs,
-				      struct ref_transaction *transaction,
-				      struct strbuf *err);
+typedef int read_raw_ref_fn(struct ref_store *ref_store,
+			    const char *refname, unsigned char *sha1,
+			    struct strbuf *referent, unsigned int *type);
 
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_store_init_fn *init;
 	ref_transaction_commit_fn *transaction_commit;
+
+	read_raw_ref_fn *read_raw_ref;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.9.3

