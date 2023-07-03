Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC16C0015E
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGCGom (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjGCGob (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446741B4
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:30 -0700 (PDT)
Received: (qmail 14099 invoked by uid 109); 3 Jul 2023 06:44:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2640 invoked by uid 111); 3 Jul 2023 06:44:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/14] replace: mark unused parameter in each_mergetag_fn
 callback
Message-ID: <20230703064428.GK3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't look at the "commit" parameter to our callback, as our
"mergetag_data" pointer contains the original name "ref", which we use
instead. But we can't get rid of it, since other for_each_mergetag
callbacks do use it. Let's mark the parameter to avoid
-Wunused-parameter warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 17b75229d2..da59600ad2 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -409,7 +409,7 @@ struct check_mergetag_data {
 	const char **argv;
 };
 
-static int check_one_mergetag(struct commit *commit,
+static int check_one_mergetag(struct commit *commit UNUSED,
 			       struct commit_extra_header *extra,
 			       void *data)
 {
-- 
2.41.0.586.g3c0cc15bc7

