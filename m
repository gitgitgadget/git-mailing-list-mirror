Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F3C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 01:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54B361A19
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 01:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbhCYB0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 21:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbhCYB0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 21:26:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D358C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 18:26:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so267959ejr.5
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 18:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jGuYwQ6/qoWiEkQeWm7LW8cZAg1fjPOA5WeK6e2E2Mw=;
        b=RCwqE6PfhVfqTCMoL8TUnn77kf4auo5BTamDwpZpw+HQ6YkhMB4TVBhbvuKanJyL4k
         XnVDdGkzfXk/QGoOof1WK3gexCpeFX2fP4NCvQ/LCvGZ7LJL5nXsSx/2F2keTjeA1LUH
         Mr79iLri+u+LM3DZj0G16Yddyq4LZwnI9fdH0Ah96jinwbrGKUsRx0pykBv+VlNiqIRw
         +FghZDbrrmoqmjUtggXO1ZpQQy618kNufVEnCYH2KNrLC8TFZN0vzxM5xjMaFrakg4Ey
         GcbvP2PN9DjvQI7hCLJkxmSzkg8q8PXqY9wiW2pBuV8Q5SSCT9DpN2DPCjypXaaFlf7B
         iIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jGuYwQ6/qoWiEkQeWm7LW8cZAg1fjPOA5WeK6e2E2Mw=;
        b=XSvcfA5h26EwvzBm7YvZUyVCh7pGYqr3VTRg8TvwT2OGf+0r+AKOwlZuUbj40lRMO/
         YZv4E9WVQE5CL/CcDmnGFhJegsI/O8t4GtKnF91Urf4ABZgqS0GGFDoL8SV98oBokgtX
         W121WacZNvtSBUzrS2RKTykHGMSnaYH7K2xbLAKhbjNawhAr557MwRsLcdAAMiHHQG7m
         XTlQAAHqycAbQPsb/wmDj4O9sdjo9pD/PS+5vW8i3j2Iey1A6cw1prTP8Kkhz5qCinJw
         R2Hrx2W5xY1fT1jU6y5NjGhUCmX4wBd88doc1jDwbnCUS9mC92+Yu9ckG0OpGp34zw/x
         Csaw==
X-Gm-Message-State: AOAM533R2J5wU8mzF+gun1uV85N4LIOzh/TUE7DRc71cYRgqAJuKFb1g
        tm59haNmtYVPdJ6DX24fxbQ=
X-Google-Smtp-Source: ABdhPJxRpRtlzEXwkhAxyraQySsM0eDii43H8qJ135KhEdYFihzzjLxVRY2deUvGqHfKTZ2oGn+dWQ==
X-Received: by 2002:a17:906:6c93:: with SMTP id s19mr6634375ejr.151.1616635582583;
        Wed, 24 Mar 2021 18:26:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p3sm1717961ejd.7.2021.03.24.18.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 18:26:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
 <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
 <87im5gp2ze.fsf@evledraar.gmail.com>
 <YFvaYokQJpvwSzJ6@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YFvaYokQJpvwSzJ6@coredump.intra.peff.net>
Date:   Thu, 25 Mar 2021 02:26:21 +0100
Message-ID: <87czvoowg2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 25 2021, Jeff King wrote:

> On Thu, Mar 25, 2021 at 12:05:09AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >   As an aside, it feels like this is something we ought to be able to
>> >   ask git-config about, rather than having a test-helper. This is
>> >   basically "baked-in" config, and if we represented it as such, and
>> >   parsed it into a struct just like regular config, then probably "git
>> >   config --list --source" could be used to find it (and differentiate =
it
>> >   from user-provided config). Possible downsides:
>> >
>> >     1. Would people find it confusing that "git config --list" suddenly
>> >        gets way bigger? Maybe we'd want an "--include-baked-in" option
>> >        or something.
>> >
>> >     2. Is the cost of parsing the config measurably bad? Obviously a
>> >        user could provide the same content and we'd have to parse it,
>> >        but there's a lot more rules here than most users would probably
>> >        provide.
>>=20
>> Also:
>>=20
>>  3. Only the PATTERNS() macro translates as-is to config syntax. We
>>     don't have a way to do what IPATTERN() does in the config syntax
>>     currently.
>>=20
>>     We could add a ifuncname and xifuncname or whatever for it I guess,
>>     but currently the ICASE behavior in the C code is magic.
>
> Good point. IMHO that is something we should consider fixing
> independently. It was a mistake to add builtins that couldn't be
> replicated via the config (though I notice it happened quite a while
> ago, and nobody seems to have cared, so perhaps it isn't that
> important).

I'm conspiring to eventually optimistically replace these ERE patterns
with PCRE if we build with that at some point.

Then you could just prefix your pattern with (?i) here in this and other
things that want icase...

> I have also wondered if we should just ship a file which could be
> installed as /etc/gitconfig.filetypes and include it the stock
> /etc/gitconfig. That is effectively the same as "baked in", but
> hopefully makes it more clear to users how they can modify things.  But
> all of that is somewhat orthogonal to what you're doing here.

In theory I'm with you on that, in practice this is just the sort of
thing that requires opt-in effort from every person packaging git
(installing system-wide-config).

A good number of those people will decide "default config values? In
some ~200 line file included in /etc/gitconfig?? I don't need that! This
is a minimal install!".

And then their web UI that calls "git diff" under the hood won't do the
right thing with a .gitattributes config that expects these built-in
drivers anymore.

But yeah, there's no reason your earlier suggestion of injecting global
defaults into "git config -l" wouldn't work, and for our own C APIs such
as this one to rely on that happening.

It would even make git more discoverable, as all the "this is set to xyz
by default" docs in git-config(1) could become reflective, you could
just run "git config -l --show-origin | grep ^default:" or something to
see all default values.
