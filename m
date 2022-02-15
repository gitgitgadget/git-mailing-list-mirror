Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A973C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 04:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiBOESC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 23:18:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBOESB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 23:18:01 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C8C9A32
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 20:17:52 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p14so17326401ejf.11
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 20:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zk7ZHXSe6perQJI8IOUMXH12j7eX5L6eVJ4RJzV2/ks=;
        b=NcdqQqzOVNyge1iQ8JqOCVWPsb94mWtGbOrwMlvZ7v21EhZ/B9qXEf2l0r4vSY6NME
         5UA7rUELN1pHUQHmcHKYBtzCFv4dkmMGt1nxt0KWsGqc2iXSA9qehRdXJz6wB74CqmpT
         FB76kIMvN9lZ7f67KzsWf+Xv+LzZsUumVI8x0/24aBVTwdnudPyyAEYhPV/+Te13rFgs
         gUcxae0Ev40scE9Ql1NDtZ7XSirdQ6mWBbo0JE27GbcRgM7b7onKyHK9FHGiSMC9CLbv
         pWnOsozYHxXyf/aRacwD3aZ02Wm0G0bJxZyuHjDeWuJC+Mm9pMJORBC6NCsF1F06w+cl
         6hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zk7ZHXSe6perQJI8IOUMXH12j7eX5L6eVJ4RJzV2/ks=;
        b=RhOjyviOOSKKbgcUQcHRdzVeG5lYyeGuwOyjd7SoCSvyKB/mokec3vmKAnaO7xIyxr
         5xqrXKTPO0VPM3fd/EhP+qVkCrN3qz7vKMoDLDZ5UeDHWUmvNCqfJbX1XYXpOxHOdBFj
         BzLqJZkF/YtVsMEBAF2YH8OyvV3Cao087nGykN7qIHFVcoTPvieVsQo39TxVaQoFXtJx
         nAzfoQE8bkCfBafQJmK5OMLYituNM1GCAtZ/CF1UwjNJFhKjRqFTL5lyauHo6a2K0sOD
         F/oNYGKNWg9FDrkc5C9tx+bcQXplXOjYa7QIis4iTszHe7D8QwKks7Y7i4lJHevXZmq3
         3+5w==
X-Gm-Message-State: AOAM530lRSQbdkPjMFxQW8v/9oTLt4JXa0y7ZHs7kuJ6p6psUKFkr49f
        3mSzqYXI9o5yyZMUDhzjUBwhR8TyqMWY0+fowSY=
X-Google-Smtp-Source: ABdhPJzZ87EAgF+KjMeobhymuTwgb/WBq3Gh0ZBDUka7kUVp1m35urf77io8nHW1J+hVofHrYThp0dPju77Xk77eQHI=
X-Received: by 2002:a17:907:7f94:: with SMTP id qk20mr1549653ejc.328.1644898670648;
 Mon, 14 Feb 2022 20:17:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <5e27cad17a7080170f476684610391bd56024f36.1644712798.git.gitgitgadget@gmail.com>
 <72d39c4a-fd16-846c-2a5e-8b9ba0c1ab07@github.com>
In-Reply-To: <72d39c4a-fd16-846c-2a5e-8b9ba0c1ab07@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Feb 2022 20:17:39 -0800
Message-ID: <CABPp-BE8aG3R4ASngqwyvRemp5WW=O0UWWSTesJ2hoch_av_kQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] sparse-checkout: error or warn when given individual files
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 7:56 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > The set and add subcommands accept multiple positional arguments.
> > The meaning of these arguments differs slightly in the two modes:
> >
> > Cone mode only accepts directories.  If given a file, it would
> > previously treat it as a directory, causing not just the file itself to
> > be included but all sibling files as well -- likely against users'
> > expectations.  Throw an error if the specified path is a file in the
> > index.  Provide a --skip-checks argument to allow users to override
> > (e.g. for the case when the given path IS a directory on another
> > branch).
>
> I agree that this is likely to be an improvement for users. The
> sparse-checkout builtin isn't integrated with the sparse index
> yet. At least not integrated upstream: we have commits in microsoft/git
> that we plan to send when other things in flight are merged. This
> change likely introduces a new opportunity for the index to expand,
> so I will keep that in mind when upstreaming.

Actually, I thought about that during development, and my presumption
was that we would not expand the index.  We've survived a few years
without reporting any argument errors to the user and folks seem to
usually get things right, so while I think it adds value to report on
likely errors, I don't think it's important for us to catch and warn
on every potential misuse.  I think the probable errors are the ones
where they specify a <file> that exists in both the working tree and
index.  The remaining ones are less probable, and also possibly quite
expensive to catch.  I'm not sure it's worth the cost to try to report
those.

> > Non-cone mode accepts general gitignore patterns.  However, it has an
> > O(N*M) performance baked into its design, where all N index files must
> > be matched against all M sparse-checkout patterns with EVERY call to
> > unpack_trees() that updates the working tree.  As such, it is important
> > to keep the number of patterns small, and thus we should warn users to
> > prefer passing directories and more generic glob patterns to get the
> > paths they want instead of listing each individual file.  (The
> > --skip-checks argument can also be used to bypass this warning.)  Also,
> > even when users do want to specify individual files, they will often
> > want to do so by providing a leading '/' (to avoid selecting the same
> > filename in all subdirectories), in which case this error message would
> > never trigger anyway.
>
> I think the case of "I want only one file from this directory" and "I
> want files with the given name pattern" are the main reason to still
> use non-cone-mode. Users with this need usually have a directory full
> of large files, and they choose which of those large files they need
> using sparse-checkout. The repository reorganization required to use
> cone mode for this use is perhaps too great (or they haven't thought
> about doing it). For this reason, I would prefer that we do not do
> these checks when not in cone mode.

If they "only want one file from this directory", isn't the correct
way to specify that by mentioning the path with a leading slash?
Otherwise, they'd potentially grab files with similar names from many
directories, right?  So, even in that usecase, we should still error
out if they specify a <filename> rather than /<filename>.  Perhaps my
reasoning should lead with that and I should fix up the warning
message a bit, but I still think we should probably give a warning
even for those who are explicitly wanting the usecase you mention.

Also, note this is a warning and not an error -- and the warning can
be suppressed with --skip-checks.

> > +test_expect_success 'by default, cone mode will error out when passed files' '
> > +     git -C repo sparse-checkout reapply --cone &&
> > +     test_must_fail git -C repo sparse-checkout add .gitignore 2>error &&
> > +
> > +     grep ".gitignore.*is not a directory" error
> > +'
> > +
> > +test_expect_success 'by default, non-cone mode will warn on individual files' '
> > +     git -C repo sparse-checkout reapply --no-cone &&
> > +     git -C repo sparse-checkout add .gitignore 2>warning &&
> > +
> > +     grep "passing directories or less specific patterns is recommended" warning
> > +'
>
> So I would expect this second test to have
>
>         test_must_be_empty warning
>
> to show that no warning occurs when specifying a file in non-cone-mode.

or perhaps

grep "please specify a leading slash to select a single file" warning

?
