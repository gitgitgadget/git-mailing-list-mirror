Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D3D1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 05:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJAFMg (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 01:12:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46348 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfJAFMg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 01:12:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3so10635003edw.13
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 22:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMnvg0MPIuzwv6GWsJTcaMlLqX+DayOkzVm5E5YkulA=;
        b=fGn66ooFVL2RYsUoVDPkJW1FRkFgTVNDjl3A3ZJLhgRfM0kpo3Ukg90ubkz/tY/Dr6
         J1oOJyMTKTEjsH8NgGL3QKNeO65100KDosxr6p+Y1RRqRwonFUl54AJ9LkKEWCSXOe+B
         cXPOjKTfCYYxMD7U0Uk3zCFg8SNXm79PvtRxvcUHV/5w3spi5irTlY+cz/McgesZ104/
         X374crAPiTBnsqRgh536QloF4KMHHqvc+v91qsburUrV9tI0x5jcgDGqHk9B2I9Mhc4O
         fU4RRyxFWcXLLs/hNpTf8X3SeDTUbhCV74kTEOZ/PCeee2Gc5GDs/aNkqt4MXqXIJA8c
         ZmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMnvg0MPIuzwv6GWsJTcaMlLqX+DayOkzVm5E5YkulA=;
        b=hHQ7VniL8IZi2qOHDMLY50TIB1e/usS1b1t7gka+Dddql65VIpTQR+N4iSqoMr8aCk
         lTSlSWvr1UghdIAKOPvXiSA6SUBRjF4Ra6u60JeQsq0A1wYn7uPgN+wwBtdR0OY/QYDw
         wQDsfPe0X0jHZK9draQ0EaGpzb/zVN+UezlJZqacvdPs3Rt2NBhlCqAzoYA6Ec/OGS62
         W/ndexPmwSBjA1G6ZILFIiqS52A+oI5URHM+aPVqGUjDUGuknKJk0UL10bGOjxi9Y79P
         CODH8HPewsNLWBgSehYGFxQ0FYxK80OHPmwxQpmy3elY63LJMPx2mMtuXzyibF82Xlkc
         fGcQ==
X-Gm-Message-State: APjAAAWdj04l8PEp1t+HQp+AHxrzQrqW4canDHV+2I2Pcup5EMrd/4V0
        1Ks5m4KorOanHK+5yeKAz34IiWzAJfBydUYY3HaMxQ==
X-Google-Smtp-Source: APXvYqyq90uw0Be24gHIi0M9VITdKg4ihwoei9cDZt1JPeWXL8pm/HyemUVeQ0DBVY/Km2QaFKRCIde43RtbFcctiDM=
X-Received: by 2002:a50:852c:: with SMTP id 41mr22860805edr.201.1569906754911;
 Mon, 30 Sep 2019 22:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190930202818.2172-1-emilyshaffer@google.com> <20190930220355.108394-1-emilyshaffer@google.com>
In-Reply-To: <20190930220355.108394-1-emilyshaffer@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 1 Oct 2019 07:12:23 +0200
Message-ID: <CAP8UFD3vdf-WHeoBaiJw5S_uUPegY_UENLKOKoMV6QVssv=QDQ@mail.gmail.com>
Subject: Re: [PATCH v4] promisor-remote: skip move_to_tail when no-op
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 1, 2019 at 12:03 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> Previously, when promisor_remote_move_to_tail() is called for a
> promisor_remote which is currently the final element in promisors, a
> cycle is created in the promisors linked list. This cycle leads to a
> double free later on in promisor_remote_clear() when the final element
> of the promisors list is removed: promisors is set to promisors->next (a
> no-op, as promisors->next == promisors); the previous value of promisors
> is free()'d; then the new value of promisors (which is equal to the
> previous value of promisors) is also free()'d. This double-free error
> was unrecoverable for the user without removing the filter or re-cloning
> the repo and hoping to miss this edge case.
>
> Now, when promisor_remote_move_to_tail() would be a no-op, just do a
> no-op. In cases of promisor_remote_move_to_tail() where r is not already
> at the tail of the list, it works as before.

Yeah, thank you Emily and Peff for finding and fixing this! The fix
and the test look good to me.
