Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D641F516
	for <e@80x24.org>; Tue, 26 Jun 2018 22:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933907AbeFZWbR (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:31:17 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40300 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933596AbeFZWbP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:31:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id g18-v6so30970wro.7
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PJH4A08vYEgF6GFYPj04ln/+N8MnVEEQHTyEEzoTCJI=;
        b=OnF2mtjdmZohl+nOEd0mUHVVmqGBG6WmFrmkdGp8OAvqqozlrkiCcX7O0ZPcEk1QYq
         xN5/hPqQi9wIGnaB/AO7BJeoVbFXFPxsAYO8B489bZ6AG+dAqc4MxGq1FY3wbdOo8hEv
         j7mFkeC1hQBdfc+rwcPLnFaylHwmcJJFEYaOoywXTksDZGvjWTNDAhYTXYlPA1l5j3p3
         bRjGxIvYDBGd1BEPdebCQDebpWu5levCr0Z30iaOgPjQSPVM7nnQ75o2QIg2ZhlU+4rl
         f6uPa50suhHdKyU0aYGxegGWONylnyvked078tB+bKboFzyxq8Vf0Gt7AFMRsutdVQJv
         rZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PJH4A08vYEgF6GFYPj04ln/+N8MnVEEQHTyEEzoTCJI=;
        b=taYijAwXCKmedcvZ8YKH3BCH2cLIR162EWM/AaBKhLY3xBIp2xctUEkaN2aYISrtXI
         3zrBFp/uxPw7LtCDXTaGKXh9u+ccIdZhfHrnjat8H7EBv3/Qh6YTsvzTOAVKWtC5TjGd
         HrF5MgM2JvA87YA4D2Dg1MlO+ywIdQdyt6ASAZYcDEMIaMeouu5IGqrUxyGDD9s+slZ3
         7QJqdyopRVrJHgGDExDzgWmfqBFex4UGHJDRLxqS3Hq38Uq9sX0sXoGjfi0P7izJzo9C
         KGr0Bu9CmJHG78ljBmLBezsoFEaEqVRSy1KsN+Gm11fo5lLfg4LHg6htrr78CrZ+ACYF
         PtZw==
X-Gm-Message-State: APt69E2qVPdR1RNGg2UDs+yRqqlXEMffIwLSNtrhHy9JB7Mpfh9Ip+2J
        D2AEGdRvB3bpxh9kqLSEoeA=
X-Google-Smtp-Source: AAOMgpf0Uyc9kVBqjV2TgYBba1xfVN1gEAfLsnSQ5/gQLUBOQ5gV/uKayrUVSL5/obc0WtkG/LS4vg==
X-Received: by 2002:adf:b310:: with SMTP id j16-v6mr2818714wrd.207.1530052273299;
        Tue, 26 Jun 2018 15:31:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w126-v6sm3494584wmw.29.2018.06.26.15.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 15:31:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/29] t: detect and fix broken &&-chains in subshells
References: <20180626073001.6555-1-sunshine@sunshineco.com>
        <xmqqo9fxjq39.fsf@gitster-ct.c.googlers.com>
        <CAPig+cSW6jP3FtYpwf5bB4SM=qw6A3K9H3JPranJ_KMqH-AwZw@mail.gmail.com>
Date:   Tue, 26 Jun 2018 15:31:11 -0700
In-Reply-To: <CAPig+cSW6jP3FtYpwf5bB4SM=qw6A3K9H3JPranJ_KMqH-AwZw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 26 Jun 2018 17:25:34 -0400")
Message-ID: <xmqq6025i3io.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jun 26, 2018 at 3:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>> I first looked at 29/29 and got heavily inclined to reject that
>> step, and then continued reading from 1/29 to around 15/29.
>>
>> I like these earlier changes that fix existing breakage, of course.
>> I also like many of the changes that simplify and/or modernise the
>> test scripts very much, but they are unusable as-is as long as their
>> justification is "chain-lint will start barfing on these constructs".
>
> Sorry, I'm having difficulty understanding.
>
> Are you saying that you don't want patches which exist merely to
> pacify --chain-lint? (For instance, 2/29 "t0001: use "{...}" block
> around "||" expression rather than subshell".)

Yes.

> Or are you saying that you don't like how the commit messages are
> worded, and that they should instead emphasize that the change is good
> for its own sake, without mentioning --chain-lint?

Yes, too.

For example, 03/29 is a good clean-up, and its value is not
diminished even if we reject the subprocess munging --chain-lint in
29/29.

As opposed to 02/29 which mostly is about appeasing the "shell
parser" in 29/29 (or you could justify it saying "one less fork and
process" if that gives us a measurable benefit).
