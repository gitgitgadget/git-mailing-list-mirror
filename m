Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FDDC4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4D42074F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/LjhZ4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgKIXGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 18:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgKIXGA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 18:06:00 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855ECC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 15:06:00 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t16so12099203oie.11
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 15:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNtZ+4tXgXHuOx5nCwKWodNrgxid923sEuIOOXDxrLk=;
        b=Y/LjhZ4jmdNdXz1OrbCfxdHKzeky/x81KMWYw2/WezahJ47AxTm0HRZzcSs/yTKi8c
         rltqtELtqL1OaXF/La9dK9mgQipdzo1JLhT2irQjZ6cskvIU+7CetaUlp1Eyh5aXBoM/
         CxmEsbji9odM4eAYVI1K/zEdesqNee93yPVoSxjuupjyo9VHlfEwqeK8/2LJOXYw6aYZ
         ZECYFasppsaD0tI4wpAFeTu2KjojKAk5+h+Ez12aUBh7etOV5Bii8QQwCHBR80J266ep
         NAs135oGzZcbGggQhuRUDdCOsLCJ/PAZDO2YfK23EVN7VU2UMAF8rp28iOU7Z+A6Ay6F
         Tcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNtZ+4tXgXHuOx5nCwKWodNrgxid923sEuIOOXDxrLk=;
        b=hAVPviDpJcdGaQAovD5IbP3LGfogMF2jUoJVlvMTqtSOexywqL9K3Jhe7kowaWO5sz
         DxSUk6bWyktKnHDM5x7z8U34KExAsccV0vUob7IOKLZTrDJJVdaGOkV0ccVEexzkqnwQ
         f2n2JXQj4CKD4cMVEK39fbxWIK4SO98ErW/mhsf+1qbLLM5ROsvKR8wwB7ahO/2I0q8x
         oXMnSQaKidVbi9huZkw9tlPhvLf3qdhYwYa4Xd5PyrGPB1vsnmETa548/5wtlPFxWsQm
         QqyABjQsRIdPz8+NAfOUb/EAprZLnuPf/IGJ5wjxfu1BJ5yveBaiMlijqDLHn7lU32L/
         BKvQ==
X-Gm-Message-State: AOAM530J+d66MpB9Z0xyPTbCcnaGCZk0/nBGz7o1PLtLpudMcMvmCtTP
        eWfTxq4cUy1Sz/WwY0Ns5Jhg1felJm8TIXPOBVttqhP3eDg=
X-Google-Smtp-Source: ABdhPJwPYp7tRd3a4wSUVF5I0fGC1LZ62gwZwdUlVtrkEvN5eFS/ajyGPQEgHwtNE/Syyt0bFME6ToPSwvgIyJieFQM=
X-Received: by 2002:aca:3756:: with SMTP id e83mr1010781oia.31.1604963159820;
 Mon, 09 Nov 2020 15:05:59 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BHOvk+W0u_MYWtH8OC-Uh5bEfsRO6QuXZKWfDQ=8fyasA@mail.gmail.com>
 <20201109220431.2534786-1-jonathantanmy@google.com>
In-Reply-To: <20201109220431.2534786-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Nov 2020 15:05:48 -0800
Message-ID: <CABPp-BFNk5ZQLyo5G-7vq3XD3s6z_rGUNM3QL14hXvMYTzK_Ug@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] merge-ort: compute a few more useful fields for collect_merge_info
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 9, 2020 at 2:04 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > On Fri, Nov 6, 2020 at 2:52 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> > >
> > > > +     /*
> > > > +      * Note: We only label files with df_conflict, not directories.
> > > > +      * Since directories stay where they are, and files move out of the
> > > > +      * way to make room for a directory, we don't care if there was a
> > > > +      * directory/file conflict for a parent directory of the current path.
> > > > +      */
> > > > +     unsigned df_conflict = (filemask != 0) && (dirmask != 0);
> > >
> > > Suppose you have:
> > >
> > >  [ours]
> > >   foo/
> > >     bar/
> > >       baz
> > >     quux
> > >  [theirs]
> > >   foo
> > >
> > > By "we only label files with df_conflict, not directories", are you
> > > referring to not labelling "foo/" in [ours], or to "bar/", "baz", and
> > > "quux" (so, the files and directories within a directory)? At first I
> > > thought you were referring to the former, but perhaps you are referring
> > > to the latter.
> >
> > The former.  I was drawing a distinction between how this code
> > operates, and how unpack_trees() operates, which probably only matters
> > to those familiar with unpack_trees() or who have been reading through
> > it recently.
>
> Just for clarification: do you mean "the latter"? (The "not" in my
> question might be confusing.)

Yeah, probably was confusing, so let me just state where you are
almost right below.

> To be more illustrative in what I meant, at first I thought that you
> were NOT labelling "foo/" in [ours], hence:
>
>  [ours]
>   foo/  <- unlabeled
>  [theirs]
>   foo   <- labeled
>
> In this way, in a sense, you are indeed labelling only the file, not the
> directory.
>
> But instead what you seem to be doing is this:
>
>  [ours]
>   foo/     <- labeled
>     bar/   <- unlabeled
>       baz  <- unlabeled
>     quux   <- unlabeled
>  [theirs]
>   foo      <- labeled
>
> which is what I meant by NOT labelling "bar/", "baz", and "quux".

I'm doing something /really/ close to this, yes.  However, just to be
pedantic, there is no "foo/".  '/' is an illegal character in a
filename to record in a tree.  One side has a "foo" whose mode and
object_id happen to reflect a tree rather than a blob.  But I only
have one conflict_info per pathname, not 3 (can't have three since
strmaps don't allow duplicate keys, and wouldn't want it if I could).
That one conflict_info stores 3 (mode, object_id) pairs, and also has
a single df_conflict bit.  So, I label "foo" by setting that
df_conflict bit.  But I only pay attention to it for the pairs
representing a blob, not the ones representing a tree.  And I don't
propagate the information down to paths below the foo directory.

> > unpack_trees() will note when there is a directory/file
> > conflict, and propagates that information to all subtrees, with every
> > path specially checking for the o->df_conflict_entry and then handling
> > it specially (e.g. keeping higher order stages instead of using an
> > aggressive or trivial resolutions).
>
> And here it seems like you're describing that unpack_trees() would label
> it in this way:
>
>  [ours]
>   foo/     <- labeled
>     bar/   <- labeled
>       baz  <- labeled
>     quux   <- labeled
>  [theirs]
>   foo      <- labeled
>
> (and you're emphasizing by contrast that merge-ort is NOT doing this).

Correct.

> > However, leaving both a file and
> > a directory at the same path, while allowed in the index, makes for
> > ugliness and difficulty for users to resolve.   Plus it isn't allowed
> > in the working tree anyway.  We decided a while ago that it'd be
> > better to represent these conflicts differently[1], [2].
> >
> > Also, at the time you are unpacking or traversing trees, you only know
> > if one side had a directory where the other side had a file.  You
> > don't know if the final merge result will actually have a
> > directory/file conflict.  If the file existed in both the base version
> > and unmodified on one side, for example, then the file will be removed
> > as part of the merge.  It is similarly possible that the entire
> > directory of files all need to be deleted or are all renamed
> > elsewhere.  So, you have to keep track of a df_conflict bit, but you
> > can't act on it until you've processed several other things first.
> >
> > Since I already know I'm not going to move a whole directory of files
> > out of the way so that a file can be placed in the working tree
> > instead of that whole directory, the directory doesn't need to be
> > tweaked.  I'm not going to propagate any information about a
> > directory/file conflict at some path down to all subpaths of the
> > directory.  I only track it for the file that immediately conflicts,
> > and then only take action on it after resolving all the paths under
> > the corresponding directory to see if the directory/file conflict
> > remains.
> >
> > [1] https://lore.kernel.org/git/xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com/
> > and the thread surrounding it
> > [2] https://lore.kernel.org/git/f27f12e8e50e56c010c29caa00296475d4de205b.1603731704.git.gitgitgadget@gmail.com/,
> > which is now commit ef52778708 ("merge tests: expect improved
> > directory/file conflict handling in ort", 2020-10-26)
>
> Makes sense.
>
> > > > @@ -161,6 +179,13 @@ static int collect_merge_info_callback(int n,
> > > >               newinfo.name = p->path;
> > > >               newinfo.namelen = p->pathlen;
> > > >               newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
> > > > +             /*
> > > > +              * If we did care about parent directories having a D/F
> > > > +              * conflict, then we'd include
> > > > +              *    newinfo.df_conflicts |= (mask & ~dirmask);
> > > > +              * here.  But we don't.  (See comment near setting of local
> > > > +              * df_conflict variable near the beginning of this function).
> > > > +              */
> > >
> > > I'm not sure how "mask" and "dirmask" contains information about parent
> > > directories. "mask" represents the available entries, and "dirmask"
> > > represents which of them are directories, as far as I know. So we can
> > > notice when something is missing, but I don't see how this distinguishes
> > > between the case that something is missing because it was in a parent
> > > directory that got deleted, vs something is missing because it itself
> > > got deleted.
> >
> > Yeah, this is more comparisons to unpack_trees.  This code is about to
> > set up a recursive call into subdirectories.  newinfo is set based on
> > the mask and dirmask of the current entry, and then subdirectories can
> > consult newinfo.df_conflicts to see if that path is within a directory
> > that was involved in a directory/file conflict.  For example:
> >
> > Tree in base version:
> >     foo/
> >         bar
> >     stuff.txt
> > Tree on side 1: (adds foo/baz)
> >     foo/
> >         bar
> >         baz
> >     stuff.txt
> > Tree on side 2: (deletes foo/, adds new file foo)
> >    foo
> >    stuff.txt
> >
> > When processing 'foo', we have mask=7, dirmask = 3.  So, here
> > unpack_trees() would have set newinfo.df_conflicts = (mask & ~dirmask)
> > = 4.  Then when we process foo/bar or foo/baz, we have mask=2,
> > dirmask=0, which looks like there are no directory/file conflicts.
> > However, we can note that these paths are under a directory involved
> > in a directory/file conflict via info.df_conflicts whose value is 4.
> > unpack_trees() cared about paths under a directory that was involved
> > in a directory/file conflict, and someone familiar with that code
> > might ask why I don't also track the same information.  The answer is
> > that I don't track it, even though I thought about it, because it's
> > useless overhead since I'm going to leave the directory alone and move
> > the file out of the way.
> >
> > Does that make sense?
>
> Ah...yes, that makes sense. I think I didn't notice the "newinfo", so I
> didn't realize that we were setting the info of our children based on
> ourselves. Perhaps I would have noticed it sooner if the comment had
> read "If this file/directory cared about its parent directory (the
> current directory) having a D/F conflict, then we'd propagate the masks
> in this way:" instead of "If we did care about parent directories having
> a D/F conflict", but perhaps the point is already obvious enough.

I'm happy to reword it if that makes it clearer.  Thanks for the suggestion.
