Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11802C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31606101B
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhJ2Sd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJ2Sd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:33:28 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4D9C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:30:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 71-20020a9d034d000000b00553e24ce2b8so10102986otv.7
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MId44IRPdQfWeXEJ+mxFT7POF5uMwyLvqwj4a8T2F4w=;
        b=pm3AfqY+w6aaDIiLOipo0wpudz1xnnv7NDn7vNBriiSnhJn66Oi49KtWD2Ueavrm2E
         IFspGAjIK0n9Huliz5KLnhygKNDYtSVl04Zs2HJrWz2thAdqqT0oZnTu/vMVS/4Np5sz
         oeVW9HU46PWk9KaX9QRGC83OmiOQUse62D95lyXNaTxFVE3zVq1o93baJSqOdnoeUxva
         EQb2vtdn2ec3nnFfk0xavmQoRX01ShjKE+0UYSC3yVCzvdXBhOBFIS401iyrvDJpDWCg
         kNAWrp6Qqet1YbWNN4eXyGtaeSKs44CxnoqfU/McAy75l8QdHGtvaEavrEhOwcTL1aGf
         jV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MId44IRPdQfWeXEJ+mxFT7POF5uMwyLvqwj4a8T2F4w=;
        b=12S6iq6G8ZjegyDd27EDDQCB/ZrieIZZgmlgqeo0VRX/aunASuBPcpjHTjuUT8cmkH
         kROz/STBH0VaI82GI1/wNM9bH7ba1XUpC0paBVqVOP5wXuhbmPZLfybKqhgyBB1moeby
         2Fev5xXPknYMDOoCdz8nCzkeXq/rgm59OOftlj2dM+RH9Npi/111AZhnUWE19EQy1H1q
         j2uAu3Pk/dDcAQ7wr81B6DkmFVoDRP5tcid0M0RPfi7PWT1gYwA2k0SqqzOPfPIB4XxS
         BBmGDEJvyo86lPer3Ghk9O4JJ8a9HXIlDkJqmTxBW/0D31oiLlJbHsv8HyChOpc72C7m
         Z26g==
X-Gm-Message-State: AOAM532jncHwltEIbUop21MRkNRmt9GvEKBtHlzl042tq6w/iyVIcQpT
        leOEr+4SMH90Ota7VUE0/7c=
X-Google-Smtp-Source: ABdhPJzcVIrCyAm1deVy2KbhgWJRRJw4XSTrHDP4MBWXja+Wvd+c2rUJERlgFn3/tMsYFFsd2N07sg==
X-Received: by 2002:a9d:222d:: with SMTP id o42mr9975776ota.21.1635532258592;
        Fri, 29 Oct 2021 11:30:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6463:ee8f:8638:ff1b? ([2600:1700:e72:80a0:6463:ee8f:8638:ff1b])
        by smtp.gmail.com with ESMTPSA id i13sm2104878oik.6.2021.10.29.11.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 11:30:58 -0700 (PDT)
Message-ID: <4039d500-1924-9610-495f-69e196f17322@gmail.com>
Date:   Fri, 29 Oct 2021 14:30:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
 <7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com>
 <211027.86r1c6yh52.gmgdl@evledraar.gmail.com>
 <756524c1-a3b9-29b5-bb72-f75a0c76ea1f@gmail.com>
 <211027.86ilxixoxz.gmgdl@evledraar.gmail.com>
 <e3c923b4-cce0-372c-31f4-9f091239ad8b@gmail.com>
 <211027.86a6iuxk3x.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211027.86a6iuxk3x.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2021 4:22 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 27 2021, Derrick Stolee wrote:
>> It still seems like we're better off letting the client request a
>> filter and have the server present URIs that the client can use,
>> and the server can choose to ignore the filter or provide URIs that
>> are specific to that filter.[...]
> 
> I've tested this a bit now and think there's no way to create such a
> bundle currently. I.e. try:
> 
>     git clone --filter=blob:none --single-branch --no-tags https://github.com/git/git.git
>     cd git
>     git config --unset remote.origin.partialclonefilter
>     git config --unset remote.origin.promisor
> 
> You'll get:
>     
>     $ GIT_TRACE_PACKET=1 git bundle create --version=3 master.bdl master
>     Enumerating objects: 306784, done.
>     Counting objects: 100% (306784/306784), done.
>     Compressing objects: 100% (69265/69265), done.
>     fatal: unable to read c85385dc03228450cb7fb6d306252038a91b47e6
>     error: pack-objects died
> 
> If you didn't do that config munging we'd create the pack, but it would
> be inflated with the blobs (after going back and getting them from the
> server).
> 
> So aside from any questions of how you'd hypothetically communicate your
> desire to get such bundle from the server, I don't think it could serve
> one up.
> 
> So I think this is moot until the bundle format itself could support
> it. I'll need to "git bundle [verify|unbundle]" whatever I get on the
> other end.

Thank you for demonstrating that bundles don't currently work with
filters. This would need to be remedied, but can be done independently.

For now, let's just make sure that there is a paved path for extending
whatever is decided here to work with filters in the future.

As for the overall design, I have some thoughts that I'm going to
break out into a new message responding to your cover letter.

Thanks,
-Stolee
