Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157B7C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 10:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63112087D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 10:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWJcGt90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgIQKOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQKOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 06:14:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884BFC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 03:14:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b79so1446836wmb.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5DI2q9VAuVkciDIY/OMavzc1oejXEAl6nYderiMTumU=;
        b=jWJcGt90N03katCvV49v/Q1M6aqnmvSVwKGQab7RMLF0+NQyc6OWOvoI2OErrtgIXt
         vmkZaVTolseTMiFsyI+Uo5lclZCBkEN8v45HWvmhfv8j58XElISXQt64Fj7mcfFmRmx/
         HILSpZF3eKaEVqEZJAUqlo3fUNgBWCnmSJlQNADrzm7+3XQ1YJFEE4bhaNX9+yLHN+hY
         CAtK6hLt57Uw2H/RVdw7z8qS0bE8YlRXghpZD/DezKp6dWBXJpaCkT+PrNICfJJL2Ub7
         rtt05xUAU49KsP0U5V5jMdGnoNzNvNPsYzxVoaStNyZZgTBsrJXsVcwYyYJcez2PVgX5
         7bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5DI2q9VAuVkciDIY/OMavzc1oejXEAl6nYderiMTumU=;
        b=Yxw5hrwKK1JpZdj36NMIzBVWN3s32rZXuPxWs7Vi7pfiat/+UZfgXYXqeXIz3FhAyV
         JtfiBrmGjAe5uWuclJIHjFex53/exxBHhmwsGw41FWU6N8DrSlA4nhcFh0QfNk+zDQdN
         5EDBYxqUt8nv2YUx9ltQUQ3pB/bx9lv29hE1C3dQW2UtRE0JZ6ffUOasvTAytsNIfrJB
         0iJG5AnBY+FSZAYTAv9QBk8zj82qVYOOxuc5oCrKzm+VlpuPz0Vs1J5K3ABBwaGxIxnX
         sL1o6no9LN1/Uvojb80G6N6VCoFFYAJ+udK8RVaVKH40rybfjVjRX8RVIxmshj6fMlsv
         WMcg==
X-Gm-Message-State: AOAM530ba9KY1OEpYdygQXxK5zB/DOnh0aoyPMf4cnV6KB922tVV0vax
        X1W+2FrUiepveL3yKygf/Pk=
X-Google-Smtp-Source: ABdhPJyD8Keuqz8VIIqe7UmiOqOAP3uJxJOIJX4VBgw5AD38jk4SFiOipMEsJkbeAU8LQM8T4+Wq/Q==
X-Received: by 2002:a1c:e1c2:: with SMTP id y185mr9568710wmg.182.1600337677991;
        Thu, 17 Sep 2020 03:14:37 -0700 (PDT)
Received: from [192.168.1.240] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.gmail.com with ESMTPSA id z15sm37495649wrv.94.2020.09.17.03.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 03:14:37 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet>
 <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
 <CAP8UFD1n_PYzygFCgNDt3T=EQhbcuaTYFCfNN5n45OHRh45KOg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ed35b0ac-a2c6-c25d-db39-284e7daf29e8@gmail.com>
Date:   Thu, 17 Sep 2020 11:14:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1n_PYzygFCgNDt3T=EQhbcuaTYFCfNN5n45OHRh45KOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/09/2020 10:43, Christian Couder wrote:
> On Wed, Sep 16, 2020 at 11:01 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> 
>> On Wed, Sep 2, 2020 at 10:50 AM Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>>> As to projects, I would like to believe that
>>> https://github.com/gitgitgadget/git/issues has grown into a useful
>>> resource.
>>
>> Thanks for the useful resource!
>>
>> I would be interested in mentoring, or better co-mentoring, the
>> following projects:
>>
>> - Accelerate rename detection and range-diff
>> (https://github.com/gitgitgadget/git/issues/519): ideally I would
>> co-mentor with someone a bit familiar with the suggested algorithms.
> 
> Proposed on Outreachy's website:
> 
> https://www.outreachy.org/outreachy-december-2020-internship-round/communities/git/accelerate-rename-detection-and-the-range-diff-com/cfp/
> 
>> - Add support for drop!/reword! commits to `git rebase -i`
>> (https://github.com/gitgitgadget/git/issues/259,
>> https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtualbox/)

I'd be happy to support someone working on this though not necessarily 
as a formal co-mentor - what the time (and other) commitments does being 
a co-mentor involve?

Best Wishes

Phillip

>> - Invent a way to retain reflogs for a while after the ref was deleted
>> (https://github.com/gitgitgadget/git/issues/236): I guess this might
>> be implemented as part of the new `git maintenance` builtin.
> 
> I will also likely submit a proposal for one of the above projects.
> 
