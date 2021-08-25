Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A540C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8255C60184
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbhHYO2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 10:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbhHYO2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 10:28:11 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1331EC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:27:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 14so27315151qkc.4
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1Oy5CN5xob3++Jf1HwFeOp4SH2NhSMrWe05rjRhE+oQ=;
        b=APrILOcQnkwJGLoxf4PVCS+ELUEc9YvP0U73ZnCrA0ZumlRk3LSLk+t7e9VVN2fG8d
         mKmTP1Jprbtr1fhzRHE+DykzJsdH16aHWX1Xir4aTbxZg9MjbfNUI3FYUgd+e8M4NegU
         bkFEgcLt8Swk//WMz8r0eCijIcdDp2F7gVAW6czVXrun9C8TGdFdNFPuJ5JYmzev3gb3
         KVmwfsqRwej8yN8YcEK7IbqdJBdgPrDdViLpodlz4GnVI7hrUPUNC5J6S8alhp0YPphv
         E4YXOKFwbEkR1YtZ2+FtCp8QR0grFTaFRpTVdRkSei/iayVV88drzUdzf1UY3WbZIh/o
         yRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Oy5CN5xob3++Jf1HwFeOp4SH2NhSMrWe05rjRhE+oQ=;
        b=BNqCsegakRcV6ouBCTbDZkmM63mkBDhi6BYZ5YgaHR/0qJSz19KuUvBfYMzXuYLGQ2
         eOW3X8A51PwaVQr2FTccwp8Rj+F43oh+yb0sBrCyn6v0cyJxIFGqtXFZLJPa4+uOgcJh
         VUSGINMHkwJu309MDIWB+6dg8qabf6w6g19Id/gRja9WQ+ara1hqnNEXaBjf2LvA9af3
         oqhPJAG+XmoPi7W/V/Tyo9VZ4PNUK8eaSTIxh8o13T0Zf5vsFFY++v1d1fLbqfzyT00q
         GfQKJo9teKCRdrcQAJEGWayrrERKSwaKfZbI3PyII9yIA8eMyRKs1XFhH/70CKM3is8O
         ph1w==
X-Gm-Message-State: AOAM532mUtt6SSI1fwx5fM9/GZBbewH5d8OcAbVKTsfa1y6H1HH96p3c
        KU3zLaaPcUUzLpH+KiMF8Dw=
X-Google-Smtp-Source: ABdhPJwjDFyDXMAwW9LkmepXDlR196IsokN+f+PQX5UMEUeOZ+coR+5+UDU62C5WTehxDjknzU1O1A==
X-Received: by 2002:a05:620a:288b:: with SMTP id j11mr31571719qkp.175.1629901645166;
        Wed, 25 Aug 2021 07:27:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6d81:bb65:3870:d879? ([2600:1700:e72:80a0:6d81:bb65:3870:d879])
        by smtp.gmail.com with ESMTPSA id z186sm91048qke.59.2021.08.25.07.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:27:24 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Speed up mirror-fetches with many refs
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover.1629452412.git.ps@pks.im> <cover.1629800774.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fc0c8047-4d46-a349-88d3-f959c25de953@gmail.com>
Date:   Wed, 25 Aug 2021 10:27:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1629800774.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2021 6:36 AM, Patrick Steinhardt wrote:
> Changes compared to v1:
> 
>     - Patch 1/7: I've applied Stolee's proposal to only
>       opportunistically load objects via the commit-graph in case the
>       reference is not in refs/tags/ such that we don't regress repos
>       with many annotated tags.
> 
>     - Patch 3/7: The return parameter of the iterator is now const to
>       allow further optimizations by the compiler, as suggested by
>       René. I've also re-benchmarked this, and one can now see a very
>       slight performance improvement of ~1%.
> 
>     - Patch 4/7: Added my missing DCO, as pointed out by Junio.
> 
>     - Patch 5, 6, 7: I've redone these to make it clearer that the
>       refactoring I'm doing doesn't cause us to miss any object
>       connectivity checks. Most importantly, I've merged `fetch_refs()`
>       and `consume_refs()` into `fetch_and_consume_refs()` in 6/7, which
>       makes the optimization where we elide the second connectivity
>       check in 7/7 trivial.

These changes are positive. My read through this set of patches
had only a few nit-picks.

Thanks,
-Stolee
