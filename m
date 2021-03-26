Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D54C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 07:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE95261A4A
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 07:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCZHTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhCZHT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 03:19:28 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46640C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 00:19:28 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w70so4876653oie.0
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 00:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoLHAVUB+KPaYO3tfgp8mW3ry9i10HQ/cBCvRuzVUlU=;
        b=OeDc06qJSwhRTtiQ04hwnJeTIUoAXWRo6yigSUw4Ou1DktYtY5GsbMxvROQmU+WdU6
         LNBNCcZ5htb0G+vjhfF4kZRcK7GmJnziPfnDw5sebOsWLFpgBE7aN3ldhTbS2W/WJ/xO
         uHNuBGW/EGffxYNV06Fu7RWvQnS/Ple5kqpUOR0e/7HSaBYAeegpt0X0p4ABoRXOgqeg
         ll0X56zz5Nk+rrLoNUxoxENTH4PpIXXCbQSErtZSIxVJSwk0Cmksqp29qKgOiFboW3bQ
         pZpIkK/6/7KD9k461WFI6RTHrpQIabYhe4AKsDDmftdvdwX2nrrk4RLaTGR1Hz7QGwzh
         x4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoLHAVUB+KPaYO3tfgp8mW3ry9i10HQ/cBCvRuzVUlU=;
        b=CRm4AtF7hvJ3HQDUTTVSbiE3j0QBi6TGoGry8Miz+crk3jvueJbcNcgusyyXNogSZr
         8KqvMzXHxqJHvT/Mpp3IwWFcqxlUDP4g8qGBFBIZDO1tu4CgV1DM3SqoQ8tn83mmrPq9
         2qjvH7FcCIVmARq2musCwwHD3LpZtMkvoC/5mnwXiArgI84sPIE1MBBvfpE5adJlZi6v
         y9CIOjKAmuwSDEvRkEd0/GgzQWpfy/iCUbbumsC8kAF+9KYHY0VljcL0BBNASVVZeU15
         46O++f6ceYxODYmaOfevLf61Xhu40uP1LmdWpdSUKW0NFXsqJMOUhBTBNr8H2mTtwiX4
         seeA==
X-Gm-Message-State: AOAM5326iP8H/wvG1mDn0R/B/BGRxkB3yT7nulSgzuXRJaFJ0WMw77nV
        vx0UmPTiA0oIfdpbLh/MvW9xtnP+mNzAbdV2F/E=
X-Google-Smtp-Source: ABdhPJz8s5VOaJM67qPDPfIHBrbgDV9Bpx47x5gjHjvkJu+/SR6tOWScqxgVDuAHT6kWUNCkpyBQ4aQF2Z+Q4XmrAFg=
X-Received: by 2002:aca:6545:: with SMTP id j5mr8742755oiw.31.1616743167593;
 Fri, 26 Mar 2021 00:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <4442fd0a-3306-a22b-3614-e3272f8f0be5@FreeBSD.org>
 <YFUX+Rqdj3gteyql@camp.crustytoothpaste.net> <78c7bd2c-c487-756e-c85d-dcfe2866f5f4@FreeBSD.org>
 <CABPp-BGZebutsk5c4kf9gAuu0zgSEptxRmbEBFFwNPE03D4R1g@mail.gmail.com>
 <CABPp-BEGEcws69sg6Z2=B1nihFG227mAsSx=boU3uSx2xDUEjg@mail.gmail.com> <xmqqzgytz6h4.fsf@gitster.g>
In-Reply-To: <xmqqzgytz6h4.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Mar 2021 00:19:16 -0700
Message-ID: <CABPp-BEmKfZUHjRECWy96Y2BrhqxQPedYC4_WvXaTXShE=B5HA@mail.gmail.com>
Subject: Re: --no-edit not respected after conflict
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Renato Botelho <garga@freebsd.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 6:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > === Current behavior ===
> >                    Non-conflict commits    Right after Conflict
> > revert             Edit iff isatty(0)      Edit (ignore isatty(0))
> > cherry-pick        No edit                 See above
> > Specify --edit     Edit (ignore isatty(0)) See above
> > Specify --no-edit  (*)                     See above
> >
> > (*) Before stopping for conflicts, No edit is the behavior.  After
> >     stopping for conflicts, the --no-edit flag is not saved so see the
> >     first two rows.
> >
> > === Expected behavior ===
> >
> >                    Non-conflict commits    Right after Conflict
> > revert             Edit iff isatty(0)      Edit (regardless of isatty(0)?)
> > cherry-pick        No edit                 Edit (regardless of isatty(0)?)
> > Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
> > Specify --no-edit  No edit                 No edit
> >
> > The thing I'm unsure on is the !isatty(0) handling for revert &
> > cherry-pick right after a conflict when neither --edit nor --no-edit
> > are specified.
>
> I read the intention behind existing "edit if isatty" as "this is an
> operation the human reader deserves a chance to explain what was
> done and why by default".  For example, I read the first entry in
> your table as: Even if there is no conflict, there should be a
> convincing explanation when you revert.  On the other hand, if you
> are cherry-picking without any conflict, the intention should be
> clear enough in the original commit log message, which ought to be
> written why applying that change is a good idea, so it would make
> sense not to invoke editor in that case.
>
> If an operation deserves a chance to be explained even in a cleanly
> auto resolved case, it does deserve the chance even more if hand
> resolution was required---in addition to the original "what and
> why", the resolution of the conflict is an additional reason why the
> human should be given a chance to explain.
>
> But if it is an automated process, there is no reason to fail the
> operation merely because the process is run unattended.  So my
> recommendation for "regardless of isatty" part is "do not force
> editing".  The same is true for a human user who declines the chance
> to explain him/herself with an explicit "--no-edit".

Thanks.

Renato: potential fix over here:
https://lore.kernel.org/git/pull.988.git.git.1616742969145.gitgitgadget@gmail.com/T/#u.
Could you give it a try?
