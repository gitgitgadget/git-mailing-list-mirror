Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD30C678DB
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 14:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCEOcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 09:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCEOcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 09:32:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F9E1CAEC
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 06:31:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q16so6428653wrw.2
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 06:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678026716;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qikMsDdMniyusTxqDxT7CW1yj8RP1iXiYYQbcNB9jhs=;
        b=qyQsiFjN4md5hd5jVv23jpaJowtJi4VMpY7OHyGYoi0TjW4zLzKYXy60uP60se4yv3
         Rb5SUeOI9ckLnKi6npBejPcsuKQGIHpGy1Sfx5WM+M8l71KSFvedfvanEC3v6l5tx3jx
         +SGtP6DzfTi558UMKwty/apgXwuKhNqZd/MqpiPBK5Xb79hVDK/vwM9oo6SMWcO+hRzz
         gBM+8P8k01seUFcnCYvB9flUXRGjLQqCBvSfitYxGI3oJA8NebvgxevPQqdnXDNKzo62
         /BOhdOerabmVxUqOaG6DkKxpnVX4GWpyH8EEKOz1k97DT3IODpvsTTJ3KfBLc1u3vYXb
         5NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678026716;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qikMsDdMniyusTxqDxT7CW1yj8RP1iXiYYQbcNB9jhs=;
        b=4rnzUCC873cEu/yZV5a2CGtsoxduAZ8zumuQcqfY+Kvcuu+jFjkfdLbIjDaLRInWus
         sSy+Fy2DvpSIUBSIuVdnquaz5f7O9/cRzIpK+58+748h9yVUeb0K18SWLCholwmd4Et8
         pMKEOTz1ICqH9VtJhfmJoSbMwpDgjxaERysX88NruHSX9UJqV1n+v0lTr4uBQxZPwudO
         88wGchRrIr9dHQ9st3yeryhJnGeEfIs6VmshaH97f+QtiYWmJWFAmozsRIKz4eKcFCR1
         BKROeQvriAgphmzjtb1sGMO+eRVa8+TXbhTHTEoMSHAKGHadRwOAOd6M4hSINAnZgi/P
         Uh1Q==
X-Gm-Message-State: AO0yUKW409ZhsYWxRFGPlIlkwy0kPgqzESc/eokKlqMY1kt/gxUQA7j2
        jJ1Nid1XsXBGOF8Kbh4IJvCUYSXfvXU=
X-Google-Smtp-Source: AK7set/hCsP6+UfD4FvS4oOnb6BmX6vaMWMttHltscl8Nq8Yr1baVtI9dL/lmZUqcNDimF9HM/BP+Q==
X-Received: by 2002:a5d:6a88:0:b0:2c9:a342:28ff with SMTP id s8-20020a5d6a88000000b002c9a34228ffmr4873934wru.42.1678026716512;
        Sun, 05 Mar 2023 06:31:56 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4103000000b002c55521903bsm7431104wrp.51.2023.03.05.06.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 06:31:56 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <db9f3be7-097f-006e-927a-91be7a50360c@dunelm.org.uk>
Date:   Sun, 5 Mar 2023 14:31:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: When exactly should REBASE_HEAD exist?
To:     Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
Content-Language: en-US
In-Reply-To: <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 02/03/2023 20:27, Stefan Haller wrote:
> On 02.03.23 11:19, Phillip Wood wrote:
>> On 28/02/2023 12:55, Stefan Haller wrote:
>>> The reason why I am asking this is: I'm using lazygit, which, during
>>> interactive rebases, shows a combined view of the real commits that were
>>> already applied, and the remaining commits that are yet to be applied
>>> (it gets these by parsing rebase-merge/git-rebase-todo); something like
>>> this, when I set the 2nd commit to "edit":
>>>
>>>     pick   4th commit
>>>     pick   3rd commit
>>>            2nd commit  <-- YOU ARE HERE
>>>            1st commit
>>>
>>> This is great, but assuming that the 2nd commit conflicted, currently
>>> the display looks like this:
>>>
>>>     pick   4th commit
>>>     pick   3rd commit
>>>            1st commit  <-- YOU ARE HERE
>>>
>>> I would like to extend this to also show a "fake entry" for the commit
>>> that conflicted, if there is one. REBASE_HEAD is perfect for this,
>>> except that I need a way to distinguish whether it was applied already
>>> or not.
>>
>> Can you check the index for conflicts when the rebase stops?
> 
> I could do that, but then the fake entry would go away as soon as I have
> staged all conflict resolutions. I would find it useful for it to stay
> visible in that case, until I continue the rebase.

I've not used lazygit but looking at the github page it seems that it is 
a persistent process that runs "git rebase". If that's the case I would 
think that you can check for conflicts when the rebase stops and keep 
that value in memory until the rebase is started again.

Another thing to bear in mind is that if the commit being picked has 
already been applied upstream then the rebase will stop without 
conflicts but you'd want to add the commit being picked to the list in 
lazygit.

I think your best bet might be to read "$(git rev-parse --git-path 
rebase-merge/done)" the last line of which contains the last todo 
command the rebase tried to execute. Not that failed command are 
sometimes rescheduled (for example when a pick would overwrite an 
untracked file) so you'd need to check the first line of "$(git 
rev-parse --git-path rebase-merge/git-rebase-todo)" as well.

Best Wishes

Phillip

> -Stefan
