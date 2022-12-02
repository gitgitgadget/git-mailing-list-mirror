Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A369C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiLBTvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 14:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiLBTvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 14:51:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD1EE940
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 11:51:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so6073185pjg.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 11:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mylv2m0MVnEzZY2uVLgdGm7BOZTR1gQjcC5bKxmHMGs=;
        b=OuAoNT6F3btretMBgwMBalnye6kgpHZBAo3kuZRH+yvumFUg1LIgRc9RjYt0EKLIsU
         L9t4VY2h6E0KpK8Qc6SCiRP763zXkVMo0KyBuIkaNPaPXQpqqfnLJWGJhjof/hEhDO0U
         M867d8Ux+VhBrzg3466ZCc0SU3k1b43dkn1CKOqFOK3Y8ZLvqhqHywvDwkgTaGOTQvJq
         0lYthqfGNrNF5VhTQGpPXE0W84anwzMLeZnyAWR8O7wej6Pv1uwxSZ6OBxAKYqcRYQ39
         4agYGBt8u1Xjr+1tU76VoTPoL1Q+56cJtWk7gx3i0cOzAs/MNewnBgTOkY77Fe/z87kS
         y3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mylv2m0MVnEzZY2uVLgdGm7BOZTR1gQjcC5bKxmHMGs=;
        b=e3O5NzvuiqZgLpcs+NLTY+WD9M/kHC0uA7vyDLeX7XRQ9DayRbCu2e0XnCxSqWobsk
         +EBhhm9nurnYBI2Akfwf37yGyhddWn0X7wHXfojMUNWBd+REUU8/B+88kosOBTeRgdwt
         W6IAkqZgq0TIbbikabUDAldLYGgKFYwCdJA/I+Ja062HuLHHJwZbsCrErh4ovB4+hzCc
         iSJp6Ypyt6MRNRj0PZWrZE+UVrePUzd4e2flMPjpoelaiFCKEc/hGPY8uN8Acu4aYffi
         IxATd+v1hf3ghw6EMiYoUnkNLMK+NMpzbYfFn0lNApTqlkVDfjPUY5mh9DWs+wFvU4lv
         UZvw==
X-Gm-Message-State: ANoB5plggfjXWnAUx5UXuGQ0mWlF7lLO8csbcRMyYHVN8UfxfX34nkeZ
        +idM2CQ5lb0hOSyP12H45LaC
X-Google-Smtp-Source: AA0mqf4CBOXoX6bYqxjWBhn6YxB3YWZlpqrXE3TiGB+fbW9P5crb53/JHVc4N8tpN/qJ32p9p9dYMw==
X-Received: by 2002:a17:902:f651:b0:188:50c2:89fb with SMTP id m17-20020a170902f65100b0018850c289fbmr37299746plg.130.1670010674262;
        Fri, 02 Dec 2022 11:51:14 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b0018853416bbcsm6004042plg.7.2022.12.02.11.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 11:51:13 -0800 (PST)
Message-ID: <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
Date:   Fri, 2 Dec 2022 11:51:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
 <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
 <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
 <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Dec 02 2022, Jeff Hostetler wrote:
> 
>> On 12/2/22 1:02 PM, Ævar Arnfjörð Bjarmason wrote:
>> So, based on the ages of those two Apple releases, I'd like to think
>> that we're fine just switching over and not having to ifdef-up the
>> config.mak.uname.  (If it were a more recent change in the OS, then
>> yeah the answer would be different.)
>>
>> Thoughts ???
> 
> That seems reasonable to me, but it came out in 2001, and we'd be moving
> the dependency to a 2007 version.
> 
> Is that OK? No idea, I don't know how old of an OSX version people
> reasonably run & want to compile Git on.

I appreciate the diligence, but I don't think continuing this discussion
will be productive use anyone's time.

Apple doesn't seem to provide official end-of-life dates for their OS
versions, but we can extrapolate from the list of obsolete hardware [1] that
it likely doesn't support OS versions older than 2014; that's corroborated
by their official set of release notes going only as far back as 10.14,
released in 2018). In other words, I think it's safe to say that a version
supplanted in 2009 is old enough to not warrant Git support.

Thanks,
- Victoria

[1] https://support.apple.com/en-us/HT201624
[2] ttps://developer.apple.com/documentation/macos-release-notes

> 
> But in 842c9edec64 (fsmonitor: enable fsmonitor for Linux, 2022-11-23)
> which is new in this upcoming release we seem to have set that
> dependency at 10.4.
> 
> Now, you can unset FSMONITOR_DAEMON_BACKEND and FSMONITOR_OS_SETTINGS in
> your config.mak.uname, but that's probably something that should be
> noted more prominently.
> 
> Eric? [CC'd]

