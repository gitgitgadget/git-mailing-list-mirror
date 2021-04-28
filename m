Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D528C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79B5613FF
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 18:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbhD1S1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 14:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbhD1S1L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 14:27:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD1C061573
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 11:26:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mu3so4974145ejc.6
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5F7dZ1ZPZc7Oh5O7edbf2Z9i1AW2BClHvjqX17SI0nU=;
        b=jho+iOYSHEynAnDGCYHXq+BLUWLZYTQ7BGgNrmbG8+oSRKEMs1y/FQvOL1wvmhUmd9
         soriHrqS5Ne/j5TJ5nn+DUsw59KvvwD0kEeG/0FNQnCSHiLvtMjn6g59rK+uQDalO+VT
         Pq5GqyQFH5dUpovB5WqKhVt3Y2BuUaAirTaMHllQV38r/J4vBebklVfdIyOqbQ1k+Dos
         qd8hPEVOYvAQoltANQBVLs/pDJositlRTBJdLf/dvJzm7yQgptpn9hr87ZcjyLmz/BIr
         wRihFvqO+mgum8xLrYR+nocqU31LDfMOQ/jrsMWFx54ijfc2XNPR01OWHWgAdd6hWr41
         iE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5F7dZ1ZPZc7Oh5O7edbf2Z9i1AW2BClHvjqX17SI0nU=;
        b=KBQUcEBqrQm3DmV2b2mg34DttNemUWaSDl01oW50xi6kqRkjIJsk378AdYXlZ8igs7
         wT0O935s/BorIc9Jy94v8FUUuTBswYPJCbEJ4SfzaoyLtxpAujsye+6+4ubwms0KM35O
         DTdUVLt+/BPNO+n7ILmJ9Bdt8xWJySBZYrcgRPIPK/7+YDYF6wsOfCuYCSpA25EwuQ+e
         wLfdDP0ff6lGwWC5C1Tmud0H/WJEWv0JP/7vGIePafWyohTkTnmap3pAUWNoCWDzEjn2
         xc4VwdGbGWUeDrzmEIFYCDMwOmIc9Len1D3P/kG5VB2Vnozqky0MVKjww3P0bduvt1XP
         9dlg==
X-Gm-Message-State: AOAM533fdzjKzvfkaIIQHI3Jzdnx7uDdzVY32uDcl+kFbbmykHDWL8BC
        DSe/9BJXM4ujJLbu4NAjSSDoQOMPEfJvWrAalMtQPA==
X-Google-Smtp-Source: ABdhPJw3Xfcge//wfDjZkRUODL4EnxlzUQT3z8xVukMZLMriKFbo5ACBifn4iAQ83+JJB37siEkX1xyzbeRI8unuE5E=
X-Received: by 2002:a17:907:7baa:: with SMTP id ne42mr31182816ejc.357.1619634380644;
 Wed, 28 Apr 2021 11:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210427011314.28156-1-jerry@skydio.com> <20210427194005.14318-1-jerry@skydio.com>
 <xmqq7dkmc19x.fsf@gitster.g>
In-Reply-To: <xmqq7dkmc19x.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Wed, 28 Apr 2021 11:26:09 -0700
Message-ID: <CAMKO5CvLW=XYFby1pBj7FHcXpNTM-qMB8UakDG+N=UXU2Gw7fQ@mail.gmail.com>
Subject: Re: [PATCH V2] git-apply: modify prints to account for --3way changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 12:32 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > Subject: Re: [PATCH V2] git-apply: modify prints to account for --3way changes
>
> Sorry that I missed this in the previous round, but what do you mean
> by "prints" here?
>
> > "git apply" specifically calls out when it is falling back to 3way
> > merge application.  Since the order changed to preferring 3way and
> > falling back to direct application, continue that behavior by
> > printing whenever 3way fails and git has to fall back.
>
> I am guessing it is safe to s/modify prints/adjust messages/ after
> reading this explanation.
Sure, do you want  a new patch for that?
>
> > Signed-off-by: Jerry Zhang <jerry@skydio.com>
> > ---
> > V1 -> V2:
> > - Moved --quiet flag to separate patch
> >
> >  apply.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/apply.c b/apply.c
> > index a36d4002ca..7aa49e2048 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -3572,7 +3572,7 @@ static int try_threeway(struct apply_state *state,
> >                read_blob_object(&buf, &pre_oid, patch->old_mode))
> >               return error(_("repository lacks the necessary blob to perform 3-way merge."));
> >
> > -     if (state->apply_verbosity > verbosity_silent)
> > +     if (state->apply_verbosity > verbosity_silent && patch->direct_to_threeway)
> >               fprintf(stderr, _("Performing three-way merge...\n"));
> >
> >       img = strbuf_detach(&buf, &len);
> > @@ -3639,6 +3639,10 @@ static int apply_data(struct apply_state *state, struct patch *patch,
> >               return -1;
> >
> >       if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
> > +             if (state->apply_verbosity > verbosity_silent &&
> > +                 state->threeway && !patch->direct_to_threeway)
> > +                     fprintf(stderr, _("Falling back to direct application...\n"));
> > +
> >               /* Note: with --reject, apply_fragments() returns 0 */
> >               if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0)
> >                       return -1;
