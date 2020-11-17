Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC5AC63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C81241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cYjXYzjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgKQVqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgKQVqw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:46:52 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513B9C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:52 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id v20so8313914qvx.4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BvjQlX/qMG8QjnQOEs4lX90tShF0U0rm3K0EXLIQjzw=;
        b=cYjXYzjlpsp0EPw0d2vCjjtjo0xmteB7Fit6oeBMsJdVKN2nVtlvCWftIdI7a/eZ1u
         RS01zkx16NLWFLdUC+B8JRULJBs75tGjxaMr9CgF40UDTr2BvDk4JaYSD6XWKjHLE365
         QjEYbdbiNO/+MSNYyax5SCFKSPAZnK/QzQVkp7Rq5SdcaOFYvGmpuxAvnfAy7HPVSNDF
         Jv9Pgqdbx1cz8x9qWNtr7mI9Gbn0t1qJ+uaZUOflUwnABc6B0n0S2x4u/DbjaT/Y6yqW
         6p70/ZhSo5Yr5y2gCaYXp7bp3cJ41rDTz3IJNwiO2D8Xni8YH/r9ZOiOte06K245D96/
         TU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BvjQlX/qMG8QjnQOEs4lX90tShF0U0rm3K0EXLIQjzw=;
        b=NWdnpj3dirHgxULQiwfbj0HjYrGp5zctpFrPR3EuP3QD1EJd5FAVK4aMHueAkc7wlO
         /Ws25CKTqM9GoyjmpwOU/FRToe3T2IWBPwXzfm37XsbGJc130EroWHg+Yy1GQkH6KQQT
         LgGX3ZRtdEy6/wgRGht4xElCLxYLfDHgauQcaJhlFdN2JeThqFgTkaLyotM1elh8ZV6+
         t8zyJSBNChg0rmSAqrma9E8NeOudC2aSUys7J9yPOme1O13HvKCoaLIVuFIp/Fiasvu8
         z+9QCKS3LRUlH3TVesInBumbVF2iQ+TpXIXHTcGmN6BTHry1wpIATmCkLGXohxBXmjwQ
         4i/w==
X-Gm-Message-State: AOAM533XmEf9hV0v2NioL+VOIDiJy9pQFAWJQcNOwcxPdA2K6M/D1Ve+
        cMW4Hc9TFvJuBjtuj++6yKO49gEOunEyBpPA
X-Google-Smtp-Source: ABdhPJx2Ak8cJqg0+ILquN9cWdtbO71WWkxdtVeg5gMnXjoNGGZX+iTX4xPK8c6cKPEmpUi5ejRbqQ==
X-Received: by 2002:a0c:80e1:: with SMTP id 88mr1947107qvb.10.1605649611282;
        Tue, 17 Nov 2020 13:46:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id d48sm15814626qta.26.2020.11.17.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:46:50 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:46:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 05/24] rev-list: die when --test-bitmap detects a mismatch
Message-ID: <1a9ac1c4aefcc8e4665106a39ce6c6c0b2a4a52c.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

You can use "git rev-list --test-bitmap HEAD" to check that bitmaps
produce the same answer we'd get from a regular traversal. But if we
detect an error, we only print "mismatch", and still exit with a
successful error code.

That makes the uses of --test-bitmap in the test suite (e.g., in t5310)
mostly pointless: even if we saw an error, the tests wouldn't notice.
Let's instead call die(), which will let these tests work as designed,
and alert us if the bitmaps are bogus.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 074d9ac8f2..4431f9f120 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1328,7 +1328,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (bitmap_equals(result, tdata.base))
 		fprintf(stderr, "OK!\n");
 	else
-		fprintf(stderr, "Mismatch!\n");
+		die("mismatch in bitmap results");
 
 	free_bitmap_index(bitmap_git);
 }
-- 
2.29.2.312.gabc4d358d8

