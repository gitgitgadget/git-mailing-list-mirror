Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804DC636CD
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 05:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBDFWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 00:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBDFWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 00:22:48 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677799218A
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 21:22:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 7so4984292pgh.7
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 21:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTX/QB2eVrjYC2t2r82cGInRFM10Elz6c6MF5cx53ns=;
        b=fq/mBHrHFnWQA1no+B5Tq6SStAsbj04qj5Z4/lZhwkq0tAFbwDEAPqtLd31B7Itk7m
         HkoRJIi19aI6ECM+eg4L1euWW2zcTMKIuPUzh3ePKyHnUC1tRcrKSBAzYbACndGWlL4f
         n+5MGiu3+ZEI0mwTl+qzhkcHW1xqpvh1C3bEpvGC4dICvo0whuQ+7ieN9huE1szlny8o
         40LHYJ8z4u8/IfOuy9dxnmsHku46BSyOHs2juge8Y3ZfEvLsvGwtVZ5KnWTaYU1Q5MCF
         lbgPpODVkzZW5crUEY4qoMMim3zGlwEFAZD0LvhuRXudy76W/PmQ5LMC9qAhmm2QWWQA
         c+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTX/QB2eVrjYC2t2r82cGInRFM10Elz6c6MF5cx53ns=;
        b=SJlJKvKbOb/ZYIHWb4OD8bhNl4WmfUImBES8dwWzU76pxSd+IejRNL6yAWvu5eSg+5
         +Oal/hONpHtLz+Qp2tRDzEAFNIAKzNiVGthg2IZ8SHY8nJNF8OjUbtKasVNBuJGzkeUD
         LdhjV1bLN6UjC9Cd3bbyVSyULwX+iJBZakuz5zKiBeT1F0ih5w2ocVkjFZ4XzxN4Z/r9
         kqmDkf3OGnDnwKXM2Zen2QhnYpIxrc7FjHgphEH4uLbnHnpB+MwsKwmrErdqw4Qd/Iwq
         ew6lQZmGpNe5trwokiBmC8iRB5Wi2PoPjLsLFtDwnAIkaM9FdDXAa2MRZJk/IUF2EiQB
         wglw==
X-Gm-Message-State: AO0yUKWCm9GitERWUvADiuYIBLAleNccUNk5yuX1WXWI1yh4pYFc/G64
        6gL5fxl+pxGfROxBT+7cB72HgQUmEqU=
X-Google-Smtp-Source: AK7set/5/zKcUeE4JHFEoNuTpm356dkrVS4CUTKV0FGOh7+RWUJIW9Q2qlQJyshu40ZML3k8GraK9g==
X-Received: by 2002:a62:aa0f:0:b0:593:adfa:84f6 with SMTP id e15-20020a62aa0f000000b00593adfa84f6mr11923113pff.23.1675488166803;
        Fri, 03 Feb 2023 21:22:46 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id k19-20020aa790d3000000b0058193135f6bsm2756474pfk.84.2023.02.03.21.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 21:22:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/6] imap-send: make --curl no-optional
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-4.6-e9cc9bbed1e-20230202T093706Z-avarab@gmail.com>
        <xmqqfsbnu7dk.fsf@gitster.g>
        <230203.867cwyberv.gmgdl@evledraar.gmail.com>
Date:   Fri, 03 Feb 2023 21:22:46 -0800
In-Reply-To: <230203.867cwyberv.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 03 Feb 2023 22:46:11 +0100")
Message-ID: <xmqqy1peknrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 02 2023, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> In the preceding commit the old "USE_CURL_FOR_IMAP_SEND" define became
>>> always true, as we now require libcurl for git-imap-send.
>>>
>>> But as we require OpenSSL for the "tunnel" mode we still need to keep
>>> the OpenSSL codepath around (ee [1] for an attempt to remove it). But
>>
>> "(ee" -> ???
>
> Should be "e.g.", will fix.

I think it's more like a missing 'S'  before 'ee'.

>>> -#if defined(NO_OPENSSL)
>>> -	if (!use_curl) {
>>> -		warning("--no-curl not supported in this build");
>>> -		use_curl = 1;
>>> -	}
>>> -#endif
>>> +	if (!use_curl)
>>> +		die(_("the --no-curl option to imap-send has been deprecated"));
>>
>> We used to force use of cURL when there is no other way to make the
>> program work (i.e. there is no direct OpenSSL codepath available),
>> instead of refusing to work (and forcing user to say --curl or to
>> stop saying --no-curl, which is one unnecessary roadblock for the
>> user).  Why do we want to change the error handling strategy that
>> has been in place?
>
> I can change this to a soft error, but it seemed more sensible to rip
> the band-aid off an option that's never going to do anything now,
> whereas before it would do something based on how you compiled git.

Stopping and forcing the user to spend an extra step does not sound
sensible to me.  Let's never do this kind of behaviour change "while
at it".

Thanks.
