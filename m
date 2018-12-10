Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A02B20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 17:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeLJRtc (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 12:49:32 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44899 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbeLJRtb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 12:49:31 -0500
Received: by mail-vs1-f68.google.com with SMTP id g68so7154508vsd.11
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 09:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dy2uglSd1uzr4M0RoYXfMSwOR0p9aGP/UnKNUGhFp7c=;
        b=iS4Ekeqvp9np6zlCJiEVlZpvHaHH52Kj2BSLvXePCxl+gFiAcae191y3xObWKkatKB
         mneBiDUlTaweW3TblJIRM6PuQYacEr5Y9XV6jbzu6J28V4G9WIjRI6478GTE0umdi4WV
         Ctr9HZvH3zzRiT2QcbEaY4NzzbxtXa337eGsRsr+2DACcWO//U7MGKQ22bYljV7+fiuj
         qnzxGwJBznoxnBl5CmMUerTntpFvdF6Wc4vyeiMhO5pl3ITcSCzkpFdP2q/HOMGxuhny
         rGxPBOlVBRDLROcs/X3vOjqW88HX1rmTNE3afcRXn/5AnXL863kcqH6uGlVLXDYyYCoi
         lpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dy2uglSd1uzr4M0RoYXfMSwOR0p9aGP/UnKNUGhFp7c=;
        b=d8nsRMi40fmYNGQYywKS73xe0MKgzqHK9551LQSqbeGHrdGoQLBPJQ685KCti+wv+A
         iF6osOxVZ56IMrbdL69LvlaeF8jL+5QSgIL7nrPPk8/se3Brfpmel/yVQbHWXosv9Z18
         m3ZbcD/krT1+w8cHJnAeDB8M1R3NJYRwJWW/xRQK+3F7HhLjZAy34LtM33c/ivppeHym
         91iI0VGjkS64z0oFHVRJ/t6WTvXzKTfmpPJcQa+7TSk8erBbZxKDsv72C7MeuRgpEN06
         bLdGWlzG+8qZrfdM85Z1SWVbWAnEFO5hoP27WYqDZ6R1/dmcgFhZWrHeWksLrLXsZtx9
         UC5A==
X-Gm-Message-State: AA+aEWatdqtsHOBZQ+C8ylKWGtM4xLNs1cPFs37DPGXJnRYc6Rh/WvFJ
        kVy4Jj9PGpmJuZMF3QTGdMzxGJIK1U5Gy6n6rb3sjQ==
X-Google-Smtp-Source: AFSGD/VUcL45VQiVnK01lu3fhyCGPswIYD3FS91hvADpo+JggtDEk/VtB7RJkjwOoTN6yrigThbjati1SFtF54pR6MA=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr5750397vsi.136.1544464170374;
 Mon, 10 Dec 2018 09:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-4-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-4-t.gummerer@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 09:49:17 -0800
Message-ID: <CABPp-BHO7UmAm14HWf2tc+SVEZuWBqyvvrQg625fDsiDYPEL8g@mail.gmail.com>
Subject: Re: [PATCH 3/8] entry: support CE_WT_REMOVE flag in checkout_entry
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 12:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> 'checkout_entry()' currently only supports creating new entries in the
> working tree, but not deleting them.  Add the ability to remove
> entries at the same time if the entry is marked with the CE_WT_REMOVE
> flag.
>
> Currently this doesn't have any effect, as the CE_WT_REMOVE flag is
> only used in unpack-tree, however we will make use of this in a
> subsequent step in the series.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  entry.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/entry.c b/entry.c
> index 3ec148ceee..cd1c6601b6 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -441,6 +441,13 @@ int checkout_entry(struct cache_entry *ce,
>         static struct strbuf path = STRBUF_INIT;
>         struct stat st;
>
> +       if (ce->ce_flags & CE_WT_REMOVE) {
> +               if (topath)
> +                       BUG("Can't remove entry to a path");

Minor nit: This error message is kinda hard to parse, for someone not
that familiar with all the *_entry functions, like myself.  Maybe add
a comment before this line:
    /* No content and thus no path to create, so we have no pathname
to return */
or reword the error slightly?  Or maybe it's fine and I was just
confused from lack of code familiarity, but I'll throw it out there
since I stumbled on it a bit.

> +               unlink_entry(ce);
> +               return 0;
> +       }
> +
>         if (topath)
>                 return write_entry(ce, topath, state, 1);
>
> --
> 2.20.0.405.gbc1bbc6f85
