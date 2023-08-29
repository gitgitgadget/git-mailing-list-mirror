Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927E5C71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbjH2Xp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241277AbjH2XpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DBE1B1
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:20 -0700 (PDT)
Received: (qmail 14830 invoked by uid 109); 29 Aug 2023 23:45:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19856 invoked by uid 111); 29 Aug 2023 23:45:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 07/22] ls-tree: mark unused parameter in callback
Message-ID: <20230829234519.GE227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The formatting functions are dispatched from a table of function
pointers. The "path name only" function unsurprisingly does not need to
look at its "oid" parameter, but we must mark it as unused to make
-Wunused-parameter happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/ls-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f558db5f3b..209d2dc0d5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -241,7 +241,8 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 	return recurse;
 }
 
-static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
+static int show_tree_name_only(const struct object_id *oid UNUSED,
+			       struct strbuf *base,
 			       const char *pathname, unsigned mode,
 			       void *context)
 {
-- 
2.42.0.528.g7950723a09

