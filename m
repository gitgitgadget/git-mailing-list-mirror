Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A8EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjGCGon (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjGCGoh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C36E55
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:34 -0700 (PDT)
Received: (qmail 14111 invoked by uid 109); 3 Jul 2023 06:44:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2646 invoked by uid 111); 3 Jul 2023 06:44:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/14] tag: mark unused parameters in each_tag_name_fn
 callbacks
Message-ID: <20230703064433.GM3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We iterate over the set of input tag names using callbacks. But not all
operations need the same inputs, so some parameters go unused (but of
course not the same ones for each operation). Mark the unused ones to
avoid -Wunused-parameter warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index e63bee8eab..81ca3fa19a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -121,7 +121,7 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 	return had_error;
 }
 
-static int collect_tags(const char *name, const char *ref,
+static int collect_tags(const char *name UNUSED, const char *ref,
 			const struct object_id *oid, void *cb_data)
 {
 	struct string_list *ref_list = cb_data;
@@ -155,7 +155,7 @@ static int delete_tags(const char **argv)
 	return result;
 }
 
-static int verify_tag(const char *name, const char *ref,
+static int verify_tag(const char *name, const char *ref UNUSED,
 		      const struct object_id *oid, void *cb_data)
 {
 	int flags;
-- 
2.41.0.586.g3c0cc15bc7

