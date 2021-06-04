Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE449C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 10:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0ACD611ED
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 10:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFDK0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 06:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFDK0K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 06:26:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05809C06174A
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 03:24:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y7so4129803wrh.7
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TlcLtQZGL0EbI7TlXjRm3qLpUVhR+wy+gENuFD/DaQI=;
        b=Vmwz5ItPfUud8mNsKvRLDmgkP+XQshRIDYDvTHkLXjt4gMJ2L2MSmZ50+x+Q1xdvC0
         XYttMnrB/rukCk28L2M5PluLwP8YUDowBw9Vm3gQKIwx3TKc9mcUUqs63sXXgXj9o2AL
         pGr1R/mwe38a4speAkR30yGXnlcygAbby+Xu8izA/hBaZnxFYagv/LYlbWTdx53TrpvI
         vRCcA+eYad7BMLp8Hx4Vlr/vjdcqUQu5n+ZXiowRrHkZcQAcc3R7tvNT0I0A/lnfVzlP
         h9a/EMZja12p+HFT4ZWIYqIBBTxXvCOHmixNfY8TflsnQGntcvuWSfzy/w7gCrOJYf9w
         H/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TlcLtQZGL0EbI7TlXjRm3qLpUVhR+wy+gENuFD/DaQI=;
        b=oyfvqHAB9tH7Rukm/xLCXsVXTf29nlVEW8spjFf7F9/6BBnrzJ2mTulpZzkYvkc2Vr
         fQPyUpYVfU+26hJyfWl8EakIoNGWfjQcrFbMdj2b5UJ1eaoOx+DVECCiHTZqjyAX3EQQ
         cB5Hfv9fn/C9omN1QLGk087yHDrtkO71a0EnMq/1DSfRGKBR0N0ln6a7L0GCLPm+vpOA
         XLeQk6MvMtrQJnEZyNLC7e75zutFS1pLMIsYS7ZyGpb/ACgWn7zW/Ic4GSupPDI1d2l8
         rAc3mV3AfNueLgM8cTjhbMQmzE2xCiaJvhz9JIjIXsaD6600xSaS5wnBnilczbph7kU6
         zt5g==
X-Gm-Message-State: AOAM531jNmRDsbPCk5sqf2UiV9CyTVSnUO88mQie4dp67A8qsvyD2xWm
        OPwChIkZVVk7g96ZlMu4UjdPMNSv4FI=
X-Google-Smtp-Source: ABdhPJy9pTe2R7j0By7C2sgHEFp2aV8cci3k7dPwNioLs/9LglcZwHX4Cig8Rnd+Zpf9AeKrsRqAxQ==
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr3015043wrw.276.1622802255595;
        Fri, 04 Jun 2021 03:24:15 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id m23sm9599618wml.27.2021.06.04.03.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 03:24:15 -0700 (PDT)
Subject: Re: The git spring cleanup challenge
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87bl8n73om.fsf@evledraar.gmail.com>
 <60b8b882b9dc5_1a0a2d208e9@natae.notmuch>
 <87wnrb5cvl.fsf@evledraar.gmail.com>
 <dbbb5a73-12b5-27a1-63d4-eece1e60f57b@gmail.com>
 <87tume6g0g.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3edd4518-00bd-6227-54e5-e546fd6b849b@gmail.com>
Date:   Fri, 4 Jun 2021 11:24:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <87tume6g0g.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar
On 03/06/2021 17:44, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jun 03 2021, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 03/06/2021 13:31, Ævar Arnfjörð Bjarmason wrote:
>>> On Thu, Jun 03 2021, Felipe Contreras wrote:
>>>
>>>> Ævar Arnfjörð Bjarmason wrote:
>>>>> So I skipped the "disable most config", but for what it's worth I think
>>>>> I'd miss these the most, I couldn't pick just N favorites, sorry:
>>>>>
>>>>>    * diff.colorMoved=true: super useful, but I'd be vary of turning it on
>>>>>      by default in its current form. E.g. on gcc.git's changelog files it
>>>>>      has really pathological performance characteristics.
>>
>> Would you be able say a bit more about this so I can try and reproduce
>> it please. I'm working on some patches [1] to improve the performance
>> of `diff --color-moved` and `diff --color-moved-ws` and it would be
>> good to test them on a problematic repo. At the moment I diffing two
>> releases of git to test performance on a large diff. I just cloned the
>> last 18 months of gcc.git and Changelog seems to just be appended to.
> 
> I misremembered the gcc.git ChangeLog issue, sorry. That's about
> something else entirely.
> 
> The issue with the color moved code can just be reproduced on most large
> diffs, e.g. on git.git:
>      
>      $ time git diff --color-moved=true v2.25.0..v2.30.0 >/dev/null
>      real    0m10.112s
>      $ time git diff --color-moved=false v2.25.0..v2.30.0 >/dev/null
>      real    0m0.939s

"Big diffs are slow with --color-moved" is the problem I've been 
focusing on. With my patches I see the time for --color-moved=true go 
down from 16s to 4.3s for that example. --color-moved=false takes 0.8s 
so the --color-moved=true is still quite a bit slower but it's not as 
bad. --color-moved-ws=allow-indentation-change goes from 8 minutes(!) to 
6 seconds. I'm seeing a slight (few percent) slowdown for `git log 
--patch --no-merges -n1000` though which I'd like to avoid.

> So 10x slower, and e.g. diffing from v2.22.0 makes it 25s and 1.1s,
> respectively.
>
> In some sense that slowness is expected, it simly takes time to compute
> this. I think for turning it on by default we should have something like
> the diff.renameLimit, and change the default to some "auto" that would
> punt out if it was taking too long to compute.
> 
> I run with it by default so this doesn't bother me, but I think it's
> probably a semi-common use-case of some people to e.g. diff the last N
> releases of Linux, and then use their pager to search around in the
> diff.

Yeah I can see people doing that.

> We don't want commands like that to take 25s instead of 1s, but I think
> it would be fine (and we should) warn that we aborted on the color move
> if it's otherwise the default.
> 
> Otherwise it'll take 1s, and if you normally depend on it you'll
> conclude that some code you're looking at wasn't moved, which would also
> suck, better to punt on it and warn, just like the diff.renameLimit.

That's a nice idea, one other thought I had was to fall back to just 
looking for moved lines within the same file - that would be much faster 
on a large diff with lots of files but maybe it is confusing to 
highlight only some of the moved lines when there are interfile as well 
as intrafile moves.

Best Wishes

Phillip

> 
>>>> Very nice! I didn't know about it. I'll pick it for my third day.
>>> It makes patch review a lot easier, and also integrates nicely with
>>> -w.
>>
>> I find --color-moved-ws=allow-indentation-change helpful as well (it
>> is quite a bit slower at the moment but I have some patches to bring
>> it up to the speed of the other --color-moved modes.
>>
>> [1] https://github.com/phillipwood/git/tree/wip/diff-color-moved-tweaks
> 
> Nice, I didn't know about that option. Will try it.
> 

