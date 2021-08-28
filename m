Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF287C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B607960EBC
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhH1FW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 01:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhH1FW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 01:22:27 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B42C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 22:21:37 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso10735303ota.8
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 22:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OocbeH9YmBIc8QGbiK/UW3HUrWtbAxcpGSrPioNE79s=;
        b=PESfoXKgmFV7oI6Flk7n5uuKZJS+DzW2BvjTwHJ/yPQbzcSNi4sEn3iDD4L6uyngmj
         Xwud5PamhqPa5RTI5vv/YQTUfMrJhSxu6hF4pOWKnKsj8b3RGkPXnAQxnie/naHDVp/U
         o2JZm8U9rVpWOZDYi+CjbWXo7SZWlaIRJ+bQQY8rEJXQWrTRGzmfwe5Rl7B5UxM4Dm/z
         sR0JqaSyP4mfi6rgNBxbyZu/dU9zqX6sGymPq2tufbt7Y5rU/rgGuK/IDRYx5xNRAbMS
         Njfd2VuuARIrmmLYQVnq4a7zGqjy6wCQ5TdgGhzEweU3rpPothY+Add7BRo0OIN8Cz8l
         yL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OocbeH9YmBIc8QGbiK/UW3HUrWtbAxcpGSrPioNE79s=;
        b=Ajj3PB8GQRP4Nrk4k+2dILojLEm47TEPz+mPhpZFNZD7bLNxNhT3xYZByKRk6mS0v7
         fSm4tlaN9BXtdWHRG43aHGTcMjst15G9fZqnREa1t434vfceK72pN4dxfHkrjvDXXE2a
         +i0OdXz2iraMT2QK7T76kzpm62LU/V/y9HI01DKa3AxqQoNaEKe14wQqHArniHrlBCok
         j/0cd9+vCkqyUPt0S7a/clotOnnHxleaUMOqxx2OjrKEgBaQEI54dl2MCo3EHNT6Dd23
         rtbiE9daPn5qonOaZ9Nc7gdNdWvh3zNd48WX8+83+IZcvbe1ha7VgyIXX5aieMMBL6oA
         RbZA==
X-Gm-Message-State: AOAM5311RZDwVAdKtiJUifUji8hAzDNHsJ24y4RE0ZNotZMk1sz44UON
        i8bmoMCUmve2oUpQLd8EefBnM/0BZP+FAPpwsBhY9Ig9q5F3JQ==
X-Google-Smtp-Source: ABdhPJwlopSlMT+1e8UwYgfo2jOPd7YhmX0XuKlHbQribnqGRVZkNLQsGodlNN5KdWTS5+hfHj/E1yVUiB60tvH872U=
X-Received: by 2002:a9d:7cc3:: with SMTP id r3mr11083033otn.345.1630128096151;
 Fri, 27 Aug 2021 22:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com>
 <YSWXSWiDWNU93lhC@coredump.intra.peff.net> <CABPp-BEMXW3EOdT4jt1g63uPyZ5YuKUPfBE9BL=E66QcT5uXXA@mail.gmail.com>
 <xmqqzgt5gr3g.fsf@gitster.g> <YSg6dshmB5JA7KZO@coredump.intra.peff.net>
In-Reply-To: <YSg6dshmB5JA7KZO@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 22:21:25 -0700
Message-ID: <CABPp-BEt=wBMZHP1P+sy1+GPhEgynu-RoUs2ZC7ZuWspfCsTVQ@mail.gmail.com>
Subject: Re: 'git pull' complains that a locally resurrected directory would
 be overwritten by merge when no pulled changes are affecting that directory
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Yuri <yuri@rawbw.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 6:05 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 25, 2021 at 02:19:15PM -0700, Junio C Hamano wrote:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > ... allow if the incoming changes don't touch the same files), but
> > > local *staged* changes.  As per the merge manpage:
> > >
> > > """
> > > To avoid recording unrelated changes in the merge commit, git pull and
> > > git merge will also abort if there are any changes registered in the
> > > index relative to the HEAD commit.
> > > """
> > >
> > > While this particular example could theoretically be handled by the
> > > merge machinery without requiring the index match HEAD,...
> >
> > While I do not mind seeing a patch that loosens the condition ONLY
> > when the merge will cleanly auto-resolve without end-user
> > interaction, when any paths conflict and require editing by the
> > end-user, it is pretty much essential to require that the index
> > matches HEAD to keep "git merge" usable.
> >
> > This is because the final step to conclude such an "automated
> > procedure cannot cleanly resolve, so the end user helps resolving
> > with the editor and mark the resolved paths with 'git add' or 'git
> > rm'" session will become very error prone if we did not have the
> > requirement.  Not just the user MUST remember not to use "commit -a"
> > or "git add" a path that was already dirty in the working tree
> > before the merge started (which is the consequence of the current
> > requirement, which allows local changes to the unrelated working
> > tree files), they must MUST remember to somehow EXCLUDE the changes
> > already registered for unrelted paths from the concluded merge.
>
> Good point.
>
> In theory we could reject the merge only after finding that there were
> conflicts. That lets the happy path continue even with unrelated changes
> (just like a fast-forward does). I suspect we'd need to change the
> interface to the merge-backends, though (to say "do the merge, and bail
> on conflicts, but _don't_ write out conflict markers or touch any other
> state in that case").

We actually wouldn't need to change the interface.  One of the reasons
there were so many annoying bugs with index != HEAD, was that
builtin/merge.c stated that the merge backends were responsible for
enforcing that condition.  So every single merge backend had to be
individually fixed -- ours, octopus, resolve, recursive.  And then
some of those, like recursive, had multiple affected code paths, and
each one had to be fixed, and I didn't catch them all the first time.

That doesn't mean I'm in favor of the change, just pointing out that
one backend could decide to do this on its own even if the other
backends didn't support it.

> (I am just thinking out loud, though. My personal opinion is that if you
> have a bunch of staged changes and want to do any non-trivial merging,
> you should considering committing or stashing those changes).

Agreed.

Though perhaps I should have pointed out to Yuri that he wouldn't have
run into these problems if he would have used
    git restore --source={hash}~1 -- math/polymake
instead of
    git checkout {hash}~1 -- math/polymake

(since the former defaults to updating just the working directory,
while the later updates both the index and the working directory.)
