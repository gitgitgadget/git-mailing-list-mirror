Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CC2C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8E8613F6
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhGOQbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhGOQbt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:31:49 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C7DC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:28:55 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id l26so7290467oic.7
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tiN8okjzFET7ilqnMLCdBW77g7+8VrO85qNVRf14C7U=;
        b=T9r13DZbipQ4XNbBmGAcaW0esOWnSmwcXiAyzhbKThZTR8CFkrIiQhlZuD6Pne1jlV
         bxB39qHyKCKwirDFFTEPgw/uv9HngWzEn1RuzfHqS2KX5x87ix7K9Cs16Aq8G9uruIa7
         qCGJUUoKcNqnjy6Nl5bYxT4O3Sun6cPqm+KlGX6+ncgWbbh0gDuXKd0PtaxIUBKK++o+
         OgW5Aewz4IJpkAj9h+3uxk2HnvWF1jMCPWRwB5H5L7nOrhTjN69t75QzV4WKZ1yjMKZx
         YLkNNJ1YeOgW0sKQ3iFjJO4aCbVB6ucZw0m1VNxeumOEKP9f4TS/VEY3bAIZ3TVwDLIn
         qX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tiN8okjzFET7ilqnMLCdBW77g7+8VrO85qNVRf14C7U=;
        b=EHl/G+pSMwzTANzreTmEFsjlc1g2dJUGWSD7pRaYW5kJJPn6KwwAyIhU/IdbEZQKj8
         54lUFYTU85pT/a+Ylg6PA6AfETLCVvggI3Gc09ph0Cy/A5CEO+zxoeebrCOo5zpzrkEz
         Y2XestvIpqWqBkI983B225pRNdxzqWTqPeYwDMjr6uQ4P4HMndniM+jsRCUpz1jUn5+L
         529dXj5Da0F6SNnqelhI2AzW+93ht8Y5l+UmjnU3l/giPY1/scBfj+jXm4sa4thcpsVI
         e1oX4BIc5BJgMxB+9ko+FiJNrq6IArkEBGnv+KebrBdVwbMoCEj3jRvcrB3QnHguTF1Y
         7KIg==
X-Gm-Message-State: AOAM532Z/9LfU3yOEp+hmaLHjMmdcr3D1HQwF5Y/SIu1XtJZJ4Su9+AV
        HlxcKa8w5/WhBKpgYJDlg9fHZsVHudKn7MyVddY=
X-Google-Smtp-Source: ABdhPJxo1AfYQi7ZL0vNce9K/AorwxnPgW4HhO+/rRP7XQ5+GoGSBmnfO5l6dMdqEmChbJPyHJNM8ZATocuV9o/yzZQ=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr8565356oie.167.1626366534843;
 Thu, 15 Jul 2021 09:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com> <3409a6cd631deb361d3ecb94491c0c297c52fb53.1626204784.git.gitgitgadget@gmail.com>
 <24c5ef26-f5d3-fb0e-b2da-24cdac90450d@gmail.com>
In-Reply-To: <24c5ef26-f5d3-fb0e-b2da-24cdac90450d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 09:28:43 -0700
Message-ID: <CABPp-BHk6=WR-T-tFJ8v_xpqp0emW8Z29VkCkxePfR_tuUcBJw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] merge-ort: avoid recursing into directories when
 we don't need to
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 7:55 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> ...
> > For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> > performance work; instrument with trace2_region_* calls", 2020-10-28),
> > this change improves the performance as follows:
> >
> >                             Before                  After
> >     no-renames:        5.235 s =C2=B1  0.042 s   205.1  ms =C2=B1  3.8 =
 ms
>
> Wow! This is quite the savings, and reinforces that when no renames
> exist we are likely to hit this optimization.

Just to clarify, "no-renames" was an unfortunate misnomer.  I should
have called it "few-renames".

But yeah, I was pretty amazed a year ago (when I initially implemented
this optimization) seeing the speedups on this testcase -- a testcase
that I hadn't even been paying much attention to beyond trying to
avoid regressing it.

> >     mega-renames:      9.419 s =C2=B1  0.107 s     1.564 s =C2=B1  0.01=
0 s
>
> I'm surprised that this one works so well, too. Clearly, there must
> be a lot of directories that can be skipped despite many renames
> existing.

One small reason it works is that some of the commits don't touch any
paths involved in the big directory rename.  That means that for those
commits, all the renames under that big directory are irrelevant.
This fact makes the optimization work for 4 of the 35 patches.  (Of
course, I did pick that particular series of commits for rebasing
because it touched the directory being renamed a lot, including adding
files to it, which made it a better stress test case for my
optimizations.  But that does make it less likely for the
irrelevant-renames criteria to help us out on this particular
optimization.)

The bigger reason this optimization works so well on this testcase, is
the mere fact that this rebase involved a sequence of 35 commits.  The
optimization doesn't work for the first commit (as noted by the
just-one-mega testcase below).  However, once the first commit is
picked, renames on the upstream side that were relevant in the first
commit are cached, so the optimization does trigger for many of the
subsequent commits.  And whenever the optimization doesn't work on a
subsequent commit -- which happens because the new commit modifies
different files that make other renames become relevant -- then after
detecting the new renames those also get cached.  More cached renames
means a higher likelihood that we can skip recursing into directories
when rebasing subsequent commits.

> >     just-one-mega:   480.1  ms =C2=B1  3.9  ms   479.5  ms =C2=B1  3.9 =
 ms
>
> And no overhead added to this case. Good.
>
> > +             /* Loop over the set of paths we need to know rename info=
 for */
> > +             strset_for_each_entry(&renames->relevant_sources[side],
> > +                                   &iter, entry) {
> > +                     char *rename_target, *dir, *dir_marker;
> > +                     struct strmap_entry *e;
> > +
> > +                     /*
> > +                      * if we don't know delete/rename info for this p=
ath,
> > +                      * then we need to recurse into all trees to get =
all
> > +                      * adds to make sure we have it.
> > +                      */
>
> super-nit: s/if/If/

Will fix.

> Otherwise, I can't speak to the code being 100% correct because
> this area is so dense. I find the code to be well organized,
> which will help finding and fixing any potential bugs that might
> show up in strange corner cases later.
>
> Thanks,
> -Stolee
