Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8171C3403D
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 14:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804D921D56
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 14:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw1JKn0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBROTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:19:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33817 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgBROTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 09:19:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so14674788lfc.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 06:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aonO6yeC5t8utxiEHX/faolP3tsTGJIxsgUYNP1uPI=;
        b=fw1JKn0aamzAYF9VMzddRnD3uu9GGNIEufsF5FksZJzfKxP9SJsdXqCXZSitxMTd5Q
         KFgk3/jfipbn0yhJr5TgHLxcHZF5CiBuKH/bsCG8Qra8hepKnTo19PmwmTJbWXOB3PM2
         l3RpqprKD42cRQKdEdwz2GPmYNMwQZJxv2pBDzRQEThm/VBC5y6tsOmWgVdDaWQnlhZ5
         TRBUH5AVMP+kpKYFchffHlW/GACe2Ala8jiHIqQbfhlICfxM4BAcfKtXSHTlzfYd6n0H
         ambl8X7c+WAip5CatleCmGOea+XxkSJIKR7muaf8ZrvCbAnPBDhnIeoPOyG8v0vIVh8z
         QebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aonO6yeC5t8utxiEHX/faolP3tsTGJIxsgUYNP1uPI=;
        b=W46BJw9BaLDSQclDEH/VGtBlcPLN9v4U0lr7K0A6KC/aryv6LTnc4CAGNn1bfrayuZ
         IQGMKjJieJQ/AoZG6z9DMHu61Kqpn3RG57l6NzdKhF4VFkwxUKpgPgoE2wv7eMJmoAhh
         D4QYK3tVgrkOi/y59hGeQO34Ug9MBd/9QHkJp85xxVdyykVuRqOQGF2Q7z5fR5JXrO/M
         IH4qGO3+VOMlvsv027eqDPb3wP6KKfrfVO/+CDrWse0+E6sojh/qQO1jMFLg7bGKUrZg
         zI4nYNSgQ3Z11RJ4DdSZYDko8jt4VlhHVbikwvoVEPSdIvptTgD3Lre3wsODPZiGHKn+
         zqlg==
X-Gm-Message-State: APjAAAVRDB6CR7JnyICUePoahj2IAFzoTq2RNj+/KJoWt7hEEf5fWWCq
        6qQUpfTZ63QWcJIWSbX8EtwMadKo+1dD6Vm4D0A=
X-Google-Smtp-Source: APXvYqwCPA9Gw5igsN0n0SyVqrWILUzFBmqVKq/x/u98lgVLxp1q3iOLOHwCvtwQaDibb2KBwjfw42wa8TigQ/FfYoY=
X-Received: by 2002:ac2:5e9b:: with SMTP id b27mr10938771lfq.184.1582035588864;
 Tue, 18 Feb 2020 06:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20200218041805.10939-1-robear.selwans@outlook.com>
 <20200218041805.10939-2-robear.selwans@outlook.com> <20200218062124.GF1641086@coredump.intra.peff.net>
In-Reply-To: <20200218062124.GF1641086@coredump.intra.peff.net>
From:   Robear Selwans <rwagih.rw@gmail.com>
Date:   Tue, 18 Feb 2020 16:19:38 +0200
Message-ID: <CALH1-XoWmojFZir1JTU490GNHE1CETs4jbjswH316cAWqjF+Bg@mail.gmail.com>
Subject: Re: [GSoC][RFC][PATCH 1/2] STRBUF_INIT_CONST: a new way to initialize strbuf
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 8:21 AM Jeff King <peff@peff.net> wrote:
> Your second patch catches cases where the strbuf functions want to write
> to the buffer. But we've always been pretty open about the fact that
> strbuf.buf is a writeable C-style string. So something like this:
> ...
> would generate no compile-time warnings, but would invoke undefined
> behavior (on my system it segfaults when run, but it could have even
> more confusing outcomes).
Oh right, I didn't think about that. Ignorant of me to expect everyone to just
call the functions and not edit the buf directly.

> If we want to pursue this direction, I think we'd do better to give each
> strbuf a matching array. Something like:
> ...
> So I think there are interesting directions here, but there's a lot of
> stuff to figure out.
I think that got me a bit fired up now.

> I notice you put GSoC in your subject line. If you're looking at this as
> a microproject, IMHO this is _way_ more complicated and subtle than a
> microproject should be. The goal there is to give something so easy that
> you get to focus on getting your patches in and interacting with the
> community. The scope I'd expect is more along the lines of compiling
> with -Wwrite-strings and cleaning up some of the locations that
> complain.
I'm actually planning to keep on contributing to git, so I kind of
didn't want to
do something trivial. Despite the fact that I'm planning to apply to
git for GSoC,
I'm mostly putting the [GSoC] so that reviewers would go easy on me :D. That
said, I might actually do the -Wwrite-strings clean-up after this one
is finished.

Thanks for the help, I guess I'll start editing it ASAP, then.

- mo7sener
