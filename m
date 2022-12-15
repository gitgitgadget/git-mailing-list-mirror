Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7A3C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLORJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 12:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiLORJE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 12:09:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF249B7E
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 09:07:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m19so14293100wms.5
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 09:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tA/zRvhXeDezZUBC7iXaJ0wKRLlOelsiN/IJGBXRl8k=;
        b=iwsjlesOiN/0CiXvrWB6jJkwFFwAOaJTjrK/nR38snXKJHuO/XCr0CbbjhxBbiDv2A
         XpyEhEknzz0BaLa8nSRYVjg/v+oPFJu46RlakH+Nns+q2dl+2yFrUmQkH73HB5wFdZcO
         3QXQdeS23xHZJIwAI3kE8HHhR5LtVcGYMq5ryT8MWZ2ZtP2s/QPeSuRzfaZtjz2FGnIb
         y3PaFWVEkcxMVVMPsB/AdDT86xBiBI1ujbYPgq46gG/RmVVqMsPr+FlvuCs+i+uZhHrc
         nLjNTunuHSYCXHxT3ymir16UTbasjCK/Eb2PUYDvRri/2SKYzrnyY1ma+6DUG3K+dz4O
         DkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA/zRvhXeDezZUBC7iXaJ0wKRLlOelsiN/IJGBXRl8k=;
        b=BovvC7YG3FkjXtQtBcfHXsiRPo60bBhOJ1Ip6R+RbV+zQCf7SqxBtANNBmfahTNAAG
         8uD+9aGHimcy3/87Kglpf3LHgpeDgSa/5dv3f5aI+9/AzBS99c4bI/3/0Dt0V8rm3Zhz
         avT+odr6WfPxbBKbiJfK3YiCxJV+LL6Cefh7zEzjj50BNIRewXydHwMG1OV190HBWuWs
         mqyXafznq3NXYUdKc6e22nUqE0MQI0K94n4g7vsd+7lDEKvtT1uGpFqhc1xeDmAOV4pq
         xPn/hdGEiOnXWVScsT1Avm+nJeOfC4HnWa3Ur1QvxiWnqEtEaHnvVr5q+rMhcn1aBjhJ
         q21A==
X-Gm-Message-State: AFqh2koV+ilu1VbYsQF/QvjJqOg5TnJ6UpOChrUNQKybbbXrE8QRmAWb
        d9pvQHErgAWscyw4NXOCQ90=
X-Google-Smtp-Source: AMrXdXsB3qBWc1mgKLHMT+VWPWiH91LDDuiYuW5NoRg00gbgXd8osUjflyRDzMTbUBhUHxnsnQCeBw==
X-Received: by 2002:a05:600c:3b9a:b0:3d0:783e:d54d with SMTP id n26-20020a05600c3b9a00b003d0783ed54dmr1281224wms.0.1671124027249;
        Thu, 15 Dec 2022 09:07:07 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c448500b003c6bd91caa5sm6351360wmo.17.2022.12.15.09.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 09:07:06 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <e174b4a6-f5c2-6856-23bf-216cbab86fbf@dunelm.org.uk>
Date:   Thu, 15 Dec 2022 17:07:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/1] rebase --onto detection of already applied
 commits
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
 <xmqqlencqhxy.fsf@gitster.g>
 <f4b485c8-3bc4-fb0c-3f7a-084daac7c14d@collabora.com>
 <51209c56-c82e-c393-6983-2a8c1a7388d3@dunelm.org.uk>
 <9e06bfd1-3e63-2414-e18c-6901fbb290e3@collabora.com>
 <3c5cb346-e6b4-7b85-6d3e-4b625cc21a94@dunelm.org.uk>
 <ee59112a-bd07-53cc-dfe3-6ee6f2342287@collabora.com>
In-Reply-To: <ee59112a-bd07-53cc-dfe3-6ee6f2342287@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/12/2022 16:02, Cristian Ciocaltea wrote:
> Hi Phillip,
> 
> On 12/15/22 17:40, Phillip Wood wrote:
>> Hi Cristian
>>
>> On 13/12/2022 15:34, Cristian Ciocaltea wrote:
>>> Hi Phillip,
>>>
>>> On 12/13/22 15:04, Phillip Wood wrote:
>>>> Hi Christian
>>>>
>>>> On 13/12/2022 10:37, Cristian Ciocaltea wrote:
>>>>> Currently '--onto' works as if the user provided the 
>>>>> '--reapply-cherry-picks' flag,
>>>>
>>>> --onto does not affect the cherry-pick detection. When running
>>>>
>>>>      git rebase --onto new-base upstream feature
>>>>
>>>> any commits in upstream have been cherry-picked from feature they 
>>>> will not be rebased. What it does not do is look for cherry-picks in 
>>>> onto...feature. It would be nice to add that but I'm not sure it is 
>>>> straight forward to do so and still exclude commits that have been 
>>>> cherry-picked from feature to upstream.
>>>
>>> The proposed patch enables looking for commits into new-base..feature 
>>> range and excluding the ones reachable from upstream. Since this is a 
>>> change in the existing behavior, we might need to introduce a new 
>>> flag to enable it. I previously suggested to use 
>>> '--no-reapply-cherry-picks' for this purpose, but now it's pretty 
>>> obvious this will be a source of confusion, since the "cherry-picks" 
>>> term refers to the commits picked from feature to upstream instead of 
>>> new-base, as you already mentioned.
>>>
>>> I agree it would be nice to support both exclusion ranges, but I'm 
>>> not sure how complicated the implementation would be, since I don't 
>>> have any previous experience with the Git internals. Could this be 
>>> added as a separate feature at a later point?
>>
>> If we can I'd rather add code that excludes cherry-pick both ranges. 
>> To remove the cherry-picks that are in upstream and new-base you could 
>> rework the todo list generation as follows
>>
>> 1. Calculate the merge-base $mb of feature and upstream
>> 2. Store the list of commits $mb..feature in an array and in a hash
>>     table indexed their patch-id.
>> 3. Walk $mb..upstream calculating the patch-id for each commit and
>>     removing any commit in the list from step 2 that matches.
>> 4. If onto is equal to upstream skip to step 7
>> 5. Calculate the merge-base $mb of feature and onto.
>> 6. Walk $mb..new-base calculating the patch-id for each commit and
>>     removing any commit in the list from step 2 that matches.
>> 7. Generate the todo list using the modified list of commits from step
>>     2.
>>
>> I don't have much time at the moment but I can try and help a bit more 
>> in the New Year if you want.
> 
> Thank you for the implementation hints and your availability to help 
> further! I will try to put this in practice and let you know as soon as 
> I get something working.

I'd start by looking at the existing todo list generation in 
sequencer.c:sequencer_make_script()

Best Wishes

Phillip
