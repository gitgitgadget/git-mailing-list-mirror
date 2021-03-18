Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED04C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 06:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7EE64F04
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 06:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCRGcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 02:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhCRGck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 02:32:40 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B6C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 23:32:39 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so1177831oot.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 23:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+Kp1FMlVWxmm3t5nvz7JQT9yoADkbMl2noHa+TktJ8=;
        b=nUcYricb/eOAuQD+gFlI7Xpdlhk5/yNnlMKmiCjwzgJlYCAr9PehOXu6H7mTA6eNmv
         TKIFrO6dI5xhcMQnXqzSDPaIX+ksOx1n4beL/vwQpj7qREXY/uI0uLbZrjIy023/3e9K
         gy1rv+ccDuZ7y8l4nmdHaY9fi38wZ+KJQYvIjLL+/FIqkLRfYudfwKY2b9IkjtattaAe
         KQ4APPLDWJmhisOKFnVKLNN/UB2MFk1YTewB9wKiIEWdP4/j9SoxiuPQD39Ix8f07n2n
         cpHSM6lYkVUHaOX1Fqv1rGu1bGYtDY2HU6IyAanPk2Ovi3ZFNoojq38hVxO/BJqRe5zq
         cGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+Kp1FMlVWxmm3t5nvz7JQT9yoADkbMl2noHa+TktJ8=;
        b=r1jAFwG/k++HDS3xjrVyJ2wMie3jJ5uMpfURtGjC5m5ExPhx66HVB9cs/2T0De7g97
         Eido+eOrI4ilD2d3cru6mQl14PKh15Lptlb9nJrGdwLxm44XpQXwc4smJHGTwvsJx3iw
         g5HW+Zr2ODq91V1GQHnMdPiK07mc2iT7lGV3XtGpkbeQP3kyJTZ53FHpJLIb4y8WP2FR
         0kkm/cxf8EMGVsOkoXZEAVWg4efadaDApIq5PD2dtVHk2VrDIisXL2C/YN7k2s2fltyr
         9fJHIzcqBnw4Bb+ITJHtILgcUHLR647EAVWm/fhxcHLtXelIMOYKCFFmMuRG0KND1qii
         +crg==
X-Gm-Message-State: AOAM531BLRuuS+YzNFOU+dwqwl48TZxHAUe/Gyq9ygC6Z1Li1T/Keyyc
        QzTfMB2bnPD/KzK3l25lezQHFUHz13cGtPIDHMs=
X-Google-Smtp-Source: ABdhPJyIlS4FQUWfDAW+T22XpxrMPTbFEJVDn+8+U8J5+Og5nXdqLcRfYAGt+4tmK1i/v2xIwIgWMoMUmGmAz5RWxUk=
X-Received: by 2002:a4a:eb8a:: with SMTP id d10mr6297972ooj.32.1616049159246;
 Wed, 17 Mar 2021 23:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com> <CABPp-BGfkPscpro=W5vcRHD5cV6pddYpvHLLzMWjL9WLaxyu3w@mail.gmail.com>
In-Reply-To: <CABPp-BGfkPscpro=W5vcRHD5cV6pddYpvHLLzMWjL9WLaxyu3w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 23:32:28 -0700
Message-ID: <CABPp-BE4qc1-Y+gdZCxB=o+DEF0F_dH-=-YaGWJfO_T6LC6x2Q@mail.gmail.com>
Subject: Re: [PATCH 00/27] Sparse Index: API protections
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 11:03 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > The point of this series is to insert protections for the consumers of the
> > in-memory index. We mark certain regions of code as needing a full index, so
> > we call ensure_full_index() to expand a sparse index to a full one, if
> > necessary. These protections are inserted file-by-file in every loop over
> > all cache entries. Well, "most" loops, because some are going to be handled
> > in the very next series so I leave them out.
...
> > However, after this series is complete, we now have a straight-forward plan
> > for making commands "sparse aware" one-by-one:
> >
> >  1. Disable settings.command_requires_full_index to allow an in-memory
> >     sparse-index.
> >  2. Run versions of that command under a debugger, breaking on
> >     ensure_full_index().
> >  3. Examine the call stack to determine the context of that expansion, then
> >     implement the proper behavior in those locations.
> >  4. Add tests to ensure we are checking this logic in the presence of sparse
> >     directory entries.
>
...
> If I'm confused about the goals and the plans, then my reviews will
> probably be less than helpful, so I'll suspend reading the series
> until I understand the plan a little better.

Thanks for patiently responding to all my other queries.  I read
through more of the series today.  I inserted comments on a couple
specific patches, but most of patches 6-25 are all along the same
theme.

I have some overall comments on those patches in 6-25 (none of which
need to be addressed in this series, but are meant as hopefully
helpful guides about future work):

add/rm: both of these were just above loops that had a
skip-the-SKIP_WORKTREE entries, at least once Matheus' series is
merged (https://lore.kernel.org/git/cover.1615588108.git.matheus.bernardino@usp.br/).
I think the upshot is just that these become easier to convert.

checkout/commit -- I think these follow the add/rm model and likewise
become easy to convert.

ls-files - I commented elsewhere in this thread about how I think it'd
make sense to have it list the entries in the index, as always.
Obviously, that'd give different output than a full index, because
there are different entries present in the index when using a
sparse-index vs. a full one.

However, all of these, as you say, can wait until later.


I also noted that patches 26 and 27 were based on ones from the RFC
series that I reviewed before, and I noticed you fixed an issue or two
I flagged there, but you also made some other changes and it's too
late at night for my brain to continue thinking and try to compare
them; I may try again tomorrow.

Other than patch 26 which I'm too tired to think through right now,
and the patches I specifically commented on, the rest of the series
looks good to me.
