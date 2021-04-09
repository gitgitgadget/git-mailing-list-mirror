Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF8CC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14D96113C
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhDIBdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 21:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhDIBdb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 21:33:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00566C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 18:33:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u21so6048125ejo.13
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 18:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BTJrXoq2sGmTpz5Ic1+KHpJY2e00cbpdnsTP2xZfa2w=;
        b=LCiL55ie0H3/z+5c76u7Kmf55TGwM0VQfXGWOQqf2tnJ1gYxruXreCWIvTSv3bZ9rY
         fhDIy+2p/O+7eXGTBaOb34x1sAm4aum95CE4GdEHB3x1/vLLPZHa4787FOboFeNVP/iB
         y8gZB01BWflCoXLYVLz4+mFByRETwpcNE75rKeeCFCaWF1kRXHNbzDvc+J1co5sXlMqc
         fzD4+R2wEFcTaiOCLTiU0QSvmBCxEoVahvf7MW7zpT3JtIhYhEgG7oZHbWKkiAe6UCYH
         PVWnjZ4zhCruHL9RTM8zAo3JZ3t7uzkZglmM5pkSBU/C9M5IV46eyM0OLV9lOblISZe0
         CnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BTJrXoq2sGmTpz5Ic1+KHpJY2e00cbpdnsTP2xZfa2w=;
        b=bhN9EiMxxJUHR035ZWub30DgFWWpIxxnqYox4M3Q17Ii+XOMGmpazY35oDzrnMp5nh
         5il2yy48yxY6GhA31yuZJAl/fQF30efEreprDUySywZP4z5kaC9vnYx/PTqLC9B7N62T
         /DgWlTq6hCmpHdqaBhUvhHdnJpEymcO0Wdb6msqOBxI6NNNAEtfidGAHU4Xf4AU18hKa
         KSZtTHs2XcpN4j5MOZDpBE5Z7G9aaiA/rAd78LMk3h+EtFeQKWKxrvdO8UzNZrcbFPRr
         nsxSys1RYxZ5eM1d5NqMTli5OkZEiiQ3p9k5q/IH7pYXS5ww6TZHulDv+mj4UdS8yySN
         59IQ==
X-Gm-Message-State: AOAM533qDEffKT4wK4zzq4uvYrG68JqEDZjsrYLGUiPy7rAEsXb9huIH
        hXJRqCTZGHDzoC+/U//QpSo=
X-Google-Smtp-Source: ABdhPJwGDiN6gQxC4d/+bmEHrYDNvBB6aVAM7hpzjGFVbruMRwbluFk62swccrbhb7bQ8Enpssry4A==
X-Received: by 2002:a17:906:14d1:: with SMTP id y17mr13548394ejc.139.1617931997585;
        Thu, 08 Apr 2021 18:33:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d10sm523284edp.77.2021.04.08.18.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 18:33:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6BuIFRy?= =?utf-8?B?4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
 <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
 <xmqqa6q8tymu.fsf@gitster.g> <875z0wicmp.fsf@evledraar.gmail.com>
 <xmqqtuogpc6f.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqtuogpc6f.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 03:33:16 +0200
Message-ID: <87o8eogs2r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 09 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I'd prefer to just make these "enum", which means we'll have the aid of
>> the compiler in checking all the callsites, as in the patch-on-top
>> (which I can squash appropriately, need to update the doc comments
>> though) at the end of this E-Mail.
>
> I think enum is oversold by some people (not me).  C Compilers won't
> do much when you use them interchangeably with int, simply because
> they are designed to be used that way, no?

They are just ints, not a seperate type like in C++.

> If existing code used 0 as false and 1 as true, and it learns an
> "auto" value with a new definition,
>
>     #define TRISTATE_AUTO 2
>
> without TRISTATE_{TRUE,FALSE} defined to 0 and 1, that would be a
> good place to stop.  I'd be quite happy with that.

The benefit in this case is to human readers of the code who know
they're being helped by the enum checking in "case" arms.

So you can immediately look at code like:

    enum foo x =3D git_config_foo();
    switch (x)
    [...]

And know without having to jump to the definition of "git_config_foo()"
that all the return values are being handled.

Just to clarify, do you have a dislike of the sort of code in
http://lore.kernel.org/git/875z0wicmp.fsf@evledraar.gmail.com for all
uses in the codebase, or in this case because the diff of adapting
existing code is larger as a result?

I think if we're not going to use enum/switch for this and similar
things in config.c in the future it makes sense to pass a pointer to a
"is_auto" parameter to these new tristate() functions, similar to
e.g. the existing git_config_bool_or_int().
