Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1531CC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 09:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjECJLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 05:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjECJLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 05:11:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B210558E
        for <git@vger.kernel.org>; Wed,  3 May 2023 02:10:32 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-61b72fd8cc0so3163146d6.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683104987; x=1685696987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mta/mUHuuNafAc6dhp602I5UuV6R6kq8vDeAUgeNtRQ=;
        b=BVjiI+saQ5vR5vRHp5lZF5Q1kJddG2tE3Z5t2ifJVaPt5C5mvk/uR8UnhAIwVK39W6
         GzviaTXMub7oFmA9jNIK9qAn/u4COYXrYkkjQ5EFn9hmTlv2pmurQrmpCONbmKe0k5j1
         KskWS8cTXjI8Sy0rtgPlVN1BS+5fX7TjBF5AACSzg+isGZRt0ZHLQV4E/O65ZJzpVx7y
         0ESxMd8eE0aPte+tCtCSnGWgTEt6cN76cbQVsWXYSgm27HY/H4e3s6UKVisxnv03Ga2M
         2nESsvegAa53hArSu9h/PSKv/iCcb65zuRL78V7lOM0zEjO8lIpLHl8uUKjENeRrrC3O
         SnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104987; x=1685696987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mta/mUHuuNafAc6dhp602I5UuV6R6kq8vDeAUgeNtRQ=;
        b=FD80pq6AOKVPnnmDZUUNtf+PU0ajucdKO+CBLzvy8T+GxYeqN7M58MRuVCadiO2Cj9
         hDJN3NAqPVNhCC4ipaFIQ4o+aQuT4Al4MnxjOP6PXJj9+IhAmzxj4oVgO2ELfb9d/orb
         GqlKJ8GiOzou4NggAf48RXBUEpwERp5dch/MR+0pI4XyXkDDTm4Yjsy0zkKCPoZTMOLT
         n0xuJlmXMIR2iAkeV+/6fY6DJ8b8MUL+gEPANvxaa6mgYpixO4SKIqQbera8EIGG+GdE
         +uVrYBMFAbymidwCOqmtkv+7V+SS8Fvgr+0ui1OdPA1Wp0EZr219F39VjiOKA/fDZd0j
         5NZw==
X-Gm-Message-State: AC+VfDxQxkskaovx1BNvKGqICAzTZn+5tFRTYj2fxY1caa2zCVFackp+
        /woNG/icgC/fn430NxcoCmqNjJK5blZ0jwzBvAfPSqvJWyoUZg==
X-Google-Smtp-Source: ACHHUZ5Mmpti5F+q/jZAjXFabdw1pIUiUsbgB/lqijP1TfDIZlGDbRNz9Fz4OMjkr92nDBZpaIbG41sYc7PA9tempCI=
X-Received: by 2002:ad4:5ae2:0:b0:5f1:606b:a9c4 with SMTP id
 c2-20020ad45ae2000000b005f1606ba9c4mr12025140qvh.24.1683104986685; Wed, 03
 May 2023 02:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net> <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g> <20230427054343.GE982277@coredump.intra.peff.net>
 <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
In-Reply-To: <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 3 May 2023 11:09:35 +0200
Message-ID: <CANgJU+UasufF7-B8ukEMm_Lv8gu4wUpaVKa9AOBacDHJvi7fxQ@mail.gmail.com>
Subject: Re: Is GIT_DEFAULT_HASH flawed?
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 3 May 2023 at 02:17, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Hi,
>
> Changing the subject as this message seems like a different topic.
>
> Jeff King wrote:
> > On Wed, Apr 26, 2023 at 02:33:30PM -0700, Junio C Hamano wrote:
> > > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > >
> > > >  `GIT_DEFAULT_HASH`::
> > > >   If this variable is set, the default hash algorithm for new
> > > >   repositories will be set to this value. This value is currently
> > > > + ignored when cloning if the remote value can be definitively
> > > > + determined; the setting of the remote repository is used
> > > > + instead. The value is honored if the remote repository's
> > > > + algorithm cannot be determined, such as some cases when
> > > > + the remote repository is empty. The default is "sha1".
> > > > + THIS VARIABLE IS EXPERIMENTAL! See `--object-format`
> > > > + in linkgit:git-init[1].
> > >
> > > We'd need to evantually cover all the transports (and non-transport
> > > like the "--local" optimization) so that the object-format and other
> > > choices are communicated from the origin to a new clone anyway, so
> > > this extra complexity "until X is fixed, it behaves this way, but
> > > otherwise the variable is read in the meantime" may be a disservice
> > > to the end users, even though it may make it easier in the shorter
> > > term for maintainers of programs that rely on the buggy "git clone"
> > > that partially honored this environment variable.
> > >
> > > In short, I am still not convinced that the above is a good design
> > > choice in the longer term.
> >
> > I also think it is working against the backwards-compatible design of
> > the hash function transition.
>
> To be honest this whole approach seems to be completely flawed to me and
> against the whole design of git in the first place.
>
> In a recent email Linus Torvalds explained why object ids were
> calculated based {type, size, data} [1], and he explained very clearly
> that two objects with exactly the same data are not supposed to have the
> same id if the type is different.

He said:

--- quote-begin ---
The "no aliasing" means that no two distinct pointers can point to the
same data. So a tagged pointer of type "commit" can not point to the
same object as a tagged pointer of type "blob". They are distinct
pointers, even if (maybe) the commit object encoding ends up then
being identical to a blob object.
--- quote-end ---

As far as I could tell he didn't really explain *why* he wanted this,
and IMO it is non-obvious why he would care if a blob and a commit had
the same text, and thus the same ID. He just said he didnt want it to
happen, not why. I can imagine some aesthetic reasons why you might
want to ensure that no blob has the same ID as a commit, and I can
imagine it might make debugging easier at certain points, but it seems
unnecessary given the data is write once.

> If even the tiniest change such as adding a period to a commit messange
> changes the object id (and thus semantically makes it a different
> object), then it makes sense that changing the type of an object also
> changes the object id (and thus it's also a different object).
>
> And because the id of the parent is included in the content of every
> commit, the top-level id ensures the integrity of the whole graph.
>
> But then comes this notion that the hash algorithm is a property of the
> repository, and not part of the object storage, which means changing the
> whole hash algorithm of a repository is considered less of a change than
> adding a period to the commit message, worse: not a change at all.

I really dont understand why you think having two hash functions
producing different results for the same data is comparable to a
single hash producing different results for different data. In one
case you have two different continuum of identifiers, with one ID per
continuum, and in the other you have two different identifiers in the
same continuum, and  if you a continuum you would have 4 different
identifiers right? Eg, the two cases are really quite different at a
fundamental level.

> I am reminded of the warning Sam Smith gave to the Git project [2] which
> seemed to be unheard, but the notion of cryptographic algorithm agility
> makes complete sense to me.
>
> In my view one repository should be able to have part SHA-1 history,
> part SHA3-256 history, and part BLAKE2b history.

Isn't this orthagonal to your other points?

> Changing the hash algorithm of one commit should change the object id of
> that commit, and thus make it semantically a different commit.
>
> In other words: an object of type "blob" should never be confused with
> an object of type "blob:sha-256", even if the content is exactly the
> same.

This doesn't make sense to me.  As long as we can distinguish the
hashes produced by the different hash functions in use we can create a
mapping of the data that is hashed such that we have a 1:1 mapping of
identifiers of each type at which point it really doesn't matter which
hash function is used.

> The fact that apparently it's so easy to clone a repository with
> the wrong hash algorithm should give developers pause, as it means the
> whole point of using cryptographic hash algorithms to ensure the
> integrity of the commit history is completely gone.

This is a leap too far. The fact that it is "so easy to clone a repo
with the wrong hash algorithm" is completely orthogonal to the
fundamental principles of hash identifiers from strong hash functions.
You seem to be deriving grand conclusions from what sounds to me like
a simple bug/design-oversight.

> I have not been following the SHA-1 -> OID discussions, but I
> distinctively recall Linus Torvalds mentioning that the choice of using
> SHA-1 wasn't even for security purposes, it was to ensure integrity.
> When I do a `git fetch` as long as the new commits have the same SHA-1
> as parent as the SHA-1s I have in my repository I can be relatively
> certain the repository has not been tampered with. Which means that if I
> do a `git fetch` that suddenly brings SHA-256 commits, some of them must
> have SHA-1 parents that match the ones I currently have. Otherwise how
> do I know it's the same history?

So consider what /could/ happen here. You fetch a commit which uses
SHA-256 into a repo where all of your local commits use SHA-1. The
commit you fetched says its parent is some SHA-256 ID you don't know
about as all your ID's are SHA-1. So git then could go and construct
an index, hashing each item using SHA-256 instead of SHA-1, and using
the result to build a bi-directional mapping from SHA-1 to SHA-256 and
back.  All it has to do then is look into the mapping to find if the
SHA-256 parent id is present in your repo. If it is then you know it's
the same history.

The key point here is that if you ignore SHAttered artifacts (which
seems reasonable as you can detect the attack during hashing)  you can
build a 1:1 map of SHA-1 and SHA-256 ids.  Once you have that mapping
it doesn't matter which ID is used.

> Maybe that's one of the reasons people don't seem particularly eager to
> move away from SHA-1:

Maybe, but it doesn't make sense to me.  You seem to be putting undue
weight on an unnecessary aspect of the git design: there doesn't seem
to be a reason for Linuses "no aliasing" policy, and it seems like one
could build a git-a-like without it without suffering any significant
penalties. Regardless, provided that the hash functions allow a 1:1
mapping of ID's (which is assumed by using "collision free hash
functions"), it seems like it really doesn't matter which hash is used
at any given time.

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
