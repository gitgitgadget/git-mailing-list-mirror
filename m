Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF461F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDCSoV (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:44:21 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43035 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDCSoU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:44:20 -0400
Received: by mail-yb0-f195.google.com with SMTP id z5-v6so6627076ybo.10
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/24fdzE3jHhQMj1KpNZv6u1DMttyfkCOVvNSsmUnpN0=;
        b=k4Lo1DfTjtMq5auUdEJd3vDGTU4gvveFFf3CfSLisxv3p88ldqwaKmb03F4hCsRiJM
         mA2JkeVqZwJ0FcF0d4kbtkusMzNWoBbswf4uhzBA4zrvZIy42aixYWmJGN47bR9O1AmL
         kRjGeqEi5b/dzsfH2Fozm7X515adIvkkD5nwrAkO7iM+b9i/xVATxQejb6KAeAJRsVJZ
         w//07XwqDHpVdy5sfZHZ02TIDuNiIg7zaeR5r1bI4aPPy6OHThRg9PPqvTHWXn72HS5F
         u/lNsYFIEuZTxnVfEXhKlkxnZiOz1RDkRV+Z9VWBN8Q0CuAUiALJHKXEgGi2o/UVqbZJ
         KVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/24fdzE3jHhQMj1KpNZv6u1DMttyfkCOVvNSsmUnpN0=;
        b=YNt32qJxdoE1OrpQ0aktMMgk4jzW6Mm12xR6Db0ksDfENektqfU6bptDHi2d6xjEzu
         gVwsxZi3ZCIVjbGkkLPKG/kBi24VRJ7nmGxyGXcOGfmWY5BLyDaBDkqaAoxs0YrO+ota
         QhhQjHdku8A8EjIDnpp6dbVWN4cVvpOlM+mfFPFxfo27JBNdP50CmG9OiyY1FGTfz2Hw
         S3ztpwXfc5Nq/mhUXmyeDdKYIXUYOa7amhIJPqmHkZcRM/Y1FaTkH91HL5etR7MYKFCT
         3ONDGxelgZAcV82FO9q/N9MwZQeeIYbcPEZ13awOK1yy4L685WIGSeqVY29Z6g/OPSmN
         klmQ==
X-Gm-Message-State: ALQs6tCs0FCTfLJvfNU4YrPw2kfAFg41q0s0x4Zvz8yUBlsskTHcF7HE
        oB75IgKFg/8nvfK2A/6X5FA5z1MjJNOtu/KtydlUWI8f6cA=
X-Google-Smtp-Source: AIpwx4/ioeFQIbX4EzbCDu20kUQ+HrFKfqccd+Pm2esFa/onalEqzPzjwzeRc+r2R/HzHTaNWWUqFDftU3/pZieGws4=
X-Received: by 2002:a25:493:: with SMTP id 141-v6mr8797974ybe.247.1522781059951;
 Tue, 03 Apr 2018 11:44:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 3 Apr 2018 11:44:19 -0700 (PDT)
In-Reply-To: <20180403182800.GA8377@sigill.intra.peff.net>
References: <20180403165143.80661-1-dstolee@microsoft.com> <20180403165143.80661-3-dstolee@microsoft.com>
 <20180403180536.GB100220@google.com> <20180403182800.GA8377@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Apr 2018 11:44:19 -0700
Message-ID: <CAGZ79kYeKmWidi0SqV_R6NhWrH1rT-rTXetRfZ_YBpycieFxgw@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit: add generation number to struct commmit
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 11:28 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 03, 2018 at 11:05:36AM -0700, Brandon Williams wrote:
>
>> On 04/03, Derrick Stolee wrote:
>> > The generation number of a commit is defined recursively as follows:
>> >
>> > * If a commit A has no parents, then the generation number of A is one.
>> > * If a commit A has parents, then the generation number of A is one
>> >   more than the maximum generation number among the parents of A.
>> >
>> > Add a uint32_t generation field to struct commit so we can pass this
>>
>> Is there any reason to believe this would be too small of a value in the
>> future?  Or is a 32 bit unsigned good enough?
>
> The linux kernel took ~10 years to produce 500k commits. Even assuming
> those were all linear (and they're not),

... which you meant in terms of DAG, where a linear history is the worst case
for generation numbers.

I first read it the other way round, as the best case w.r.t. timing

~/linux$ git log --oneline |wc -l
721223
$ git log --oneline --since 2012 |wc -l
421853
$ git log --oneline --since 2011 |wc -l
477155

The number of commits is growing exponentially, though the exponential
part is very small and the YoY growth can be estimated using linear
interpolation.

In linux, the release is a natural synchronization point IIUC as well
as on a regular schedule. So an interesting question to ask there would
be whether the delta in generation number goes up over time, or if the
DAG just gets wider (=more parallel)

> that gives us ~80,000 years of
> leeway. So even if the pace of development speeds up or we have a
> quicker project, it still seems we have a pretty reasonable safety
> margin.

Thanks for the estimate.
Stefan
