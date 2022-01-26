Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1154CC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 10:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiAZKxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 05:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiAZKxt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 05:53:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F984C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 02:53:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so3941152wms.3
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 02:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ex5rLKN2XDTMO7HBimNiMEPC7TszJATRk5Vzgp6tNhQ=;
        b=a09ADUh30obihSAU8+dCV+CrVuWHhQu8f44HCXfdlZMqGMrv7OylWO3JEB4WGUHsNW
         Yf7lo8S6dl8EurLkr8895CPIt3Qmh5c8slFyQZu7x4WV2RXIt6k4XBDu4d4YEq5brF6G
         ljXdWVHoitJ31j3ClRsXyitUkv2KbfwEjL0ZJqTnffXL1bLzg73KPO0A8J7XY/+Pb8TP
         bu/1CMCHCnAfDg7E55Y0lboU6kHsIkqrOp3a5ViY1qz2DWSS14i7FwIk0+69EvPR1ap1
         la0F5Bqs4W8kY3w6qgGzMex/T3pJz5/xjHBGdGY88sRqne/0MoM5U0xf3re0tImtrmHZ
         AZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ex5rLKN2XDTMO7HBimNiMEPC7TszJATRk5Vzgp6tNhQ=;
        b=GKvWNfTf6ZoM65aS6BALVkLiiRPQ7o5MOd019ncjs/YgW6n83xUCLhcJKKpbI8tA9B
         2EmjCiGu4Tw6o0mc7aa+ZylHSpguL55m+Vwh3HP74ugaCUgjWlwqREJhv1QPvWk5+pql
         hLktYfNeZXIY3M3QV6TcT/P7V+k+SsBzyLEY2AXul0U1NC6ehu+8/2+C9qy8ATnAUmZr
         nXH54J0UxG15Qlj4sNfhCH6HQqVoRIdGHEzFSka/3mqvxXXeZml97LWQW/s62VkHRoBM
         Ojjg0VvRUWnAQa4W73T3J9Td8I4dRyp+PEBUEv93Vb7se+QbtpeLMlggPvKjFhLEcX88
         3reg==
X-Gm-Message-State: AOAM533BPPD/Rr1eoEzcA9xp462W3/7qFcBVW4slv5SKQlaigkq4MQ58
        6hthRz+3MgRONmibXys8uiI=
X-Google-Smtp-Source: ABdhPJwm0rlGlI9CwQqG5IzyR+1CTIiWmXXrkr/QaCl4almWpm9KNMvOTTgvqDs5DIx+z7svXfx5tA==
X-Received: by 2002:a05:600c:2042:: with SMTP id p2mr6634298wmg.167.1643194427070;
        Wed, 26 Jan 2022 02:53:47 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id l29sm3670521wms.1.2022.01.26.02.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 02:53:46 -0800 (PST)
Message-ID: <aedee582-7f00-7e12-c378-35b0cbc6b565@gmail.com>
Date:   Wed, 26 Jan 2022 10:53:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/14] rebase: reset_head() related fixes and
 improvements
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
 <xmqqtufhpk1a.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqtufhpk1a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 09/12/2021 21:04, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Thanks for the comments on V1. I have tried to improve the commit messages
>> to explain better the motivation and implications of the changes in this
>> series and I have added some more tests. I have rebased onto v2.34.0 to
>> avoid some merges conflicts.
> 
> Thanks.
> 
> It still is not clear in the cover letter what the overall theme of
> the topic is, and the original cover letter was deliberately vague
> by saying "Fix *some* issues".  Random assortment of changes to
> various code paths, the only common trait among them being they are
> somehow related to reset_head()?

So the theme started out as "convert 'rebase -i' to use reset_head() and 
stop forking 'git checkout'" which I thought would be one to two 
patches. Then I started looking at the code and realized that 
reset_head() needed some work before we could use it for 'rebase -i' and 
that work ended up dominating the series. I've updated the cover letter 
as you suggested.

Best Wishes

Phillip

>> Cover letter for V1: Fix some issues with the implementation and use of
>> reset_head(). The last patch was previously posted as [1], I have updated
>> the commit message and rebased it onto the fixes in this series. There are a
>> couple of small conflicts merging this into seen, I think they should be
>> easy to resolve (in rebase.c take both sides in reset.c take the changed
>> lines from each side). These patches are based on pw/rebase-of-a-tag-fix
> 
> I've read the patches through.  It does revolve around the use of
> reset_head().  I would have appreciated if the cover letter said
> something along this line:
> 
>      reset.c::reset_head() started its life at ac7f467f
>      (builtin/rebase: support running "git rebase <upstream>",
>      2018-08-07) as a way to detach the HEAD to replay the commits
>      during "git rebase", but over time it learned to do many things,
>      like switching the tip of the branch to another commit,
>      recording the old value of HEAD in ORIG_HEAD while it does so,
>      recording reflog entries for both HEAD and for the branch.
> 
>      The API into the function got clunky and it is harder than
>      necessary for the callers to use the function correctly, which
>      led to a handful of bugs that this series is going to fix.
> 
>         ... list of bugs here ...
> 
>      Later steps of this series revamps the API so that it is harder
>      to use it incorrectly to prevent future bugs.
> 
> Anyway, I think the series is more or less in a very good shape,
> even though a few comments I threw at this round may result in a
> further improvement.
> 
> Thanks for working on this.

