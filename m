Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40136C34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061982070B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHBJkWwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgBQSH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:07:28 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:41146 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBQSH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 13:07:28 -0500
Received: by mail-ed1-f52.google.com with SMTP id c26so21640287eds.8
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4EUe0ZJZskipizuK9Ca5bfx13AAOFbLBVFe1hn/pVag=;
        b=lHBJkWwRxIgYgxWmXQySwRGxa9ZwijhWD6dHSlXQHB9JokM8VMaWjg5Gue+d7azsUt
         h0ecT2eu4m7zaHefP8PdJ/gQ/4m8MDm1nHuSHHE+reITpNoXCwp9TZejghKCalDqKZol
         LFo4TzR/S2VnO6mbLVhxbePUarufJOGPxcxWscKpGywzjfs0ATWHBiYR+nylrAwbBNL/
         GoYAyR3Yp4K4vGz+lhDD7uBJkDf7daCzpmqXkgk41En60Q8OMil+Psmy31PsD4eHWKfv
         9rronToIJlI677Q2yZdE5nBZrUZye/Yg6dpZ3iH+/Vp2ETfj52nMQ7Yb9Kd4gVBvpIIh
         IskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EUe0ZJZskipizuK9Ca5bfx13AAOFbLBVFe1hn/pVag=;
        b=b1BjRgotS4O7NKs7MXhxldqUUICOv9DJ+8AAPw0RIL7KUgQsYELOk5Jk43t0n9lUeQ
         6+EOveE6XeHt2/Mq13h3HIGKrdObe3D5w3f4HOII9VHqip6rM2odr2UP4tHV3mVZ84tC
         qeW30u96I6+jKz4tx63EJkbhoGXSM2cdY8OyQh/DUNL6ETUashS3ck7a3gkYwjj3eltJ
         zB3g3bQnYqYGmMDnu74/93yxeCoImq0MuLNguCBDo1InIWJJ6hED+JcI2KW7r9B8oICm
         2IYqNAthxk9tbKv/ZpoXb0QVz194Gt3swWbmHczIuVT+Of3Q0ZmpnVaSr+DJ07yQFUMO
         mSnA==
X-Gm-Message-State: APjAAAX60m+CCVeZSzlvwQ8CG7tr8foDVlfdolyfjnYvy5mS5idGiFi/
        vQDy/3zyK/SDNU+r1Wogj3EvYsPCmOoKJO8HcO8=
X-Google-Smtp-Source: APXvYqzEZKAX/RSGlbs1S3CX1Y2O7a/gk7jAHNvvUdFvU4qoba4knNmJiZxNd9jN1ImJkqb55fvGYn5cAG8IlPdG4ls=
X-Received: by 2002:a05:6402:1cb6:: with SMTP id cz22mr15046320edb.127.1581962846069;
 Mon, 17 Feb 2020 10:07:26 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD3fE-JHFweU+VM5xwEph7d6eUEFS23TLVsOrW6F+68QDg@mail.gmail.com>
 <20200217160311.GA79320@thyrsus.com>
In-Reply-To: <20200217160311.GA79320@thyrsus.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Feb 2020 19:07:09 +0100
Message-ID: <CAP8UFD05Mr5x2S20bhYvTCAVrDqD0SB1NHFtjgB22Kp2Q4yqsA@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 60
To:     Eric Raymond <esr@thyrsus.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Torsten Krah <krah.tm@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 5:03 PM Eric S. Raymond <esr@thyrsus.com> wrote:

> I spotted a typo:
>
> "Many attempts at importers silently botch this in practice, but least it handled automatically in theory"
>
> should be
>
> "Many attempts at importers silently botch this in practice, but it can be handled automatically in theory"

Fixed!

Thanks,
Christian.
