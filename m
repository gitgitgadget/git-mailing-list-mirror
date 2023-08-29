Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6ECC83F19
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbjH2Xqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbjH2XqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:46:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABC510C8
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:38 -0700 (PDT)
Received: (qmail 14973 invoked by uid 109); 29 Aug 2023 23:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19930 invoked by uid 111); 29 Aug 2023 23:45:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 19/22] fetch: mark unused parameter in ref_transaction
 callback
Message-ID: <20230829234537.GQ227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
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
2.42.0.528.g7950723a09

