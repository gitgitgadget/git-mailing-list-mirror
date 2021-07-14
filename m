Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0EDC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6505D613AF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhGNQdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGNQdc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:33:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D521C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 09:30:40 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t143so2903178oie.8
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lbUWQJx4ZSJWhqbe+Y96Kfh3pkH2lBt504qS2XUuRfE=;
        b=EbjGZKNitYjdRP+u02z2thgcPp1VFxv8+A2vGua23PKMzRFD1I8Oc7rBYiOgs/WgLd
         HAdreWYoZdIqYj/G9bsDHtQOVkhHlI+7/htvguXoLeEXtWJsFoitLbBHYis+SXqCxbsP
         wXt8hrjvWigM5bm66Lp4ZiXvwDxHCMZiJjSIWflg3tYKHoKcDltjTFzHhbpWde27vKwM
         9urrVWz4HupBY7cTJI1U2ksJhfjwIS1pbGwIjxSyc9pw0z+bKj+eWW8mMDLs/GfM714i
         tVob14IG2OgTZ0YkyBiV4b1oKcMPbZlwJABNj8X55jnBwOZfRQzsn02cOhvSF4COalIR
         0KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lbUWQJx4ZSJWhqbe+Y96Kfh3pkH2lBt504qS2XUuRfE=;
        b=qB3siCR1oZnoeqjrB/TSxpr0nEwPtez947D3800ypkpu9TL5RtkUufzv+Kzb0mlqAJ
         DKDy2XZAcdJyjYuvD1b+cDjvBCbVUTzOqMKFi5/+EqmdChL0rLe3/csST+Lh2focMzq+
         dXq5aEPhRhY3zRqp6iHnwlnt5yBaq09nVAxUeIq0z26wStQEFmKmiScpf/umNw7cbGD0
         h1HWPmF5i9E/+jy9IcASpmIAjLfZF0vPKYDtfyPvQrkKkrxmJWe88z8llNxJMEO5Brrq
         QIy6YpDV7Mi1Xja2/2ek44YW+sBnoqUOIXwupchpq2UN27TExkieeKRD0C21q6DOrTj4
         znjg==
X-Gm-Message-State: AOAM531iIPScnQuRNtSB6UeNU6eTV3EdzCqMCAWS5FE3CNvJHE1ksOIM
        RbVEAyNjHFX8IAQRaIWxF/ZLS4eOZaC6PQwg7Rw=
X-Google-Smtp-Source: ABdhPJwGOfi+MOKmDgnsmcW1/HY/p9BIHb7p12n5FAaheSHrQhd+Ya0C6a2OQ39lhOULfi+Xtl32m5opLfzpqJ/AVZE=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr3445119oie.167.1626280239364;
 Wed, 14 Jul 2021 09:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com> <4046993a9a2af79029c1ce94d20616831e94d786.1626225154.git.gitgitgadget@gmail.com>
 <87tukx1gmi.fsf@evledraar.gmail.com>
In-Reply-To: <87tukx1gmi.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 09:30:28 -0700
Message-ID: <CABPp-BHq5hYRa0eT1JcWedadw2O=uC=5v9FdM2gH+EgMeufEqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] doc: clarify documentation for rename/copy limits
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 12:47 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Jul 14 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
...
> > diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.=
txt
> > index 2d3331f55c2..e26a63d0d42 100644
> > --- a/Documentation/config/diff.txt
> > +++ b/Documentation/config/diff.txt
> > @@ -118,9 +118,10 @@ diff.orderFile::
> >       relative to the top of the working tree.
> >
> >  diff.renameLimit::
> > -     The number of files to consider when performing the copy/rename
> > -     detection; equivalent to the 'git diff' option `-l`. This setting
> > -     has no effect if rename detection is turned off.
> > +     The number of files to consider in the exhaustive portion of
> > +     copy/rename detection; equivalent to the 'git diff' option
> > +     `-l`.  If not set, the default value is 400.  This setting has
> > +     no effect if rename detection is turned off.
>
> For both this...
>
> >  diff.renames::
> >       Whether and how Git detects renames.  If set to "false",
> > diff --git a/Documentation/config/merge.txt b/Documentation/config/merg=
e.txt
> > index 6b66c83eabe..aca0c92dbe6 100644
> > --- a/Documentation/config/merge.txt
> > +++ b/Documentation/config/merge.txt
> > @@ -33,10 +33,12 @@ merge.verifySignatures::
> >  include::fmt-merge-msg.txt[]
> >
> >  merge.renameLimit::
> > -     The number of files to consider when performing rename detection
> > -     during a merge; if not specified, defaults to the value of
> > -     diff.renameLimit. This setting has no effect if rename detection
> > -     is turned off.
> > +     The number of files to consider in the exhaustive portion of
> > +     rename detection during a merge.  If not specified, defaults
> > +     to the value of diff.renameLimit.  If neither
> > +     merge.renameLimit nor diff.renameLimit are specified, defaults
> > +     to 1000.  This setting has no effect if rename detection is
> > +     turned off.
>
> ...and this we should really have some wording to the effect of:
>
>     ..., defaults to XYZ. The exact (or even approximate) default of XYZ
>     should not be relied upon, and may be changed (or these limits even
>     removed) in future versions of git.
>
> I.e. let's distinguish a "this is how it works now, FYI" from a forward
> promise that it's going to work like that forever.

Perhaps I could simplify that to "...currently defaults to XYZ"?  Does
that capture your intent well enough?

I agree very much that this shouldn't be a hard promise.  If it was,
we've broken it repeatedly over the years.  Not only have we modified
the default numbers multiple times, there have also been multiple
times when we've been able to change how many renames could be handled
without changing the default numbers for the rename limits.  (This was
done by adding or improving special cases that allow us to exclude
paths from the exhaustive comparison; exact rename detection that
someone else added and my more recent improvements to exact rename
detection are two simple examples).

> Which also leads me to:
>
> >  merge.renames::
> >       Whether Git detects renames.  If set to "false", rename detection
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> > index 32e6dee5ac3..11e08c3fd36 100644
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -588,11 +588,12 @@ When used together with `-B`, omit also the preim=
age in the deletion part
> >  of a delete/create pair.
> >
> >  -l<num>::
> > -     The `-M` and `-C` options require O(n^2) processing time where n
> > -     is the number of potential rename/copy targets.  This
> > -     option prevents rename/copy detection from running if
> > +     The `-M` and `-C` options have an exhaustive portion that
> > +     requires O(n^2) processing time where n is the number of
> > +     potential rename/copy targets.  This option prevents the
> > +     exhaustive portion of rename/copy detection from running if
> >       the number of rename/copy targets exceeds the specified
> > -     number.
> > +     number.  Defaults to diff.renameLimit.
>
> This mention of O(n^2). This is not an issue with your patch/series, nd
> this is an improvement.
>
> But as a side-comment: Do we explain somewhere how exactly this
> {diff,merge}.renmeLimit=3DN works for values of N? It's probably fine to
> continue to handwave it away, but is there anything that say tells a
> user what happens if they have 400 files in their repository in a "x"
> directory and "git mv x y"? Will it work, but if they add a 401th file
> it won't for diffs?
>
> I *think* given a skimming of previous discussions that it's "no",
> i.e. that this just kicks in for these expensive cases, and e.g. for
> such a case of moving the same tree OID from "x" to "y" we'd
> short-circuit things, but maybe I'm just making things up at this point.

Tree OIDs aren't used by the rename detection logic, but you're close.

> Feel free to ignore me here, I guess this amounts to a request that it
> would be great if we could point to some docs about how this works. It's
> probably too much detail for Documentation/config/{merge,diff}.txt, so
> maybe a section in either of git-{diff,merge}.txt ?

If git-merge.txt includes it, then rebase, cherry-pick, revert
probably should too.  (and maybe the -3 option of git-am)

Anyway...

In the "git mv dir-x dir-y" case, if no other changes are made to
those files, then the renames would be detectable via blobs having the
same hashes (i.e. exact renames).  So all these renames would be found
regardless of the number of files and without exhaustive detection
even kicking in.

If there were thousands of such files, and every one of them were also
modified, then the basename-guided rename detection which operates in
linear time would still find all the renames, without the exhaustive
detection even kicking in (see commits bd24aa2f97a0 (diffcore-rename:
guide inexact rename detection based on basenames, 2021-02-14) and
37a251436447 (diffcore-rename: use directory rename guided basename
comparisons, 2021-02-27)).

If this were a merge, and there were thousands of such files renamed
and modified, AND they were all further renamed to change their
basename, BUT the original directory was unmodified on the other side
of history, then we wouldn't need any of the renames for the purposes
of the merge and they'd all be excluded from the exhaustive rename
detection.  Sure, we wouldn't find renames for those files, but that
wouldn't change the result of the merge.  So, again, no exhaustive
rename detection.  (See commit 174791f0fb23 (merge-ort: use
relevant_sources to filter possible rename sources, 2021-03-11))

(Rebases & cherry-picks also have an advantage of caching renames from
previous picks on the upstream side of history to avoid needing to
re-detect renames on that side...though it only caches renames that
are either relevant or exact.)

Basically, we bail on exhaustive rename detection if, after the linear
or faster steps have run (excluding previously cached renames, exact
rename detection, skipping irrelevant renames, basename guided rename
detection), the number of remaining unpaired source files times the
number of remaining unpaired destination files is greater than
rename_limit * rename_limit.  (If we can assume the numbers match,
i.e. N =3D number of remaining unpaired sources =3D number of remaining
unpaired destinations, then that check simplifies to bailing once N >
rename_limit)


I'm not sure if these details are really going to help the users,
especially if more special cases are added (and more have been
proposed by Johannes and became an Outreachy project, though that one
didn't get off the ground).  And this explanation is not even fully
detailed; I'm still hand waving here in at least four different ways
(mostly in ignoring special cases for different fast steps, but also
by ignoring copy detection that itself messes with the explanation in
multiple ways).

But maybe someone else can figure out a way to hand wave my hand
waving down to a simple enough explanation, while also covering copy
detection, and managing to do so in a way that doesn't mislead.  If
so, we can include that in the docs somewhere.
