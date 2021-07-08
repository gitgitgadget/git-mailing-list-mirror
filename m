Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93117C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 23:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9DF61452
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 23:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGHXyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 19:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGHXyu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 19:54:50 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546ECC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 16:52:07 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i5-20020a9d68c50000b02904b41fa91c97so3240166oto.5
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 16:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/dm4EZ9Xh29gBR/+uN0Getjrt8/p1pGhDdOWZ7KgHQ=;
        b=ZwZr1vMhN9K6j98a1h0lzxoukJKdp9oRqPsLA1CFWB/bMZtxrGr+Tptwol4bnaKFJP
         Hywjj/Ss//+zjRee+fNKsZQgdpM8qdsMm6k4hA01lZ6MeGoJgKv0SI3eepQU6gyv31MV
         GftQ/HxIgcbr+me9hUOL6pPWX2zK9a93K3HxSl21B5w/MovR164bRmXNOwqG6W2+MNQU
         NqOCpKoEjHjiiy+KTc+BYrr3c1FOycfVdIKqPsUOsL+IHP5BhIX3y3u1EOCxmrT+fHX5
         Q4SmyjhpiTbBxL+5mUljcvuUKpBP0bmFyLeyb3R5hn6I6Dz6/ZP+wFXxGsgLczEzUyEZ
         v4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/dm4EZ9Xh29gBR/+uN0Getjrt8/p1pGhDdOWZ7KgHQ=;
        b=pQlzJTL0phNCuFepG17NsBNswggR1mO+qIzPkHVU5htAUeGMnb/cL6f6AzcRwRfGCu
         GZ66ZYYDt886iT4p5K5pRa6Ety5dxEauS2xpRpwsxQlvfJKa7eSjItppQCdrT6yol7mL
         UabLq6xEAykzkEkYkUSMNTkSVTy4MDkK7AeJ/IDs1dwMGcW6M78UBLajq84GKhqMO36x
         Z43oo/W7vvPMzhYccxPRErjD7XAHi9CW3fZ8TdUtx0mZAoWNkXp6xVUzfLYED5z+6uNT
         poaA5lfOE00gFi/5cFT8IMnQiZQNzw+SebXgqkx83/IuwCQOBfPEJ5c4aR9wWutiHZzQ
         hDxg==
X-Gm-Message-State: AOAM530iOS7NONHx42O8uImZFW9jA9Czz0RycrGwXmwUB+HoIEvPn2FI
        uLCzJOMcL/+yyT/VO8UaOXzeJsZ8k+++QGm6ewU=
X-Google-Smtp-Source: ABdhPJwr9v4y4CIkLUEKCtUBmrQAqERJyqYRep4zuEG9XqgRhV3kxGc0UHv17qf8ueTTKMP+akcT3Z5/JRwAuGk1Wtg=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr26062113otn.345.1625788326584;
 Thu, 08 Jul 2021 16:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com> <f83aa08ff6b0fd18d6f9f3ce5ee993523a7f1759.1624932294.git.gitgitgadget@gmail.com>
 <CABPp-BFaWxuBTgztpmso9zCOz3AC62HQuAi5XVAEwsfevYv8gw@mail.gmail.com>
In-Reply-To: <CABPp-BFaWxuBTgztpmso9zCOz3AC62HQuAi5XVAEwsfevYv8gw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Jul 2021 16:51:55 -0700
Message-ID: <CABPp-BHnjB5H4cJ_mx=3PNVss0Z+d-aEE5Hw4AcuLTC0PC+3qg@mail.gmail.com>
Subject: Re: [PATCH v7 12/16] diff-lib: handle index diffs with sparse dirs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 8, 2021 at 4:10 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > While comparing an index to a tree, we may see a sparse directory entry.
> > In this case, we should compare that portion of the tree to the tree
> > represented by that entry. This could include a new tree which needs to
> > be expanded to a full list of added files. It could also include an
> > existing tree, in which case all of the changes inside are important to
> > describe, including the modifications, additions, and deletions. Note
> > that the case where the tree has a path and the index does not remains
> > identical to before: the lack of a cache entry is the same with a sparse
> > index.
> >
> > Use diff_tree_oid() appropriately to compute the diff.
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  diff-lib.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/diff-lib.c b/diff-lib.c
> > index c2ac9250fe9..3f32f038371 100644
> > --- a/diff-lib.c
> > +++ b/diff-lib.c
> > @@ -325,6 +325,11 @@ static void show_new_file(struct rev_info *revs,
> >         unsigned dirty_submodule = 0;
> >         struct index_state *istate = revs->diffopt.repo->index;
> >
> > +       if (new_file && S_ISSPARSEDIR(new_file->ce_mode)) {
> > +               diff_tree_oid(NULL, &new_file->oid, new_file->name, &revs->diffopt);
> > +               return;
> > +       }
> > +
> >         /*
> >          * New file in the index: it might actually be different in
> >          * the working tree.
> > @@ -347,6 +352,17 @@ static int show_modified(struct rev_info *revs,
> >         unsigned dirty_submodule = 0;
> >         struct index_state *istate = revs->diffopt.repo->index;
> >
> > +       /*
> > +        * If both are sparse directory entries, then expand the
> > +        * modifications to the file level.
> > +        */
> > +       if (old_entry && new_entry &&
> > +           S_ISSPARSEDIR(old_entry->ce_mode) &&
> > +           S_ISSPARSEDIR(new_entry->ce_mode)) {
> > +               diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
> > +               return 0;
> > +       }
> > +
> >         if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
> >                           &dirty_submodule, &revs->diffopt) < 0) {
> >                 if (report_missing)
>
> Love the simpler patch.
>
> I'm curious about the case where S_ISSPARSEDIR(old_entry->ce_mode) !=
> S_ISSPARSEDIR(new_entry->ce_mode), though; how is that handled?

Digging a little deeper, it appears that we could add this just before
your new if-block:

    assert(S_ISSPARSEDIR(old_entry->ce_mode) ==
           S_ISSPARSEDIR(new_entry->ce_mode));

And the code still functions, while that also removes some of the
surprise factor.  I'm guessing that the difference between "folder1"
and "folder1/" cause us to never try to directly compare a file to a
directory...but if that's accurate, a comment of some effect might
help make this code be a little clearer and make readers less likely
to wonder why you need to check that both old and new are sparse
directories.
