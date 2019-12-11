Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C07C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 13:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A0020836
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 13:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOUmH2xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLKNs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:48:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35295 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKNs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 08:48:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so19479061edv.2
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 05:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5KxuO7GplOoZWH34DFx5psLcIK8wP0l9tGHT87x9Bc=;
        b=iOUmH2xhogAdWHBYxNLLID0tFNcR4n0T7f5YGG0t8iXBrzBEbHrsg482kgCa3iNTgz
         XZ1DvD5eH0uoVI1oNIVjNCzHj9NUX4sHu1M5mCb3KdqDQu59fe//oswtu471exURIMUJ
         NyBCTemc6tA5oAChnnejspzZzOSAqAksWayvZ5tmKeg5YZVyr6GRC+xu0mbuZccrgGmQ
         dBVB1tu98GdjRY8o1TYNbEdr2+88wSTTY1Twj7ZRjJCyq3/k1GcVU0SgdqjlDWSgUfzh
         Dn5Ps3wZUOh1hdZvvfCi/1Kcn37OE7llJLjv8SX1JnlP1lmz4vob/Aiu0ky7Xx920apc
         4NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5KxuO7GplOoZWH34DFx5psLcIK8wP0l9tGHT87x9Bc=;
        b=LdzPZ2Ucu9IvASlApqeIFwNvqv6/RD7WmFjfoR7ox4IvIw6+/do8V86h7j6L1hSbxi
         tpnZoO8zO4KWv19hts2bOBHckeKxHH90vqqNpyNjR2KI7d/N9lAIvwqFbtvAIUk4qknb
         TD1UAn5GjeInN8TcGDcuGmfdkBzgyv30ccnrdvk/V7kYL8tGGl4sn7g5tJnTgnBFsBia
         zU58eL2qHXKxhY9emPkd7c/1oH456pbBpUBD84T/QVG/+kbNbKWmPZEasY6VJ9dM9mzB
         8sdL+VLhp/e4pF1PdCvRlGxBejzILbzvf5/7nPsgZe5Pv7WvjjfHxmXDM5Lg0qRRmkTs
         zNoA==
X-Gm-Message-State: APjAAAWjp6gqXaA+WgjMxyf7Yg6Cd9KxDLxeewspE1ATEb+HT1c4chDr
        5f3kf59caYWda9zvjnzfitaNVJtSj8i+rZ2Pz4M=
X-Google-Smtp-Source: APXvYqwckjm2yru226adx6pDC0E8wxyeZrTw1R/HrGejcvyOFvyUbNEsHlX+gGYETLwsvBzCVzGj5Uqg7v5h49bZoI4=
X-Received: by 2002:a17:906:681:: with SMTP id u1mr3250636ejb.81.1576072134449;
 Wed, 11 Dec 2019 05:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-2-chriscool@tuxfamily.org> <20191209062449.GA40570@coredump.intra.peff.net>
In-Reply-To: <20191209062449.GA40570@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Dec 2019 14:48:43 +0100
Message-ID: <CAP8UFD0YCSW_zDZ-OBif_MUBV3tkGR5554LSdFLkQGTegTxnqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] builtin/pack-objects: report reused packfile objects
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        James Ramsay <james@jramsay.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 7:24 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 15, 2019 at 03:15:33PM +0100, Christian Couder wrote:
>
> > From: Jeff King <peff@peff.net>
> >
> > To see when packfile reuse kicks in or not, it is useful to
> > show reused packfile objects statistics in the output of
> > upload-pack.
>
> Yep, I think this one makes sense. I would be a bit curious to see how
> often reuse actually kicks in for you with the current code. Back when I
> worked on this topic in 2015, it was kicking in for us almost-never (at
> least for big repos like torvalds/linux that we were interested in
> measuring), but that's because we were packing all of the forks together
> (and still do). The earlier heuristics made no sense for that case.
>
> I don't know if it's really worth spending a lot of time trying to
> collect data, though.

Unfortunately it's not yet easy for me, or people in my team, to
collect data from production servers. I will try to ping people about
that though.
