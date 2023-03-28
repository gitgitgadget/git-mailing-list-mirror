Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2562BC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjC1Ry0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1RyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:54:25 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B9CC3C
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:54:21 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id i10so11080782vss.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680026060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rz05giQJhtWq0SqKMWyshIHEZhHw+9ZSbShO4DbxHV0=;
        b=CgQtkJ97nQ1haT1c9DUDAXi9cjvAb7qTPwAZpliYn6jvHm2oRd3GmIhhHbf1dPcQp4
         qTjyxceFLjTWjTYpM1auZe9dx+SlByUYxduufVwJOIiFIS5a2+g9hFKBk8ij9x5bacpO
         zl2xDCiUQHS3phoDGDvu5YMHAVOKiCRGOPAP1rsBOx+bYr421Dn86Q0Ubnfz+D8y0P7G
         W6p6RjycxHT8l7sY7y58S9F7iBY0lFt52bR1DBgiKhIOtjPYZsPoEh5cL1yaT+xi/8WV
         30pgquM02ggiSggCysfnhmVP8z5pjwUvawhFS0v+mMmDC+4adE6PVOzLITdSX8jF6E0U
         Ko7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rz05giQJhtWq0SqKMWyshIHEZhHw+9ZSbShO4DbxHV0=;
        b=oWIvCDyIwOtCxx4cJlEemwuheqQw3swpOazkrNmEw9mj2AXqdMbm5UIKcZTllQCd6L
         N3BFkG2EeofxMM+9GXjWCW9bv87A8bV+v0NuB+RGjzbicBMY8WEyhm81ltTvDKv9nrXC
         qu+zxDSRppmMomOuEgnRN45CRxPgciXoHxkrgfveonWzeo1tAhSN/Xn606oosBVey0V5
         EW8x255a3qdTrlWw9VcVaGAbr8/JUoG8ELP3n85QwglgcnZQXx9EY7Fwtay7pdgutdia
         z+2Ii76N3+UdH5njM11QVh0CNSTGxIMCous7siT7MzMZ5w9TuoSYN5a74Jl58hRWnZFs
         SmRQ==
X-Gm-Message-State: AAQBX9fnHF6jRG6zZq1hyQlg/Ra3whPft13+eMwIG/3jzFpkQKwSkmIC
        KpdA2++GnSU5d0+uOdpQlIYnM4/C+4OH6J1Fo68YMKFBTCFQMQ==
X-Google-Smtp-Source: AKy350Yb12NoxLHB4xum1GsLIM/PugjM3m2D2xH6oUkZnSLCyAcgjemZbvdtakNgHAPi85a+UBRuVxUyWETb5A4f6II=
X-Received: by 2002:a67:d78d:0:b0:425:dd21:acc8 with SMTP id
 q13-20020a67d78d000000b00425dd21acc8mr9050906vsj.7.1680026060574; Tue, 28 Mar
 2023 10:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230226083347.80519-1-gvivan6@gmail.com> <20230323063844.23222-1-gvivan6@gmail.com>
 <bfd16069-e542-e8c2-e32e-b3e08fc27211@github.com>
In-Reply-To: <bfd16069-e542-e8c2-e32e-b3e08fc27211@github.com>
From:   Vivan Garg <gvivan6@gmail.com>
Date:   Tue, 28 Mar 2023 11:54:09 -0600
Message-ID: <CACzddJq14xPcYcYonyEnZi=Bbji0-fq-M+o01AxxncxDj7AGDA@mail.gmail.com>
Subject: Re: [RFC][PATCH v3] GSoC 2023 proposal: more sparse index integration
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hi Vivan,
>
> Sorry for the delay in re-reviewing! You've largely addressed my original
> comments, so I only had a few follow-up questions/notes to add.

Thanks for re-reviewing!!

>
> I'm guessing these two steps will be much shorter if the command is already
> compatible with sparse-checkout (<7 days for step 1, and you could skip step
> 2 entirely)?

Yep, you got that right! Perhaps I'll add an optional tag to step 2 to
indicate that it
isn't required for each command.

> Does this also account for the time _after_ submission to the mailing list?
> Responding to review comments, iterating on changes, etc?

It does account for time to reiterate until it reaches a reasonable state
(similar to my microproject [1], in the sense that even though it has not
yet been merged, it has received one approval), after which I plan to start
working on the next command and continue reviewing the patch for any
minor changes that may be required.

[1] https://lore.kernel.org/git/CACzddJrZ8YdJ72ng3UpMGN9CJx0qW1+fZfyi3q01z2487V8fxw@mail.gmail.com/T/#m792fa5cc6c77c5ccb114b488beb72c1ea6145e34

> At this point, initial integrations for both 'git describe' [1] and 'git
> diff-files' [2] have been submitted to the mailing list. To make your plan
> more flexible/resilient to concurrent contributions, I think it'd be
> reasonable to give a list of 5-6 commands you'll choose from to complete
> your 2-3 planned integrations.

I will do that! I didn't realise integration for 'git describe' had
begun until last
week, when I began working on it. I believe I will have to abandon the work
I did over the past week because someone else started working on it
before me. However, I also feel that I might not be able to squeeze out enough
time in the coming week to be able to start and push another command
integration before the application deadline (Apr 4th).


>
> [1] https://lore.kernel.org/git/pull.1480.git.git.1679926829475.gitgitgadget@gmail.com/
> [2] https://lore.kernel.org/git/20230322161820.3609-1-cheskaqiqi@gmail.com/
>
> > +
> > +This schedule is based on the order of difficulty outlined in GSoC 2023 Ideas.
> > +
> > +It's worth noting that each integration may require different amounts of time
> > +and attention, and modifications to the schedule may be necessary as I delve
> > +deeper into each command. Nevertheless, I am committed to delivering quality
> > +results within the given timeframe.
> > +
> > +In summary, I anticipate that each integration will take an average of 1.5 months,
> > +but I remain flexible and open to adjusting the schedule as needed to ensure the
> > +success of the project.
> > +
> > +Availability
> > +
> > +I commit to responding to all communication daily and being available throughout
> > +the duration of the program. While I will be taking some summer courses at my
> > +university, I will not be enrolled in a typical full course load. As part of GSOC,
> > +I plan to commit to a medium-sized project of 175 hours. I have experience managing
> > +my time effectively while taking courses and working full-time internships in the
> > +past.
> > +
> > +The program is officially 16 weeks long. To ensure timely completion of the project,
> > +I plan to spend 8 hours per week until August 15th, which is when my semester ends.
> > +From August 16th until September 1st, I plan to dedicate 8 hours per day to the project.
> > +There are only three weeks during which I would prefer to focus on other things:
> > +June 23rd-30th (midterm week) and August 1st-15th (finals season). However, as I will be
> > +committing 8 hours per day following Aug 15th, it should be ample enough to make up for it.
>
> Thanks for adding these availability details!
>
> > +
> > +I am confident that I will have ample time to complete the project within the allocated
> > +time frame. Additionally, I am hoping to continue working on the project even after
> > +GSOC ends, as there are several functions that need to be implemented.
> > +
