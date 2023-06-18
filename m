Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4938DEB64D7
	for <git@archiver.kernel.org>; Sun, 18 Jun 2023 09:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjFRJFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jun 2023 05:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFRJF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2023 05:05:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B99810E3
        for <git@vger.kernel.org>; Sun, 18 Jun 2023 02:05:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso24152935e9.2
        for <git@vger.kernel.org>; Sun, 18 Jun 2023 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687079125; x=1689671125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUBufW+u6WFxIychznZURsHMAT3O9srsCMNfhszzQts=;
        b=eFHlAywKGinIUp34Vh+iUOOhcf7oSrDrsBW5sn4sd6+FMZ4xKZzhlRAA27OBefMXs6
         b2aYlEuXKMh3cyIvYTyOFl6etiFNvvhuXbUaO/wkVscR/fOzz153yPgh0lbBw/8YBlpm
         VgAiRBkbtba1lGCTQqw5gbq4fDMUx/QQoK50wZbRU/5Zr3t9m4FUHBUhfEjXB0SiVMYm
         DIAjuUnIHYLaox1eBn3a/yellUqAB57jgsP4FztpnW256lg5mvVUsqP0D7+q6GTLPDA/
         mFg2h7QCvjLIAGFLieGwSSyBHZzCTpmDdla9fJLWtM0PhvQsQYsysnEewcbrocOW3H5A
         PHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687079125; x=1689671125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUBufW+u6WFxIychznZURsHMAT3O9srsCMNfhszzQts=;
        b=eFe9g2tI9JYpabperTL4tQsqHRF9ItZob2OjwRygdnIyiY3bM2MQC0Vpmp4HiNjIgw
         Km9+nlNBKM3Lw4JgYxQq3tNxI7iVtEFMPFic/8URSzTI6pQvrFstiNxhK30Sv28bUU//
         Lf6TfjUEgiHgVe8u2j14ixonM9uBaIpn/PqDxk0ZuoGH5+Sg4d2Sd5l2oN0Bwxco375H
         c5QA7ChxxKF8wZ+ZVkfzChw5UhQtPsKb9minmG+2UFFqFmuShxKQDiLjKMOyWIk5S2j5
         CIJZfZKKqHY7OT7f8Mc/FPq82t9QUEziDZEwiyuMCEAjN+r5vJBV52H0DqhGFWA0aoe+
         Y9Gw==
X-Gm-Message-State: AC+VfDzAbRbfbGCv7gmmI1D2MvZqEX7U9YvI5qybW6gu2in6//26hP9h
        G9rKsu6YUa306k3dEVLYJvY=
X-Google-Smtp-Source: ACHHUZ69+/ahNM38pBCngewJWsehK+xIgWIzITi9O5XPxmI295l3qJqp1BHz91QtHUvhh6kWTG5aIg==
X-Received: by 2002:a05:600c:ad7:b0:3f9:991:61da with SMTP id c23-20020a05600c0ad700b003f9099161damr1792792wmr.39.1687079124088;
        Sun, 18 Jun 2023 02:05:24 -0700 (PDT)
Received: from ?IPV6:2a00:a041:18a2:9200:1f6:9537:e509:fc57? ([2a00:a041:18a2:9200:1f6:9537:e509:fc57])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm28028685wrr.46.2023.06.18.02.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 02:05:23 -0700 (PDT)
Message-ID: <f6a510f8-f569-6b1e-a74d-cdd103b39c10@gmail.com>
Date:   Sun, 18 Jun 2023 12:05:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] Add 'preserve' subcommand to 'git stash'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
 <xmqqjzw3qry6.fsf@gitster.g> <ZIzALOe8GBsNGIhR@ugly>
 <xmqqv8fnrwtt.fsf@gitster.g> <ZI1xLwemOs9Vxorf@ugly>
 <xmqqwn02qqp4.fsf@gitster.g>
From:   Nadav Goldstein <nadav.goldstein96@gmail.com>
In-Reply-To: <xmqqwn02qqp4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Thanks for the feedback, and I totally agree I was very vague in my 
description, and I'm sorry for that.

Let me try to explain my motivation:
I heavily use stash to set quick points in my code so I could go back to 
them (during thought process), and I want to store my changes quickly 
and continue from there).

Currently doing git stash discard the current working tree, so I need to 
perform git stash apply 0 to restore it, so my new sub-command is aiming 
to replace doing:
`git stash
git stash apply 0`

with just `git stash preserve`

Regarding using it as a flag in the stash push, I went to this direction 
initially, but stopped because of all of the flags you mentioned 
(keep-index, include-untracked etc...), I wanted a clean slate, and to 
avoid using the push flags that seems overkill in this phase (they can 
be supported later if users requested it in forums, wanted to keep it 
simple).

If I understand correctly, the problem is my subcommand behind the 
scenes still support the push flags because they use the same method 
(do_push_stash).

Do you have any idea how to disable those flags in the new subcommand 
only? And do you still think it should be a flag?

Also what do you think regarding the way I choose to implement it? 
(Adding the extra argument to do_push_stash)

Thanks,
Nadav

On 17/06/2023 14:21, Junio C Hamano wrote:
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> i may be totally wrong about it (because i don't understand the
>> motivation behind this feature, either), but i think the _intent_ of
>> nadav's patch is to merely expose the first half of "stash push" (the
>> other half is the implicit "reset --hard"). it may not be a
>> sufficiently good one, but there is clearly an analogy here.
> I do agree that it would be reasonable to want to expose the first
> half (the other half is "now the local mod got saved in a stash,
> adjust the working tree and/or the index"), but then that means the
> code should cover the various operating modes we have, and let the
> users perform their first half, so that the second half (which by
> the way needs to be exposed by another series later) can be used on
> top of the result to emulate as if the combined two (i.e. "stash
> save/push") have been run, for the feature to be complete, no?
>
> Lack of the second half can be excused away with "let's do these one
> step at a time", but the analogy fails to hold with an incomplete
> coverage of even the first half, I am afraid.
>
> But as you said, I think the lack of concrete "here is how this
> feature is expected to be used and why it is useful because it
> allows us to do X that we haven't been able to before" is the
> largest first issue in the posted patch, as that leaves reviewers
> guessing without feeling they "understand the motivation behind" the
> feature.  Such an understanding would help us to tell where to stop
> (maybe in certain modes doing only the "first half" does not make
> sense because the corresponding "second half" inherently does not
> exist for some reason, in which case it is fine not to support such
> a mode that is supported by "stash push").
>
>
>
>
