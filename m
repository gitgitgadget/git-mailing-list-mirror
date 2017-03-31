Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3111FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbdCaOLp (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:11:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50194 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933155AbdCaOLn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:43 -0400
X-AuditID: 1207440e-cb3ff7000000340b-cf-58de639de2da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 05.69.13323.D936ED85; Fri, 31 Mar 2017 10:11:41 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBl010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:40 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/20] ref-cache: rename `add_ref()` to `add_ref_entry()`
Date:   Fri, 31 Mar 2017 16:11:04 +0200
Message-Id: <b37435be49b285431166d4829d03faedb446817e.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqDs3+V6EwZe3RhZrn91hsui60s1k
        0dB7hdni9or5zBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHl3tR9g8
        nvXuYfS4eEnZ4/MmuQD2KC6blNSczLLUIn27BK6MZy9aWAv28FXM3KrYwPiTu4uRk0NCwETi
        3b39rF2MXBxCAjuYJBY0dbFAOCeZJFpufWADqWIT0JVY1NPMBGKLCKhJTGw7BFbELPCGSeLA
        ll8sIAlhAR+J3S9nsIPYLAKqElcPPWMGsXkFoiRO7bvHCrFOXmJX20Uwm1PAQmLdzENg9UIC
        5hIL1k5gm8DIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSKjx7WBs
        Xy9ziFGAg1GJh/eE970IIdbEsuLK3EOMkhxMSqK8vuFAIb6k/JTKjMTijPii0pzU4kOMEhzM
        SiK8THFAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwGB4fA3SW9GxilWPLy
        81KVJHgrkoCGCBalpqdWpGXmlCCUMnFwgiziAVq0AKSGt7ggMbc4Mx0if4pRUUqclxUkIQCS
        yCjNg+uFpYhXjOJAbwnzHgSp4gGmF7juV0CDmYAGW3y9CzK4JBEhJdXAuGnb79iyjP1LgpVX
        HNk0a5uE2P6KabK3Di4UqA4S2HdpdYxoHcvf+01XziT/XP6s6USjZZhGQFmH+NtjF0oWmMWf
        +HL6UND8Ux/faeqfMs745/8/tpvNv2rpXaE/D1PY7rQpeR2aJRRxIzJU+GaHidGNXGOzvFwv
        93Tnj7ZSJ1L8NX9ePtxjqMRSnJFoqMVcVJwIAJhgVyHsAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function's visibility is about to be increased, so give it a more
distinctive name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index cad56efb04..4d579cbdac 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -455,7 +455,7 @@ static int remove_entry(struct ref_dir *dir, const char *refname)
  * subdirectories as necessary.  dir must represent the top-level
  * directory.  Return 0 on success.
  */
-static int add_ref(struct ref_dir *dir, struct ref_entry *ref)
+static int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref)
 {
 	dir = find_containing_dir(dir, ref->name, 1);
 	if (!dir)
@@ -994,7 +994,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
-			add_ref(dir, last);
+			add_ref_entry(dir, last);
 			continue;
 		}
 		if (last &&
@@ -1116,7 +1116,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed refs not locked");
-	add_ref(get_packed_ref_dir(packed_ref_cache),
+	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
 		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
@@ -2179,7 +2179,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	} else {
 		packed_entry = create_ref_entry(entry->name, entry->u.value.oid.hash,
 						REF_ISPACKED | REF_KNOWS_PEELED, 0);
-		add_ref(cb->packed_refs, packed_entry);
+		add_ref_entry(cb->packed_refs, packed_entry);
 	}
 	oidcpy(&packed_entry->u.value.peeled, &entry->u.value.peeled);
 
-- 
2.11.0

