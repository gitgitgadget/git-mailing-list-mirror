Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62A6C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhLITXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhLITXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0FC0617A1
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i12so5064540wmq.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94fa0ttWFukWVEyNU9TPhZ048FdSAUD6gPLphJ4Fwfk=;
        b=Ssh7N8JqSqm0Y+ZBTq9KGy2+QM7tTKfPwTCa28B5kTuFikBmnpHDy0+9eIO6p2Ub0c
         kR7bsEg/byuJNelqVG/5jFpAwm4fC7gJDj7p48fFtPkqhX/DU6nVf0sDwPa8Fzvv/CtY
         UzUut5F+itG3ORKTMlVJ+05N2Mr4GIYyx4pxBW0VtMpPee7bzPEJxKibeZbMJ5UTwI3H
         X7RvzoPi04caC1C5O6xHUGhU+5EkqKSbnpc+h5UEIV+NarcrCCNCcFuX2OEFYQVDHN87
         WH7HGIYAgFyOuT43aTNGLz5bNfouRhiVM010rnAWwjIHy5KZ/+gcmXEu0xZwhFO8mOiO
         ZIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94fa0ttWFukWVEyNU9TPhZ048FdSAUD6gPLphJ4Fwfk=;
        b=3BDS5jYmjnizx+K2htxoCkc1sn/AAFmNBOc3DvPxDCPWYcZAEs38c9qVLSh+dpLa0e
         YGV279pHn9/2dmiSFfVMX4uJ6ORi0pDaGw41yPWw0q3D/2/ofVuTyH63TY1EtVnaVcJd
         Jsqd59Vb5eGL/9hP7IM9KQxLWxThrynmffvLfs1TwQ1o8/XwrdKwUgvL6JmBsb1yS90X
         YCvHLOzzfh6J4V5x3JfbAAR0Jf5iK7FXvY04UPI2ZPFyO9dc6QqKWRKbIPWP63f0puqi
         +l3mlMapm9bS7AYZhCJgxbvKR8Qg0NUVCjmwc7mHfaEhDqTY5koBV298k+THQ+c8xNF2
         fWWg==
X-Gm-Message-State: AOAM530Oks7/P6mV1gK1+bHX1RkIgvvNX1cKBUioMj0gOPQ4EU7U1n2D
        YTlnZmbRFydmrLVr20WAl4b7UmqNKujuhQ==
X-Google-Smtp-Source: ABdhPJwU9wbBniVKoSYV6ZIDdes9tmKWk4tAeG7zClgAWRxHDQ3UA1vvRHrohPzI0Gnj9SKR8m3OqQ==
X-Received: by 2002:a7b:c008:: with SMTP id c8mr10112498wmb.55.1639077573264;
        Thu, 09 Dec 2021 11:19:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed "int"
Date:   Thu,  9 Dec 2021 20:19:19 +0100
Message-Id: <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As documented in 320d0b493a2 (add helpers for detecting size_t
overflow, 2016-02-19) the arguments to st_mult() and st_add() "must be
unsigned". This code added in d9c66f0b5bf (range-diff: first
rudimentary implementation, 2018-08-13) operates on signed int.

In subsequent commits further overflows resulting in segfaults will be
fixed in this code, but let's start by removing this supposed guard
that does nothing except give us a false sense of
security. E.g. providing an "n" of INT_MAX here will result in "1" on
my system, causing us to write into memory.

There are other such issues left in the codebase, e.g. the code in
"builtin/clean.c" changed in 50a6c8efa2b (use st_add and st_mult for
allocation size computation, 2016-02-22). But let's focus on
range-diff.c for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index cac89a2f4f2..170e8623313 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -312,7 +312,7 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	int *cost, c, *a2b, *b2a;
 	int i, j;
 
-	ALLOC_ARRAY(cost, st_mult(n, n));
+	ALLOC_ARRAY(cost, n * n);
 	ALLOC_ARRAY(a2b, n);
 	ALLOC_ARRAY(b2a, n);
 
-- 
2.34.1.930.g0f9292b224d

