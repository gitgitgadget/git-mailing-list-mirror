Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3FDC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50AE611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbhGLRx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhGLRx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:53:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9289DC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:51:08 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id p12-20020a05683019ccb02904b7e9d93563so7643937otp.13
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTZznyJ+ejsSPi6Zhg4muv/sI90daoP4sn1j1TwwewU=;
        b=pFTJdVHVIRf8VmXVN3YVSqT4DdHHpRyHgGHa+AS4vaWStF0Du2rCl2d7etZDiY0Vap
         ZTZqJPiYLL4lP7ybm25jfluQ8Ri/Cxj4VJLrRI7gVbjXpxhF1xl5A8qcj9X9d9B/8KzA
         vNy863KaxX1cPpWvQp8xnlL3CXXOx2SI/4H25DaHtUTt/pJ6QaQCg4u9LZo7BVSYkARv
         Ens9Sx9MQlmqtAMyOgm4YjPRTdDvgnMhrJJZOgEpFP9MQfxQbIyJ0uSoMPfcDEhaJJvS
         oBjHMjRzH8Aw2+lN5gscXEw/PVTFfM+gx7smrqr7s0nVXejtrRBT81E9YOTtDSi5+u5s
         GaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTZznyJ+ejsSPi6Zhg4muv/sI90daoP4sn1j1TwwewU=;
        b=V9P99NYFHVQVBpTS5lWefzRF9MjbhFrvyLN5wiwfn/eM5gB0PQbhNlrfrwkHG85Xct
         GU1Eq9CHcH5rlJoRvXkzrVBVjUqkTc9IkSp6W0S5gIgphPLUrmgjLBL3uFzSeW5Qntom
         blQWwV6oWWDr0ifD4t2PcwcdBCDhiP4NUwGB1lUjNAX29ujpEAvmVFt4+poLGaJHjGl7
         8zlpdwA0fvTLymQbZJmVqqZzoO9rdCm79tltGxCJdV1IXM7ObAWirhs17nhxMpAK8Br4
         cFDH2cXhI7tbFkI81lg8j7Kx6e6JK7kFg3Mcx8J2tWYvADpXq75kGMHNwgWpIN8RxRv4
         t3PA==
X-Gm-Message-State: AOAM530hQEdFPcG6EJ0OVjBKZwYC992mhs0CON13ciBd8pZwJY4Q33Y+
        e7VqeU+6MoATmbxhTwtW7W0i8TPvJ9LD1hTXK2w=
X-Google-Smtp-Source: ABdhPJwgjby8F2dsj7a9OgLZg16WlL5HIvOxtt4kMP19SSvVJDxs/lso6/oeVr9RkkPJF96SVE+U/pq6rJGdKl5Q/DA=
X-Received: by 2002:a9d:73c1:: with SMTP id m1mr179512otk.162.1626112267988;
 Mon, 12 Jul 2021 10:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com> <xmqqpmvn5ukj.fsf@gitster.g>
In-Reply-To: <xmqqpmvn5ukj.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Jul 2021 10:50:57 -0700
Message-ID: <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 10:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Thanks for revising this patch, I like this approach much better. I do
> > however have some concerns about the interaction of pull.ff with the
> > rebase config and command line options. I'd naively expect the
> > following behavior (where rebase can fast-forward if possible)
> >
> >   pull.ff  pull.rebase  commandline  action
> >    only     not false                rebase
> >    only     not false   --no-rebase  fast-forward only
> >     *       not false    --ff-only   fast-forward only
> >    only     not false    --ff        merge --ff
> >    only     not false    --no-ff     merge --no-ff
> >    only       false                  fast-forward only
> >    only       false      --rebase    rebase
> >    only       false      --ff        merge --ff
> >    only       false      --no-ff     merge --no-ff
>
> Do you mean by "not false" something other than "true"?  Are you
> trying to capture what should happen when these configuration
> options are unspecified as well (and your "not false" is "either set
> to true or unspecified")?  I ask because the first row does not make
> any sense to me.  It seems to say
>
>     "If pull.ff is set to 'only', pull.rebase is not set to 'false',
>     and the command line does not say anything, we will rebase".

I think Phillip is trying to answer what to do when pull.ff and
pull.rebase conflict.  If I read his "not false" means "is set to
something other than false", then I agree with his table, but I think
he missed covering some cases.

I think his table says that pull.rebase=false cannot conflict with
pull.ff settings, but any other value for pull.rebase can.  That makes
sense to me.

I'd similarly say that pull.ff=true cannot conflict with any
pull.rebase settings...but that both pull.ff=only AND pull.ff=false
conflict with pull.rebase={true,merges}.

My opinion would be:
  * conflicting command line flags results in the last one winning.
  * --no-rebase makes pull.ff determine the action.
  * --ff makes pull.rebase determine the action.
  * any other command line flag (-r|--rebase|--no-ff|--ff-only)
overrides both pull.ff and pull.rebase
  * If no command line option is given, and pull.ff and pull.rebase
conflict, then error out.

I believe my recommendation above is consistent with every entry in
Phillip's table except the first line (where I suggest erroring out
instead).
