Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D29C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 22:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiCVWD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 18:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiCVWD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 18:03:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46248E0A5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 15:02:28 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i12so9026098ilu.5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TvHNL6tyy20yQGhg67FMU+m4+/2vqFvmdNCIzgDcya0=;
        b=i8hErmGAYEMVnBAv2OLdXkqbxvv5lLpxgi1Rb03+bIYQN+V/i0WKax/4lYWdcWrVUj
         IWpnXEob5b7mfBtn5esFUtsHl+tBGVscZrFAu5PQHpzEK9fKBCG3Ht/w3zqc9KpJpY+c
         1QMS8R0KizS4Jet5WqX+2/i29hbHO39EugnsDpfkjSGnvMZGK599oufgOftM4za6mfEm
         MPnS3yMVFqWOMbVf708uNnNsGsISCF8hWq9MsSdclTEXUe6wzwdfmuOJ5BaquJD787ig
         GUT0hG5krfmj4/RG9zQHfN5hA3xchPcJeQx/XGLuzLAcVgij/63xc09RbDidPihlenf1
         QC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TvHNL6tyy20yQGhg67FMU+m4+/2vqFvmdNCIzgDcya0=;
        b=TRAKATDTslElILeNjCpG4Q21sjJ8niF7H7SvWWSIa4Vh01aEA16wog4yOJAwRzgCmx
         VIy9lRddja6ZsQQS51dCjmOq9A+O+U1vQrry9frAXaIzBr+Vr1VL40EjJImQhmU3KjX2
         6KnRIbQTaF5/k7vSPHSB5E6evppfv9YlF4A5612Hl2M7H410hwFsHDqyJjpp8LuOWF/P
         BxCFXim5t0iyVE8NzCT6hsjnTPxi43/D9svoPaP0GivVdriixYTyAEttxEvogBsZ1rDE
         zZ8XLfbOntzczwnOvDVePv6tlegBFuMMryWf0cOzjoO5eu3Ju6ofhAOQt6xKjZ3H85UG
         niug==
X-Gm-Message-State: AOAM533u6AKIUuTsb5t7ernCLYomGu6ZA1CrHWoYu79wupotiouF0qer
        RKdxD/aXEYo+4y2egVghXuVFFw==
X-Google-Smtp-Source: ABdhPJxRINcbR31aWgsNmq5MS8GONLwguVWUHN7Sb8G+vqkTCFqQYMQeSg8ZQdLr+7c0zVYmvU36GA==
X-Received: by 2002:a05:6e02:1bc9:b0:2c8:2b30:dcb6 with SMTP id x9-20020a056e021bc900b002c82b30dcb6mr5383481ilv.282.1647986547545;
        Tue, 22 Mar 2022 15:02:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g5-20020a05660203c500b006463f6dd453sm11781731iov.34.2022.03.22.15.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 15:02:27 -0700 (PDT)
Date:   Tue, 22 Mar 2022 18:02:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, tytso@mit.edu,
        derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YjpHbaBspUasDdEy@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
 <YiZI99yeijQe5Jaq@google.com>
 <YjkjaH61dMLHXr0d@nand.local>
 <YjpDbHmKY9XA2p0K@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjpDbHmKY9XA2p0K@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 22, 2022 at 02:45:16PM -0700, Jonathan Nieder wrote:
> Hi,
>
> Taylor Blau wrote:
> > On Mon, Mar 07, 2022 at 10:03:35AM -0800, Jonathan Nieder wrote:
>
> >> Sorry for the very slow review!  I've mentioned a few times that this
> >> overlaps in interesting ways with the gc mechanism described in
> >> hash-function-transition.txt, so I'd like to compare and see how they
> >> interact.
> >
> > Sorry for my equally-slow reply ;). I was on vacation last week and
> > wasn't following the list closely.
>
> No problem --- thanks for getting back to me.
>
> [...]
> > (After re-reading what you wrote and my response, I think we are saying
> > the exact same thing, but it doesn't hurt to think aloud).
>
> Great.  Can the doc cover this?  I think it would be helpful to make
> that easy to find for others with similar questions.

I believe the doc covers this already, see the paragraph beginning with
"Unreachable objects aren't removed immediately...".

> >> Can this doc say a little about how "git prune" handles these files?
> >> In particular, does a non cruft pack aware copy of Git (or JGit,
> >> libgit2, etc) do the right thing or does it fight with this mechanism?
> >> If the latter, do we have a repository extension (extensions.*) to
> >> prevent that?
> >
> > I mentioned this in much more detail in [1], but the answer is that the
> > cruft pack looks like any other pack, it just happens to have another
> > metadata file (the .mtimes one) attached to it. So other implementations
> > of Git should treat it as they would any other pack. Like I mentioned in
> > [1], cruft packs were designed with the explicit goal of not requiring a
> > repository extension.
>
> Sorry, the above seems like it's answering a different question than I
> asked.  The doc in Documentation/technical/ seems like a natural place
> to describe what semantics the new .mtimes file has, and I didn't find
> that there.  Is there a different piece of documentation I should have
> been looking at?

Are you looking for a technical description of the mtimes file? If so,
there is a section in Documentation/technical/pack-format.txt (added in
"pack-mtimes: support reading .mtimes files") that explains this.

> Can you tell me a little more about why we would want _not_ to have a
> repository format extension?  To me, it seems like a fairly simple
> addition that would drastically reduce the cognitive overload for
> people considering making use of this feature.

There is no reason to prevent a pre-cruft packs version of Git from
reading/writing a repository that uses cruft packs, since the two
versions will still function as normal. Since there's no need to prevent
the old version from interacting with a repository that has cruft packs,
we wouldn't want to enforce an unnecessary boundary with an extension.

> [...]
> > The key advantage of cruft packs is that you can expire unreachable
> > objects in piecemeal while still retaining the benefit of being able to
> > de-duplicate cruft objects and store them packed against each other.
>
> Can you say a little more about this?  My experience with the similar
> feature in JGit is that it has been helpful to be able to expire a
> cruft pack altogether; since objects that became reachable around the
> same time get packed at the same time, it's not obvious to me what
> benefit this extra piecemeal capability brings.
>
> That doesn't mean the benefit doesn't exist, just that it seems like
> there's a piece of context I'm still missing.

Expiring objects in piecemeal is somewhat interesting, but I think I was
reaching a little too far when I said it was the "key benefit". It does
have some nice properties, like being able to store cruft objects as
deltas against other cruft objects which might get pruned at a different
time (though, of course, you'll need to re-delta them in the case you do
prune an object which is the base of another cruft object).

But the issue with having multiple cruft packs is that the semantics get
significantly more complicated. E.g., if you have an object represented
in multiple cruft packs, which mtime do you use? If you want to prune
it, you suddenly may have many packs you need to update and keep track
of.

> >>> +Notable alternatives to this design include:
> >>
> >> This doesn't mention the approach described in
> >> hash-function-transition.txt (and that's already implemented and has
> >> been in use for many years in JGit's DfsRepository).  Does that mean
> >> you aren't aware of it?
> >
> > Implementing the UNREACHABLE_GARBAGE concept from
> > hash-function-transition.txt in cruft pack-terms would be equivalent to
> > not writing the mtimes file at all. This follows from the fact that a
> > pre-cruft packs implementation of Git considers a packed object's mtime
> > to be the same as the pack it's contained in. (I'm deliberately
> > avoiding any details from the h-f-t document regarding re-writing
> > objects contained in a garbage pack here, since this is separate from
> > the pack structure itself (and could easily be implemented on top of
> > cruft packs)).
> >
> > So I'm not sure what the alternative we'd list would be, since it
> > removes the key feature of the design of cruft packs.
>
> Sorry, I don't understand this answer either.  Do you mean to say that
> JGit's DfsRepository does not in fact have a cruft packs like feature
> that is live in the wild?  Or that that feature is equivalent to not
> having such a feature?  Or something else?
>
> To be clear, I'm not trying to say that that's superior to what you've
> proposed here --- only that documenting the comparison would be
> useful.

I'm not familiar enough with JGit (or its DfsRepository class) to know
how to answer this. I was comparing cruft packs to the
UNREACHABLE_GARBAGE concept mentioned in the hash-function-transition
doc, and noting the differences there.

Thanks,
Taylor
