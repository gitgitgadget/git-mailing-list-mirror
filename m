Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0EBC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2BC611F2
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbhDUNwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbhDUNwK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 09:52:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDABC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:51:36 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q136so21854307qka.7
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXI2IM2+ouWuOrd2XdInwc4TlFjQzX6ZREt+7ZdPQn8=;
        b=j5hfmvKDmx7EOrmO3SAXQ+1DzA/Q1hYFLt11QIcqmZrTsQO+EUiiJxpPjnnsUFcFXA
         1g7xyv8/AjAlUlfPJn1pLNSq494ODvvc9+zpnXrg/VLgkzt/hjvAowRYW+VZ3SUDKykf
         AHwr+JvhyjKZLsJC9dAaHkJ7PVkYI4cdehvr6TcwrqNyjIIwft5hQGtih900wP4AO81d
         D1Gko3o8g5CQVMBFqhqL9YkFXSzNP+8AdsFpMQAYDaKYR2HBh8Buna5J5S67y98AvSdX
         eTBO3kFym2LUDZ+kcQD5vxng0OqQe5HqEn+SmrjlSSQNJiCmoBzOkzBOxsDIwh8n28mW
         CJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXI2IM2+ouWuOrd2XdInwc4TlFjQzX6ZREt+7ZdPQn8=;
        b=QCUngfqjFmsqvGs8gj40LTTMSiWCNp4+CJ1BSFutANNGuBP9tpRrxWncGQoHUREUP9
         EtA6RiFCih42mnF3u8Ted4E+OHbgwZU6YsoK0rv4Zw9ZOYt1+j9nos3IIpFu+jMmOpF1
         f2tSc9Pmx/QVaul1Z7yPv8BDpxL+wChHvkYaeyfGbmT5bElGd9JJWQ30WmnqYL0HxPaM
         AGnUyWMso+gIHolGghFHWXBJrPWKv/IA4RhSQe+lP4MkQ3HRNbATtO9IxkkxNUdew80g
         NeGiDS7r2up8Wzs7ioffblcaVF3D1NBOqKNRa51DAsLKOV/Zu6Bs5EqBUHxr4rqC67fJ
         WX0w==
X-Gm-Message-State: AOAM533HU7CdWlybnUElN9bR11ou/ClAWwYDoqL6UkW+z98xdWFc+txQ
        6YEfnBs8/py0wy3fALeL84I=
X-Google-Smtp-Source: ABdhPJw5uQrurMt4OFpdcvrf+VYNYZ2pv9QbQpxLKLid/Lab+5IyuASH4P/bsLJr4ewgTn3Q5Y/zGQ==
X-Received: by 2002:a37:6606:: with SMTP id a6mr15631010qkc.165.1619013095648;
        Wed, 21 Apr 2021 06:51:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e10e:eea5:8b82:2147? ([2600:1700:e72:80a0:e10e:eea5:8b82:2147])
        by smtp.gmail.com with ESMTPSA id x20sm2111908qkf.42.2021.04.21.06.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 06:51:35 -0700 (PDT)
Subject: Re: [PATCH 04/10] status: skip sparse-checkout percentage with
 sparse-index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <e86f874dd41291da66848068e7725a172dee231e.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHVSPLsXT36=pyrXRR_d9oWCs2aFhA0jh6_u4DzVcTMDg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e5374162-fc30-3e17-deec-4e6988958763@gmail.com>
Date:   Wed, 21 Apr 2021 09:51:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BHVSPLsXT36=pyrXRR_d9oWCs2aFhA0jh6_u4DzVcTMDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2021 7:26 PM, Elijah Newren wrote:
> On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Avoid the expensive computation by simplifying the output to only report
>> that a sparse checkout exists, without the percentage.
> 
> Makes sense.  The percentage wasn't critical, it was just a nice UI
> bonus.  The critical part is notifying about being in a sparse
> checkout.
> 
> It makes me wonder slightly if we'd want to remove the percentage for
> both modes just to keep them more similar.  I'll ask some folks for
> their thoughts/opinions.  Of course, that could always be tweaked
> later and doesn't necessarily need to go into your series.

I find the percentage helpful for users who are exploring the
sparse-checkout feature in their repositories. It's nice to know how
much time it is saving, because "percentage of files" frequently
translates to "percentage of time it takes to update the worktree".

I was sad to lose it here, but I don't see any way to keep it.

Thanks,
-Stolee
