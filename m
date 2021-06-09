Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C43C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665D3613D3
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhFIRm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:42:26 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:44605 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFIRmW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 13:42:22 -0400
Received: by mail-qt1-f175.google.com with SMTP id t17so18644672qta.11
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B9mPL1wEatH6emkvAIxecJv+DqLFDtSAcvmtwENfrys=;
        b=cNnwHmOd7zvAkwxTG+nn+1G68rHMg6Z/VfV9Zv7tyx8ApMtuuQzUEpAAuavqriZEEb
         7skkiM+c2uqnhVnSVNMwl+UmGuCg3y+j82MuK0MNY9niRcbbs/qo5Lky0xalnqg/PnkF
         0liJYNlAaaeAFMt3N9qYW0s4KAHpMfRLrBb1fZ8RRgYiJhMMImfJZDMDZkJ1Jtog77Qf
         ezNUBADZE3PtTQYaricbHvCGzeiBzXMKepOU2m/OqkRN3tDOP9XX5LwNOdjXNK+RG3gu
         lSlvoVQXajvlWDO0YgGEdmFRgngLd1rRtSivlvXxEmV5Zhp8arO4QwOj173XyKKJnbmr
         VLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B9mPL1wEatH6emkvAIxecJv+DqLFDtSAcvmtwENfrys=;
        b=gsA2zNq924Y6xbkxpPoosziT3lshkD4QFhaRBMS9TOvGnppj+Dt8U1zaLSBFcZVIvk
         hvvKVdX+MO0fXVIBQXYdzApAlb0Xg47IuFBlBKU+Tl0d0xpar7ngvzPNFEtjG6Aa0C1N
         E2zBAoFPW53sRSg4SMoqJFzviGLiKYM3x5H35dWzNfwciOO1ScCzt2QmbeMTHA2jHgAH
         GsEp/Z0od/bQZweWLmOplnVu0SE1/zPEGb3/RfbbpXjBayoU6ls2Ng5PPeogKMivQpEX
         Xeh+Ajkfq3hZfhDu7owa5T5AtqfAGeymXl2eajxX28ozVKdlts8pVrxKzgGPo2tmtpmU
         Ooeg==
X-Gm-Message-State: AOAM530RjGebvy3BmuccMIlP4deVbdbix5JHzI3KaFPFTV47MBADTkdz
        Ya2QdNiMMFCHs2nVpQOW8wo=
X-Google-Smtp-Source: ABdhPJyzQpMPPgFXJBL/SEjwuZDCUzB8Z/yXIBr384vL1pki16mpgZzzYvaB4UsezUJucMk2W/CXkw==
X-Received: by 2002:ac8:604:: with SMTP id d4mr1059843qth.304.1623260366405;
        Wed, 09 Jun 2021 10:39:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:757b:21f8:d6f2:dd1b? ([2600:1700:e72:80a0:757b:21f8:d6f2:dd1b])
        by smtp.gmail.com with ESMTPSA id d10sm426489qtd.82.2021.06.09.10.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 10:39:26 -0700 (PDT)
Subject: Re: [PATCH v5 02/14] sparse-index: include EXTENDED flag when
 expanding
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
 <8aa41e749471df3bd9d593b8f55db6506eafea12.1623069252.git.gitgitgadget@gmail.com>
 <CABPp-BGrAU==rEjtX5DNXs05_pcSVzAZBTFxGgGEA+xUO1oS1Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <23508662-37f2-97a4-3cf0-916a3705a272@gmail.com>
Date:   Wed, 9 Jun 2021 13:39:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGrAU==rEjtX5DNXs05_pcSVzAZBTFxGgGEA+xUO1oS1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2021 2:56 PM, Elijah Newren wrote:
> On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When creating a full index from a sparse one, we create cache entries
>> for every blob within a given sparse directory entry. These are
>> correctly marked with the CE_SKIP_WORKTREE flag, but they must also be
>> marked with the CE_EXTENDED flag to ensure that the skip-worktree bit is
>> correctly written to disk in the case that the index is not converted
>> back down to a sparse-index.
> 
> In our previous discussion on this patch from v3
> (https://lore.kernel.org/git/cb9161ca-dc6e-b77b-1a41-385ed8920bb2@gmail.com/),
> you said you'd explain the reason for this change in a bit more
> detail, but the commit message has not changed.

Thank you for the reminder.

> Could this be corrected?

How does this sound?

    When creating a full index from a sparse one, we create cache entries
    for every blob within a given sparse directory entry. These are
    correctly marked with the CE_SKIP_WORKTREE flag, but the CE_EXTENDED
    flag is not included. The CE_EXTENDED flag would exist if we loaded a
    full index from disk with these entries marked with CE_SKIP_WORKTREE, so
    we can add the flag here to be consistent. This allows us to directly
    compare the flags present in cache entries when testing the sparse-index
    feature, but has no significance to its correctness in the user-facing
    functionality.

I have this in my local branch for now, but can update it before the next
version.

Thanks,
-Stolee
