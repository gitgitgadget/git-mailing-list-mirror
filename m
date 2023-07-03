Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728DDEB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGCGot (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjGCGoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC5D3
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:37 -0700 (PDT)
Received: (qmail 14121 invoked by uid 109); 3 Jul 2023 06:44:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2649 invoked by uid 111); 3 Jul 2023 06:44:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 14/14] t/helper: mark unused callback void data parameters
Message-ID: <20230703064436.GN3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many callback interfaces have an extra void data parameter, but we don't
always need it (especially for dumping functions like the ones in test
helpers). Mark them as unused to avoid -Wunused-parameter warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-dump-split-index.c | 2 +-
 t/helper/test-oid-array.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 5cf0b26dca..f29d18ef94 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -7,7 +7,7 @@
 #include "split-index.h"
 #include "ewah/ewok.h"
 
-static void show_bit(size_t pos, void *data)
+static void show_bit(size_t pos, void *data UNUSED)
 {
 	printf(" %d", (int)pos);
 }
diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index eef68833b7..aafe398ef0 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -4,7 +4,7 @@
 #include "setup.h"
 #include "strbuf.h"
 
-static int print_oid(const struct object_id *oid, void *data)
+static int print_oid(const struct object_id *oid, void *data UNUSED)
 {
 	puts(oid_to_hex(oid));
 	return 0;
-- 
2.41.0.586.g3c0cc15bc7
