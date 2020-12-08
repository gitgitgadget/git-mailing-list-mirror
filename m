Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C3C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F40F23A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgLHAFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLHAFR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:17 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012EFC06138C
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:04:37 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id y74so17505712oia.11
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aTPqehF/iR92lHl5qU6Qtb+pF/tTsVor4twzj8uNe5U=;
        b=CoQkznRX2vLhrMm4wInB7eGzfOoBCY/H2eRTME8ZsIqvl2BsaCaH3lY+/BTMSerZMU
         KLin/yJ7JR1uV5A+EtfZsI1XRhkU/to26EGi2Givinv76IxvKQLc0jUHiip07qAVqsow
         uajIvLRuX+k2HD/1V+dkExod1EnfXhD5v4s5ZHolDTT8tp20v1MYE/IOdNag2FT8jl/0
         gpg6JkvyGYjGkie3T4rP0C+j+mPI7zMxV+H3DLISG3a83IdLyeaHba+Q4ORBiJIDZqfy
         ejSXBVYusip9m+GGL63kAHkDibVKOR6P7FpATIkGE8w35puKge3CgL8cL1VWBdfnr+Un
         4LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aTPqehF/iR92lHl5qU6Qtb+pF/tTsVor4twzj8uNe5U=;
        b=VydywP/5Sd3sZW4IhHSMSNesvIaKsx4LGga7Y5w/1vICmdO5Ud3msMItE41msErYI3
         z7pyHT+gLx3LyqAHmtZNQQyqZ3K8pVwOYl9jBLWiQJQn/0P7cd/g2BG3SkSrxoQsqMCD
         QMEAhsmGEow8BreCWW0xwJPX6Y+zqWmS26+ScLP1sJ9f90ulk08rTa1iNdi7RAPhsFpk
         mIUWA3p0Ai3mHHcBzIr9OkDGRwU9BL+gvddzSI42k2fOPtXC4L4ZJxBMVgN/sUKgQH4R
         PwWj8uNRfO8UbyYIuymCBe7mGL6pa0hw8ba0gl7d+qOi/eOea13bcJdGUrAbaS5nvykl
         Reww==
X-Gm-Message-State: AOAM531a/eqHhlq5u+orGH8ef0UTSCy8EymLktVLobM6cP+pd7jnNDMa
        Yc15iX3P/60IJQlSqAeED9yKTbuhg0rRtNXS
X-Google-Smtp-Source: ABdhPJwV/jBhN3SEBoqD+2DAt5+aAO01p6ddOSJjMMBrBIcoIpSiZc2moSiF4Z5yOdHjLUv6p018wA==
X-Received: by 2002:aca:3ad6:: with SMTP id h205mr939499oia.119.1607385876104;
        Mon, 07 Dec 2020 16:04:36 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id n31sm1085098otn.33.2020.12.07.16.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:04:35 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:04:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 05/24] rev-list: die when --test-bitmap detects a mismatch
Message-ID: <c99cacea6792fab685f821ef19ae4e20b91f5875.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
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
2.29.2.533.g07db1f5344

