Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28730C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 04:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA4222202
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 04:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgLBEol (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 23:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgLBEol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 23:44:41 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02585C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 20:44:01 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id e7so1038266wrv.6
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 20:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/SFBYj+67pwBuiVaCp5oDfe+4a1psHTQ5Bex7ddmFc=;
        b=PKzLzU8KD7LgGJuO/62CHWfK+nleZS8OBQgTTdO3XUZtEl271h4YEMXSpIbnrm6Fwe
         iudECNPg6B0NZenGqyxZ+9zLSGwBWI3lLjMkjFNOsTTk8yQicZLuz+DFZhXwPW+CyPIc
         6r/udcoHBN3sgR9EUtg2S3FzgCsuHC+N1bFGRFCqUTpKA0/L4YcwNEujZIbGvHn4uwTE
         53a8ZT2OJKWCbQZlwsZsmzKOeQkjiVE0t8hagMNeVgvpdzl9BaEm7mq3mmiQ8HZQLZaN
         OMOz+Xx+4BKuXPi855/faZizqhObJ7p2fqig4Ga4FBS9CtpNYA4EEv0ilO5fQWQX0I+5
         tN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/SFBYj+67pwBuiVaCp5oDfe+4a1psHTQ5Bex7ddmFc=;
        b=CeniRCZ9ccKP7DMS7iBllBP0W2dCJIFgBRH6m8Swg0LfeFHPxayDBpJbTXurvCJ01w
         qHMrOekmcZwaaAzr1YLvQtGA7bzBZhoAKAbYeyY19VL9ujzZu5OS469S5XaZ912x1+3n
         pTslfqAQ5+YHYZB2m17kEh4cvND3bgtwNrZzcKIoxOqLcyP8t8JvtkAlmuuoF4M6uE2p
         5sG1vF7RGTbPHYWdMzr06DGx1I3pHJJfpNnCCnHz78sRPP15DwcWG37QN9BLiplcYxHB
         6a08SIBxz4d4Yp6exYycOEDV/7MGoufCCLXPDwqqzytltu93yIuCDC7PShlzPXBXWbdT
         JFQA==
X-Gm-Message-State: AOAM533LRW1ob18OHVM74YKmASojiJCTqewx/f8uj6WlLBuBWbYKCGip
        6VoUWiwq6O9SbbUtvhyi6jDyZm7F95iyHAbQVRo=
X-Google-Smtp-Source: ABdhPJy3tvZI9uf2kZ22ZQlrUE24m1IUHEWPhKLrteIf/tJBQPJRyK9yZEV305RRwMg1XLFLaOyMfQlaVFEIgBYejB8=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr860589wrs.100.1606884239766;
 Tue, 01 Dec 2020 20:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
 <20201125020931.248427-2-alexhenrie24@gmail.com> <CAMP44s18Sd=DWMhFWCSDyGEz74ZKVF2kukr_=Exe1CjnPULCoA@mail.gmail.com>
 <CAMP44s3-fJ=mrYjGTW3AUACBmEhyrdD0dRktdaKHK9b1MTbk2A@mail.gmail.com> <67e55d85-63a4-9a47-e633-52b2ece23758@iee.email>
In-Reply-To: <67e55d85-63a4-9a47-e633-52b2ece23758@iee.email>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 22:43:48 -0600
Message-ID: <CAMP44s3Y6SxvxEH8snUi6LKTOmnuNOt7x1XSn2p5_zPQb0Ez2w@mail.gmail.com>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not
 set either
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 7:25 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> On 25/11/2020 03:47, Felipe Contreras wrote:
> > On Tue, Nov 24, 2020 at 9:45 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >> On Tue, Nov 24, 2020 at 8:14 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> >>
> >> Before making this the default we need a solution *right now* that is
> >> a sane default.
> > This mail was sent by mistake. I was going to say:
> >
> > We need a warning like:
> >
> >   The pull was not fast-forward, please either merge or rebase.
> >
> > When the default (pull.ff=only) is set.
> >
> > It is the current status that is more urgent to fix.
> >
>
> Maybe this could also, as an interim measure, be a doc change right in
> the first paragraph of the `git pull --help` description section to warn
> that its current default may not be suitable for most users, and to see
> the `--ff-only` option (and variants) and its matching config variable.
>
> e.g. "In its default mode, git pull uses the --ff option and is
> shorthand for git fetch followed by git merge FETCH_HEAD. The --ff-only
> option may be more suitable for modern usage. It can be set using `git
> config pull.ff only`."
>  (then once v3.0 arrives the discussion can be flipped)
>
> It's worth making sure that the manuals are easy to read.

This is what my patch attempted to do:

https://lore.kernel.org/git/20201125032938.786393-11-felipe.contreras@gmail.com/

Before warning that a non-fast-forward pull failed, it's probably
sensible to explain what a fast-forward is.

-- 
Felipe Contreras
