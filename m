Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2C31FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 13:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdBIN2i (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 08:28:38 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60632 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751250AbdBIN2S (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 08:28:18 -0500
X-AuditID: 12074411-fbbff700000009b7-cb-589c6e36c235
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B8.0A.02487.63E6C985; Thu,  9 Feb 2017 08:27:18 -0500 (EST)
Received: from bagpipes.fritz.box (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19DRB5E023019
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 08:27:16 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/5] refs: push the submodule attribute down
Date:   Thu,  9 Feb 2017 14:26:59 +0100
Message-Id: <8958e7e26cc8bf11a76672eb8ea98bc9ba662fdc.1486629195.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqGuWNyfCYNkvcYuuK91MFg29V5gt
        +pd3sVncXjGf2WLJw9fMFt1T3jJabN7czuLA7vH3/Qcmj52z7rJ7fPgY57FgU6lHV/sRNo+L
        l5Q9Pm+SC2CP4rJJSc3JLEst0rdL4Mro2/KTuWCTc8X+9QYNjAfMuxg5OCQETCRaz6p0MXJx
        CAlcZpRY3XCdDcI5ySSx8fllpi5GTg42AV2JRT3NYLaIgJrExLZDLCBFzALrmSROz/vACpIQ
        FrCRmHD/NCvIVBYBVYk5Sw1BwrwCURKXtr9kAbElBOQkLm37wgxicwpYSPyecIURxBYSMJf4
        e/w70wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxQkJLcAfjjJNy
        hxgFOBiVeHgvWM+OEGJNLCuuzD3EKMnBpCTKG/EfKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
        NyVnToQQb0piZVVqUT5MSpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mC9y9Io2BRanpq
        RVpmTglCmomDE2Q4D9DwGWDDiwsSc4sz0yHypxgVpcR5s0ESAiCJjNI8uF5Y7L9iFAd6RZj3
        EEgVDzBtwHW/AhrMBDT4+ulZIINLEhFSUg2MNXdcOK1+WLVvTd1tu11B0bOwmLki9V4K99Y5
        Ny7Pflax5OjXLuaqpQftZ5dI7/4n2JyzUsGw9lbKxOb4iMWPhGfz7z65w+btKluF3dPevp+9
        99TsU7cP60z7zCEuL/c0Vd0g2NjmO6+X8qTtb9ovHlzblSFwfnX0oSu95QxL3vFvkaxsYhd+
        pMRSnJFoqMVcVJwIABdJojfYAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Push the submodule attribute down from ref_store to files_ref_store.
This is another step towards loosening the 1:1 connection between
ref_stores and submodules.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  9 --------
 refs/files-backend.c | 61 ++++++++++++++++++++++++++++++++++++----------------
 refs/refs-internal.h | 13 -----------
 3 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/refs.c b/refs.c
index 50d192c..723b4be 100644
--- a/refs.c
+++ b/refs.c
@@ -1404,11 +1404,8 @@ void base_ref_store_init(struct ref_store *refs,
 		if (main_ref_store)
 			die("BUG: main_ref_store initialized twice");
 
-		refs->submodule = "";
 		main_ref_store = refs;
 	} else {
-		refs->submodule = xstrdup(submodule);
-
 		if (!submodule_ref_stores.tablesize)
 			hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);
 
@@ -1473,12 +1470,6 @@ struct ref_store *get_ref_store(const char *submodule)
 	return refs;
 }
 
-void assert_main_repository(struct ref_store *refs, const char *caller)
-{
-	if (*refs->submodule)
-		die("BUG: %s called for a submodule", caller);
-}
-
 /* backend functions */
 int pack_refs(unsigned int flags)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c041d4b..6ed7e13 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -912,6 +912,14 @@ struct packed_ref_cache {
  */
 struct files_ref_store {
 	struct ref_store base;
+
+	/*
+	 * The name of the submodule represented by this object, or
+	 * the empty string if it represents the main repository's
+	 * reference store:
+	 */
+	const char *submodule;
+
 	struct ref_entry *loose;
 	struct packed_ref_cache *packed;
 };
@@ -974,10 +982,23 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 
 	base_ref_store_init(ref_store, &refs_be_files, submodule);
 
+	refs->submodule = submodule ? xstrdup(submodule) : "";
+
 	return ref_store;
 }
 
 /*
+ * Die if refs is for a submodule (i.e., not for the main repository).
+ * caller is used in any necessary error messages.
+ */
+static void files_assert_main_repository(struct files_ref_store *refs,
+					 const char *caller)
+{
+	if (*refs->submodule)
+		die("BUG: %s called for a submodule", caller);
+}
+
+/*
  * Downcast ref_store to files_ref_store. Die if ref_store is not a
  * files_ref_store. If submodule_allowed is not true, then also die if
  * files_ref_store is for a submodule (i.e., not for the main
@@ -987,14 +1008,18 @@ static struct files_ref_store *files_downcast(
 		struct ref_store *ref_store, int submodule_allowed,
 		const char *caller)
 {
+	struct files_ref_store *refs;
+
 	if (ref_store->be != &refs_be_files)
 		die("BUG: ref_store is type \"%s\" not \"files\" in %s",
 		    ref_store->be->name, caller);
 
+	refs = (struct files_ref_store *)ref_store;
+
 	if (!submodule_allowed)
-		assert_main_repository(ref_store, caller);
+		files_assert_main_repository(refs, caller);
 
-	return (struct files_ref_store *)ref_store;
+	return refs;
 }
 
 /* The length of a peeled reference line in packed-refs, including EOL: */
@@ -1133,8 +1158,8 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 {
 	char *packed_refs_file;
 
-	if (*refs->base.submodule)
-		packed_refs_file = git_pathdup_submodule(refs->base.submodule,
+	if (*refs->submodule)
+		packed_refs_file = git_pathdup_submodule(refs->submodule,
 							 "packed-refs");
 	else
 		packed_refs_file = git_pathdup("packed-refs");
@@ -1203,8 +1228,8 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	size_t path_baselen;
 	int err = 0;
 
-	if (*refs->base.submodule)
-		err = strbuf_git_path_submodule(&path, refs->base.submodule, "%s", dirname);
+	if (*refs->submodule)
+		err = strbuf_git_path_submodule(&path, refs->submodule, "%s", dirname);
 	else
 		strbuf_git_path(&path, "%s", dirname);
 	path_baselen = path.len;
@@ -1244,10 +1269,10 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 		} else {
 			int read_ok;
 
-			if (*refs->base.submodule) {
+			if (*refs->submodule) {
 				hashclr(sha1);
 				flag = 0;
-				read_ok = !resolve_gitlink_ref(refs->base.submodule,
+				read_ok = !resolve_gitlink_ref(refs->submodule,
 							       refname.buf, sha1);
 			} else {
 				read_ok = !read_ref_full(refname.buf,
@@ -1358,8 +1383,8 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	*type = 0;
 	strbuf_reset(&sb_path);
 
-	if (*refs->base.submodule)
-		strbuf_git_path_submodule(&sb_path, refs->base.submodule, "%s", refname);
+	if (*refs->submodule)
+		strbuf_git_path_submodule(&sb_path, refs->submodule, "%s", refname);
 	else
 		strbuf_git_path(&sb_path, "%s", refname);
 
@@ -1540,7 +1565,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	int ret = TRANSACTION_GENERIC_ERROR;
 
 	assert(err);
-	assert_main_repository(&refs->base, "lock_raw_ref");
+	files_assert_main_repository(refs, "lock_raw_ref");
 
 	*type = 0;
 
@@ -2006,7 +2031,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	int attempts_remaining = 3;
 	int resolved;
 
-	assert_main_repository(&refs->base, "lock_ref_sha1_basic");
+	files_assert_main_repository(refs, "lock_ref_sha1_basic");
 	assert(err);
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -2152,7 +2177,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	static int timeout_value = 1000;
 	struct packed_ref_cache *packed_ref_cache;
 
-	assert_main_repository(&refs->base, "lock_packed_refs");
+	files_assert_main_repository(refs, "lock_packed_refs");
 
 	if (!timeout_configured) {
 		git_config_get_int("core.packedrefstimeout", &timeout_value);
@@ -2190,7 +2215,7 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	int save_errno = 0;
 	FILE *out;
 
-	assert_main_repository(&refs->base, "commit_packed_refs");
+	files_assert_main_repository(refs, "commit_packed_refs");
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
@@ -2223,7 +2248,7 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
 
-	assert_main_repository(&refs->base, "rollback_packed_refs");
+	files_assert_main_repository(refs, "rollback_packed_refs");
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
@@ -2397,7 +2422,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
 
-	assert_main_repository(&refs->base, "repack_without_refs");
+	files_assert_main_repository(refs, "repack_without_refs");
 	assert(err);
 
 	/* Look for a packed ref */
@@ -2930,7 +2955,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err)
 {
-	assert_main_repository(&refs->base, "commit_ref_update");
+	files_assert_main_repository(refs, "commit_ref_update");
 
 	clear_loose_ref_cache(refs);
 	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err)) {
@@ -3560,7 +3585,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	int ret;
 	struct ref_lock *lock;
 
-	assert_main_repository(&refs->base, "lock_ref_for_update");
+	files_assert_main_repository(refs, "lock_ref_for_update");
 
 	if ((update->flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
 		update->flags |= REF_DELETING;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4ed5f89..97f275b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -627,13 +627,6 @@ extern struct ref_storage_be refs_be_files;
 struct ref_store {
 	/* The backend describing this ref_store's storage scheme: */
 	const struct ref_storage_be *be;
-
-	/*
-	 * The name of the submodule represented by this object, or
-	 * the empty string if it represents the main repository's
-	 * reference store:
-	 */
-	const char *submodule;
 };
 
 /*
@@ -675,10 +668,4 @@ struct ref_store *lookup_ref_store(const char *submodule);
  */
 struct ref_store *get_ref_store(const char *submodule);
 
-/*
- * Die if refs is for a submodule (i.e., not for the main repository).
- * caller is used in any necessary error messages.
- */
-void assert_main_repository(struct ref_store *refs, const char *caller);
-
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.9.3

