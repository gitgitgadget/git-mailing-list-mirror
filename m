Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959ABC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7251E61396
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhFXXZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 19:25:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A73C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:22:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h17so10888901edw.11
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Tvceu4rOFNon0kHU6BfG/7vUJxRoUBnQsue7rRikbsw=;
        b=gc5YSdwR5PcbUN021Z0/tnuqw4E6PdDGacAFNZTftTLvwveP21lsK7AU97TaB8oJTi
         ppb8KZJBvwPJktRvbRpl9sOADiN95pNJwC/tLJMI6gOorzAus8sY8CHZZh1cfEZo3ivW
         VHtvzJchEw6Jej5X2lhR9ZUDP2jaUsUMSDw6wa2XZOkgKO3zFdTEmqctPQ22Io+wIBew
         bWzNyeHnvGl4c6yQOuZp7zOZAScmW4CmJYSQHYWXM4EFuqVZJ+qSjL00BMf9r+BoCM8v
         TybbxMol37/sGxW1UwNQKDnGSg+Z2ExoB2+qnp441B4qhKchPwrHP2xNYBcYT09FbUhJ
         E4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Tvceu4rOFNon0kHU6BfG/7vUJxRoUBnQsue7rRikbsw=;
        b=Fe2TwSDW0CPRiRhDwzLYzlVGJ8EMeNHom9Pu2CkLYgVJHuqERddcKs1nFUifL7/PKO
         VgxWKd86B14hp99mULOTgJoE1OJNvNNCENas3KFYogYAaUezYDPklFeK+NPt5bzMMi/e
         9NX1sqXGmwkE6eKKRen9Z2qDUhOyJezUNcjyfDS7wOoZvHDGIp/QwSVEN1AOttLQJfPD
         rDbKEuzjzEU1OqjbpqFCYm8f9yGNYMGkXhZLa7jbdfCZMO6mgLycQ/xO+vh/ebn+zv0O
         uJCQTzwd+2mq3kDUe486yAKR4UsHVMNEbkB7usmuQ9LWgNF8mVqkAS4KuxuqK/6muaIW
         HbnQ==
X-Gm-Message-State: AOAM530HhehNwELMJ/wKQ/DuJBW5OjatYGwZcEU22l8AaHrtion01jO7
        /Ns7Z9hvT+RhNypzjhOn21EjPHAb8Bhk7A==
X-Google-Smtp-Source: ABdhPJxRHEMzStoR4kKSwbsQ4MOyKZQrh1eon94HhMnhlpdfV2Bmth20vgcSd6ZdE7+83HGGbtVZ1A==
X-Received: by 2002:aa7:cc87:: with SMTP id p7mr10535745edt.82.1624576973839;
        Thu, 24 Jun 2021 16:22:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f5sm1803090ejj.45.2021.06.24.16.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:22:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqn?= =?utf-8?B?biBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
Date:   Fri, 25 Jun 2021 01:19:42 +0200
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-2-congdanhqx@gmail.com>
 <87bl8928q9.fsf@evledraar.gmail.com>
 <3ab4f29e-987a-c7de-0cca-a64c3bf4be47@gmail.com>
 <CAPig+cRFjBXpm_WwSGBYu75z8TabCDZodYi=wKgTamB1a3aGmg@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAPig+cRFjBXpm_WwSGBYu75z8TabCDZodYi=wKgTamB1a3aGmg@mail.gmail.com>
Message-ID: <87h7hmzw37.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 13 2021, Eric Sunshine wrote:

> On Sun, Jun 13, 2021 at 2:18 PM Phillip Wood <phillip.wood123@gmail.com> =
wrote:
>> On 13/06/2021 14:28, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> > On Sat, Jun 12 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
>> >> +       { test "x$1" =3D "x!" && test $# =3D 1 ; }
>> >> [...]
>> >> +    if test "x$1" =3D "x!"
>> >
>> > We don't use this test idiom in other places, it's OK to just use "$1"=
 =3D
>> > "!". I think we're past whatever portability concern made that popular
>> > in some older shell code in the wild.
>>
>> Slightly off topic but if anyone is interested in the history of this
>> test idiom and why it is no longer needed there is a good article at
>> https://www.vidarholen.net/contents/blog/?p=3D1035
>
> Thanks for the link to the article; it was an interesting read.
> However, the article does seem to say that such idioms and care may
> still be warranted. In particular, the epilog gives an example which
> is still relevant on macOS today. (Indeed, I just tried it and it does
> error out as the article states.) Even discounting macOS, it also
> talks about such bugs existing as late as 2015, which isn't long ago
> by any stretch. (And, as someone whose primary -- indeed only --
> development machine is ten years old, some of the other bugs it
> mentions -- which existed as recently as ten years ago -- don't seem
> all that long ago either.)

It's only for the case where the first byte is "(" or ")" though, so
e.g. the use of this to compare things like command-line options and
other things that don't start with those characters is portable, if I'm
understanding the article correctly.

> At any rate, for those of us who are old-timers, the `"x$foo"` idiom
> is habit and only costs a couple extra characters, so I for one have
> no problem with its presence in the proposed patch.

Indeed, but it's interesting to dig and see if there's any reason for
such workarounds still.
