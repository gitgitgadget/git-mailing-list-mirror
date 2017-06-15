Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D1420401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbdFOOsD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:03 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51680 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752584AbdFOOsC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:02 -0400
X-AuditID: 1207440f-33bff7000000102d-75-59429e21db3f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.F5.04141.12E92495; Thu, 15 Jun 2017 10:48:01 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbR3014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:47:59 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/28] add_packed_ref(): take a `packed_ref_store *` parameter
Date:   Thu, 15 Jun 2017 16:47:14 +0200
Message-Id: <c3d68e8b44bae235af802ebed7cdaaf5eedc3508.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKs4zynSYN4vfYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJ6Fz5hKZggUHFs1gmWBsY1vF2M
        HBwSAiYS79f7djFycQgJ7GCSaGrazAjhnGSSWHXoA1MXIycHm4CuxKKeZjBbREBNYmLbIRaQ
        ImaBScwSb68tBEsIC/hJPFg9kxHEZhFQlTh08R4LiM0rECWx9/k1VhBbQkBeYlfbRTCbU8BC
        YvaXdcwgVwgJmEscW64xgZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTS
        TYyQkOPfwdi1XuYQowAHoxIPr0KDU6QQa2JZcWXuIUZJDiYlUV5+OaAQX1J+SmVGYnFGfFFp
        TmrxIUYJDmYlEd6pc4ByvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJ
        3m0gjYJFqempFWmZOSUIaSYOTpDhPEDDZ08HGV5ckJhbnJkOkT/FqCglzusB0iwAksgozYPr
        haWEV4ziQK8I834BqeIBphO47ldAg5mABgddcAAZXJKIkJJqYAz/49o2xalXL+FRlUS09pL5
        cdevtt08c3/6tqAVU03bBE47s9yvlqpadOo7Y+AHlQtNfRNaln/ZeTOaf73/WaHKEO0fV3XD
        ziR6l2y1kRJwuHSzy0FDZNPXss7172+IPrC7n3tAIGiSzI1Zk11UXZvbGw47ay+7epF9Uvf0
        WR8KIln3iSX+fKPEUpyRaKjFXFScCACqAJyW5AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bc5c0de84e..4943207098 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -438,19 +438,19 @@ static struct ref_dir *get_packed_refs(struct packed_ref_store *refs)
  * (see lock_packed_refs()). To actually write the packed-refs file,
  * call commit_packed_refs().
  */
-static void add_packed_ref(struct files_ref_store *refs,
+static void add_packed_ref(struct packed_ref_store *refs,
 			   const char *refname, const struct object_id *oid)
 {
 	struct ref_dir *packed_refs;
 	struct ref_entry *packed_entry;
 
-	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
+	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed refs not locked");
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 
-	packed_refs = get_packed_refs(refs->packed_ref_store);
+	packed_refs = get_packed_refs(refs);
 	packed_entry = find_ref_entry(packed_refs, refname);
 	if (packed_entry) {
 		/* Overwrite the existing entry: */
@@ -1579,7 +1579,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * we don't copy the peeled status, because we want it
 		 * to be re-peeled.
 		 */
-		add_packed_ref(refs, iter->refname, iter->oid);
+		add_packed_ref(refs->packed_ref_store, iter->refname, iter->oid);
 
 		/* Schedule the loose reference for pruning if requested. */
 		if ((flags & PACK_REFS_PRUNE)) {
@@ -3210,7 +3210,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 
 		if ((update->flags & REF_HAVE_NEW) &&
 		    !is_null_oid(&update->new_oid))
-			add_packed_ref(refs, update->refname,
+			add_packed_ref(refs->packed_ref_store, update->refname,
 				       &update->new_oid);
 	}
 
-- 
2.11.0

