Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C333BC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976BC61185
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEKVjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 17:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKVjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 17:39:53 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C75C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 14:38:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso18799799otn.3
        for <git@vger.kernel.org>; Tue, 11 May 2021 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Etwn7NKmW+5z5ZAd7Aegsr5WPjcaOMT6NCi7W19bDms=;
        b=YZsZw5dYxNG4Ij72YwD0ZcWeqya9ee6Ig+xMPIaAkcT/vM0AgSy/wRRBNWqhzwMGzs
         iQgdoDlbVMRg0dbqejijMvKokvttfWyWt/bM1g3jzh1J8Gv3q8rMLZp9VQik32Fl+kBP
         gN3EQOHfXGAfRo3L3Zy7Iym6JI2FNQ/Crf4fDm2+g7wQkhyThWTdsWOrcA5FNKEGcxFV
         r3sB0IQLHgRMt7QjTgb+9FPWlMdo9H2TofQxvIQTbb+4J6XTVzLNmTHtzNbQoW3KLIdI
         N2ObpVT86uDdCcK+ZnjXcezeDxXwQhVA85h/Jfnpejh5pZBTGd5Z1hHi6dy8POb+ULXa
         dnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Etwn7NKmW+5z5ZAd7Aegsr5WPjcaOMT6NCi7W19bDms=;
        b=ZYKRdRqgtg29823QhuqE5+3yB7BIaFdVl24EA/+iQDkuKLvCpLQOZjHy8CoRfrMa5h
         OT/6Bs8G5QWm4B4wRAnmwkjRpiQAhIVQcfvIiKUYZDUygYYJMwPapdXfGZxy2tf42W0k
         9xLcmlbUbIKI9xSvuIEIdT2gs4crk5osV3HY+8hdVQPYDVEA9ikxfeU+3XLUAvyGItN1
         EHNgqsKRDktHzFbWtjbr75YrT8+Jaq7VvhWHV+qx5Y+3HgwH8/D2iZy9+AS+AAfm9dLW
         nkoN3l9HL6bMZsmRhEsX+gKpH3yFC3sCUxjuphfE/v/KRFz8y4FIMMzda+RpuEpPi4WL
         eY8w==
X-Gm-Message-State: AOAM532u3GhRFbII7RaVxIVidVV8K/LYiYVjqbpdBxUFX85W+YPaS+5D
        S22g3ujIIlYNYQEdQdzaqRlVWrieG8zy2RX270A=
X-Google-Smtp-Source: ABdhPJwQUPx0qH3vt+PXXSWOl0YaSwl7/jgRIgUCAo5WluG1L8e7djt8vil7Wqjovqa1KzLtYb0VoGfHe4kSoYniMkY=
X-Received: by 2002:a9d:1d45:: with SMTP id m63mr6979051otm.302.1620769124898;
 Tue, 11 May 2021 14:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz> <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch> <20210511202502.GM12700@kitsune.suse.cz>
In-Reply-To: <20210511202502.GM12700@kitsune.suse.cz>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Tue, 11 May 2021 16:38:34 -0500
Message-ID: <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 at 15:25, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
>
> On Tue, May 11, 2021 at 02:59:32PM -0500, Felipe Contreras wrote:
> > Varun Varada wrote:
> > > On Tue, 6 Apr 2021 at 04:24, Michal Such=C3=A1nek <msuchanek@suse.de>=
 wrote:
> > > > while using "will not impact" in an incorrect or unclear way may be=
 a
> > > > problem the word "impact" in itself is not "jargon".
> > >
> > > The word means "to have a strong or marked effect on" (v.) and "a
> > > strong or market influence" (n.) when used figuratively; it is not
> > > synonymous with "affect" and "effect", respectively, as shown even by
> > > all of the entries you've cited. Using it as such is the incorrect
> > > part, so those are the instances I've changed in the diff.
> >
> > There are two ways impact can be used as a verb: transitive and
> > intransitive, but git doesn't seem to be using the intransitive form. I=
n
> > the transitive form it usually means to strike "the car impacted the
> > tree". But it can also mean to have a desired effect "reducing CO2
> > emissions impacted climate change".
>
> I don't know where you find the 'desired' effect meaning. Certainly none
> of the dictionaries I consulted at random provides such definition.
>
> >
> > None of these are used in the documentation, we have things like:
> >
> >   the index does not impact the outcome
> >
> > Which is clearly wrong (unless we are talking about possitive outcome o=
f
> > the outcome, which makes no sense).
>
> It is not clearly wrong. To me it makes perfect sense. If you want to
> claim it's wrong please provide a source for your claim. Otherwise it's
> just matter of different opinions of more fitting formulation.

You agreed that the word "impact" means to "significantly affect". The
idea of whether something is *significantly* affected, as opposed to
conveying the idea that something is affected at all, only arises in
situations where degrees of an influence are possible; that's not the
case in any of the examples my change is editing (except for the one I
conceded where it says "badly impacted"). Assuming that a reader would
know which of those involve degrees of influence are possible and
which aren't, even if every reader of the documentation/command output
was familiar, is entirely unnecessary. That's the point here: there is
this point of confusion that is entirely avoidable with a simple
one-word change.

Re: your point about me not pointing out specific examples: the
command output for detached HEAD state reads "you can discard any
commits you make in this state without impacting any branches by
switching back to a branch". I'm incredibly passionate about this
example. Here, the user is left to think, "wait...so this will not
impact (significantly affect) any branches, but will it affect them?
As in, are there side effects that I should be aware of? Where do I go
to find out what they are?" All of this mental energy is completely
unnecessary. Mind you, this is regarding discarding commits, which is
a destructive action.

You might feel that this is just one example that might need fixing,
but I assure you, I've analysed all the other examples and they all
have similar problems. It's entirely unnecessary to have this
confusion.

>
> >
> > As a noun it can mean a siginificant or major effect: "the impact of
> > science".
> >
> > However, the documentation is not using it that way:
> >
> >   the runtime impact of tracking all omitted objects
> >
> > The noun usage is less wrong than the verb usage, but it's still wrong.
>
> Why is that wrong?
>
> How did you infer that the effect is insignificant or minor?

No one did, and that's the point. All impacts are effects, but not all
effects are impacts. You yourself acknowledged that there is a
prevalent tendency to hyperbolize, and the fact that one doesn't know
which it is in this case (or frankly any of the other cases my commit
touches) is problematic. This kind of confusion surely doesn't belong
in technical documentation. And if it is indeed an "impact", where is
that conveyed? What's so notable about the effect on the runtime?
That's the point.

>
> In fact while some dictionaries list 'impact' as 'have strong effect'
> the Oxford dicrionary lists is as simply synonymous to 'affect'.
>
> > The verb usage could be corrected by changing "the index does not
> > impact", to "the index does not have an impact on".
>
> Why is that change needed at all?
>
> > But why bother? The word "affect" is a much superior choice.
>
> Why bother with a chenge at all?

It seems like you already previously agreed with the premise that the
word means "a significant effect" or "to significantly affect". I
understand and appreciate your thoroughness to scrutinize changes to
the repo, but I'm frankly surprised that such a small change is
attracting such fierce debate. This is meant to be a change that is
probably one of the easiest ones to decide on: it only consists of
one-word changes that don't change functionality, yet undeniably
reduce confusion.

Re: your previous point about linguistic authorities: yes, there is no
authority on usage, but therein lies my point. This doesn't even need
to rise to the domain of usage, because it is squarely within the
realm of semantics. Words mean something, and we all use dictionaries
to learn about / confirm those meanings. Insofar as all the major
dictionaries cite the word as "a significant effect" / "to affect
significantly", that semantic concept doesn't belong in the cases
where I've made changes. And if it does, then those need to be
clarified (because that's where the real confusion/ambiguity is).
I.e., it's not "why is not every case a significant effect?", but "why
are some cases a significant effect?"

>
> Thanks
>
> Michal
