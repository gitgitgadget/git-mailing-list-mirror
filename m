Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCBD2023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934699AbdEVOSg (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:36 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44117 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934692AbdEVOSd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:33 -0400
X-AuditID: 1207440f-719ff700000004e5-fa-5922f332e823
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 75.45.01253.233F2295; Mon, 22 May 2017 10:18:26 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24H023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:24 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/25] ref_store: take a `msg` parameter when deleting references
Date:   Mon, 22 May 2017 16:17:38 +0200
Message-Id: <eb1b8016cbf4aff3b595cb176534751520460608.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqGv0WSnSoH2/jcXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M7iwOXx9/0HJo+ds+6y
        eyzYVOrx8FUXu0dX+xE2j2e9exg9Ll5S9vi8SS6AI4rLJiU1J7MstUjfLoEr48bD3awFD2wr
        Vs97ydzAeN+oi5GDQ0LARGLeNLcuRk4OIYEdTBJ7poZA2KeYJO6/qQWx2QR0JRb1NDOB2CIC
        ahIT2w6xdDFycTALbGCWeDN9NVhCWCBEYu3fKcwgNouAqsSk5w9YQGxegSiJhiev2EFsCQF5
        iV1tF1lBbE4BC4nfsw4wQSwzl+j9t5plAiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
        Jnq5mSV6qSmlmxghQci/g7FrvcwhRgEORiUeXo3HSpFCrIllxZW5hxglOZiURHmPvgEK8SXl
        p1RmJBZnxBeV5qQWH2KU4GBWEuHVvguU401JrKxKLcqHSUlzsCiJ86ovUfcTEkhPLEnNTk0t
        SC2CycpwcChJ8Op9AmoULEpNT61Iy8wpQUgzcXCCDOcBGr7mA8jw4oLE3OLMdIj8KUZFKXFe
        A5BmAZBERmkeXC8sSbxiFAd6RZi3EKSKB5hg4LpfAQ1mAhps/UweZHBJIkJKqoHR0oX92o5E
        37b4m+svF/r9N1Wv+nApfg9Xi06oWnq0ZKCi+Gv9VkFzzZ8L3smXv9FbpxLYwfD+ccKvwMln
        wq3n/5ptl7HQ875ZSnVY019Z1zbGA+sC7YtSAnzZ720oCeP+weT1ZpPVcYPHt2JDF1a4XXUt
        8ZSWF8i/VudX99dDbM0x4Qsbi5RYijMSDbWYi4oTAXJpKmPtAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just because the files backend can't retain reflogs for deleted
references is no reason that they shouldn't be supported by the
virtual method interface. Also, `delete_ref()` and `refs_delete_ref()`
have already gained `msg` parameters. Now let's add them to
`delete_refs()` and `refs_delete_refs()`.

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
index d4d573b985..47708451bc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -941,7 +941,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
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
index 71139ba74e..989462c972 100644
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
index ec8c6bfbbb..b62722fb81 100644
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
index b2559b5585..fce8265aa7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1595,7 +1595,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 	return ret;
 }
 
-static int files_delete_refs(struct ref_store *ref_store,
+static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 			     struct string_list *refnames, unsigned int flags)
 {
 	struct files_ref_store *refs =
@@ -1627,7 +1627,7 @@ static int files_delete_refs(struct ref_store *ref_store,
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
-		if (refs_delete_ref(&refs->base, NULL, refname, NULL, flags))
+		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
 			result |= error(_("could not remove reference %s"), refname);
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 7020e51cb7..95edf6f234 100644
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
index fba85e7da5..05d8c4d8af 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -93,12 +93,13 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 {
 	unsigned int flags = arg_flags(*argv++, "flags");
+	const char *msg = *argv++;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
 
 	while (*argv)
 		string_list_append(&refnames, *argv++);
 
-	return refs_delete_refs(refs, &refnames, flags);
+	return refs_delete_refs(refs, msg, &refnames, flags);
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

