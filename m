Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4805420401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754673AbdFWHCn (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:43 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62611 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750902AbdFWHCl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:41 -0400
X-AuditID: 1207440e-8a7ff70000006f9a-de-594cbd0f3b51
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id A7.F0.28570.F0DBC495; Fri, 23 Jun 2017 03:02:39 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o65001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:37 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/29] packed_ref_store: make class into a subclass of `ref_store`
Date:   Fri, 23 Jun 2017 09:01:38 +0200
Message-Id: <041f714d6ab872c113cde7a9c97eae03a06ae04d.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqCuw1yfSYN5ZDou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDImPz/MXNBTW3Fk2zXmBsaOtC5G
        Tg4JAROJu01vWboYuTiEBHYwSUxqOQLlnGKSaOxqYQepYhPQlVjU08wEYosIqElMbDsEVsQs
        MIlZ4u21hWAJYYFQibtHpwLZHBwsAqoSy16agpi8AlESB6+rQiyTl9jVdpEVxOYUsJDombgc
        bLyQgLnEqt+rWScw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGusl5tZopeaUrqJERJy
        fDsY29fLHGIU4GBU4uHdcd47Uog1say4MvcQoyQHk5Ior2akT6QQX1J+SmVGYnFGfFFpTmrx
        IUYJDmYlEV6dVUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEr+ge
        oEbBotT01Iq0zJwShDQTByfIcB6g4R6bQYYXFyTmFmemQ+RPMSpKifNu2A2UEABJZJTmwfXC
        UsIrRnGgV4R5E0GqeIDpBK77FdBgJqDBM9aADS5JREhJNTBOZW3aueNMpgNfy1bD+G0rfRL9
        InwqnDaanSk2sfRa/Xv/XoYVl/jsP9gv/5R+tV3PZ4eAvpYHb1Mb54dI5UdJQswVovZxwf0H
        Dq+IfdKdHPFnS1rT137vFbGnJ0z7tLzhwMlEfq5jrVtPRGS/PZ6+ptjvNeNPo+tqfLzKM/tD
        p2g8L1UozlFiKc5INNRiLipOBADF9zA/5AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the infrastructure to make `packed_ref_store` implement
`ref_store`, at least formally (few of the methods are actually
implemented yet). Change the functions in its interface to take
`ref_store *` arguments. Change `files_ref_store` to store a pointer
to `ref_store *` and to call functions via the virtual `ref_store`
interface where possible. This also means that a few
`packed_ref_store` functions can become static.

This is a work in progress. Some more `ref_store` methods will soon be
implemented (e.g., those having to do with reference transactions).
But some of them will never be implemented (e.g., those having to do
with symrefs or reflogs).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  |  16 ++--
 refs/packed-backend.c | 231 +++++++++++++++++++++++++++++++++++++++++++++-----
 refs/packed-backend.h |  23 ++---
 refs/refs-internal.h  |   1 +
 4 files changed, 226 insertions(+), 45 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7df9747798..60f4fa5e7a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -28,7 +28,7 @@ struct files_ref_store {
 
 	struct ref_cache *loose;
 
-	struct packed_ref_store *packed_ref_store;
+	struct ref_store *packed_ref_store;
 };
 
 static void clear_loose_ref_cache(struct files_ref_store *refs)
@@ -311,8 +311,8 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (packed_read_raw_ref(refs->packed_ref_store, refname,
-					sha1, referent, type)) {
+		if (refs_read_raw_ref(refs->packed_ref_store, refname,
+				      sha1, referent, type)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -351,8 +351,8 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (packed_read_raw_ref(refs->packed_ref_store, refname,
-					sha1, referent, type)) {
+		if (refs_read_raw_ref(refs->packed_ref_store, refname,
+				      sha1, referent, type)) {
 			errno = EISDIR;
 			goto out;
 		}
@@ -683,7 +683,7 @@ static int files_peel_ref(struct ref_store *ref_store,
 	 * have REF_KNOWS_PEELED.
 	 */
 	if (flag & REF_ISPACKED &&
-	    !packed_peel_ref(refs->packed_ref_store, refname, sha1))
+	    !refs_peel_ref(refs->packed_ref_store, refname, sha1))
 		return 0;
 
 	return peel_object(base, sha1);
@@ -804,8 +804,8 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * ones in files_ref_iterator_advance(), after we have merged
 	 * the packed and loose references.
 	 */
-	packed_iter = packed_ref_iterator_begin(
-			refs->packed_ref_store, prefix,
+	packed_iter = refs_ref_iterator_begin(
+			refs->packed_ref_store, prefix, 0,
 			DO_FOR_EACH_INCLUDE_BROKEN);
 
 	iter->iter0 = overlay_ref_iterator_begin(loose_iter, packed_iter);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6fa988c953..4676dc3959 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -50,6 +50,8 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
  * `ref_store`.
  */
 struct packed_ref_store {
+	struct ref_store base;
+
 	unsigned int store_flags;
 
 	/* The path of the "packed-refs" file: */
@@ -68,14 +70,17 @@ struct packed_ref_store {
 	struct lock_file lock;
 };
 
-struct packed_ref_store *packed_ref_store_create(
-		const char *path, unsigned int store_flags)
+struct ref_store *packed_ref_store_create(const char *path,
+					  unsigned int store_flags)
 {
 	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct ref_store *ref_store = (struct ref_store *)refs;
 
+	base_ref_store_init(ref_store, &refs_be_packed);
 	refs->store_flags = store_flags;
+
 	refs->path = xstrdup(path);
-	return refs;
+	return ref_store;
 }
 
 /*
@@ -91,6 +96,31 @@ static void packed_assert_main_repository(struct packed_ref_store *refs,
 	die("BUG: operation %s only allowed for main ref store", caller);
 }
 
+/*
+ * Downcast `ref_store` to `packed_ref_store`. Die if `ref_store` is
+ * not a `packed_ref_store`. Also die if `packed_ref_store` doesn't
+ * support at least the flags specified in `required_flags`. `caller`
+ * is used in any necessary error messages.
+ */
+static struct packed_ref_store *packed_downcast(struct ref_store *ref_store,
+						unsigned int required_flags,
+						const char *caller)
+{
+	struct packed_ref_store *refs;
+
+	if (ref_store->be != &refs_be_packed)
+		die("BUG: ref_store is type \"%s\" not \"packed\" in %s",
+		    ref_store->be->name, caller);
+
+	refs = (struct packed_ref_store *)ref_store;
+
+	if ((refs->store_flags & required_flags) != required_flags)
+		die("BUG: unallowed operation (%s), requires %x, has %x\n",
+		    caller, required_flags, refs->store_flags);
+
+	return refs;
+}
+
 static void clear_packed_ref_cache(struct packed_ref_store *refs)
 {
 	if (refs->cache) {
@@ -287,9 +317,12 @@ static struct ref_dir *get_packed_refs(struct packed_ref_store *refs)
  * (see lock_packed_refs()). To actually write the packed-refs file,
  * call commit_packed_refs().
  */
-void add_packed_ref(struct packed_ref_store *refs,
+void add_packed_ref(struct ref_store *ref_store,
 		    const char *refname, const struct object_id *oid)
 {
+	struct packed_ref_store *refs =
+		packed_downcast(ref_store, REF_STORE_WRITE,
+				"add_packed_ref");
 	struct ref_dir *packed_refs;
 	struct ref_entry *packed_entry;
 
@@ -322,10 +355,13 @@ static struct ref_entry *get_packed_ref(struct packed_ref_store *refs,
 	return find_ref_entry(get_packed_refs(refs), refname);
 }
 
-int packed_read_raw_ref(struct packed_ref_store *refs,
-			const char *refname, unsigned char *sha1,
-			struct strbuf *referent, unsigned int *type)
+static int packed_read_raw_ref(struct ref_store *ref_store,
+			       const char *refname, unsigned char *sha1,
+			       struct strbuf *referent, unsigned int *type)
 {
+	struct packed_ref_store *refs =
+		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
+
 	struct ref_entry *entry;
 
 	*type = 0;
@@ -341,9 +377,12 @@ int packed_read_raw_ref(struct packed_ref_store *refs,
 	return 0;
 }
 
-int packed_peel_ref(struct packed_ref_store *refs,
-		    const char *refname, unsigned char *sha1)
+static int packed_peel_ref(struct ref_store *ref_store,
+			   const char *refname, unsigned char *sha1)
 {
+	struct packed_ref_store *refs =
+		packed_downcast(ref_store, REF_STORE_READ | REF_STORE_ODB,
+				"peel_ref");
 	struct ref_entry *r = get_packed_ref(refs, refname);
 
 	if (!r || peel_entry(r, 0))
@@ -420,12 +459,18 @@ static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 	packed_ref_iterator_abort
 };
 
-struct ref_iterator *packed_ref_iterator_begin(
-		struct packed_ref_store *refs,
+static struct ref_iterator *packed_ref_iterator_begin(
+		struct ref_store *ref_store,
 		const char *prefix, unsigned int flags)
 {
+	struct packed_ref_store *refs;
 	struct packed_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
+	unsigned int required_flags = REF_STORE_READ;
+
+	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
+		required_flags |= REF_STORE_ODB;
+	refs = packed_downcast(ref_store, required_flags, "ref_iterator_begin");
 
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
@@ -459,14 +504,15 @@ static void write_packed_entry(FILE *fh, const char *refname,
 		fprintf_or_die(fh, "^%s\n", sha1_to_hex(peeled));
 }
 
-int lock_packed_refs(struct packed_ref_store *refs, int flags)
+int lock_packed_refs(struct ref_store *ref_store, int flags)
 {
+	struct packed_ref_store *refs =
+		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
+				"lock_packed_refs");
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
 	struct packed_ref_cache *packed_ref_cache;
 
-	packed_assert_main_repository(refs, "lock_packed_refs");
-
 	if (!timeout_configured) {
 		git_config_get_int("core.packedrefstimeout", &timeout_value);
 		timeout_configured = 1;
@@ -507,8 +553,11 @@ static const char PACKED_REFS_HEADER[] =
  * lock_packed_refs()). Return zero on success. On errors, set errno
  * and return a nonzero value.
  */
-int commit_packed_refs(struct packed_ref_store *refs)
+int commit_packed_refs(struct ref_store *ref_store)
 {
+	struct packed_ref_store *refs =
+		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
+				"commit_packed_refs");
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
 	int ok, error = 0;
@@ -516,8 +565,6 @@ int commit_packed_refs(struct packed_ref_store *refs)
 	FILE *out;
 	struct ref_iterator *iter;
 
-	packed_assert_main_repository(refs, "commit_packed_refs");
-
 	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed-refs not locked");
 
@@ -573,9 +620,12 @@ static void rollback_packed_refs(struct packed_ref_store *refs)
  *
  * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
  */
-int repack_without_refs(struct packed_ref_store *refs,
+int repack_without_refs(struct ref_store *ref_store,
 			struct string_list *refnames, struct strbuf *err)
 {
+	struct packed_ref_store *refs =
+		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
+				"repack_without_refs");
 	struct ref_dir *packed;
 	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
@@ -595,7 +645,7 @@ int repack_without_refs(struct packed_ref_store *refs,
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (lock_packed_refs(refs, 0)) {
+	if (lock_packed_refs(&refs->base, 0)) {
 		unable_to_lock_message(refs->path, errno, err);
 		return -1;
 	}
@@ -615,10 +665,151 @@ int repack_without_refs(struct packed_ref_store *refs,
 	}
 
 	/* Write what remains */
-	ret = commit_packed_refs(refs);
+	ret = commit_packed_refs(&refs->base);
 	if (ret)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
 	return ret;
 }
 
+static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	/* Nothing to do. */
+	return 0;
+}
+
+static int packed_transaction_prepare(struct ref_store *ref_store,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err)
+{
+	die("BUG: not implemented yet");
+}
+
+static int packed_transaction_abort(struct ref_store *ref_store,
+				    struct ref_transaction *transaction,
+				    struct strbuf *err)
+{
+	die("BUG: not implemented yet");
+}
+
+static int packed_transaction_finish(struct ref_store *ref_store,
+				     struct ref_transaction *transaction,
+				     struct strbuf *err)
+{
+	die("BUG: not implemented yet");
+}
+
+static int packed_initial_transaction_commit(struct ref_store *ref_store,
+					    struct ref_transaction *transaction,
+					    struct strbuf *err)
+{
+	return ref_transaction_commit(transaction, err);
+}
+
+static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
+			     struct string_list *refnames, unsigned int flags)
+{
+	die("BUG: not implemented yet");
+}
+
+static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
+{
+	/*
+	 * Packed refs are already packed. It might be that loose refs
+	 * are packed *into* a packed refs store, but that is done by
+	 * updating the packed references via a transaction.
+	 */
+	return 0;
+}
+
+static int packed_create_symref(struct ref_store *ref_store,
+			       const char *refname, const char *target,
+			       const char *logmsg)
+{
+	die("BUG: packed reference store does not support symrefs");
+}
+
+static int packed_rename_ref(struct ref_store *ref_store,
+			    const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
+{
+	die("BUG: packed reference store does not support renaming references");
+}
+
+static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	return empty_ref_iterator_begin();
+}
+
+static int packed_for_each_reflog_ent(struct ref_store *ref_store,
+				      const char *refname,
+				      each_reflog_ent_fn fn, void *cb_data)
+{
+	return 0;
+}
+
+static int packed_for_each_reflog_ent_reverse(struct ref_store *ref_store,
+					      const char *refname,
+					      each_reflog_ent_fn fn,
+					      void *cb_data)
+{
+	return 0;
+}
+
+static int packed_reflog_exists(struct ref_store *ref_store,
+			       const char *refname)
+{
+	return 0;
+}
+
+static int packed_create_reflog(struct ref_store *ref_store,
+			       const char *refname, int force_create,
+			       struct strbuf *err)
+{
+	die("BUG: packed reference store does not support reflogs");
+}
+
+static int packed_delete_reflog(struct ref_store *ref_store,
+			       const char *refname)
+{
+	return 0;
+}
+
+static int packed_reflog_expire(struct ref_store *ref_store,
+				const char *refname, const unsigned char *sha1,
+				unsigned int flags,
+				reflog_expiry_prepare_fn prepare_fn,
+				reflog_expiry_should_prune_fn should_prune_fn,
+				reflog_expiry_cleanup_fn cleanup_fn,
+				void *policy_cb_data)
+{
+	return 0;
+}
+
+struct ref_storage_be refs_be_packed = {
+	NULL,
+	"packed",
+	packed_ref_store_create,
+	packed_init_db,
+	packed_transaction_prepare,
+	packed_transaction_finish,
+	packed_transaction_abort,
+	packed_initial_transaction_commit,
+
+	packed_pack_refs,
+	packed_peel_ref,
+	packed_create_symref,
+	packed_delete_refs,
+	packed_rename_ref,
+
+	packed_ref_iterator_begin,
+	packed_read_raw_ref,
+
+	packed_reflog_iterator_begin,
+	packed_for_each_reflog_ent,
+	packed_for_each_reflog_ent_reverse,
+	packed_reflog_exists,
+	packed_create_reflog,
+	packed_delete_reflog,
+	packed_reflog_expire
+};
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 22e8817ac4..beea9c14b5 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -1,33 +1,22 @@
 #ifndef REFS_PACKED_BACKEND_H
 #define REFS_PACKED_BACKEND_H
 
-struct packed_ref_store *packed_ref_store_create(
-		const char *path, unsigned int store_flags);
-
-int packed_read_raw_ref(struct packed_ref_store *refs,
-			const char *refname, unsigned char *sha1,
-			struct strbuf *referent, unsigned int *type);
-
-int packed_peel_ref(struct packed_ref_store *refs,
-		    const char *refname, unsigned char *sha1);
-
-struct ref_iterator *packed_ref_iterator_begin(
-		struct packed_ref_store *refs,
-		const char *prefix, unsigned int flags);
+struct ref_store *packed_ref_store_create(const char *path,
+					  unsigned int store_flags);
 
 /*
  * Lock the packed-refs file for writing. Flags is passed to
  * hold_lock_file_for_update(). Return 0 on success. On errors, set
  * errno appropriately and return a nonzero value.
  */
-int lock_packed_refs(struct packed_ref_store *refs, int flags);
+int lock_packed_refs(struct ref_store *ref_store, int flags);
 
-void add_packed_ref(struct packed_ref_store *refs,
+void add_packed_ref(struct ref_store *ref_store,
 		    const char *refname, const struct object_id *oid);
 
-int commit_packed_refs(struct packed_ref_store *refs);
+int commit_packed_refs(struct ref_store *ref_store);
 
-int repack_without_refs(struct packed_ref_store *refs,
+int repack_without_refs(struct ref_store *ref_store,
 			struct string_list *refnames, struct strbuf *err);
 
 #endif /* REFS_PACKED_BACKEND_H */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6f8f9f5619..4789106fc0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -664,6 +664,7 @@ struct ref_storage_be {
 };
 
 extern struct ref_storage_be refs_be_files;
+extern struct ref_storage_be refs_be_packed;
 
 /*
  * A representation of the reference store for the main repository or
-- 
2.11.0

