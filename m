Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE253C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 15:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiLOPkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOPkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 10:40:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15212A95A
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:40:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg10so14091674wmb.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XwyaEqyCk97ZmrTuSW7Q7ei5ngeCVLs3A7ezb8MJCek=;
        b=QoxHHokaOivogkQXdiFlbFArOgip9eR7gOITbQTpKm+0kGs8vP/MbKrjTM7wDtn8xJ
         IfrWnRs04cdus2V4mV6YFsn+WxpDt75ldAUiFfB78DHWm+myZ+a/v5c1ySJpU6HPIECx
         9lPcECrxvYSgKmHhp5eAjWPKWH9iZW3ukhz38Ss/kVu339u7r0zUN8nMM8Dp3JkE5/RU
         4QRPF6uETzLRXMQIkffGoun+T0OECbQNX0+FIOMVa3vD/1EQ3m2ltPr4NVQvaEt7+8/o
         +DsRJr3TQFpQBXtw4icFNUa9HqjkYlW/+R43ZkQEGtiD8yhZoUvLxJrvlMkrQZs3+w3b
         Y6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwyaEqyCk97ZmrTuSW7Q7ei5ngeCVLs3A7ezb8MJCek=;
        b=Hlfu/Zsn/me2b51PFp0sK8aSx6FnnfvGpILgyfBnauag+hUNXyGY425AoLwH9TJOja
         PKqI8K5lSLsthls+uAzIrj4OkBSoHJSJxraNz77b0+Aa7Lb+VBs6p42y7YzgaqS4upL4
         Ei1IXpKzsscf2DBquprgqP08FrnDiK7EP24k2Mtofs7YPTPlKDaFpXTRpmElRf2RXcJD
         1WmuUY2gyi/EDdTj74EasK8ABU9/zWXnIotF5ADghAxs/S8ixFAOp1XkwcacpOjwFZXL
         97rWWPgZQs/JJorSDc2c0uZ3HU0MaviWAW8P3ph7JGAqWRhP+6yYnchGfJLCKURhgcbf
         Z30A==
X-Gm-Message-State: ANoB5pmDXMINbu5IICoy/zXUNsAuC8YQzVtoreubEPm2LZmQCm0J0eNW
        9tk1mMybATgEJxdXfCN+KNE6A12anUI=
X-Google-Smtp-Source: AA0mqf5vgIlLIzsMD1eXImfNj34jjbCtdf3RCOeknezeCaELgOKpkzGlirAOtwwfWq/y0e8I0mskMg==
X-Received: by 2002:a05:600c:1e18:b0:3d2:26e1:bd45 with SMTP id ay24-20020a05600c1e1800b003d226e1bd45mr17493533wmb.29.1671118816294;
        Thu, 15 Dec 2022 07:40:16 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b003b4868eb71bsm7930855wmq.25.2022.12.15.07.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:40:15 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <3c5cb346-e6b4-7b85-6d3e-4b625cc21a94@dunelm.org.uk>
Date:   Thu, 15 Dec 2022 15:40:13 +0000
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
In-Reply-To: <9e06bfd1-3e63-2414-e18c-6901fbb290e3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Cristian

On 13/12/2022 15:34, Cristian Ciocaltea wrote:
> Hi Phillip,
> 
> On 12/13/22 15:04, Phillip Wood wrote:
>> Hi Christian
>>
>> On 13/12/2022 10:37, Cristian Ciocaltea wrote:
>>> Currently '--onto' works as if the user provided the 
>>> '--reapply-cherry-picks' flag,
>>
>> --onto does not affect the cherry-pick detection. When running
>>
>>      git rebase --onto new-base upstream feature
>>
>> any commits in upstream have been cherry-picked from feature they will 
>> not be rebased. What it does not do is look for cherry-picks in 
>> onto...feature. It would be nice to add that but I'm not sure it is 
>> straight forward to do so and still exclude commits that have been 
>> cherry-picked from feature to upstream.
> 
> The proposed patch enables looking for commits into new-base..feature 
> range and excluding the ones reachable from upstream. Since this is a 
> change in the existing behavior, we might need to introduce a new flag 
> to enable it. I previously suggested to use '--no-reapply-cherry-picks' 
> for this purpose, but now it's pretty obvious this will be a source of 
> confusion, since the "cherry-picks" term refers to the commits picked 
> from feature to upstream instead of new-base, as you already mentioned.
> 
> I agree it would be nice to support both exclusion ranges, but I'm not 
> sure how complicated the implementation would be, since I don't have any 
> previous experience with the Git internals. Could this be added as a 
> separate feature at a later point?

If we can I'd rather add code that excludes cherry-pick both ranges. To 
remove the cherry-picks that are in upstream and new-base you could 
rework the todo list generation as follows

1. Calculate the merge-base $mb of feature and upstream
2. Store the list of commits $mb..feature in an array and in a hash
    table indexed their patch-id.
3. Walk $mb..upstream calculating the patch-id for each commit and
    removing any commit in the list from step 2 that matches.
4. If onto is equal to upstream skip to step 7
5. Calculate the merge-base $mb of feature and onto.
6. Walk $mb..new-base calculating the patch-id for each commit and
    removing any commit in the list from step 2 that matches.
7. Generate the todo list using the modified list of commits from step
    2.

I don't have much time at the moment but I can try and help a bit more 
in the New Year if you want.

Best Wishes

Phillip
