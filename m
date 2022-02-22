Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E7C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiBVN3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiBVN3f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:29:35 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C8A99697
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:29:09 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qx21so42837777ejb.13
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jPkzrfpPBp/GCktwxNq4hqinwKSyC7cEUygPdFGHLXU=;
        b=Uvvt7ws1YkZsQPycHEFgGqcAuAp/0BuemMpENamoYZk7CGvajPE083pmrlVM5TVWob
         sR3KkU/EXdHtKNXJERJv7ajHgxkj/TFlKQ/w6H41UOLICkjJRAD4oGgNYlgInmfqH73d
         sPOw3a4NFHnxlLijfPeySMtsio6oSaDUglRnJ8zXEojNdwzM8pGY3azJCM9E4sGjRD3m
         tFSntZG3OvBX4onFJSurxPvTBd05HBSMI0DmWGnR5nKAXpTBMnlktOYmSt3wsj8f8DzO
         b7PCTA1w/m17gEOmmCbBaNEaQOwBI5zZvVgSPK5yreXCxXbypb92MyZWG/WfXFuVwTHE
         NHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jPkzrfpPBp/GCktwxNq4hqinwKSyC7cEUygPdFGHLXU=;
        b=kPNtfZ2TWpVi2URW9VsCrXAufQs/PD2x6byaQvVM+gYtbvOg+3aG5BMeVGGmZDtEPP
         1SzOfT2U6dWu2GbZrctt/ycfJCoSf16qf3IoP71u8fDAMU2WlyME+sqA2NqPLRFC8Q+7
         W7BzrEJ2gHn5i6yB5K81icMtxQnyB5sSE0rHFvx1meyEya/WEJSCDb2IcDqyQkXa8gFZ
         D8BNBxt/YhoGUfMWMvywIzupUOZSJBrWsfGxSC+aWzCGjCLhOS8jQvmdWsix76fUtWkh
         TehiG22MZk710Z0376zZZDaUBHRc8A0Sk+H1iJK2uTelyz+1uQLPVuDWyYj9LBSUO+BO
         hdxQ==
X-Gm-Message-State: AOAM532k1EFLHhW4UyaCYCcVNvdTaj7C+2fDZBiMUNQcYcH0XqeJ0XTY
        sebh3gsBfGkujJl80Xxg74orl1tb0/GQtO4w
X-Google-Smtp-Source: ABdhPJyXA+VY1+Ox+8UlucxnaRkVvP1Ty6Sq4ED3G0Zf0IPBW+WBCCkagaPPEycGi8qlRSXYNRY1aA==
X-Received: by 2002:a17:906:84b:b0:6ce:6f82:9af6 with SMTP id f11-20020a170906084b00b006ce6f829af6mr19586330ejd.489.1645536547573;
        Tue, 22 Feb 2022 05:29:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 5sm6304434eji.192.2022.02.22.05.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:29:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMVE2-00653X-DD;
        Tue, 22 Feb 2022 14:29:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 05/25] CI: remove unused Azure ci/* code
Date:   Tue, 22 Feb 2022 14:05:08 +0100
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
        <patch-05.25-4738a22a36d-20220221T143936Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2202221115590.4418@tvgsbejvaqbjf.bet>
        <220222.86k0dn89bm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221306190.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202221306190.11118@tvgsbejvaqbjf.bet>
Message-ID: <220222.86y2236ndp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 22 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> It's still unclear to me how Azure CI is being used as a "fall-back",
>> can you explain that?
>
> By reinstating the `azure-pipelines.yml` file from the last known-good
> version.

Okey, despite what you might thing I'm not on the war path to remove all
of this at all costs.

In particular I don't mind much keeping the 05/25 parts around, but the
04/25 would be a hassle, depending on how you reply to the below.

So what do you expect me or someone who overtly touches code related to
this & the similar (and related) in-tree JUnit support to do? Presumably
one of:

 1. Don't work on any such code at all, in case you'd one day like to
    resurrect Azure support.

 2. Test my patches locally by reverting azure-pipelines.yml and make
    sure any overt changes to Azure-related code still work with that
    reverted commit.

 3. Just "YOLO hack it" but leave it in place-as is. E.g. for 04/25 and
    05/25 in combination with 11/25 (the later s/export/setenv/g change)
    leave a known-bad-but-looking-like-it-was-before Azure branch in-place.

 4. A variant of #2 where I attempt to patch the Azure code branches, but
    the "testing" is just eyeballing that they look reasonable, but I haven=
't
    *really* tested them even once (and I'd note as much in a commit messag=
e).

I'm not willing to go for #1 and #2. I could do #3 or #4 if Junio/others
chime and agree with you, but I really don't think those are worth it
either.

I could understand your view in your reply back in December when I sent
the stand-alone Azure removal patch[1]. Even though I noted that it was
needed for subsequent changes it was a stand-alone patch, so it wasn't
easy to evaluate the trade-off of whether removing it was worth it.

I think here it is quite easy. The end-state of this series
significantly improves the UX for the CI we actually use, and I think
actually makes it easier to get Azure support back up & running should
you ever want that, since the whole structure of it is making CI less
complex and less of a special-case.

It's been almost 2 years (just around 2 months short of it..) since
azure-pipelines.yml was removed from "master". It would really be quite
easy to get it or any other new CI target off the ground, particularly
after this series.

Insisting that any effort to fix actual CI issues in the actual CI we do
use needs to be hamstrung by any change in the area needing to carefully
eyeball:

    git show 6081d3898fe^:azure-pipelines.yml

And for each change carefully consider them *if* we still ran that just
seems unreasonably obstructionist.

Sure, Azure CI had some neat features, so did Travis CI. If we ever want
to run either of them again let's just consider that if and when that
happens.

Maybe you have relevant feedback queued up, but so far you haven't had
any meaningful comments on the goals end end-state of this series as
compared to yours[2] (to the extent that their approaches differ).

Can we try to focus on that instead? I.e. the actual visible CI changes
that'll either make the CI workflow we actually use better or worse?

1. https://lore.kernel.org/git/patch-1.1-eec0a8c3164-20211217T000418Z-avara=
b@gmail.com/
2. https://lore.kernel.org/git/pull.1117.git.1643050574.gitgitgadget@gmail.=
com/
