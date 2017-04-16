Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4058F20A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755537AbdDPGnN (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:43:13 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60172 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755390AbdDPGnF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:43:05 -0400
X-AuditID: 1207440e-cb3ff7000000340b-48-58f312787f87
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 80.DE.13323.87213F85; Sun, 16 Apr 2017 02:43:04 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGNK025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:43:02 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 19/20] files_pack_refs(): use reference iteration
Date:   Sun, 16 Apr 2017 08:41:41 +0200
Message-Id: <72ee44df32bf1e647a3ec058a332450d5ffd094f.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqFsh9DnC4PJScYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG3FWHGAuaTSrmrL7D1MC4WauLkZNDQsBE
        YtvE+0xdjFwcQgI7mCSatrezQDgnmCSuLetmBqliE9CVWNTTzARiiwioSUxsOwRWxCzwmEni
        77JuIIeDQ1jARaJvEQ9IDYuAqsSmVxNZQWxegSiJ9t0tLBDb5CV2tV0Ei3MKWEhMubsBLC4k
        YC6x/fhV5gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrr5WaW6KWmlG5ihIQa3w7G
        9vUyhxgFOBiVeHgt/D9FCLEmlhVX5h5ilORgUhLllfkPFOJLyk+pzEgszogvKs1JLT7EKMHB
        rCTCm8zyOUKINyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBe0MQqFGw
        KDU9tSItM6cEIc3EwQkynAdoeDpIDW9xQWJucWY6RP4Uo6KUOO8PAaCEAEgiozQPrheWCl4x
        igO9IszLDNLOA0wjcN2vgAYzAQ1mmPwBZHBJIkJKqoGx327J3f3ebH4OOlxfHEI1n8cpT+37
        uujbTZOviX+51Ura/I1X1VSJsUekaJj4pUxMVZBiN/se4q+/deE1NeN/7OWKLleu9gVsPF19
        kXP9taR4OdHXgvOPfZTWW5+52KJwXQ/rKdmf++NSvzx7v+5Tl/Vsyd8Tvti+as10ET/ftOzh
        rmO/tixWYinOSDTUYi4qTgQAsnw7ceACAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use reference iteration rather than `do_for_each_entry_in_dir()` in
the definition of `files_pack_refs()`. This makes the code shorter and
easier to follow, because the logic can be inline rather than spread
between the main function and a callback function, and it removes the
need to use `pack_refs_cb_data` to preserve intermediate state.

This removes the last callers of `entry_resolves_to_object()` and
`get_loose_ref_dir()`, so delete those functions.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 143 +++++++++++++++++++++------------------------------
 1 file changed, 60 insertions(+), 83 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1419512d51..b81fb88fa3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -32,17 +32,6 @@ static int ref_resolves_to_object(const char *refname,
 	return 1;
 }
 
-/*
- * Return true if the reference described by entry can be resolved to
- * an object in the database; otherwise, emit a warning and return
- * false.
- */
-static int entry_resolves_to_object(struct ref_entry *entry)
-{
-	return ref_resolves_to_object(entry->name,
-				      &entry->u.value.oid, entry->flag);
-}
-
 struct packed_ref_cache {
 	struct ref_cache *cache;
 
@@ -547,11 +536,6 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 	return refs->loose;
 }
 
-static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
-{
-	return get_ref_dir(get_loose_ref_cache(refs)->root);
-}
-
 /*
  * Return the ref_entry for the given refname from the packed
  * references.  If it does not exist, return NULL.
@@ -1408,65 +1392,6 @@ struct ref_to_prune {
 	char name[FLEX_ARRAY];
 };
 
-struct pack_refs_cb_data {
-	unsigned int flags;
-	struct ref_dir *packed_refs;
-	struct ref_to_prune *ref_to_prune;
-};
-
-/*
- * An each_ref_entry_fn that is run over loose references only.  If
- * the loose reference can be packed, add an entry in the packed ref
- * cache.  If the reference should be pruned, also add it to
- * ref_to_prune in the pack_refs_cb_data.
- */
-static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
-{
-	struct pack_refs_cb_data *cb = cb_data;
-	enum peel_status peel_status;
-	struct ref_entry *packed_entry;
-	int is_tag_ref = starts_with(entry->name, "refs/tags/");
-
-	/* Do not pack per-worktree refs: */
-	if (ref_type(entry->name) != REF_TYPE_NORMAL)
-		return 0;
-
-	/* ALWAYS pack tags */
-	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref)
-		return 0;
-
-	/* Do not pack symbolic or broken refs: */
-	if ((entry->flag & REF_ISSYMREF) || !entry_resolves_to_object(entry))
-		return 0;
-
-	/* Add a packed ref cache entry equivalent to the loose entry. */
-	peel_status = peel_entry(entry, 1);
-	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-		die("internal error peeling reference %s (%s)",
-		    entry->name, oid_to_hex(&entry->u.value.oid));
-	packed_entry = find_ref_entry(cb->packed_refs, entry->name);
-	if (packed_entry) {
-		/* Overwrite existing packed entry with info from loose entry */
-		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
-		oidcpy(&packed_entry->u.value.oid, &entry->u.value.oid);
-	} else {
-		packed_entry = create_ref_entry(entry->name, entry->u.value.oid.hash,
-						REF_ISPACKED | REF_KNOWS_PEELED, 0);
-		add_ref_entry(cb->packed_refs, packed_entry);
-	}
-	oidcpy(&packed_entry->u.value.peeled, &entry->u.value.peeled);
-
-	/* Schedule the loose reference for pruning if requested. */
-	if ((cb->flags & PACK_REFS_PRUNE)) {
-		struct ref_to_prune *n;
-		FLEX_ALLOC_STR(n, name, entry->name);
-		hashcpy(n->sha1, entry->u.value.oid.hash);
-		n->next = cb->ref_to_prune;
-		cb->ref_to_prune = n;
-	}
-	return 0;
-}
-
 enum {
 	REMOVE_EMPTY_PARENTS_REF = 0x01,
 	REMOVE_EMPTY_PARENTS_REFLOG = 0x02
@@ -1556,21 +1481,73 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
 			       "pack_refs");
-	struct pack_refs_cb_data cbdata;
-
-	memset(&cbdata, 0, sizeof(cbdata));
-	cbdata.flags = flags;
+	struct ref_iterator *iter;
+	struct ref_dir *packed_refs;
+	int ok;
+	struct ref_to_prune *refs_to_prune = NULL;
 
 	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
-	cbdata.packed_refs = get_packed_refs(refs);
+	packed_refs = get_packed_refs(refs);
+
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
+	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+		/*
+		 * If the loose reference can be packed, add an entry
+		 * in the packed ref cache. If the reference should be
+		 * pruned, also add it to refs_to_prune.
+		 */
+		struct ref_entry *packed_entry;
+		int is_tag_ref = starts_with(iter->refname, "refs/tags/");
+
+		/* Do not pack per-worktree refs: */
+		if (ref_type(iter->refname) != REF_TYPE_NORMAL)
+			continue;
+
+		/* ALWAYS pack tags */
+		if (!(flags & PACK_REFS_ALL) && !is_tag_ref)
+			continue;
+
+		/* Do not pack symbolic or broken refs: */
+		if (iter->flags & REF_ISSYMREF)
+			continue;
 
-	do_for_each_entry_in_dir(get_loose_ref_dir(refs),
-				 pack_if_possible_fn, &cbdata);
+		if (!ref_resolves_to_object(iter->refname, iter->oid, iter->flags))
+			continue;
+
+		/*
+		 * Create an entry in the packed-refs cache equivalent
+		 * to the one from the loose ref cache, except that
+		 * we don't copy the peeled status, because we want it
+		 * to be re-peeled.
+		 */
+		packed_entry = find_ref_entry(packed_refs, iter->refname);
+		if (packed_entry) {
+			/* Overwrite existing packed entry with info from loose entry */
+			packed_entry->flag = REF_ISPACKED;
+			oidcpy(&packed_entry->u.value.oid, iter->oid);
+		} else {
+			packed_entry = create_ref_entry(iter->refname, iter->oid->hash,
+							REF_ISPACKED, 0);
+			add_ref_entry(packed_refs, packed_entry);
+		}
+		oidclr(&packed_entry->u.value.peeled);
+
+		/* Schedule the loose reference for pruning if requested. */
+		if ((flags & PACK_REFS_PRUNE)) {
+			struct ref_to_prune *n;
+			FLEX_ALLOC_STR(n, name, iter->refname);
+			hashcpy(n->sha1, iter->oid->hash);
+			n->next = refs_to_prune;
+			refs_to_prune = n;
+		}
+	}
+	if (ok != ITER_DONE)
+		die("error while iterating over references");
 
 	if (commit_packed_refs(refs))
 		die_errno("unable to overwrite old ref-pack file");
 
-	prune_refs(refs, cbdata.ref_to_prune);
+	prune_refs(refs, refs_to_prune);
 	return 0;
 }
 
-- 
2.11.0

