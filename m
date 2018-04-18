Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459CD1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 01:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeDRBWx (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 21:22:53 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37452 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeDRBWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 21:22:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id f14-v6so241536wre.4
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 18:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vOT3S3k1MObX1mlgvkLRxtyY3z+yVjBcwIPpZpi8uT0=;
        b=Dazohzq2SCZkotmmTufIhU7MbC2I9M7sWVXKF0d0Io+BCUlw0Cg3Ys3K+2ZOyqfUYe
         vlijZQgmwZiCsMBfR6SBMam/nzMgyPKy21/d1hr5fuLxocp53W4ONn02MXml5G0DRVbG
         2EJrbA0Xsv4kmgSNiIT2etTRve+Q4pIdm06b6Ay2Qn8TPITu1eiBzNdjxesyQA1GzgiO
         PdZcYCBYL+VAaVe9XSAXJwqYSwTdmzzssAmbm8s8mU2Smt4tx1sHIvaB488IgTKgO2l2
         zCUexVtUjjP+c0R67wgDCqiBmgj1zBk4HQPSeJIiX/KmgzpL7M4nCHLTqtP093OVfHKG
         oA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vOT3S3k1MObX1mlgvkLRxtyY3z+yVjBcwIPpZpi8uT0=;
        b=aJnlk9tzgP+fIFQJe4HVMfm0DJT2s2llwE6QE9NlP7N1tdy3GzCkdBROQ2ddKroOxu
         yaocG8bZZ+O+seQA2DnVLnsaDdHbBCqbISq9rqe5Dw8GBiN8oLtwYeY+ioEb4KdSzNqQ
         yZtQtzie/xYxMKzSK1w/756gib4/hdVEsvAUIfCkhNwElWAlxxalVau4LUPKc/UoplOo
         AinW7AHLZ3vTGoREVpxrd7Sg8qMvIYaxDUZNnTACfg8CaixNgRiXus6kcPusKLssx9GR
         IKXmJF+xJ6ecGaeu/tJ2seVUdP2jR7YGzCkBQtiJZc0v9cfH1KgBja5wdzVhPo8ugre6
         YmqA==
X-Gm-Message-State: ALQs6tC+nFYcQdTYjZkLPSIuCS6CLekR5cEB03rVJlUyWVpDby1Jycmt
        dqgjtr7h7CmdrXIIEcr3TIA=
X-Google-Smtp-Source: AIpwx4/UmbElKt/ME7DUkqcyK7DtmZ2T97A6mb7+gt0pqIdy2ZBNkwYr82lUWHm7/cc9IA5PDK4sGA==
X-Received: by 2002:adf:90c3:: with SMTP id i61-v6mr32343wri.227.1524014571088;
        Tue, 17 Apr 2018 18:22:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b13sm331355wmi.42.2018.04.17.18.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 18:22:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 01/11] t9902-completion: add tests demonstrating issues with quoted pathnames
References: <20180318012618.32691-1-szeder.dev@gmail.com>
        <20180416224113.16993-1-szeder.dev@gmail.com>
        <20180416224113.16993-2-szeder.dev@gmail.com>
        <xmqq7ep6v6ft.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjk=JtdoduywJ4t5OPhLGgt90yxJA_Zif6R803XHA=Sfbg@mail.gmail.com>
Date:   Wed, 18 Apr 2018 10:22:50 +0900
In-Reply-To: <CAM0VKjk=JtdoduywJ4t5OPhLGgt90yxJA_Zif6R803XHA=Sfbg@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 18 Apr 2018 01:32:43
 +0200")
Message-ID: <xmqqlgdljok5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>>> +test_expect_failure 'complete files - quoted characters on cmdline' '
>>> +     test_when_finished "rm -r \"New(Dir\"" &&
>>
>> This does not use -rf unlike the previous one?
>
> Noted.
>
> The lack of '-f' is leftover from early versions of these tests, when I
> had a hard time getting the quoting-escaping right.  Without the '-f'
> 'rm' errored out when I messed up, and the error message helpfully
> contained the path it wasn't able to delete.

Sounds like we do not want 'f' from both tests, then?  I think it is
OK either way.

>>> +if test_have_prereq !MINGW &&
>>> +   mkdir $'New\034Special\035Dir' 2>/dev/null &&
>>> +   touch $'New\034Special\035Dir/New\036Special\037File' 2>/dev/null
>>
>> The $'...' quote is bash-ism, but this is about testing bash
>> completion, so as long as we make sure non-bash shells won't touch
>> this part of the test, it is OK.
>>
>> Do we want to test a more common case of a filename that is two
>> words with SP in between, i.e.
>>
>>         $ >'hello world' && git add hel<TAB>
>>
>> or is it known to work just fine without quoting/escaping (because
>> the funny we care about is output from ls-files and SP is not special
>> in its one-item-at-a-time-on-a-line output) and not worth checking?
>
> This particular case already works, even without this patch series.

I was more wondering about preventing regressions---"it worked
without this patch series, but now it is broken" is what I was
worried about.

> The problems start when you want to complete the filename after a space,
> e.g. 'hello\ w<TAB', as discussed in detail in patch 5.  Actually, this
> was the first thing I tried to write a test for, but it didn't work out:
> inside the 'test_completion' helper function the space acts as
> separator, and the completion script then sees 'hello\' and 'w' as two
> separate words.

Hmph.  That is somewhat unfortunate.
