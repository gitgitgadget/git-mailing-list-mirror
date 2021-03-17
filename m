Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3129C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9515F64E28
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhCQUfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhCQUfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:35:32 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18CCC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:35:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 15so4917972ljj.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duIWa4VkOvigBNJgx9Q4OHYc925QlKVec7c5Uk2PYqE=;
        b=TOdDUJL2FPJLIajAORkGCeG83Oj/tpFarnhPiBpe82OTwm2dpYSSyPyk7OpDc36QuK
         v6pjgj38TOUwPALf/Zte5Cm9l7eNNBy3k/4ltLTlll9XxjOthXDLgFlZnmZLlCmpuX2A
         vNtWn2EgAjQ+YJ/u2P5WOk8du3HTUL1etnMDYEpCKVX45R+xYJ1J4y1Roni/IDCaR6jc
         6WZVOgHdBs0i+MYZ5H5qd4NY7H3+ptxm1ldEyv6hDz89tYDSY556pnvfrURKfU7cI3M/
         Y+8/LDWhSpNNX/auv8+LoBW7Rttxh+qEUPxWV1ezTECQUDp3jzfN3kdK5TgLoykpB6bt
         eQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duIWa4VkOvigBNJgx9Q4OHYc925QlKVec7c5Uk2PYqE=;
        b=DsVJTWkof68TuKZJFDfMdivZ+ldLAOSyLGN0NBYGTGUZ2QY0dCoQonIKCwR6+Uzjkr
         NBmPI+vil/ri1DjO+hXU+pxFQU45IlZT0qoplCDe8JkEdmXSuRsMRb2t2FGxde7Y1eY/
         6S1pM3rtMroyJx7PLmjaRxdm/Nd7t9yiKQgRGEdCkE3aZRfSYVUW7WnmbD68OeXyWZ8c
         fmADTXCPPVZjS1z5uATjaCpxP/9sb/EM/Dh0kDRSRJzRwCxaaPMomIP6AsDYvto3tdN3
         qUMtdlpvJtrNBhRTDpxaLab3xL24xh4G03RDJtWmSytnLHtjLChZNFoUYK/ZjdGrIhWC
         CGNA==
X-Gm-Message-State: AOAM530YeCY9IBWAvV4m8wdkY4RXw5owCsg6q6hT2bXXLvJOH1QT8xGg
        uvrXa8tagk+izidNbD/G67Com4Lottso6EQNS0CaCg==
X-Google-Smtp-Source: ABdhPJwCR/g/hYmXZHg2xlld6nnHp3PyqlxZV3EF9epuA2acEdIKXXkBdQpSIpcPdFUKPPtCMeDF7vmDFMdO0IilOf0=
X-Received: by 2002:a2e:3808:: with SMTP id f8mr3255807lja.137.1616013328799;
 Wed, 17 Mar 2021 13:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <142df1ab8e3e8ea5e213f2477e271e60e5b62f84.1615929436.git.gitgitgadget@gmail.com>
 <CABPp-BHyCDJH-78XGdW5TxAOPjDE669LL21yTY3NdmCP7iSMRA@mail.gmail.com>
In-Reply-To: <CABPp-BHyCDJH-78XGdW5TxAOPjDE669LL21yTY3NdmCP7iSMRA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 17 Mar 2021 17:35:17 -0300
Message-ID: <CAHd-oW4DMAjQ_Gjbzkx6csFRAK1iKHsTfuJLniOjWehwrnHdVQ@mail.gmail.com>
Subject: Re: [PATCH 05/27] add: ensure full index
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 2:36 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > Before iterating over all cache entries, ensure that a sparse index is
> > expanded to a full index to avoid unexpected behavior.
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  builtin/add.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index ea762a41e3a2..ab2ef4a63530 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -141,6 +141,7 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
> >  {
> >         int i, retval = 0;
> >
> > +       ensure_full_index(&the_index);
> >         for (i = 0; i < active_nr; i++) {
> >                 struct cache_entry *ce = active_cache[i];
>
> I'm not so sure about this one; from git-add(1):
>
>        --renormalize
>            Apply the "clean" process freshly to all tracked files to forcibly
>            add them again to the index. This is useful after changing
>            core.autocrlf configuration or the text attribute in order to
>            correct files added with wrong CRLF/LF line endings. This option
>            implies -u.
>
> ... to "all tracked files".  Should that be interpreted as all files
> within the sparsity paths, especially considering that we're trying to
> enable folks to work within the set of files of interest to them?

I had the same question when working on the add/rm sparse-checkout
series. As seen at [1], --renormalize and --chmod are, currently, the
only options in git-add that do not honor the sparsity patterns and do
update SKIP_WORKTREE paths too.

But is this by design or possibly just an oversight? In my series I
ended up making both options honor the sparsity rules, with a warning
when requested to update any sparse path. (If we are going with this
approach, perhaps should we also amend the docs to remove any
ambiguity as for what "all tracked files" means in this case?)

> The code below already has the following check below:
>
>     if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
>       continue; /* do not touch non blobs */
>
> suggesting that it'd correctly skip over the sparse directories, so I
> think this one just isn't needed.

But if sparse index is not enabled, it does not skip over the sparse
files, right? So isn't the ensure_full_index() call here (and in
chmod_pathspec()) important to be consistent with the case when sparse
index is not in use? Or maybe Stolee could rebase this on top of my
series, where both these places already skip the sparse paths?
(Assuming that's the behavior we are looking for. If not, I can also
fix my series.)

[1]: https://lore.kernel.org/git/d93c3f51465a3e409819db63bd81802e7ef20ea9.1615588108.git.matheus.bernardino@usp.br/
