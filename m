Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC4DC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiLTKS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 05:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiLTKSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 05:18:55 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25F3106
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 02:18:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso10719871wms.4
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 02:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUkFnAFyfCqx2Fg3aU2ORl+DC76Ful6pYHrjpNwmGbc=;
        b=ck4+cOjAHK3X1IUI7pR6Y/glAaaYE7Q12FXqKpMR6TjL4HEOnj3uLAvM5R/SbPWZ5w
         d2XSPGvaPGs0U3sQu8Xl6SxJzg8Pvb6Hmp1hemVSIPjeV9bjFdIaem+lstDnQ0LnyPyN
         OWAViQ4vRe6oHa+iyOVxbbV+LPx9ao/WlmBkorxpGoXdKW0e6/oXyQwt3hyTqTACcAtG
         BNKaK3YpnbuzvkjLHzSuHHhJFyyqBJsJTi8XYtYA+3sJi8c87g9A7bkmVMAvc9QaQg6A
         9Z30vQByx/s6jxJ2JZCaC8dierCXHN5NDbNHStB+fo5i7ifJlbCJvAwBCMEdq49RCuox
         1/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUkFnAFyfCqx2Fg3aU2ORl+DC76Ful6pYHrjpNwmGbc=;
        b=UoV0PVhy0lw5Ez8Hw/7jcAOVDKyMR2LAcbi/Ovvw4xVaz8HkWabo420kfrumWNceX4
         gwTPOnMPZBXttfKRhvdRF7nUyCHKmZEF6SHidhDmJbrtMlJnQ91hmUbXQ1Yjz9lPeAw8
         iSCHjJQPbHB8DdopuKAIO+gvAsp2H7fjLvqOTNyYBh9bWtX2X0/yu2Eyx8C/PU6qAQNP
         IeAs6txWrpJoyDJ9fpdjWYjBv2Hdd5ifWZ2RYARdNoNXf02pcrKaA7Vru3yuYQYz+vkI
         /Wli9TzMvnqGEbmmDpn6hCSd3M2zxGi3S2VPBneumfT4q2E2VVWud5hq+5puWHkrzYOw
         ZQxw==
X-Gm-Message-State: AFqh2kqtpW+Q/LHtD3OmJrI94++GXheK0DYaSvzmT1Yx6ii/U57rc1Ki
        fbEJCc0i5tyqUIXZhD18WXE=
X-Google-Smtp-Source: AMrXdXuzdDcv9dxOng3nr9ySvUvLWM8NxKqg0g6MnmHpHYmIJD+dlOV9Encxw2VNbSkxygKMcm5Zpw==
X-Received: by 2002:a05:600c:500e:b0:3cf:88c3:d008 with SMTP id n14-20020a05600c500e00b003cf88c3d008mr1151519wmr.28.1671531533137;
        Tue, 20 Dec 2022 02:18:53 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0a4600b003d1e3b1624dsm24891480wmq.2.2022.12.20.02.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:18:52 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <aab41ec5-7854-b62c-f11c-ba850cbac95b@dunelm.org.uk>
Date:   Tue, 20 Dec 2022 10:18:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
To:     Toon Claes <toon@to1.studio>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <20221209150048.2400648-1-toon@iotcl.com>
 <20221209150048.2400648-2-toon@iotcl.com>
 <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
 <87a63i7h8h.fsf@to1.studio>
Content-Language: en-US
In-Reply-To: <87a63i7h8h.fsf@to1.studio>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Toon

On 20/12/2022 05:31, Toon Claes wrote:
> 
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Thanks for working on this. I'd previously suggested NUL terminating the output
>> of "git cat-file -z" to avoid this problem [1]
>>
>> [1]
>> https://lore.kernel.org/git/66b71194-ad0e-18d0-e43b-71e5c47ba111@gmail.com/
> 
> What happened to this proposal? I don't see any replies to that. That's
> a bit sad, because it would have been nice to have it this behavior from
> the start.

Yes it would have been nice, unfortunately it feel through the cracks 
due to a combination of unfortunate timing and lack of time. I think the 
patch was probably in next by the time I realized the problem and wrote 
that email. Taylor was on holiday at the time and then I went away 
around the time he got back. I know it was on his todo list but I think 
he was busy catching up from being away getting ready for git merge. I 
had other things I was working on and unfortunately didn't get round to 
following it up.

>> but quoting the object name is a better solution.
> 
> I would not say it's a better solution, but it's a less invasive
> solution that /minimizes/ breaking changes. Ideally I'd like to have NUL
> terminated output for "git cat-file -z". In a success situation I
> assume this would return:
> 
>      <oid> SP <type> SP <size> NUL
>      <contents> NUL
> 
> In a failure situation something like:
> 
>      <object> SP missing NUL
> 
> So when you pass -z you can keep reading until the first NUL and then
> you'll know if you should read for contents as well.
> 
> Would you consider change behavior to this now?

Hmm I'm not sure (and luckily it isn't up to me to take the final 
decision!). I really don't know how many people are using "-z" I suspect 
it is not many and so the fallout wouldn't be too bad but we'd still be 
inconveniencing some users. I theory we could so "sorry we made a 
mistake when implementing this feature and have decided to change it" 
but we have a solution in your patch which hopefully does not break any 
users (I say hopefully because think if one is careful and keep track of 
which responses you've read it is possible to detect missing objects now 
even if their name contains a new line but it will be messy and probably 
slightly inefficient but anyone doing that will notice the change in 
output).

Overall I'd say it is tempting but risky and inconvenient to any 
existing users of "-z" (assuming someone else is actually using it). 
Quoting the object name is definitively the safer option at this point.

Best Wishes

Phillip
