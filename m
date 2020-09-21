Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F38C4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4995C23A5D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+uDPOat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIUU4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgIUU4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 16:56:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8BC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 13:56:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c2so12269340ljj.12
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=991Dyt6dieU/Ri3uZJtwHzfwG0KmIiRgGxIuNqOpFkg=;
        b=j+uDPOatw4ngMKcsa/OqWGjca6BA3C/xlkupOKFX9Lbjvv/+LqEyMv1F7zmKeDwdlm
         2X+L69oJx+uzDkpLR6f59mtLWrbatDZrjL1qta0MOyQN6yoQIxCGbtA53RQBsWQ5uVpl
         t+7o3H1vw29OpYTpTAD2+on2r/+RZi1WzeS/qXFkXcO0bBCBrctv+8o6LD5bpL1L8OdJ
         hDlv0Q5+GK22yeSyd+p9FCX+Q9D+qzES8ZjVspgCTtwhlkSGAyMLJzhwYdgj4NJCokLZ
         2H+LdaBuUkvzOQ8EMhHcHSNSykO/q5HFRFkNOuJfUb2B/9Sb37az4AH5cn4fbHeV1BZ0
         z2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=991Dyt6dieU/Ri3uZJtwHzfwG0KmIiRgGxIuNqOpFkg=;
        b=hKi/wWYhj4XXN3P+ZV8F1nZVqxDqljmb/kOYLtvp6WOQkc7g+jib841ZBfRcDrKpIc
         9NkW5pZj+uVb+nWH+aSGXuIx8qIDJT95UQe+o+FNw1gKoE/IJjw7EqkMSe87qW1rag1d
         VaqPWbxiEUS1RdUEcYEeA9F0D4QcYJnOdlh311hRVlnATnWCXZtfiovroLxhwz2aRep7
         NzooUQLYo++jx3W5kPNDzC1jAZ7Yo+0xrSGVnkJM52CJ5f3JNVR+m1Zt07xI3UCYz5z8
         z2u8L9JlQ8onMZtxFEc+CHz83a6MDHSaNF37tPYzAmLyldgrd1817wWFlUj3zsJ0LaVg
         Tk4w==
X-Gm-Message-State: AOAM531rpPFF/TQatW4z1YWEtie9WA7dFKAT+dNBF4OgHrpzfb4PC7z/
        MKSFjAI69Li4f1zQdzUpPQqOxsJ216dTM/XDVOulvxp4YzA=
X-Google-Smtp-Source: ABdhPJwRHZ21IToIjBKLPShZDeAsjgeEmQ0c9zHBgWUDwxP9IYqDTFWLXfUwrS3cmJy4pwDlFr6qA9FelO0mps5YkHc=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr409014ljo.95.1600721798127;
 Mon, 21 Sep 2020 13:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com> <a9b7cac1-1993-dbf9-a048-a81c2c39a906@gmail.com>
 <CAP8UFD05qPn6kGRTQGhwABvZbfoH3xcK3VpFo7d5koj9d7mUsg@mail.gmail.com>
In-Reply-To: <CAP8UFD05qPn6kGRTQGhwABvZbfoH3xcK3VpFo7d5koj9d7mUsg@mail.gmail.com>
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
Date:   Tue, 22 Sep 2020 02:26:28 +0530
Message-ID: <CAP6+3T11vpwgJJZQwTC6vgp2+RzRS8fxLLyZrbFvt3=cmi8vyA@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 21, 2020 at 9:52 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sun, Sep 20, 2020 at 6:31 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> >
> > On 07-09-2020 00:26, Kaartic Sivaraam wrote:>
> > >> I would appreciate help to find project ideas though. Are there still
> > >> scripts that are worth converting to C (excluding git-bisect.sh and
> > >> git-submodule.sh that are still worked on)?
> > >
> > > I think Dscho's e-mail linked below gives a nice overview of the various
> > > scripts and their likely status as of Jan2020:
> > >
> > > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/
> > >
> > > I'm guessing only the status of submodule has changed as it's being
> > > worked on now.
> >
> > After giving it a second thought, I believe I should take back my word
> > about the git-submodule status changing. There still seems to be some
> > work left for it.
>
> Yeah, there is some work left, but Shourya said he was interested in
> continuing to work on it.

Yeah, I am a bit busy right now catching up with the classes and assignments
in my college. I will try to deliver a follow-up v2 to 'submodule add'
in a couple
of weeks.

> > To be clear,
> >
> > - there's 'add', whose conversion is currently stalled [1]
>
> Yeah, but it hasn't been stalled for a long time, and sometimes it
> takes time after the GSoC or Outreachy period for former GSoC students
> or Outreachy interns to resume their work.
>
> > - there's 'update', which still has a decent amount of code [2]
> >   in the shell script.
> > - we still have to complete the conversion completely converting
> >   moving the rest of the bits from `git-submodule.sh` to C which is
> >   mostly just the option parsing. This might be more trickier than
> >   it sounds as we would've to ensure the we don't accidentally
> >   change behaviour of the options when moving the option parsing to C.
> >
> >   There's also an e-mail from Junio which is relevant [3]
> >
> > I'm not sure if this would be enough for a complete project on it's own.
> > I'm also not sure whether 'add' would get converted in the meantime. In
> > any case, I believe we could add a few other small refactoring projects
> > to make up for the rest of the period. For instance,
> >
> > - Replace more instances of `the_index` and `the_repository`
> >   (https://github.com/gitgitgadget/git/issues/379)
> >
> > - Turn the `fetch_if_missing` global into a field of `struct repository`
> >   (https://github.com/gitgitgadget/git/issues/251)
> >
> > - Possibly others from #leftoverbits
> >
> > Thoughts?
>
> Yeah, without 'add' we would have enough related issues for another
> project. I would prefer though that we wait for at least 3 months
> without any progress before suggesting them as a project. That's what
> we usually do and I think it's the right thing to do.

If we are talking about submodules, then one project can be to improve
the parsing of 'submodule--helper.c' and try to eliminate the shell scripting
for this purpose. Another thing which can be done is to clean up the helper
sub-commands which were created to aid the conversion (iff they are of
little to no use now). I do not have an exact idea if the "improve parsing" and
conversion of a couple of subcommands* will be a project big enough
for Outreachy
or not though.

*'submodule update' is a bit messed up right now and will need a solid
conversion
to C since some of its fragments are there in the C code while some
aren't. Also, the shell
code of this subcommand is still there meaning that the fragments do
not play any direct role
in the functioning of the subcommand. I can pass on the conversion of
'update' to Outreachy
if the addition of this will amount to a complete project for a
potential Outreachy intern.

Regards,
Shourya Shukla
