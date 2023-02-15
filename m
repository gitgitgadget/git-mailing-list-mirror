Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB70FC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 14:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjBOOpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBOOpF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 09:45:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155114EAC
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 06:45:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so1718547wms.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 06:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xellQ7XP56jnpu2i00fZBi7YpaKv5AqDpnXNDmq7io=;
        b=LgJJRNf5QW9c6NFeSkx1S7ly8yhVDLOPsbORPHf2WxPbJwhBz0cN0wxH3crnsHMm4A
         r5Gn55DZmTEPVw5X6wrdRze8B/Xmwxmu/jZ5YMiXuMdchUW/fS5F273VlXRSYF6pe7Tp
         jKWB4IpfqAIA6SDrU/jUIb7uWIvx3ewaSCnHUkKIT6+B047ZTbzTfl4t4OBX/dWKjEEu
         qq77EfQG3beypaV8KkdZHOY9Bzv1QfDC53hLdJy16Tvn64QoU/naJ8a9X5ZrLJppc20H
         R+HpkpZJ6ukJiroPn6rQ5w+KUClIbm2aY0QeLNAseVRY2U99fc6LC/wclZYxx0y5xcWL
         HbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xellQ7XP56jnpu2i00fZBi7YpaKv5AqDpnXNDmq7io=;
        b=g0Vsp1KF0P9rAq2DKDUQLIlIafLL//bnhW1yu/e21/B6CH8HFIH4ZxOJ47LN6ha3TZ
         4ynm8LO5fbhcv26+KyOvteQFnY8DlV71hD1iUGMhsOp7jVxP/ci3oeqIkNpl7Utd5wS2
         HzuMuAFDeqdpH3Sl3XPjY5SdBXZx/ejJ2GElaW6/514HUPT2FAvSQBEg8/b2fwP1aF28
         C32Fh9jPdZBuKYJckoQLB8TD/ZY2bIPU1uyDXDH/z2AztBijX4xPdXAcMlB77BSTlP/B
         X2J5hvHzS/SwnNIAlv+40zgtS2XDeib8r+NGlOUYbYcFDrp7bMDWa14naPV7drUMpy+m
         OhRg==
X-Gm-Message-State: AO0yUKVC8WB3pAl1P9PPNORSYeePlyJ9ECAWwn3Hkvc1osy7NziFyaDv
        ejnUOVcbzirvTuhjUgBA034=
X-Google-Smtp-Source: AK7set/tA93Gp5SseEVRdnDA1MhBuV0JpWLhQoN4GEiqF0g3JBBtU+0RGFGu7fQbjRfP67JOp8jX3Q==
X-Received: by 2002:a05:600c:1c95:b0:3e2:5f6:3647 with SMTP id k21-20020a05600c1c9500b003e205f63647mr1580559wms.16.1676472301597;
        Wed, 15 Feb 2023 06:45:01 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bca49000000b003c6bbe910fdsm2396825wml.9.2023.02.15.06.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 06:45:01 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <2ca47f26-f10a-1fae-c879-f9479f7acdb1@dunelm.org.uk>
Date:   Wed, 15 Feb 2023 14:44:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
 <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
 <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
 <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
 <Y+b2l4Le2gTxGwO8@coredump.intra.peff.net>
In-Reply-To: <Y+b2l4Le2gTxGwO8@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

Thanks for the counter example

On 11/02/2023 01:59, Jeff King wrote:
> Just a small counter-point, since I happened to be looking at myers vs
> patience for something elsewhere in the thread, but:
> 
>    git show 35bd13fcd2caa4185bf3729655ca20b6a5fe9b6f builtin/add.c
> 
> looks slightly better to me with myers, even though it is 2 lines
> longer. The issue is that patience and histogram are very eager to use
> blank lines as anchor points, so a diff like:
> 
>    -some words
>    -
>    -and some more
>    +unrelated content
>    +
>    +but it happens to also be two paragraphs
> 
> in myers becomes:
> 
>    -some words
>    +unrelated content
>    
>    -and some more
>    +but it happens to also be two paragraphs
> 
> in patience (here I'm using single lines, but in practice these may be
> paragraphs, or stanzas of code). I think that's also the _strength_ of
> patience in many cases, but it really depends on the content.

Indeed. Ironically as there are no unique context lines in that example 
the blank lines are being matched by patience implementation falling 
back to the myers algorithm. Normally the myers implementation tries to 
avoid matching common context lines between two blocks of changed lines 
but I think because in this case it is only called on a small part of 
the file the blank lines are not common enough to trigger that 
heuristic. I've got a patch[1] that stops the patience implementation 
falling back to the myers algorithm and just trims any leading and 
trailing context. On the whole it I think it gives more readable diffs 
but I've not got any systematic data to back that up. I also suspect 
there are pathological cases such as each line in the file being 
duplicated where the falling back to the myers algorithm gives a much 
better result.

> Replacing
> a multi-stanza block with another one may be the best explanation for
> what happened. Or the two stanzas may be independent, and showing the
> change for each one may be better.
 >
> I'm not sure which one happens more often. And you'd probably want to
> weight it by how good/bad the change is. In the example I showed I don't
> find patience very much worse, since it's already a pretty ugly diff.
> But in cases where patience shines, it may be making things
> significantly more readable.

I agree that having some data would be useful if we're going to change 
the default but collecting it would entail quite a bit of work and as 
the scoring is subjective we'd want a few people doing it. It's great 
that someone has done that for the histogram algorithm in the paper 
Elijah cited.

> I don't have a super strong opinion, but I just wanted to chime in that
> it is not clear to me that patience/histogram is always a win over myers
> (yes, I know your examples were comparing patience vs histogram, but the
> larger thread is discussing the other).

Agreed, there are definitely cases where myers gives more readable 
diffs, I think if we're going to change the default the question we need 
to answer is which algorithm gives the best result most of the time.

Best Wishes

Phillip

[1] https://github.com/phillipwood/git/commits/pure-patience-diff
