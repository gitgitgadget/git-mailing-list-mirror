Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A4C433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 02:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhL0C2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 21:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhL0C2e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 21:28:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78337C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 18:28:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so13188036pjw.2
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 18:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hCKZVR88N1uPXCmhhrDClXqsA3qBp3+w6FxqkYMbe9g=;
        b=APDf0lZjy8AMZ3rLeS4pgmNDrZ7CMCt00KCfS+6JN+TiKbWCng2xAXNykRhdsQBkn2
         HolATux7VbCMuvaeySphYn2yHuuNb8/10HJxHYTnsC+L+qzv6Xl/pikVu9TM+b2IwKBQ
         rr5Y/ln4YZcv4N5HmcrenVpINSQSq3QzyrgReKSiOTWuyijIbgD4O9Qlo2P5q7rctOjt
         pn6FSl8WckdbSH2REE6KlcukULKpLri8V8wjfwOXi9nsavc7sXSTOkWh19Fr5IoJneTH
         SGSUEKBQe59c4TH1aIoz3LYk9i1KwUUNB+lhyydb3KeCTZuePoQgG4xPjYaUYTfXwvgZ
         WDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCKZVR88N1uPXCmhhrDClXqsA3qBp3+w6FxqkYMbe9g=;
        b=j8JetrAEokxMqSsvlyyEjt/49WIhNKLxcH1YhTF7vQKBJtzaNRk29jJIlPRB4OiAEF
         D20m+tjHNS/CGk6v3Kf/RsbW+y/alTdbHwLMgwkyWrxd67wQrlCTRg8Q3K5PfrGmB8Hc
         +ZQfbbx+Shd7BFWXiXFrX8YbivWAWscffd6nAPDmR4wOFSaZhawHpMqhZmi/DP85Kt9G
         19EVDnvLKoavPK6ArCtcWcq7bilWr0XlozaDsPANzsvvt4Qd3pvSFGakQPc42KsbFW4P
         hh59veb5gJ+jWRHcVP8daMhM9dxWmYL+3P3j5w0RPZ58pJTvBXsH1OgsIv2vCGwIm9UM
         XZ/A==
X-Gm-Message-State: AOAM531RsUQ1woiR7bIN86Blakx4SPy3OwEpD3GMxdtXypc7cPwjL9pr
        MJDZqoVPSbJ1WeVNl2oSo7dXGfjuy0BPWQ/x
X-Google-Smtp-Source: ABdhPJwXgL3kkJbWcDXTo0kU0TaN0ZmRwhd3V0mrBG8g9gunbaxZ7Mo+CcvqsAZ4Lhy98+m+tV/qbg==
X-Received: by 2002:a17:902:9682:b0:149:15d2:55ae with SMTP id n2-20020a170902968200b0014915d255aemr15312508plp.59.1640572113865;
        Sun, 26 Dec 2021 18:28:33 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id y14sm2347811pfi.178.2021.12.26.18.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 18:28:33 -0800 (PST)
Subject: Re: Rebasing commits that have been pushed to remote
To:     rsbecker@nexbridge.com, 'Erik Cervin Edin' <erik@cervined.in>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
References: <71b51bc8-172f-48de-7c3f-cf55dc45b39a@gmail.com>
 <xmqqlf0cjuwx.fsf@gitster.g> <d51b7981-5034-b34c-42d6-ad8b80a378c1@gmail.com>
 <CA+JQ7M_GhE=vcpoCSPEnSPoLA1xZM3uVMuGw4goPe4AmQip2hg@mail.gmail.com>
 <f282b2eb-efd2-e194-d326-fe4daa07b598@gmail.com>
 <001801d7fa70$25775e20$70661a60$@nexbridge.com>
From:   Lemuria <nekadek457@gmail.com>
Message-ID: <27ee772b-33ec-ca81-364a-6360666e147c@gmail.com>
Date:   Mon, 27 Dec 2021 10:28:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <001801d7fa70$25775e20$70661a60$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/12/2021 11:49 pm, rsbecker@nexbridge.com wrote:
> On December 26, 2021 4:58 AM, Lemuria wrote:
>> On 26/12/2021 4:44 pm, Erik Cervin Edin wrote:
>>>> Alright. I'll take this into account. Unfortunately, before you got
>>>> to me, I reworded the commits on my local and pushed them to the
>>>> remote, which resulted in a messy history with duplicate comments.
>>>
>>> This easily happens
>>> Usually when you merge old history back onto rewritten history It's
>>> easy to confuse what is what when rewriting history
>>>
>>> If you find yourself rewriting and force pushing a lot you might find
>>> the following script helpful
>>> https://gist.github.com/CervEdin/2e72388c3f7d9b30d961ec3b64d08761
>>> It shows:
>>> - The graphs of differences between local and upstream of a branch
>>> - The difference between local and upstream
>>> - Prompts to force push with lease
>>
>> I don't force push a lot, but regardless I'll make a note of that.
> 
> The process is used by some teams, like OpenSSL, for WIP pull requests. It follows a git rebase --autosquash -i. The principle is to clean up the PR down to a single final commit for approval. It is more work for the contributor, but the committers seem to prefer having everything in one commit. This requires a git push -f.
> 
>>>
>>>> But at least my GitHub page has more green on it!
>>>
>>> If you want green you can fork
>>> https://github.com/cervEdin/vanity
>>>
>>
>> I'm surprised how GitHub hasn't taken that down yet. Well, spamming
>> commits means more green and isn't that good for the environment, right?
> 
> I don’t follow this. Sorry.
> 
> -Randall
> 

Me too. I don't follow that either. My statement
was sent with the purposes of ___sarcasm___.
