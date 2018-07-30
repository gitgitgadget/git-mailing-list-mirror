Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 333CB1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbeG3UJA (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:09:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34092 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbeG3UJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:09:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so9056796wme.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xzj//z7eJuCm/tJw0KXWGu6xiXHdWDbmfSmEIJdmqvg=;
        b=KwNlKgAFY47mrwPjTYJ5TO3cxFXv8IBLAJuUqWZtlkwx3XmBax8AZiZgoW2Y0zR9pL
         R6qon/N51+rtyMCx8QR60VOPmt68lMwrFnLnU/ghaX6jtq16BTMQ08SSPM9UpEeTTxO6
         BqC1WveeyjBbKzM+I9Bap+2PZHF6PgiL/cZ9r8c4xIIC71Nn33e203l4K8cS2jTZ8Ckn
         KpEplE9jVuSsWHztlGmJg9TtX4xqMJMwbwKJTCwdnib3fd6uV4i7WTsnOaKfEbULMVri
         kmULbyC+iXzCfQj+r6gwuUxWxjjx+WNOYxYB621rHAcYSmYSY1358osPBiqsP+Bbf+V6
         Mx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xzj//z7eJuCm/tJw0KXWGu6xiXHdWDbmfSmEIJdmqvg=;
        b=E73ED3ieSbEBt03xwnqTSyFHWmDUe7X9Ho0jGI0aRJp9L7/l1vYG37Wg75SNX/g6qH
         2dKou00IknP/XsEq6KSHP5XrYIBqQmQuLRWevmyD06GsUQfF7J9Z6TM79yaQkNV5PIaZ
         lIdAwrzKxJERbDSpGReV1SzKZfa0tQca5oShDYEazx5klLjmvtOBDTTJw7B2wfmigtx4
         kbDTHouycKj3aSMHKMlv9cF3VDdiLB9xmnCtdwsYRwlOPx+gO9Dh0+qeARDLmCVqZKKb
         pE1PYPgkmaavoHDlBR/JtTOwjycqUafcD6Ki0zAy2r4hzGB83lvfjZPAGwUFA/VgTSgx
         tQLg==
X-Gm-Message-State: AOUpUlEyM9BFd3F1G4CJAU9mLlQPOhjHPrCwcKOSNZ3TJ7WqZ2Lrzvp+
        eDPvZI/Oi7LON/XriO3p8vIp1May
X-Google-Smtp-Source: AAOMgpeyq4iRdDBGon1+3r7W18rAxaRg134+0tNkrap1ik6HrDQcIxN3rSAScoEiBRHhILue++bQ2g==
X-Received: by 2002:a1c:5e48:: with SMTP id s69-v6mr258210wmb.19.1532975562966;
        Mon, 30 Jul 2018 11:32:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e7-v6sm25203374wrm.14.2018.07.30.11.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 11:32:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael <aixtools@felt.demon.nl>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: Is detecting endianness at compile-time unworkable?
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
        <20180729181006.GC945730@genre.crustytoothpaste.net>
        <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
        <20180729192753.GD945730@genre.crustytoothpaste.net>
        <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
        <20180729200623.GF945730@genre.crustytoothpaste.net>
        <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
        <87wotdt649.fsf@evledraar.gmail.com>
        <xmqq600wkc4i.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 30 Jul 2018 11:32:41 -0700
In-Reply-To: <xmqq600wkc4i.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 30 Jul 2018 07:54:21 -0700")
Message-ID: <xmqqh8kgfuba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> And, as an aside, the reason we can't easily make it better ourselves is
>> because the build process for git.git doesn't have a facility to run
>> code to detect this type of stuff (the configure script is always
>> optional). So we can't just run this test ourselves.
>
> It won't help those who cross-compile anyway.  I thought we declared
> "we make a reasonable effort to guess the target endianness from the
> system header by inspecting usual macros, but will not aim to cover
> every system on the planet---instead there is a knob to tweak it for
> those on exotic platforms" last time we discussed this?

Well, having said all that, I do not think I personally mind if
./configure learned to include a "compile small program and run it
to determine byte order on the build machine" as part of "we make a
reasonable effort" as long as it cleanly excludes cross building
case (and the result is made overridable just in case we misdetect
the "cross-ness" of the build).

