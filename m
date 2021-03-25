Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E109C433E0
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 09:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7F361A23
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 09:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhCYJdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYJdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 05:33:36 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38EC06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 02:33:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso1334982otq.3
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nwbNkV2EvQxbES2PILPvx7KZ2/JvVMpt4EUifHJ5ejw=;
        b=jfETIOsHzKOYc8x0jvuuF8pX2DV8FTM/50fK+WDorwZQnyGAcHhWB2MNDoMt/NQCXV
         fP0HmqZs543C4jexWeJEdtyxp3dm8jb84c8NQCJd9mGjtt5NMnUPD/n4Exng39926CHt
         4Zd2ETXPrzykQKdA8nN8GeK8TDziKbNB41kC9n5Tc1OP0U7aoMmTll2EfCB40UjelSKb
         kW3MMjIvlB8dvd/TLx4dXbD5Xy04xC8/qTZvt4kIxnNRKLaUjMMzH9UOIVGn7rz6AIJH
         LtwNu6aNYOcWWAnfTFQrurjZdBPkXeByUUsT2lolBlR9kNOIj8Fz/FIOZg+iM9UkdPeS
         apXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nwbNkV2EvQxbES2PILPvx7KZ2/JvVMpt4EUifHJ5ejw=;
        b=mZMrrRGhwCeayqj6orPZoPK0fFGsMjpC3xxrrYum5d1vbi+Xvh9xM0ueLxx6r3rTQf
         D1HfXsNaZp2b4J6qcjtLTSWVx2klYogdujn7o8qb3Vaq1FaRvrUpsV0DXVrdEXqXhRww
         lN+KXjx3hlFT1RSSqhNITiAHKENb0LYlLx4Lg1rt/Zc3oIkcNkoQEXzHS64GF0I6hwPf
         ANmsfxjYrJ+4A5d6sVho5iv/gdsSCnfD1CkS7R64sSbh5jJ4PlHMrjC4GfwEfLdTg2jx
         flJSMD4G76APuKPyEzXs+0M42kw1splr6pn2xVToh2PvMh2bgDM90nUskwlpGFC/YT5r
         Fcow==
X-Gm-Message-State: AOAM530SkxcQOmxO2cngOjXf5J3nkVW1++NtTvaNx2BPFXYlCUhxuCNi
        8b4jWTqIRNGL95XqZq8N38ylVf3upIMa+6GTSrMocDFjga9T9McF
X-Google-Smtp-Source: ABdhPJy0dv0QiIJWh9WNTRTcDDzmK6I52ijExOQJB61BXrcswhpmugH+F66CmMexqiT1llo7rpQO+7CXBMl2ZeZkRnc=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr6617188otq.160.1616664815351;
 Thu, 25 Mar 2021 02:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
 <xmqqczx0sq1o.fsf@gitster.c.googlers.com> <YCwJ8tORQg2Air4r@nand.local>
 <xmqqmtw3pzu3.fsf@gitster.c.googlers.com> <YCwhPG6RaAhU9ljg@nand.local>
 <CAP8UFD1QG_b6ax-HodLRRcdLKgWJhPDghjLfjnyan1Zi80en7A@mail.gmail.com>
 <xmqqsg4l3h32.fsf@gitster.g> <CAP8UFD0rRff7oCMH=DeTQ-tZw7STLwSHLecWxRr_rQVyHuxJuA@mail.gmail.com>
In-Reply-To: <CAP8UFD0rRff7oCMH=DeTQ-tZw7STLwSHLecWxRr_rQVyHuxJuA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 25 Mar 2021 17:33:23 +0800
Message-ID: <CAOLTT8TFTcw9fkfPk-vi3REtZqCWYS28LEP5jfy-TmYuWf747g@mail.gmail.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break parsing
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git <git@vger.kernel.org>,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8825=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:54=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Tue, Mar 23, 2021 at 6:39 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > > So I thought that blank lines should not appear in the trailers. And
> > > if any appears, it means that the trailers should start after the las=
t
> > > blank line.
> >
> > I think that is a good principle to stick to.
> >
> > >> >  - if the second "multi:" trailer did not have the funny blank lin=
e
> > >> >    before "_two", the expected output would still be "multi:"
> > >> >    followed by "one two three", iow, the line after the second
> > >> >    "multi: one" is a total no-op?  If we added many more " \n" lin=
es
> > >> >    there, they are all absorbed and ignored?  It somehow feels wro=
ng
> > >>
> > >> That's definitely the outcome of this patch, but I agree it feels wr=
ong.
> > >> I'm not sure that we define the behavior that strictly in
> > >> git-interpret-trailers(1), so we have some wiggle room, I guess.
> > >
> > > Any patch to relax how blank lines and other aspects of trailers
> > > parsing in my opinion should come with some documentation change to
> > > explain what we now accept and what we don't accept, and also tests t=
o
> > > enforce that.
> >
> > OK.  But do we document clearly what we accept and we don't before
> > any change?
>
> Maybe it's not enough, but the doc already has the following:
>
> ------
> Existing trailers are extracted from the input message by looking for
> a group of one or more lines that (i) is all trailers, or (ii) contains a=
t
> least one Git-generated or user-configured trailer and consists of at
> least 25% trailers.
> The group must be preceded by one or more empty (or whitespace-only) line=
s.
> The group must either be at the end of the message or be the last
> non-whitespace lines before a line that starts with '---' (followed by a
> space or the end of the line). Such three minus signs start the patch
> part of the message. See also `--no-divider` below.
>
> When reading trailers, there can be whitespaces after the
> token, the separator and the value. There can also be whitespaces
> inside the token and the value. The value may be split over multiple line=
s with
> each subsequent line starting with whitespace, like the "folding" in RFC =
822.
> ------


Maybe I don't have enough right to speak on this issue, but I always think =
that
 the empty line is intentional by the designer, especially when I test it.
