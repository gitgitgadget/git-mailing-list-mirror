Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78CF61F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbcIAWNB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:13:01 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37346 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbcIAWNA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:13:00 -0400
Received: by mail-it0-f49.google.com with SMTP id e124so6487649ith.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=evVTC6Fe7CGYVvdm+USDIMttF8a0ZW7E6WrZAsUSqkE=;
        b=Zxu8jg7D20ggSi2wI5SqHOZfRx0OhnfQ6W0f78VYmz3zgFi5sldW0rCLnPVF+jBR63
         VbvoSEWqP6oYf6qj6QoAVbnJeBXJu+1LdnCrgr9I2Zf77DJ2ABOAGT1PE4EhURXsjlOq
         23AEKN1Xyb1Mmnz8IGtfEjb4uqY96YJRvOX4xJng0JJqSdSSs1AI3GJ9/BIoXQQ+Y/D1
         AuuUmxcPqGlQwORr/bTB49zBYZVX8Uvb3wMOaTcCXVJOVHqhX8wg7/gQpAkKtHztdDVB
         wGSICxqZqo8gxX3psKiTlbHrjmZebvOpTFo/Sfpb0/LhuobjU9Y9hLkXeBZV1Oa5k2Hl
         ZcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=evVTC6Fe7CGYVvdm+USDIMttF8a0ZW7E6WrZAsUSqkE=;
        b=mZRGbgClWE/+H7ACWJrLOFjj/GgGVg7fKTVuh5OQ8GG90tPAxk7ItHmCVWpumhGUoy
         BLgSG8FQkDfky7h2eK79azLTgNaitVKpB1X6KGdGPH3z1/klmo1A1SI03Ol6aUJUExpL
         GBMzPw+79Nz6GUdTyzHnvDNDzgul13B7dh238B7HzBVwtPbFp+9IF+YvV2trm6j/QucO
         MJOfYjdM18r/pc8JQfEYvIwErAp7yc8jiFGqxP74OjxzCinTf1x8qd7sxC/hKUdeG1Bl
         7ZTadm4+ZeWRryqlZAu3EGaJobpil+ibkKJKDoi1bHVgu9MQPAe486QPSszduIT8bmQk
         hEpA==
X-Gm-Message-State: AE9vXwO+2WE1Kabl95uPlMWAYCFUquUTVjv0NuZh9hOdeCgZ7Lg3KqooNgijHNp4qKFv/x6P/vsW4NP7MEcUbdyL
X-Received: by 10.36.137.9 with SMTP id s9mr21722267itd.58.1472749076072; Thu,
 01 Sep 2016 09:57:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 1 Sep 2016 09:57:55 -0700 (PDT)
In-Reply-To: <CAP8UFD3RE6L17nQmvZTkx6wycsdG7EA9eM=tYQD8nrS445zg1w@mail.gmail.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <20160827184547.4365-7-chriscool@tuxfamily.org> <CAGZ79kYnp_8iew33KQJK1TB0ROLthHBtvHqf3wVzFkh_JSq5MA@mail.gmail.com>
 <CAP8UFD3RE6L17nQmvZTkx6wycsdG7EA9eM=tYQD8nrS445zg1w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Sep 2016 09:57:55 -0700
Message-ID: <CAGZ79kZT-t_NZZJcdMEB8E1y_u0=LHGWOxbdEeYMjgFHZYtHHQ@mail.gmail.com>
Subject: Re: [PATCH v13 06/14] apply: make it possible to silently apply
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 1:01 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Sep 1, 2016 at 12:07 AM, Stefan Beller <sbeller@google.com> wrote:
>>> Printing on stdout, and calls to warning() or error() are not
>>> taken care of in this patch, as that will be done in following
>>> patches.
>>
>>> -               if (state->apply_verbosely)
>>> +               if (state->apply_verbosity > verbosity_normal)
>>>                         error(_("while searching for:\n%.*s"),
>>>                               (int)(old - oldlines), oldlines);
>>
>> But this is an error(..) ?
>
> Do you mean that it was a bug in the original code to print this error
> only in verbose mode?

Oh never mind.

I meant to point out the inconsistency between the commit message, that
said: "error() are not taken care of in this patch" and modifying a
condition for
an error call. However we need to fix them as you renamed apply_verbosely
to apply_verbosity and made it an enum. So I spoke too early.

>
> Anyway I don't think such a refactoring is needed.

great :)
