Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99351FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933167AbdCaOLl (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:11:41 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48970 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933149AbdCaOLh (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:37 -0400
X-AuditID: 1207440d-041ff70000003721-c8-58de63963fa8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E3.20.14113.6936ED85; Fri, 31 Mar 2017 10:11:35 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBh010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:32 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/20] refs_read_raw_ref(): new function
Date:   Fri, 31 Mar 2017 16:11:00 +0200
Message-Id: <3962e229cf0eb9daad8b5ed55b98fc9dbdd0d64a.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqDs9+V6EQWOnosXaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugSvjxP9djAUH+Su+X+xnbGDcytPFyMkhIWAi
        0f/sClsXIxeHkMAOJompl5uYIZyTTBK7Ni5jAqliE9CVWNTTDGaLCKhJTGw7xAJSxCzwhkni
        wJZfLCAJYQFriRezbrKC2CwCqhIbbqxkBLF5BaIkmjo+sUGsk5fY1XYRrIZTwEJi3cxD7CC2
        kIC5xIK1E9gmMPIsYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6iRESbLw7
        GP+vkznEKMDBqMTDe8L7XoQQa2JZcWXuIUZJDiYlUV7fcKAQX1J+SmVGYnFGfFFpTmrxIUYJ
        DmYlEV6mOKAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCtyIJqFGw
        KDU9tSItM6cEIc3EwQkynAdoeApIDW9xQWJucWY6RP4Uo6KUOC8rSEIAJJFRmgfXC0sGrxjF
        gV4R5vUCqeIBJhK47ldAg5mABlt8vQsyuCQRISXVwFjK3bp35p8r/RFb30zNuKJw/OvT4/5+
        f21dQsx+vpt6LdPN6Kjq5+cNjmbMvPd2V/Lef5eV9rA6rUr2wek3FoJZBr3/b7OxV2SzVqa/
        /n3x84xDDBna97/WhC/mkTson32f99CmmQavOOVmiVRMt+cIXLNgu+H9p7zyRl98ZXa1OYcv
        3xS5pVCJpTgj0VCLuag4EQAYHOmk4QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a new function from `refs_resolve_ref_unsafe()`. It will be
useful elsewhere.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 11 +++++++++--
 refs/refs-internal.h |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 77a39f8b17..0ed6c3c7a4 100644
--- a/refs.c
+++ b/refs.c
@@ -1326,6 +1326,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(), fn, cb_data);
 }
 
+int refs_read_raw_ref(struct ref_store *ref_store,
+		      const char *refname, unsigned char *sha1,
+		      struct strbuf *referent, unsigned int *type)
+{
+	return ref_store->be->read_raw_ref(ref_store, refname, sha1, referent, type);
+}
+
 /* This function needs to return a meaningful errno on failure */
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
@@ -1362,8 +1369,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (refs->be->read_raw_ref(refs, refname,
-					   sha1, &sb_refname, &read_flags)) {
+		if (refs_read_raw_ref(refs, refname,
+				      sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 690498698e..6ee9f20dbc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -165,6 +165,10 @@ struct ref_update {
 	const char refname[FLEX_ARRAY];
 };
 
+int refs_read_raw_ref(struct ref_store *ref_store,
+		      const char *refname, unsigned char *sha1,
+		      struct strbuf *referent, unsigned int *type);
+
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
-- 
2.11.0

