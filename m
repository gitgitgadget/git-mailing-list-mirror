Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10AC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbiBDNEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbiBDNEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:04:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F539C061744
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:04:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id o12so19182913eju.13
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=K94Yd1HEYvPuvB+vnSQlCNtpKvS0YGLEBcHs072JR5E=;
        b=Mwu7pupQ0nTBoTQV8L38i6Lutl2dMzOCcGwxQ2YheVuYmx8Xl9JBAaWTOq2xNjMZeb
         SfwqHhAkdYc4Dj7DPvy0Nm7yUQAQiqNieQdjGw1bdi3HmLIHANJq6pZ+qZB33PXhmkwL
         AqHJaFKXeFcYLoMU26A935JC05u7Qmhqhxor7uCh7Gl7XjTq0fDQwCZYzozp4nivJA4p
         3RAf9n+qTkjvhcx6aedyXOoK4V7h2WaUDzG1Kk7Of+hdDZlswS6SnHu+pEDe+oe38QZr
         zRGgGg3QAJPZdhxtrhUKhmDe4CP3/Gb2HqEZZAtIgJtk1cEVy0HnnbjL2Ry+FGteTBbJ
         yo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=K94Yd1HEYvPuvB+vnSQlCNtpKvS0YGLEBcHs072JR5E=;
        b=Zx3tfX8JuWWkcdOEzJHwNi9sqK2ls+Oewi7qP6t2X09mfU6Ibwt+c+NSR4ZFVgl5h/
         qoxHT34YddkcvMYefPNBSNZ+ls0xXqPUgDTn+zTCD6SB8TTvVNxPyk2MkjiWaXA73Cab
         e7ROZ9oTV9vEfMH4/Emu6H+S/QUaz2W7WekLsQC2gx2/Zo8kWMMVgoxfRs8F+TPvdDOI
         y2ZkpyiE6WRIFtdL+epjzaHvv0nORgMw+spJXPAR/2hUYh6guQhj/6rSMwuRNb2A8sVf
         CHBx/U1qsVz6+wTjF9eS0P417RE18G5gXMYpr6xfW3BvdyuSWOIDm7LUXOpN+jL+sswQ
         bxKQ==
X-Gm-Message-State: AOAM532w2FVkQ68BhIGv6lrOUJl6HvxJ1C8Qf26TDPiyDC3PC1YW8TdS
        s9tSptFqtJReKtVZNwk5gF0=
X-Google-Smtp-Source: ABdhPJyE4ZFDM9Iu1Ig6VNlZVXWpIkVPa6knvjQM63HnnaakpQ4vM/c0DVtd2rcQ2qcV7dfxwospHg==
X-Received: by 2002:a17:906:2a91:: with SMTP id l17mr2325623eje.245.1643979890865;
        Fri, 04 Feb 2022 05:04:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g27sm820661edj.79.2022.02.04.05.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:04:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFyGf-0065ds-5V;
        Fri, 04 Feb 2022 14:04:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v10 6/9] ls-tree.c: support --object-only option for
 "git-ls-tree"
Date:   Fri, 04 Feb 2022 13:58:20 +0100
References: <cover.1641978175.git.dyroneteng@gmail.com>
 <bcfbc935b80b889273e3e54fec2a896e44acd2b5.1641978175.git.dyroneteng@gmail.com>
 <220113.86wnj4w228.gmgdl@evledraar.gmail.com>
 <CADMgQSQXLydvgpW+Vm_b-rkSWAuj9FezwveY-iRZnKfsGkOpCA@mail.gmail.com>
 <220114.86ilumttn2.gmgdl@evledraar.gmail.com>
 <CADMgQSQzqW9m1XM7_EE09eBhkheMj6QCZ+pVjtHWW2HY=u_o2g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CADMgQSQzqW9m1XM7_EE09eBhkheMj6QCZ+pVjtHWW2HY=u_o2g@mail.gmail.com>
Message-ID: <220204.865ypu3hqm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Teng Long wrote:

> On Fri, Jan 14, 2022 at 7:59 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> Yes, you get the functionality you need with a simple alias of
>> --format=3D'%(objectname)' to --object-name (or whatever), so the only
>> reason to carry the extra code is for optimization.
>>
>> I wonder if the extra difference in performance is still something you
>> care about, or if just the --format implementation would be OK.
>>
>> But in any case, starting with a simpler implementation and testing it
>> makes the progression easier to reason about.
>
> Actually, at first, I wanted to achieve this in a simple way, as the
> "--object-only" implementation.
>
> With the discussion in the community, I think both of them can achieve
> this purpose. "--object-only" is more intuitive, while "--format "is
> more flexible.
> For example, if the terminal supports automatic completion, the function =
of
> this option can be clearly known with typing TAB and lower costs of use a=
nd
> understanding. "--format"  also works, but maybe have to check the help
> document to see if there are fields that support the same purpose.
>
> Because the community had a different opinion about it. Junio, might pref=
er
> an "--object-only" approach, if I understand the context correctly.
>
> So I have some inclination to support both. However, I can accept that on=
ly
> "--format" is supported.

I'm only talking about how it's implemented internally, not whether we
have an --object-only option in the UI. I think it's good to have the
option for completion etc.

I.e. in my RFC implementation of it here it's just a trivial wrapper
around specifying a --format:
https://lore.kernel.org/git/RFC-patch-7.7-5e34df4f8dd-20211217T131635Z-avar=
ab@gmail.com/;
Implementing it is 6 lines of trivial C code boilerplate.

But when you picked that up & ran with it you ended up carrying your
original implementation:
https://lore.kernel.org/git/e0274f079a7d381b9a936bfcd53bad64167c18b8.164144=
0700.git.dyroneteng@gmail.com/

I'm not saying we shouldn't have that, but that in any case a sequence of:

 1. Add a --format option
 2. Add a --object-only alias for a --format (what my RFC 7/7 does)
 3. Add a custom more optimized --object-only implementation

Would make the patch progression much easier to read, and we'd consider
the correctness of --object-only (1 and 2) separate from the
optimization question (3).

But maybe we won't need (3) at all in the end, i.e. is (1 and 2) fast
enough for it not to matter (I think probably "yes", but I don't have a
strong opinion on that).

> So in the next patch, I hope to do some refactoring of the commit to supp=
ort
> "--object-only" as the top commit. If in the end, we decide that "--forma=
t" is
> enough, we can discard the top "--object-only" commit.

*nod*, now that I read ahead I think you pretty much agree with that plan :)

> I know you guys currently are busy on the new 2.35 release, so a later re=
ply
> is OK.

Now would be a good time :)

I was reminded of this because Junio's proposed it for next at
https://lore.kernel.org/git/xmqqr18jnr2t.fsf@gitster.g/

I think per the above & other replies of mine (including not matters of
code arrangement opinion, but e.g. the doc formatting bug) we'll need at
least one more re-roll of this. Thanks for sticking with this & working
on this!

I'll indicate that in a reply to that "What's Cooking" report.
