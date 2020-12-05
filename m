Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C8C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2C122D70
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgLEBHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgLEBHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:07:15 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B56C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:06:29 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so8564706wmb.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umqNj2rgwf2cey8gE3XfA74mGgEBB5PctS4HypHr1bQ=;
        b=L9vFai5FoyXU0ahBFyQk57gLX+1f4BM/HR+xbFy0uLmmCuBAHj875oxCAAoldHHQAy
         RkoHDE9kWMjebtoeNIUajTISvQGPYhU+6skX09Yo7LJ9CNiKGUIDD5OkbI8ulVt7GxvC
         tHszl4ELWw4orhxo1oAtOv+xxfkVFunX5X3wCX2ASAdUkgHFZiordzzq+sufIFj4BjlY
         r3AMFOYJM7Bh/Qctdjp2hHZ4r/meilgAPanWMf7EyDttKroKlocZlIkB8uNrho7/GqzF
         RrL/5mTY0JlEqfhBG+tR4aytomIYUbaiMcYeOCRrnj0grXqnkKbi1rmZFiC+/PmbNfbk
         we/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umqNj2rgwf2cey8gE3XfA74mGgEBB5PctS4HypHr1bQ=;
        b=D7MIt2O3m5alZTr611b26BtK30gfhSm4dgNKeMXG4ixYIvK/T7hW34Zas3Wo5R4zQy
         Hib84+sMTspDipkxajqCy+fEjQtWEwyBY8l2RAk3zjNaqOv+7RKzAMp397Wz3XgjghY2
         gr6asVDWgvutdTNh0mxxBtq/bonJpSu23yIyLpHbdkRQpN9ihXbFvDiDh5hPjsOS+TL8
         iwgtuEbrS1mGyCRLy7AMiEaefYEsTSNPB2V/ebo8MCWuf9Khe6a5d+A3lhRNNVDmbCMn
         53ROhd919KDYW8gaQ3H2LYxzKBVfg35T8mn+JxiD6fyqdxuy/tIGZb5ostTAVGamw9gE
         jZbg==
X-Gm-Message-State: AOAM5324/NNhxDg2hb5qmPQZHTyal3Y0tffZINbrXjWNThb8wrK5COY7
        RkU3v6lffb2ixOzmzha/wJS7Pl0xXRIRMak2dWS79VTiSy8=
X-Google-Smtp-Source: ABdhPJzCZMDOH1sDtvv8RETVrCQ+2lsl9EC4Goj10i4qVO2wZdI7jxaxdpNKxJfIaJAbeW3RKS1n6DD3Ui7gdtr+1P4=
X-Received: by 2002:a7b:c843:: with SMTP id c3mr6851516wml.100.1607130388001;
 Fri, 04 Dec 2020 17:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-10-felipe.contreras@gmail.com> <CABPp-BGndfbF=QcCox13kik4B9F7Bgn7k2ToFRkGsh0dJ4K0HA@mail.gmail.com>
In-Reply-To: <CABPp-BGndfbF=QcCox13kik4B9F7Bgn7k2ToFRkGsh0dJ4K0HA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 19:06:17 -0600
Message-ID: <CAMP44s3rPy0N5s6KiegmuKvyvveDgrBxv6w+Qp3OXVm5QzNaKg@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] pull: introduce --merge option
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:27 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Previously --no-rebase (which still works for backwards compatbility).
> >
> > Now we can update the default warning, and the git-pull(1) man page to
> > use --merge instead of the non-intuitive --no-rebase.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/git-pull.txt   | 9 ++++++---
> >  builtin/pull.c               | 4 +++-
> >  t/t7601-merge-pull-config.sh | 4 ++--
> >  3 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> > index ad33d2472c..c220da143a 100644
> > --- a/Documentation/git-pull.txt
> > +++ b/Documentation/git-pull.txt
> > @@ -61,7 +61,7 @@ However, a non-fast-foward case looks very different.
> >  ------------
> >
> >  By default `git pull` will warn about these situations, however, most likely
> > -you would want to force a merge, which you can do with `git pull --no-rebase`.
> > +you would want to force a merge, which you can do with `git pull --merge`.
>
> I'm glad you updated all the references, but as noted earlier in the
> series I think this suggestion is problematic.

Yeah, but the danger comes straight from what "git pull" does by
default (an implicit "git pull --merge").

It's not the text that is dangerous; it's the default behavior.

-- 
Felipe Contreras
