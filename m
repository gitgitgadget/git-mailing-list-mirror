Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E25C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiBVNES (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiBVNER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:04:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD5EB1AAC
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645535028;
        bh=5WrTyWdBVNGssPV3jf4GgaHnBo+2NrWQmnCAJxV6b3I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ElluDX8sFFqX6dW66hFBL13Mbbe+cPk/simE2OhtQU8IRJsOtjvPp8VyJ1O+iyCx4
         qpUhk2jTYnICd8QEauYl2HKPa8feIz+Y2f8L4e4qGeOGmXB1yN9lxDzs4c7sZhl6t3
         wOKu9hFg3W7EJcqzd0KeXbbWj5uS9FZxnYNjYrx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1oNYXC20X0-013gTh; Tue, 22
 Feb 2022 14:03:48 +0100
Date:   Tue, 22 Feb 2022 14:03:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH v2 8/8] merge-tree: provide an easy way to access which
 files have conflicts
In-Reply-To: <CABPp-BHvXrP0sTTmuTYfACoJTCcm9+wk_f441nj4TstrmQdqMQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221345510.11118@tvgsbejvaqbjf.bet>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com> <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201071908580.339@tvgsbejvaqbjf.bet>
 <CABPp-BHvXrP0sTTmuTYfACoJTCcm9+wk_f441nj4TstrmQdqMQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5kSWGdVXsJnKMN24MEbLd1siaeQda4gpCoEkr/auEZ8h//GeNx1
 h9xUFdnz36jSh1zFvU78kBJbh+vEG4zQqawCMUbtideQT+6TgZRw+2mQGdYisq2Zbtnouy7
 U7leqGYn0bikrudlNY6EsKt2pjwISsxQkTROjUOBFYBr+0efT2JUqq4bu2w6TjolguX4a4e
 VqUZFHCIrPGr5VfiFwn7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S8Rb4NljrMo=:5C6dKArMh6aRZcKeIPcd4G
 gslplEBmlsZPseNw7701xxX6Flodb2I6Kap/K1pqfgRZQOlYrIIiUQ5Hl8Wi4uYmti1BIjWFu
 kBpPbM1alLJHXkAlmwVo8xZS2bPKWIPXIw5Cdm1fOmnC/n1TIebHgeDa0rgwdVAr0tpm60aos
 MkgjuboJivOzRZElC5Z7icsRiiVLVJTpc1t4vMKyVEU2x8JXbQOty+u0d/s3ajV4BOvb1iEOC
 nrQV+k9spjim5xMYS6Gc70VdWn9Scqw6j58cTM1ZKWGhKRcVF4RexOkXxYR2EoGVvl66dN1Er
 U53qyXG19rQVGTCsnpHByqdlAedI70ev2uRKpUDZnolCx6NpqCz1bCkqudrL9/8rDuMKCbmqZ
 N4MRtq+9wQMMPXleo2wF+Y29PD8jjsjv6TBmvwFQKWw32gON8dfb2oWsw2mT5VXP5NodwxsBj
 IujVSpMl3+23EjhS5ZkUiMHSvaJxHUhA7lJ8fm585xtIoP/JjBs9Cfgiub+Fx8V1kVopfUv2e
 m8Ikbod4j644oGdKhHdzgbNYWMDylK5+LnKagkHpyZSaa0SKA9SwWLiPayrsypCuKBBf+RrET
 FX2RRHircnRNsJ8NsuHMYhgvVDDwDHJV6etWunqPCYIazuqv3PMxmJrn1NG0NQ1umB1erqRuj
 FQ6HoW0jZBj6N+7ZcK2YwbINOlGaJVAgSwHlZoKE0DjprlGvC1KT7LuazX7j6F+I1pqTHKQfs
 dTEvdAAQafNfjRATmJmTNWSUxn6KsvzBO02M4EZlYlFu21SrcHNfgBXcqJ4tulHCC+pPBSIxG
 qQ9d4d/wTd8KnWl++NpqAEBNUnHuPAVqhB6zlR7PF5ASuPQef68pFXNdX7655pt/YwSKWg5si
 iahnn2Y0ElVhG7fPjItpwe0sZ7QOLJD3zkoi3p2A9YqlHtAAbc45zXfPh5UgYuuv2MuOT5KQT
 mgQVsq6MviqHZ/wwHFb8lzSrn8llXYxpv21m4KbE/bIudRPbc5IWdFJpmV1Cd3OF3Aa31+wqF
 ukyJo4W+1DAFv0miah7AnAVDiueGuSeXMEkwQdBgNdhPr5iyE5ssuyMc2KC07GlBF9JYwdCMe
 0ueJAFnxdg38YM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

I meant to answer this mail much earlier, oh well. Sorry. I will only
answer the still open questions below, clipping the quoted text to save
every reader some time.

On Fri, 7 Jan 2022, Elijah Newren wrote:

> On Fri, Jan 7, 2022 at 11:36 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > So my (somewhat hacky) patches for a proof-of-concept produced
> > _either_ the hash of the tree on `stdout`, _or_ a header saying that
> > there were conflicts followed by a NUL-separated list of file names.
>
> Did you really check that it only produced one of these?  If you were
> using ort, you wrote blob and tree objects to disk, even if you didn't
> print their hash on stdout.

D'oh. No, I had not checked that.

> > Mind you, I did not even get to the point of analyzing things even mor=
e
> > deeply. My partner in crime and I only got to comparing the `merge-ort=
`
> > way to the libgit2-based way, trying to get them to compare as much
> > apples-to-apples as possible [*1*], and we found that even the time to
> > spawn the Git process (~1-3ms, with all overhead counted in) is _quite=
_
> > noticeable, at server-side scale.
>
> 1-3ms?  I thought it was a good bit more than that.

The absolute number really depends on a lot of factors, i.e. what is
relevant is the relative difference between in-process vs spawning a new
process.

> If process execution overhead is such a big problem, perhaps you could
> use these new functions via libgit.a instead of invoking a git process
> and get the best of both worlds?

For now, I solved this by combining multiple Git process invocations into
a single one, as described here:

> > In this particular instance, there is a silver-lining: the
> > libgit2-based merge is not actually recursive. It is a three-way
> > merge. Which means that we first have to determine a merge base. In
> > our case, this is done by spawning a Git process anyway, so one of my
> > ideas to move forward is to fold that merge-base logic into `git
> > merge-tree`, too.
>
> The merge-base logic is already part of merge-tree in my patches.
> What exactly did you do with merge-tree?  Were you using the existing
> one and feeding it with a merge-base as an input, or did you write
> your own that was more like Christian's that expected a merge base?

For an apples-to-apples comparison, I had to stay with the very same merge
base logic as before, i.e. originally I added a new option to `merge-tree`
that would take a merge base and then take a non-recursive path. In my
current version, it is merely an option that even determines said merge
base in the same process (and yes, it leaks memory, but that does not
matter because the process is short-lived anyway).

> > Anyway, the short short is: whenever we can avoid unnecessary work, we
> > should do so. In the context of this patch, I would say that we should
> > avoid writing out a tree (and avoid printing its hash to `stdout`) if
> > there are merge conflicts.
>
> We can avoid printing its hash to `stdout`, but it'd take significant
> work to avoid writing the tree to an object store, and it cannot be
> done at the merge-tree level, it'd require replumbing some bits of
> merge-ort (and making some already complex codepaths a bit more
> complex, but that's a price I'm willing to pay for significant
> performance wins).

Yes, let's leave things as-are. It is not worth the trouble.

> We could make use of the tmp_objdir API that recently merged (see
> b3cecf49ea ("tmp-objdir: new API for creating temporary writable
> databases", 2021-12-06)).  We could put that tmp-objdir on /dev/shm or
> other ramdisk, and if the merge is clean, migrate the contents into
> the real object store.  Perhaps we could even pack those objects first
> if there are a large number of them, but If it's not clean, we can
> just discard the tmp-objdir. Also, as a further variant on this
> alternative... packing these objects before migrating if there are a
> sufficient number of them.  Now, this is rather unlikely to be needed
> in general by merge-tree, because you only need to write new objects
> (thus representing files modified on both sides, or whatever leading
> trees are needed to reference the updated paths).  However, it might
> matter for big enough repos with large enough numbers of changes on
> both sides.  And it'd align nicely with my idea for server-side
> rebases (where implementing this is on my TODO list), because
> server-side rebases are much more likely to generate a large number of
> objects.
>
> But if you really want to learn about avoiding object writes...
>
> If you really want to only write tree and blob objects when the merge
> is clean, then as far as I can tell you have two options in regards to
> the blobs: (1) you'll need to keep all files from three-way content
> merges simultaneously in memory until you've determined if the result
> is clean, so that you can then write the merged contents out as blobs
> at the end.  Or (2) doing all the three-way content merges and keeping
> track of whether the result for each is clean, and if they all turn
> out to be clean, then redo every single one of those three-way content
> merges afterwards so that you can actually write out the merged-result
> to disk that time.
>
> I think (2) would cost you a lot more work than you'd save, and I
> worry that (1) might risk using large amounts of memory in the big
> repositories if there are lots of changes on both sides.  While that
> may be uncommon, I've seen folks try to merge things with lots of
> changes on both sides, and you do have the server side to worry about
> after all.
>
> There are similar issues with the fact that trees are written as they
> are processed as well.  Those would also require re-running afterwards
> to re-generate the trees from the list of relevant-files-and-trees we
> operate on.
>
> However, if you are really curious about trying this out despite the
> fact that I think you might be causing more work than you're avoiding
> (or potentially requiring a lot more RAM), look for calls to
> write_tree() (there are precisely two in merge-ort.c, one for
> intermediate trees and one for the toplevel tree) and
> write_object_file() (there are precisely two in merge-ort.c, one
> within write_tree() for writing tree objects, and one in
> handle_content_merge() for writing blob objects).

Thank you for this thorough analysis.

I am a big fan of crossing bridges when they are reached, and not miles
before that. So _iff_ it turns out that the speed, or the potential
cluttering with objects, should present a problem in the future, I am
inclined to follow the tmp-objdir route you described above (thank you for
pointing it out, I had not made the connection to this here scenario).

> > Footnote *1*: I did not _quite_ get to the point of comparing the
> > `merge-ort` merges to the libgit2 ones, unfortunately. I was on my way=
 to
> > add code to respect `merge.renames =3D false` so that we could _truly_
> > compare the `merge-ort` merges to the libgit2 merges (we really will w=
ant
> > to verify that the output is identical, before even considering to ena=
ble
> > recursive merges on the server side, and then only after studying the =
time
> > difference), and then had to take off due to the holidays. If you alre=
ady
> > have that need to be able to turn off rename-detection on your radar, =
even
> > if only for a transitional period, I would be _so_ delighted.
>
> Well, I had no intention of submitting it (and still don't), but I did
> implement it a while back for folks who have needs for it in a
> transitional period.  It's a pretty simple change.
>
> https://github.com/newren/git/commit/5330a9de77f56f20e546acc65c924fc783f=
092e6
> https://github.com/newren/git/commit/2e7e8d79b0995d352558608b6308060fbc0=
55fd1

Thank you _so_ much for that. It was super helpful, and it allowed me to
gather enough evidence to justify continuing to work on this code.

Ciao,
Dscho
