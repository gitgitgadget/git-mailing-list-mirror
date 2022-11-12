Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C795C4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 17:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiKLRTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 12:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLRTY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 12:19:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA3110B6A
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 09:19:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a13so11745305edj.0
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P/B4cgR/uxKL9Wo46jX8QV6EXjrqYsDXSsAjCh12NAI=;
        b=aO725adKnWI5C+CSkg7vrhbTN7khxF448IOost7cUBzNcx8U5R0sIhmRuOerKeuXGg
         8YrIJH+AgMg80RB2q52MkALmbrlwYwhyL2nGYiKuRzsViRAifDBdmQQ59hW/M0cChndM
         /CcqdkvxEbi9Gdc09UHnzRSmzpFHuPSeLXq/55VnMDiYeDfW1QwH5H7T/h4inSY8OzHz
         OrSB1i1noOvk7b+HxEv56CAscX29h++x4iB8cgZNwRcjo7staAz2FfyFDDUdgcz8Kq4M
         fEWALXz5/yfLEK876aEHEsWjJyc7jBP1PaiCvxXycw2NGfC4VcJ2R0amCcHOGl8JKeDR
         9U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/B4cgR/uxKL9Wo46jX8QV6EXjrqYsDXSsAjCh12NAI=;
        b=5382N3LyqlNR4Idivcviq+O5qaTIsAyARJTFCXyW5NLU923+4TqqrgeHfmyidmmne7
         QjTNEiRYQzWpdgmS87SnmB3hmDEkt1Hh5Vd9Qde/tyYCc0jJjmx+F/UGcUNalakc8aMu
         cXUbfhoH7zT+PJvF+uxIwH3NPAsjC4El1iHDxMkV1rfISVI0jTThjlZl5S0Nw9AOCpsP
         l7JYSgMTvvLN/LlfWyQJZ5jhCe0XUyrCN9bU5700HAYY1+lQWOzbZYXsMRTRQNpv7nSw
         JDvJoyuP4Ru4QFJthKLIN9IiwW0MCGSRui+FBF9qzNp4Bs3zVzCoXR990Qahnxqy/1AK
         TPzQ==
X-Gm-Message-State: ANoB5pmsS1GzAyXRKNA1Iw3CKOVXHOATQlGxq8Xpj1vE8ZAsRt3TPP56
        xydXYmUlTgsZ6aQqOczpf0s=
X-Google-Smtp-Source: AA0mqf4rXAXIxhpsDITZAIBtH/DmmlIGc4t8mPLC9ZMupEWAlC6zqqXSelP8tZ8CUYuT5Rk6fXRfXQ==
X-Received: by 2002:a50:fb01:0:b0:459:cdb:92ad with SMTP id d1-20020a50fb01000000b004590cdb92admr5931735edq.77.1668273561393;
        Sat, 12 Nov 2022 09:19:21 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b007ae0fde7a9asm2043387eja.201.2022.11.12.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 09:19:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otuA2-002G3g-2e;
        Sat, 12 Nov 2022 18:19:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/13] parse-options API: don't restrict
 OPT_SUBCOMMAND() to one *_fn type
Date:   Sat, 12 Nov 2022 17:55:52 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
        <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
        <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
        <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
        <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
        <25776063-a672-fc65-bed3-1bc8536ab8b3@web.de>
        <221105.86o7tlvxh0.gmgdl@evledraar.gmail.com>
        <46ee3f92-943f-10d5-7ec5-c68f1ced87ce@web.de>
        <221106.86k048w2f4.gmgdl@evledraar.gmail.com>
        <36337a3f-6443-f272-09f0-7ddb3c20d7a4@web.de>
        <Y2/LF/qiZI99YuxM@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2/LF/qiZI99YuxM@coredump.intra.peff.net>
Message-ID: <221112.8635aom6p5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 12 2022, Jeff King wrote:

> On Sat, Nov 12, 2022 at 11:42:09AM +0100, Ren=C3=A9 Scharfe wrote:
>
>> > E.g. we have plenty of code that assumes ASCII, instead of catering to
>> > EBCDIC, and assuming NULL is (void *)0, not (void *)123456 or whatever.
>>=20
>> NULL is defined as "0" or "(void *)0" by C99 6.3.2.3 Pointers paragraph
>> 3 and 7.17 Common definitions <stddef.h> paragraph 3.
>
> I think he is alluding to the fact that while the standard requires that
> a "0" constant refers to a NULL pointer, the representation does not
> have to be all-bits-zero. So:
>
>   char *foo =3D 0;
>
> is fine, but:
>
>   char *foo;
>   memset(foo, 0, sizeof(&foo));

Yes, to elaborate: the "null pointer constant" referred to in 6.3.2.3
deliberately leaves room for the representation being unequal to the
"all zero bits". And as you point out the former example is portable,
but not the latter.

> is not. And we absolutely do the latter in our code base anyway, because
> it's convenient and unlikely to be a problem on practical platforms. And
> I think it has always been our attitude in this community to let
> engineering practicality trump strict adherence to the standard. But
> "practicality" there should be measuring the tradeoff of how useful
> something is versus how likely it is to bite us.

All I've been trying to get across in this sub-thread is that there's an
interesting empirical question here: Are we in fact targeting an
architecture where J.5.7 isn't implemented, or likely to have one sneak
up on us?

I don't think so, and timing-wise deciding to be paranoid about this
particular thing would leave that question unanswered, when all we have
to do is wait a bit (some of the slower platforms tend to be a few
releases behind).

The argument for the change[1] (further articulated upthread) hasn't
answered the "do we target such an arch?", but seems to just fall back
to general standards paranoia.

Which isn't an invalid argument in itself. But doesn't really address
why we'd be worried about *this* particular thing, but not e.g. those
sort of memsets, assuming ASCII ordering for 'A'..'z' etc.

> In the case under discussion, my gut feeling agrees with you, though.
> I'm skeptical that equivalence of object and function pointers is all
> that useful in practice. And your mention of CHERI seems like a
> plausible way it could bite us.

I think the post-image of [1] looks nicer when reviewed stand-alone, so
I'm not against the change per-se, I actually like it.

And I don't have a use-case for using that feature further, in a way
that isn't easy to do differently.

But e.g. now we're having a parallel discussion about using some 3rd
party bitmap library. We might e.g. want to incorporate some 3rd party
JIT or whatever in the future. If we run into this question again it
would be nice to have it answered already.

And if we didn't have this J.5.7 reliance in that code already I don't
think it would be worth the effort to introduce one as a test
balloon. I'm only saying this in the context that we already have one.

1. https://lore.kernel.org/git/c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de/
