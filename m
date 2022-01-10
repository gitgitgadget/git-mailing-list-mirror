Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C0BC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 20:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbiAJUDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 15:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243444AbiAJUDU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 15:03:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15552C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 12:03:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m4so16703834edb.10
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 12:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UoRwy2QFx/NUyV7xjeb7AM0ZcdL5MFhppD7dYHlbjs=;
        b=NiuxH13P2YO0v3A5uhziu6RLTICM50bUYYzuWFzHXAU5PimCIPALGxeWVi1GnX4cFX
         cyj5kPlPDaLvHYvHCOc50FnFFL4+T0OMb5+dXN+eXFEjSQBbVfFzsyak51iQg/ixdfQw
         2mcj88mayOP2ruaq6XJj/HAxcgYE7wnDqjWnDYvaE9BxnG9NPmGlkOAJ76NdpXxzx1e/
         ZSNjxerL1k/5siGMgtA9D563uWXH2usgKketyiEuN6zHHoly+ZMIxwjG1osOBg7/2w/k
         VHMfA9fkXiwYdDu/+JXsoY/wN4su5PoQfidPkl+/2zGPmUFZjfHuB42pmBXyX+/FaNQ0
         2nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UoRwy2QFx/NUyV7xjeb7AM0ZcdL5MFhppD7dYHlbjs=;
        b=TKsA1ABrEvDaM0KR+jlQnQAoZfRMX4C/+mwMXxdnLNozujFE6XI39R9tlZmVVxEYeo
         BcxQ98SL20WhvUKSakg4qj4v9piWpqSwZPtgxAoY6/VBVMCp4t0cHcIVYVspKE70lSC0
         XzeMmDrYOrvLznwH1aXwZaL8OSkWIy94XsSWT/8MV1guqd7BNtDp4TqHNGpKYFqPEw1L
         kUcOJjlb1zaoPsNMgqQEtE3z10V2SVqrNOfXi9yeGqXFrTarhl+QP73R9UR87uK4qhbj
         WKYAw2JHADIKNA6VyC7Zkg4fbPaEn7nQh7MKlogM3Bfzf4t5tpDWJ/PTk//XzbPnyDAB
         Ry4Q==
X-Gm-Message-State: AOAM532lSCRfJgAQMFXc5EkDbib9Go9zcVqPEnK6YwNsDz73lWvi3Okk
        dAl4fFslNG+wM3ggxRG0jhqpK2hd+Ol1JFEPdwB1fRdnRdk=
X-Google-Smtp-Source: ABdhPJz+NSWczFFttIHmyyE59CG52secEC9a7ByGzbUQToHjj/Jij8/6+R7kBTnUiWiAfNihgU50FBw1UbP/GBrBBHU=
X-Received: by 2002:a05:6402:5202:: with SMTP id s2mr1259513edd.206.1641844998546;
 Mon, 10 Jan 2022 12:03:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
 <3b734f89c0f2f473d71a5d3c85faec6d48a0e350.1641317820.git.gitgitgadget@gmail.com>
 <CABPp-BHadoOToWb6Kp7rUj03ZzKhzK_aFJymT_zApEw8st2ttA@mail.gmail.com>
 <159a35ba-7ed0-c601-15bd-54dfda460323@github.com> <CABPp-BEXYZxThegY9WvudY0B7KJ1HQm--Kwe5zxQOxvzHMHN1A@mail.gmail.com>
 <bec659b2-8d69-c69c-73e5-a56ae415874b@github.com>
In-Reply-To: <bec659b2-8d69-c69c-73e5-a56ae415874b@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Jan 2022 12:03:07 -0800
Message-ID: <CABPp-BEgOi-UqH9bP0_OU6G7wCaE7g1GJN-RU5oaWPvwUW+imA@mail.gmail.com>
Subject: Re: [PATCH 7/9] update-index: add tests for sparse-checkout compatibility
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 10:01 AM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > On Mon, Jan 10, 2022 at 7:47 AM Victoria Dye <vdye@github.com> wrote:
> >>
> >> Elijah Newren wrote:
> >>> On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
> >>>>
> >>>> From: Victoria Dye <vdye@github.com>
> >>>>
...
>
> Sorry about that - when I wrote the first version of this series in the
> `microsoft/git` fork, `git add` hadn't been updated to reject out-of-cone
> untracked files as it is in [1]. It's my mistake for not double-checking
> that it was still the case, apologies for wasting your time on re-explaining
> this.

No worries; there's lots of moving parts in the sparse world.

> In any case, I'll update the test comment and commit message per your
> suggestion:
>
> >>> I might buy that `git update-index` is lower level and should be
> >>> considered the same as `git add --sparse`, but the comment should
> >>> mention that and try to sell why update-index should be equivalent to
> >>> that instead of to `git add`.
>
> I'm leaning only slightly towards the current behavior (and will update the
> comment accordingly), but I'm happy to change it if the reasoning isn't as
> strong as that of another approach.
>
> [1] 105e8b014b (add: fail when adding an untracked sparse file, 2021-09-24)

I'm also leaning slightly towards keeping the current behavior and
just updating the comment.

...
> >> I understand why you find it buggy, but I am not making baseless assumptions
> >> about the correctness (or lack thereof) of the current behavior.
> >
> > To be clear, the fact that the behavior was there for a decade would
> > typically be basis enough for an assumption (in my opinion), and I
> > wouldn't have faulted folks for making it.  I might well have done so
> > myself.  My reasoning was just that I was getting confused by the
> > negations and trying to understand the testcase, and when I started to
> > unravel it, I found what looked like a possible inconsistency.
> >
> > Anyway, it's clear here you've actually dug a lot deeper and know the
> > history here.  In contrast, I was making assumptions about the history
> > (and ones that weren't correct, though I'd argue my assumptions
> > weren't baseless)...
> >
>
> Your assumptions were completely valid, I apologize if my response came off
> as implying otherwise. I'll try to use the comments on the tests to clarify
> their behavior as much as possible, hopefully reducing some confusion around
> all the multiple-negative flags & options.

Oh, no, not at all.  I was just worried that my earlier response might
have come across poorly and could be read as criticizing assumptions I
(incorrectly) _thought_ you were making.  I wasn't sure if that was
actually implied in your wording, but just to be careful I was just
trying to specify that I think the level of effort of your submissions
is totally appropriate -- even if you had been making the assumptions
I thought you had been.  And I was pointing out that I, after all, had
made and will continue to make assumptions too.  The point of review
is getting a second pair of eyes, because they can help catch issues;
and finding those issues often includes double-checking unspoken
assumptions.

Anyway, I think we're on the same page.  Thanks for your hard work
here; looking forward to seeing your reroll!
