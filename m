Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587211F954
	for <e@80x24.org>; Tue, 21 Aug 2018 21:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeHVBOn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 21:14:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52666 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeHVBOm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 21:14:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id y139-v6so224520wmc.2
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NQSn+Ju/aNTr6X9s12sC01o1bIyy7kxODwk8UZTQfLg=;
        b=SA80S87oQWdOmT/V+7mlaZW4+unUNyhKK7FCfYIIfKrqchQAd4mfJyfINUovNKuEAS
         C3qlVRX2i8Emtfu9bimrMxAZzFGa4s3qK+FBzVsXLr21QVMBn0SZAWe/hZuBiUnVrKlK
         js/5bu8dTwE4bQaFGeKNV8UD8qmgHdJIxof0thPIbJMsvcOAof3vIEHqZK3CndyBW80z
         EIRZNaEwcl+Cu6UW8xC3foLX2sq18e4uVnm3h4Cn+YpI8j0OCq8GSvEZKTyHH5dFuoi8
         LwHFqCXU7DqxguCY9y7K1SpAbdzPhu8GjU/UQvckjoS2Iq1HuPKj5CSt9v5wUOPKlqIi
         0S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NQSn+Ju/aNTr6X9s12sC01o1bIyy7kxODwk8UZTQfLg=;
        b=pLoOOdkUrF8YgBFbk/qvWroWnCP6jmwqWwPWyEyH1S5dqOpOTa1S+oAopFcTi4fEMs
         AcYCjWy+Mud9/f6/GO3bl+rK6Zw5GchBLfqPlYpmyArfc5iyRIF7XwM+0JFRT+8JVELL
         nhoHcHh3he/DanIl1a6syxa5ozqGlBmORdH7w2L45XKa5iRkU5fIZR48wFHC14yvebbI
         zEtfubmJi5/Bm9J5teFdGM+K4YLEbj0F3FRcdGY1yRQ5Vo0/cTewvRHU4EyCLjMkaCHt
         OOsigjGs2xYfYTPHzek0dKSUtvWNxuowRY7QiQUCLEGf5EbBHGkJEXHZyxgd+Yf+IWAc
         SI0g==
X-Gm-Message-State: APzg51CqO9Pl3zUVyAZW26Ys/TnFK7UL60neymWybxQgj2zWe7lBfF+y
        szu8tg2j0pbZi6zB4NoPQnI=
X-Google-Smtp-Source: ANB0Vdas6mRvrVtoAotLkILosCdixQnyx8P4pZw/88ZTH6XU0XSmo4mbw3JytiGr1uxmmHqtv7ViAA==
X-Received: by 2002:a1c:3351:: with SMTP id z78-v6mr695111wmz.23.1534888366632;
        Tue, 21 Aug 2018 14:52:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j133-v6sm472989wmd.12.2018.08.21.14.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 14:52:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can use bitmap' test
References: <20180814114721.25577-1-szeder.dev@gmail.com>
        <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
        <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com>
        <eeb04c94-50c1-13ee-880b-ea380031a685@gmail.com>
        <xmqq4lfsbvru.fsf@gitster-ct.c.googlers.com>
        <73346b91-6d19-651a-c361-1666a39681f0@gmail.com>
        <20180819203253.GA5789@sigill.intra.peff.net>
        <aedb7f33-65cc-5d63-4e7e-dd5f37831e19@gmail.com>
        <20180819214334.GA2626@sigill.intra.peff.net>
Date:   Tue, 21 Aug 2018 14:52:45 -0700
In-Reply-To: <20180819214334.GA2626@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 19 Aug 2018 17:43:34 -0400")
Message-ID: <xmqqh8jn75g2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > If we assume that "expect" is first (which is our convention but not
>> > necessarily guaranteed), then I think the best logic is something like:
>> > 
>> >   if $1 is empty; then
>> >     bug in the test script
>> >   elif test_cmp_allow_empty "$@"
>> >     test failure
>> > 
>> > We do not need to check $2 at all. An empty one is either irrelevant (if
>> > the expectation is empty), or a test failure (because it would not match
>> > the non-empty $1).
>> 
>> ... this is indeed a better solution. I written out the cases for
>> updated test_cmp to straighten out my thinking:
>
> I'd be OK pursuing either this line, or what you showed originally.

As I do find [1] to be a real concern, I'd prefer not to flag empty
input to test_cmp as special.  But if we _were_ to do something, I
agree that "$2 can be anything---that is the output from the
potentially buggy program we are testing" is the right attitude to
take.

[Footnote]

*1*
https://public-inbox.org/git/CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com/
