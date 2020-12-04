Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B0BC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BBD22CAD
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLDSle (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDSle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 13:41:34 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF99C061A53
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 10:40:48 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id p126so7216251oif.7
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 10:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1luGk0oaio4DKOAaIz0n5Lk7sK4d9WoWe3pNAvF20ic=;
        b=sm/vaXwu3jflod3/14gU6W1QGtDquFfYH1lkaTXPNJLZT8FBPzxfWc/RPwpivv+tj7
         poxP3fK21wrZUe7labec1bom8+IYFsgmHlKgE3IPUCgU1eycKgJ8cXgz4fr/J8zjFSbH
         eLU9o0e7FJa002/N5X2dIZVOz1q1chuU+bV4MyZ+ZXA4hwgTsW+NWoMxF7CiuMHM+PKU
         tRfit4VcBeVTpIP/a7N+6r76asCZwgG5AgEGOLintut5mEgNefuxywkD2AoO0gO8L/ca
         zZx2xdMLLHsn5cdM44njXy5bKxhfOAIfuOXY5nPKp7naL3I3RJ3TgTGIwxXPvSjm1ieI
         WzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1luGk0oaio4DKOAaIz0n5Lk7sK4d9WoWe3pNAvF20ic=;
        b=I19YIQijbtIGD/uBb4KF6s35RCv1XFnXhl3sBB0Dmgbk7kpggw5pldkLiAXnhXK8Ck
         93l32vQ9F3oCN99+0Rg8/uV4c9St67IglVxbkqn6DsLe+QzNqPm+Hlu57y+2L4tH1sC3
         nSP/E9dSkKIGLtTGJmjiLHhzuUlgTe5zJJnnNT/Bh72tneg3tYIZPI8J2YCZLVHcz8jO
         9rfiKTeEuldVct1fZVW5AaqV5gfV/ripiR7XV81PTmrawairvm7igBfo7IJfxqGV1y0Z
         a5CwKuZXZQo+wIsRONeElpRep5v6X+b8F4xolGiW4lpsGh1bkzFcYmOklkuZKAxB+Mnb
         er6w==
X-Gm-Message-State: AOAM531MG9BJlt0PlVyEye4GZKs7XbPkDCoAXzrythL/V7LZv9k5Bw5K
        KqPhhpiqiodsP7uha5Vrnj/kCR7KNRk3w9kNVC1dP0DeTqw=
X-Google-Smtp-Source: ABdhPJxo3v3LTBY0wpl6IBb7LdF72OGRji34//kKhpGN94U+YT8hzG1J6VVYVb11Dr03Ww5i0UcqN4qdLEEtQJh/SBU=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr4101929oia.167.1607107247670;
 Fri, 04 Dec 2020 10:40:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.803.git.1607011187.gitgitgadget@gmail.com> <2ea0aab8-934f-3eaa-e3d0-9ae35a278748@gmail.com>
In-Reply-To: <2ea0aab8-934f-3eaa-e3d0-9ae35a278748@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 10:40:36 -0800
Message-ID: <CABPp-BGrNS2Rcue9JZBC=BFyedPP8JnPyJn_P8eT2itOEds36A@mail.gmail.com>
Subject: Re: [PATCH 0/7] merge-ort: some groundwork for further implementation
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 9:26 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/3/2020 10:59 AM, Elijah Newren via GitGitGadget wrote:
> > This series is based on en/merge-ort-impl. This series sets up three future
> > patch series (to add recursive merges, three-way content merging, and rename
> > detection) for the merge-ort implementation, and allows the future series to
> > be submitted, reviewed, and merged in any order. Since those three things
> > actually do have some minor dependencies between them, this preparatory
> > series is needed to make a few small changes to set things up to allow them
> > to be submitted independently.
> >
> > The first six patches are trivial. They should be easy to review, and as a
> > bonus you get to find how I mess up even the trivial stuff. ;-) The final
> > patch is more substantive and represents one of the big changes between
> > merge-recursive and merge-ort -- namely, how notice/warning/conflict
> > messages are reported to the user (I possibly should have included it in
> > merge-ort-impl, but that series seemed so long already...).
> >
> > Elijah Newren (7):
> >   merge-ort: add a few includes
> >   merge-ort: add a clear_internal_opts helper
> >   merge-ort: add a path_conflict field to merge_options_internal
> >   merge-ort: add a paths_to_free field to merge_options_internal
> >   merge-ort: add function grouping comments
> >   merge-ort: add die-not-implemented stub handle_content_merge()
> >     function
> >   merge-ort: add modify/delete handling and delayed output processing
>
> Coming back to say that I finished reading PATCH 7 and this series
> looks good overall. Tough to be confident in it when the implementation
> isn't connected to tests, but the patches do a good job of describing
> the isolated changes. If there _are_ problems, it will be easy to
> identify the reasoning behind the code using log/blame.

Doh, I should have mentioned that this series drops the number of
failures in the testsuite when run under GIT_TEST_MERGE_ALGORITHM=ort
from 1453 to 1448.  (Due to the final patch adding handling for
modify/delete conflicts.)  It feels almost like an oversight since the
number only dropped by 5 and the focus was on setting up the next
three series which will drop it much more.  The next three, which I'm
planning to submit soon, will collectively drop the number of failures
by 1388 down to just 60.

Anyway, thanks for looking it over!
