Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54CA1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 04:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbeDJEN1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 00:13:27 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:43325 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeDJEN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 00:13:26 -0400
Received: by mail-qk0-f179.google.com with SMTP id v2so11970538qkh.10
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 21:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8pFFTMQkHuijfqUBlBDo/ZU6kPxtgiJx0fY2dVAyWTY=;
        b=e+j2RPVfSo0L3/77R57Gy2kYt8IKP2uHG+kz16+2tF3/OgAYQ/eceZSo3YrIERXCcv
         2lW7iaLGhmOhaOf+5PCHL7lsl5d0BKlIWo7BurzukJUX2iniS3LpIUS2XoVxpbiKskI+
         e4oJEDrUODyvO6NyTEepsfRpphhxqw9cns2EaFKtqpHtfuFprkMkVyGvvGQAHbEZ60i2
         JO1H2hdox0Gx6pBZFBk1U3Gfb6tCRu34bWg/h0ynbjAH0az21OkRbbfhG39SDD72Af7/
         SH2IgibvJZVWeturwtbuDPoxEntxjK/8N2k6K16JkZAKJROrOia5FOZ6xouNYG7VCYLu
         GrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8pFFTMQkHuijfqUBlBDo/ZU6kPxtgiJx0fY2dVAyWTY=;
        b=uO2mpaVCCf2LuRHKgTZ8q0kfGwLfQILXrqp0Zw5JAfX69UCx2Tnm/by9q2WoE1cJZD
         5qiqdgZ+HCedsnbLN5ekpwAI18BvOPgWikZm/cKWqn/zg5wjJBDGBvQ7I20ntfrQQ8Gk
         scusdbnIeAXLdz/kChH5YqH2zoxxHAzhvVt4Nse8IOWBa0F3yAZxMWWOnnisx/Un8I8R
         WTV7vLZfFBrce0GmDkRgM6G/b8nSfjtA5Raiaayts5usRwBs5KpamSkU3HXX6SKwBlKF
         hPYni0X6KFcLmAkHSUMKYg9tqaAtF4Zx6tMIo1+ujWmPI1EV5NdPPXxvhhWpdbsnX46u
         LZ3g==
X-Gm-Message-State: ALQs6tAXQPJVa23wrHJ1lL9v/NF/gaaxRWPVjapW/JWmW9QfB5wFvj3u
        9yyahwFkNeNdsN3LUtnix7IU1CKtxNYe5Bqb9LA=
X-Google-Smtp-Source: AIpwx48Cvh1wizsJnJNBykeju3KZYUP/mZ0QabWF7nsAlb9xkGDtN16b7+PzCIQBAmQ4RKMtfAKKJvAs6gNAvA4uGY4=
X-Received: by 10.55.3.140 with SMTP id 134mr53953037qkd.26.1523333605539;
 Mon, 09 Apr 2018 21:13:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 9 Apr 2018 21:13:24 -0700 (PDT)
In-Reply-To: <20180410021253.GA937@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com> <cover.1523313730.git.me@ttaylorr.com>
 <20180409224654.GB34547@syl.local> <xmqqy3hv4zzi.fsf@gitster-ct.c.googlers.com>
 <20180410021253.GA937@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 10 Apr 2018 00:13:24 -0400
X-Google-Sender-Auth: UZzwgKN2kWacW7fDrBp4u4syL44
Message-ID: <CAPig+cT4mRQpvF4qNWOoVs-+94Bpg9ZJ3QnxZ4KF7HcKm-cUKQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] builtin/config.c: treat type specifiers singularly
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        ericsunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 10:12 PM, Taylor Blau <me@ttaylorr.com> wrote:
> On Tue, Apr 10, 2018 at 10:22:25AM +0900, Junio C Hamano wrote:
>> I suspect that it may be OK to switch to last-one-wins, but then we
>> should give a justification that is a bit stronger than "we want to
>> avoid complaining against --int --type=int" (i.e. "we want to switch
>> to last-one-wins for such and such reasons").
>
> I think that the major justification is to treat --type=int as a _true_
> synonym of --int, such that neither `--type=<t1> --type=<t2>` nor
> `--<t1> --<t2>` will complain. This, as well as the fact that
> OPT_SET_BIT brings us closer to the semantics of `--verbose=1
> --verbose=2`, which is something that Eric had mentioned above.

I'm probably being dense, but even after reading this paragraph
several times, I still don't have a good idea as to what it is trying
to say.

As for my earlier reference to '--verbose=1 --verbose=2', that was
cited merely as a "last wins" which I could buy; it was offered in
contrast to '--type=bool --type=int' "last wins" which this patch
tries to sell, and which I have a tough time buying (though I defer to
Junio's and Peff's judgments).

This patch (or perhaps its commit message) seems to conflate two
independent goals. (1) ridding this code of OPT_BIT() since its use in
this context is not very sensible, and (2) trying to sell "last wins"
(for a not well justified argument) to support '--int --type=int'
without complaint.

Goal #1 makes plenty sense; no objection to that. Goal #2 isn't so
obviously desirable (I already raised objections to the more general
'--bool --type=int' "last wins" it implements).

> I think that OPT_CMDMODE would not work quite in the way we desire,
> since the error messages would not quite line up with the command typed.
> For instance, after applying the following diff:
>
>      OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
> -    OPT_SET_INT(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
> -    OPT_SET_INT(0, "int", &type, N_("value is decimal number"), TYPE_INT),
> -    OPT_SET_INT(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
> -    OPT_SET_INT(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
> -    OPT_SET_INT(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
> +    OPT_CMDMODE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
> +    OPT_CMDMODE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
> +    OPT_CMDMODE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
> +    OPT_CMDMODE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
> +    OPT_CMDMODE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
>
>   ~/g/git (tb/config-type-specifier-option!) $ ./git-config --type=int --bool foo.bar
>   error: option `bool' : incompatible with --int
>
> Whereas I would expect that to say:
>
>   error: option `bool' is incompatible with `--type=int'.

Couldn't you achieve reasonable output (such as "error: conflicting
types requested: %s and %s") by handling all those --<type>s with a
custom callback? You've already coded such a callback for
--type=<type>, and it doesn't look like it would be much more effort
to refactor it a bit to handle --<type> as well.
