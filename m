Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0143208EC
	for <e@80x24.org>; Wed, 18 Jul 2018 17:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeGRSfP (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:35:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39809 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731236AbeGRSfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:35:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so5527794wre.6
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NcUsbvBprZC4KLkxAbAkQP5yLWOyRtOSgcO75BCVsCA=;
        b=L4OT9zxQqa50Su05pPOleJDHWkP8Anpl/8wEvj6SdVHTQ9H7UyGZ1MT3iBQO7K+zMP
         jpCvxGd008RBFx/iUePIyDf7XRYitr5DAMFl8OJs2Kpcsr2+Dc0JOSmsPRFz57JEuQbn
         feNltJonvmrpRI6EhQkOqeDTByeJqyENXTUpjYzvhOHardJeINIiBH8c5hxUvvFrzJQ1
         okB5Gk9tw6PY/u1Og87yNr6DeN4z1oDO3WAdsUuyExpw7ay4+am6+k6SVPvELXLntFSW
         yu3jSwhN46eOapuB6pc5WRgOvWaq8174rOV7V4HKf+j/MMLDPd9FZhAznPOSZUtyM9y4
         9sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NcUsbvBprZC4KLkxAbAkQP5yLWOyRtOSgcO75BCVsCA=;
        b=RFNHA1RddtrVkQ4dBGzWrjeEnVsmzHZFBLv61N9x2hcQ7h2HQ1TmkXmyGbb6IzvQD+
         uBMwDdruNSS/ou6cwaPrWrkuLzf9x6OysXqPBDVwzRrd76olLpI3ZFpLguBx3WXc5rZg
         4BHQ0MZ4gBX6z1wNzfeRfBHpToF/aG4YiWM8Qrmzg17fMI9YRCrQus7tjhD1NyLGW/km
         J+00g6AjEXzQvB+5qHeNP/OvWUr2I9oQ4KbEXZc5KQsCZ+0Ak9VKzhQiyB1GQoaPOjAE
         kEHwNIGt2pG6rqfr3VNpnuEGloCzstbnaXyH1xk7vJabioztOpJlSfXv4WRyQnDiavb7
         V17g==
X-Gm-Message-State: AOUpUlEGPSvFLV7qJ5djS/BDC0c7KcDskqXeKtlL2GXUSqHA76SVbvbx
        WfwWqnF2614R8mKPYlEKfsevRCW2
X-Google-Smtp-Source: AAOMgpdnGQxOXOojZY9pzNMt3jEX9R13TJfVK7lvLC5ZLkfBeZM1M3FUFHfiOV6o03PGC7jJyDePLA==
X-Received: by 2002:adf:fb43:: with SMTP id c3-v6mr5372514wrs.32.1531936573300;
        Wed, 18 Jul 2018 10:56:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 67-v6sm3106345wmg.34.2018.07.18.10.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:56:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/4] Use oid_object_info() instead of read_object_file()
References: <CAL21BmkBohTOVdCO_ENVfzL28aRjoh1MCCF6750AQEYsc7L54w@mail.gmail.com>
        <CAL21BmmwRDwWc_4JmFKMA6ZYcx=A4biG+tmrBHPRNAxpSkt_NA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1807181413200.71@tvgsbejvaqbjf.bet>
Date:   Wed, 18 Jul 2018 10:56:11 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807181413200.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 18 Jul 2018 14:13:54 +0200 (DST)")
Message-ID: <xmqqpnzkjumc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Olga,
>
> On Fri, 13 Jul 2018, Оля Тележная wrote:
>
>> 2018-07-09 11:27 GMT+03:00 Оля Тележная <olyatelezhnaya@gmail.com>:
>> > Hello everyone,
>> > This is my new attempt to start using oid_object_info_extended() in
>> > ref-filter. You could look at previous one [1] [2] but it is not
>> > necessary.
>> >
>> > The goal (still) is to improve performance by avoiding calling expensive
>> > functions when we don't need the information they provide
>> > or when we could get it by using a cheaper function.
>> >
>> > This patch is a middle step. In the end, I want to add new atoms
>> > ("objectsize:disk" and "deltabase") and reuse ref-filter logic in
>> > cat-file command.
>> >
>> > I also know about problems with memory leaks in ref-filter: that would
>> > be my next task that I will work on. Since I did not generate any new
>> > leaks in this patch (just use existing ones), I decided to put this
>> > part on a review and fix leaks as a separate task.
>> 
>> UPDATES since v1:
>> add init to eaten variable (thanks to Szeder Gabor, Johannes Schindelin)
>> improve second commit message (thanks to Junio C Hamano)
>> add static keyword (thanks to Ramsay Jones)
>> 
>> >
>> > Thank you!
>> >
>> > [1] https://github.com/git/git/pull/493
>
> Could you please populate the description of that PR so that SubmitGit
> picks it up as cover letter?

Thanks for suggesting that.  Yes, an updated version of a series,
even if it is a small one with just 4 or 5 patches, becomes much
easier to read with a well-written cover letter.
