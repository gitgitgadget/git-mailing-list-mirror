Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD1EC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1464214AF
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDI7MgOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgA1PAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:00:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34817 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1PAP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 10:00:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id b18so6622113oie.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 07:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=owhYHBKf1CsGB5+zNm7nXBYgbbALNGR8jua/k62Tfu4=;
        b=kDI7MgOoFBtpd3GirafqWmXdL5teemzOvrXYml3sYulykoCjNGKYM9Fs0ARD7sD5ik
         s9R+h079IMwFeAcksxbayVXcVeLsTKoLV7VfesG5EsU5x2cFY7WJXIb/KNk50Z74wdP4
         vnZP/i4wbNZI9kkItMvn2bXjPRpk8fk3TUoU729ZZeXxz8/ikZMoqrc0TigjVuYOehDP
         phM8bRCOOP6U8zpmlE2I1U8K55TK5uvFUhWScKFZemRA6Tr3eaAbCUEph+NQ1QeTFQLY
         yKgz8sBGJQVYV5qQ7xEEda41BP6XPssUwd6jKHqoDZFhrGnD9KJoDv2fssW3ew5wOHIX
         3pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=owhYHBKf1CsGB5+zNm7nXBYgbbALNGR8jua/k62Tfu4=;
        b=iHydzyPjyyPIAKg0pLZR7MDK01gG5OXWAmK4QgJnCCg3Ohwd27KnUlUXdh8IyyfuaZ
         CDyp1/6iBmu/3sRdL1czfWlqiWeIN9ot6bN10stZwBUFcIoYLZU4XjBCx8PY9A/M18eS
         U3TN3WA5RWiAhTnHcglDXf3fbcu5HhUXPCaC4eWzq+ZjANMzpArc8w96Vd9TK6UfMlh7
         VzUv8UL9xEnXj5A9rRKQ/SUUS4bjVw+2HAnuRZXw3oIJC6Pa3ooc3mm1HHdXo3k6aTPn
         X61ZNu//czJ1+7/T0MC9QMKIbcPadOqlyeZPqmBB21dIvVg3sv/WSym+7mAiom/B/+pk
         6o4w==
X-Gm-Message-State: APjAAAWF4TTy2Z78N4XMmxsIefh8hkYw1G7BX4ucdfgn9/B9d7sa5wgz
        RoNBfLBlfdiDRjiaiP8IvXpiZ6INCTIcMZGRXJ8=
X-Google-Smtp-Source: APXvYqxWffcjlncAm2Raxx1LK3DSxWV2FDExt4LMXfxC2rXcUD04AiWFh/I0iVeVhsMvCskrA1Oh5nqzBjlgqNC0FfU=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr2932851oib.6.1580223614371;
 Tue, 28 Jan 2020 07:00:14 -0800 (PST)
MIME-Version: 1.0
References: <CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com>
 <20200127120837.GA10482@szeder.dev> <CABPp-BGvU_DHQu66bqPZ+WXg5mL8bCP5Uxp4g5393WnWyO1Dhg@mail.gmail.com>
 <20200128135707.GD10482@szeder.dev>
In-Reply-To: <20200128135707.GD10482@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Jan 2020 07:00:03 -0800
Message-ID: <CABPp-BG44ni2jeaFo8p9w7tfmbeFRS=jdVheTM8f1zdv=Txxjg@mail.gmail.com>
Subject: Re: git status --ignored hangs when a deep directory structure
 present in working tree
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Martin Melka <martin.melka@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 5:57 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Mon, Jan 27, 2020 at 09:06:01PM -0800, Elijah Newren wrote:
> > > the runtime of 'git status
> > > --ignored' grows quickly with the depth of the untracked directory.
> > > Running this shell loop produces the numbers below:
> > >
> > > for depth in $(seq 10 30)
> > > do
> > >         dirs=3D$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
> > >         rm -rf dir
> > >         mkdir -p $dirs
> > >         >$dirs/untracked-file
> > >         /usr/bin/time --format=3D"$depth: %e" git status --ignored >/=
dev/null
> > > done
> > >
> > > 10: 0.01
> > > 11: 0.03
> > > 12: 0.05
> > > 13: 0.11
> > > 14: 0.23
> > > 15: 0.47
> > > 16: 0.97
> > > 17: 1.97
> > > 18: 3.88
> > > 19: 7.85
> > > 20: 16.29
> > > 21: 32.92
> > > 22: 76.24
[...]
> > > Unless I messed up my numbers, with a depth of 120 directories it
> > > would take over 6*10^23 years to complete... so yeah, it does qualify
> > > as indefinitely.
> >
> > No comment about how people today are spoiled and addicted to instant
> > gratification?  I mean, can't folks just be a little patient?  ;-)
>
> Nope.  Notice how my shell loop above goes to 30, but the results only
> to 22 :)

I was specifically referring to your 6*10^23 years estimate when I was
jokingly suggesting just a little more patience.  :-)
