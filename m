Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA06BC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 23:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10A62078D
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 23:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU+QeLQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgFRXSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFRXSb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 19:18:31 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E92C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 16:18:29 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x202so6740054oix.11
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 16:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgCiiep1+k08L/LigWIWg1/MrtVzK9Vnrbgg0BJyUdI=;
        b=OU+QeLQiT+uCCJIX91aazCAg4V7IVU0anilDI+6ejP/FGcAqFmrFpldoo4vI4RL1MK
         5O1iYSj9LOVgBfkq9hUJDHg96Le6r33Vtjqv31zdDMlRQIyxBafCysiBUvNgnx0UHGeJ
         XaX2TXL8jhzkKAlVamFqUXHXH1Y312h4+0Va3R89NOnOevGsSkUgPofPVWxZC8j7zsBy
         6WHJ1nQDWEatektjP3liOFHQjHNydEb9dOZDqNhxKx+SZDYXifygI8fFE3kAKavPa3ZF
         giFlX2cFl0ApEKvTvrST50TLynN8fLhYlWKnG5CGtluWMi+TO04OgMrDv23k5dcQ85TD
         N64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgCiiep1+k08L/LigWIWg1/MrtVzK9Vnrbgg0BJyUdI=;
        b=Y8ZtGlTU5SzZAkeg0EU2YrRvYy0RSEAy9j/fdM6T5Xvoak1X9rbwP+JesvbRcx8v+O
         D14Ae3gXgEy7zFY2PzUdgeSC1tV9AFNTzC+f3gO0Ue7Ga5IcKNoYDlQIEtLQODysPTu8
         ovod5w3jQHUPOSkZTPr2Qf8CKWFZ2J1tZj0zkmoMyy6kwBY+BXy2fkoc3AQYAhPdMw/W
         kUWV+8Swx+uw1546Qt3WwG0EjkTQfVX7dUBuAwkGpTA8nf5MkJxJBGs7AD9WSagqD7tt
         utsm+wnTGONcTmzgoczSSgyTBQu3u8qU7I9b3k3Hy+FrTTGVDGTJq7y97qD6GQdWdh6w
         kN6A==
X-Gm-Message-State: AOAM532LqtdfK7TknZ7pLH4TAzzOVphnYsS6NJCVbNkaMr0fjjSDlYEq
        drvRwphqu8lhaUIIZ27fgBuLVb8VA9Xv42xS7d0=
X-Google-Smtp-Source: ABdhPJytDb8KpvuoYrf/n/tn/XvoJi/rcZjqofwp8Meda0sYXDivj+n+n89wlL5ivVD6RVaKSfVbrwyIQPb9099e628=
X-Received: by 2002:aca:2b0d:: with SMTP id i13mr1093592oik.39.1592522308135;
 Thu, 18 Jun 2020 16:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
 <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com> <xmqqwo44kpyk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo44kpyk.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Jun 2020 16:18:15 -0700
Message-ID: <CABPp-BHLDhRTpdjfrG5WLjwxkegC--RXrjzxV+ufYKnH+Kdifw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Sparse checkout status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 2:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Some of the feedback of folks trying out sparse-checkouts at $dayjob is that
> > sparse checkouts can sometimes be disorienting; users can forget that they
> > had a sparse-checkout and then wonder where files went. This series adds
> > some output to 'git status' and modifies git-prompt slightly as an attempt
> > to help.
> >
> > Note that as per discussion on v1, we may want to later add a git
> > sparse-checkout subcommand named something like 'stats' or 'info' or
> > 'status' that provides more detailed information for users to dig deeper.
> > That would be an additional improvement for helping users find out more
> > information once they realize or remember they are in a sparse checkout,
> > this is just aimed at giving them a simple reminder.
> >
> > Changes since v1:
> >
> >  * Replaced the -1 magic constant with SPARSE_CHECKOUT_DISABLED
> >  * Fixed a possible division by 0 (when there are no entries in the index
> >    AND sparse checkout is enabled; not sure when that'd ever happen but
> >    still better to guard against...)
> >  * Slight wording tweaks for the git-prompt commit message
> >  * Removed the RFC label
> >
> > Elijah Newren (2):
> >   wt-status: show sparse checkout status as well
> >   git-prompt: include sparsity state as well
> >
> >  contrib/completion/git-prompt.sh |  7 +++++-
> >  wt-status.c                      | 41 ++++++++++++++++++++++++++++++++
> >  wt-status.h                      |  2 ++
> >  3 files changed, 49 insertions(+), 1 deletion(-)
>
> Any change to Documentation/git-status.txt?

Reasonable question; I didn't think of it.  But on a related note, in
the eight years we've had status output for various other forms of
state (in-progress operations like merge, cherry-pick, rebase, or
bisect), these haven't been documented either.  Was that also
oversight, or was there a reason it was left out?

If oversight, should I just document all those others while I'm at it?
