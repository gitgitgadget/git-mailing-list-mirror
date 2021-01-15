Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34D2C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 11:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3A823730
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 11:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbhAOLNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbhAOLNh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 06:13:37 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2926FC0613D3
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 03:12:57 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id q25so8154222otn.10
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpgSNWv1IMBeHv2A68ytpmv4Pe5tYDBZZ/mZHGB6YVE=;
        b=YUOZBEhpm8J1HdtE5+FAzcD5gG91ACpgD0iYiprxb7PLD1EYZCRdoYMqevC4m3wkUq
         MtTEIkZo7y9AOGbwkEBTMuFIVxy71kFDlPiGDb3S/udGX1qFVj3jjhOqtMhXWGd8FM60
         o/rNwk0TmuWOeO0SuxZaXn3OWbgodFBY8SbzjH9bWJN4jbseCtTU8SGzZzWsnMCCeTNc
         Vn2FW1obY9ROok3B9p0ygFbJnTW81/axg/ckRqE85C5ggmbIP+5FP7hUoYWzoIleVjfI
         Jl5X+MZCttkFhfnjtwwIUfb5iUCRgJGuIbvQTGZyKa5MjbYaIZs9vam4KPSPxnz4nOgS
         9/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpgSNWv1IMBeHv2A68ytpmv4Pe5tYDBZZ/mZHGB6YVE=;
        b=o312vuyAIVSlkIMkeKm4pWOqGIfBHVjTSOfGc4cLK97rVoVVcnoeKxYqZo29atMSwJ
         DwvdmIUURATOdpWKrUlGMYE0+Hcmcd6lvYHye8mx8OHLZUxlguIgJgjNicZWrOdmZz81
         MXiKUBDyI/ZKZi83PCrjbLe8TV63eVK7QkWs7itZW1OOyqMaoYCHFFrlrOTJziXLxSy1
         xNCl0p3XHnHUk0gsfyQ5blsXo7YCBADfOIdGzwkTMd0WbZgRJocStXlGl04b0pGhDgEH
         NJHhRq9CjzDd/0cQab15ihyqI1qgsGgYDl1UP39oi1sZTOL2Lrtv43oGtPsBR/LO0DR4
         YTsw==
X-Gm-Message-State: AOAM533VyAocaCtM+X2scN62hOk/ehdhAuMBvp+18jMa01YPRoJoxn6w
        S7uQZk8ozgRHEHIYyrNxwzsS0nnLJEwdh0GuYe4=
X-Google-Smtp-Source: ABdhPJy4a8zW/RHiTTP5ndR0bwcewf8VD3KrnQTmy+bzQdmuzP5Yp+wXYnAw+eLbsJlCB/SOcSop/PC4WNM622VpgTw=
X-Received: by 2002:a9d:313:: with SMTP id 19mr43978otv.147.1610709176548;
 Fri, 15 Jan 2021 03:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-4-charvi077@gmail.com>
 <X/9DdGnYo7RQz5CE@nand.local> <CAPSFM5fuT0QAK9wJ_HuH3t=qThPx7Opwy0GrYieVntJ8A4ARMA@mail.gmail.com>
 <abc9334d-a9ec-a041-aa04-16cb4f01372a@gmail.com> <CAPSFM5co06fdo=vqTMeHLtYyP37qucGVRtOiFsZBwiR1UOsm8Q@mail.gmail.com>
 <CAP8UFD3_RPrFQELiBp=QFgheQa8RhDYcwgLmG9Eb4fFKH4p+FA@mail.gmail.com>
In-Reply-To: <CAP8UFD3_RPrFQELiBp=QFgheQa8RhDYcwgLmG9Eb4fFKH4p+FA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 15 Jan 2021 16:42:45 +0530
Message-ID: <CAPSFM5eiV-Kd3T7Ug9838UJVXKNPZ7x+C5UdRybu6wR0=sw4Ug@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Fri, 15 Jan 2021 at 14:15, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Charvi,
>
> On Fri, Jan 15, 2021 at 9:35 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
>
> > On Thu, 14 Jan 2021 at 15:59, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> > > On 14/01/2021 08:27, Charvi Mendiratta wrote:
> > > > On Thu, 14 Jan 2021 at 00:31, Taylor Blau <me@ttaylorr.com> wrote:
> > > >>
> > > >> On Fri, Jan 08, 2021 at 02:53:41PM +0530, Charvi Mendiratta wrote:
> > > >>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> > > >>> +static size_t subject_length(const char *body)
> > > >>> +{
> > > >>> +     size_t i, len = 0;
> > > >>> +     char c;
> > > >>> +     int blank_line = 1;
> > > >>> +     for (i = 0, c = body[i]; c; c = body[++i]) {
> > > >>> +             if (c == '\n') {
> > > >>> +                     if (blank_line)
> > > >>> +                             return len;
> > > >>> +                     len = i + 1;
> > > >>> +                     blank_line = 1;
> > > >>> +             } else if (!isspace(c)) {
> > > >>> +                     blank_line = 0;
> > > >>> +             }
> > > >>> +     }
> > > >>> +     return blank_line ? len : i;
> > > >>> +}
> > > >>
> > > >> OK, so this gets the length of the subject in "body", which is defined
> > > >> as the run of characters before a newline and then a space character.
> > >
> > > The length of the subject is the run of characters before a line
> > > containing only whitespace, "hello\n there" would return 13 "hello\n
> > > \nthere" would return 5. Looking again at my code there must be a way of
> > > writing that function that is easier to follow.
> >
> > Okay. I will look into it once, thanks for explaining.
>
> You may want to look at other places in the code where we deal with
> the subject. For example there is find_commit_subject() in commit.c
> and find_trailer_start() in trailer.c that might have interesting code
> for our purpose.
>

Thanks for the pointer, I will look at it.

Thanks and Regards,
Charvi

> Best,
> Christian.
