Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2993C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 07:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606FA22277
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 07:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBM6fLoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbgJIHmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 03:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgJIHmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 03:42:11 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB45C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 00:42:11 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o9so3829874ilo.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3oG9deTibpFKMUW3yag8DOq7r7i/RFzq5B1TwUOPTaY=;
        b=BBM6fLoiv4b4U15xC1PlzByEjW4jFDn2a7WI7MlKXcPb6xBcrm+UyeLx6Pg6WKjiah
         B3EL8MOoRAMvrS/qgq1dXGPdspwAyJ23KJB5R55v+cze6j19ln9SO8Duu94M74eQ3Qgf
         gph6JrmuyijpfULouAaf+LNEuTgOZpHmZaTKHp9zZkIT/O7GMn9aOL12GTJT6a2evaSJ
         2vuB6H5vHUUqZLldEuTF8iDN6NZ2vFKnT47Rnkkt/Fd7G90TOpZBQ/ckjAA1yss4jkQP
         bnwBW0j0rkS7kIdPINiRwzIN2jFzwWff4kVRexe9USyGKk+4p1czPsTcn47kq7zbj0Yt
         lNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3oG9deTibpFKMUW3yag8DOq7r7i/RFzq5B1TwUOPTaY=;
        b=PEd0gXN4kfrpftDb/CWT8DiPNTkclLoZzVCK+eVXpgYOChDID2t0gI6LoxJSR7OluJ
         B1g8E7hImC3EpALlA6LwGCEVFwGx992WIg/fiKhi39cAYuChzC+vxmEmuLOQL8NjjsA6
         85/5yYrOUGVXtg9yBD3uO/oS5GXSyvNMHTEn3ECAf0DOpO2hC18D4b6X+zNIap580tBR
         SEwMV2lPpuZlw8ihhbJX+knZtILQPMYl8YO0WUCamgfydOItQZY8XTvCWc8B8Hx8sasl
         tKCGssN+idRDbvCrrGhXk4BNpG70iVyEJxYydmIUwW/WNsrI9Ng88TaaKkUwsxJEOdQg
         6pcw==
X-Gm-Message-State: AOAM533O5nXO242qYdE/W40CBitMmLyVDq5oEnnl/khv6MoTLqWpoy/Y
        yNlXnLlsIpr3e7TXWwwUPYW2jgDvdXSf0j2aaaYb0p9N
X-Google-Smtp-Source: ABdhPJxARADmzviz5Zv8VeE0IIN0XnAVVRQLNENrNqNBdjHjJ/fWV71OJk5nyg7Ny/H/iVamD8tvg0Gfzx48MTEXvIM=
X-Received: by 2002:a05:6e02:10:: with SMTP id h16mr8837178ilr.5.1602229330423;
 Fri, 09 Oct 2020 00:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
In-Reply-To: <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Fri, 9 Oct 2020 13:11:59 +0530
Message-ID: <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the explanation, Philips. I think there's a long road ahead
to understand how everything is implemented and put together.

Coming to the microproject, it was said that there is an inconsistency
in --dirty behavior shown by `git diff` and `git describe --dirty` for
submodule state when the files are untracked.

From what I understood by looking at the code, the diff files states
that we should ignore untracked submodule states. So is it that I have
to make changes in the way git describe is implemented by ignoring the
changes in the untracked submodule?

Also, I wasn't able to look for this inconsistency in my local
machine. Any pointers on how to reproduce this might be helpful.

Thanks and regards,

Sangeeta

On Thu, Oct 8, 2020 at 2:37 PM Phillip Wood <phillip.wood123@gmail.com> wro=
te:
>
> Hi Sangeeta
>
> On 07/10/2020 21:10, Sangeeta NB wrote:
> > Hello everyone,
>
> Welcome to the list
>
> > My name is Sangeeta and I=E2=80=99m one of the Outreachy applicants.  I=
 would
> > like to work on the microproject "Unify the meaning of dirty between
> > diff and describe".
> >
> > While looking at the files for `describe` and `diff` commands I found
> > that the `describe.c`  is present in builtin[1] folder whereas diff.c
> > is found in the root[2] folder as well as builtin[3] folder. I could
> > not find any implementation of --dirty in the diff.c present in
> > builtin[3] folder. So is it that I have to compare the implementation
> > of describe.c[1] and diff.c(of root folder)?
> >
> > Also, I was curious to know why is there a builtin folder when many
> > commands described in that are described again in the root folder?
>
> The files in the root directory are (mostly) library code that ends up
> in libgit.a. The builtin directory contains the individual git commands
> that form the git binary that is linked with libgit.a. builtin/diff.c
> contains cmd_diff() which will be called when the user runs `git diff`.
> That function parses the command line options and sets up the necessary
> data to pass to the diff implementation in /diff.c. The diff and log
> family of commands are a bit different to most of the other commands in
> that the option parsing is mostly done by calling setup_revisions() in
> /revision.c rather than using the option parsing library routines in
> /parse-options.c directly. I think the `--dirty` option for diff ends up
> being handled by handle_ignore_submodules_arg() in submodule.c, I'll
> leave it to you to see where that is called from (you can use `git grep`)=
.
>
> I'm going to be off line for the rest of today, hopefully someone else
> will be able to help if you get stuck or I'll try and answer any other
> questions tomorrow.
>
> Best Wishes
>
> Phillip
>
> > Looking forward to working with you all.
> >
> > Sangeeta
> > [1] https://github.com/git/git/blob/master/builtin/describe.c
> > [2] https://github.com/git/git/blob/master/builtin/diff.c
> > [3] https://github.com/git/git/blob/master/diff.c
> >
