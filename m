Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E946C0015E
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGCGoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjGCGoR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D9134
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:15 -0700 (PDT)
Received: (qmail 14052 invoked by uid 109); 3 Jul 2023 06:44:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2625 invoked by uid 111); 3 Jul 2023 06:44:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/14] count-objects: mark unused parameter in alternates
 callback
Message-ID: <20230703064413.GF3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callbacks to for_each_altodb() get a void data pointer, but we don't
need it here. Mark it as unused to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/count-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 97cdfb0ac5..2d4bb5e8d0 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -82,7 +82,7 @@ static int count_cruft(const char *basename UNUSED, const char *path,
 	return 0;
 }
 
-static int print_alternate(struct object_directory *odb, void *data)
+static int print_alternate(struct object_directory *odb, void *data UNUSED)
 {
 	printf("alternate: ");
 	quote_c_style(odb->path, NULL, stdout, 0);
-- 
2.41.0.586.g3c0cc15bc7

