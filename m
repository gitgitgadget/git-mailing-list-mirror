Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FC8C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbjAJNdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbjAJNde (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:33:34 -0500
Received: from ns6.inleed.net (mailout6.inleed.net [IPv6:2a0b:dc80:cafe:106::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA13BE9C
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bakskuru.se
        ; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date
        :From:In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nh9raGOkaufGhGnHRj+xJrjOFueEkVg4W6oCqftQRmg=; b=LnWFp8dRh9DKEwod3Uh6bZG1+4
        AJyo6hAL/YGE1/sXUANqYxkUVrUVqKMYmW/vOW6cPERNUjNIMo/D/NSX/Skr+0SneYpedAG0k95xH
        Ka79zsrpGQblX45y97hn+IQqb6dOZJ2djtO1LhwhFUpHY9rsNBsAUSCdV03fK39MmpL8luYvxCl7l
        QgHy33lc/2LhVjEYIKR0aDAb0WNG7ufhdlosComEz+A/uistfPGxmjctiw/5NoV0706tPc7sgvQi5
        keNp6RSApgw4tNp9g9k8UjsPHWe+0ggciVYJ5QhfxSb3ShLR2f1uqRzq52A1AxfyZQscjmY8Cn2M8
        i0T0JhWw==;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
        by ns6.inleed.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <fredrik@bakskuru.se>)
        id 1pFEkq-00De0A-0Y
        for git@vger.kernel.org;
        Tue, 10 Jan 2023 14:33:28 +0100
Received: by mail-pf1-f176.google.com with SMTP id s3so6298815pfd.12
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:33:27 -0800 (PST)
X-Gm-Message-State: AFqh2krEodySiIFMKIFZVD5dGAZon/7SyEzTt8/5a2fqcSKmOApfx3vj
        S6F+O9iiAmoCtgkdp59D4Zmau4mvcTgELsmakRg=
X-Google-Smtp-Source: AMrXdXs0nybrC1N6VhRqrbzIJ923E36nbqBlM3ncOOybUN0NlDSK+Luw19DFqldctJDOB+YqfQmkO5XRUnQBxv5TzEg=
X-Received: by 2002:a62:1556:0:b0:58b:87f:9a70 with SMTP id
 83-20020a621556000000b0058b087f9a70mr100153pfv.1.1673357606187; Tue, 10 Jan
 2023 05:33:26 -0800 (PST)
MIME-Version: 1.0
References: <CALDp=1EVmQE2NZAd7ccAT0z=R=2S8FvyJzsPNrDeXwdJkEW3Lg@mail.gmail.com>
 <CAN0heSprKD35P-D7GTVQ20eRsj0AriYEA7iCDnrA9GuiwX0snw@mail.gmail.com>
 <Y71Xnx2vmznV913I@coredump.intra.peff.net> <CAN0heSqvqnCHPa-RQ3JuxxP7M_k1ORYOAV9aG+8EuXvB1GZukw@mail.gmail.com>
In-Reply-To: <CAN0heSqvqnCHPa-RQ3JuxxP7M_k1ORYOAV9aG+8EuXvB1GZukw@mail.gmail.com>
From:   =?UTF-8?Q?Fredrik_=C3=96berg?= <fredrik@bakskuru.se>
Date:   Tue, 10 Jan 2023 14:33:14 +0100
X-Gmail-Original-Message-ID: <CALDp=1GBtibTR5SvG8sOX14aODtdEJWhL_PCP1mzTLmX9V0sow@mail.gmail.com>
Message-ID: <CALDp=1GBtibTR5SvG8sOX14aODtdEJWhL_PCP1mzTLmX9V0sow@mail.gmail.com>
Subject: Re: Bugreport: Prefix - is ignored when sorting (on committerdate)
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: fredrik@bakskuru.se
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the  quick response! I've been playing with creatordate and
it seems to work with with both older and newer versions of git.

I am trying to understand what I did wrong. I guess you are saying
that I tried to use the field committerdate, which is not available on
the tags? And that the handling of this situation has changed since
git/2.23? Hence I got different results?

/Fredrik

Den tis 10 jan. 2023 kl 14:05 skrev Martin =C3=85gren <martin.agren@gmail.c=
om>:
>
> On Tue, 10 Jan 2023 at 13:18, Jeff King <peff@peff.net> wrote:
> >
> > On Tue, Jan 10, 2023 at 11:54:16AM +0100, Martin =C3=85gren wrote:
> >
> > > I suppose it could be argued that the '-' should be applied to the
> > > fallback as well, e.g., to uphold some sort of "using '-' should give
> > > the same result as piping the whole thing through tac" (i.e., respect=
ing
> > > `s->reverse` in `compare_refs()`, if you're following along in
> > > 7c5045fc18). With multiple sort keys, some with '-' and some
> > > without, we'd grab the '-' from the first key. It seems like that cou=
ld
> > > make sense, actually.
> >
> > I dunno. Just because you are reverse-sorting on one field doesn't
> > necessarily imply that you want the tie-breaker to reverse-sort, too. I
> [...]
>
> > I could see it depending on exactly what you're trying to do. Which
> > leads me to think the rule should be as simple as possible. You can
> > always do:
> >
> >   git for-each-ref --sort=3D-refname --sort=3D-committerdate
> >
> > to specify exactly what you want.
>
> Indeed. So probably best to leave it as-is, then.
>
> Martin
