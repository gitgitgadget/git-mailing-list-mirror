Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B3EC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C1964E3E
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBRDIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBRDIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:08:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DA0C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:07:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id z11so2314853lfb.9
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byHoc+sozUvnf5N3D1WACAuN2lqHzez/Xjmbf6/mYDo=;
        b=pvXn+DdincPr7iQW3mUVtjmNLifXxQEkBact1yNtIP5DZzpVc9Bw5t2T05+OSLLAdP
         8MdjFbGHH2W19pzmiB0OF32rk/22AGdz9TvhnlofHHVZbEu0yIf9bfF+pzy521yrSbzp
         +jk4yWKknFAv+QiJ4AM3h+5wCkTjAX/KsTvEVZALaAuq8wmTtsv5A4Ujm73p+sllyAJs
         n7mtE1VKTaosA0kRffe+xE07fSmW8WdxI36aryebUAGYke5a5xZ8+481maa5L9eHp4F4
         dwM6j/Dm40K94RVv93J9d9XPoO7KRkM+ALaCf528qIqGIiZD/DCvCCAosOx5zkzVwoS+
         yWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byHoc+sozUvnf5N3D1WACAuN2lqHzez/Xjmbf6/mYDo=;
        b=BzTMANUVDvvnEPjOR0a7TcB8BW3qAeQSJe+xZw8cgdQvXkclvdDkOlVIfm5dlGoa5t
         LfI6pLy1LyGix0u5jfWgZaLY62avwWfUtehs0vgglAVKzF6savkDhbZxFPgt/trH327E
         dPRWFI2JFFCsU9d+2mw1QmephIuqupWSxUOpb2rA/xjojuALGSDo2q9snuPznL0HOpgG
         H79+3QzFw+tJjC0Qw+vHjWclQOR/0z/WzduuYi4pxvvil/d2zAv4q/DWKwbDyHXgd+L0
         xyQYoSLBMy3DK0Z4k44waeRbdicDvA/itqlcP7okQmpDrU+lswmVVYIuQ0mMcDACBVVC
         BuPg==
X-Gm-Message-State: AOAM5321I5QTn/GnLVzjDgyAXJGJbTv+r38xRlHXX7gCA3KmclxkE7+j
        6CrWJDV5CVutciArkKJOifHpTwu7PIWgRVMfl2tLew==
X-Google-Smtp-Source: ABdhPJyOou0CDI/LDmv2UrSgjJKmwKUAbFf9G7Gv6gvTCUf2KUnv6w++3YN7FkMUgEf5ENNLMsX7Lni5z80d+rmgMtg=
X-Received: by 2002:a19:6916:: with SMTP id e22mr1164262lfc.421.1613617673291;
 Wed, 17 Feb 2021 19:07:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613593946.git.matheus.bernardino@usp.br>
 <6e30f133e234ff1d3a29f36423cd3fdca58d8095.1613593946.git.matheus.bernardino@usp.br>
 <xmqqpn0yi9ii.fsf@gitster.g>
In-Reply-To: <xmqqpn0yi9ii.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 18 Feb 2021 00:07:42 -0300
Message-ID: <CAHd-oW6b0n7ezA-C8NuUOkHUSfM8TFLmkJtwwSRv7FRtbOWjsA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 8:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
> >
> > +test_expect_success "git add does not remove SKIP_WORKTREE entries" '
>
> We use the term SKIP_WORKTREE and SPARSE interchangeably here.  I
> wonder if it is easier to understand if we stick to one e.g. by
> saying "... does not remove 'sparse' entries" instead?  I dunno.

Good idea, thanks.

> > +     setup_sparse_entry &&
> > +     rm sparse_entry &&
> > +     git add sparse_entry &&
> > +     test_sparse_entry_unchanged
>
> Wow.  OK.  Makes a reader wonder what should happen when the two
> operations are replaced with "git rm sparse_entry"; let's read on.
>
> > +'
> > +
> > +test_expect_success "git add -A does not remove SKIP_WORKTREE entries" '
> > +     setup_sparse_entry &&
> > +     rm sparse_entry &&
> > +     git add -A &&
> > +     test_sparse_entry_unchanged
> > +'
>
> OK.  As there is nothing other than sparse_entry in the working tree
> or in the index, the above two should be equivalent.

I just realized that the "actual" file created by the previous
test_sparse_entry_unchanged would also be added to the index here.
This doesn't affect the current test or the next ones, but I guess we
could use `git add -A sparse_entry` to avoid any future problems.

> I wonder what should happen if the "add -A" gets replaced with "add .";
> it should behave the same way, I think.  Is it worth testing that
> case as well, or is it redundant?

Hmm, I think it might be better to test only `add -A sparse_entry`, to
avoid adding the "actual" file or others that might be introduced in
future changes.

> > +test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
> > +     setup_sparse_entry &&
> > +     test-tool chmtime -60 sparse_entry &&
> > +     git add --refresh sparse_entry &&
> > +
> > +     # We must unset the SKIP_WORKTREE bit, otherwise
> > +     # git diff-files would skip examining the file
> > +     git update-index --no-skip-worktree sparse_entry &&
> > +
> > +     echo sparse_entry >expected &&
> > +     git diff-files --name-only sparse_entry >actual &&
> > +     test_cmp actual expected
>
> Hmph, I am not sure what we are testing at this point.  One way to
> make the final diff-files step show sparse_entry would be for "git
> add --refresh" to be a no-op, in which case, the cached stat
> information in the index would be different in mtime from the path
> in the working tree.  But "update-index --no-skip-worktree" may be
> buggy and further change or invalidate the cached stat information
> to cause diff-files to report that the path may be different.

Oh, that is a problem... We could use `git ls-files --debug` and
directly compare the mtime field. But the ls-files doc says that
--debug format may change at any time... Any other idea?

> > +'
> > +
> > +test_expect_failure 'git add --chmod does not update SKIP_WORKTREE entries' '
> > +     setup_sparse_entry &&
> > +     git add --chmod=+x sparse_entry &&
> > +     test_sparse_entry_unchanged
>
> Hmph.  Should we also check if sparse_entry in the filesystem also
> is not made executable, not just the entry in the index?

I think so. This is already tested at the "core" --chmod tests in
t3700, but it certainly wouldn't hurt to test here too.

Thanks for all the great feedback
