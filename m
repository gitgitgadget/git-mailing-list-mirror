Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E56C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 06:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiI1G4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 02:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiI1G4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 02:56:18 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8AB647D7
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 23:55:36 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id u64so1022045ybb.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 23:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=npplTIIZ87mqWrvuxj//+TSWhnBnJfNGDoEP4abR2Cs=;
        b=ohXyrJ+SxTFuYCulRtNu5+dcjeQdCLs7TH1Nebi9R00rP2/dgjsiAwMxkCyEbJqhVS
         gRmb3e/Xr2HrOYr1sZzmOo/izBDhx5aYshukE/8j1OkiNwGnGWeVC9de6/5MWrmkonre
         UrpwOk8oJZENrm+CBxeyFmQho6TZ5O+rySEgaDdCSY1I2QBWeyxVB984/TypaVEqj1aP
         H6+2llTPtgJrndbCynlyebyJp5/Oq4hCH9Gz3cfUaqu+S0DKgblkd41sLoxrr2bNJZIY
         RogRIpU7hNKLAHkEi841/HmDElojpYfHfB8WTxgcuaHWza84fmtYwbW150/UuI3zq88w
         XkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=npplTIIZ87mqWrvuxj//+TSWhnBnJfNGDoEP4abR2Cs=;
        b=FA5CjVQe/NkXcA0qTbZXuIFwD3Yk7r+PibifeUUBYtuP0s6wcdGlOq9qHnK508pCBO
         5JaaRnaUazWA+MVwRX0yVhwNff+VFvO2L5Vj99Lb7UPMbuhyO2j29j2GnOi2wfnaAGlJ
         c4pBHl6+aYj8hdGTbTvNggzpdcNIq7p1D3a7WCIBKkRCfMDhu0/WqBYpfaTnaOp5wGlA
         CBVikH3MFm49yE8UGePbhpTpc9tCNDda6/ByEEcS3px8fkitVic7vY7ckSgCw0hy83Tr
         o9eBq982nhaLfoPB+mkzp+ry9PAWNhAT1CPNOkGD6AZOqcxj4kWsu6GjFNfhxxzFKWRM
         u/0A==
X-Gm-Message-State: ACrzQf2CHF5tkXYArNzs0X3HwQw3YEsqeAHWd5zHKUpQ4aCI3U6Ir5WE
        PsqQxOGvOB1Bwoi7/Xhf5spNO1ucOOrmrI+ZZtE=
X-Google-Smtp-Source: AMsMyM4e/uGiirNPBuMyWiw0IWsV0g2h/nGN8Zafslb6gJFBuD1k6vhQcZlWnyyR1z/1RES5EyG+1kZO5DKbzEv+r9o=
X-Received: by 2002:a5b:40c:0:b0:6b4:bed1:13a5 with SMTP id
 m12-20020a5b040c000000b006b4bed113a5mr29329793ybp.180.1664348135396; Tue, 27
 Sep 2022 23:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com> <e00cb37b98ac09cff010e843ef19eeec761f8985.1661243463.git.gitgitgadget@gmail.com>
 <220908.86illyl3yo.gmgdl@evledraar.gmail.com>
In-Reply-To: <220908.86illyl3yo.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <ericsunshine@gmail.com>
Date:   Wed, 28 Sep 2022 02:55:24 -0400
Message-ID: <CAPig+cQTxVvBtKymLeWkDtRSBqejjydP6o-PfDriQHP-M+cShg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] cmake: make it easier to diagnose regressions in
 CTest runs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 8, 2022 at 3:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> On Tue, Aug 23 2022, Johannes Schindelin via GitGitGadget wrote:
> > When a test script fails in Git's test suite, the usual course of actio=
n
> > is to re-run it using options to increase the verbosity of the output,
> > e.g. `-v` and `-x`.
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems=
/CMakeLists.txt
> > +             COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lin=
t -vx
>
> I think the "--no-bin-wrappers --no-chain-lint" and the "while at it"
> here should be stripped out, and put into its own commit.
>
> So, perhaps we should have a performance hack due to Windows's slowness,
> but:
>
>  C. Since I sent [1] we've had submitted chainlint.pl in-flight
>     series. It's partly trying to take special considerations to be fast
>     on Windows. I don't think it's the case with that series that this
>     needs to be skipped on Windows anymore (and if it is, Eric would
>     like to know).

I had the opportunity to test chainlint.pl on an 8-core machine using
both Linux and Windows 10. The machine is more than a few years old,
though not nearly as old as my own development machine. Although
chainlint.pl checked all test definitions in the entire project in
less than one _second_ on Linux, it took two _minutes_ on Windows 10
on the same machine (using all 8 cores). Despite the fact that Perl is
run just once to check all test definitions -- unlike chainlint.sed
running 'sed' tens of thousands of times, chainlint.pl is still
painfully slow on Windows, so I certainly understand the desire to use
--no-chain-lint, at least on Windows.
