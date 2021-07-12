Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC87EC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 23:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0591606A5
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 23:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhGLXjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhGLXjr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 19:39:47 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B16C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 16:36:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id h9so26594394oih.4
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6Ow97pWGBXm+f/E6Xlw9A5ISAxw/C1taGdxuYcz8Mn4=;
        b=H4hvQrXdJ+jfjK8EtutbY7ygFWrUOLFkS7Vc/YdJLZp4vlnabsofDqWnsHmfH0FPnK
         x/0OZ3gLc5KNnUF1f2KxBAV5KQkJoEhbT//ikn/+bohp6UFJiljqt7oYtUnJ1GuThsEg
         7gQdGaNbCoxYdLqDIq9La1+FwC/ZI2vS4tCndwyuSdj0nTK+oDCQRPpmmUawhvt+GjXw
         bRrAmt/tNaPqRqbhylZa12A2eMhslQM59WLZVFJ3SrYIJgbs3UG2c9kkpwhbKds1lxp2
         I86cwo43U6zgOB2ILv6eHi8NMXrzbp7IEOxNH+tEYA0gAdvHlybaUI+wK4IcqMFSibwG
         AmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6Ow97pWGBXm+f/E6Xlw9A5ISAxw/C1taGdxuYcz8Mn4=;
        b=if9MNooDgRFFFverQbLkr8PZYKHQY98T5ceAdUibE0uE4sdOkDK2BzCjNWHcHHxT3J
         /JwRY0yD/PcwcsJPxxfeq7KcBEgii77UwA+/cwhD2Oq+zeJVauL35OD8jQ+tIxLkmqQM
         /AaNaDjAYWyvCSAy0j4lb32Z+J0zrnypOABGPqEZvKXSzMb/ix/rutgOSuf+HXpYOMpQ
         gKr0JsTBlbyjeVqeMVbIRQ0ajVwJmT2N4SSqAYWSkXRRVkO327iKdZ1Am5yVMHB0Yved
         e85LB2YgzmsqDjj6CPg1Yog67wj4QhxSq1ONVLywSISdB+ld0jepeN+LqeKAtKhYOlyW
         h5Fw==
X-Gm-Message-State: AOAM533kfJbDvqb+HMcmtkbtM4RBQbNU1Yuorn6tT3NWTihi5tAAPDn4
        rZu3iKsLfOFSxWQHn1C0W00=
X-Google-Smtp-Source: ABdhPJxuEIekZaBXtZSCxLDAnHQ9YaCwccTbZVAyNHGccAUDyqYSD+SIJzYmlxGlUUrkyTQvOGfuew==
X-Received: by 2002:aca:d1a:: with SMTP id 26mr5418335oin.69.1626133016786;
        Mon, 12 Jul 2021 16:36:56 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id n9sm1670737otn.54.2021.07.12.16.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:36:56 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:36:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60ecd216bd177_a7177208bc@natae.notmuch>
In-Reply-To: <87czrnf8bj.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <87im1ieaba.fsf@osv.gnss.ru>
 <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
 <87a6mudt9b.fsf@osv.gnss.ru>
 <60e9ff4430c57_7ef20815@natae.notmuch>
 <874kd1gr0q.fsf@osv.gnss.ru>
 <60ec6cd622c4c_a4525208a0@natae.notmuch>
 <87czrnf8bj.fsf@osv.gnss.ru>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Sergey Organov wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:

> >> > I don't see the logic in here.
> >> >
> >> >   git branch topic # here 'branch' is the verb
> >> 
> >> Not to me. I assumed the "branch" is always a noun in "git branch", and
> >> the actual meaning of this command is:
> >> 
> >>    git branch [create|new] topic
> >> 
> >> I.e., creation just being the default action taken on the branch.
> >
> > The question is not what you assumed, the question is can other people
> > assume otherwise?
> 
> Sure they can, and that's part of the problem. I described how *I* see
> it, as I try to interpret things as coherently as possible, and I don't
> like to interpret "branch" in "git branch" as either noun or verb
> depending on options when universal interpretation as noun is
> sufficient.
> 
> > "branch" can be a verb, that's a fact.
> 
> Yep, who argues?
> 
> My argument is that specifically in "git branch" it could be universally
> interpreted as noun, but can't universally be interpreted as verb, so
> /for me/ it's noun there.

Yeah, but universal interpretation is not part of human language.
Context is always relevant.

Sometimes it can be a verb.

> >> > I agree, and I did have indeed noticed the inconsistency. But there's
> >> > another category of commands that receive subcommands, like:
> >> >
> >> >   git remote $subcommand
> >> >   git worktree $subcommand
> >> >   git bisect $subcommand
> >> >
> >> > In my opinion `git branch` fits more these subcommand commands, and it
> >> > was a mistake to make the subcommands options, it should be:
> >> >
> >> >   git branch list
> >> >   git branch new
> >> >   git branch set-upstream
> >> >   git branch move
> >> >   ...
> >> >
> >> > Now the verb is crystal-clear.
> >> 
> >> Yes, lacking (assumed) subcommands is yet another dimension of
> >> inconsistencies.
> >> 
> >> I mean what I'm after is inconsistency of the first argument to "git".
> >> It's being the verb more often is where we currently are, at least when
> >> considering "primary" commands that "git help" outputs. 
> >> 
> >> I mean, consider:
> >> 
> >>    git branch new nice-feature
> >> 
> >> vs
> >> 
> >>    git new branch nice-feature
> >> 
> >> It should have been the latter, when in fact it's currently the
> >> [reduced] former.
> >
> > I disagree. I prefer the former.
> 
>      git create branch "nice-feature"
> 
> Almost plain human language. Isn't it nice?

But I'm not talking to a human. If I wast talking to a human I would say
"create a branch called X", and "with git" would be implied.

But there's no "create" binary on my system. Why would there be? I've
been using Linux systems for more than 20 years, I know that if I want
to do something with vim, I have to start the command with 'vim'.

> > Even standardizing `git branch` would be an almost-impossible task, even
> > if we manage to convince others. `git new branch` even more
> > impossible.
> 
> Quite an opposite. In fact it's easier to add new ways of doing things
> that, provided they prove being useful, eventually obsolete and replace
> old ways. "git switch" and "git restore" are recent examples of that.

That's what *should* be the case, but this discussion proves that even
experimental commands (which are clearly demarcated as experimental) are
hard to change.

Moreover, keep in mind that the person who managed to introduce both
`git switch` and `git resotre` already left the project. That should
give you a pretty good idea of how much faith he has on these commands
eventually being useful.

Sure, at this point in time introducing `git branch new` might be
impossible, however, `git branch --new` isn't. And if we agree on what
should have been the case for `git branch`, then what should be the case
for `git switch` is more attainable.

Cheers.

-- 
Felipe Contreras
