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
	by dcvr.yhbt.net (Postfix) with ESMTP id C25DD1F462
	for <e@80x24.org>; Wed, 24 Jul 2019 18:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfGXSWx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 14:22:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37949 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfGXSWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 14:22:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so13141033edo.5
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=m77PfaQIwoz38dPvYixi2CJQGiGbgbvFHoImka8VPa0=;
        b=G9uuH2ft1qa7jsiRiRZoNl1h6CUIMYn9M/ezdebzyoU0eG+g5R7+1nviEFAZBOG3zp
         fS4SQEyCofax2//41ObnPvEyFWEExjFRXbFDgv2Wh04mqSO+GEazpL6ElN8iWIaAP0Tg
         KO/V//uIB7AjDkWCztCfM/ZXdMTI7iyc20+Ze7eTUrH6nBIRqBVyzzVm4kKtwAuOowzo
         megfJbSlpysyZZpN/CjwZ715zGZ609XuWWElwxyk4gp/KfKYWqEqzFV37okTOeoQIPL/
         6NDvVATybqz4XMFPc4Spk3M6gQMbJCljsp4MrLL6RYSFXpDbiBN00mvUKYobt93d297Z
         Pm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=m77PfaQIwoz38dPvYixi2CJQGiGbgbvFHoImka8VPa0=;
        b=lPS3iLdg6EIxjEJ5CB6KNpVyKnD42Yx8jBgmEYNXdI3YR2MGisSsoWbqDZyghy4jlG
         q+8mJOgvll6ksTtB3Q7h5QpomiN0hJDkpgypNXA5z4ggX1rKc7xFqbRHnkpkgey9ZFwm
         kBykshbPPE5EGJlOPLBggSwuU8cqG+F11TId9/2xRYwZhDNb0FSMqRNpAgW0Sc5XlkeL
         QHoSS8mvV8JTMi4OcFJCMjHkbOisL0CIFk8AfrMeGj2ldFz06hLdXeIyq2aP0VNpGfXb
         8YLjkNu5kZ41C9/f/LaUCP6pkxr25YbVv/1rviIPHpmgOifJvOWvOpEKNmujbvwHpyLB
         iL/A==
X-Gm-Message-State: APjAAAURYFTu4Z/fEZmcc0kkWbmqq3/KW/Vkgn7pry6cNKviFfb2cyex
        NJ3DzXwePn+q3Wys4RsSIcPMmaRb7lA=
X-Google-Smtp-Source: APXvYqxRuAALqvaGnRpojaKBboxm+NgW/8skoQdMf9TM2Ks3Hvb1fRKLfeiXJ19n0kN24ZY3IEbNiA==
X-Received: by 2002:a50:b3b8:: with SMTP id s53mr72636992edd.61.1563992571022;
        Wed, 24 Jul 2019 11:22:51 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id b15sm9426601ejp.7.2019.07.24.11.22.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 11:22:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet> <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com> <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet> <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com> <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet>
Date:   Wed, 24 Jul 2019 20:22:48 +0200
Message-ID: <87lfwn70nb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 24 2019, Johannes Schindelin wrote:

> Hi Carlo,
>
> On Tue, 23 Jul 2019, Carlo Arenas wrote:
>
>> On Tue, Jul 23, 2019 at 5:47 AM Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > So when PCRE2 complains about the top two bits not being 0x80, it fails
>> > to parse the bytes correctly (byte 2 is 0xbb, whose two top bits are
>> > indeed 0x80).
>>
>> the error is confusing but it is not coming from the pattern, but from
>> what PCRE2 calls
>> the subject.
>>
>> meaning that while going through the repository it found content that
>> it tried to match but
>> that it is not valid UTF-8, like all the png and a few txt files that
>> are not encoded as
>> UTF-8 (ex: t/t3900/ISO8859-1.txt).
>>
>> > Maybe this is a bug in your PCRE2 version? Mine is 10.33... and this
>> > does not happen here... But then, I don't need the `-I` option, and my
>> > output looks like this:
>>
>> -I was just an attempt to workaround the obvious binary files (like
>> PNG); I'll assume you
>> should be able to reproduce if using a non JIT enabled PCRE2,
>> regardless of version.
>>
>> my point was that unlike in your report, I didn't have any test cases
>> failing, because
>> AFAIK there are no test cases using broken UTF-8 (the ones with binary d=
ata are
>> actually valid zero terminated UTF-8 strings)
>
> Thank you for this explanation. I think it makes a total lot of sense.
>
> So your motivation for this patch is actually a different one than mine,
> and I would like to think that this actually strengthens the case _in
> favor_ of it. The patch kind of kills two birds with one stone.

This patch is really the wrong thing to do. Don't get me wrong, I'm
sympathetic to the *problem* and it should be solved, but this isn't the
solution.

The PCRE2_NO_UTF_CHECK flag means "I have checked that this is a valid
UTF-8 string so you, PCRE, don't need to re-check it". To quote
pcre2api(3):

    If you know that your pattern is a valid UTF string, and you want to
    skip this check for performance reasons, you can set the
    PCRE2_NO_UTF_CHECK option. When it is set, the effect of passing an
    in=E2=80=90 valid UTF string as a pattern is undefined. It may cause yo=
ur
    program to crash or loop.

(Later it's discussed that "pattern" here is also "subject string" in
the context of pcre2_{jit_,}match()).

I know almost nothing about the internals of PCRE's engine, but much of
it's based on Perl's, which I know way better. Doing the equivalent of
this in perl (setting the UTF8 flag on a SV) *will* cause asserts to
fail and possibly segfaults.

It's likely through dumb luck that this is "working". I.e. yes the JIT
mode is less anal about these checks, so if you say grep for "Nguy=E1=BB=85n
Th=C3=A1i" in UTF-8 mode and there's binary data you're satisfied not to fi=
nd
anything in that binary data.

But if you are I'm willing to bet this ruins your day, e.g PCRE would
"skip ahead" a character 4-byte character because it sees a telltale
U+10000 through U+10FFFF start sequence, except that wasn't a character,
it was some arbitrary binary.

Now, what is the solution? I don't have any patches yet, but things I
intend to look at:

 1) We're oversupplying PCRE2_UTF now, and one such case is what's being
    reported here. I.e. there's no reason I can think of for why a
    fixed-string pattern should need PCRE2_UTF set when not combined
    with --ignore-case. We can just not do that, but maybe I'm missing
    something there.

 2) We can do "try utf8, and fallback". A more advanced version of this
    is what the new PCRE2_MATCH_INVALID_UTF flag (mentioned upthread)
    does. I was thinking something closer to just carrying two compiled
    patterns, and falling back on the ~PCRE2_UTF one if we get a
    PCRE2_ERROR_UTF8_* error.

One reason we can't "just" go back to the pre-ab/no-kwset behavior is
that one thing it does is fix a long-standing bug where we'd do the
wrong thing under locales && -i && UTF-8 string/pattern. More precisely
we'd punt it to the C library's matching function, which would probably
do the wrong thing.
