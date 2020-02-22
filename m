Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C09AC35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DF7208C3
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 07:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnK8KSHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBVHUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:20:17 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:45196 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgBVHUR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 02:20:17 -0500
Received: by mail-ed1-f48.google.com with SMTP id v28so5242531edw.12
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 23:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClU1Tw2kFVre62bndyP6QvfMlwwehiZJKWcC7OL8aLo=;
        b=HnK8KSHbtgTztAcwA2+21EoLdYdbCkTgQRu2zBduhnWzzyQFnwgNIuzhpVEhtqI1Fk
         7aux8nngqjypxZ2q1y5Unu8MdwmIZ6HyUVfVr4Ey/MksC5IuZleF+zAfJU7u5ZgqJmXD
         1GyZIpnz49JUDEDeeGXc4TgTVRHuQ0Tiy2SZh+FopcN6GVXVP/OtoZqgmXzDjT2+OVfV
         YbX/f3Iu3/CxbXPPOI86BH6ciozNTrQYuJlBT+aMlweJFgPbaRYH3T5v0a2xwgSNMo3z
         tFTIdetC3pVKwsvNxeCwXcwVVgLdpgeRYJXp20+zKUJOh1zrB42nbWLOvklFdK0WxUHb
         DK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClU1Tw2kFVre62bndyP6QvfMlwwehiZJKWcC7OL8aLo=;
        b=Wpe8zoC+e6gdXUUzFfSQp1Ynfyp5i0bI9js295oI5nvD1i/YZHUB/dVjUYqaXPs2ij
         eh4EObpxd21Sfx7KEsJmbrPiQoUQjWuK4Yfx4orX9ibLXhLjYtErRbRqhzj5H4T1mM9l
         osMs06LMPFMngq4fr9bJXDi828kdlNufL8mfgsE/xpnnhrUC1uDZDtI9Rh4ES/1LKYmZ
         yhVR2I2diZgWp3DhgaQJGJYoJIKMKK1RvG7He77Kaijqyfeo6Z2sQRFoxGZtnSpNXlXK
         Sb/AhhfRjiBPCEIt072JebQzfVXKZs7muTYFLZGSttAAfFaOCPqWQIAnYYlDAUyinaYj
         fSQg==
X-Gm-Message-State: APjAAAViffv8eXKCbigunPImzOhNL/jD8uLa75jxg2t3l5nrurBdKCoy
        7HzVk5nilQNGz0/V8ITlYBlzGgXKm4DK5+TeSQc=
X-Google-Smtp-Source: APXvYqwCrH4OBeSukt05AFeXuFi5s0ODw++SQtSiPTLImSezudfjUbz3Of+VY9T1qhLedyyB3DLngMdd/lNvfUtmYcA=
X-Received: by 2002:a05:6402:70f:: with SMTP id w15mr35847183edx.255.1582356015574;
 Fri, 21 Feb 2020 23:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
 <20200204163716.GA7308@coredump.intra.peff.net> <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
 <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
 <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com> <20200221183003.GA9786@coredump.intra.peff.net>
In-Reply-To: <20200221183003.GA9786@coredump.intra.peff.net>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sat, 22 Feb 2020 20:20:04 +1300
Message-ID: <CACg5j24mH0LRHXbhgf16f+7KqOnrsh7BRovh8mR6AzHG=y5gFA@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 22, 2020 at 7:30 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Feb 21, 2020 at 05:03:47PM +0100, Christian Couder wrote:
>
> > > I'd be happy to co-mentor an Outreachy intern with an experienced
> > > mentor, hope I'm not too late.
> >
> > Thank you for your interest in co-mentoring! It's very much appreciated!
> >
> > I don't think you are late. It seems that February 25 at 4pm UTC is
> > the deadline for project submission.
>
> I think it is too late. That's the deadline for mentor project
> submission, but the signup for orgs was Feb 18th.
>

Hi Peff,

You're right, but they mentioned on the website that Feb 18th is for
new communities who haven't participated before. I double checked with
the Outreachy organizers and they can still add Git if there's funding
and a mentor is interested.

I'm happy to help and co-mentor on any of the two programs.


Heba
