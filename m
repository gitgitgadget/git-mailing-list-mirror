Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7258DC433DF
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 08:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C53420672
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 08:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAJGCk2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgGOIxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730440AbgGOIxY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 04:53:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8C0C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 01:53:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so1543315wrl.8
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=280SL71BP2Q/2LtgRR5FbmjddmjGS3wgfE2Hq3T9e58=;
        b=DAJGCk2+oKFtdRkpastm9kEvtz5lbnFJshqVXcfgdSpZBFrZOjPsQ9pWFuYzRyx7oo
         cZYNSnQdO0VtuxSH2tOGti4tWN9MKRkEh9HpA5HzLItIPS6It8hegWgQaNWOvSBIX2SP
         kh8LnUV3jgFAc6/pgaBcx6sxVsFcL3K2KK28idqTZeKagjS2VRlDVVDq9mqaEuRP4a3l
         SV8fXYnNM1ruFBXvBm6CvHtm4ujbzvcMN9TX+fB/VNzZiGuQG+B141ZVWK5yIGBA+urb
         M5dzqhfLcUzOrW+m3+XF7saOoIPFTqLxrURN9jtXmttIFShtl0sK5mJlW48NAhy8vbpN
         xOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=280SL71BP2Q/2LtgRR5FbmjddmjGS3wgfE2Hq3T9e58=;
        b=OXLchVUUUyzZZ4P2jzl/YFAxDXYcaAKJ9mVOy0pryd1Qby90g5wOEGVPZW5l/cGhmV
         2HVzc/69LLNgqdPmOqVFWpjTdyMsXTDCJC+GcJubrw9OJNnp7YlHTg1llJ+JUSPzpYBp
         WDPzLj9kg/2rIZvWCO3rwHL6Y3t2rMvh7idgvTS7xU4op/zNv7NjoA9qYQ5Oz2MYuS2J
         swRCXHRbEAIhbe7oY2bnOtNGRREZgV5ema8Wk1Tpr7H9DJob/fFoH7yciUDBYyf2NILy
         UU8+hA7FywF9WZ4GHbiqAZl3XawUrkRpylQf4mmO+nU6PxMq6DN8haYDCtxqbr5mI53F
         Q9XA==
X-Gm-Message-State: AOAM5308uZggm4uFuGAOI7Lfgu8rn/bral5FF768h3jE35bWGLqJNJuX
        LwVtt+K23X0/YLuaPQVQFzY=
X-Google-Smtp-Source: ABdhPJwzNRO8Yct4Kt4FZ9xLVvP24bkXeDY8W3V51K54Pd0d1jfr55T/aZTMr14mXMrXVG7zI5ewFg==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr10408718wrt.5.1594803202460;
        Wed, 15 Jul 2020 01:53:22 -0700 (PDT)
Received: from [192.168.1.240] (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id f17sm2545680wme.14.2020.07.15.01.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 01:53:21 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] should `git rebase --keep-base` imply
 `--reapply-cherry-picks` ?
To:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
References: <0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com>
 <20200714031017.GA15143@generichostname>
 <9c6dff59-b204-1ace-e0aa-0885dd502214@gmail.com>
 <nycvar.QRO.7.76.6.2007142236060.52@tvgsbejvaqbjf.bet>
 <20200715032014.GA10818@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <87889c7b-b83a-8969-e40a-9bb19b7c11ae@gmail.com>
Date:   Wed, 15 Jul 2020 09:53:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715032014.GA10818@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

On 15/07/2020 04:20, Denton Liu wrote:
> Hi all,
> 
> On Tue, Jul 14, 2020 at 10:38:23PM +0200, Johannes Schindelin wrote:
>>> To me the question is why are we looking at the upstream commits at all
>>> with `--keep-base`? I had expected `rebase --keep-base` to be the same
>>> as `rebase $(git merge-base [--fork-point] @{upstream} HEAD)` but
>>> looking at the code it seems to be `rebase --onto $(git merge-base
>>> @{upstream} HEAD) @{upstream}`. I didn't really follow the development
>>> of this feature - is there a reason we don't just use the merge-base as
>>> the upstream commit?
> 
> It behaves this way mostly for unimportant reasons. The first is that my
> workflow before implementing this feature invoked running
> `git rebase --onto master... master` and I wanted to replicate that.
> 
> More importantly, one feature of using the upstream I considered is
> documented in t3431. Essentially, if we have the following graph,
> 
> 	A---B---D---E    (master)
> 	     \
> 	      C*---F---G (side)
> 	
> 	C was formerly part of master but master was rewound to remove C
> 
> running `git rebase --keep-base --fork-point master` would drop C.
> 
>> Those are interesting questions, indeed.
>>
>> And I dare to suspect that the answer is indeed: `--keep-base` really
>> should not only substitute `onto` but also `upstream` with the merge base.
> 
> I would be open to changing the behaviour since the commit dropping
> isn't really a feature that I use very often. However, I am worried
> about pulling the rug out from other people if they use it since this is
> a documented feature in git-rebase.txt.

I think changing it to behave like

   git rebase --onto $(git merge-base @{upstream} HEAD) \
                     $(git merge-base --fork-point @{upstream} HEAD)

when --fork-point is given would keep the existing behavior of dropping 
commits when @{upstream} has been rewound without dropping cherry-picks. 
--fork-point seems less useful when combined with --keep-base than when 
used with a normal rebase as if @{upstream} has rewritten the commit 
that the branch is based on rather than just dropping it we end up 
dropping the original commit without getting the new version from 
upstream as we would with a normal rebase. This could be surprising to 
users if we keep --fork-point on by default with --keep-base.

Best Wishes

Phillip

> 
> Thanks,
> Denton
> 
>> Ciao,
>> Dscho
