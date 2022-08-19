Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20804C32773
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348317AbiHSKIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348306AbiHSKIl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A974CEE
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:40 -0700 (PDT)
Received: (qmail 17669 invoked by uid 109); 19 Aug 2022 10:08:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 931 invoked by uid 111); 19 Aug 2022 10:08:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/11] transport: mark bundle transport_options as unused
Message-ID: <Yv9hJ0vAKqwR1BE0@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_refs_from_bundle() is a virtual function which must match the
signature of other transports, but it doesn't look at its
transport_options at all. This isn't a bug, because not all transports
necessarily support all options. Let's mark it as unused to appease
-Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index b51e991e44..551cad22dd 100644
--- a/transport.c
+++ b/transport.c
@@ -142,7 +142,7 @@ static void get_refs_from_bundle_inner(struct transport *transport)
 
 static struct ref *get_refs_from_bundle(struct transport *transport,
 					int for_push,
-					struct transport_ls_refs_options *transport_options)
+					struct transport_ls_refs_options *UNUSED(transport_options))
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
-- 
2.37.2.928.g0821088f4a

