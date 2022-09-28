Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F3DC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 14:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiI1OdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI1OdG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 10:33:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13277757D
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 07:33:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bq9so20125586wrb.4
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=sGxkEX9Vl+R8wUJkqzXoFveusWK+vELEirGGypEoWHY=;
        b=C+VkajwrI6x2MZX2zGGNpn1BhRd7gEURw9yAxbKX152lYoT2S2Bzi48gHQEfjUlJsL
         UtPBRDy4xHkaULCZ6eZwFpeZupj3laAl4CBiYzNoYE6aUl2ua5TreZ3izFZHVwfT/QwR
         9Qd2tFQfQmr6HfZwbmZsPyuQlAfiI4/vyg4tQBrfLHj9MZ03C7xe8nut/6Di+3/LSqUO
         oPodgVAauJjqjMvVgyfMnxiZuapfgs0Q1F+bFjK8Wq72AfhVRRH1xCbQB20RjKshIEEp
         A8iWzHmAgZXjU0K/bXSu9uxgGzMDhtzCvnW4ahnKx5tPpCGe4GeoP6om5yIGSdbteuGw
         6VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=sGxkEX9Vl+R8wUJkqzXoFveusWK+vELEirGGypEoWHY=;
        b=HzNBRGJ2yZ3SvsNLuiEFuvwl7Tziyt2Vn9uuVbmWpY6GqS9Z/wKr/2CQKCYUJ9td0X
         c9JVsdprWZHMTKPHA5bPEcldCdZCJiti2KDcZSoP/h0j0KP54uljdoEqXpKotr3Usfqi
         Wa7x7bsnztXOEbahCesXnm7y1xlMFMYt0Nzmc2cDYlDuH9rzMEn1VRd58/AZ7KnYxL2E
         rRG4fHmq73jWakg0v7mWGw2XzAabdfyXkr7D0cySFDwp/Q87zJoq21Mw+Ykpfbh0QHJX
         tMwGltWanA9G/cMFVG5fCUukMliKQ0PDE1iME5mzcxzd/4szx9BVcDgAVHErU6gPVFL4
         gPqw==
X-Gm-Message-State: ACrzQf0bmCB2K5Oc38QGQOUfRzJUpwwNPJZsjLEDXkmHykSrIfDF7+SS
        ViVG7yJPsVI/GvcGq7+vADOGGsPcFH4=
X-Google-Smtp-Source: AMsMyM7AZbM2O1pS3e/f7c826u0E5dOkBkroqdrHXY2hRc/En6uoISbpZkFQ+y7FhhRBS1LXJr0K3g==
X-Received: by 2002:a5d:4252:0:b0:22c:cbd5:6d2f with SMTP id s18-20020a5d4252000000b0022ccbd56d2fmr972268wrr.503.1664375584143;
        Wed, 28 Sep 2022 07:33:04 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003b3307fb98fsm1866566wmj.24.2022.09.28.07.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:33:03 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <72c4e8c9-62bb-96aa-7b42-d7103b7873eb@dunelm.org.uk>
Date:   Wed, 28 Sep 2022 15:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 05/10] evolve: add the change-table structure
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
 <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
 <220927.865yh8zzux.gmgdl@evledraar.gmail.com>
 <ae031714-ba51-fe39-6351-ebd638840c32@dunelm.org.uk>
 <220927.861qrwzvhe.gmgdl@evledraar.gmail.com>
In-Reply-To: <220927.861qrwzvhe.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/09/2022 16:28, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Sep 27 2022, Phillip Wood wrote:
> 
>> On 27/09/2022 14:50, Ævar Arnfjörð Bjarmason wrote:
>>> On Tue, Sep 27 2022, Phillip Wood wrote:
>>>
>>>> On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
>>>>> +/**
>>>>
>>>> We tend to just use '/*' rather than '/**'
>>> No, we use both, and /** is correct here. It's an API-doc syntax,
>>> see
>>> e.g. strbuf.h.
>>> It's explicitly meant for this sort of thing, i.e. comments on
>>> public
>>> structs in a header & the functions in a header (and struct members,
>>> etc.).
>>
>> We don't do that consistently, we don't mention them in
>> CodingGuidelines and we don't use anything that processes API-doc
>> comments. It would be a lot simpler and it would be consistent with
>> our coding guidelines just to use the same style everywhere. That
>> would avoid problems where this series uses API-doc comments for
>> in-code comments in .c files and where single line comments in header
>> files do not use the API-doc syntax.
> 
> Yes, this isn't documented in CodingGuidelines (but FWIW is in various
> commit messages).
> 
> I'm pointing out that this isn't a mistake, but the preferred style for
> new API docs.

It seems a bit a stretch to call it the preferred style, however I had 
thought all our uses were historic but that's not the case.

Chris if you want to use '/**' style comments for the API docs then 
please do so consistently and do not use them elsewhere.

> At least Emacs knows how to highlight these differently, which is the
> main use I personally get out of them, I don't know what other use-cases
> there are for them...

I've come across them in projects that use gtk-doc or other 
documentation generators where it is necessary to distinguish 
'documentation' from 'code comments'. I don't think they add much value 
if one is not generating documentation from the source, it is just one 
more thing for contributors to remember.

Best Wishes

Phillip


