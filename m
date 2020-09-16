Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04D1C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 09:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB3D206C9
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 09:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o614q15T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIPJfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 05:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgIPJft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 05:35:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0A5C06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 02:35:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q13so9333161ejo.9
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRFw21Y3GHtjY/j55cNhExDPYtfdNGDgS0NM2bUrYoY=;
        b=o614q15T4jWDn+x2QIyeGQUkAO23NHk9p8fhEQivmmLCEDR9N5zQdZfTlyLJJpUCO1
         t6sNmqVD3lML3MG3WH1J8DqyQWH8qRvnXCx76/jXXfmSD8s7h/8d7bKP1dQWZvYtxAuE
         ChljG8LA6LACbzUayIBEb39QjQHZvxLL6vreaSrJMs6mRG4J9QTryhPdFjopWPkybZ8o
         Ws8oKHWYMq+KldomoroDHNL2x2zzZeWXj0ASCb4VdGEMJgdAjawQc5evbwo/Y5afFMFn
         NOO4imMsCjjeNMswSRsKCh6Dy0FcDaL4p0W38y4Jetnpp/j8c4N5HSXQCMOIyZG8t0md
         Gw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRFw21Y3GHtjY/j55cNhExDPYtfdNGDgS0NM2bUrYoY=;
        b=NMj/uvDVvSsIXzc+08epzqabBfKeKgg2JpPVrW5JJ4ikvgVYJeFfz5zENTpCboRh93
         anbhLvWfA5xpTaiGVw0WSoMNydHv83P3tHkLedsU6pBV+ADJRicEeaDJFgUa4NpgYLBo
         FzYZtSr99vyCIh3zVjInNivWZnuEphwe0ovPLqkvcrzUKBNzn5Bie70NZrYuza7IIKj3
         wvKZJb3OLZx9U6YuaU0fcof/4J9SeZD4AT4K1s1aODY2Q7Yx7Iw8Wh0VAjSGd5RxI+4x
         h5UE+mhGcVEb+uvEjoKEpAZQGsQKjRSVguztTmSQZXgj91LYYNhckOLQhDXVqJbTFOsG
         1LPQ==
X-Gm-Message-State: AOAM530pAq6AS9/N/egO4Ot8pNEEW8Tf4C438Cn2LfFzbpCzk105rIdQ
        4Yu6VHvWo8KJlK3Ws/WsgymZVFHHL1nQ2BxJsJg=
X-Google-Smtp-Source: ABdhPJy/UDXVt9O4VOHOOrHmI2wnr16YZifH4vNFNmL2As8KoZsu10YfotP+piXzkml9ZLwcUpEsBznTgTev4JUFcyg=
X-Received: by 2002:a17:906:8258:: with SMTP id f24mr23697665ejx.551.1600248948023;
 Wed, 16 Sep 2020 02:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com> <nycvar.QRO.7.76.6.2009072051470.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009072051470.56@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Sep 2020 11:35:36 +0200
Message-ID: <CAP8UFD0_75zR3xoBzbVZjgTY2+KvORLFNMZ36s8+m6KZyNTXPg@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho and Kaartic,

On Mon, Sep 7, 2020 at 8:55 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Mon, 7 Sep 2020, Kaartic Sivaraam wrote:
>
> > On 28-08-2020 12:26, Jeff King wrote:
> > > Are we interested in participating in the December 2020 round of
> > > Outreachy? The community application period is now open.
> > >
> > > I can look into lining up funding, but we'd also need:
> > >
> > >   - volunteers to act as mentors
> > >
> >
> > I'm willing to co-mentor a project for this term. I don't have any
> > particular preference of projects, though.

Thanks!

> > > I would appreciate help to find project ideas though. Are there still
> > > scripts that are worth converting to C (excluding git-bisect.sh and
> > > git-submodule.sh that are still worked on)?
> >
> > I think Dscho's e-mail linked below gives a nice overview of the various
> > scripts and their likely status as of Jan2020:
> >
> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/
> >
> > I'm guessing only the status of submodule has changed as it's being
> > worked on now.
>
> No, not quite. The `git-merge-*.sh` ones I called "trivial" are already
> being worked on by Alban Gruin:
> https://lore.kernel.org/git/20200901105705.6059-1-alban.gruin@gmail.com/
>
> And `git-legacy-stash.sh` is no more, as of v2.27.0~180^2.
>
> But yes, other than that, my summary still holds.

To summarize more, it seems to me that only the following scripts
could be worth converting:

git-difftool--helper.sh
git-mergetool--lib.sh
git-mergetool.sh

I wonder if they are really worth converting though, as they should
probably all be converted together and we would likely also need to
convert the scripts in mergetools/ at the same time. And then there
should be a way to still easily configure things for users. So perhaps
a better way to approach this would be first to convert the scripts in
mergetools/ into config files.

Best,
Christian.
