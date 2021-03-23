Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE0CC433E3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D17619BA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhCWNOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhCWNNn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:13:43 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BE0C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:13:42 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so4932628ool.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3YORe0UdbbJcZgOWilL7CJxHaUmzhN6MdzUUl6sARvA=;
        b=VPXJz+89dUSa9pgcuDwPK0b9TeY/l72bbPtGyiETAAv2cbRJRiiL7iDxl8XOJKbs8l
         MYZ+/LHhe+uQO5udwh8NiGvUhDATTo4lL1pCwt6M4INRSiDvx74HGD6lQYAR3smqsyVN
         OI2Im2wc9DyEMjUTP9gkMRYHMtesfMfv9RLucvbBKoYJWXwlV6HAR/vfqNADj5VAXBhH
         bhNSbiw+IxjTXPQxNtLbaySYg2N3tEZf6UzKQxLLXRgyw5HcgxlkqaasPwm4m3K/OfvF
         hm+aj+voEvvpl0EWt5YgJEsoy2wK0bEgPVkPqmljACjBeKvM1g9S5EaVKIbudGfve3KE
         P40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3YORe0UdbbJcZgOWilL7CJxHaUmzhN6MdzUUl6sARvA=;
        b=BogyxqzhGWJ+1kvDnmePnhP1RsNNqXT6gPvmJlr++UDrS2Krkvp+kot1FZUhTmgIJB
         UrHgfy2FWFVBFzM/P/HJ7CL4jLcUhprXc9BoA0oB2RbxPlq3CSG8sAoN4d4uJp/dexZ4
         fk3R+eeHYpUbHd2QENN+xYHKnycSTq3xYIQWKeoCZRN0TVTgJ0DyZz4sq1wS0Wt6NzBs
         LLOift9zLV4GjTf13X53RhB6CoNVCHet5crrKkz09Uzfl0rew+dUusM6b0csbUE8ywu1
         jPJ58wPfUln6cKcMMLFcDzFtDQdnE8yoP7/w+QBREb4DjBPglo0p6H0QbWvIPtJb1Cvc
         oOWQ==
X-Gm-Message-State: AOAM530znKH2qbwBZdT2K51/lsjHBQGx6zfN7Ay4Eu6pmprkeh3BnBuu
        vDWrTxbJtWD/iKH3lemhL0c=
X-Google-Smtp-Source: ABdhPJyoDY7StjbdTchBFd6KtuiIbNEg4QEcSOaCusAKYtLtZL4OvP+IqE3vhWdAA9t7Zk+WG5MIpw==
X-Received: by 2002:a4a:d05:: with SMTP id 5mr3792167oob.10.1616505222226;
        Tue, 23 Mar 2021 06:13:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:19be:10a5:ec17:ace3? ([2600:1700:e72:80a0:19be:10a5:ec17:ace3])
        by smtp.gmail.com with ESMTPSA id w199sm3911572oif.41.2021.03.23.06.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 06:13:41 -0700 (PDT)
Subject: Re: [PATCH 15/27] sparse-checkout: ensure full index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <92ccd31dd343c20bad4a6b8d89c50559209e7236.1615929436.git.gitgitgadget@gmail.com>
 <CABPp-BF4YVSNB1c=y11MZfTDAu=KHryNb5JQZ1kKRpigPALPxw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <64fe05be-b4be-5aac-af1b-0db03db49cfe@gmail.com>
Date:   Tue, 23 Mar 2021 09:13:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BF4YVSNB1c=y11MZfTDAu=KHryNb5JQZ1kKRpigPALPxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/18/2021 1:22 AM, Elijah Newren wrote:
> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When adjusting the sparse-checkout definition, ensure that a sparse
>> index is expanded to a full one to avoid unexpected behavior. This is a
>> top candidate for later integration with the sparse-index, but requires
>> careful testing.
> 
> 
> I was going to comment on most of these collectively, but your commit
> message is completely divorced from the patch; it appears you either
> place the wrong commit message here or copied it from the one for a
> sparse-checkout.  The code modifies stash, though.

Thanks for pointing this out. Must have been a bad squash during one
of many rebases.

-Stolee
