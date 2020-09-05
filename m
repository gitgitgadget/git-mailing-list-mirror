Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A56AC433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469832078E
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjJKxUuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgIESTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgIESTR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 14:19:17 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351EC061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 11:19:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so10299519ioe.5
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LcgCpuu6WcJxI+BwMNaudjh8tgj+XwfRdDTqzIHp3vs=;
        b=IjJKxUuK15ygOmbAkURVCQDotpzKQ8Hgnf9+it/GFkIB5STb0csmbWhNxUTfKlSRZB
         vBf9poLllCpBONf8444JTrrUwLgebXqffYi0VEa2CTT0Vl9LlWZvx9eEJUZCEveST9hQ
         wI+y/MAOSKmEDalTJD/DH8ZuWsPFMjsVdjSVj5OzzSM6bxwyXX7+feW70KS9ck9ljxcn
         gnAKF7mVQRhnSmgFehvwwKkyF2pFIhNqOZZCv4mnO25HBouutQuWkyrLQJAbkV2gGA04
         2xwUuNxm9bszO4oWXXOuhjV1ctW69UvplnKPzCWPfotBhUXZnxe3QsvknFQKIWAZ0sGM
         lAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LcgCpuu6WcJxI+BwMNaudjh8tgj+XwfRdDTqzIHp3vs=;
        b=b1CPvM/O44dJVlYZNTA3RVLEfHPf9jpZG/hRF8LXl8Q6QfXOEBKpaGkfPgfxUSXllN
         o6XVEm5oao7OewF0C0BHKuHvsIiPd2469Mi7yofI3QK9iFYVrchAl7Lh0mg8XPrNP/WN
         O8308rPS57MrCFy3B8YLKYAVDSk9lwaJTTYxmYVWJPrGWYteCfubS316WndsmRzb+I7H
         xHW6yT+9kpjXuyI8DvXlqbbRDPGQX69/Fdwrf5Vl4Wq1qAmBq+Xid2m542aeSfI43/E3
         witaTdTj8Rzbl+xEyfEF0izFjkCNKp0aDqFh8eACcJlXoDuIpBpiYByUWnVaBUjuKYLi
         xewA==
X-Gm-Message-State: AOAM530X19+dteyD/JHRxEukudik6SBWo1M2koer3oGp9hdTIU1F3eeC
        OA2ezF1X5vONvmTNoZpGZyQLYHmWmBdJ0KKz+c0=
X-Google-Smtp-Source: ABdhPJz/3iWXM5gzo2diPcB2LHl5NKLAPFt1vG6AFkxxp6nMKn76fFdylJn7KbCxOC9x7c+UozW6lRC5dvlX7jg3oWc=
X-Received: by 2002:a6b:d203:: with SMTP id q3mr12211096iob.20.1599329955152;
 Sat, 05 Sep 2020 11:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596480582.git.me@ttaylorr.com> <cover.1599172907.git.me@ttaylorr.com>
 <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
 <85h7sc9m0v.fsf@gmail.com> <20200905173825.GA6820@nand.local>
 <CANQwDwcWveN03h=Ex0GFo-Mm89UT8_HXFMQcZWdDx9MPZYYodQ@mail.gmail.com> <20200905180120.GB6820@nand.local>
In-Reply-To: <20200905180120.GB6820@nand.local>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Sat, 5 Sep 2020 20:18:40 +0200
Message-ID: <CANQwDwcD5XD3e7ar=8HPupobOZGDN4bgQJBS1Ad1m2NDx8eurw@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Junio Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Sat, 5 Sep 2020 at 20:01, Taylor Blau <me@ttaylorr.com> wrote:
> On Sat, Sep 05, 2020 at 07:50:01PM +0200, Jakub Nar=C4=99bski wrote:
> > On Sat, 5 Sep 2020 at 19:38, Taylor Blau <me@ttaylorr.com> wrote:
> > >
> > > Right, once we get handed back a filter from
> > > 'get_or_compute_bloom_filter()', we can't distinguish between (a) a
> > > commit with too many changes to store in a single Bloom filter, and (=
b)
> > > a commit with no changes at all.
> >
> > We could change how we store either no-changes Bloom filter (as all
> > zeros minimal size filter), or too-many-changes Bloom filter (as all
> > ones, i.e. max unsigned value, minimal size filter). This change would
> > not require to change any user of Bloom filter.
>
> I don't think that's true. Say that we changed the empty Bloom filter to
> be encoded as only having the most-significant bit set. First, we'd have
> to write a Bloom filter where we didn't have to before.

That's true.

>                                                                          =
      But the real
> issue is that commit-graph files generated with new clients would
> suddenly be unreadable by old clients.

Actually it is, at least in the form that I have proposed. The Bloom filter
which has all bits set to zero would for every possible path reply that
the path is not in set. Old clients would therefore work without changes.
Therefore this is good representation of no-changes Bloom filter.

The Bloom filter which has all bits set to one would for every possible
path reply that the path is maybe in set. This is a good alternative
representation of too-many-changes Bloom filter. Again, old clients
would work without changes.

[...]

Best,
--=20
Jakub Nar=C4=99bski
