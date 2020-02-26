Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B43C4BA06
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 00:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3745221927
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 00:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtIuAyrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgBZA4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:56:00 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:36945 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBZA4A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 19:56:00 -0500
Received: by mail-ed1-f53.google.com with SMTP id t7so1642056edr.4
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 16:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiFDlAVXqQsGjUuj0uTwRwoy0gX7gyAFS3WB6BIpU/g=;
        b=YtIuAyrSKlPpQf/g5IJCKg2MoUThjwpCPOo2dF/FP/iApio5VbQALn0GDmTBJVBshA
         9DsS5LMHVuIw6vROfUtMxMnfEcxFfu1QQtcOLJVcVZBqNMniLx0qMOzeDs/Ek8G+A1Gh
         59ppaoB5hGWJjxx6t4jZjV95w2JGtOzSTzHlIxaEQ9aq5+98DFCN7Di8v0Z4B6E5XbWW
         5n3yS3NBYWUqnugNPkwaXKFRDq72EnTnpVk5d5BkDaaPak36D/ZHHd1+IjeCSDGptmTv
         pKyHPoMGNR/L/7OIIZ98/iDXLZvYu3mGZnMkeVby4x1J75HDIqvoyMsEQbZ0AtXdLfnd
         bseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiFDlAVXqQsGjUuj0uTwRwoy0gX7gyAFS3WB6BIpU/g=;
        b=NjpSigYrN8yBirqCNpNqSCNN0eCEQjaSSEBjJb77RA2lrmC1KuePgXLIOFsxagvqdh
         OZtEd2NVy/FpiS5levgl/fqbAY4ep1s0bw5enxw13e3yLib0t9B+xuRQZ8g+qCcXUZI+
         LesCXmoJhC1gtgRl/R65iLhZ0sSKjfHvMWX5uJgMBjQu+ji8I81SDHVKHBCCrZzUlxUg
         XFCKzcUkzarUIaPPaLHebKBfx7diDsQGDf74ydc33IV30fZV68s7uNU09XseXAG92Ob1
         NvV6i01Sv5mclx2NBfFpufd7XLAFX6rcqYdNrHIDalnbrbnWCsolA3M1w2T+qozKwDKP
         dHWw==
X-Gm-Message-State: APjAAAUdLWWySWovdgNA+CHWjTqb6WykvHswKpmX7jVvTYvqFrtkR4s1
        f/RSKZQ53KEq1Z2XHOeuwwh+yjBbMr1hhTg2qTg=
X-Google-Smtp-Source: APXvYqzyMjuevwmkzEJGCBMp4fjxXCfNzMmFwW3F66R2FMlsSMWyugHo6aAAzriULammn/t6oguxDMsiqvmWp0R1szc=
X-Received: by 2002:aa7:df09:: with SMTP id c9mr1609517edy.133.1582678558024;
 Tue, 25 Feb 2020 16:55:58 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
 <20200204163716.GA7308@coredump.intra.peff.net> <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
 <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
 <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com>
 <20200221183003.GA9786@coredump.intra.peff.net> <CACg5j24mH0LRHXbhgf16f+7KqOnrsh7BRovh8mR6AzHG=y5gFA@mail.gmail.com>
 <20200223214433.GA564650@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2002241648000.46@tvgsbejvaqbjf.bet>
 <20200225202014.GA2773363@coredump.intra.peff.net>
In-Reply-To: <20200225202014.GA2773363@coredump.intra.peff.net>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 26 Feb 2020 13:55:46 +1300
Message-ID: <CACg5j25qmYivZdW_=dfun-ZP5m3Zx8dcYEkf24xDhVc7xmqwig@mail.gmail.com>
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

On Wed, Feb 26, 2020 at 9:20 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Feb 24, 2020 at 04:48:41PM +0100, Johannes Schindelin wrote:
> >
> > I would be willing to co-mentor, but I have no good project lined up, so
> > it feels a bit rushed to me. Maybe take it easy and apply this fall?
>
> I think that makes sense in this case.
>

I think I'll co-mentor with Christian then :)

Thanks,
Heba
