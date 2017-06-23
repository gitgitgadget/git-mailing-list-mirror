Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD6420401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbdFWHCq (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:46 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49094 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754169AbdFWHCn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:43 -0400
X-AuditID: 12074411-cebff700000033ea-3d-594cbd1251ff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 61.FD.13290.21DBC495; Fri, 23 Jun 2017 03:02:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o66001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:40 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 21/29] commit_packed_refs(): report errors rather than dying
Date:   Fri, 23 Jun 2017 09:01:39 +0200
Message-Id: <0336ce223945d678c91d4d5110a7a29bedba9c99.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqCu01yfS4PpGbou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJu/dcreG9e8ePhT/YGxgW6XYyc
        HBICJhIPpqxl6mLk4hAS2MEkcbSriw3COcUkcfjpTDaQKjYBXYlFPc1MILaIgJrExLZDLCBF
        zAKTmCXeXlsIlhAW8Je4sO0aWAOLgKrEjJ2nwGxegSiJGXe72CDWyUvsarvICmJzClhI9Exc
        zg5iCwmYS6z6vZp1AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxgh
        QSe4g3HGSblDjAIcjEo8vAlnvSOFWBPLiitzDzFKcjApifJqRvpECvEl5adUZiQWZ8QXleak
        Fh9ilOBgVhLh1VkFlONNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfCK
        7gFqFCxKTU+tSMvMKUFIM3FwggznARrusRlkeHFBYm5xZjpE/hSjopQ474bdQAkBkERGaR5c
        LywpvGIUB3pFmDcRpIoHmFDgul8BDWYCGjxjDdjgkkSElFQDI//UcwH3e77mibtrvFEwyS5t
        FJ8deML5cHaGadqVzd+P8FeuUo31XGDj+dRLzjHL5rNsYpZ9264q9+ebWb9P+Z1sv/1zTsiu
        f/79DcX87ZeSy+dX7LF/uHzzSS6r9UUlVloZtktvLFy25H70vObFtk36S+bpTglOiZoSV3Vs
        f8F3yWVW51XblViKMxINtZiLihMB97ideOUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Report errors via a `struct strbuf *err` rather than by calling
`die()`. To enable this goal, change `write_packed_entry()` to report
errors via a return value and `errno` rather than dying.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  | 10 +++---
 refs/packed-backend.c | 85 +++++++++++++++++++++++++++++++++------------------
 refs/packed-backend.h |  2 +-
 3 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 60f4fa5e7a..2810785efc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1094,6 +1094,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct ref_iterator *iter;
 	int ok;
 	struct ref_to_prune *refs_to_prune = NULL;
+	struct strbuf err = STRBUF_INIT;
 
 	lock_packed_refs(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
 
@@ -1128,10 +1129,11 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_packed_refs(refs->packed_ref_store))
-		die_errno("unable to overwrite old ref-pack file");
+	if (commit_packed_refs(refs->packed_ref_store, &err))
+		die("unable to overwrite old ref-pack file: %s", err.buf);
 
 	prune_refs(refs, refs_to_prune);
+	strbuf_release(&err);
 	return 0;
 }
 
@@ -2693,9 +2695,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 				       &update->new_oid);
 	}
 
-	if (commit_packed_refs(refs->packed_ref_store)) {
-		strbuf_addf(err, "unable to commit packed-refs file: %s",
-			    strerror(errno));
+	if (commit_packed_refs(refs->packed_ref_store, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4676dc3959..18ce47fcb7 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -493,15 +493,19 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 /*
  * Write an entry to the packed-refs file for the specified refname.
- * If peeled is non-NULL, write it as the entry's peeled value.
+ * If peeled is non-NULL, write it as the entry's peeled value. On
+ * error, return a nonzero value and leave errno set at the value left
+ * by the failing call to `fprintf()`.
  */
-static void write_packed_entry(FILE *fh, const char *refname,
-			       const unsigned char *sha1,
-			       const unsigned char *peeled)
+static int write_packed_entry(FILE *fh, const char *refname,
+			      const unsigned char *sha1,
+			      const unsigned char *peeled)
 {
-	fprintf_or_die(fh, "%s %s\n", sha1_to_hex(sha1), refname);
-	if (peeled)
-		fprintf_or_die(fh, "^%s\n", sha1_to_hex(peeled));
+	if (fprintf(fh, "%s %s\n", sha1_to_hex(sha1), refname) < 0 ||
+	    (peeled && fprintf(fh, "^%s\n", sha1_to_hex(peeled)) < 0))
+		return -1;
+
+	return 0;
 }
 
 int lock_packed_refs(struct ref_store *ref_store, int flags)
@@ -550,49 +554,74 @@ static const char PACKED_REFS_HEADER[] =
 /*
  * Write the current version of the packed refs cache from memory to
  * disk. The packed-refs file must already be locked for writing (see
- * lock_packed_refs()). Return zero on success. On errors, set errno
- * and return a nonzero value.
+ * lock_packed_refs()). Return zero on success. On errors, rollback
+ * the lockfile, write an error message to `err`, and return a nonzero
+ * value.
  */
-int commit_packed_refs(struct ref_store *ref_store)
+int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
 				"commit_packed_refs");
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
-	int ok, error = 0;
-	int save_errno = 0;
+	int ok;
+	int ret = -1;
 	FILE *out;
 	struct ref_iterator *iter;
 
 	if (!is_lock_file_locked(&refs->lock))
-		die("BUG: packed-refs not locked");
+		die("BUG: commit_packed_refs() called when unlocked");
 
 	out = fdopen_lock_file(&refs->lock, "w");
-	if (!out)
-		die_errno("unable to fdopen packed-refs descriptor");
+	if (!out) {
+		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
+			    strerror(errno));
+		goto error;
+	}
 
-	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
+	if (fprintf(out, "%s", PACKED_REFS_HEADER) < 0) {
+		strbuf_addf(err, "error writing to %s: %s",
+			    get_lock_file_path(&refs->lock), strerror(errno));
+		goto error;
+	}
 
 	iter = cache_ref_iterator_begin(packed_ref_cache->cache, NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		struct object_id peeled;
 		int peel_error = ref_iterator_peel(iter, &peeled);
 
-		write_packed_entry(out, iter->refname, iter->oid->hash,
-				   peel_error ? NULL : peeled.hash);
+		if (write_packed_entry(out, iter->refname, iter->oid->hash,
+				       peel_error ? NULL : peeled.hash)) {
+			strbuf_addf(err, "error writing to %s: %s",
+				    get_lock_file_path(&refs->lock),
+				    strerror(errno));
+			ref_iterator_abort(iter);
+			goto error;
+		}
 	}
 
-	if (ok != ITER_DONE)
-		die("error while iterating over references");
+	if (ok != ITER_DONE) {
+		strbuf_addf(err, "unable to write packed-refs file: "
+			    "error iterating over old contents");
+		goto error;
+	}
 
 	if (commit_lock_file(&refs->lock)) {
-		save_errno = errno;
-		error = -1;
+		strbuf_addf(err, "error overwriting %s: %s",
+			    refs->path, strerror(errno));
+		goto out;
 	}
+
+	ret = 0;
+	goto out;
+
+error:
+	rollback_lock_file(&refs->lock);
+
+out:
 	release_packed_ref_cache(packed_ref_cache);
-	errno = save_errno;
-	return error;
+	return ret;
 }
 
 /*
@@ -628,7 +657,7 @@ int repack_without_refs(struct ref_store *ref_store,
 				"repack_without_refs");
 	struct ref_dir *packed;
 	struct string_list_item *refname;
-	int ret, needs_repacking = 0, removed = 0;
+	int needs_repacking = 0, removed = 0;
 
 	packed_assert_main_repository(refs, "repack_without_refs");
 	assert(err);
@@ -665,11 +694,7 @@ int repack_without_refs(struct ref_store *ref_store,
 	}
 
 	/* Write what remains */
-	ret = commit_packed_refs(&refs->base);
-	if (ret)
-		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
-			    strerror(errno));
-	return ret;
+	return commit_packed_refs(&refs->base, err);
 }
 
 static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index beea9c14b5..3d4057b65b 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -14,7 +14,7 @@ int lock_packed_refs(struct ref_store *ref_store, int flags);
 void add_packed_ref(struct ref_store *ref_store,
 		    const char *refname, const struct object_id *oid);
 
-int commit_packed_refs(struct ref_store *ref_store);
+int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err);
 
 int repack_without_refs(struct ref_store *ref_store,
 			struct string_list *refnames, struct strbuf *err);
-- 
2.11.0

