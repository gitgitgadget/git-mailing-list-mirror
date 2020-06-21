Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF8C433E2
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 01:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1814224755
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 01:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpKXXQ8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgFUBex (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 21:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgFUBex (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 21:34:53 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABBC061794
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 18:34:53 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t25so12249264oij.7
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 18:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2qXbccka25can+jx6KAYWHHksjF11mIIu0r5aOr8Ac=;
        b=kpKXXQ8MKG2igY7l9KRWfLW/JM9QJDeIJMhLFGgFuHrKw4rXKOfXAcgOk40cywVtCH
         SIEIRLWVHUNwLuTI7Euaj7/LelGSADb9Rvn99L3L154924VzUb0HaI2ped7gjChoxpHm
         b7QehCFp9IwhI58jE58TCcfO60fiC/1egyg+LiK5u24pofUTvathghivrmCBPLI6uK9c
         wKj4leoB48FMQ9u2ctVCnf1CSyZyMjMs04XkJ7VFZYg+Ahe1CkcFx68zpZ7ybPYJyPYT
         VWgPrhy7n4XUubuFgmb8+Gq212bKfG0O+EhCnsSL5NmCfFxtoukHMoc2lY8t3hrcQs7T
         NMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2qXbccka25can+jx6KAYWHHksjF11mIIu0r5aOr8Ac=;
        b=JOq2CCyUQtkHYt6c4iZuRWZHhHbw4M+3FW9YlyYUpi2yFLbgI1/UiezJ/BI9kp7YIK
         i4Y9zHqtQYCCjCdzXIjT3em0bQlpfkVP6+kkZ08TrN4zCqHBRdOFNiR5KxY5Jm3W4WcK
         /ehXa1vB8rEmPPgBDZWYVRiVKXKMA61bbPXBBZCuNfvDbXWLVZ+6/LUl7JDAg9hs+AQJ
         PjDqPTizEWNocmlvYc5+aGPRCeiiBO5orukYB+hrkmd5vve07Zj9FgUtWybekxFNx8kk
         oDGZB+36WDhcNIAg0sbsbRr6xbRCWZJRxmyq4XCSX/tdSYXlsMWvHrd11JMuVwm4utvF
         vSzA==
X-Gm-Message-State: AOAM531d26ZhtQNyNX+YlpGN89j2UvsXbo3Pj1Arm2rxFA0SsAVzKOG4
        HiCXliT6VYZ7UZa9TBefIJ79xxMz1uhOEq8Yr5E=
X-Google-Smtp-Source: ABdhPJyN2eAdZ9ZTBbyC7CkUUOQlEKyQPPauKJI9qDIVam9kEzDSasSYF8sX7dnh3A1cqr9xFAsyYtTGTSikVn7DUJM=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr7906996oic.31.1592703291121;
 Sat, 20 Jun 2020 18:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
 <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com> <xmqqwo44kpyk.fsf@gitster.c.googlers.com>
 <CABPp-BHLDhRTpdjfrG5WLjwxkegC--RXrjzxV+ufYKnH+Kdifw@mail.gmail.com>
In-Reply-To: <CABPp-BHLDhRTpdjfrG5WLjwxkegC--RXrjzxV+ufYKnH+Kdifw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Jun 2020 18:34:39 -0700
Message-ID: <CABPp-BFh94eP89CNCrXknaUbm7cHzpn8N4xYWZTsVYWGrB8RkQ@mail.gmail.com>
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

On Thu, Jun 18, 2020 at 4:18 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jun 18, 2020 at 2:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > Some of the feedback of folks trying out sparse-checkouts at $dayjob is that
> > > sparse checkouts can sometimes be disorienting; users can forget that they
> > > had a sparse-checkout and then wonder where files went. This series adds
> > > some output to 'git status' and modifies git-prompt slightly as an attempt
> > > to help.
> > >
> > > Note that as per discussion on v1, we may want to later add a git
> > > sparse-checkout subcommand named something like 'stats' or 'info' or
> > > 'status' that provides more detailed information for users to dig deeper.
> > > That would be an additional improvement for helping users find out more
> > > information once they realize or remember they are in a sparse checkout,
> > > this is just aimed at giving them a simple reminder.
> > >
> > > Changes since v1:
> > >
> > >  * Replaced the -1 magic constant with SPARSE_CHECKOUT_DISABLED
> > >  * Fixed a possible division by 0 (when there are no entries in the index
> > >    AND sparse checkout is enabled; not sure when that'd ever happen but
> > >    still better to guard against...)
> > >  * Slight wording tweaks for the git-prompt commit message
> > >  * Removed the RFC label
> > >
> > > Elijah Newren (2):
> > >   wt-status: show sparse checkout status as well
> > >   git-prompt: include sparsity state as well
> > >
> > >  contrib/completion/git-prompt.sh |  7 +++++-
> > >  wt-status.c                      | 41 ++++++++++++++++++++++++++++++++
> > >  wt-status.h                      |  2 ++
> > >  3 files changed, 49 insertions(+), 1 deletion(-)
> >
> > Any change to Documentation/git-status.txt?
>
> Reasonable question; I didn't think of it.  But on a related note, in
> the eight years we've had status output for various other forms of
> state (in-progress operations like merge, cherry-pick, rebase, or
> bisect), these haven't been documented either.  Was that also
> oversight, or was there a reason it was left out?
>
> If oversight, should I just document all those others while I'm at it?

So, I went to look at this.  Documentation/git-status.txt documents in
detail the short status format, the porcelain V1 format, and the
porcelain V2 format.  There are two side comments that the long format
is the default, and that status.submoduleSummary affects the long
output, but the only thing it says to document the contents of the
long format is:
"""
The default, long format, is designed to be human readable,
verbose and descriptive.  Its contents and format are subject to change
at any time.
"""
It would thus feel odd to mention the sparsity status within the long
format when nothing else within that format is documented.  I suspect
that's why it was never added when rebase/merge/cherry-pick/bisect
state notifications were added to the long format.
