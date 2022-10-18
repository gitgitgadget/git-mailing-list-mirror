Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC4AC4321E
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJRBJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJRBJK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:09:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42848E98E
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:09:08 -0700 (PDT)
Received: (qmail 28809 invoked by uid 109); 18 Oct 2022 01:09:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:09:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13480 invoked by uid 111); 18 Oct 2022 01:09:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:09:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:09:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/12] diffcore-pickaxe: mark unused parameters in pickaxe
 functions
Message-ID: <Y038swzBW99vnTeI@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a virtual pickaxe_fn for handling -G versus -S pickaxe options.
They need to take the same set of parameters, but of course they care
about different ones (e.g., a regex -G will never use a kwset).

Mark the unused ones to appease -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 diffcore-pickaxe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index c88e50c632..03fcbcb40b 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -38,7 +38,7 @@ static int diffgrep_consume(void *priv, char *line, unsigned long len)
 
 static int diff_grep(mmfile_t *one, mmfile_t *two,
 		     struct diff_options *o,
-		     regex_t *regexp, kwset_t kws)
+		     regex_t *regexp, kwset_t kws UNUSED)
 {
 	struct diffgrep_cb ecbdata;
 	xpparam_t xpp;
@@ -114,7 +114,7 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws,
 }
 
 static int has_changes(mmfile_t *one, mmfile_t *two,
-		       struct diff_options *o,
+		       struct diff_options *o UNUSED,
 		       regex_t *regexp, kwset_t kws)
 {
 	unsigned int c1 = one ? contains(one, regexp, kws, 0) : 0;
-- 
2.38.0.371.g300879f34e

