Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0589BC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30D6613C9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhGNW7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhGNW7T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:59:19 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF68C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:56:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s23so4252876oij.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rVHpYdYATCv/3BOjOyN+I21aX6hxyg5DfsURreQciro=;
        b=p0qU5/feBAr3ZX1oLMm1/1cH3OG3in6xEHW1J9EYdC19S3gNkIh0Pv7uT/BOJthDSG
         H6cQF3eNGMFMtNb/WFj5ITa81kGuzSDk6bOLScVgTxiLPeImWarsrnutCaLoPwxuE1uC
         Jjju6E44VhxogWEY2z20NZZPwi7AWMjYl4HDrfZ6xpoL3Ym51XjrXVYgUleccP12A+CW
         9HGUiruAQfHSW79NadQX6i6h17oIGlWQr3NjRCWhXZz2HMRxqPwx4Udcv/a3znuPV7sE
         5FZNjMldNe/S+t3SIZXDRLainCneCGTIZVQ7DoZXTnQnLuPAdFIGz3ygiJ8KzGDUnFFC
         rNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rVHpYdYATCv/3BOjOyN+I21aX6hxyg5DfsURreQciro=;
        b=scetbm5Kua0LEt/xzg9zFCIkrLi/eEFLqPOCvvKTSSOk3eNsj8YzbQ5LvWOxYwE7c8
         RwMK2SO8IxV81EjX8Zxt0/59SESL8KKn83ry4DWBahK3JgC7pZ821yc9ELmk3pQ8/OWA
         ENwXNNxyS0VtSCnAICSMzDINOktbmCtcCeUoS35Vv54PImfeOvviKFt7mCRKbkWjc7J0
         rh28nUOMuo54ETvSs/peJcyeBkBpM0S5N52AVn9CUOna3dLopPxCg9r6e1XKiBoZ3mTi
         K01xaAGcq4y9HC5pW4KMtMYwUkgPZ54xDKCTsC8xlySSVUxMyq94ROi/Ba74K0oxymVR
         kUMQ==
X-Gm-Message-State: AOAM532mZFO1GV4L291TmPBknLrZ3QVMk0rlgi/Rv2ONbfeYrXcVnfVl
        1qNc8C6QcJ9FtjBXg0/Y5Vi4o+DgQNuGqQ7vBfE=
X-Google-Smtp-Source: ABdhPJzaEV81qQIs60rsoBF53EFc9bAcEgguS452lXM1vc6mje1j4BSa1VQriJyAsTmHdaVM9KGqa9ACBjg+0EmnfgU=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr4569688oie.167.1626303385342;
 Wed, 14 Jul 2021 15:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com> <4046993a9a2af79029c1ce94d20616831e94d786.1626225154.git.gitgitgadget@gmail.com>
 <87tukx1gmi.fsf@evledraar.gmail.com> <CABPp-BHq5hYRa0eT1JcWedadw2O=uC=5v9FdM2gH+EgMeufEqQ@mail.gmail.com>
 <87mtqozg2q.fsf@evledraar.gmail.com>
In-Reply-To: <87mtqozg2q.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 15:56:14 -0700
Message-ID: <CABPp-BFiw2PA6qz0uSCPXoSY9HDNc1NuwCxUJBnLU00mACAFqg@mail.gmail.com>
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

On Wed, Jul 14, 2021 at 3:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Jul 14 2021, Elijah Newren wrote:
>
> > On Wed, Jul 14, 2021 at 12:47 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Wed, Jul 14 2021, Elijah Newren via GitGitGadget wrote:
> >>
...
> >> ...and this we should really have some wording to the effect of:
> >>
> >>     ..., defaults to XYZ. The exact (or even approximate) default of X=
YZ
> >>     should not be relied upon, and may be changed (or these limits eve=
n
> >>     removed) in future versions of git.
> >>
> >> I.e. let's distinguish a "this is how it works now, FYI" from a forwar=
d
> >> promise that it's going to work like that forever.
> >
> > Perhaps I could simplify that to "...currently defaults to XYZ"?  Does
> > that capture your intent well enough?
>
> Yes, and it's not as needlessly verbose :)

Cool, I'll include that change then.

> > I agree very much that this shouldn't be a hard promise.  If it was,
> > we've broken it repeatedly over the years.  Not only have we modified
> > the default numbers multiple times, there have also been multiple
> > times when we've been able to change how many renames could be handled
> > without changing the default numbers for the rename limits.  (This was
> > done by adding or improving special cases that allow us to exclude
> > paths from the exhaustive comparison; exact rename detection that
> > someone else added and my more recent improvements to exact rename
> > detection are two simple examples).
> >
> >> Which also leads me to:
> >>
> >> >  merge.renames::
> >> >       Whether Git detects renames.  If set to "false", rename detect=
ion
> >> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-opt=
ions.txt
> >> > index 32e6dee5ac3..11e08c3fd36 100644
> >> > --- a/Documentation/diff-options.txt
> >> > +++ b/Documentation/diff-options.txt
> >> > @@ -588,11 +588,12 @@ When used together with `-B`, omit also the pr=
eimage in the deletion part
> >> >  of a delete/create pair.
> >> >
> >> >  -l<num>::
> >> > -     The `-M` and `-C` options require O(n^2) processing time where=
 n
> >> > -     is the number of potential rename/copy targets.  This
> >> > -     option prevents rename/copy detection from running if
> >> > +     The `-M` and `-C` options have an exhaustive portion that
> >> > +     requires O(n^2) processing time where n is the number of
> >> > +     potential rename/copy targets.  This option prevents the
> >> > +     exhaustive portion of rename/copy detection from running if
> >> >       the number of rename/copy targets exceeds the specified
> >> > -     number.
> >> > +     number.  Defaults to diff.renameLimit.
> >>
> >> This mention of O(n^2). This is not an issue with your patch/series, n=
d
> >> this is an improvement.
> >>
> >> But as a side-comment: Do we explain somewhere how exactly this
> >> {diff,merge}.renmeLimit=3DN works for values of N? It's probably fine =
to
> >> continue to handwave it away, but is there anything that say tells a
> >> user what happens if they have 400 files in their repository in a "x"
> >> directory and "git mv x y"? Will it work, but if they add a 401th file
> >> it won't for diffs?
> >>
> >> I *think* given a skimming of previous discussions that it's "no",
> >> i.e. that this just kicks in for these expensive cases, and e.g. for
> >> such a case of moving the same tree OID from "x" to "y" we'd
> >> short-circuit things, but maybe I'm just making things up at this poin=
t.
> >
> > Tree OIDs aren't used by the rename detection logic, but you're close.
> >
> >> Feel free to ignore me here, I guess this amounts to a request that it
> >> would be great if we could point to some docs about how this works. It=
's
> >> probably too much detail for Documentation/config/{merge,diff}.txt, so
> >> maybe a section in either of git-{diff,merge}.txt ?
> >
> > If git-merge.txt includes it, then rebase, cherry-pick, revert
> > probably should too.  (and maybe the -3 option of git-am)
> >
> > Anyway...
>
> Some of this we do via includes, but I also think we should have more
> "concept docs", like gitglossary, gitrevisions, so perhaps
> gitrenames(5)? Anyway, not for now...
>
> > In the "git mv dir-x dir-y" case, if no other changes are made to
> > those files, then the renames would be detectable via blobs having the
> > same hashes (i.e. exact renames).  So all these renames would be found
> > regardless of the number of files and without exhaustive detection
> > even kicking in.
> >
> > If there were thousands of such files, and every one of them were also
> > modified, then the basename-guided rename detection which operates in
> > linear time would still find all the renames, without the exhaustive
> > detection even kicking in (see commits bd24aa2f97a0 (diffcore-rename:
> > guide inexact rename detection based on basenames, 2021-02-14) and
> > 37a251436447 (diffcore-rename: use directory rename guided basename
> > comparisons, 2021-02-27)).
> >
> > If this were a merge, and there were thousands of such files renamed
> > and modified, AND they were all further renamed to change their
> > basename, BUT the original directory was unmodified on the other side
> > of history, then we wouldn't need any of the renames for the purposes
> > of the merge and they'd all be excluded from the exhaustive rename
> > detection.  Sure, we wouldn't find renames for those files, but that
> > wouldn't change the result of the merge.  So, again, no exhaustive
> > rename detection.  (See commit 174791f0fb23 (merge-ort: use
> > relevant_sources to filter possible rename sources, 2021-03-11))
> >
> > (Rebases & cherry-picks also have an advantage of caching renames from
> > previous picks on the upstream side of history to avoid needing to
> > re-detect renames on that side...though it only caches renames that
> > are either relevant or exact.)
> >
> > Basically, we bail on exhaustive rename detection if, after the linear
> > or faster steps have run (excluding previously cached renames, exact
> > rename detection, skipping irrelevant renames, basename guided rename
> > detection), the number of remaining unpaired source files times the
> > number of remaining unpaired destination files is greater than
> > rename_limit * rename_limit.  (If we can assume the numbers match,
> > i.e. N =3D number of remaining unpaired sources =3D number of remaining
> > unpaired destinations, then that check simplifies to bailing once N >
> > rename_limit)
> >
> >
> > I'm not sure if these details are really going to help the users,
> > especially if more special cases are added (and more have been
> > proposed by Johannes and became an Outreachy project, though that one
> > didn't get off the ground).  And this explanation is not even fully
> > detailed; I'm still hand waving here in at least four different ways
> > (mostly in ignoring special cases for different fast steps, but also
> > by ignoring copy detection that itself messes with the explanation in
> > multiple ways).
> >
> > But maybe someone else can figure out a way to hand wave my hand
> > waving down to a simple enough explanation, while also covering copy
> > detection, and managing to do so in a way that doesn't mislead.  If
> > so, we can include that in the docs somewhere.
>
> I think it would be good to briefly explain it in the sense of not
> explaining it, i.e. give the user who ran into this some idea of what
> they're looking at. Perhaps something like (and maybe this is too
> long...);
>
>     [...] these limits are limits to the number of "steps" in an an
>     algorithm that's subject to change, and whose number of steps will
>     depend on your input data.
>
>     They don't correspond to any easily tangible thing, e.g. a limit of
>     100 has no correspondence with detecting all renames in a commit
>     that changed 10 files, but not a commit that changed 11 files.
>
>     The limits were picked to limit runtime to an approximate desired
>     value, given what was thought to be Representative data from a
>     repository similar to linux.git.
>
>     If you find your diff/merge take X amount of time doing rename
>     detection, then generally speaking doubling the limit will about
>     double the time we spend on it.

...*quadruple* the time we spend on it.

>     So they're an indirect a way to get to a runtime limit of (what was
>     it, 2 and 10 seconds?).
>
>     The reason for this configuration not being a time limit is so that
>     git can guarantee identical results for the same input data across
>     different systems, given the same version and configuration.
>     I.e. the common case of running your attempt at a diff/merge twice
>     in a row, a time limit would produce unpredictable results.

Seems pretty lengthy.  Thinking about it for a bit, perhaps we could
just say something like:


After preliminary steps that can detect subsets of renames quickly, an
exhaustive fallback algorithm is used that compares all remaining
unpaired sources with all remaining unpaired destinations looking for
similar files that can be marked as renames.  (Or, in the case of copy
detection, it compares all original sources with all remaining
unpaired destinations).  With N sources and N destinations, this
algorithm is O(N^2).  The rename_limit says to skip this exhaustive
step if N is greater than the rename_limit.  (More precisely, it says
to skip the exhaustive step if number_sources * number_destinations >
rename_limit * rename_limit, which handles the case where there are a
different number of sources and destinations.)
