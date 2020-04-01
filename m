Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC78C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C02063A
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHhl1JLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbgDAP7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:59:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33360 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732994AbgDAP7O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 11:59:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id m14so22693480oic.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkM8RK4Aonrm85NDgRP6jIODuCLvhgIsrz0JzeAEUBQ=;
        b=PHhl1JLqk8IGaQJGS6g4OltpJqt2lpbqTlYph6r48kLv6W68jCMG/DU++NRzcjSsPY
         oajCTbtp6yXsJ28lcokoXNzW5REVBeXNqbOVF5AFKWT9z0lkBEQB4n19IX8FDvh+IZqc
         xOtvEXYBuCMZZ1U1x2ZGw8ZLYOq0FUv1nSfbxVHrb7sDkpKls4DEtSK8CRsCr5UyboVQ
         xpYylt4WaGEvhH6ie6+wUBk4gJ34uvP4JsSbNYZvUzr//ZbDPiH1XimvKuD+wTvpB6by
         xZUuBYHX/JxZGc5N5+JZnI29jJnt+egHPG0Lq1FpEVtDTFQLvfcWlC0qYodMZDOmw5ol
         OquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkM8RK4Aonrm85NDgRP6jIODuCLvhgIsrz0JzeAEUBQ=;
        b=k4i8yJg63Xdk00DF/mMAFmtjiKVnDVTMfpZy5ziT9HEAKUzLEwlPPwLqpQb7SGJuu5
         lBsLJuta1NrChg5nP7nriTB1qyDNx0txYq+jrIuDsM1GNsYB1ulmBphHxE/rW/TzIwh+
         IDkTaSDY9YMMks4mmHS/BSicasD43WyurMdcCHfI0Y/52qnqUViQdjJF0A8Cy5QTh1qX
         X8FPA4w1niJQcHhcyitrP5Miucpk38jieVfqQVfDByY2nOrK9OCibhxdLxjSDw/D0aN5
         MW9qJZoGlY51wupDGHnsjLpuSstX8KtNplxrIPgnvKjsDwYxHHLyorrJUOQKJY01i4b+
         i8Pg==
X-Gm-Message-State: AGi0PuY7DGmFLiCQZusZ4WnbR7WJUMbrWij51JQGPPtRzykT6hbuYK1y
        QKmy9l0T0Y5O1yhyKEvQH7xWsGR+y/JCZwwtSuEUxhwe
X-Google-Smtp-Source: APiQypKaOE6p9mObzD1OUTIKS/6odgY4RisRd1JhpkadEZNnSDIZsk4yWJTVyQIuVITAGTQhzYGQPXDMazYyIkdTtgg=
X-Received: by 2002:aca:4b84:: with SMTP id y126mr3174754oia.31.1585756754102;
 Wed, 01 Apr 2020 08:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
 <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com> <b2caa426790a2cd6a510e5ebf2d182b018f12185.1585714667.git.gitgitgadget@gmail.com>
 <977213ee-3d5f-150a-2982-e1083557bce3@gmail.com>
In-Reply-To: <977213ee-3d5f-150a-2982-e1083557bce3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Apr 2020 08:59:02 -0700
Message-ID: <CABPp-BHOoM+xDJA3pCaymuRrAwPJKOPxU__c7uJGZaZNPc7eaA@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] dir: replace exponential algorithm with a linear one
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 1, 2020 at 6:57 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/1/2020 12:17 AM, Elijah Newren via GitGitGadget wrote:
> > @@ -1659,7 +1659,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
> >       const char *dirname, int len, int baselen, int excluded,
> >       const struct pathspec *pathspec)
> >  {
> > -     int nested_repo = 0;
> > +     /*
> > +      * WARNING: From this function, you can return path_recurse or you
> > +      *          can call read_directory_recursive() (or neither), but
> > +      *          you CAN'T DO BOTH.
> > +      */
> > +     enum path_treatment state;
> > +     int nested_repo = 0, old_ignored_nr, check_only, stop_early;
> >       /* The "len-1" is to strip the final '/' */
> >       enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
> >
> > @@ -1711,18 +1717,135 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
> >
> >       /* This is the "show_other_directories" case */
> >
> > -     if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
> > +     /*
> > +      * If we have a pathspec which could match something _below_ this
> > +      * directory (e.g. when checking 'subdir/' having a pathspec like
> > +      * 'subdir/some/deep/path/file' or 'subdir/widget-*.c'), then we
> > +      * need to recurse.
>
> I was extremely skeptical about this approach due to leading wildcards
> like "*.c" or "sub*/*.h" but found this comment inside math_pathspec_item():
>
>                 /*
>                  * Here is where we would perform a wildmatch to check if
>                  * "name" can be matched as a directory (or a prefix) against
>                  * the pathspec.  Since wildmatch doesn't have this capability
>                  * at the present we have to punt and say that it is a match,
>                  * potentially returning a false positive
>                  * The submodules themselves will be able to perform more
>                  * accurate matching to determine if the pathspec matches.
>                  */
>                 return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
>
> So it looks like it will return MATCHED_RECURSIVELY_LEADING_PATHSPEC as
> expected by this block below:
>
> > +      */
> > +     if (pathspec) {
> > +             int ret = do_match_pathspec(istate, pathspec, dirname, len,
> > +                                         0 /* prefix */, NULL /* seen */,
> > +                                         DO_MATCH_LEADING_PATHSPEC);
> > +             if (ret == MATCHED_RECURSIVELY_LEADING_PATHSPEC)
> > +                     return path_recurse;
> > +     }
>
> I can't say that I fully understand the change to this patch yet, but at
> least my initial "THAT CAN'T POSSIBLY WORK!" reaction has been tempered.

I don't know if it helps you feel better about this block or not, but
it existed (in just slightly modified form) in dir.c before patch 7; I
just missed it when I was restructuring and thus didn't have it in my
first four rounds of this series.  (Funnily enough, I was the one who
added this LEADING_PATHSPEC logic to dir.c a while back, and you'd
think if I was going to overlook some code when I was restructuring,
that it surely couldn't be bits that I had added myself.)  So, that
basically means that dir.c has been relying on this logic for some
time, and I just needed to make sure to include it in this
restructuring.

Elijah
