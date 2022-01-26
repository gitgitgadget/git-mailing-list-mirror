Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3359C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 14:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiAZOoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242297AbiAZOoP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 09:44:15 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79039C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:44:15 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k17so16775731ybk.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsHwBQBmemIMTWqzxovoCpI3Ix95+VAChSH9mQToW/k=;
        b=MwUtg9Q2W+gf+/J3+CN7LOkubVwRg0CRMgoqD7ajH62cVK1Sznz/7S34+xjVNd3lbj
         8KUldmN8N9k/DDCEp1f5HDlFVqCzGqBfQEaDQUS0g8bU5Crg0yslRTDklSuND1sBQFpe
         LtrGI7UCN9QKXjBPoANRScfNw3OqPb4OZE1Jge9ItN5uj/RrGdhUNxkM5lm2Z8Np3eVX
         WLTkLKnS4+rsmVCpHyhgYEcHOTc/rcovaJm1w2sCOohu2B2XLPkDGNatcmC62aOXJLk1
         nWFAS8AFhTp+T6M/2trwLjJevWsYuSOPGQ94z9UKSejCwtYHgP8+44zJuHuAdnk5Y1yI
         NylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsHwBQBmemIMTWqzxovoCpI3Ix95+VAChSH9mQToW/k=;
        b=TYkKKUHMepg+UlFD40lSMtzx0TWR1ZBctHCsW6WjgPvvxQTgQ1iwkK6aV5rQyfDiX6
         iAXzx2EW4yvhfjVDBJTp7Ch2jTKJEXqDCmKsrC/lhlxJVeF58/bn9ONXqSp4RJPdIbZb
         X9EZ2ychGpUm3CowKbSRdnGUsCLst+rywcEe4XahfIHI+MdrLxulW7SJHGKIKWAt1vbw
         yJQ7Cbd4wNzicAIZtoYxTNMHyqLCR2rgsrRuOL08lb+kBKms0BcWFXlVNYfhZ/x+U67Q
         mz1wq5s5ljSj9z2AullD70JCD24qJyd9uX3dM8wLbcOIxcJPH7Q87jI9Iq80IkSPrtQW
         KXcg==
X-Gm-Message-State: AOAM532pEhwQm9BFLVTVPCYSrgHOqtDx+0i6TwEjR/gnOSsayiiAGMDz
        qr5DjseTEH2NkLiz0AKkpRR6ddaeEse2CWtZwiw=
X-Google-Smtp-Source: ABdhPJxeZ8ea+DGAuetU1EFTsY7rsYo3B+hEOyaDHfdY9BI39rHWnXVfdOk0y4JI7C3PodHL18W5TZFrKbJGlp7Pjcc=
X-Received: by 2002:a25:dac1:: with SMTP id n184mr35658249ybf.649.1643208254512;
 Wed, 26 Jan 2022 06:44:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com> <nycvar.QRO.7.76.6.2201261250380.6842@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201261250380.6842@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Jan 2022 15:44:03 +0100
Message-ID: <CAP8UFD2qFmZ2Adk71SQw9xtq5keZ=d2hcMwF=fs9OtW4==0ZYg@mail.gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side merges")
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Jan 26, 2022 at 1:03 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Christian,
>
> On Wed, 26 Jan 2022, Christian Couder wrote:
>
> > On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >
> > >  * Accept an optional --trivial-merge option to get old style merge-tree
> > >    behavior
> > >  * Allow both --write-tree and --trivial-merge to be omitted since we can
> > >    deduce which from number of arguments
> >
> > I still think that it might be simpler and cleaner to leave 'git
> > merge-tree' alone for now, and just add a new command named for
> > example 'git write-merge-tree'.
>
> That would assume that the original `git merge-tree` implementation was
> useful. That notion has been thoroughly refuted in the meantime, though.
>
> I am really opposed to introducing a new command here. Elijah took the
> best approach we can take here: save the `merge-tree` command by teaching
> it to do something useful.

I think it's a question of point of view. If a command is completely
useless, then most of the time it needs to die, not be "saved". We
would need good statistics, but I doubt we have "saved" many useless
commands before, compared to commands we have just killed.

> > Later we can always add flags to 'git merge-tree' or add 'git
> > trivial-merge-tree' as an alias for 'git merge-tree', and eventually
> > slowly switch 'git merge-tree' to mean only 'git write-merge-tree' if
> > that's where we want to go.
>
> I suggested before, and seem to need to repeat again, that we need to let
> ourselves be guided less by hypothetical scenarios, and more by actual,
> concrete use cases where the revamped `merge-tree` command is useful.

Ok, see below.

> And since I already provided some feedback based on my work from working
> on a server-side backend, I am fairly certain that we already have a
> pretty good idea where we want to go.
>
> > > Stuff intentionally NOT included, but which others seemed to feel strongly
> > > about; they'd need to convince me more on these:
> > >
> > >  * Any form of diff output[1]
> >
> > It's not a big issue for me to not include them right now as long as
> > it's possible to add cli options later that add them.
>
> But why? That _so_ smells like a hypothetical scenario.
>
> We do not need the diffs. It is highly unlikely that the server-side wants
> to have diffs, and if a user does want the diffs, it is very, very easy to
> generate them by chaining low-level commands.
>
> So there is absolutely no need for `git merge-tree` to produce diffs.
>
> > The reason is that I think in many cases when there are conflicts, the
> > conflicts will be small and the user will want to see them. So it would
> > be simpler to just have an option to show any conflict right away,
> > rather than have the user launch another command (a diff-tree against
> > which tree and with which options?).
>
> That assumes that server-side merge UIs will present merge conflicts in
> the form of diffs containing merge conflict markers. Which I don't think
> will happen, like, ever.

Please take a look at:

https://docs.gitlab.com/ee/user/project/merge_requests/conflicts.html#resolve-conflicts-in-the-inline-editor

As you can see in the image there are conflict markers in the file
displayed by the server UI.

> In short: I completely disagree that we should introduce a new command,
> and I also completely disagree that the `merge-tree` command should output
> any diffs.
>
> I do agree that we need to be mindful of what we actually need, and in
> that regard, I reiterate that we need to let concrete use cases guide us.
> As part of GitLab, you might be in an excellent position to look at
> GitLab's concrete server-side needs when it comes to use `git merge-tree`
> to perform merges.

I hope I provided a concrete use case with the link above.
