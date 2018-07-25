Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669441F597
	for <e@80x24.org>; Wed, 25 Jul 2018 08:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeGYJcG (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 05:32:06 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43025 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeGYJcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 05:32:06 -0400
Received: by mail-yw0-f194.google.com with SMTP id l189-v6so2559406ywb.10
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 01:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHs3pF8tSFnczcasfe8p+dPVemv3CUJxDZL//Gh0YvE=;
        b=Ad2oSHgd18U626oSgRz/LifEPlo9tSKkhfi5RDhzaVKyNcJE8A3/9inKJ/6UbRNuOt
         GdWV7MnJwRm5q/oeMS0T9tMh1nl7lXCBXGfa+qmQT440P5TxRM8zI9P8pBL9idi1/TOv
         pxhF71dHafm9f9m1MZJBKuthz1jOLNNRiOBbN9nM7Qh3tsKCzxat569CS3p0UPFWTemI
         Vbe0Bv71Iro/PU3QvTmXejvhwaun936xn/IMpgD+6HtlaRi9dpUrrDyYnP33RxrckFYQ
         j9ckrQHerr3rKcK4Txju7NNRL90eiBXt326SFjizWReEXnS5aRxz++CU8eKtti9eV/Vy
         G/sg==
X-Gm-Message-State: AOUpUlFVo5JQn1xPVVqpu6CIaEA0qhVVf8OgJR5r7AKjv2hLGdiiZUGv
        QA9B4Q5zOix+ICiu8w7/at2/lJ6uqJjAZPX7v6o=
X-Google-Smtp-Source: AAOMgpfvC4y9hL81xkYORPeZEHkdieZRGemM6JkPpqklDdyzZKAtztY+pMVrr69OLS88YxqR3+xaBXnbqJdeC31ZeMg=
X-Received: by 2002:a0d:f3c7:: with SMTP id c190-v6mr10408082ywf.98.1532506890872;
 Wed, 25 Jul 2018 01:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180724215845.7137-1-sunshine@sunshineco.com> <20180724220928.GE136514@aiede.svl.corp.google.com>
In-Reply-To: <20180724220928.GE136514@aiede.svl.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Jul 2018 04:21:19 -0400
Message-ID: <CAPig+cQ2BWc6c8pv9+Cb+=HLdo0KAtAY2N08ozaRVVYWSqG3GQ@mail.gmail.com>
Subject: Re: [PATCH] diff: --color-moved: rename "dimmed_zebra" to "dimmed-zebra"
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 6:09 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Sunshine wrote:
> > Subject: diff: --color-moved: rename "dimmed_zebra" to "dimmed-zebra"
>
> It would be clearer to say something like
>
>         diff --color-moved: add "dimmed-zebra" synonym for "dimmed_zebra"

That could work, although doesn't really convey that "dimmed_zebra" is
undesirable. Perhaps:

    diff --color-moved: add "dimmed-zebra"; deprecate "dimmed_zebra"

Perhaps, not worth a re-roll, though(?).

> > The --color-moved "dimmed_zebra" mode (with an underscore) is an
> > anachronism. Most options and modes are hyphenated. It is more difficult
> > to type and somewhat more difficult to read than those which are
> > hyphenated. Therefore, rename it to "dimmed-zebra", and nominally
> > deprecate "dimmed_zebra".
>
> Hm.  Looks like dimmed_zebra was introduced in v2.15.0-rc0~16^2~2
> (2017-06-30), so it has been around for a while (about a year).  But I
> would like to be able to simplify by getting rid of it.
>
> Is there anything we can do to make it possible to remove eventually?
> For example, should we (eventually, after dimmed-zebra has existed
> for some time) start warning when people use dimmed_zebra to encourage
> them to use dimmed-zebra instead?

Wanting to simplify by eventually getting rid of the old name is
understandable, but my hope is that we don't have to do so. Given that
this nominal deprecation involves one short sentence in the
documentation and one strcmp() for backward compatibility, it seems
unlikely to become a maintenance burden. In contrast to "git branch
-l", short for --create-reflog, but which people intuitively expect to
mean --list, "freeing up" this name for some other purpose is
unnecessary, so a concrete deprecation may be overkill. As well, the
extra burden on Junio to hang onto deprecation and eventual removal
patches far into the future seems unwarranted.

> > +dimmed-zebra::
> >       Similar to 'zebra', but additional dimming of uninteresting parts
> >       of moved code is performed. The bordering lines of two adjacent
> >       blocks are considered interesting, the rest is uninteresting.
> > +     `dimmed_zebra` is a deprecated synonym.
>
> Thanks for including that note.  It means that when people see
> dimmed_zebra in scripts or configuration they won't have to be
> mystified about why it works.
>
> I don't have any good ideas about deprecating more aggressively, and
> the patch looks good, so
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the review.
