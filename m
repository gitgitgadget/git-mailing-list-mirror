Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E8C0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 05:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjG1F0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1F0E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 01:26:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C530FC
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 22:26:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bba7a32a40so13012355ad.0
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 22:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690521963; x=1691126763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VinsfpB2B4vj9pZIzyfHpBkz6a0LfX9Z4m0gpEKItM4=;
        b=RDGsj2j8PRYqEF715zWY/j1nps1NQYzaoqsjjjZOWgoDmvDVM0fXA7H9/+EGg32FNZ
         xO27R+8TqSeopsq2grk/+u5wnn4teuPcfz+NipnnIt+EsQOlxINFBWcqvZt7j+Iso0ud
         D3Qxp/IwgjIRO9kWbEukUGHbD7bh9hr6J3SSO6eL+RrYoExkWwGtAai6IwdknKjkuA0h
         Xy9R8AZ6v3qGGnqzy7p833B+fvJYFjHOa3BHRuHPtEA/4DHvZ9VZ9EZwrBdZ/yT0g2Cl
         s+KaNyz5D116pF/idrmV7nJbr2T42cdAp9e0T5Yc4TR0nrE4WRKtO4PyTpYA9AAvtz3o
         gRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690521963; x=1691126763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VinsfpB2B4vj9pZIzyfHpBkz6a0LfX9Z4m0gpEKItM4=;
        b=iOIiYImD64p1Ieep976oWqBNl3f06LpZB2MzLDDs3SgaVV0vUwW4mDS5RjSIYR3IAY
         ejmkSl3G8wjavVjwnAvOzad3am/Q980wyhU+rmnhvl6IzP9ukv6ptOseazZBetCLTfsX
         Nbk/R9b6cJLQkuvV9T5xJK3CQTDLavtfTR9bcMoFpKN2Xqcb/Eh6ZN48dintz4o0GW22
         HwG6ChfK1iXYyKtT+yw01xjtq8J5krj8BqH9nrfNS73cEFyflDyk/3TkSB2rOsJ7XJlG
         TTll4yGUCg3PRhJNe3yDZP3pXf2CUNzuPKd0VgjjgNu97Joy76FdbXH0oT8k2kmGs9jD
         23aQ==
X-Gm-Message-State: ABy/qLZcoEqtOaM63O9zW/4iwuJwf9avC2SgXOWs0kx2KsDqiFSse+we
        KaUEDG0DTi9oIimp00xp+uQjhymXnfg=
X-Google-Smtp-Source: APBJJlH4Mhy/VM23A6/FP2/BQKTxDKpMbB0zFE0iPqM+xv0HeGjo6UKhgi/cEEjuQxz7rV2cFfu/jPGQg8Q=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:ce90:b0:1a6:4ce8:3ed5 with SMTP id
 f16-20020a170902ce9000b001a64ce83ed5mr3089plg.4.1690521962953; Thu, 27 Jul
 2023 22:26:02 -0700 (PDT)
Date:   Thu, 27 Jul 2023 22:26:01 -0700
In-Reply-To: <xmqqmt21txid.fsf@gitster.g>
Mime-Version: 1.0
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com> <ZGSlqAPwaLhgWm6v@ugly>
 <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com> <ZGUIqBU0+Vr5LSBF@ugly>
 <10523968-0f02-f483-69c4-24e62e839f70@gmail.com> <xmqqmt21txid.fsf@gitster.g>
Message-ID: <owly7cqkfvyu.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It is better for a code to behave
> in a dumb but explainable way, than to attempting and failing to act
> too clever for its own worth.

I completely agree.

> Oswald, I do not think GIGO is really an excuse in this case, when
> the only value of the topic is to make the behaviour less awkward by
> creating something better than a repeated revert-revert sequence,
> revert-reapply-revert is worse, as it is markedly harder to guess
> what it really means for a reversion of revert-revert-revert than
> "revert" repeated four times. 

How about introducing a suffix (+ or -) after the word "Revert" to
indicate the application/inclusion (+) or removal (-) of a commit? Example:

    - "foo: bar baz quux"
    - Revert "foo: bar baz quux"
    - Revert(+) Revert(-) "foo: bar baz quux"
    - Revert(-) Revert(+) Revert(-) "foo: bar baz quux"
    - Revert(+) Revert(-) Revert(+) Revert(-) "foo: bar baz quux"

I think the above increases readability. I chose to keep the same style
as the status quo for the first revert, because the "(-)" suffix alone
without a neighboring "(+)", as in

    Revert(-) "foo: bar baz quux"

might confuse users. This style would also do away with the multiple
quoting levels that make the current multi-revert subject lines look
messy at the end. Example:

    Revert "Revert "Revert "Revert some subject"""
                                                ^
                                                This part is starting to
                                                become noisy.

(Sorry for jumping into this thread so late, but the mention of this
topic on the recent "What's cooking" message [1] (that this topic would
be discarded) got me interested.)

[1] https://lore.kernel.org/git/xmqqpm4d9g54.fsf@gitster.g/T/#mf4edccc7bbc6365a03eaf106121694a27559d275
