Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B944C83F1C
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbjH2Xqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241353AbjH2XqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:46:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFC3E70
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:37 -0700 (PDT)
Received: (qmail 14961 invoked by uid 109); 29 Aug 2023 23:45:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19923 invoked by uid 111); 29 Aug 2023 23:45:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 18/22] credential: mark unused parameter in urlmatch
 callback
Message-ID: <20230829234536.GP227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our select_all() callback does not need to actually look at its
parameters, since the point is to match everything. But we need to mark
its parameters to satisfy -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/credential.c b/credential.c
index d664754163..18098bd35e 100644
--- a/credential.c
+++ b/credential.c
@@ -88,8 +88,8 @@ static int proto_is_http(const char *s)
 static void credential_describe(struct credential *c, struct strbuf *out);
 static void credential_format(struct credential *c, struct strbuf *out);
 
-static int select_all(const struct urlmatch_item *a,
-		      const struct urlmatch_item *b)
+static int select_all(const struct urlmatch_item *a UNUSED,
+		      const struct urlmatch_item *b UNUSED)
 {
 	return 0;
 }
-- 
2.42.0.528.g7950723a09

