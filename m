Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08996C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8CB23B06
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbhAVVfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbhAVVec (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 16:34:32 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD95BC061786
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 13:32:49 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id c7so6666288qke.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 13:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZJuvkRXCQiRuU7e93SPE5O+huA3fsW+0NPWfMy4MDw=;
        b=gSO0/12WiKBUnjcwItX7MA21dCWQZ+GOkSJdV4j0zABisnrvwG8nmgaFg9J3Dm0kZX
         bWDy/pXjujwKU09TPzMad+71ha2as5lOc5p8mWJj1jWgAkTQ6tGFTTr4SH/lxySaexpc
         MPgWZ7aGMD7U4evLUARt0YKZzUrvVJ6FAwNctRB1u1YC8I6Y/Bg3kAQrxvFFy7hticMM
         czeCcY1fLqVkhLY0scCeqkWU1SahOU2iUpSSM/woNVRe4Rsp/NSWv4eCB8temoqHZWfW
         9U/BBB0t7+F8QcArAdqY6FSLXKLXLujIE3r5vHPWrpScCXG5h74pdPtbo7M+ReMEfMH9
         d5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KZJuvkRXCQiRuU7e93SPE5O+huA3fsW+0NPWfMy4MDw=;
        b=WvLCf1US6S3lA2ZWyOc3g2Ltk0EsZBAUBF5VGNsEO3l6kQ8uSVHf+NeVjFm7MU7+uA
         IHFmVIBgbaJ+6RiCfDvazpvNh4ow2ieqbSoZbyLPqBSpz+VDAlb4///6A1xTViOPWf8e
         zK+7jW1yrgDqINKCIVeizeEbRyRopvAZSXLd0g/W0YUn3bmwfC94Lm+RLMwMiW7NdWMK
         Wm17rVA8whLLBXOfxcp4VNQ57RO8rtHqx6KjZzkA+9HMesWoumI1IFJ0eQ0/8btbvu/2
         Z94YzrBYE2muO8MKxen4RK9CyusF9cXSSSJpM/2x+X6G9yCW/IR/rj5+AX9X+kJi1HRC
         UsRQ==
X-Gm-Message-State: AOAM530yoQdqVcAvNeRfF+iIXHLRfLvBmS95jQ4cZYtERKoLeXeHc+2w
        EZMO9RtjoI/Yspe/xNng2uP3Ew==
X-Google-Smtp-Source: ABdhPJxs91Gl68Aei/ZQBDFxRPtz8c2A+rwXnH4XwVnuKYEhxJLXrL3YmoCx3obZfM/VdQ1wgRQOHA==
X-Received: by 2002:a37:4f44:: with SMTP id d65mr234777qkb.165.1611351169189;
        Fri, 22 Jan 2021 13:32:49 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c9ba:d35d:aff9:448c])
        by smtp.gmail.com with ESMTPSA id o21sm7221572qko.9.2021.01.22.13.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 13:32:48 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:32:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Vosmaer <jacob@gitlab.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] run-command: document use_shell option
Message-ID: <YAtEfuygxMhZpo2o@nand.local>
References: <20210122142137.21161-1-jacob@gitlab.com>
 <20210122142137.21161-2-jacob@gitlab.com>
 <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
 <YAs9pTBsdskC8CPN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAs9pTBsdskC8CPN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 04:03:33PM -0500, Jeff King wrote:
> Subject: [PATCH] run-command: document use_shell option

Nice. This does indeed make things a little clearer (and as we've seen
it was certainly not as clear before), so I think this is worth doing.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
