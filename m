Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F9C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5012313E
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbhAOIpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 03:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbhAOIps (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 03:45:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319DFC061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:45:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id r12so810411ejb.9
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3FGogfrOlZYzzJx7oyy5WGaDkXUqbYDBHhOjM1pxY8=;
        b=u9U4rX3nCvHaAkmzFTZZ100x7X9XazUW2hbsCozm7TplG+66iahcQOsruPhEd4z6L9
         WE9gDhSLmlQ45ehGsH8OCeUlZrKMEhkLFcwrKRYGC/GqaTcuxvN0E3p5cXkl9lWe2vH2
         G3t6wl3yWR/Gk304Gaj/j6cp319e3wWas9gbaT1yF7O2GmiHZ8iF5C1Reyl0ZcZbgCci
         ZjF5oDlo6CNL++u6BQ1jCwPVkKOl4rHT2aWHHv0b6UqEpClQXYpB1JZRGocLR5TFbFN3
         JSllbci1P7Fd5xzcXfcP7U2iwC3C4gbK2OlDfVV9OqmqxOcnC4+ZNM7u2GmQzS7zlOzo
         Jk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3FGogfrOlZYzzJx7oyy5WGaDkXUqbYDBHhOjM1pxY8=;
        b=TjsKJov3FGxTmCC8gts0+M9RMnv+4zCwRmO8GanRKjqfqArc6KDE6ISH/2Ta33vEJT
         c+IA2zCxB5ZdhZo4ezch4BO9dKrjURf3Fgjw47CEbSe7JMcMhL60dtlqqWEO+UGNepIP
         gTuSnOmbNZjANC8rLN4MKcApVk1tGGc14BKAF+JExARgWFQqkw96T2BKD7QlL1RpWmMc
         O9SfIPHD/XIhCSoG1QTmPRCs/6yLPxCaECkOIynpeL6bqsvXG74+OAFLkT+RjO+Zz2ZO
         SrBQTszcohf8c7nagVPrqC6h/artU7X6H1/eS1dcKFXoXFGDE/dHKCeZKBM6bMffzDbM
         W9iA==
X-Gm-Message-State: AOAM531Ve2CJfa56IK72aEQ89+AfRBF4u/1Yuq9Sd4G3RfL1NCzu523v
        duDB/mAWM04Kbork4elC60ZEioFtUjSsYoURFDo=
X-Google-Smtp-Source: ABdhPJxpr4KLdFVLX/G+HRLnNe/5zS40qx7tyTGXkTbo7TzoRCNpqmAZNqAdK7pYfpAekZZz6g6OIZK01fiki5M/Wlo=
X-Received: by 2002:a17:906:e212:: with SMTP id gf18mr8203859ejb.551.1610700306822;
 Fri, 15 Jan 2021 00:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-4-charvi077@gmail.com>
 <X/9DdGnYo7RQz5CE@nand.local> <CAPSFM5fuT0QAK9wJ_HuH3t=qThPx7Opwy0GrYieVntJ8A4ARMA@mail.gmail.com>
 <abc9334d-a9ec-a041-aa04-16cb4f01372a@gmail.com> <CAPSFM5co06fdo=vqTMeHLtYyP37qucGVRtOiFsZBwiR1UOsm8Q@mail.gmail.com>
In-Reply-To: <CAPSFM5co06fdo=vqTMeHLtYyP37qucGVRtOiFsZBwiR1UOsm8Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 15 Jan 2021 09:44:54 +0100
Message-ID: <CAP8UFD3_RPrFQELiBp=QFgheQa8RhDYcwgLmG9Eb4fFKH4p+FA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi,

On Fri, Jan 15, 2021 at 9:35 AM Charvi Mendiratta <charvi077@gmail.com> wrote:

> On Thu, 14 Jan 2021 at 15:59, Phillip Wood <phillip.wood123@gmail.com> wrote:

> > On 14/01/2021 08:27, Charvi Mendiratta wrote:
> > > On Thu, 14 Jan 2021 at 00:31, Taylor Blau <me@ttaylorr.com> wrote:
> > >>
> > >> On Fri, Jan 08, 2021 at 02:53:41PM +0530, Charvi Mendiratta wrote:
> > >>> From: Phillip Wood <phillip.wood@dunelm.org.uk>

> > >>> +static size_t subject_length(const char *body)
> > >>> +{
> > >>> +     size_t i, len = 0;
> > >>> +     char c;
> > >>> +     int blank_line = 1;
> > >>> +     for (i = 0, c = body[i]; c; c = body[++i]) {
> > >>> +             if (c == '\n') {
> > >>> +                     if (blank_line)
> > >>> +                             return len;
> > >>> +                     len = i + 1;
> > >>> +                     blank_line = 1;
> > >>> +             } else if (!isspace(c)) {
> > >>> +                     blank_line = 0;
> > >>> +             }
> > >>> +     }
> > >>> +     return blank_line ? len : i;
> > >>> +}
> > >>
> > >> OK, so this gets the length of the subject in "body", which is defined
> > >> as the run of characters before a newline and then a space character.
> >
> > The length of the subject is the run of characters before a line
> > containing only whitespace, "hello\n there" would return 13 "hello\n
> > \nthere" would return 5. Looking again at my code there must be a way of
> > writing that function that is easier to follow.
>
> Okay. I will look into it once, thanks for explaining.

You may want to look at other places in the code where we deal with
the subject. For example there is find_commit_subject() in commit.c
and find_trailer_start() in trailer.c that might have interesting code
for our purpose.

Best,
Christian.
