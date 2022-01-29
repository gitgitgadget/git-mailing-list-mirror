Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A193C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 04:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352396AbiA2Ewa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 23:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiA2Ew3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 23:52:29 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CCC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:52:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k25so22905250ejp.5
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGlzR7J/kY7kaHx4IP/0p4FqRI4k/kWEv4UplmW89Do=;
        b=CjQw2eWqVx57uwbIgg6CoE46M+6pzwwft9Jr8fUsg3TFKIqvGn7+wIsW2/55XFD7t8
         A43Ae+kRT+37ACOxRqn71EJrnSprcDXC3VisqjPxNfZQ81RN81ssoSj+bwTqBpJhelR7
         b5X016BWgn7wwRAqeCSM2ZNWmFekaqDmzcIe7qKjH7UY6QpWt118LKSs3PHBdL+cz8yt
         q0L59A5V413nK8BbqC+6U8Tlw81tmrVmBakPKeDxLn0lVImsl8hVRUnRzWRX87EeEoOs
         up3jJxELQ6nnbMYGQcTrdEUbdpOxTxUM9TftJzJaDBueBs6mFZldl4SvS40dPlC1JvU+
         TFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGlzR7J/kY7kaHx4IP/0p4FqRI4k/kWEv4UplmW89Do=;
        b=n2/D6eAR+lSB6MEpga79gitK57xzydl3ugosVnjocFQltgrE3YVnNvdR3wyMuvG4vL
         /NbpcdHfa4NZ++BJzxjKCRwCznqWclfmoiYiuXc5aiXffFTuP4R0pUecXvufGxyP3TPa
         +OS4xKS+voIToMwRE/uypfwbKT7OFCV25z4f3RZPSD1crsmRGNtj9swpX3/XgdbKWrLD
         y7rJB/UQgDM7dKaovDY0qgpeeV/Ic3ukYNIwCo4USLZc6cTZ7upHow8LJh2Thc1tf0e9
         z8RLO0Evmyg2MlO56Jkao3ApjDbaVb4wOVcfRey8m4/uDYN563M9az71b1r5mkWqeaIM
         HY0Q==
X-Gm-Message-State: AOAM530Uo9CYav+6WuNBTRPMDjY5cH1jAS5NCyYKv4KYTG6299yzv8aW
        7gt/ujZCunGxIcqdNr+ORY1y9pJZXiUc56phvKs=
X-Google-Smtp-Source: ABdhPJyhQ1+82aLjTb7BFpr7o3kwE6G2zvTonTQdok3RlkBqln0/JyX5we8Ohhgp7rcPeFsV2GcUe0iq61OACHRm/f4=
X-Received: by 2002:a17:907:7388:: with SMTP id er8mr9272325ejc.269.1643431947034;
 Fri, 28 Jan 2022 20:52:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <2f296aeeefbf8340cfb8b7fa4fef5ad49c8b4aa1.1642888562.git.gitgitgadget@gmail.com>
 <CAP8UFD0fRTw0Uh6oWNtCdotRb3F6fvZnpUwm=vT0qzmfeuBvEQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0fRTw0Uh6oWNtCdotRb3F6fvZnpUwm=vT0qzmfeuBvEQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 20:52:15 -0800
Message-ID: <CABPp-BGVCdSoVowgmM17xCiuYLwfGVLvLm=Ue8tPB+q+N3oB6g@mail.gmail.com>
Subject: Re: [PATCH 07/12] merge-tree: support including merge messages in output
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 2:42 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> >  EXIT STATUS
> >  -----------
> > @@ -72,7 +102,8 @@ be used as a part of a series of steps such as
> >
> >  However, it does not quite fit into the same category of low-level
> >  plumbing commands since the possibility of merge conflicts give it a
> > -much higher chance of the command not succeeding.
> > +much higher chance of the command not succeeding (and NEWTREE containing
> > +a bunch of stuff other than just a toplevel tree).
>
> Is this hunk really related to this commit or should it go into a
> previous commit?

It's meant to first be related to this commit, though as you pointed
out below, I had some accidental stuff not cleaned out of the earlier
commit.

> > @@ -440,22 +441,30 @@ static int real_merge(struct merge_tree_options *o,
> >                 commit_list_insert(j->item, &merge_bases);
> >
> >         merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> > -       printf("%s\n", oid_to_hex(&result.tree->object.oid));
> > +
> >         if (result.clean < 0)
> >                 die(_("failure to merge"));
>
> So this addresses the comment I made in a previous commit related to
> the fact that if result.clean < 0 we might not have a valid tree that
> we can print. I think though that it would be better if that was
> addressed in a previous commit.
>
> > -       else if (!result.clean)
> > -               printf(_("Conflicts!\n"));
>
> Ok, so we don't print "Conflicts!\n" now, which makes me wonder if we
> should have printed it in the first place in previous commits.

Yep, good flag on both of these last two comments.  When I was fixing
this up I didn't squash it back in early enough.  Thanks for reading
carefully.

> >         if (o.real && o.trivial)
> >                 die(_("--write-tree and --trivial-merge are incompatible"));
> > +       if (!o.real && original_argc < argc)
> > +               die(_("--write-tree must be specified if any other options are"));
>
> Is this necessary? It looks to me like another thing that would be
> simplified if we were just adding a new command...

I think the code is harder to read than it should be.  I changed it to:

    if (o.mode == 't' && original_argc < argc)
        die(_("--trivial-merge is incompatible with all other options"));

which I think is clearer; it points out that it's only about the
deprecated --trivial-merge option and how it's incompatible with all
other options.
