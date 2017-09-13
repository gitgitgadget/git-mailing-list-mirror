Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2433120286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbdIMRQs (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:48 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58338 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751167AbdIMRQl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:41 -0400
X-AuditID: 1207440d-853ff70000000f42-1a-59b967f8c677
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D6.C6.03906.8F769B95; Wed, 13 Sep 2017 13:16:41 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIiX001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:39 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/20] packed_ref_cache: remember the file-wide peeling state
Date:   Wed, 13 Sep 2017 19:16:03 +0200
Message-Id: <6b7c9b6bd4160635cc5bebf5c0d6e298f05d4af4.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqPszfWekwbFTLBZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxrv3X5gKdopUXNn0lqmB8aJAFyMnh4SAicTCE3dY
        uhi5OIQEdjBJ7N66ixXCOckksennbCaQKjYBXYlFPc1gtoiAmsTEtkNgHcwCT5kkdp68ywqS
        EBbwlZjf85oNxGYRUJV4cmUHO4jNKxAlcWnnTiaIdfIS5x7cZgaxOQUsJDbueMIIYgsJmEs0
        ztnJOIGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkBDj3cH4f53M
        IUYBDkYlHl4Lm52RQqyJZcWVuYcYJTmYlER59+oChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
        BkUB5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErw5wFgSEixKTU+t
        SMvMKUFIM3FwggznARouCFLDW1yQmFucmQ6RP8Woy9Fx8+4fJiGWvPy8VClx3r+pQEUCIEUZ
        pXlwc2Cp4RWjONBbwrxdaUBVPMC0AjfpFdASJqAlZ07vAFlSkoiQkmpgFHXgfaQQl2d2VaMj
        SqR68bVpNYqXnZW3zle6c4GhnStjK9O2q+XhRqskT7qFuBtvWGvw2ezWAu+YTqlTt9Wvbmve
        82VxZHzpKjORj1qM+u12eyZeOsK6hffRuULfhTtv/Q5mvetQMNPc8L4U43bzSedK+2YZ5EUo
        VsXF5m96FHjadj//kxh/JZbijERDLeai4kQApTxjYegCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than store the peeling state (i.e., the one defined by traits
in the `packed-refs` file header line) in a local variable in
`read_packed_refs()`, store it permanently in `packed_ref_cache`. This
will be needed when we stop reading all packed refs at once.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 2b80f244c8..ae276f3445 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -18,6 +18,12 @@ struct packed_ref_cache {
 
 	struct ref_cache *cache;
 
+	/*
+	 * What is the peeled state of this cache? (This is usually
+	 * determined from the header of the "packed-refs" file.)
+	 */
+	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled;
+
 	/*
 	 * Count of references to the data structure in this instance,
 	 * including the pointer from files_ref_store::packed if any.
@@ -195,13 +201,13 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	char *buf;
 	const char *pos, *eol, *eof;
 	struct strbuf tmp = STRBUF_INIT;
-	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 	struct ref_dir *dir;
 
 	packed_refs->refs = refs;
 	acquire_packed_ref_cache(packed_refs);
 	packed_refs->cache = create_ref_cache(NULL, NULL);
 	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
+	packed_refs->peeled = PEELED_NONE;
 
 	fd = open(refs->path, O_RDONLY);
 	if (fd < 0) {
@@ -244,9 +250,9 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		string_list_split_in_place(&traits, p, ' ', -1);
 
 		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
-			peeled = PEELED_FULLY;
+			packed_refs->peeled = PEELED_FULLY;
 		else if (unsorted_string_list_has_string(&traits, "peeled"))
-			peeled = PEELED_TAGS;
+			packed_refs->peeled = PEELED_TAGS;
 		/* perhaps other traits later as well */
 
 		/* The "+ 1" is for the LF character. */
@@ -282,8 +288,9 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			oidclr(&oid);
 			flag |= REF_BAD_NAME | REF_ISBROKEN;
 		}
-		if (peeled == PEELED_FULLY ||
-		    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
+		if (packed_refs->peeled == PEELED_FULLY ||
+		    (packed_refs->peeled == PEELED_TAGS &&
+		     starts_with(refname, "refs/tags/")))
 			flag |= REF_KNOWS_PEELED;
 		entry = create_ref_entry(refname, &oid, flag);
 		add_ref_entry(dir, entry);
-- 
2.14.1

