Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF67C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B52464E10
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhBPQM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhBPQMj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 11:12:39 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EDFC061756
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:11:59 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id q85so9850353qke.8
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nzAorhPNbftXwMtzjXu9sS0xKNG/Gd9Os0fBADkW9k0=;
        b=WDQrDqATY/qtBPKhSMkccJtRMOaiPp2OWB57HRIbm+3K21aHogZeOiaAsL1ioxFK6b
         e5zrfI2D0SXtEzvSLp2OF7IhsLa2Mgv2HdzZWJXG82RpqcKwgLcoP/QYhTgwBc4laFib
         CYLM2v7qgRlpRGqUrHo9c7rQiwmQSNqjStWWhWSw6KJHHOATsqhf04eCOQfWM+7bFfbx
         A9ni6LKB8P2WG2PmzgsQjsXtBB44913f1RSVP2T+c7HQoGLf+uv/HjjlY2Zp3zVJxn4D
         TsbCzqFFgO7duknbfPU/V8h9TzWeQ7jeeZ+OPzm03pnfs67PvVm4tXhCk1/2FrDoyTYX
         hsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nzAorhPNbftXwMtzjXu9sS0xKNG/Gd9Os0fBADkW9k0=;
        b=fUv7QF4shJKlUpkp+Kpns6qiFKoOuVLXnO/RyD/dHCvJkB6/yDXFgSMSx/hNjhrgdu
         hGySNRwDS2ZRSI25trCBH7c1ua352U4O44keteltW6ZdRFfeFb0RsESDKAgkXYOppTjZ
         QWZfKJTIWAP8sdokqYUIP3JYhf4UH8PZ1nzVawkK6Fw7EyS1rXl9vfc0z29lKgGD8lYR
         ov8WyYXrkte8vll4l5mOSPjeQVfvJXcUSGYBcUJVBUxdOvieyS8c7jw3cV7xdVd9cQVc
         OmW3fIT5yiO1hI82YQT66vZRlPXDtDZnTj7rj9oJiAXliOZ44mJythLhtsSSab1ALX/7
         b8MA==
X-Gm-Message-State: AOAM530Lx06+uiBVESAXWcnz2dqjtADQN/Avi03hjR/XLYAm25o2egwk
        9X4UBpXf7GUYUWFa5JGyIhuG8w==
X-Google-Smtp-Source: ABdhPJxx/4egk+WuVkyOIkSIqqbVbvUFdNexcl+L5CIDvPoPXM2Y/55m1uO7i06D4afZJBn478u4WA==
X-Received: by 2002:a37:a64b:: with SMTP id p72mr20415555qke.99.1613491918923;
        Tue, 16 Feb 2021 08:11:58 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id r4sm14637539qkf.112.2021.02.16.08.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:11:58 -0800 (PST)
Date:   Tue, 16 Feb 2021 11:11:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] add open_nofollow() helper
Message-ID: <YCvuy80k/P8qQ1h7@nand.local>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
 <YCvaRpQs99TBaCrQ@coredump.intra.peff.net>
 <YCvcoPnDAEWNcv+h@coredump.intra.peff.net>
 <YCvoQBhmCeeR9Cup@nand.local>
 <YCvsj2Teym2K06wa@coredump.intra.peff.net>
 <YCvty0WvJycB7WXi@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvty0WvJycB7WXi@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 11:07:39AM -0500, Taylor Blau wrote:
> On Tue, Feb 16, 2021 at 11:02:23AM -0500, Jeff King wrote:
> > Can you double-check your initial timings?
>
> Aha, I forgot to update the input to the second check-attr tests after
> putting .gitattributes files everywhere.
>
> Rerunning with O_NOFOLLOW, the initial timings look something like
> 128.8ms and 183.7ms before/after.

I should add that "before" refers to a clean checkout, and "after"
refers to the state after running 'find * -type d | ... | xargs touch'.
Both of those numbers are with the O_NOFOLLOW branch.

If I repeat the test after applying:

diff --git a/wrapper.c b/wrapper.c
index 563ad590df..90f603e749 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -681,7 +681,7 @@ int is_empty_or_missing_file(const char *filename)

 int open_nofollow(const char *path, int flags)
 {
-#ifdef O_NOFOLLOW
+#if 0
        return open(path, flags | O_NOFOLLOW);
 #else
        struct stat st;

Then those numbers go from 155.9ms to 197.2ms.

Thanks,
Taylor
