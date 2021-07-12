Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44356C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 15:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297BF61008
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 15:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhGLP0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhGLP0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 11:26:19 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9703DC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 08:23:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t25so6049401oiw.13
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JeF6Cjy70hGsz/LmofxgXM8n3eRwOjDPkQ6TFfsI0bA=;
        b=qZ9cCoTs4+H//MSEYyyBhiC5ucFcH+jV31IAaKie57v+iAK1mtofIBY3eIfwziivhe
         dDQWjdCs+m+7h+Ooohc2ksUqvgZ/w7wfr5D/JkR1cyzqNi6JcdqSg8jIhdknPmeLbNWL
         UnSWpweOD0GOF14XxsAB0gJ1Z+iiznPH25U61EDBm8x2PyCeqM9UKhrK5WYOeoOFShGR
         zWLuD5DvDInYfLsQRUHjXmNwn/G5C7IQo3ocUMTNW4LK7smDUgNvUWJ2S4btP1FdTLKl
         CtSd/t5iXGWEfxC213FX23Jr9ynBbcD58qXCZN4ElFaRKSj7aNVkq/cYggWWW4IBndZZ
         Hqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JeF6Cjy70hGsz/LmofxgXM8n3eRwOjDPkQ6TFfsI0bA=;
        b=IJsww5Ab0j4USqVnGNtGikz/22sYDc/vx6kOOhVjMtLdQ9lZNmXf6wTPJM5zzn/ko/
         gj/QhW26CB2A7Y7dmvlSs8Cbx/HlXBsrWdwvBuLD/b7dN/CnfHLdYbNehUYaow5U6hS2
         oUJHa6z1EDfepN7ipUBSijo8lYiV2B55JmwIz3i2EJINOqY3okRgNhPKStT4VUyY2XYe
         nC5UhRw8gxUc/j/Dsy+tyXo2xecwRKbMHYfZQj8lvH3Y2lenr6d9SwfvfiEDwzoytElS
         BCfDFdzEfIZj415dJLckZJgB6I5UnRrWnmJEPRHwbvQi5RxPUxt10qe46LKcqz6kTGEg
         rNrw==
X-Gm-Message-State: AOAM530Ax/P0Ec/p8Zfxjv/MXYgtOJF8ZQx6gXHV9Fb7z+hBebTAzxnE
        bOEU1hi3yXLj6JX6joqftL+V2QLqFS5swgeW7a8=
X-Google-Smtp-Source: ABdhPJxRm+J10s/0zDg2vrmlg13c7mhAktcGmYWzQgt7XP6M+BkisfsdmDrU+ZNOltQp2OKX7AnPp6aZL+c2K4foRYA=
X-Received: by 2002:aca:f0a:: with SMTP id 10mr11062202oip.39.1626103408941;
 Mon, 12 Jul 2021 08:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
 <87a6ms4wgw.fsf@evledraar.gmail.com>
In-Reply-To: <87a6ms4wgw.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Jul 2021 08:23:18 -0700
Message-ID: <CABPp-BGE+8spsq9HZ6KNwWk_hYy5pj5vjJ8NQQuQiUN7qz7GCA@mail.gmail.com>
Subject: Re: [RFC] Bump {diff,merge}.renameLimit ?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

Thanks for reading and commenting.  You certainly brought a new angle
to the question...

On Sun, Jul 11, 2021 at 10:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Jul 10 2021, Elijah Newren wrote:
>
> > I'm considering bumping {diff,merge}.renameLimit, which control the
> > quadratic portion of rename/copy detection.  Should they be bumped?
> > If so, moderately higher, or much higher?
> >
> > I lean towards a moderate bump for diff.renameLimit, and preferably
> > more than just a moderate bump for merge.renameLimit.  I have
> > calculations for what "moderate" translates to, based on a number of
> > assumptions.  But there's several reasons to break with past
> > guideposts for how these limits were picked.  See below for various
> > arguments in each of the directions.
> >
> > So...thoughts?
>
> I think the most relevant is something you didn't state: That when this
> limit was introduced (well, diff.*, not merge.*) there was no progress
> output in git.

I am convinced that good progress output is very important.  I've
submitted multiple patches for progress output specifically for rename
detection[1]

However, I am not convinced that the lack of progress output in git
when this limit was introduced is the most relevant thing.  If it
were, then the lively thread when Peff posted his past series to both
introduce the progress output for rename detection and simultaneously
bump the limits probably would have spurred comments about not needing
both[2].

> We should err entirely on producing consistent and predictable results,
> and not change how git works when we it hits some arbitrary limit. To
> the extent that this is needed it's sufficient to opt-in to it, i.e. we
> do/should show a progress bar, advice() etc. showing why we're doing
> this much work, so those users can adjust the limit (or not).

So I've read and re-read your response multiple times, but I am still
not sure what you're advocating for.  I think you're either advocating
for rename detection to be turned off by default, or for a new
"unlimited" mode to be introduced and be the default (maybe even
redefining what the value of "0" means in order to implement this),
but I can't tell which.  Could you clarify?


[1] In particular:
   d6861d0258df (progress: fix progress meters when dealing with lots
of work, 2017-11-13)
   9268cf4a2ef6 (sequencer: show rename progress during cherry picks,
2017-11-13)
   81c4bf02964e (diffcore-rename: reduce jumpiness in progress
counters, 2020-12-11)

[2] See https://lore.kernel.org/git/20110219101936.GB20577@sigill.intra.pef=
f.net/
