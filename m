Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB5C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 12:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiITMTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 08:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiITMTR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 08:19:17 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D4C74DE0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 05:19:16 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b23so2063019iof.2
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AOn4zv48SSoEI/I7Q0L1dyvjtiY1xTf/jKAxJeEfOR0=;
        b=KZHAyJap7HpbqR91uKSAYswS1WR7CtHWyzqwXEoCTm4D/8CUhl4LuAxY3SMQyJj3FW
         6QDOhU1bqONIcEYa55pIgTOjlekYXkebMuLg083BGiWaEVwqlE87msYqhVZBdEHR6fpK
         zxqdZjAwSm2ViW/3j94575FHvy6Fb9HsDYMQJQXkV9u9upHC5fplGcKT2/Peu9x/CPWo
         OptbrbNZdkybMIT8Y71inJnOyRaBz5Py6cwTKSZczzRp5aEND8Fq1sv3luiV8/eIcFV8
         gm+7uB/QEqDmasT1kFE4sRS6nbublMZ0WzPMp/fPkN1XPLXE619LaB9HFlWottqGjdNH
         eybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AOn4zv48SSoEI/I7Q0L1dyvjtiY1xTf/jKAxJeEfOR0=;
        b=ZBnUifjhquw63TJ5TAXZo6am1fbxKY+BmIGAGlYVN46SMn/S8ESbSKL2mAOtpbYSyR
         tOv3ktl8eu2hx15NG9Blqs1PotfdVXfZBmIzJ1BEgdM8qeRIln8HMebkFJR8o8WYjkaU
         XhCXCDMKt0MCUvIDPdiFwoi2m9eIknf5UKwn5gtJ/M18pi4++rTSSe2lTy0Sp3jGbL06
         2j/6/ZchpOcsY02rdBGFH/AF34j8HkoeH53nYg806J2bReebffSpx0nex70pdZlQZQzH
         Ck088TcL3JeAXv5QeSt0U6WW5FRznEdunL4AmawIPfgEtWLNLnf7csUv2QRHGRi+dkSE
         08pg==
X-Gm-Message-State: ACrzQf2RikG7UAHbxocwXmjRM+gxauy9Ewn2MRxBaSd+T1khBBcsXsFi
        aPT2jvvjZyFHcXOqi0YU2u5GBCqFYGgT
X-Google-Smtp-Source: AMsMyM6WHqKFjhBpdrT4qhqLxaTSNmldLuWC1h0la7fS684hIjlpQYxrqGtn5LBaC1HQC5/Of9QpDw==
X-Received: by 2002:a05:6638:2488:b0:35a:17ac:8cd2 with SMTP id x8-20020a056638248800b0035a17ac8cd2mr10518576jat.175.1663676355865;
        Tue, 20 Sep 2022 05:19:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ece2:5e56:6003:4064? ([2600:1700:e72:80a0:ece2:5e56:6003:4064])
        by smtp.gmail.com with ESMTPSA id a15-20020a92d10f000000b002f53ce5e426sm585731ilb.69.2022.09.20.05.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 05:19:15 -0700 (PDT)
Message-ID: <990f84f9-fdd9-0d0a-4fc0-d0dbd19ee5a9@github.com>
Date:   Tue, 20 Sep 2022 08:19:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/5] roaring.[ch]: apply Git specific changes to the
 roaring API
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
 <38ec2360f4fbfe65fa2d9f1e9cfb7d4944d1714f.1663609659.git.gitgitgadget@gmail.com>
 <b727c25c-469f-ca56-bbd6-82f82c762523@github.com>
 <xmqqr10781lx.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqr10781lx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2022 6:02 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>>>  int32_t array_container_write(const array_container_t *container, char *buf);
>>> +
>>> +int array_container_network_write(const array_container_t *container,
>>> +				  int (*write_fn) (void *, const void *, size_t),
>>> +				  void *data);
>>
>> Should we make write_fn a defined type? I'm not sure I've seen this
>> implicit type within a function declaration before.
> 
> Unless we can point out why having a named type is a good idea
> (e.g. we add such a function pointer as a member of a struct, or we
> keep a variable of that type somewhere), I actually would prefer to
> do without them.
> 
> Perhaps there are some more important reasons I am missing why we
> often come up with explicit types for callback function pointers in
> many parts of our API, but if there aren't, my preference actually
> is to lose them, not add more of them.
> 
> Hmph.... could "a typedef can become a place to give definitive
> documentation for the class of callback functions" be a good reason
> why we would want one?  I dunno.
> 
> In the posted patch, readers cannot tell what kind of three
> parameters they are supposed to give to write_fn().

This is exactly my reasoning. Having a clear definition gives us an
opportunity to document what each parameter is for, even if it is
just a variable name.

This anonymous type is used in multiple places, so it can be helpful
to know that the type is connected across call sites or a stack of
method calls.

In the unlikely event that we needed to modify this callback
signature, changing it in one place makes it clear that we cover
all connected uses instead of tracking all of these anonymous
functions across multiple methods.

Thanks,
-Stolee
