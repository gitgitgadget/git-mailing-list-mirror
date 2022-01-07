Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6503EC433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 16:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348213AbiAGQV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 11:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348184AbiAGQV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 11:21:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D45C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 08:21:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u25so24129964edf.1
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WU/yU9vKE0H1yYWdsI86rIRsQn9lRbw0IaP2+qc9nPE=;
        b=U8TiNsg8puTD5G/Y7V/wOfyt9FbfKuMb11lXjRsa7et6uPery6cdQFi9mchbAbEgeT
         lPi4WiM8Hy8Zaqnp777O+k9AvUlrz3qa77oCWvY+XpkITON3BGbMTNDF3XXsCTMbvOZT
         /MCHKcMx5w5ifMdG8Ky4IhJ+Nfw4FDCsyNveIfyEarWbL7iYz7lm4ICAa8DTCs6Xmg40
         c4f2z/SXszRvMtEAKCiNu+Bhq9bRTQEPY3dtD5d3I+B3PsihKHQdGjSaHgZGGY0u1im8
         buMUgtsQYDPoL2CMHS53k98JrDcOf0Xn/1Er4jzywuqRLKwsuDSpbyKwTNgbj/5zBiEG
         qocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WU/yU9vKE0H1yYWdsI86rIRsQn9lRbw0IaP2+qc9nPE=;
        b=3bHW8dvwhbA5ghxpvw8pJpiyIK5OfeI1wCqO54YCChbiWOt5nh0Aqzqw7PrUavGJzh
         CLau8QlqV19syYrUpUvk30ZZDEf+jXvt/Ylm4PIluSTIH6lrKEzb+XsQIAzp1GqfGP2y
         WwYfDspLAuGwRVv3HjZ0nSYiHZn0Ldjhg+MhZvH3agugVDaOSHti9j7hAzJnpnjXx/8s
         hoTwDZa2xHYVOzIXBhDOovSblcZueFS5R22HNkxemM8xUje8F0EoWCRhhM/m4WkNqroY
         C8ZaV2N9J+NcMTKv75LMsHNx5uUniBQ2cCxVLSg3Ao4sg9KwTCIpOp1Mq34iWWZRj4n5
         VB6w==
X-Gm-Message-State: AOAM5333aFr29yq2IM1vBcfh4yYa9n1JQ0klHW17yc3xfyBC11Z2aGKu
        r7azq2aikkY/KgnEhEDHe/dm2AOokA+xbiW9UYQ=
X-Google-Smtp-Source: ABdhPJwMAk7klODXVFqopiXZT2NZDrZMlTYOMB7QrxUDv60/8fwta2jUqgtnGBPRUr6Gb6jM+I0s8F8PtIUVrhaA0vI=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr49402781ejc.269.1641572485149;
 Fri, 07 Jan 2022 08:21:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
 <e6a8671f6be5afad9a495be66c0735f6b741c844.1641317820.git.gitgitgadget@gmail.com>
 <CABPp-BFqTqK3grMLv_odKGwDhUaU8p1epNzv825kTqLAgMrK9g@mail.gmail.com>
In-Reply-To: <CABPp-BFqTqK3grMLv_odKGwDhUaU8p1epNzv825kTqLAgMrK9g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 08:21:13 -0800
Message-ID: <CABPp-BFvPDKYhDQGJ8-qKojs+aTXa2ZTKTGJb+Aa4wER8Ug8Ow@mail.gmail.com>
Subject: Re: [PATCH 4/9] checkout-index: expand sparse checkout compatibility tests
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 1:04 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Victoria Dye <vdye@github.com>
> >
...
> > +'
> > +
> > +# NEEDSWORK: even in sparse checkouts, checkout-index --all will create all
> > +# files (even those outside the sparse definition) on disk. However, these files
> > +# don't appear in the percentage of tracked files in git status.
>
> Ah, so you _are_ noticing the present-despite-SKIP_WORKTREE files.  I
> think it might be nice to test for these a bit earlier, but it's nice
> to see some test here for them.
>
> I think that present-despite-SKIP_WORKTREE files is an erroneous
> condition, one we should avoid triggering, and one we should help
> users clean up from.  For checkout-index, the fact that it currently
> makes more of these files is buggy.  It should either (1) clear the
> SKIP_WORKTREE bit when it writes the files to the working tree, or (2)
> avoid writing the files to the working tree.
>
> And if we choose (1), there's already a --no-create option we could
> piggy-back on to allow folks to not write the SKIP_WORKTREE files.
>
> > +test_expect_failure 'checkout-index --all' '
> > +       init_repos &&
> > +
> > +       test_all_match git checkout-index --all &&
> > +       test_sparse_match test_path_is_missing folder1
>
> Ah, it looks like you're choosing (2).  That may be fine, but an
> interesting anecdote:
>
> While attempting to adopt sparse checkouts at $DAYJOB (and
> particularly using cone mode), we found the code structure just didn't
> quite work.  We needed some directories to be ignored for sparse
> checkouts to be meaningful at all, but we had some files that were
> siblings to those directories that were needed for builds to function.
> We came up with a hack to "add a few files back", using "git
> checkout-index -- $FILENAME".  We expected that hack to write the
> listed file(s) to the working tree -- though I think we also had logic
> to then run the stuff we needed and then delete these temporary files.
> We used this hack starting in Feb 2020, and eventually restructured
> the code to not need this hack in Feb 2021.  I'll have to mull over
> whether your choice of option (2) might cause us some problems if
> someone (a) uses a new git version to (b) access an old version of our
> code and (c) really wants to work with a sparse checkout (since the
> "checkout-index" stuff was part of the build logic checked into the
> code).  I think your change here is fine (because not using sparse
> checkouts is an option, we told folks it was experimental, and those
> are old versions that are only getting security fixes in special
> circumstances), but let me think about it for a bit...

I brought this up a day or two ago with my co-workers and discussed
the combination of conditions needed to trigger any problems.  Their
response was "meh, it's pretty unlikely that anyone ever hits it, the
feature was labeled as experimental anyway, and there are multiple
easy workarounds for the user to choose from".  So, no need to worry
about this angle.
