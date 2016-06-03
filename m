From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 32/38] refs: add methods for reflog
Date: Fri,  3 Jun 2016 23:04:07 +0200
Message-ID: <a2875a32847a605a95896646aae9ca88812b81f7.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Ronnie Sahlberg <rsahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:06:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wIW-0001b3-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbcFCVGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:18 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58673 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932967AbcFCVFY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:24 -0400
X-AuditID: 1207440e-f07ff700000008c5-e0-5751f11339e2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 73.78.02245.311F1575; Fri,  3 Jun 2016 17:05:23 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcw003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:21 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqCv8MTDcYNdGSYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbdHy9B2LxZk3jYwOnB5/339g8tg56y67x4JNpR7P
	evcwely8pOyxf+k2No/FD7w8Fjy/z+7xeZNcAGcUt01SYklZcGZ6nr5dAnfGwWlT2QuaQypO
	P+1kamC869LFyMkhIWAi8frvBFYQW0hgK6PE1VWFXYxcQPZxJokbs78wgSTYBHQlFvU0g9ki
	AhESDa9aGEGKmAXOMklMPb0CLCEsYCxxYfouRhCbRUBVYv2VM2BxXoEoiaebzzJCbJOTuDz9
	ARuIzSlgIdHyeRXUZnOJxlOHWSYw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGusl5tZ
	opeaUrqJERKGfDsY29fLHGIU4GBU4uEteBYYLsSaWFZcmXuIUZKDSUmUd+8doBBfUn5KZUZi
	cUZ8UWlOavEhRgkOZiUR3pTXQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpis
	DAeHkgTvovdAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgGIgvBkYBSIoHaC/3
	B5C9xQWJuUBRiNZTjIpS4ryHQOYKgCQySvPgxsKSyytGcaAvhXn7Qdp5gIkJrvsV0GAmoMEF
	j/xBBpckIqSkGhiZZnmsV/q4bbNob0jj6blrn0+Z/XnH3gOrWKJazZg1ti7kWsAdyufwINiz
	g3u29MHdKTG1FhcqGHyFBVwer1q3Mn4qB0NXIMNJkYbj977bynzYLMVf2864vejS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296396>

From: David Turner <dturner@twopensource.com>

In the file-based backend, the reflog piggybacks on the ref lock.
Since other backends won't have the same sort of ref lock, ref backends
must also handle reflogs.

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch doesn't fix the known problem [1] that worktree reflogs are
not considered when considering reachability, but I think this whole
patch series will make the problem easier to fix in a relatively
elegant way.

[1] http://thread.gmane.org/gmane.comp.version-control.git/295961/focus=296068

 refs.c               | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 70 +++++++++++++++++++++++++++++++++++++---------------
 refs/refs-internal.h | 44 +++++++++++++++++++++++++++------
 3 files changed, 150 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index d1ab20b..77d3986 100644
--- a/refs.c
+++ b/refs.c
@@ -1458,3 +1458,66 @@ int verify_refname_available(const char *refname,
 
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
index 40c05b2..b19ea02 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2781,11 +2781,16 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
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
@@ -3079,16 +3084,24 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
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
 
@@ -3131,13 +3144,19 @@ static char *find_beginning_of_line(char *bob, char *scan)
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
@@ -3233,12 +3252,17 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
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
@@ -3317,22 +3341,19 @@ struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	files_reflog_iterator_abort
 };
 
-struct ref_iterator *files_reflog_iterator_begin(void)
+struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
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
@@ -3928,15 +3949,16 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
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
@@ -4049,5 +4071,13 @@ struct ref_storage_be refs_be_files = {
 
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
index 797d44f..7d84984 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -399,13 +399,6 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
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
@@ -502,6 +495,35 @@ typedef struct ref_iterator *ref_iterator_begin_fn(
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
@@ -563,6 +585,14 @@ struct ref_storage_be {
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
2.8.1
