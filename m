Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A3C4BA0E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F09222C2
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWW9fXkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBZKRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:17:37 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45082 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgBZKRh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:17:37 -0500
Received: by mail-ed1-f49.google.com with SMTP id v28so3042649edw.12
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsEcuWTbJBsCPji6cNEPi2/KHAA95A2r1ZQ5uTbi1Fo=;
        b=TWW9fXkfYwLO/O26Cf4VgSmVSxM5/PePQDED8qkEjq2hA/qhv10IT/QwbUMDVZPvCQ
         7EXsnGszAxKHelb8u6mDdE9hmzFp84L2ddSaA2IMxNKExDpabSRZjoo2VvoYpS8K5tyV
         Zx2Ydom2khwqpi4nt6kd7yEyP5bizaFP643p3T1pkWGuAxJ3ZCRFruDkH7/QBOEE55q5
         lTeeOL2rxrBP9UXYrTR7FPcPAyKqhQxLAZ2Iwk1r/MsX4fvMJ7wST201Lr8Iu+5GoaV+
         6n0PziwljGk8YaBhz7vojZNBWJ5A5SRodhCcEDAUtykYKn9joq0m1bx0PmNPu+EMpmq4
         xN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsEcuWTbJBsCPji6cNEPi2/KHAA95A2r1ZQ5uTbi1Fo=;
        b=CSPHvoTuocyRc5aV5zeJPnjaWVOOLW5x0+U3kbBw2I7NR+3xYf1erCo04RWGUqY6Mw
         YxY1MCa5iqr3Zh57EiTBaRKc7b8KrxPkeXEUd1v4BZgc+MyMjMInMJ2SRHcgDwlaP7un
         VeUvrsO7kuPs108x/Y203C6ejTroWoh8mBh9s1RM1OOYR3J4eH7bXborqdglxisBKLkD
         TP+6aWRq5eHT8arEhgOuxfULnPtMQkJ0ZFhH3fvRfU+IPvw675kx8QwybgfIPjPUMUqX
         91yNySmiqslm9VDLnczG4/+IO8AgRXFF01fZLayej3tvmplHS6jJfw+pU+38LjQRuD+B
         jaUQ==
X-Gm-Message-State: APjAAAXF+r4tF6z/oHGC67lh5X0XhrZPXge0FUtiS99YswhhiwxFe6vX
        1JvtuXVkdWU1hh2Kivm0QpHq1CJhXb3vazn/ZkD/y333UCU=
X-Google-Smtp-Source: APXvYqwpoqbtyk0PHIYq7XEdBwoee7Vytndmgg+IixZUiDJGRtjOTrdenmWLH+nlC7gigr9vRkjQ1Qu3CPD18eKmxAg=
X-Received: by 2002:a17:907:375:: with SMTP id rs21mr3905346ejb.352.1582712255556;
 Wed, 26 Feb 2020 02:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20200204163716.GA7308@coredump.intra.peff.net>
 <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
 <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
 <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com>
 <20200221183003.GA9786@coredump.intra.peff.net> <CACg5j24mH0LRHXbhgf16f+7KqOnrsh7BRovh8mR6AzHG=y5gFA@mail.gmail.com>
 <20200223214433.GA564650@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2002241648000.46@tvgsbejvaqbjf.bet>
 <20200225202014.GA2773363@coredump.intra.peff.net> <CACg5j25qmYivZdW_=dfun-ZP5m3Zx8dcYEkf24xDhVc7xmqwig@mail.gmail.com>
 <20200226014228.GA2913263@coredump.intra.peff.net>
In-Reply-To: <20200226014228.GA2913263@coredump.intra.peff.net>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 26 Feb 2020 23:17:26 +1300
Message-ID: <CACg5j26XTA4Z5pnBKWJiF6-dxTA7LJ3ZsxSi1ZvHbK4qZ9jhTg@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 2:42 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Feb 26, 2020 at 01:55:46PM +1300, Heba Waly wrote:
>
> > > On Mon, Feb 24, 2020 at 04:48:41PM +0100, Johannes Schindelin wrote:
> > > >
> > > > I would be willing to co-mentor, but I have no good project lined up, so
> > > > it feels a bit rushed to me. Maybe take it easy and apply this fall?
> > >
> > > I think that makes sense in this case.
> >
> > I think I'll co-mentor with Christian then :)
> >
> Just to be clear: you mean on GSoC, or trying to get something together
> for Outreachy?
>

GSoC.
