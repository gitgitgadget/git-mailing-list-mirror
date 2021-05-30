Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA828C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 11:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1133610A0
	for <git@archiver.kernel.org>; Sun, 30 May 2021 11:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhE3LiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 07:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3LiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 07:38:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A0AC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 04:36:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y7so10142346eda.2
        for <git@vger.kernel.org>; Sun, 30 May 2021 04:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1Z1wunHBZu6ABVbfyw6+AZZ0fa2V5/D815BAXMgvOQI=;
        b=AB7hLKbpStl9ZwHWnkt9JHcwW2TkVmbW13f+rkJhWvvV7lteBXeW7SpCgqXL/NrHww
         bi8034XExk0BNY1bvD95AtFO98R5sfDr4fUS/Mpc1Q48CpH+8Nbpu4J4J2EDCRYsMCW1
         aHd95aoe3ScG7Z27TmuzQXuMacTh/kHz3pOXpANtl85lqQXSZygrUa084jFDSkhXwMYP
         qhVzRjtiW2FejbEjIv/SZweCg8ye33nYFLuim7VoKxrZSDlZctcXLmbvPt1ATZstcat1
         TXsnQ8r6SPCsYHHlivlILSHM+DvFfYxn/cYXaRfIeAinmEsxdWtBostfU6Sz+8GxcWDI
         g3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1Z1wunHBZu6ABVbfyw6+AZZ0fa2V5/D815BAXMgvOQI=;
        b=IRCYUCuCd89l7rOiq//3S+wpF55LDMYALms9m57bO9dkF03IJ1/TW7N36s/4BzxeBc
         dn57qm8x2OXGakh2sItoc9b/iZ8dwt/9H0bqyO9hGochA0YBo7OI75qb5FRl/wydAVwM
         kRQ8pgUkFldvJ6+iGlbLLsA0HzlTNC84YPYpmZ+i369IZNkEFnWHVnMUf49spl5C6GCP
         yaENmRPNoYSZLISN21qf4ak6sJrXUWwkJ5W6TPoDZ41aAqoa0m1LaXFyWc8IbdwBcNJX
         uTuWmHLQue/jYdKRXN3PFZdiExgdAoH/T7/LvJ6Iogsu3WR8ZFudBy2In8zksZAI8tYD
         824g==
X-Gm-Message-State: AOAM533URlIeGd/wfRumJ3gkQiGm+Zy5DwBvhr5KrAc/FdmCTQTPdjN+
        Abvp5+hvj3cJd4aSQgHQWBk=
X-Google-Smtp-Source: ABdhPJwwL00oXaRycfqEKKYLBMUmtzDDJg8HBClMBZoO3zcAckBULgjeW2dJdwWAf528u29cR4GXRA==
X-Received: by 2002:aa7:cb84:: with SMTP id r4mr19857437edt.187.1622374585724;
        Sun, 30 May 2021 04:36:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p25sm4705965eja.35.2021.05.30.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 04:36:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up
 by >2x
Date:   Sun, 30 May 2021 13:33:31 +0200
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net> <xmqqv97drmge.fsf@gitster.g>
 <875yzcpo52.fsf@evledraar.gmail.com>
 <60b11101e5288_50514208b4@natae.notmuch>
 <87czta2b47.fsf@evledraar.gmail.com>
 <60b2557b5c7da_2650882084e@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60b2557b5c7da_2650882084e@natae.notmuch>
Message-ID: <877djg313c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 29 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, May 28 2021, Felipe Contreras wrote:
>>=20
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >> Returning a flattened list is idiomatic in Perl, it means that a call=
er
>> >> can do any of:
>> >>=20
>> >>     # I only care about the last value for a key, or only about
>> >>     # existence checks
>> >>     my %hash =3D func();
>> >
>> > I was staying on the sideline because I don't know what's idiomatic in
>> > Perl, but Perl and Ruby share a lot in common (one could say Perl is t=
he
>> > grandfather of Ruby), and I do know very well what's idiomatic in Ruby.
>> >
>> > In perl you can do $ENV{'USER'}, and:
>> >
>> >   while (my ($k, $v) =3D each %ENV) {
>> >     print "$k =3D $v\n";
>> >   }
>> >
>> > Obviously it's idiomatic to use hashes this way [1].
>>=20
>> For what it's worth idiomatic/good idea and "has an example in the perl
>> documentation" unfortunately aren't always aligned. A lot of experienced
>> Perl programmers avoid each() like the plague:
>> http://blogs.perl.org/users/rurban/2014/04/do-not-use-each.html
>
> Perl is an old language, and each() was introduced in 2010, it's
> expected that some old-timers would not adapt to the new idioms.

each() has been in Perl since 1987 with perl v1.0, you must be confusing
it with something else.

In any case, the recommendation against it has nothing to do with its
age, it's that similar to strtok() it has global state. So e.g. you
can't safely iterate over a hash you're modifying with it, or if you
iterate over a top-level structure and pass that variable down to
another function, and it also uses each()...

