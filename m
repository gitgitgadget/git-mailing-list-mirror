Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929B2C47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B4961131
	for <git@archiver.kernel.org>; Sat, 29 May 2021 17:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE2RZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhE2RZA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 13:25:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21742C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 10:23:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h3so3785616wmq.3
        for <git@vger.kernel.org>; Sat, 29 May 2021 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2WGYt4YQEohuk3b1URQIJbuaofrSumP0752RiG+QWYM=;
        b=XdUf+GX/i6KEI2ezPlzaSSan+0e6Rmw5Cd3mZFfrb5Y56qTVsC+y2d9Ltlac/4PPUz
         7NU0wJkoMO8XdbD+zXdVgT8JxLlaaeEtdSK6tHFGNIkjDvczNLh0W6bSarDRobM39NMt
         QFVX8oayQFgp1a6Fry5ya0GKxEcciBBNRDg/d8gwcmxfYyT2GRE+xACHb8hH0EyLkLCw
         KrE3bJg138KApv1gdKVjKfaV5PXkjcFfGXyityWWNXdRhRLOISmxfSTBtDABmtUPrCGn
         fEsntmcYDRUby8LE2bLd+AriYFbpZP9nUyTBzR/xDATddoEQ/4r3ox9W3oPzmHNjJwP/
         D6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2WGYt4YQEohuk3b1URQIJbuaofrSumP0752RiG+QWYM=;
        b=bPBe8LZN/1N8/g2GgPU7ZZC64Q1hxsZfvu/MCMdobymtEuxI0imhJlJhMx9TC23Vo+
         xrLyYHCL36IFnQZSFm4j7kfC0dQxk37KTkCiISx3PAkcRthRSLZsQrnG/lEsAy9GXadH
         sUueXCBxksZX1+XD1+bVrrordy5YqSWljp1GveNLxJU4JanmywEo2kfzenUAnDZRjpel
         V96HwM4EBaGN34xwRUylckQ/olo1HLhLOBf55IMV7wQ4Zl0cd3tIZg/jf/OFtKaIsjI8
         lnx+WC4CK2kYizULI3gKx6XKjSqesqPuu5ueXd1eL34C+hBfaPgd7J7N5UFbEjpan9Et
         koWw==
X-Gm-Message-State: AOAM530B8LTB1c5i7yxXsR1abodcQteOktz/DSJsyBHkgOifGAiaHkBd
        5HxDtx3LUOtmxJMQEDy1fV3TEiopApQ=
X-Google-Smtp-Source: ABdhPJyERfc53mmPXBlUFC2wgu+vYIrJaf7iH0MhCoirunYtb/F1diNWltuOebTaLecNjsNwqlLavw==
X-Received: by 2002:a1c:6209:: with SMTP id w9mr5040013wmb.27.1622309001783;
        Sat, 29 May 2021 10:23:21 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id d9sm11049702wrx.11.2021.05.29.10.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 May 2021 10:23:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch>
 <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
 <60b25ca7a01c2_265088208af@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e7db3342-7022-98db-e0d2-a880f874565e@gmail.com>
Date:   Sat, 29 May 2021 18:23:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60b25ca7a01c2_265088208af@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/05/2021 16:24, Felipe Contreras wrote:
> Phillip Wood wrote:
>> On 27/05/2021 17:36, Felipe Contreras wrote:
>>> ZheNing Hu via GitGitGadget wrote:
>>> [...]
>>>> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
>>>
>>> Why void *? We can delcare as char *.
>>
>> If you look at how this function is used you'll see
>> 	int (*cmp_fn)(const void *, const void *, size_t);
>> 	cmp_fn = s->sort_flags & REF_SORTING_ICASE
>> 			? memcasecmp : memcmp;
> 
> Yeah, but why?
> 
> We know we are comparing two char *. Presumably the reason is that
> memcmp and memcasecmp use void *, but that could be remedied with:
> 
> 	cmp_fn = (int (*)(const char *, const char *, size_t))memcmp;
> 
> That way the same cmp_fn could be used for the two cases.

But that is still undefined behavior - the ugly cast just silences any 
compiler warning without making the code safe. It calls memcmp using a 
pointer of a different type. The type of cmp_fn and the two functions 
assigned to it must match.

Best Wishes

Phillip

> Either way I don't care particularly much. It also could be possible to
> use void * and do the casting in tolower().
>   
>>> (and I personally prefer lower to upper)
>>
>> We should be using tolower() as that is what POSIX specifies for
>> strcasecmp() [1] which we are trying to emulate and there are cases[2] where
>> 	(tolower(c1) == tolower(c2)) != (toupper(c1) == toupper(c2))
> 
> That's true.
> 

