Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3761C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 17:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2941214DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 17:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8hTO6DD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgA3RNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:13:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39769 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3RNf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 12:13:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id z2so4232284oih.6
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 09:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUucQrl0PJJa172TQydYi4yNDyWfxc1HujyY7FhR53g=;
        b=H8hTO6DDNvSnBJE1hmeOyGJ/Kd5eh+noIVyqscU3SMMUnRNCJ5UWKcYdjNl7F3zhVB
         wwvxQ1vtzf7uyyg4vJS7anQDi8t733NTLg+SqPRUAAj+t+K49oLyl4ceAGSBv3PIK1DJ
         /TAPpKE64LHErmoZnQhJ88qgM7Mwkat324aDJCjR/+4j4jD8yNlI1P4lhs36R0WXsl2K
         sc7UVHZ9Kh+hrNHizIFuRClLlqYzoO7z9fE9UsdDQsL9C22E5JVVedSAAET69wtqgwuy
         BVOf6Wjo8JBpabK9tkReyS64WWs5JK2/w0HxqGqRs8TNS6IkrjkvxxZYLq09EQ/u9UDu
         6Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUucQrl0PJJa172TQydYi4yNDyWfxc1HujyY7FhR53g=;
        b=bnITtPhIwHxBhhwTVmTkuxp9dpDVeNSeSzGVKKc0vPZapRcfOOVvs7f7i3p2iM51VT
         O277tdCr1MLEmp8LKjn6rz7njsX2TODnHIVvIpb5pykLaZMoJXNPGH7+gKxp0/iOmtvs
         KIymE6Kc8tmjBZ2G1KFTt9+D9F1v5F3UbDYhAf/bzAGkOQhjs6YPhqSS9uzUW8EtBZKF
         t4aNJ0WkmIjJLNQgTYxZtNyxU6j7QI38SAbTa02/58b0P7eYRZNE90lGp8UozNLj3MY6
         +XFutJPqgxpnaOkvIKNZwtNdcLcVdaegTCx9kzdfuMw+JDVDPLMMfxkYPA6+eKna9wVT
         KVNg==
X-Gm-Message-State: APjAAAXOJwJFlK78Px+Z2VZsMQmVq6F24sqGbBMieoLLzRXXhQCFI1N1
        U5Excy0swY3Fu5BHFo0J1gtiznYwD2N/g8+Hp5k=
X-Google-Smtp-Source: APXvYqzyd3OZLxSeBfkvUEB/mmSfN04laEQtujxD/ZXgv0J6VtNd9oW/rnoW8j9euV1C5nEv+pd0o3+JOtukF7qNeaA=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr3418910oib.6.1580404412552;
 Thu, 30 Jan 2020 09:13:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <40b378e7adbbff5ecfd95fd888465fd0f99791c8.1580335424.git.gitgitgadget@gmail.com>
 <59b5b766-29e2-a709-b407-56bf6ea60b47@gmail.com>
In-Reply-To: <59b5b766-29e2-a709-b407-56bf6ea60b47@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jan 2020 09:13:21 -0800
Message-ID: <CABPp-BEQ5s=+6Rnb-A+pdEaoPXxfo-hMSegSe1eai=RE74A3Og@mail.gmail.com>
Subject: Re: [PATCH 5/6] dir: replace exponential algorithm with a linear one
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Kevin.Willford@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 7:55 AM Derrick Stolee <stolee@gmail.com> wrote:
> > However, on the positive side, it does make the code much faster.  For
> > the following simple shell loop in an empty repository:
> >
> >   for depth in $(seq 10 25)
> >   do
> >     dirs=$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
> >     rm -rf dir
> >     mkdir -p $dirs
> >     >$dirs/untracked-file
> >     /usr/bin/time --format="$depth: %e" git status --ignored >/dev/null
> >   done
> >
> > I saw the following timings, in seconds (note that the numbers are a
> > little noisy from run-to-run, but the trend is very clear with every
> > run):
> >
> >     10: 0.03
> >     11: 0.05
> >     12: 0.08
> >     13: 0.19
> >     14: 0.29
> >     15: 0.50
> >     16: 1.05
> >     17: 2.11
> >     18: 4.11
> >     19: 8.60
> >     20: 17.55
> >     21: 33.87
> >     22: 68.71
> >     23: 140.05
> >     24: 274.45
> >     25: 551.15
>
> Are these timings on Linux? I imagine that the timings will increase
> much more quickly on Windows.

Yes, on Linux, with an SSD for the hard drive in this case (though I
suspect OS caching of the directories would probably eliminate any
differences between an SSD and a spinny disk since the same
directories are visited so many times).

> > After this fix, those drop to:
> >
> >     10: 0.00
> ...
> >     25: 0.00
>
> Nice. I wonder if presenting these 0.00 values as a table is worth
> the space? At least the effect is dramatic.

I first considered a table, but then noted it didn't match the code
snippet I provided and was worried I'd have to spend more time
explaining how I post-processed the output from two runs than we'd
gain from compressing the number of lines of the commit message.
Assuming reader time was more valuable, I opted to just keep the two
snippets of output.

> > WARNING: This change breaks t7063.  I don't know whether that is to be expected
> > (I now intentionally visit untracked directories differently so naturally the
> > untracked cache should change), or if I've broken something.  I'm hoping to get
> > an untracked cache expert to chime in...
>
> I suppose that when the untracked cache is enabled, your expectation that we
> do not need to recurse into an untracked directory is incorrect: we actually
> want to explore that directory. Is there a mode we can check to see if we
> are REALLY REALLY collecting _all_ untracked paths? Perhaps we need to create
> one?

I don't think I made any significant changes about using the untracked
cache versus traversing; the primary differences should be that I
traverse each directory once instead of 2^N times.  However, the
previous code would traverse with both check_only=0 and check_only=1,
and to avoid the whole 2^N thing I only traverse once.  That
fundamentally means I only won't traverse with both settings of that
flag.

The output in t7063 seems to suggest to me that the check_only flag
matters to what the untracked-cache stores ("check_only" literally
appears as part of the expected output), and the output also suggests
that the untracked-cache is recording when entries are visited
multiple times somehow.  Or maybe I'm just totally misunderstanding
the expected output in t7063.  I really have no clue about that stuff.

> I'm CC'ing Kevin Willford because he is more familiar with the Git index
> than me, and perhaps the untracked cache in particular.

Getting another set of eyes, even if they only know enough to provide
hunches or guesses, would be very welcome.

> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  dir.c | 151 ++++++++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 105 insertions(+), 46 deletions(-)
> >
> > diff --git a/dir.c b/dir.c
> > index ef3307718a..aaf038a9c4 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1659,7 +1659,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
> >       const char *dirname, int len, int baselen, int excluded,
> >       const struct pathspec *pathspec)
> >  {
> > -     int nested_repo;
> > +     /*
> > +      * WARNING: From this function, you can return path_recurse or you
> > +      *          can call read_directory_recursive() (or neither), but
> > +      *          you CAN'T DO BOTH.
> > +      */
> > +     enum path_treatment state;
> > +     int nested_repo, old_ignored_nr, stop_early;
> >
> >       /* The "len-1" is to strip the final '/' */
> >       switch (directory_exists_in_index(istate, dirname, len-1)) {
> > @@ -1713,18 +1719,101 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
> >
> >       /* This is the "show_other_directories" case */
> >
> > -     if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
> > +     /*
> > +      * We only need to recurse into untracked/ignored directories if
> > +      * either of the following bits is set:
> > +      *   - DIR_SHOW_IGNORED_TOO (because then we need to determine if
> > +      *                           there are ignored directories below)
> > +      *   - DIR_HIDE_EMPTY_DIRECTORIES (because we have to determine if
> > +      *                                 the directory is empty)
>
> Perhaps here is where you could also have a DIR_LIST_ALL_UNTRACKED
> flag to ensure the untracked cache loads all untracked paths?

Do you mean DIR_KEEP_UNTRACKED_CONTENTS (which is documented in dir.h
as only having meaning when DIR_SHOW_IGNORED_TOO is also set, and thus
caused me to not list it separately)?

Speaking of DIR_KEEP_UNTRACKED_CONTENTS, though, its handling as a
post-processing step in read_directory() is now inconsistent with how
we handle squashing a directory full of ignores into just marking the
containing directory as ignored.  I think I should move the
read_directory() logic for DIR_KEEP_UNTRACKED_CONTENTS to
treat_directory() and use another counter similar to old_ignored_nr.
It should be more efficient that way, too.

>
> > +      */
> > +     if (!(dir->flags & (DIR_SHOW_IGNORED_TOO | DIR_HIDE_EMPTY_DIRECTORIES)))
> >               return excluded ? path_excluded : path_untracked;
> >
> > +     /*
> > +      * If we only want to determine if dirname is empty, then we can
> > +      * stop at the first file we find underneath that directory rather
> > +      * than continuing to recurse beyond it.  If DIR_SHOW_IGNORED_TOO
> > +      * is set, then we want MORE than just determining if dirname is
> > +      * empty.
> > +      */
> > +     stop_early = ((dir->flags & DIR_HIDE_EMPTY_DIRECTORIES) &&
> > +                   !(dir->flags & DIR_SHOW_IGNORED_TOO));
> > +
> > +     /*
> > +      * If /every/ file within an untracked directory is ignored, then
> > +      * we want to treat the directory as ignored (for e.g. status
> > +      * --porcelain), without listing the individual ignored files
> > +      * underneath.  To do so, we'll save the current ignored_nr, and
> > +      * pop all the ones added after it if it turns out the entire
> > +      * directory is ignored.
>
> Here is a question for an untracked cache expert: Do we store ignored
> paths in the untracked cache?

According to 0dcb8d7fe0ec ("untracked cache: record .gitignore
information and dir hierarchy", 2015-03-08), no:

    This cached output is about untracked files only, not ignored files
    because the number of tracked files is usually small, so small cache
    overhead, while the number of ignored files could go really high
    (e.g. *.o files mixing with source code).

...unless, of course, someone came along later and changed the design goals.

[...]

> This is certainly a substantial change, and I'm not able to read it
> carefully right now. I hope to return to it soon, but hopefully I've
> pointed out some places that may lead you to resolve your untracked
> cache issues.

Yeah, it's pretty hard to reason about; personally I needed lots of
dumps of state during traversals just to partially make sense of it.

I had dumps of output from both before and after my changes printing
out return values of treat_directory() and paths and a bunch of other
stuff and was doing lots of comparisons (and repeatedly did this for
many, many different testcases with different toplevel git commands).
It was particularly annoying that the old stuff would traverse
everything 2^N times, half the time with check_only on and half the
time with it off.  It would return different state values for the same
path from different calls, often depending on the side effects of
dir.entries having had more entries added by the first recursion to
get the right output, despite the fact that the "wrong" state was
returned by treat_directory() for later visits to the same path (e.g.
path_untracked returned for the first time it was visited, then
path_none later, and it was a case where path_untracked was correct in
my view).

Despite those difficulties, having an extra set of eyes try to reason
about it and pointing out anything that looks amiss or even that just
looks hard to understand would be very welcome.
