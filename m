Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AEFF1FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 11:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbdBJLQl (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 06:16:41 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58457 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752902AbdBJLQk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 06:16:40 -0500
X-AuditID: 1207440d-967ff70000000a35-97-589da115280c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 55.1C.02613.511AD985; Fri, 10 Feb 2017 06:16:37 -0500 (EST)
Received: from bagpipes.fritz.box (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1ABGLLk025185
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 06:16:36 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/9] base_ref_store_init(): remove submodule argument
Date:   Fri, 10 Feb 2017 12:16:17 +0100
Message-Id: <43f78e3e765605c021f4f4138b15e4db5b7a3508.1486724698.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqCu6cG6Ewa8TuhZdV7qZLBp6rzBb
        9C/vYrO4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+7x4WOcx4JNpR5d
        7UfYPJ717mH0uHhJ2ePzJrkAjigum5TUnMyy1CJ9uwSujIYtj5kLrvFVvF63ga2B8QN3FyMn
        h4SAicTy3TcZuxi5OIQELjNK/L+8nwXCOcUkcbP7BBtIFZuArsSinmYmEFtEQE1iYtshFhCb
        GaTo3AKwuLCAh8T8lv9g9SwCqhIvVzxkBrF5BaIkDkzexASxTU7i0rYvYHFOAQuJfyfOgNlC
        AuYSx1cdZZ7AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkjI8e5g
        /L9O5hCjAAejEg/vi5o5EUKsiWXFlbmHGCU5mJREeb/PmBshxJeUn1KZkVicEV9UmpNafIhR
        goNZSYTXpgMox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4GVYANQo
        WJSanlqRlplTgpBm4uAEGc4DNJwdpIa3uCAxtzgzHSJ/ilFRSpy3bj5QQgAkkVGaB9cLSwmv
        GMWBXhHmFQNp5wGmE7juV0CDmYAGXz89C2RwSSJCSqqB0UbGnTtn+R4xJ62Lv9VOl86b8/Dt
        hZyDwgHdedKnj18099thH71Bi/W3/rz4po7+fjcR/YanCeJyCze8PMsneXHVb6Xpkkw9i6uD
        6i+yT5y2rt1dLUz/i2vITd631za2b7h7M2lK+c/zQvv3b533UIdbdIGDX4mnZlHMTu2HxQwr
        lHfzJcVtU2Ipzkg01GIuKk4EAJ8DIFbkAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another step towards weakening the 1:1 relationship between
ref_stores and submodules.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 3 +--
 refs/files-backend.c | 2 +-
 refs/refs-internal.h | 7 +++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 07959ff..05af56b 100644
--- a/refs.c
+++ b/refs.c
@@ -1477,8 +1477,7 @@ struct ref_store *get_ref_store(const char *submodule)
 }
 
 void base_ref_store_init(struct ref_store *refs,
-			 const struct ref_storage_be *be,
-			 const char *submodule)
+			 const struct ref_storage_be *be)
 {
 	refs->be = be;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5e135a4..c9d2d28 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -980,7 +980,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 
-	base_ref_store_init(ref_store, &refs_be_files, submodule);
+	base_ref_store_init(ref_store, &refs_be_files);
 
 	refs->submodule = submodule ? xstrdup(submodule) : "";
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 008822d..793c850 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -632,12 +632,11 @@ struct ref_store {
 };
 
 /*
- * Fill in the generic part of refs for the specified submodule and
- * add it to our collection of reference stores.
+ * Fill in the generic part of refs and add it to our collection of
+ * reference stores.
  */
 void base_ref_store_init(struct ref_store *refs,
-			 const struct ref_storage_be *be,
-			 const char *submodule);
+			 const struct ref_storage_be *be);
 
 /*
  * Return the ref_store instance for the specified submodule. For the
-- 
2.9.3

