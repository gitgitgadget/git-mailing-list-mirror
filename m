Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA444C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 16:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiGJQiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJQit (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 12:38:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A4FDF95
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 09:38:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd6so3786967edb.5
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LdM8VYrTL9g1xEoi3hvd1TNLK2OuEb3gADo9ixlj5x4=;
        b=ZvSycN+L+pZemhdqEVaBy/MVMjdFX9S9LrBi9fJ4nri+rNh2MK7qJFdY/2Q+c6G5nU
         EkPDCVyxE/rZM1dXxzhXIZTuvjmElvLMLmtHgLfcF6MN6C6j0fAxExE/coJYsZ3IiN31
         rU2tqljSFbCO5gqpWWRAGwN1DV1BVpM1y/IEtqFY2PzNVd6VQcXloiOxIoefzfaMbYz1
         0pLu+Y6TKnOxuaTtUbcd3eoQzYdWQGnR+HWnZszddKwzAZ3pDZ+jZVWVGY/QKInZ1FS2
         vhWjdBcmwsGkX4tKkVJndnRKpoK2mxSXDDesAcGV5/1ygz04nYzWlohywyvFwPu1pd4j
         52bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LdM8VYrTL9g1xEoi3hvd1TNLK2OuEb3gADo9ixlj5x4=;
        b=dr3wJnQy8UNNd7qoahHw15bbJ2dKhx55LEux1CaxxBj2kx10AeTJjc2nUb5dDj3v/A
         FCle+ame+rLmBuG2nHsyHdxuN66w04f+lDsOKyvxvBpBzjK0dwoSukjefajNjSLW6VQA
         QHj2sKvQBxgXdJRMP0UBOa8CptqSMGUli0hCXyMC2YkrUZXXnAqfTPBb41xZ/XmAE126
         tqCtWXsyYJaZATKReCiYdgfp/C1BdE42wozTw7uAYDNm0is8b/VpTPpkEw8LTjfedADF
         kst2oS9AsW+tPDP5Je1GirXXqJRpf4U5csPQiwGvzkny7H2KzLDNHmj8C0AaqDSZxYe5
         pT8g==
X-Gm-Message-State: AJIora93tuUBC9MtVZPYV+v4Wl8xvwMkl4ZMRmCNZKeN0Vt+Tv8uEeKP
        pteR5V6TGbWgPkI1jFlWjS4=
X-Google-Smtp-Source: AGRyM1tuYC7M1a8c/mAtqlWyV8XCDG3KbWumV+E9Lg7ArOmeiRWsIWelZJE6tz/FIM0z1Ih8+oQsAQ==
X-Received: by 2002:a05:6402:4144:b0:431:6ef0:bef7 with SMTP id x4-20020a056402414400b004316ef0bef7mr18593291eda.151.1657471126833;
        Sun, 10 Jul 2022 09:38:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ca15-20020a170906a3cf00b0072b2cc08c48sm1705405ejb.63.2022.07.10.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 09:38:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAZxF-000EQp-Fr;
        Sun, 10 Jul 2022 18:38:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] cocci: avoid normalization rules for memcpy
Date:   Sun, 10 Jul 2022 18:32:07 +0200
References: <xmqq8rp54r4l.fsf@gitster.g>
 <220707.86y1x585wy.gmgdl@evledraar.gmail.com> <xmqq1quw23r8.fsf@gitster.g>
 <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
 <95432eb4-e66a-5c04-9267-f71391fbe277@web.de> <xmqqmtdhsf1z.fsf@gitster.g>
 <ded153d4-4aea-d4da-11cb-ec66d181e4c9@web.de>
 <220710.86ilo580mb.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220710.86ilo580mb.gmgdl@evledraar.gmail.com>
Message-ID: <220710.86a69g9b3e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 10 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sun, Jul 10 2022, Ren=C3=A9 Scharfe wrote:

> Isn't there a way to avoid this by simply wrapping this across lines, I
> didn't test, but I think you can do this sort of thing in the cocci
> grammar:
>
> - memcpy(
> - COPY_ARRAY(

Oops, typo!

I just manually typed this out, so I meant "+ COPY_ARRAY(" here, in case
it wasn't clear.

To elaborate: Here's an example in the cocci repository:
https://github.com/coccinelle/coccinelle/blob/master/tests/pcim.cocci

You can also use "..." elides, but I didn't check if that works for the
start of an argument list (but it should, I think), here's an example
with it at the end:
https://github.com/coccinelle/coccinelle/blob/master/scripts/coccicheck/coc=
ci/kc.cocci

So I think rules like:

- memcpy(
+ COPY_ARRAY(
  ...,
- A
+ B
  );

Are possible, and something you can use in this case (I have "5.1 Basic
Transformations" from cocci_spatch_grammar.pdf in front of me).
