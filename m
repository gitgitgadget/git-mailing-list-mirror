Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917E1C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A3660FA0
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 14:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbhJGPBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 11:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhJGPB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 11:01:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF72C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 07:59:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r18so20041925wrg.6
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R2o1S8ctDNMnw0Z55Aa1Ke5pC6aN7awufw8oBIhun4U=;
        b=Oo75ZZmVtpVWxvlNgwWW/mhXuELiE978dqFuNBMwKLipIOP+MdQAJkBpkd6GqhFLaf
         YGRmmeA0+8N5qI2OVwZERnuFgu4xwr5yq9WzsKa51OAma3tCRPhqabi+UwLfBiUOdsyN
         yo2A1Hc7PTKmT/LXrUV8Co1RYBbPrxhmRoFP3JLubNwz7HHdk170f7nrrKj2/Y0wFeEf
         Vew24wpiaLrsc2dFzAY7P/ZI/ygfah0EZHCw+vonJOzSLWoPLigdqglcm4Wn9wUzdHkt
         wUsd3dL5gEKklWHL85RnyCfqNowAs4K0QJ8T9gkmKpJTKSDFEAchH16iiS0MExR+6C0c
         fgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R2o1S8ctDNMnw0Z55Aa1Ke5pC6aN7awufw8oBIhun4U=;
        b=0FvgpTlJzlRtnveswIWfIxkL4x0KA0gy89/RK1e7kxhC6mYQgY79CoYWMD1rrWzrNf
         b+KWZR4XBfTYlnMk8h1DfpPRh0earIPuOXtHmXxCbtHsEWR7Y1WCnTY8ak9dUZso90x3
         nZQJrdnISpt0qE3Pj59ZKHq/Pa8EI5Mq2HVDijgoa9UadyP1PQbulqahFLBSfhbquoN/
         AMueriR2wLXsFv7u755Ruitp44FU5p4Va6pU3dqtik6N5ALca5xjnX7E43LFwdat1WV9
         QIkBOG3s/McxaYofpY4trWhiGBahgaflLsSOn9Wi7xI8yLDqGrZgDs5nnMKlwv8Sbyx8
         rBWA==
X-Gm-Message-State: AOAM533R6Jz0uEWGQuPijhtm/sMa0MNtGMO6jmTsBn0IpE1WYbxUe9v5
        hM5FXP2r86tJxuJJWmbQPnQ=
X-Google-Smtp-Source: ABdhPJx7nY8JhGi4fmDFAewLb6pwyYAjvzgu3PQ6xKiZKc7AWuwhy5AUD8jlQUZZr8y/EPV61vgiVQ==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr6029726wrc.30.1633618774433;
        Thu, 07 Oct 2021 07:59:34 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id 143sm9404502wma.37.2021.10.07.07.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 07:59:34 -0700 (PDT)
Message-ID: <c7ce1fd0-21c9-9ee9-bade-f3cec58d1029@gmail.com>
Date:   Thu, 7 Oct 2021 15:59:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-GB-large
To:     Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
 <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
 <a5011892-1dfe-31ab-12fe-d586eb0e9dbd@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a5011892-1dfe-31ab-12fe-d586eb0e9dbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 07/10/2021 14:35, Derrick Stolee wrote:
> On 10/7/2021 5:50 AM, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> In a sparse index it is possible for the tree that is being verified
>> to be freed while it is being verified. This happens when the index is
>> sparse but the cache tree is not and index_name_pos() looks up a path
>> from the cache tree that is a descendant of a sparse index entry. That
>> triggers a call to ensure_full_index() which frees the cache tree that
>> is being verified.  Carrying on trying to verify the tree after this
>> results in a use-after-free bug. Instead restart the verification if a
>> sparse index is converted to a full index. This bug is triggered by a
>> call to reset_head() in "git rebase --apply". Thanks to René Scharfe
>> and Derick Stolee for their help analyzing the problem.
> 
> nit: s/Derick/Derrick/

Sorry, maybe Junio can tweak that when he applies the patch, if not I'll 
fix it.

> Otherwise, this version looks good to me. Thanks for putting the last
> bit of polish on it.
> 
> I'm taking this patch into our microsoft/git fork as we speak [1].
> 
> [1] https://github.com/microsoft/git/pull/439

That's nice to know, Thanks

Phillip
