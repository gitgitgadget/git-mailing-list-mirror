Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0556DEB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGCGol (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGCGo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569E9E8
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:27 -0700 (PDT)
Received: (qmail 14091 invoked by uid 109); 3 Jul 2023 06:44:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2637 invoked by uid 111); 3 Jul 2023 06:44:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/14] replace: mark unused parameter in ref callback
Message-ID: <20230703064425.GJ3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't look at the "flags" parameter, which is natural for something
that is just printing the contents of the replace refs. But let's mark
it to appease -Wunused-parameter.

This probably should have been part of 63e14ee2d6 (refs: mark unused
each_ref_fn parameters, 2022-08-19), but I missed it as this one is a
repo_each_ref_fn, which takes an extra repository argument.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 9ceaa25233..17b75229d2 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -49,7 +49,7 @@ struct show_data {
 
 static int show_reference(struct repository *r, const char *refname,
 			  const struct object_id *oid,
-			  int flag, void *cb_data)
+			  int flag UNUSED, void *cb_data)
 {
 	struct show_data *data = cb_data;
 
-- 
2.41.0.586.g3c0cc15bc7

