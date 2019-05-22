Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C6F1F462
	for <e@80x24.org>; Wed, 22 May 2019 00:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfEVAfn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:35:43 -0400
Received: from avasout04.plus.net ([212.159.14.19]:39357 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEVAfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:35:43 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id TFELhLXZmticRTFEMhZqfa; Wed, 22 May 2019 01:35:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1558485342; bh=6JXJVGb/dQud4MgbqQzX7u2je+pQ1WmiyGxrSFt5/Go=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sbbWJszQPED7dz3majPWfbXZ8jO6LnWCfjCf+XfwWUkuJnDkx2nmZQxwdXkVC+PUV
         xbcWrgnf64sWUq6uKSchWfnVaelGa6kuMi8rtS/r7gY0IIVngMD7dwVcO9p+y4A3CN
         ffcXDGCt1jJ0Wt2qciWeh+Zg2rjf2dYd0L/bnfdfxkb2o1uk0kJXhTHGs0u71wpLhW
         cQcJDVF9yTn4xC4zI/kciGxfCbPYCYreZJ8IWH1AVXDq6zvVROQsSorQ/KfMC+eFvI
         nG5xO3+PGYukn4yL0tLE8j1Pf8mCppWtYKlg9PX8EqihmGs9KmCm679ta6qOGy4RlC
         /AcvH+E1QTjAQ==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Gs88BX9C c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8
 a=DMf4DAfpwMgutcOSsScA:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: Incorrect diff-parseopt conversion?
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <82f79cd9-5273-b9a4-744d-f5fa95dd1f47@ramsayjones.plus.com>
 <CACsJy8BHeVDDnEYXaOAPtEoesTVNCiPGSgnJYjtL6aYSU0-J5A@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <791da98b-4065-e477-92cb-ceac80cc04e6@ramsayjones.plus.com>
Date:   Wed, 22 May 2019 01:35:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8BHeVDDnEYXaOAPtEoesTVNCiPGSgnJYjtL6aYSU0-J5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFzR7rEyIofOhBlLRBW9Vzs9mAASKXf28X/2/r6LCeTs4Os03hfmbvf3uUpJ4YATFoJ3BGUJ/0sw4Pn514NX9t6xK2AkNMIik1Ki1nWfOULUvYZecrMk
 3Mjtq9G/jD6ci53j20OctlQPoqmE6N0SopQJos+ecP3bcmL+5rG3aXXDZYgOrR/TpIzkcYyhLVMZ3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/05/2019 01:11, Duy Nguyen wrote:
> On Wed, May 22, 2019 at 2:56 AM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> Hi Duy,
>>
>> I am in the middle of rebasing a long running branch onto
>> current master (v2.22.0-rc1) and noticed something odd with
>> commit af2f368091 ("diff-parseopt: convert --output-*",
>> 2019-02-21).
>>
>> As part of the branch I am rebasing, I have defined a new
>> OPT_LL_CALLBACK() macro[1], which I had intended to apply to
>> the 'output' option to diff. However, commit af2f368091
>> defines that option thus:
>>
>> +               { OPTION_CALLBACK, 0, "output", options, N_("<file>"),
>> +                 N_("Output to a specific file"),
>> +                 PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
>>
>> Note that the 'option type' is given as OPTION_CALLBACK, not
>> as OPTION_LOWLEVEL_CALLBACK. Is this intended?
> 
> Yeah I think this is correct (phew!).

OK, I just had a look at the code in parse-options.c.
Hmm, somewhat ugly! :-D

Thanks.

ATB,
Ramsay Jones
