Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B290720209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbdGAScA (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:00 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:61233 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752059AbdGASb6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:58 -0400
X-AuditID: 1207440d-e95ff70000000a46-6f-5957ea92c066
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C0.F6.02630.29AE7595; Sat,  1 Jul 2017 14:31:46 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBR010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:44 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 14/30] get_packed_ref(): take a `packed_ref_store *` parameter
Date:   Sat,  1 Jul 2017 20:30:52 +0200
Message-Id: <8519a233a8055b510b950da7763c2dcfdb31fa54.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqDvpVXikwbmTphZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGWcnvmGpWAVf8WNuS+ZGxiP83Qx
        cnJICJhITGiezNzFyMUhJLCDSeL800fMIAkhgZNMEt8m2oPYbAK6Eot6mplAbBEBNYmJbYdY
        QBqYBSYxS7y9thAsISwQKPF/0RdGEJtFQFVi39Nz7F2MHBy8AlES37/yQyyTl9jVdpEVxOYU
        sJD407Yeape5RPPBPpYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6eVmluilppRu
        YoSEHO8Oxv/rZA4xCnAwKvHwbggJixRiTSwrrsw9xCjJwaQkyrvyWmikEF9SfkplRmJxRnxR
        aU5q8SFGCQ5mJRHe3OfhkUK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4O
        JQneSS+BGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGL7wLMry4IDG3ODMdIn+KUZfj1YT/35iEWPLy
        81KlxHlbQQYJgBRllObBzYGlileM4kBvCfNGvACq4gGmGbhJr4CWMAEtEZ4RArKkJBEhJdXA
        WLRzVq0qv12eVV6M64TQw7FGJXN5A35s2cpmq7hnlXGASmZffsn0ilvvvi5Oa3AuEPDkMdvB
        xZ9Vrr0s2dlZ4NTH/XU9mZN6N/dyiEUu/r4ypiyJ1Vjhtr9d+OboWV/6lzE2SfAez+ROEJp0
        +6l5XZRapaHktq+KylneGZOYubYGWlYmpyuxFGckGmoxFxUnAgAKYU4Q8AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a08d3fbadf..2b9d93d3b6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -602,10 +602,10 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
  * Return the ref_entry for the given refname from the packed
  * references.  If it does not exist, return NULL.
  */
-static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
+static struct ref_entry *get_packed_ref(struct packed_ref_store *refs,
 					const char *refname)
 {
-	return find_ref_entry(get_packed_refs(refs->packed_ref_store), refname);
+	return find_ref_entry(get_packed_refs(refs), refname);
 }
 
 /*
@@ -621,7 +621,7 @@ static int resolve_packed_ref(struct files_ref_store *refs,
 	 * The loose reference file does not exist; check for a packed
 	 * reference.
 	 */
-	entry = get_packed_ref(refs, refname);
+	entry = get_packed_ref(refs->packed_ref_store, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.oid.hash);
 		*flags |= REF_ISPACKED;
@@ -1044,7 +1044,9 @@ static int files_peel_ref(struct ref_store *ref_store,
 	 * have REF_KNOWS_PEELED.
 	 */
 	if (flag & REF_ISPACKED) {
-		struct ref_entry *r = get_packed_ref(refs, refname);
+		struct ref_entry *r =
+			get_packed_ref(refs->packed_ref_store, refname);
+
 		if (r) {
 			if (peel_entry(r, 0))
 				return -1;
@@ -1631,7 +1633,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 
 	/* Look for a packed ref */
 	for_each_string_list_item(refname, refnames) {
-		if (get_packed_ref(refs, refname->string)) {
+		if (get_packed_ref(refs->packed_ref_store, refname->string)) {
 			needs_repacking = 1;
 			break;
 		}
-- 
2.11.0

