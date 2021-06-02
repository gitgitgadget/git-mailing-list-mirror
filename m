Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1091AC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 05:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E379D61376
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 05:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFBFz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhFBFz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 01:55:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3CC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 22:54:10 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id a21so1663005oiw.3
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 22:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnLQ6QU6Z5Cb9pelWnO1sID+7WjF6D4FoPi7tarIf1o=;
        b=LTw8MGEnQt8dmEXjyLoLSTaS3/VK3EYHm9torsVRw+TZb+LAKVC3LkshseO6zv5/NR
         Zi7MmG2sD//WFuH6mZUXjAQX63s5niTRQbFyy+lwvKxbN/jVCTMbX5bn9M0yE2wDN+R+
         yTSTm3N6lFwsXX7tXbMwBR5YDbQy5UtQNv3VAFRTm+Wh5Fd6pJ4XjuCWVmxSbyKsW1d2
         RqweFJEC7AVEojOC53qje2VBShSOfaW1QUqoMUnMD4AFyrGVKMP6FuRny8FhDbg8kDo5
         hGVFuUIqcMfIhzhDHYPNdG64Af3TcRsO0v/VMdcKIN+zFsfAXIr7m0blrI5Php1sJdM0
         WF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnLQ6QU6Z5Cb9pelWnO1sID+7WjF6D4FoPi7tarIf1o=;
        b=Czm9zid1IHRJYOYowt10p3Otqf9Y+itcfyCYFCecyuxbD3NvCnnu730mG6y4t2i2pc
         A3PVQ+Fh6mc71TkDWg039pmzykM2X1bhY3nVHYzX+NEycLy7XTtHQCFB8q82Yr1+TJbJ
         h4hOVuY/Mbq/opyVEB+pJzbq7+Oh243e7xEuKYhK0qWMzMfCY6CXdcKl+HL/SJfn/2PQ
         /NlKAoiaWm6sGbiSsYTwcs35LrgyFzGFEX0drlinwey4M6odP53tO8uk39zVaBz8wH5k
         u43evFy3e/t2A2pyqX/aNJr+wQDivsmRqp742ksxpYPJK4Ymdy6pM7FGCNtUXdfpMy1/
         yaig==
X-Gm-Message-State: AOAM531ToXkvOgegHvdTr5nXtkKU+pK/JSn7rdDGbO4+rS/2ISxmcvvL
        QivI1ohaeclgUB5qggt1OfCw5di9FO3PxFS/fBQ=
X-Google-Smtp-Source: ABdhPJwtdVd4hFIL18c6VcPVfj3d2s59B1lKKuDqY22SFFLO9Srun/I55pRlM8Tj/u1wv29GxtXUSRWXgCTg7pu6b1U=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr20604994oiw.31.1622613249988;
 Tue, 01 Jun 2021 22:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210601183106.3084008-1-tpr.ll@botech.co.uk> <f6d39636-308c-c846-55b5-3f16a155e69d@gmail.com>
 <xmqqmts9q9m2.fsf@gitster.g>
In-Reply-To: <xmqqmts9q9m2.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Jun 2021 22:53:58 -0700
Message-ID: <CABPp-BHs0ACvkCJMB-tO8xkiidB12NrN1hOhLRvm3U_Q=r2YcQ@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: add core.sparseCheckoutRmFiles config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Tim Renouf <tpr.ll@botech.co.uk>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick and Junio already made some really good points, I'll just try
to add a few comments.

On Tue, Jun 1, 2021 at 7:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> >> This commit adds the above config item, defaulting to "true" to get the
> >> old behavior. Set it to "false" to avoid removing such a file from the
> >> worktree.
> >
> > I don't think config is necessary here. This behavior is niche
> > enough to create a behavior-breaking change. However, we do want
> > to ensure that the full flow of eventually clearing the file when
> > clean is handled.
>
> I didn't have a chance to get around to commenting on the patch
> (instead I was preparing for -rc3), but you covered pretty much
> everything I wanted to say.  It is unusual for those who are using
> sparse checkout to have a modified (=tracked and dirty) file that
> shouldn't be there, and making sure the user notices these unusual
> files, instead of silently losing the changes to them, is probably a
> "bugfix".
>
> An explicit request to destructively overwrite the path ("git
> restore -- path") or remove the working tree file along with
> modification ("git reset --hard") is a good thing to have, but
> the branch switching "git switch" is supposed to preserve local
> modification (or fail to switch), whether the dirty path is inside
> or outside the sparse checkout area.

Yes, I think this is the best phrasing of the bug.  Since
SKIP_WORKTREE was originally implemented as "assume file contents
match HEAD" (which is sometimes a reasonable first approximation to
the intended behavior, but which keeps leading us astray into bad
behavior), it's pretty easy to see what's likely happening here:
unpack-trees.c is almost certainly just assuming that the file
contents match HEAD and not even bothering to verify that assumption
before deleting the file.  We should make it verify when a file is
SKIP_WORKTREE.

> > If we _are_ going to go with a config option, then I'm not a big
> > fan of this name. I've also been thinking that the sparse-checkout
> > config has been squatting in the "core.*" space too long. Perhaps
> > it is time to create its own section?
> >
> > What about something like sparseCheckout.keepDirtyFiles, which
> > defaults to false?
>
> What about not having a configuration?

I agree; we all concur that the reported behavior is a bug; adding a
config option to turn a bug off for some people just doesn't make any
sense.  Let's fix the bug instead.

I'm also worried that making a config option may have masked subtle
bugs in the patch that the rest of the testsuite would have turned up.

> > 1. How does a user with a dirty, tracked, sparse file get back
> >    into a state where that file is deleted? What commands do
> >    they need to run? Can that be tested and added to the sparse-
> >    checkout documentation?

Yeah, I've wondered if 'git sparse-checkout reapply' should do
something special here...or whether additional subcommands might be
needed.  I'm still not quite sure.

> > 2. What does 'git status' look like when a user is in this state?
> >    Is that helpful?

I'm worried that trying to make 'git status' report these files would
be expensive and defeat some of the advantages of a sparse-checkout.
Even in cone mode, and even if we could just stat the leading
directories to see they aren't there, would we still end up iterating
over all the index entries just to verify that their leading directory
is missing so we don't have to stat it?

Whereas checkout, if it might end up deleting something, it makes
perfect sense to pay the cost of a stat at that point and throw an
error message and abort if things aren't clean.
