Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA3601F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934419AbeGJP6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:58:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44225 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933846AbeGJP6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:58:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so15185483wrt.11
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s3MoynEU7fbwg4CnHSGIUmJ4LnZ1C3gU16XAnjQDXoU=;
        b=C8NmyxIZ4I3zLOQhWJqSP9ApsnUkZ45LbniL8OH45+eSKMe2DtX8ahOFnm384mEDmn
         fJOJasNLZuluxhB/bIDgDmQwd45yZNsmflycWxlUF0AGt/K+SIy0YWUiEFr+T6NDGc8Y
         qykO/mfuMqoEMtLUcKKeOdE3W9l7Inpbxq9UJXfRiuA+aFJRhO/RMG4wQS21EOlk5jP1
         YHblelritU0MuNYRwVwU54g64n8zTdj3aqewaTj8QTYS9XaaSyui5K+jl7W+7WHE1BCZ
         tk/sIsZ4G/FMq3yozqlWKVHj4+LU8803nvf9G6bxrB22fg4UfsoE8d54Dishp2OPVkTo
         /mOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s3MoynEU7fbwg4CnHSGIUmJ4LnZ1C3gU16XAnjQDXoU=;
        b=bAz6InAI6Ak/9hx3UBk04aDjAAfJEvF180XDkpbMXUDowxJpAeDkWXl2PMWKsamaXP
         oWh8GoHthhfCFHgzrX6qcWIgJCgmBZwgn04UoF6OoPABOmhL6W5hUQzBxpLitopVK44t
         iHcjrRrajCOt+A0GzvA3vdoq6C8i6YHrPIxZCjovXCDMV1eK+FaBjifH+SAayvCkvP7x
         SoVcvmuiNrertKbMJP6NL1Wz37sR6503jh2gPwN1ABHfwXHJYv9hSkIcCZhxjRbZ+Tyg
         GBZBQGhT024mFDAFGH//p3cHMPrM3PYBvGkvh12tMQYT5MfpNwvgjLd0drVYPSgl0rfy
         9WqA==
X-Gm-Message-State: APt69E09u5ERaJ3MH58dwyv+JzNEg/crxkXFwwVboSfJSumhmnHVRE+x
        OMoeKCyVp5/YjTXpgY59xhQ=
X-Google-Smtp-Source: AAOMgpf64FDXjcZbtA+9bq1aC2DuMdzo97M/IJPwXkbYKw5oSFi29nCcWuc5yNc4d7RFnxkZWtFZUw==
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr20315541wrd.176.1531238313488;
        Tue, 10 Jul 2018 08:58:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b6-v6sm37163543wru.66.2018.07.10.08.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 08:58:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Henning Schild <henning.schild@siemens.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/8] gpg-interface: introduce an abstraction for multiple gpg formats
References: <cover.1530616446.git.henning.schild@siemens.com>
        <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
        <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
        <xmqqa7r4mg45.fsf@gitster-ct.c.googlers.com>
        <20180710153724.GA23438@sigill.intra.peff.net>
Date:   Tue, 10 Jul 2018 08:58:32 -0700
In-Reply-To: <20180710153724.GA23438@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 10 Jul 2018 11:37:25 -0400")
Message-ID: <xmqqin5n9j6f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 06, 2018 at 10:24:58AM -0700, Junio C Hamano wrote:
>
>> What we've been avoiding was the comma after the last element in the
>> enum (in other words, if PGP_FMT had ',' after it in the above
>> quoted addition, that would have been violation of that rule), as
>> having such a trailing comma used to be ANSI C violation as well.  I
>> do not recall offhand if we loosened that deliberately.
>> 
>> 4b05548f ("enums: omit trailing comma for portability", 2010-05-14),
>> c9b6782a ("enums: omit trailing comma for portability", 2011-03-16)
>
> I think we accidentally did a weather-balloon in e1327023ea (grep:
> refactor the concept of "grep source" into an object, 2012-02-02).
> It's still there and nobody has complained about it yet.
>
> So I think we can consider that requirement loosened at this point.
>
> -Peff

Yup, thanks for digging it out.  It seems that I did the same
digging some time ago but forgot about it.
