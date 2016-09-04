Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E021F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754435AbcIDQMB (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:01 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54584 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754356AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 1207440d-be3ff700000008af-2c-57cc4751a819
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 86.86.02223.1574CC75; Sun,  4 Sep 2016 12:09:54 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5s026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>,
        Ronnie Sahlberg <rsahlberg@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 32/38] refs: add methods for reflog
Date:   Sun,  4 Sep 2016 18:08:38 +0200
Message-Id: <8b427ea913f4456869ff7bfeede887386f27e118.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqBvsfibc4H+axfxNJxgtuq50M1k0
        9F5htri9Yj6zxZKHr5ktuqe8ZbT40dLDbDHzqrVFy9N3LBZn3jQyOnB5/H3/gclj56y77B4L
        NpV6dLUfYfN41ruH0ePiJWWP/Uu3sXksfuDlseD5fXaPz5vkAriiuGxSUnMyy1KL9O0SuDLm
        TZjOXDApqGLt+n0sDYyTnbsYOTkkBEwk9t6fxdjFyMUhJLCVUeLf0kksEM5JJol7RzrZQarY
        BHQlFvU0M4HYIgJqEhPbDoEVMQusYZb4tn0mK0hCWMBMornjCguIzSKgKvGmczsjiM0rECXR
        8u0kI8Q6OYlL274wg9icAhYSZ3bPBbI5gLaZS7S/yJ7AyLOAkWEVo1xiTmmubm5iZk5xarJu
        cXJiXl5qka6RXm5miV5qSukmRkhY8u5g/L9O5hCjAAejEg+vhfaZcCHWxLLiytxDjJIcTEqi
        vLMOngwX4kvKT6nMSCzOiC8qzUktPsQowcGsJMKr7QJUzpuSWFmVWpQPk5LmYFES51Vbou4n
        JJCeWJKanZpakFoEk5Xh4FCS4L3uCtQoWJSanlqRlplTgpBm4uAEGc4DNPwmSA1vcUFibnFm
        OkT+FKOilDjvS5CEAEgiozQPrheWNl4xigO9Isyr6AZUxQNMOXDdr4AGMwENXrf7NMjgkkSE
        lFQDY9sPm4incitt3boOeBr3VR5O7f8/o8q+v6Dy0bxbcyvnFltv2LT4reNOlds7rYrNNz09
        Zh9e6WrpfVzT+SEj873vwZ2VT5nSn82sTBVPerXW3ivdTvanVOi0PXfXvGXX/hUtm9cpuDbl
        y0el/V3tvO9dNrboJhk85F+xK+frVPt3zsbWq4N8lFiKMxINtZiLihMB+YV6wvYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

In the file-based backend, the reflog piggybacks on the ref lock.
Since other backends won't have the same sort of ref lock, ref backends
must also handle reflogs.

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 70 +++++++++++++++++++++++++++++++++++++---------------
 refs/refs-internal.h | 44 +++++++++++++++++++++++++++------
 3 files changed, 150 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 798b08a..cb9d805 100644
--- a/refs.c
+++ b/refs.c
@@ -1461,3 +1461,66 @@ int verify_refname_available(const char *refname,
 
 	return refs->be->verify_refname_available(refs, refname, extra, skip, err);
 }
+
+int for_each_reflog(each_ref_fn fn, void *cb_data)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_iterator *iter;
+
+	iter = refs->be->reflog_iterator_begin(refs);
+
+	return do_for_each_ref_iterator(iter, fn, cb_data);
+}
+
+int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
+				void *cb_data)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->for_each_reflog_ent_reverse(refs, refname,
+						     fn, cb_data);
+}
+
+int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
+			void *cb_data)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->for_each_reflog_ent(refs, refname, fn, cb_data);
+}
+
+int reflog_exists(const char *refname)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->reflog_exists(refs, refname);
+}
+
+int safe_create_reflog(const char *refname, int force_create,
+		       struct strbuf *err)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->create_reflog(refs, refname, force_create, err);
+}
+
+int delete_reflog(const char *refname)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->delete_reflog(refs, refname);
+}
+
+int reflog_expire(const char *refname, const unsigned char *sha1,
+		  unsigned int flags,
+		  reflog_expiry_prepare_fn prepare_fn,
+		  reflog_expiry_should_prune_fn should_prune_fn,
+		  reflog_expiry_cleanup_fn cleanup_fn,
+		  void *policy_cb_data)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->reflog_expire(refs, refname, sha1, flags,
+				       prepare_fn, should_prune_fn,
+				       cleanup_fn, policy_cb_data);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4451e13..a810dfa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2777,11 +2777,16 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 }
 
 
-int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
+static int files_create_reflog(struct ref_store *ref_store,
+			       const char *refname, int force_create,
+			       struct strbuf *err)
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
 
+	/* Check validity (but we don't need the result): */
+	files_downcast(ref_store, 0, "create_reflog");
+
 	ret = log_ref_setup(refname, &sb, err, force_create);
 	strbuf_release(&sb);
 	return ret;
@@ -3075,16 +3080,24 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	return ret;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(struct ref_store *ref_store,
+			       const char *refname)
 {
 	struct stat st;
 
+	/* Check validity (but we don't need the result): */
+	files_downcast(ref_store, 0, "reflog_exists");
+
 	return !lstat(git_path("logs/%s", refname), &st) &&
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(struct ref_store *ref_store,
+			       const char *refname)
 {
+	/* Check validity (but we don't need the result): */
+	files_downcast(ref_store, 0, "delete_reflog");
+
 	return remove_path(git_path("logs/%s", refname));
 }
 
@@ -3127,13 +3140,19 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
+					     const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
 	long pos;
 	int ret = 0, at_tail = 1;
 
+	/* Check validity (but we don't need the result): */
+	files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
+
 	logfp = fopen(git_path("logs/%s", refname), "r");
 	if (!logfp)
 		return -1;
@@ -3229,12 +3248,17 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(struct ref_store *ref_store,
+				     const char *refname,
+				     each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 
+	/* Check validity (but we don't need the result): */
+	files_downcast(ref_store, 0, "for_each_reflog_ent");
+
 	logfp = fopen(git_path("logs/%s", refname), "r");
 	if (!logfp)
 		return -1;
@@ -3313,22 +3337,19 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	files_reflog_iterator_abort
 };
 
-struct ref_iterator *files_reflog_iterator_begin(void)
+static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 
+	/* Check validity (but we don't need the result): */
+	files_downcast(ref_store, 0, "reflog_iterator_begin");
+
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
 	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
 	return ref_iterator;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref_iterator(files_reflog_iterator_begin(),
-					fn, cb_data);
-}
-
 static int ref_update_reject_duplicates(struct string_list *refnames,
 					struct strbuf *err)
 {
@@ -3935,15 +3956,16 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-int reflog_expire(const char *refname, const unsigned char *sha1,
-		 unsigned int flags,
-		 reflog_expiry_prepare_fn prepare_fn,
-		 reflog_expiry_should_prune_fn should_prune_fn,
-		 reflog_expiry_cleanup_fn cleanup_fn,
-		 void *policy_cb_data)
+static int files_reflog_expire(struct ref_store *ref_store,
+			       const char *refname, const unsigned char *sha1,
+			       unsigned int flags,
+			       reflog_expiry_prepare_fn prepare_fn,
+			       reflog_expiry_should_prune_fn should_prune_fn,
+			       reflog_expiry_cleanup_fn cleanup_fn,
+			       void *policy_cb_data)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "reflog_expire");
+		files_downcast(ref_store, 0, "reflog_expire");
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
@@ -4056,5 +4078,13 @@ struct ref_storage_be refs_be_files = {
 
 	files_ref_iterator_begin,
 	files_read_raw_ref,
-	files_verify_refname_available
+	files_verify_refname_available,
+
+	files_reflog_iterator_begin,
+	files_for_each_reflog_ent,
+	files_for_each_reflog_ent_reverse,
+	files_reflog_exists,
+	files_create_reflog,
+	files_delete_reflog,
+	files_reflog_expire
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5be62a2..a20b622 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -404,13 +404,6 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 					       const char *prefix,
 					       int trim);
 
-/*
- * Iterate over the references in the main ref_store that have a
- * reflog. The paths within a directory are iterated over in arbitrary
- * order.
- */
-struct ref_iterator *files_reflog_iterator_begin(void);
-
 /* Internal implementation of reference iteration: */
 
 /*
@@ -507,6 +500,35 @@ typedef struct ref_iterator *ref_iterator_begin_fn(
 		struct ref_store *ref_store,
 		const char *prefix, unsigned int flags);
 
+/* reflog functions */
+
+/*
+ * Iterate over the references in the specified ref_store that have a
+ * reflog. The refs are iterated over in arbitrary order.
+ */
+typedef struct ref_iterator *reflog_iterator_begin_fn(
+		struct ref_store *ref_store);
+
+typedef int for_each_reflog_ent_fn(struct ref_store *ref_store,
+				   const char *refname,
+				   each_reflog_ent_fn fn,
+				   void *cb_data);
+typedef int for_each_reflog_ent_reverse_fn(struct ref_store *ref_store,
+					   const char *refname,
+					   each_reflog_ent_fn fn,
+					   void *cb_data);
+typedef int reflog_exists_fn(struct ref_store *ref_store, const char *refname);
+typedef int create_reflog_fn(struct ref_store *ref_store, const char *refname,
+			     int force_create, struct strbuf *err);
+typedef int delete_reflog_fn(struct ref_store *ref_store, const char *refname);
+typedef int reflog_expire_fn(struct ref_store *ref_store,
+			     const char *refname, const unsigned char *sha1,
+			     unsigned int flags,
+			     reflog_expiry_prepare_fn prepare_fn,
+			     reflog_expiry_should_prune_fn should_prune_fn,
+			     reflog_expiry_cleanup_fn cleanup_fn,
+			     void *policy_cb_data);
+
 /*
  * Read a reference from the specified reference store, non-recursively.
  * Set type to describe the reference, and:
@@ -568,6 +590,14 @@ struct ref_storage_be {
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
+
+	reflog_iterator_begin_fn *reflog_iterator_begin;
+	for_each_reflog_ent_fn *for_each_reflog_ent;
+	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
+	reflog_exists_fn *reflog_exists;
+	create_reflog_fn *create_reflog;
+	delete_reflog_fn *delete_reflog;
+	reflog_expire_fn *reflog_expire;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.9.3

