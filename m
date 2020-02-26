Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0480DC4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 06:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BC721D7E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 06:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEH/skjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgBZGR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 01:17:58 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:32933 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgBZGR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 01:17:57 -0500
Received: by mail-ed1-f53.google.com with SMTP id r21so2389193edq.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 22:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdbhUoW60i0I0CZiKbOKHqzeimeAzkS4x6YBBoloEv8=;
        b=nEH/skjAcDzqsTjb7pfjPZzKDpGX74dnaA6KOZvHbUifpNe6M4E2iajlNeJ3s1qClP
         k5cHfxdQGjYmF+n4L7Rqh4n3zsWG32AFsso+53Dmf7RWm4ZVKEnFp6UlhFkJGZPNlMj2
         m9bVzjytg/haOzj8SWKw2Qqixt7QTT+h8uqo+aUId/VSmdBwRmXtlcwBXTmB7qOUs60Z
         hW2jxg2dVM2xGcwydpkrr4xZrmimL8o6pbBoroV6Ebe/hemW27FoleWN/6CslkQq6x53
         FFc501/kG0FBJyIOM6gCRQX+tgtfE2/QYyzZXd2lbdzC9CVBAVn8NtVzRCdzw5EsuczG
         6fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdbhUoW60i0I0CZiKbOKHqzeimeAzkS4x6YBBoloEv8=;
        b=OX9/R/rI2ZhPiJ599pN36nXxuyRzZzFsJw2qKalplKrwoFqPge4ZGUpqBYKG+c43zp
         XB6S3FP7+UM85q8G1Af8XHqugTFncC5SXN8wm1A91Jxyq9DNpqYm4LCoEjCHT5uujp7U
         OlXnngU056CK7rUxrIN2Lt9G+omDv7JShPTBw3TL1p6xjvGb3ieQmeCIwx779BM3JYv+
         g63biO3cQdCafS/tn5wGi2jTlbA+RDyAq7bY3nJvo5wRcJLK/GtCRr6VCPCNyfHI0L0D
         b2ppdWFyBKdHO0+yqg/rHBmlpjU1NXvYbTyUIMfphuxuX9ph9l9hr+FTNQFDqSX4siCe
         vtiA==
X-Gm-Message-State: APjAAAWfLR2zxHGEcPfNi6aKGlyEG/igDPDsov90e7RhTAr/mCEDHrD0
        PsCaDfCd00v5OVgRhwKqInJ/qZzRXv8YuchUL00=
X-Google-Smtp-Source: APXvYqx3YTokeB1rN4hy6t2dKrHgkBcL1/TaFgdqKVXYx2/dlAp6nLsQdoH8sgqZf7rsJ+OJ1BnoH4e0gGOVv9qf8Tk=
X-Received: by 2002:a17:906:4e07:: with SMTP id z7mr2753283eju.201.1582697875764;
 Tue, 25 Feb 2020 22:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
 <20200204163716.GA7308@coredump.intra.peff.net> <CAP8UFD0tGZzLo2=u06mzd5YbiEEHREByWk8j91CTedfaFNw3PA@mail.gmail.com>
In-Reply-To: <CAP8UFD0tGZzLo2=u06mzd5YbiEEHREByWk8j91CTedfaFNw3PA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Feb 2020 07:17:44 +0100
Message-ID: <CAP8UFD1XdS7aJYELwYP5TLdu1Z6xn_WS+B8bcwm11xPOLwwn2A@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Jeff King <peff@peff.net>, Heba Waly <heba.waly@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 21, 2020 at 11:27 AM Christian Couder
<christian.couder@gmail.com> wrote:

> Emily and Jonathan, If we participate in both GSoC and Outreachy this
> summer, I think it's better if we share as much as possible, so I
> would suggest we just create a "Summer-2020-Microprojects.md" and a
> "Summer-2020-Ideas.md" that are common to both GSoC and Outreachy.
>
> So I am planning to rename "SoC-2020-Ideas.md" into
> "Summer-2020-Ideas.md". I will also create a mostly dummy
> "Summer-2020-Microprojects.md" that we can fill up with micro project
> ideas.
>
> In the future we can perhaps continue this way by creating
> "Winter-2021-Microprojects.md" and a "Winter-2021-Ideas.md" for the
> next Winter Outreachy round if we participate?

First I should have talked to Dscho above, not Emily and Jonathan,
sorry for the confusion.

As it looks like we will only participate in the GSoC this Summer and
no one replied to the above proposal, I just created:

https://git.github.io/SoC-2020-Microprojects/

It only contains things from the previous year
(https://git.github.io/SoC-2019-Microprojects/) for now.

I am of course open to any suggestion about things that could be
included or things that should be removed.

Thanks,
Christian.
