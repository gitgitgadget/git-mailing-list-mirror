Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B05C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDDA6140D
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhDUAy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhDUAy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 20:54:28 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF7C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:53:56 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso23460587otm.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQykzR9/c+jYQRKVSasc74Tln/H88ojRfK8f0n63KJ0=;
        b=AwA2Hc5mLJOev9KDHWLnVsTu3cNo4qhcF1we73DGWLumUy49HFNgvaWU44KISIMm9k
         TAMQ+11dbkufdVJuL3wQk9B5N94x+vpHZcnpJ2x+vF++oVNIpvSHgU0Y3hbzVgs/Pdsx
         Pw5MGzuwZwcwfzf5hx8JoiUL8R+CLTpCzwD16s7HuRbAy6kzWK/kwuRZhinD89zFUyPr
         5eJVy48TZWI/7SuXoXAHbaqGuecQlauIjK9/xl/8fn1bIqIVyjFjjrRbsuPK2lcoGR/j
         DIIaCxh9yphGTn0ACNnHABESPdQ6teiwD3ZwiXpWuYdY3LKaN5lAUyTQyL+5c2cssbfc
         GumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQykzR9/c+jYQRKVSasc74Tln/H88ojRfK8f0n63KJ0=;
        b=aQLJJpmI5HZRsULT4Fa02RlKISycPLba3ilvcdifKLV2Q1ryPK6R024/D8dA4EJiQH
         v2nDaV/3CKqobFRONl+ClrH9ePJigOwTqbUzR/5Y8W0q8usxzdM9m3afedxTAC1Pvq89
         cd0cLpGyjUQXypx7wjxmoYU/v0T0IVLd7r1yXNBVsqq0iE78+j9qWsvza7qsQuJFiP6q
         CrY8sIaq0upzIU9k865bNj0kHrUe9skx6Lub2IQHRX8UExsQdw1twbhRRBoKih8pxgTR
         jCG5NbxhzTmPaCScLGOEuErqeR7Jkl1rKCh4OsyeHtfuZJW0DPB7XhMIEaBzabZtjqHM
         r0wA==
X-Gm-Message-State: AOAM530IyUZ5zt0NnWvZhSL5bYB0MkR7kGbKFSXT+aZiKNL1e1K6yVrK
        SkY5RRwbRfKJ4jWxcOQWSpHMQLKAJplDxLtSFPY=
X-Google-Smtp-Source: ABdhPJw7n6sX8O6xHHUi7Y2+TlsZIUwpnLRQwtxQ1+XkcrXHWW6bhSJgsM/ioXfsddul+7+OHJtdIHehiyfiwh2iBTo=
X-Received: by 2002:a05:6830:906:: with SMTP id v6mr21321255ott.345.1618966436279;
 Tue, 20 Apr 2021 17:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <434306541613cbd0b9bb4ebb3102d97e3df9eb94.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BE2qzvFwp0Gg_o+Sd5oC2itpkLNuhvEv1qWTvbCGUKWhQ@mail.gmail.com>
In-Reply-To: <CABPp-BE2qzvFwp0Gg_o+Sd5oC2itpkLNuhvEv1qWTvbCGUKWhQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Apr 2021 17:53:45 -0700
Message-ID: <CABPp-BHLTKWW_j53P9=mwGpmAiuBUcUvRp2Oaim8T+SB46+h+g@mail.gmail.com>
Subject: Re: [PATCH 06/10] dir: use expand_to_path() for sparse directories
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One more thing:

On Tue, Apr 20, 2021 at 5:52 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > The recently-implemented expand_to_path() method can supply position
> > queries a faster response if they are specifically asking for a path
> > within the sparse cone. Since this is the most-common scenario, this
> > provides a significant speedup.
> >
> > Update t1092-sparse-checkout-compatibility.sh to fully ensure that 'git
> > status' does not expand a sparse index to a full one, even when there
> > exist untracked files.
> >
> > The performance test script p2000-sparse-operations.sh demonstrates
> > that this is the final hole to fill to allow 'git status' to speed up
> > when using a sparse index:
> >
> > Test                                  HEAD~1            HEAD
> > ------------------------------------------------------------------------------
> > 2000.4: git status (sparse-index-v3)  1.50(1.43+0.10)   0.04(0.04+0.03) -97.3%
> > 2000.5: git status (sparse-index-v4)  1.50(1.43+0.10)   0.04(0.03+0.04) -97.3%
>
> Um, I'm confused.  In the previous patch you claimed the following speedups:
>
> 2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  0.04(0.05+0.04) -98.4%
> 2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  0.05(0.04+0.07) -98.0%
>
> I don't understand why the "Before" for this patch claims 1.50 as the
> initial speed, if the "After" for the last patch was 0.04.  Should the
> previous commit message have instead claimed:
>
> 2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  1.50(1.43+0.10) -38.3%
> 2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  1.50(1.43+0.10) -38.5%
>
> ?
>
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  t/t1092-sparse-checkout-compatibility.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> > index 380a085f8ec4..b937d7096afd 100755
> > --- a/t/t1092-sparse-checkout-compatibility.sh
> > +++ b/t/t1092-sparse-checkout-compatibility.sh
> > @@ -456,8 +456,9 @@ test_expect_success 'sparse-index is not expanded' '
> >         init_repos &&
> >
> >         rm -f trace2.txt &&
> > +       echo >>sparse-index/untracked.txt &&
> >         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> > -               git -C sparse-index status -uno &&
> > +               git -C sparse-index status &&
> >         test_region ! index ensure_full_index trace2.txt
> >  '
> >
> > --
> > gitgitgadget
>
> Oh!  So, the previous patch was testing without enumerating untracked
> files (because it did those slowly), whereas this one enumerates
> untracked files and is still able to achieve the same performance?
> This wasn't very clear from the commit message.  Maybe I'm just bad at
> reading, but perhaps the commit message could be tweaked slightly to
> make this more clear?

Why is the subject of this commit "dir: use expand_to_path() ..." if
it only touches t1092-sparse-checkout-compatibility.sh?
