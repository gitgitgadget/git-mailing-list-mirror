Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B4BC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiF3VJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbiF3VJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:09:10 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12C31E3F0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:09:09 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-101b4f9e825so941144fac.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ov9hHVOnFqU/5q/vBBI6uEyoSnpvWOBVtceVf9StQU=;
        b=PVGl4TEs2ofbGDzQ63pnEKoe46ZMA2DkJtxfxgUvnUolaNKQGhyvaRy4I6wxb3+jTi
         pxJE+i/r3IvLqOGAY1AKG0FSZfyaqtVvQsXJe2yLoiS7V0/FQ4lVsJ9Sz7FyoBW5f7cy
         xdBxx+IaCPNEBvxw+kDCwlw6QG0oE2+CherGxjBR6meThddfpkyddjBsmGPHX2d6xq3z
         Nh64nCFyY45bZz16vUtcRXRk3jhmaQRIkmNKns8zpE7SDcwkJs97Ll+kkik2VPuPWLtW
         XVZbElyIWy0D6Wtoj7PhBGz4Bn2Jr9HY1zPsB8/+ivGx/Tb7gdHEAQKxBs84ESHSU+4k
         0uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ov9hHVOnFqU/5q/vBBI6uEyoSnpvWOBVtceVf9StQU=;
        b=6SqMOmNDvusEUZgzPxNShhy3H4aayJyWOv1Gn/6Oz2Zl3IyeqR9z2DJ9H6H7nZOtOX
         /zBQ/R/QmCca3DXZAnOvaNiVvZO5ntuYdY4PyAIi8cJWPhjon0XuYWdKSD9baWlDlc9z
         Rw/Gcl4M8vcqQRSRcjPagDUYaNxUuPK/r6PM9oxqDUfeUzM8L3gPAe2Ov1OW9nPmeOME
         f3DVdAnJdvZ3E/rniEhe5FhjykW3I3Gc3WQeaOYRrKQrGjZXy9aWWcWxv+uDkpNyVyFT
         2al8CkoxVgXJLGQ99SddBjLQpbyBU0nOTDIPoNYa+Ar4ID41vFAqd/m5dK+lnSC6GBts
         rpqA==
X-Gm-Message-State: AJIora9t+uDutb2xnc9qNjSJrHuh7nLImidqOtlgXPrB4o771oS10C71
        w4M3/dPMrUJ9A3bULw8DNM9GHqcZ6VdT5rdo6e35Aw==
X-Google-Smtp-Source: AGRyM1u6dL350PyAddt9F0WYlMV9eSGAjccOBD0zcgUjfivgIwID8Kf4rU8fYwnH+Tzdx/QDv10GEJbNSPxGZLS3Bhg=
X-Received: by 2002:a05:6870:d207:b0:101:d867:5092 with SMTP id
 g7-20020a056870d20700b00101d8675092mr6568245oac.236.1656623348916; Thu, 30
 Jun 2022 14:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220629224059.1016645-1-calvinwan@google.com> <kl6l35flubx8.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l35flubx8.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 30 Jun 2022 14:08:57 -0700
Message-ID: <CAFySSZDOC8a8q+P3hTAMmO4TCi8Aj61432CsAhgh+pKBv=owyg@mail.gmail.com>
Subject: Re: [PATCH v3] submodule merge: update conflict error message
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        levraiphilippeblain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I notice that this is all above the "---", i.e. this becomes part of the
> commit message when "git am"-ed. Intentional?

Good catch. Not intentional at all.

On Thu, Jun 30, 2022 at 1:35 PM Glen Choo <chooglen@google.com> wrote:
>
> Hi! I have a suggestion for the output text; I haven't looked closely at
> the code changes.
>
> Calvin Wan <calvinwan@google.com> writes:
>
> >  Changes since v2:
> >  [...]
> >  Changes since v1:
> >  [...]
>
> I notice that this is all above the "---", i.e. this becomes part of the
> commit message when "git am"-ed. Intentional?
>
> > If git detects a possible merge resolution, the following is printed:
> >
> > --------
> >
> > Failed to merge submodule sub, but a possible merge resolution exists:
> >     <commit> Merge branch '<branch1>' into <branch2>
> >
> >
> > If this is correct simply add it to the index for example
> > by using:
> >
> >   git update-index --cacheinfo 160000 <commit> "<submodule>"
> >
> > which will accept this suggestion.
> >
> > CONFLICT (submodule): Merge conflict in <submodule>
> > Recursive merging with submodules is currently not supported.
> > To manually complete the merge:
> >  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>
> >  - come back to superproject, and `git add <submodule>` to record the above merge
> >  - resolve any other conflicts in the superproject
> >  - commit the resulting index in the superproject
> > Automatic merge failed; fix conflicts and then commit the result.
> >
> > --------
>
> I'm hesitant to recommend a plumbing command like "git update-index" to
> the user, especially if the user is one who needs help resolving a
> submodule merge conflict. I also believe this would be the first time we
> recommend "git update-index".
>
> To do this using only porcelain commands, maybe:
>
>    git -C <submodule> checkout <commit> &&
>    git add <submodule>
>
> (Though this might need to be broken up into two commands because I'm
> not sure if we ever include "&&" in a help message. I'm guessing we
> don't for portability reasons?)
>
> > If git detects multiple possible merge resolutions, the following is printed:
> >
> > --------
> >
> > Failed to merge submodule sub, but multiple possible merges exist:
> >     <commit> Merge branch '<branch1>' into <branch2>
> >     <commit> Merge branch '<branch1>' into <branch3>
> >
> > CONFLICT (submodule): Merge conflict in <submodule>
> > Recursive merging with submodules is currently not supported.
> > To manually complete the merge:
> >  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>
> >  - come back to superproject, and `git add <submodule>` to record the above merge
> >  - resolve any other conflicts in the superproject
> >  - commit the resulting index in the superproject
> > Automatic merge failed; fix conflicts and then commit the result.
> >
> > -------
>
> For consistency, perhaps include the "here's how to use the suggestion"
> instructions here as well?
