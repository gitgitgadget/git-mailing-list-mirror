Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344201F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfAGIeO (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:34:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:56318 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725550AbfAGIeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:34:14 -0500
Received: (qmail 1182 invoked by uid 109); 7 Jan 2019 08:34:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:34:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 703 invoked by uid 111); 7 Jan 2019 08:33:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:33:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:34:12 -0500
Date:   Mon, 7 Jan 2019 03:34:12 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 02/11] update comment references to sha1_object_info()
Message-ID: <20190107083412.GB29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit abef9020e3 (sha1_file: convert sha1_object_info* to object_id,
2018-03-12) renamed the function to oid_object_info(), but missed some
comments which mention it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c     | 6 +++---
 builtin/pack-objects.c | 4 ++--
 cache.h                | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2ca56fd086..baaafbdcf3 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -209,14 +209,14 @@ struct expand_data {
 
 	/*
 	 * After a mark_query run, this object_info is set up to be
-	 * passed to sha1_object_info_extended. It will point to the data
+	 * passed to oid_object_info_extended. It will point to the data
 	 * elements above, so you can retrieve the response from there.
 	 */
 	struct object_info info;
 
 	/*
 	 * This flag will be true if the requested batch format and options
-	 * don't require us to call sha1_object_info, which can then be
+	 * don't require us to call oid_object_info, which can then be
 	 * optimized out.
 	 */
 	unsigned skip_object_info : 1;
@@ -490,7 +490,7 @@ static int batch_objects(struct batch_options *opt)
 
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
-	 * object_info to be handed to sha1_object_info_extended for each
+	 * object_info to be handed to oid_object_info_extended for each
 	 * object.
 	 */
 	memset(&data, 0, sizeof(data));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 24bba8147f..d4c3987f3e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1642,7 +1642,7 @@ static void check_object(struct object_entry *entry)
 
 		/*
 		 * No choice but to fall back to the recursive delta walk
-		 * with sha1_object_info() to find about the object type
+		 * with oid_object_info() to find about the object type
 		 * at this point...
 		 */
 		give_up:
@@ -1718,7 +1718,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	if (packed_object_info(the_repository, IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
-		 * fall back to sha1_object_info, which may find another copy.
+		 * fall back to oid_object_info, which may find another copy.
 		 * And if that fails, the error will be recorded in oe_type(entry)
 		 * and dealt with in prepare_pack().
 		 */
diff --git a/cache.h b/cache.h
index ca36b44ee0..587512747b 100644
--- a/cache.h
+++ b/cache.h
@@ -1592,7 +1592,7 @@ extern int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
 extern int odb_pack_keep(const char *name);
 
 /*
- * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
+ * Set this to 0 to prevent oid_object_info_extended() from fetching missing
  * blobs. This has a difference only if extensions.partialClone is set.
  *
  * Its default value is 1.
-- 
2.20.1.470.g640a3e2614

