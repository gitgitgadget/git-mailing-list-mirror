Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B20C83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjH1Vs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjH1VsW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB0F9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:48:19 -0700 (PDT)
Received: (qmail 594 invoked by uid 109); 28 Aug 2023 21:48:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:48:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4571 invoked by uid 111); 28 Aug 2023 21:48:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:48:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:48:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 19/22] fetch: mark unused parameter in ref_transaction
 callback
Message-ID: <20230828214818.GS3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this callback is just trying to collect the set of queued tag
updates, there is no need for it to look at old_oid at all. Mark it as
unused to appease -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index eed4a7cdb6..8f93529505 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -308,7 +308,7 @@ static void clear_item(struct refname_hash_entry *item)
 
 
 static void add_already_queued_tags(const char *refname,
-				    const struct object_id *old_oid,
+				    const struct object_id *old_oid UNUSED,
 				    const struct object_id *new_oid,
 				    void *cb_data)
 {
-- 
2.42.0.505.g4c6fb48dec

