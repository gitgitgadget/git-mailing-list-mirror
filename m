Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2946C71153
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjH1Vs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjH1VsY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE817F9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:48:21 -0700 (PDT)
Received: (qmail 597 invoked by uid 109); 28 Aug 2023 21:48:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:48:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4574 invoked by uid 111); 28 Aug 2023 21:48:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:48:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:48:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 20/22] bundle-uri: mark unused parameters in callbacks
Message-ID: <20230828214820.GT3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first hunk is similar to 02c3c59e62 (hashmap: mark unused callback
parameters, 2022-08-19), but was added after that commit.

The other two are used with for_all_bundles_in_list(), but don't use
their void data pointer.

Signed-off-by: Jeff King <peff@peff.net>
---
 bundle-uri.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 4b5c49b93d..8492fffd2f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -20,7 +20,7 @@ static struct {
 	{ BUNDLE_HEURISTIC_CREATIONTOKEN, "creationToken" },
 };
 
-static int compare_bundles(const void *hashmap_cmp_fn_data,
+static int compare_bundles(const void *hashmap_cmp_fn_data UNUSED,
 			   const struct hashmap_entry *he1,
 			   const struct hashmap_entry *he2,
 			   const void *id)
@@ -45,7 +45,7 @@ void init_bundle_list(struct bundle_list *list)
 }
 
 static int clear_remote_bundle_info(struct remote_bundle_info *bundle,
-				    void *data)
+				    void *data UNUSED)
 {
 	FREE_AND_NULL(bundle->id);
 	FREE_AND_NULL(bundle->uri);
@@ -779,7 +779,7 @@ static int unbundle_all_bundles(struct repository *r,
 	return 0;
 }
 
-static int unlink_bundle(struct remote_bundle_info *info, void *data)
+static int unlink_bundle(struct remote_bundle_info *info, void *data UNUSED)
 {
 	if (info->file)
 		unlink_or_warn(info->file);
-- 
2.42.0.505.g4c6fb48dec

