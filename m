Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296B0C11F68
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCC86128B
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhF2Uzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:55:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34810 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235605AbhF2Uzl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 16:55:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CE5AF1F9F3;
        Tue, 29 Jun 2021 20:53:05 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 4/5] oidcpy_with_padding: constify `src' arg
Date:   Tue, 29 Jun 2021 20:53:04 +0000
Message-Id: <20210629205305.7100-5-e@80x24.org>
In-Reply-To: <20210627024718.25383-1-e@80x24.org>
References: <20210627024718.25383-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with `oidcpy', the source struct will not be modified and
this will allow an upcoming const-correct caller to use it.

Signed-off-by: Eric Wong <e@80x24.org>
---
 hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hash.h b/hash.h
index 9c6df4d952..27a180248f 100644
--- a/hash.h
+++ b/hash.h
@@ -265,7 +265,7 @@ static inline void oidcpy(struct object_id *dst, const struct object_id *src)
 
 /* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
 static inline void oidcpy_with_padding(struct object_id *dst,
-				       struct object_id *src)
+				       const struct object_id *src)
 {
 	size_t hashsz;
 
