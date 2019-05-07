Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8C01F488
	for <e@80x24.org>; Tue,  7 May 2019 08:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfEGIMJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 04:12:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45987 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfEGIMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 04:12:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so17797470edc.12
        for <git@vger.kernel.org>; Tue, 07 May 2019 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RKTglpffG0MjaUMhq3y4VNvKxvvzQjrP/w6skF2JjoU=;
        b=KhfsJn+P1jpPv7XjkDGsVYO/nbp65bMTUG+zJ9VpYZ8M35722uBcXTIWSBVDwOP2b/
         oJ7UTzAM+MqCdZNqmvwqrFINXqD3QybrDJNv/GJXdv/fry5TWtyMz9x9AJDpG0MFJm9M
         Edp3BmV3mlVN9axYxNCABPZ7ayMfz+shlXmYCRSx8f29Hxwug8teE2Bxz7xyDO6M4Cju
         W6sCal6ejhi5bk74OmSog9fijL4AAZ0C2xEpvD52Fy0k8LJGqvfyBrc+4EN8QmPVN3X2
         CQR1xN0XIcFrFfwXLK972Rkpt+xVaufzpcY0rhXdF0+eUPKeZcrgndCf/iVCnS+TPnlt
         /73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RKTglpffG0MjaUMhq3y4VNvKxvvzQjrP/w6skF2JjoU=;
        b=naGxwFga1mkPJbaX3dCppfrXGWsMljVpbqxGKNgYjdA8GMf/d2EgavAjfkbxBW4CDR
         PeFCiHaUz0u2hvzt+8mFXu6+wIo3P/+ulEu64wNKEULDg6fEcECJ1qeLrkTIgLcIxttf
         NEkLo8bXfTTWgVqjreVigrbNyblR9TmornzTYx5pDiqoyuWalO0pmHpX9nWCb5D2xzPq
         t4BmaIGEPtAiE7HfJjxgBBCEdAJNWBESX7UGzriLtn7hEjeAwV1IkPLzgseRcGmqpDMa
         hFnFEydSrCxIooOD0Wy1muiL2HtwWW2zDyHXgQtGpPx1vzDeNT3R0z2C6O1XqnzoXJ8V
         dRMg==
X-Gm-Message-State: APjAAAVAxoyELx1938q7OM0bQgtgH0jLgBaLHRCFRod8QBIpta/aYQxd
        Hi3xq53eOgIdOFXr0DOxkeo=
X-Google-Smtp-Source: APXvYqwKGoa1Szkyy2X0fQKrPsoiuHUAjqCqoq7/PjaKFk9f9kxUD8UManKlWvcXSUwulM/G3hZNGA==
X-Received: by 2002:a17:906:1903:: with SMTP id a3mr22707081eje.37.1557216727133;
        Tue, 07 May 2019 01:12:07 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id o15sm3922029edj.44.2019.05.07.01.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 01:12:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190312031303.5tutut7zzvxne5dw@dcvr> <20190312104954.GA2023@sigill.intra.peff.net> <20190313015133.n7f7lyujnlwfytre@dcvr> <20190313145417.GA24101@sigill.intra.peff.net> <20190314091254.nescpfp3n6mbjpmh@dcvr> <87zhoz8b9o.fsf@evledraar.gmail.com> <20190410225721.GA32262@sigill.intra.peff.net> <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com> <20190504013713.GC17551@sigill.intra.peff.net> <87a7g2iuem.fsf@evledraar.gmail.com> <20190507074506.GF28060@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190507074506.GF28060@sigill.intra.peff.net>
Date:   Tue, 07 May 2019 10:12:06 +0200
Message-ID: <8736lqisyx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 07 2019, Jeff King wrote:

> On Sat, May 04, 2019 at 08:52:01AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > Note that =C3=86var's case was somebody running bitmaps locally and tr=
ying to
>> > push, which I think is generally not a good match for bitmaps (even wh=
en
>> > they work, they cost more to generate than what you save if you're only
>> > pushing once).
>>
>> Right. It was *not* caused by this "enable bitmaps by default on bare
>> repos" patch (which I wasn't even running with), but *is* indicative of
>> a pretty big edge case with enabling bitmaps that *will* happen for some
>> on such bare repos if we ship the patch.
>
> Yeah. To clarify my comments a bit: I do think it would be possible to
> hit a weird case like this while serving fetches (i.e., as far as I know
> there is nothing in what you saw that is inherent to pushes). But I do
> think for serving fetches, bitmaps are overall a big net win (based on
> my experiences).
>
> So I think it may come down to a tradeoff: enabling this by default
> would probably be a net win across the population, but that's little
> comfort to the unlucky somebody who may see it as a regression. I'm not
> sure which is more important to maintain.
>
>> As an aside this is the Nth time I notice how crappy that "Enumerating
>> objects" progress bar is. We do a *lot* of things there, including this
>> bitmap calculation.
>>
>> But just splitting it up might result in either no progress (all
>> individually below 2 seconds), or a lot of noise as you have 20 things
>> that each take 2 seconds. I wonder if someone's looked at supporting:
>>
>>     Enumerating Objects (X%) =3D> Calculating bitmaps (Y%)
>>
>> Where X% is the total progres, and %Y is the sub-progress. I eyeballed
>> doing this once by "chaining" the progress structs, but there's probably
>> a less crappy way...
>
> I don't think it needs to be split; I think we just need to update the
> object count while we're traversing the bitmaps. The problem is that the
> progress object is known to pack-objects.c. Without bitmaps, as the
> revision machinery walks the graph, our callbacks bump the progress
> meter every time we see an object.
>
> With bitmaps, all that walking happens behind the scenes, and the bitmap
> code delivers us the final answer. So we pause for a long time, and then
> suddenly it shoots forward.
>
> I think we'd want a way to tell the bitmap code to update our progress
> meter as it traverses (both single objects, but also taking into account
> when it finds a bitmap and then suddenly bumps the value by a large
> amount).

Not splitting it will fix the progress bar stalling, so it fixes the
problem that the user is wondering if the command is entirely hanging.

But I was hoping to give the user an idea of roughly where we're
spending our time, e.g. so you can see how much the pack.useSparse
setting is helping (or not).

So something where we report sub-progress as we go along, and perhaps
print some brief summary at the end if it took long enough, e.g.:

    Enumerating Objects (X^1%) =3D> Marking trees (Y^1%)
    Enumerating Objects (X^2%) =3D> Calculating bitmaps (Y^2%)

And at the end:

    Enumerating Objects (100%) in ~2m30s -- (~10s marking trees, ~2m10s bit=
maps, ~10s other)

I.e. bringing the whole "nested" trace2 regions full circle with the
progress bar where we could elect to trace/show some of that info, and
then you could turn on some trace2 mode/verbose progress to see more.
