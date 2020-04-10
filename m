Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BB0C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947B2206F7
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 07:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDicPEnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJHJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:09:27 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33695 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgDJHJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 03:09:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id y138so867128vsy.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 00:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5+odk+btvMsspS9TAX1+FCJzLvHzwFPL7qrkB7RHZlk=;
        b=TDicPEnQs1V8Ire89UZ5wraMAsegPO+JuFYHJRofczWHu4ck73Q99Q13dZO/L828vh
         d2rZTJzfs8Il386cv0/weEnQat+LMeGJjlHo8APoJ8ZW1ZCQK79KG85eZk2MJpzBPWtK
         xkb21Ncu72Yc9M92dWUfiAtZVbhg/3Svzet4n335JC2erxPCyq9UduRPXT8hgnYUfceU
         8aa0FAgbH79mv0jNJNDSAgPEgp/pyiyaSUdvfuFfw3gFvzjFZu6u/QmThJ0CLMKEWogS
         N8f31LiPOv5IhmZlwzDlfxs9bNp0jzwUATDI+vOozwZOUmvosRyVde/wVOh2/wvoACw2
         cnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5+odk+btvMsspS9TAX1+FCJzLvHzwFPL7qrkB7RHZlk=;
        b=A5yUvF6HopAydz7+1A871nwFSlnHFieTgjvb5n2TWDi383/bIP+F6D9IHBNABhfro2
         7QKg3ucEQxCB4Eskc9XfyWtUtUC0aI+6plTSco3Ik1Bo5OYZzNmi757ijyaLDvt5iVHl
         MtmSQbMLeffv6QDJNElAvvdyq4wyd/kigWuNRJ34k7ZoStLxz3wVDgyU7UJ4zv6unurz
         VhRPYlapI+E9f8KJU3VAYvnVx2/gc4eh86YNWs5hKw3OJiGYSNnYnkRPZr74Xp7P31XS
         pZr+7AthG2J0BTwQNQkCNlMa66GfukFCHASMSJ0fw19n14+mR0KxaP5mrS29sJvLNwG3
         H4jg==
X-Gm-Message-State: AGi0PuY8wkJ+WFFEjCPzznSv2pLneHDnhbgi3HIrbs3H+i5RfhKfIOwt
        kymkvJcf/Qtiol6mhBu4wnl4KzGe+wFy5salmvboNw==
X-Google-Smtp-Source: APiQypJROnG6Qb4kYnHfqGMFhK2aLx3WY1VMhXJreKK/e8gfrRlTJFarGEDNVK5e6UR+A0tBUdpPU200rhqpujRq2PQ=
X-Received: by 2002:a67:c592:: with SMTP id h18mr2772581vsk.118.1586502566075;
 Fri, 10 Apr 2020 00:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200409103541.23743-1-martin.agren@gmail.com>
 <20200409141452.GC3494212@coredump.intra.peff.net> <CAN0heSp3=8fTGb5Ciuvr8+EevNSrAfskvrrS_PN=VPhKJyB5jA@mail.gmail.com>
 <20200409155159.GA4129050@coredump.intra.peff.net>
In-Reply-To: <20200409155159.GA4129050@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 10 Apr 2020 09:09:13 +0200
Message-ID: <CAN0heSqF2minprAb2Ss-rE94cWngm7-A-E8uB8XuOnu8SGz_Qg@mail.gmail.com>
Subject: Re: [PATCH] config.txt: move closing "----" to cover entire listing
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 9 Apr 2020 at 17:52, Jeff King <peff@peff.net> wrote:
>
> On Thu, Apr 09, 2020 at 05:00:34PM +0200, Martin =C3=85gren wrote:
>
> > At one point I considered trying out diffoscope for this. It should
> > allegedly be good at comparing "everything". But being good at
> > everything, it wanted to pull in a discouragingly large number of
> > dependencies, so I never actually tried it out. It doesn't explicitly
> > claim to know html or manpages (but does mention xml and pdf), so I
> > dunno.
>
> I tried it just now, and it's not that clever. A regular "diff -r" of
> the before and after HTML yields what you'd expect:
>
> A diffoscope diff yields the same, plus it complains about differing
> timestamps on all of the files. I don't think it's doing anything clever
> with respect to HTML formatting.

I see, thanks for trying it out.

Martin
