Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24EDC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8175761245
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhGLUkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhGLUkp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:40:45 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953BEC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:37:56 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso20197798oty.12
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlD2XPs3PBRLtd8U4UT40o21Ls6mBbEkjaPJsQw7b1s=;
        b=JxymwSjQU8pdZ0MBFTvLu8NHHAfcqkEAWXYqo/bX6q+FPuik/ATi16LCiP/O+HfFJr
         NOTT5LB3DJSyQCQtByuftNDL4/abjrdP6XsaeHxftP6I4rVZKfRH730kTR0XTLeNfgBP
         4x3J54x2IwEM6nt0gggWBTIcmZWzRLkqapc4gNQ8cHJGTfKiYT6EWx1iZQe3qxjJvGEQ
         8NJ+Mi20Ra0aViDfHIBJly3stXSZUlQN1qR51FGbItxoEIrNBac5aK1mTfGH09ipDt/U
         NmPJykHJTUHNSSmEYesNRFzrk+1oaF+ut4i4ny/ChTnGGWDutq6u3jHecpJT9HH8fJ0V
         xt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlD2XPs3PBRLtd8U4UT40o21Ls6mBbEkjaPJsQw7b1s=;
        b=Xqbam1ypRZ3OOZhT7asFy0KDaz6my89PHKbXQG+53wI49a/zguQyQaTfJhyxju+Bkc
         Mn3TOPXIMJTkxoGzq2cJrJ1snvLdQNZEgjwBjnNkJvUyZ69IBaRYfn9PxRMKZKRqmE13
         1x9q8Fks2JrjweTha7SzhgJ5O5A8R95lkcQtYNx2zHuXGwRtKjN/wmrsafWlX8jhYWyc
         BLIeKKDlM0hGFNNOoQyHlX/B4syBPe2boaecIYVOlmYaB6BH2uafYNWyWT86jn9gYYFq
         4QZU44RgzgLKyVLZ18yXpfw7Hw/mCwpGzjuLiW7vYGRh0RLviBw8UMm9UdEZbs1dteKI
         Jg4g==
X-Gm-Message-State: AOAM533ncfPPNMd2jB3T2RG61p1Er7Oe1hJF3J6uFILJUUNKwvf9hcka
        wuLqo2zRqg60nJbsBKdlCcWvsWOHSTkRfTeZVUk=
X-Google-Smtp-Source: ABdhPJxgpymME4m0UjCV1E4IhmQfQiQpPmZLZmw+m0HWuDInOmCfApyJrTjItuQDm74TOCPp45CzzSJ2C56r2yYF/zA=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr634147otd.345.1626122276004;
 Mon, 12 Jul 2021 13:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com> <xmqqpmvn5ukj.fsf@gitster.g>
 <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com> <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
In-Reply-To: <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Jul 2021 13:37:45 -0700
Message-ID: <CABPp-BGGi_b3PeFZ4-uErLS2vad-mX5gcuO+=nfgQreRMSCYZw@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 11:20 AM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Mon, Jul 12, 2021 at 11:51 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Jul 12, 2021 at 10:08 AM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Phillip Wood <phillip.wood123@gmail.com> writes:
> > >
> > > > Thanks for revising this patch, I like this approach much better. I do
> > > > however have some concerns about the interaction of pull.ff with the
> > > > rebase config and command line options. I'd naively expect the
> > > > following behavior (where rebase can fast-forward if possible)
> > > >
> > > >   pull.ff  pull.rebase  commandline  action
> > > >    only     not false                rebase
> > > >    only     not false   --no-rebase  fast-forward only
> > > >     *       not false    --ff-only   fast-forward only
> > > >    only     not false    --ff        merge --ff
> > > >    only     not false    --no-ff     merge --no-ff
> > > >    only       false                  fast-forward only
> > > >    only       false      --rebase    rebase
> > > >    only       false      --ff        merge --ff
> > > >    only       false      --no-ff     merge --no-ff
> > >
> > > Do you mean by "not false" something other than "true"?  Are you
> > > trying to capture what should happen when these configuration
> > > options are unspecified as well (and your "not false" is "either set
> > > to true or unspecified")?  I ask because the first row does not make
> > > any sense to me.  It seems to say
> > >
> > >     "If pull.ff is set to 'only', pull.rebase is not set to 'false',
> > >     and the command line does not say anything, we will rebase".
> >
> > I think Phillip is trying to answer what to do when pull.ff and
> > pull.rebase conflict.  If I read his "not false" means "is set to
> > something other than false", then I agree with his table, but I think
> > he missed covering some cases.
> >
> > I think his table says that pull.rebase=false cannot conflict with
> > pull.ff settings, but any other value for pull.rebase can.  That makes
> > sense to me.
> >
> > I'd similarly say that pull.ff=true cannot conflict with any
> > pull.rebase settings...but that both pull.ff=only AND pull.ff=false
> > conflict with pull.rebase={true,merges}.
> >
> > My opinion would be:
> >   * conflicting command line flags results in the last one winning.
> >   * --no-rebase makes pull.ff determine the action.
> >   * --ff makes pull.rebase determine the action.
> >   * any other command line flag (-r|--rebase|--no-ff|--ff-only)
> > overrides both pull.ff and pull.rebase
> >   * If no command line option is given, and pull.ff and pull.rebase
> > conflict, then error out.
> >
> > I believe my recommendation above is consistent with every entry in
> > Phillip's table except the first line (where I suggest erroring out
> > instead).
>
> I'm not sure that --no-ff should imply --no-rebase because `git
> rebase` actually has a --no-ff option to rewrite commits even when
> fast-forwarding is possible. And it's not really necessary to make
> --ff-only imply --no-rebase because we're going to make `git pull`
> handle --ff-only itself without invoking `git merge`. However, the
> rest of this proposal could be implemented in a straightforward manner
> by making --rebase on the command line imply --ff, and I think that
> would be a fine solution.

git rebase has a --no-ff but it doesn't do anything like what git
pull's --no-ff has long been documented to do.  git pull's --no-ff
very clearly states that a merge commit will be created, and thus is
tied to merging instead of rebasing.

Also, I don't think pull needs to provide a union of all merge and
rebase options; so there's no need to add a way to invoke a 'rebase
--no-ff' from pull.  (Folks can run individual fetch & merge or rebase
steps, after all.)  I think we should concentrate on making sure that
we provide reasonable behavior when conflicting options/command-lines
from the already provided set are specified.
