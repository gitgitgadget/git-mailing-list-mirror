Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0359EC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 13:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbiFCNVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbiFCNVi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 09:21:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A252DD67
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 06:21:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so4337672wmz.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PE2cKpiKQrOuqngcGeDYfemHA3SsO28/rBS4WqlDB7M=;
        b=qSyA34pp0nXHZ83wM3y+GvEQdAFlm54WCqtN++W947icfsUk85DVGYmbM/0z9JgKpo
         IBsLqNLEu5tmlUC5D8+xMz7DpgxaDRMdTOTkQBxoqiCWiM3HCoKbTCAs+fiRVhE/sj7n
         EHRERoKHFnTeV0w/SKmdTXJukfXzaNtgjvYx1gyl9WJBd4iJRCyJj81XAWHBuUx4HJje
         23KEIMCKNQUxwdnn5lLq/rUXJg1lK44BEdtn/IxzODGepatZ0UlK+c2VBmHUzN7VKfPU
         bLOms4JUhaBjXaKzhcaNoBlgNB4gKHycnEE1FkAXS4lsvvPYhUFo5XPEeEefZ+ZzigoL
         dxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PE2cKpiKQrOuqngcGeDYfemHA3SsO28/rBS4WqlDB7M=;
        b=5S8vMiYeyjahiJ1VB1GwhjiPCsNEQOLiunq1LryQs3wJPGY42YkkWFqy8hlloxHCVn
         qwVvKTH0L4pZYff8tZPmXQQKMFO98rJeDzca3BBoHkEgtR9zebsKJLzuz65hFO9KrJlG
         up1wYl1iB1L/kIK70EQJ7AyTBs9oqEd7UKzBqjCjTm95ePgH3I7SNRIN+V2cvHxTSrut
         dps4iuP//HyCSW/XPUBql4KmfNKKSsLCMR7QPOEQ72zWRnpDaoWbquvhdoyrP1ispiUO
         Xe2edceRJFihwukp+hU2nvDqDFGqHOKDf3ukYUTb1X326SNsTBsnRHTRPt/fOmRM7HRR
         036g==
X-Gm-Message-State: AOAM533zhb8Ks7Zd/TAFpi6vYHF3ROkoaheZBRgdnu+eWJzbyoSUV61Y
        RP5bV/KFJQs9OlToMtRSEoJtdWgyXm8=
X-Google-Smtp-Source: ABdhPJy8wU7M3HUVti9rXrK7WE9WAda3qzaYdUg1XXV0auU604fu9u90ocCPiZkP9i31x2Ex8dDxgg==
X-Received: by 2002:a05:600c:2312:b0:397:7647:2ac4 with SMTP id 18-20020a05600c231200b0039776472ac4mr8661428wmo.125.1654262494897;
        Fri, 03 Jun 2022 06:21:34 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id l65-20020a1c2544000000b00397393419e3sm11754454wml.28.2022.06.03.06.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 06:21:34 -0700 (PDT)
Message-ID: <993aff66-01b7-4aa3-78ae-0027c9c04ea8@gmail.com>
Date:   Fri, 3 Jun 2022 14:21:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/2] hook API: connect hooks to the TTY again, fixes a
 v2.36.0 regression
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
 <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
 <6e98dfe9-5df2-caab-ed3a-81f07b0bb6bc@gmail.com>
 <220603.86o7zaxfhf.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220603.86o7zaxfhf.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 03/06/2022 10:20, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Jun 03 2022, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 02/06/2022 15:07, Ævar Arnfjörð Bjarmason wrote:
>>> This series fixes a v2.36.0 regression[1]. See [2] for the v4. The
>>> reasons for why a regression needs this relatively large change to
>>> move forward is discussed in past rounds, e.g. around [3]. CI at
>>> https://github.com/avar/git/actions/runs/2428475773
>>> Changes since v4, mainly to address comments by Johannes (thanks for
>>> the review!):
>>>    * First, some things like renaming "ungroup" to something else &
>>>      rewriting the tests I didn't do because I thought keeping the
>>>      inter/range-diff down in size outweighed re-arranging or changing
>>>      the code at this late stage.
>>>      In the case of the suggested shorter test in
>>>      https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206011827300.349@tvgsbejvaqbjf.bet/
>>>      the replacement wasn't testing the same thing. I.e. we don't see
>>>      what's connected to a TTY if we redirect one of stdout or stderr
>>>      anymore, which is important to get right.
>>
>> I'm a bit confused by this, the proposed test uses this hook script
>>
>> 	write_script .git/hooks/pre-commit <<-EOF
>> 	test -t 1 && echo "stdout is a TTY" >out
>> 	test -t 2 && echo "stderr is a TTY" >>out
>> 	EOF
>>
>> if either of stderr or stdout is redirected then the corresponding
>> "test -t" should fail and so we will detect that it is not a tty.
> 
> Yes, exactly, but the proposed test doesn't test that, in that case both
> of them are connected, the test in 2/2 does test that case.

I think I must be missing something. As I understand it we want to check 
that the hook can see a tty on stdout and stderr. In the test above 
we'll get a line printed for each fd that is a tty. Your test always 
redirects one of stdout and stderr - why is it important to test that? - 
it feels like it is testing the shell's redirection code rather than git.

I was concerned that we had also regressed the handling of stdin but 
looking at (the now deleted) run_hook_ve() it used to set .no_stdin = 1 
so that is unchanged in the new code.

Best Wishes

Phillip

> Can that snippet bebe made to work? Sure, but I know the test I have
> works, and that proposed replacement didn't even pass chainlint
> (i.e. hasn't been run even once in our test suite). So I didn't think
> that trying to micro-optimize the test length was worth it in this case.
> 
> It's also getting much of that length reduction e.g. by not cleaning up
> after itself, which the test in 2/2 does.
> 
