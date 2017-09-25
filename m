Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C0120281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933842AbdIYIAf (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:35 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58069 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933835AbdIYIAe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:34 -0400
X-AuditID: 12074411-f7dff70000007f0a-db-59c8b7a15d6d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.12.32522.1A7B8C95; Mon, 25 Sep 2017 04:00:33 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6N027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:31 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/21] packed_ref_cache: add a backlink to the associated `packed_ref_store`
Date:   Mon, 25 Sep 2017 10:00:00 +0200
Message-Id: <8d26b082df7ae61ed9f55f35fe673a1e658e54b4.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLtw+4lIgxOzlSzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZWzZuZG1oFWq4vWMoywNjBNFuxg5
        OSQETCQetV9k62Lk4hAS2MEk8eTJV2YI5xSTxKYFl5lAqtgEdCUW9TSD2SICahIT2w6xgBQx
        C6xklpi09QorSEJYIF5i990HYDaLgKrEq9mrWUBsXoEoiRXnZrFBrJOXOPfgNjOIzSlgIfHm
        zBGwuJCAucT5G7dYJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mil5pSuokR
        EnSCOxhnnJQ7xCjAwajEwxvx73ikEGtiWXFl7iFGSQ4mJVHeu3wnIoX4kvJTKjMSizPii0pz
        UosPMUpwMCuJ8B5bDZTjTUmsrEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnw
        dm4DahQsSk1PrUjLzClBSDNxcIIM5wEavhykhre4IDG3ODMdIn+KUZej4+bdP0xCLHn5ealS
        4rwbQIoEQIoySvPg5sCSxStGcaC3hHnTQKp4gIkGbtIroCVMQEt6p4ItKUlESEk1MMo833Z8
        w6KqKbPTvEKaeYWML+t5a0e9s8rZWftWkP8lzwv7l7J3MyRvfdkRffOAsbhWbUNh54wNf13r
        S+szbVwOvZ9xePfHU+Wzlnr8/1VtOyGi12jaXrW9PxmVVkXXVAZO3HsvReZOj9rKOQ+vMqqH
        eP6+HGVaLvfseXlmdoC1svqtJ1t6apRYijMSDbWYi4oTAQwtC6jxAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It will prove convenient in upcoming patches.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index e411501871..a3d9210cb0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -7,7 +7,15 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 
+struct packed_ref_store;
+
 struct packed_ref_cache {
+	/*
+	 * A back-pointer to the packed_ref_store with which this
+	 * cache is associated:
+	 */
+	struct packed_ref_store *refs;
+
 	struct ref_cache *cache;
 
 	/*
@@ -154,7 +162,7 @@ static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
 }
 
 /*
- * Read from `packed_refs_file` into a newly-allocated
+ * Read from the `packed-refs` file into a newly-allocated
  * `packed_ref_cache` and return it. The return value will already
  * have its reference count incremented.
  *
@@ -182,7 +190,7 @@ static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
  *      compatibility with older clients, but we do not require it
  *      (i.e., "peeled" is a no-op if "fully-peeled" is set).
  */
-static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
+static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 {
 	FILE *f;
 	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
@@ -191,11 +199,12 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 	struct ref_dir *dir;
 
+	packed_refs->refs = refs;
 	acquire_packed_ref_cache(packed_refs);
 	packed_refs->cache = create_ref_cache(NULL, NULL);
 	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
 
-	f = fopen(packed_refs_file, "r");
+	f = fopen(refs->path, "r");
 	if (!f) {
 		if (errno == ENOENT) {
 			/*
@@ -205,7 +214,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 			 */
 			return packed_refs;
 		} else {
-			die_errno("couldn't read %s", packed_refs_file);
+			die_errno("couldn't read %s", refs->path);
 		}
 	}
 
@@ -218,7 +227,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 		const char *traits;
 
 		if (!line.len || line.buf[line.len - 1] != '\n')
-			die("unterminated line in %s: %s", packed_refs_file, line.buf);
+			die("unterminated line in %s: %s", refs->path, line.buf);
 
 		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
 			if (strstr(traits, " fully-peeled "))
@@ -258,7 +267,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 			last->flag |= REF_KNOWS_PEELED;
 		} else {
 			strbuf_setlen(&line, line.len - 1);
-			die("unexpected line in %s: %s", packed_refs_file, line.buf);
+			die("unexpected line in %s: %s", refs->path, line.buf);
 		}
 	}
 
@@ -293,7 +302,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct packed_ref_store *re
 		validate_packed_ref_cache(refs);
 
 	if (!refs->cache)
-		refs->cache = read_packed_refs(refs->path);
+		refs->cache = read_packed_refs(refs);
 
 	return refs->cache;
 }
-- 
2.14.1

