Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A98C2BA19
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 02:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FD220730
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 02:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="c7T0wPo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDJCGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:06:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35435 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDJCGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 22:06:53 -0400
Received: by mail-io1-f67.google.com with SMTP id w20so469670iob.2
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 19:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNpkdz0VX/H26By7W2i3SSsXV4PxT/4CwLJLS465cT4=;
        b=c7T0wPo3VDuCafgDr9ukMqmkjvY8vxo5hktgmyYSxEdwL0Pur6RCfJbC9d+aoPhj2T
         WUjqs7E9egZtoTkJMhfXzxO9kLcWnWDFC9UPwzn2AISjIDlZkCRWroV8gCYroAdCFLVP
         WmWeUT6InP/QsvjF1nsxdb7G+A+8QeOJiIEAvgwltchBe5gpuWKv+/pzJY6h6PKV17H7
         UBaAXjPoeqpYqAidNmHtQ57JLRzbpOcGmAcuGYQkdDBw9/BD/TQQFr0bppVq329S2Fu3
         +w7OZnEk3+lmnA3IK6A9ns45g3FPXwA8Ojc0H5WR/e0XunzgjWTQYco2y+ppcA0aOjVb
         q8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNpkdz0VX/H26By7W2i3SSsXV4PxT/4CwLJLS465cT4=;
        b=tfwo0/rHGvgzVjBa21yLnqwhpky/saOF0AlZKahQ+cmz32gAd4jXbWJfojrcnma1lV
         UyKK/G4vw9fn0hTjgkssrQ+Dw0WcZdVCaAvVWwbWY1igvlk/ImivZYFYTL2Xjs0sxLy6
         3NccweC94wlwtzSVBPpw2SoLFrE1ur9TbY5cc4mS2TK9SxKEJVPi9bO4uwvr5T7CP4B2
         0B9XKzHJID+E1vP9aQ7aoWvGeVnqYRxwvs59b3vtK0YhI3ojiAyGv4npuOqjo6U18MEz
         OVSwidZAjLtHjuuMkL/fFlCFcuqeX13oXT7mwAoHr0pPSKWdPn7qymsuKNMB5MVU/V/y
         Ou0w==
X-Gm-Message-State: AGi0PubjMljPFLAraT6lz1S58rXEEw+IHSBcc7+xJi5/2nR0ULr+VWzp
        EbRHw4YHOPKwht4GWP/wmzmJTm3ZlNEgPmecZ0qtvQ==
X-Google-Smtp-Source: APiQypKSN3y6jHMeZ9oeLCPGMfKuj+C5x9BMXJvcLkuYoi5V3vm0wDDy6CnPnzO2KRlecTiGH34vbJyk3hHIlXeg69E=
X-Received: by 2002:a02:4e07:: with SMTP id r7mr2563223jaa.96.1586484413041;
 Thu, 09 Apr 2020 19:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com> <xmqqimi8kvue.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimi8kvue.fsf@gitster.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 9 Apr 2020 19:06:42 -0700
Message-ID: <CAGyf7-H4jtnVjgZ20qC-mzJHRd7Ffqm=Vh18wJPiiSS4NPnhyQ@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: mark commits that begin empty in todo editor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>, phillip.wood123@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 9, 2020 at 5:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > While many users who intentionally create empty commits do not want them
> > thrown away by a rebase, there are third-party tools that generate empty
> > commits that a user might not want.  In the past, users have used rebase
> > to get rid of such commits (a side-effect of the fact that the --apply
> > backend is not currently capable of keeping them).  While such users
> > could fire up an interactive rebase and just remove the lines
> > corresponding to empty commits, that might be difficult if the
> > third-party tool generates many of them.  Simplify this task for users
> > by marking such lines with a suffix of " # empty" in the todo list.
> >
> > Suggested-by: Sami Boukortt <sami@boukortt.com>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >     rebase -i: mark commits that begin empty in todo editor
> >
> >     If this isn't enough, we could talk about resurrecting --no-keep-empty
> >     (and making --keep-empty just exist to countermand an earlier
> >     --no-keep-empty), but perhaps this is good enough?
>
> This does look like an unsatisfying substitute for the real thing,
> but perhaps looking for " # empty" and turning them a drop is simple
> enough?  Emacs types may do something like
>
>     C-x h C-u M-|
>     sed -e '/ # empty$/s/^pick /drop /'
>     <RET>
>
> and vi folks have something similar that begins with a ':'.
>
> But it would not beat just being able to say "--no-keep-empty" (or
> "--discard-empty"), would it?
>
> On the other hand, even if there were "--discard-empty" available,
> there may still be two classes of empty ones (e.g. ones that were
> created by third-party tools, the others that were deliberately
> empty) that the user may need and want to sift through, and for such
> a use case, the marking this patch does would be very valuable.
>
> So, from that point of view, this may not be enough, but a "throw
> away all" option is not enough, either.  We'd want to have both to
> serve such users better.

This was why I wondered whether it might be worth extending the
--empty option to add another possible value, like "drop-all", that
would allow the caller to say they want to drop all empty
commits--both those that started out empty and those that became
empty. That fourth mode would be distinct from the existing three.
(I'm not sure what to call said mode; "drop-all" looks odd alongside
the existing "drop". I just say "drop-all" here to help illustrate the
idea.)
