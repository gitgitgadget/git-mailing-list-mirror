Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A9E1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfGZPP3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:15:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33269 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfGZPP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:15:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so53608325edq.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9ZYWe+HQKnhUny2V473i72dXdrvw5Zqwn/FfcjdP6+U=;
        b=ZPTL3t7UJAsOK18XTlooEDeUucAI+Hp7e3EEtvsxoPn3rC/b7oKk4VAePr+gUKQ8zt
         BFiY/1+SHl+ISbtNQXXspamZRudCm6l0s0+2or9WHjnfd3E4s8KhP3x2BcoSfQbL6pcZ
         Ps9sHrDITLoi+dCkJvUrPUcjmOjXAhfVhbeWKWr7LdY23eOZQcDc5febHsCgy0GLaa3T
         0TGl5j18ZUj8KIsWVfddHGPZ5vl2A8Ve2lLEz3Z+SSEXjpQzKi6CmkKl+oar2LHVMG4X
         /UxSiTcXBxC9E4uwSaNFBKulPmYPbqH8MYiWM1MLrH2IbLlepoGtsCo58NdysKgv1eNV
         07Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9ZYWe+HQKnhUny2V473i72dXdrvw5Zqwn/FfcjdP6+U=;
        b=nkEHstB5uj/nrlEY6ofDCcKtcI8t6Il6/HW7D+AeYIA2sF30MSFCACeDKKdAZXinD9
         Akpoz+cb33M5Hs/Gtyn/Om8E/m9Jq/J05wIF7k59w3HoEqSQQbbP5iQ0/ItKyn9I2vqD
         7l8MPyzWSddtHprA4UEmCLAFrguUh2x13cu4G2g6IIJx9Kh/UeVw/saStc2YSo7G1TUJ
         YVeRQmg4eOh4WRma6jB8EAgHvj1H2IwJzFk89ekVVwvo69lChYF+bTLjAqO4eCki011o
         jdkpJBUC3Z9JOSsGpWwXuY9d8CBpwH7jl5qzmhfN9o3X6aprSI0f1vCZLsNgrgIndh5f
         hi+g==
X-Gm-Message-State: APjAAAXzBeWvbr8Gf1u/EzvtwIn3DLlaJYNoJcN6sfUxgpbJjwYtbzRy
        gsrzWG8ClIHRhjcj/q2JhIk=
X-Google-Smtp-Source: APXvYqxp4IFIe+VBU2iYNcHeIYjlCtUiwP0SIFPJZ3nfY6haukPSaS1/a6n5tJ+OK3xhcOFRaQ1k8w==
X-Received: by 2002:a50:9153:: with SMTP id f19mr84383262eda.70.1564154127067;
        Fri, 26 Jul 2019 08:15:27 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id ni7sm7027415ejb.57.2019.07.26.08.15.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:15:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet> <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com> <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet> <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com> <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet> <87lfwn70nb.fsf@evledraar.gmail.com> <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907251143430.21907@tvgsbejvaqbjf.bet> <xmqqlfwmqnb5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907252021230.21907@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1907252021230.21907@tvgsbejvaqbjf.bet>
Date:   Fri, 26 Jul 2019 17:15:25 +0200
Message-ID: <87ef2c7roy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 25 2019, Johannes Schindelin wrote:

> Hi Junio,
>
> On Thu, 25 Jul 2019, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >> OK, in short, barfing and stopping is a problem, but that flag is
>> >> not the right knob to tweak.  And the right knob ...
>> >>
>> >> >  1) We're oversupplying PCRE2_UTF now, and one such case is what's =
being
>> >> >     reported here. I.e. there's no reason I can think of for why a
>> >> >     fixed-string pattern should need PCRE2_UTF set when not combined
>> >> >     with --ignore-case. We can just not do that, but maybe I'm miss=
ing
>> >> >     something there.
>> >> >
>> >> >  2) We can do "try utf8, and fallback". A more advanced version of =
this
>> >> >     is what the new PCRE2_MATCH_INVALID_UTF flag (mentioned upthrea=
d)
>> >> >     does. I was thinking something closer to just carrying two comp=
iled
>> >> >     patterns, and falling back on the ~PCRE2_UTF one if we get a
>> >> >     PCRE2_ERROR_UTF8_* error.
>> >>
>> >> ... lies somewhere along that line.  I think that is very sensible.
>> >
>> > I am glad that everybody agrees with my original comment on ab/no-kwset
>> > where I suggested that we should use our knowledge of the encoding of
>> > the haystack and convert it to UTF-8 if we detect that the pattern is
>> > UTF-8 encoded,...
>>
>> Please do not count me among "everybody", then.  I did not think
>> that =C3=86var meant to iconv the haystack when I wrote the message you
>> are responding to, but if that was what he meant, I would not have
>> said "very sensible".
>
> Okay, but in that case I cannot agree with your assessment that it is
> very sensible.

FWIW what I meant was not that we'd run around and iconv() things, it
wouldn't make much sense to e.g. iconv() some PNG data to be "UTF-8
valid", which presumably would be the end result of something like that.

Rather that this model of assuming that a UTF-8 pattern means we can
consider everything in the repo UTF-8 in git-grep doesn't make sense. My
kwset patches *revealed* that problem in a painful way, but it was there
already.

I'm not sure what a real fix for that is. Part of it is probably 8/8 in
the series I mention below, but more generally we'd need to be more
encoding aware at a much higher callsite than "grep". So e.g. we'd know
that we match "binary" data as not-UTF-8. Now we just throw arbitrary
bytes around and hope something sticks.

> If we're already deciding to paper over things, I'd much rather prefer
> the simpler patch, i.e. Carlo's.

As I noted upthread PCRE's own docs promise undefined behavior and fire
and brimstone if that patch is applied. Those last two not
guaranteed. So we need another solution.

I've submitted
https://public-inbox.org/git/20190726150818.6373-1-avarab@gmail.com/
just now. See what you think about it.
