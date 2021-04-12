Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0AFC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0245E61249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 15:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbhDLPqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 11:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241288AbhDLPqC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 11:46:02 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978ADC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 08:45:43 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so13159247otq.10
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8m5JuVTXuPI4Vqrqc1mbh16x9ifFdzEvDYy+RgSo0o=;
        b=dmtEQCSe9qzf+rsUx5kKCsS7iKFU7NYgUzlf/wI6uizIWbvorIOx3QZKx2FXnO9MyO
         pQcEEegZCZKYkz9DHabGI6qN3yitkRTxnhKY6BbA6rkHI1hZPFSWCj23V0EA8c4skZWV
         dVgJstK71zgCs2zUAfI9RXtxFleQjtRYn/FXsTbWxkxl+vc5szac850knKbwEbtEE0kF
         Wjji13VWba5opgmOEK0rFKyq1HryYRj1UGq9aOXKvKbdnMriZSudhWuLgrprUz2z64s/
         FiqueSDjWvrqD+7y9Yzub7+TePx6bjieLtkaWCeYsBlN8zKPXO7t2AOoWwLuRhQtHHSb
         pbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8m5JuVTXuPI4Vqrqc1mbh16x9ifFdzEvDYy+RgSo0o=;
        b=KLKmtR+H7gubatjIhobxSmxn4gwgfXSaCPLBsPP6PuoTuojV1mkDK+hT54d6oYaQIY
         BNqnHzl2DXvSMAlyRx0Yio/pJkNgXCzMJK/emArZiAP6ZJVhG+/0aPaoVovpMFJNm5D0
         kNfqP1GJUL5wp47rV5OIbZKKo4iOp4SaH6oPcLr6S5uRu3YsI9wnE6iKqeYL0PCyFfzY
         wj+qOHCgDJAg3bCSiVxGWpQqwm79V3xzTXrH7oWYSxgsGRu/cU707T47V7My702YaDxv
         e1GMbgrhnvU4bmzxjUx/Ns6so4RFAZmQpAqn3mo4IxjxEfMrM1Tro5DJLYIFLJ/4hcr/
         HOvg==
X-Gm-Message-State: AOAM531RtH9kzO1PPnyT2bD6VnUfEw+MDVaNZV442R5WP33GPS6JRp+P
        2i+WuvHjYE/vs3eBF6p3EmwGQZJlgHG/Zzwkojo=
X-Google-Smtp-Source: ABdhPJxzy/8MkB97AYf/xmxlIZGmWgmXLiRW0HgPYNqJvi1DBrIOrSdeREs0uleq8Z7RWSUEEdS7vixKdHCPGUdpZf0=
X-Received: by 2002:a9d:2de8:: with SMTP id g95mr11462262otb.162.1618242342994;
 Mon, 12 Apr 2021 08:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210407180349.10173-1-jerry@skydio.com> <20210408021344.8053-1-jerry@skydio.com>
 <xmqqh7kgvr3i.fsf@gitster.g>
In-Reply-To: <xmqqh7kgvr3i.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Apr 2021 08:45:31 -0700
Message-ID: <CABPp-BEmZrK9ambLHL=ryjRM22zqGn6vzc+2aGoy=x-Z3mwUdQ@mail.gmail.com>
Subject: Re: [PATCH v5] git-apply: allow simultaneous --cached and --3way options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jerry Zhang <jerry@skydio.com>,
        Git Mailing List <git@vger.kernel.org>, ross@skydio.com,
        Abraham Bachrach <abe@skydio.com>, brian.kubisiak@skydio.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 8, 2021 at 6:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> >  Documentation/git-apply.txt |  6 +++--
> >  apply.c                     |  9 ++++---
> >  t/t4108-apply-threeway.sh   | 50 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 59 insertions(+), 6 deletions(-)
>
> Nicely done.  Will queue.
>
> Elijah, how does this round look to you?

Sorry for the delay; modulo two minor issues with the commit message
it looks good to me.

This change won't allow git-apply to handle upstream renames, and
makes me wonder if we should lift the fall_back_threeway() logic out
of builtin/am.c and use it here.  This change also makes me wonder if
we should change git-am's --3way flag to make it not be treated as a
fallback to be consistent with what we are doing here.  But neither of
those changes need to be part of this patch.

> > diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> > index 9144575299c264dd299b542b7b5948eef35f211c..aa1ae56a25e0428cabcfa2539900ef2a09abcb7c 100644
> > --- a/Documentation/git-apply.txt
> > +++ b/Documentation/git-apply.txt
> > @@ -87,8 +87,10 @@ OPTIONS
> >       Attempt 3-way merge if the patch records the identity of blobs it is supposed
> >       to apply to and we have those blobs available locally, possibly leaving the
> >       conflict markers in the files in the working tree for the user to
> > -     resolve.  This option implies the `--index` option, and is incompatible
> > -     with the `--reject` and the `--cached` options.
> > +     resolve.  This option implies the `--index` option unless the
> > +     `--cached` option is used, and is incompatible with the `--reject` option.
> > +     When used with the `--cached` option, any conflicts are left at higher stages
> > +     in the cache.
> >
> >  --build-fake-ancestor=<file>::
> >       Newer 'git diff' output has embedded 'index information'
> > diff --git a/apply.c b/apply.c
> > index 9bd4efcbced842d2c5c030a0f2178ddb36114600..dadab80ec967357b031657d4e3d0ae52fac11411 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -133,8 +133,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
> >
> >       if (state->apply_with_reject && state->threeway)
> >               return error(_("--reject and --3way cannot be used together."));
> > -     if (state->cached && state->threeway)
> > -             return error(_("--cached and --3way cannot be used together."));
> >       if (state->threeway) {
> >               if (is_not_gitdir)
> >                       return error(_("--3way outside a repository"));
> > @@ -4644,8 +4642,11 @@ static int write_out_results(struct apply_state *state, struct patch *list)
> >                               fprintf(stderr, "U %s\n", item->string);
> >               }
> >               string_list_clear(&cpath, 0);
> > -
> > -             repo_rerere(state->repo, 0);
> > +             /* Rerere relies on the partially merged result being in the working tree
> > +              * with conflict markers, but that isn't written with --cached.
> > +              */
> > +             if (!state->cached)
> > +                     repo_rerere(state->repo, 0);
> >       }
> >
> >       return errs;
> > diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> > index 9ff313f976422f9c12dc8032d14567b54cfe3765..65147efdea9a00e30d156e6f4d5d72a3987f230d 100755
> > --- a/t/t4108-apply-threeway.sh
> > +++ b/t/t4108-apply-threeway.sh
> > @@ -180,4 +180,54 @@ test_expect_success 'apply -3 with ambiguous repeating file' '
> >       test_cmp expect one_two_repeat
> >  '
> >
> > +test_expect_success 'apply with --3way --cached clean apply' '
> > +     # Merging side should be similar to applying this patch
> > +     git diff ...side >P.diff &&
> > +
> > +     # The corresponding cleanly applied merge
> > +     git reset --hard &&
> > +     git checkout main~ &&
> > +     git merge --no-commit side &&
> > +     git ls-files -s >expect.ls &&
> > +
> > +     # should succeed
> > +     git reset --hard &&
> > +     git checkout main~ &&
> > +     git apply --cached --3way P.diff &&
> > +     git ls-files -s >actual.ls &&
> > +     print_sanitized_conflicted_diff >actual.diff &&
> > +
> > +     # The cache should resemble the corresponding merge
> > +     # (both files at stage #0)
> > +     test_cmp expect.ls actual.ls &&
> > +     # However the working directory should not change
> > +     >expect.diff &&
> > +     test_cmp expect.diff actual.diff
> > +'
> > +
> > +test_expect_success 'apply with --3way --cached and conflicts' '
> > +     # Merging side should be similar to applying this patch
> > +     git diff ...side >P.diff &&
> > +
> > +     # The corresponding conflicted merge
> > +     git reset --hard &&
> > +     git checkout main^0 &&
> > +     test_must_fail git merge --no-commit side &&
> > +     git ls-files -s >expect.ls &&
> > +
> > +     # should fail to apply
> > +     git reset --hard &&
> > +     git checkout main^0 &&
> > +     test_must_fail git apply --cached --3way P.diff &&
> > +     git ls-files -s >actual.ls &&
> > +     print_sanitized_conflicted_diff >actual.diff &&
> > +
> > +     # The cache should resemble the corresponding merge
> > +     # (one file at stage #0, one file at stages #1 #2 #3)
> > +     test_cmp expect.ls actual.ls &&
> > +     # However the working directory should not change
> > +     >expect.diff &&
> > +     test_cmp expect.diff actual.diff
> > +'
> > +
> >  test_done
