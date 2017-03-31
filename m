Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14DA01FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933198AbdCaOLr (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:11:47 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48977 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933182AbdCaOLp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:45 -0400
X-AuditID: 1207440d-041ff70000003721-df-58de639f25fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B6.20.14113.F936ED85; Fri, 31 Mar 2017 10:11:43 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBm010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:41 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/20] ref-cache: rename `find_ref()` to `find_ref_entry()`
Date:   Fri, 31 Mar 2017 16:11:05 +0200
Message-Id: <279df1fe591349db97aa4a5dd30ec57a0dba3c2e.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqDs/+V6EwdNOQ4u1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGg0WnWAtW8Fa83+/awDiBu4uRk0NCwETi
        /NkGFhBbSGAHk8SMkxFdjFxA9kkmiRsHJoEl2AR0JRb1NDOB2CICahIT2w6xgBQxC7xhkjiw
        5RdYkbCAn8Tfa6sYQWwWAVWJ51//gNm8AlESmx4sZILYJi+xq+0iK4jNKWAhsW7mIXaIzeYS
        C9ZOYJvAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkig8e5g/L9O
        5hCjAAejEg/vCe97EUKsiWXFlbmHGCU5mJREeX3DgUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
        eJnigHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZDQ4OgbtLejcwSrHk5eel
        KknwViQBDREsSk1PrUjLzClBKGXi4ARZxAO0KAWkhre4IDG3ODMdIn+KUVFKnJcVJCEAksgo
        zYPrhSWIV4ziQG8J83qBVPEAkwtc9yugwUxAgy2+3gUZXJKIkJJqYLS6MGGrUK7u9+NMD0Nk
        azOdJ8bY91YfXyKpe9Kl5H0344bLCw/fezBXvevxf4UjH3fxSImc5LA+yyqstPdJQfhe9nP1
        7/NWq/JURvVUpmt8jarjrcpkLd33QnJq2feDF48FcdgH/p85bf/Z27d9a0XzU5M11Uvi8ox1
        3Xr8yxo89vl+Sp5Up8RSnJFoqMVcVJwIAOn/OWDrAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function's visibility is about to be increased, so give it a more
distinctive name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4d579cbdac..6768c8c86b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -385,7 +385,7 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
  * and recursing into subdirectories as necessary.  If the name is not
  * found or it corresponds to a directory entry, return NULL.
  */
-static struct ref_entry *find_ref(struct ref_dir *dir, const char *refname)
+static struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
 {
 	int entry_index;
 	struct ref_entry *entry;
@@ -1227,7 +1227,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
 					const char *refname)
 {
-	return find_ref(get_packed_refs(refs), refname);
+	return find_ref_entry(get_packed_refs(refs), refname);
 }
 
 /*
@@ -2171,7 +2171,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		die("internal error peeling reference %s (%s)",
 		    entry->name, oid_to_hex(&entry->u.value.oid));
-	packed_entry = find_ref(cb->packed_refs, entry->name);
+	packed_entry = find_ref_entry(cb->packed_refs, entry->name);
 	if (packed_entry) {
 		/* Overwrite existing packed entry with info from loose entry */
 		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
-- 
2.11.0

