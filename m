Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F283C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 22:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiAGWNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiAGWNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 17:13:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D981C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 14:13:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z9so27172795edm.10
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 14:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uaMvkNu8oSYbofctauVGr5v7FmZ4IsjyuJzDLK/jfh8=;
        b=CAIaHvGI3rQHWLzYmVxWaDf1WGABqRX6Ue11muUHE2pKMtNILo+7zNh7q3+Uto/3as
         JXst9zmyK1Ku4JF23fHeq1I372OaoyBbLwlG5tvw/99Y0B7OXyO/qIW3OeYhWi5LEJhK
         VPEmj/cruIXyOWSdOipvbR1cAOT3zJKsT5IFTeagZ4D6AeP4QTW9x9U7DQL7MicrL3AA
         VpyzBC/B25YA4/j1vY5t2bucu+yO2gYySVA8w/i387zeNTccdHcYRNZzwC3x8XTRe4ct
         PjOQ/rcjvoWPwgV8OxlnNr3pzjL4N+URhzE8ZUcC6Wr3FyULcAzseh6p+6i3TIqBTnWI
         Yp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uaMvkNu8oSYbofctauVGr5v7FmZ4IsjyuJzDLK/jfh8=;
        b=OvauA67+UaNOiL5JCRKBxiPgT1fZkXXnx2DjsSW6muoIiyetKhRDUQ1eyMOz+CmQr/
         T0pk38eg0JAqZH7M2bdM24zKR7Jl8ID13b7yWV3Bok3KqJ8+eUMmsPBTEcfEMdXJNAbX
         b7KnxwU4Qp3nMgg1XTxztuQ5bL/uBsyYFzRjvYbygIF3S4ySWSl6Chee+yNjnDUtzZma
         kMPu251HrjF5jVvq6sb9KLE3tvlGcVsEBOF6ZjrT7Kx9gKbftXaeQXE/nqxqk1efgrJm
         /ICG4m42LbIqclUuqBRqMF8iC9UkNmnkuaNuYeor5SUf1dlog3RDF7U4CuPikCzn8Kcr
         rYxQ==
X-Gm-Message-State: AOAM532XiH7IBZj/M+DvSfGf0qlLCkCdqVqiY2jxr2Ip7u2NhsH+MS5v
        c99pmZy6bvQukfxN3O51tjEeDHwmzECoUeNQCG52ymK0D8nqQA==
X-Google-Smtp-Source: ABdhPJzQmHyAfXJUIpHwuhxe1PgF/Vqs5BvvBlX4grdxD7hvfsHcr5Bh5NIVc9C7EW+7oZjZkb3sVCWX6a9DWYF2Jlk=
X-Received: by 2002:a05:6402:34ca:: with SMTP id w10mr65732475edc.359.1641593587804;
 Fri, 07 Jan 2022 14:13:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201071908580.339@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201071908580.339@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 14:12:56 -0800
Message-ID: <CABPp-BHvXrP0sTTmuTYfACoJTCcm9+wk_f441nj4TstrmQdqMQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] merge-tree: provide an easy way to access which
 files have conflicts
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 7, 2022 at 11:36 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Wed, 5 Jan 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Callers of `git merge-tree --real` might want an easy way to determine
> > which files conflicted.  While they could potentially use the --message=
s
> > option and parse the resulting messages written to that file, those
> > messages are not meant to be machine readable.  Provide a simpler
> > mechanism of having the user specify --unmerged-list=3D$FILENAME, and t=
hen
> > write a NUL-separated list of unmerged filenames to the specified file.
>
> This patch does what the commit message says, and it looks quite
> plausible. However, in practice it seems that you need either a tree (if
> the merge succeeded) or the list of conflicted files (if the merge
> succeeded).
>
> So while it looks relatively clean from the implementation's point of
> view, the design itself could probably withstand a bit of consideration.
>
> As I hinted earlier (to be precise, in
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2201071602110.339@tvgsbejva=
qbjf.bet/),
> I had the chance in December to work on the server-side, using `merge-ort=
`
> for a bit. In the following, I will talk about this a bit more than about
> this particular patch, but I think it is highly relevant (not a tangent).
>
> One of the things that became clear to me is that we really have an
> either/or situation here. Either the merge succeeds, and we _need_ that
> tree, or it fails, and we could not care less about the tree at all.
>
> In fact, if the merge fails, we completely ignore the tree, and it would
> be better if we would not even write out any Git objects in that case at
> all: even just writing the objects would be quite costly at the
> server-side scale.
>
> So my (somewhat hacky) patches for a proof-of-concept produced _either_
> the hash of the tree on `stdout`, _or_ a header saying that there were
> conflicts followed by a NUL-separated list of file names.

Did you really check that it only produced one of these?  If you were
using ort, you wrote blob and tree objects to disk, even if you didn't
print their hash on stdout.

> Mind you, I did not even get to the point of analyzing things even more
> deeply. My partner in crime and I only got to comparing the `merge-ort`
> way to the libgit2-based way, trying to get them to compare as much
> apples-to-apples as possible [*1*], and we found that even the time to
> spawn the Git process (~1-3ms, with all overhead counted in) is _quite_
> noticeable, at server-side scale.

1-3ms?  I thought it was a good bit more than that.

> Of course, the `merge-ort` performance was _really_ nice when doing
> anything remotely complex, then `merge-ort` really blew the libgit2-based
> merge out of the water. But that's not the common case. The common case
> are merges that involve very few modified files, a single merge base, and
> they don't conflict. And those can be processed by the libgit2-based
> method within a fraction of the time it takes to even only so much as
> spawn `git` (libgit2-based merges can complete in less than a fifth
> millisecond, that's at most a fifth of the time it takes to merely run
> `git merge-tree`).
>
> The difference between 0.2-0.5ms for libgit2-based merges on the one hand=
,
> and 1-3ms for `merge-ort`-based merges on the other hand, might not seem
> like much, but you have to multiply it by the times such a merge is
> performed on the server. Which is a _lot_. Way more often than I thought.

Ah, I had been wondering a bit about process overhead.  Having
something that avoids that is definitely helpful.  I tried to design
ort such that its API is relatively clean and easy-to-use, and I
carefully tested and fixed it until it ran memory-leak free.  If
process execution overhead is such a big problem, perhaps you could
use these new functions via libgit.a instead of invoking a git process
and get the best of both worlds?

Unfortunately, in-process would run into problems with finding merge
bases, because the revision walking machinery is definitely not
leak-free -- an annoyance I had to deal with while attempting to clean
up merge-ort since the code I was using always did the merge-base
finding as well as the calls into merge-ort.  (I hear =C3=86var has some
not-yet-submitted patches that might help with memory leaks in the
revision walking machinery.)

> In this particular instance, there is a silver-lining: the libgit2-based
> merge is not actually recursive. It is a three-way merge. Which means tha=
t
> we first have to determine a merge base. In our case, this is done by
> spawning a Git process anyway, so one of my ideas to move forward is to f=
old
> that merge-base logic into `git merge-tree`, too.

The merge-base logic is already part of merge-tree in my patches.
What exactly did you do with merge-tree?  Were you using the existing
one and feeding it with a merge-base as an input, or did you write
your own that was more like Christian's that expected a merge base?

> Anyway, the short short is: whenever we can avoid unnecessary work, we
> should do so. In the context of this patch, I would say that we should
> avoid writing out a tree (and avoid printing its hash to `stdout`) if
> there are merge conflicts.

We can avoid printing its hash to `stdout`, but it'd take significant
work to avoid writing the tree to an object store, and it cannot be
done at the merge-tree level, it'd require replumbing some bits of
merge-ort (and making some already complex codepaths a bit more
complex, but that's a price I'm willing to pay for significant
performance wins).

Can I first suggest a simpler alternative that may give some
performance wins despite keeping the object writes:

We could make use of the tmp_objdir API that recently merged (see
b3cecf49ea ("tmp-objdir: new API for creating temporary writable
databases", 2021-12-06)).  We could put that tmp-objdir on /dev/shm or
other ramdisk, and if the merge is clean, migrate the contents into
the real object store.  Perhaps we could even pack those objects first
if there are a large number of them, but If it's not clean, we can
just discard the tmp-objdir. Also, as a further variant on this
alternative... packing these objects before migrating if there are a
sufficient number of them.  Now, this is rather unlikely to be needed
in general by merge-tree, because you only need to write new objects
(thus representing files modified on both sides, or whatever leading
trees are needed to reference the updated paths).  However, it might
matter for big enough repos with large enough numbers of changes on
both sides.  And it'd align nicely with my idea for server-side
rebases (where implementing this is on my TODO list), because
server-side rebases are much more likely to generate a large number of
objects.

But if you really want to learn about avoiding object writes...

If you really want to only write tree and blob objects when the merge
is clean, then as far as I can tell you have two options in regards to
the blobs: (1) you'll need to keep all files from three-way content
merges simultaneously in memory until you've determined if the result
is clean, so that you can then write the merged contents out as blobs
at the end.  Or (2) doing all the three-way content merges and keeping
track of whether the result for each is clean, and if they all turn
out to be clean, then redo every single one of those three-way content
merges afterwards so that you can actually write out the merged-result
to disk that time.

I think (2) would cost you a lot more work than you'd save, and I
worry that (1) might risk using large amounts of memory in the big
repositories if there are lots of changes on both sides.  While that
may be uncommon, I've seen folks try to merge things with lots of
changes on both sides, and you do have the server side to worry about
after all.

There are similar issues with the fact that trees are written as they
are processed as well.  Those would also require re-running afterwards
to re-generate the trees from the list of relevant-files-and-trees we
operate on.

However, if you are really curious about trying this out despite the
fact that I think you might be causing more work than you're avoiding
(or potentially requiring a lot more RAM), look for calls to
write_tree() (there are precisely two in merge-ort.c, one for
intermediate trees and one for the toplevel tree) and
write_object_file() (there are precisely two in merge-ort.c, one
within write_tree() for writing tree objects, and one in
handle_content_merge() for writing blob objects).

> And we should avoid writing (and later reading)
> a file, if we can get away with avoiding it.

Sure, we can do that.  Christian had a suggestion that if the
--conflicted-list didn't have an associated filename, then we just
print those to stdout.  Would that be to your liking?  And would you
prefer NUL-separated, or ls-tree style escaping of filenames?

> At least in the default case, that is. We still might need a flag to
> produce some more information about those merge conflicts. But even in
> that case, it would be better to have a list of file names with the three
> associated stages than to output the hash of a tree that contains
> conflicts (and tons of files _without_ conflicts). The UI needs to
> re-generate those conflicts anyway. And remember: a tree can contain
> millions of files even if there is but a single conflict. It makes more
> sense for `merge-tree --real` to output a concrete list of files that
> conflicted, rather than expecting the caller to discern between conflicts
> and non-conflicts by processing a tree object.

???

Where did I suggest that we discern between conflicts and
non-conflicts by processing a tree object?  That's not merely
something with atrocious performance, it's also utterly crazy from a
UI perspective, and is downright *impossible* to achieve in general
anyway.  (Failure to merge binary files.  modify/delete conflicts.
mode conflicts.  file/directory conflicts.  Various rename
permutatations.  There's all kinds of non-content conflicts that are
not representable in a tree, and which folks will miss if they attempt
to parse a tree and surmise what conflicts there were.)  Whatever I
wrote that might have suggested such a course of action needs some
serious rewording or clarification; I consider attempting that to be a
horrible idea.

The tree exists so that if people want to get extra information (and
presumably in a format similar to what they would find in their
working directory if they had asked `git merge` to merge those same
two branches on their laptop), then they can do so.  For example,
perhaps in the list of --conflicted-files they notice a file of
interest and want to ask, "What's found in this particular file?".
They can use the tree together with the filename to get that kind of
info.

> Maybe you agree with this rationale and re-design the `--real` mode to tr=
y
> to avoid writing out files in the common case?

I'm totally open to something like having --conflicted-list be given
without a filename (or maybe a '-') and write to stdout instead.

I'm amenable to various tradeoffs to improve performance, but I'm
worried that "not-writing-tree-and-blob object files" sounds like a
goal that might hurt performance rather than help it (either worse
performance in general due to the need to do things twice when the
merge is clean, or else a peak memory usage that is unmanageable and
causes problems).  Perhaps there's a smarter solution I'm not seeing,
or my worries about maximum memory usage are overblown.  However, if
you still want to pursue such core changes, I would also like to see
more performance measuring work to justify them -- especially since in
the common case merge-ort won't recurse into most directories and will
end up only writing a few object files (since only new blob or tree
objects need to be written).  In particular, I think we'd need to do
the following first:

  * Do a real comparison; libgit2 + the separate find-merge-base git
process, vs. the single `git merge-tree --real` call that handles
both.  Excluding the merge-base computation makes it apples to oranges
in my opinion.

  * While measuring the performance of the above, specifically use
trace2 to measure time spent in write_loose_object() in object-file.c.
See how much time object writing actually takes vs. everything else.

  * Try the tmp-objdir changes I suggested (examples of using the API
can be found by searching for "tmp_objdir" at
https://lore.kernel.org/git/d57ae218cf9eaee0b66db299ee1bba9b488b69b1.164090=
7369.git.gitgitgadget@gmail.com/
and https://lore.kernel.org/git/e1747ce00af7ab3170a69955b07d995d5321d6f3.16=
37020263.git.gitgitgadget@gmail.com/),
and then re-measure the performance particular in respect to
write_loose_object() as a percentage of overall time.

  * Get some kind of measure of the maximum number of three-way
content merges needed in merges and the overall size of holding all
the results in memory simultaneously.  If repositories have a million
files and there are merges involving a high enough percentage of files
changes on both sides, then that could certainly theoretically be
quite large.


I also think that doing something in-process (via linking against
libgit.a?) rather than forking `git merge-tree --real` would probably
net you _much_ bigger wins than avoiding writing these object files,
though it'd be unsafe without memory leak fixes for all the merge-base
computations.  That, of course, might not be the only reason you're
leery of such an approach.

> About the form of the patch itself: I was tempted to go with the
> nitpicking spirit I see on the Git mailing list these days, especially
> about the shell script code in the test scripts. But then I realized that
> I find such nitpicking pretty unhelpful, myself. The code is good as-is,
> even if I would write it differently. It is clear, and it does exactly
> what it is supposed to do.
>
> Thank you,
> Dscho
>
> Footnote *1*: I did not _quite_ get to the point of comparing the
> `merge-ort` merges to the libgit2 ones, unfortunately. I was on my way to
> add code to respect `merge.renames =3D false` so that we could _truly_
> compare the `merge-ort` merges to the libgit2 merges (we really will want
> to verify that the output is identical, before even considering to enable
> recursive merges on the server side, and then only after studying the tim=
e
> difference), and then had to take off due to the holidays. If you already
> have that need to be able to turn off rename-detection on your radar, eve=
n
> if only for a transitional period, I would be _so_ delighted.

Well, I had no intention of submitting it (and still don't), but I did
implement it a while back for folks who have needs for it in a
transitional period.  It's a pretty simple change.

https://github.com/newren/git/commit/5330a9de77f56f20e546acc65c924fc783f092=
e6
https://github.com/newren/git/commit/2e7e8d79b0995d352558608b6308060fbc055f=
d1

:-)
