Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7324F201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbdEQMGM (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:12 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58669 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753014AbdEQMGJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:09 -0400
X-AuditID: 1207440f-701ff700000004e5-ea-591c3cb04fca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F0.78.01253.0BC3C195; Wed, 17 May 2017 08:06:08 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pfw000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:07 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/23] ref_store: take `logmsg` parameter when deleting references
Date:   Wed, 17 May 2017 14:05:30 +0200
Message-Id: <b26ccc03a7e72dfa30467db81e9210dd621516e2.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLvBRibSYMN+S4u1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG8+7r7AVrbCueNGY0MK436mLk5JAQMJF4
        sfQVM4gtJLCDSWLtNZcuRi4g+wSTxPaGE2wgCTYBXYlFPc1MILaIgJrExLZDLCBFzAKPmST+
        LutmAUkICwRJPHyzkxHEZhFQlZgxtQdsKq9AlMTGy5+YILbJS+xqu8gKYnMKWEjcf/+IvYuR
        A2ibucT265UTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJM/4d
        jF3rZQ4xCnAwKvHwTuCSjhRiTSwrrsw9xCjJwaQkyrv/AVCILyk/pTIjsTgjvqg0J7X4EKME
        B7OSCO9NU5lIId6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwMB4eSBO8Ua6BG
        waLU9NSKtMycEoQ0EwcnyHAeoOFcIDW8xQWJucWZ6RD5U4yKUuK8B0ASAiCJjNI8uF5YGnjF
        KA70ijDvapAqHmAKget+BTSYCWhwM8hHvMUliQgpqQZGhjMRxjodc5cdnnCzz9GH6ccBzz9+
        9wLOb5r6WMZ08rKFX9qeTwgW3b2yfJvDh87pd7fxvVt7WDhRwNDzxi2bBRaXFl3Jrduf/DdQ
        l19X8f8k3pcSHXeMJHkMp4bzLRRX8ljg+Dtou2ErM8+jXR/PyC+aUdXIW3lKtWTbfMMF6+5z
        GjstOLl8oRJLcUaioRZzUXEiALv2xG3eAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just because the files backend can't retain reflogs for deleted
references is no reason that they shouldn't be supported by the
virtual method interface. Let's add them now before the interface
becomes truly polymorphic and increases the work.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c                |  2 +-
 builtin/remote.c               |  4 ++--
 refs.c                         | 11 ++++++-----
 refs.h                         | 12 +++++++-----
 refs/files-backend.c           |  4 ++--
 refs/refs-internal.h           |  2 +-
 t/helper/test-ref-store.c      |  3 ++-
 t/t1405-main-ref-store.sh      |  2 +-
 t/t1406-submodule-ref-store.sh |  2 +-
 9 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f2c2ab23e..f51314f432 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -940,7 +940,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 		for (ref = stale_refs; ref; ref = ref->next)
 			string_list_append(&refnames, ref->name);
 
-		result = delete_refs(&refnames, 0);
+		result = delete_refs("fetch: prune", &refnames, 0);
 		string_list_clear(&refnames, 0);
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index addf97ad29..5f52c5a6d6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -786,7 +786,7 @@ static int rm(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (!result)
-		result = delete_refs(&branches, REF_NODEREF);
+		result = delete_refs("remote: remove", &branches, REF_NODEREF);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
@@ -1301,7 +1301,7 @@ static int prune_remote(const char *remote, int dry_run)
 	string_list_sort(&refs_to_prune);
 
 	if (!dry_run)
-		result |= delete_refs(&refs_to_prune, 0);
+		result |= delete_refs("remote: prune", &refs_to_prune, 0);
 
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname = item->util;
diff --git a/refs.c b/refs.c
index ea8233c67d..14dec88e7f 100644
--- a/refs.c
+++ b/refs.c
@@ -1902,15 +1902,16 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
 
-int refs_delete_refs(struct ref_store *refs, struct string_list *refnames,
-		     unsigned int flags)
+int refs_delete_refs(struct ref_store *refs, const char *msg,
+		     struct string_list *refnames, unsigned int flags)
 {
-	return refs->be->delete_refs(refs, refnames, flags);
+	return refs->be->delete_refs(refs, msg, refnames, flags);
 }
 
-int delete_refs(struct string_list *refnames, unsigned int flags)
+int delete_refs(const char *msg, struct string_list *refnames,
+		unsigned int flags)
 {
-	return refs_delete_refs(get_main_ref_store(), refnames, flags);
+	return refs_delete_refs(get_main_ref_store(), msg, refnames, flags);
 }
 
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
diff --git a/refs.h b/refs.h
index a7d7b1afdf..b2d9626be6 100644
--- a/refs.h
+++ b/refs.h
@@ -331,7 +331,8 @@ int reflog_exists(const char *refname);
  * verify that the current value of the reference is old_sha1 before
  * deleting it. If old_sha1 is NULL, delete the reference if it
  * exists, regardless of its old value. It is an error for old_sha1 to
- * be NULL_SHA1. flags is passed through to ref_transaction_delete().
+ * be NULL_SHA1. msg and flags are passed through to
+ * ref_transaction_delete().
  */
 int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    const char *refname,
@@ -343,12 +344,13 @@ int delete_ref(const char *msg, const char *refname,
 /*
  * Delete the specified references. If there are any problems, emit
  * errors but attempt to keep going (i.e., the deletes are not done in
- * an all-or-nothing transaction). flags is passed through to
+ * an all-or-nothing transaction). msg and flags are passed through to
  * ref_transaction_delete().
  */
-int refs_delete_refs(struct ref_store *refs, struct string_list *refnames,
-		     unsigned int flags);
-int delete_refs(struct string_list *refnames, unsigned int flags);
+int refs_delete_refs(struct ref_store *refs, const char *msg,
+		     struct string_list *refnames, unsigned int flags);
+int delete_refs(const char *msg, struct string_list *refnames,
+		unsigned int flags);
 
 /** Delete a reflog */
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 893029f9dc..7708994e82 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1607,7 +1607,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 	return ret;
 }
 
-static int files_delete_refs(struct ref_store *ref_store,
+static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 			     struct string_list *refnames, unsigned int flags)
 {
 	struct files_ref_store *refs =
@@ -1639,7 +1639,7 @@ static int files_delete_refs(struct ref_store *ref_store,
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
-		if (refs_delete_ref(&refs->base, NULL, refname, NULL, flags))
+		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
 			result |= error(_("could not remove reference %s"), refname);
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index e5f6bb2047..9ed4387c8c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -508,7 +508,7 @@ typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
-typedef int delete_refs_fn(struct ref_store *ref_store,
+typedef int delete_refs_fn(struct ref_store *ref_store, const char *msg,
 			   struct string_list *refnames, unsigned int flags);
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index fba85e7da5..3eb78467c4 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -93,12 +93,13 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 {
 	unsigned int flags = arg_flags(*argv++, "flags");
+	const char *logmsg = *argv++;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
 
 	while (*argv)
 		string_list_append(&refnames, *argv++);
 
-	return refs_delete_refs(refs, &refnames, flags);
+	return refs_delete_refs(refs, logmsg, &refnames, flags);
 }
 
 static int cmd_rename_ref(struct ref_store *refs, const char **argv)
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 490521f8cb..e8115df5ba 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -31,7 +31,7 @@ test_expect_success 'create_symref(FOO, refs/heads/master)' '
 test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
 	git rev-parse FOO -- &&
 	git rev-parse refs/tags/new-tag -- &&
-	$RUN delete-refs 0 FOO refs/tags/new-tag &&
+	$RUN delete-refs 0 nothing FOO refs/tags/new-tag &&
 	test_must_fail git rev-parse FOO -- &&
 	test_must_fail git rev-parse refs/tags/new-tag --
 '
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 13b5454c56..c32d4cc465 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -31,7 +31,7 @@ test_expect_success 'create_symref() not allowed' '
 '
 
 test_expect_success 'delete_refs() not allowed' '
-	test_must_fail $RUN delete-refs 0 FOO refs/tags/new-tag
+	test_must_fail $RUN delete-refs 0 nothing FOO refs/tags/new-tag
 '
 
 test_expect_success 'rename_refs() not allowed' '
-- 
2.11.0

