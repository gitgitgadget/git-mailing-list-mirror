Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88859C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 05:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiBOFMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:12:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiBOFMW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 00:12:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38FB7C43
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 21:12:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w2so11571873edc.8
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 21:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyjbmYyuttkiqgD05ARW4gljvqA7UusjD1QKZCkVZJs=;
        b=ep/LRovFcrknEAy4cfQhEJt4gMYUOr8/R9ud5Z4qwl9rHDVn5jPEzN3KddIYmHkOMm
         hF4T3bBu0tTfmV0mbXs42+U9+Ku6OcgUgkDC1uUpKVJl9vSKC2cxNE7LiRNKiCpa9/YE
         fe2IiSxZ3dq1LxLvKUrp/TMY/GHBiJOH2iaK6xhCnoAoromimL0baIucAGmyY0x1K2dJ
         +AcNjK/D5edjYSXgB/BdWnHdQKjCKZf1prIrHrrKp6QZ9KIrpcoIBgSKCzOgTPTchjiw
         NLuRDVgGZ1mSlTJutpUhLPbWxLCfXRO4UtFFPtpZVXVdO6nYnNeQrcHz3ZDanZCbi6B1
         hkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyjbmYyuttkiqgD05ARW4gljvqA7UusjD1QKZCkVZJs=;
        b=rlbX+WL4ub9+MzQVsV+wpAJX81B+j9ncogR3tv/td3Kfe9UsVPFx0WoJm4DqJGZI/d
         wwA6md1c2vpCpihNFRX7OsBFjzya1/xkzUhIIZ+sBo9myCuCZWdjB5wZzMbVRbHSwKCQ
         Tu406q/d2D+zT3wVi88ZlLJdzzgII3Cl5PPYw52iqNh0r1tRkngY/k7mu4AkODG4/BU6
         pIDFe8+PtXraWcU878fdp/y46jItCXTIFM/kAj1zPRcy/dgc3uw8gRVgpLrDQ3ae6mYg
         La0eiR0F3pY2dLLeWhtLvjHLyVe0qVvoqDtTAqIWuygLRc0n0cVHBDv2Wy2eHOP7ob5Z
         L2aQ==
X-Gm-Message-State: AOAM531wsTMVNyLqSTFR6HfTyBiLg+zDUdn/HGMiM6P47C/+0/5Fhyrl
        CxpFF9+hd7H0OfDylFFqBffLaSWX9zZaj+17Bf4=
X-Google-Smtp-Source: ABdhPJzhkjZmolxIB5an5CDkWNWl56fHPqcJ6g7i5aaoA6AauLiKhMSWGPjlyyAbf2Q+BwaYuLau0Mw9mfxEQYCbyQw=
X-Received: by 2002:a05:6402:3509:: with SMTP id b9mr2156861edd.192.1644901931607;
 Mon, 14 Feb 2022 21:12:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com> <dfda7d2e-940b-bb54-6d2b-cda3a00abc0a@github.com>
In-Reply-To: <dfda7d2e-940b-bb54-6d2b-cda3a00abc0a@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Feb 2022 21:12:00 -0800
Message-ID: <CABPp-BGWRFTcNxbpMkVAqnpGO0iEA=-dAMJ979GfYSSL=t+ZTQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] RFC: sparse checkout: make --cone mode the default,
 and check add/set argument validity
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

On Mon, Feb 14, 2022 at 8:19 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> > Note (reason for RFC): this is RFC primarily because of dependencies (you
> > may not want to pick this up yet, Junio), though there is also a question of
> > whether to split patch 7 into two steps -- one for now and one we take in
> > some future release. In particular, the first step could be to have
> > sparse-checkout error out if neither --no-cone nor --cone are specified and
> > then change the default to be --cone in some future release. I don't think
> > splitting it into two steps is needed given (a) users who are unaware of the
> > change will still get useful error messages telling them that directories
> > are expected due to patches 4-6 of this series, and (b) the huge
> > "EXPERIMENTAL" warning and explicit note about likely behavioral changes in
> > git-sparse-checkout.txt serves as warning about the changes. However, the
> > two step approach is an alternative.
>
> I support this change. This will also require an update to the 'git clone'
> documentation around the '--sparse' option, as I imagine we are going to
> be changing behavior there. (If not, then we should do that as part of the
> deprecation.)

Why would that be needed?  The documentation does not specify anything
about cone vs. non-cone mode, only that the initial working tree will
only have files from the toplevel directory present.  So, the
documentation is correct without any needed changes.

> > Note 2 (dependencies): this depends on en/present-despite-skipped (which
> > depends on vd/sparse-clean-etc) and on
> > ds/sparse-checkout-requires-per-worktree-config, because of otherwise heavy
> > text conflicts in patch 7 to git-sparse-checkout.txt. Given that neither of
> > those have merged to next yet, it may be premature to pick up this series.
>
> Yes, hopefully things will start to settle down a little, especially since
> vd/sparse-clean-etc is due to merge any day now.

Yeah, and en/present-despite-skipped addressed all reviewer comments a
full month ago, so I'd like to believe it's ready to merge down soon
too.

> > This series continues attempts to make sparse-checkouts more user friendly.
> > A quick overview:
> >
> >  * Patches 1-2 fix existing bugs from en/sparse-checkout-set
> >  * Patch 3 fixes sparse-checkout-from-subdirectories-ignores-"prefix" (see
> >    https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/),
> >    at least in cone mode. In non-cone mode it is not clear if patch 3 is a
> >    "fix" or a "break" (see the "NON-CONE PROBLEMS" section of the manual
> >    added in patch 7, and
> >    https://lore.kernel.org/git/e1934710-e228-adc4-d37c-f706883bd27c@gmail.com/
> >    where Stolee suggested it might be incorrect).
> >  * Patches 4-6 check positional arguments to set/add and provide
> >    errors/warnings for very likely mistakes. It also adds a --skip-checks
> >    flag for overridding in case you have a very unusual situation.
>
> I took a close look at these patches and mostly have minor typo fixes. There
> was one behavior issue: I don't think you should warn for file paths in non-
> cone-mode. Being able to select a single file in a directory full of large
> files is one of the main reasons to use non-cone-mode, in my experience.

In which case shouldn't we still show a warning when users specify a
path rather than a pattern, since the former risks selecting more than
one file?  (Adding a leading slash should be recommended for such a
case, right?)

> It might be worth adding some documentation about how to reorganize a repo
> to fit cone mode patterns, but that's not necessary.
>
> >  * Patch 7 makes cone mode the default, and makes large updates to the
> >    documentation both to explain why we changed the default, and to simplify
> >    the documentation since users can just use directories and ignore the
> >    intricacies of gitignore-style patterns and how they relate to sparse
> >    checkouts.
>
> I'm a fan of the end-result of this patch. I responded with some specific
> comments and a suggestion for splitting it into a series of four patches.
>
> Your first 6 patches are likely to be noncontroversial and could merge
> more quickly than the deprecation.

Will do.

> I think it would be good to get the
> full deprecation under full review as soon as possible so we can give the
> community a long window to comment on it.
>
> We can also consider if we need a release or two where this behavior
> change is announced, but not actually done. I'm not sure if that is
> necessary. Making '--no-cone' required might stir up some noise that
> indicate how much of an impact the change would make.

We can discuss this more later, but I think it's worthwhile to
consider what happens even if folks didn't read the BIG warning about
behavioral changes in the git-sparse-checkout.txt manual, and didn't
know about the default change, and tried to use it anyway.  If they
specify something other than a directory, then they'd get an error
message due to the first six patches of this series -- at which point
they can look to the manual and decide to add --no-cone to their
command.  In other words, it basically does the same thing that we'd
do if we decided to have an interim period with an error when neither
--cone or --no-cone were specified, other than the error message
perhaps being slightly different.  What if the user does specify
directories and doesn't know about the default mode change?  Well,
that's where the two modes overlap and things work fine (with only
minor differences in behavior, such as better performance, and files
from leading directories being included), so the user would be able to
continue with their work.  So, I'm not sure that an interim period
where we error out when neither --cone or --no-cone are specified is
going to buy us much of anything.  And besides, we do have that super
big scary warning in the manual.  Anyway, I'll bring this all up again
when I resubmit the final patch broken up into a separate series.
