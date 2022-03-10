Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3D3C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbiCJRyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiCJRyK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:54:10 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2153EC9A15
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:53:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 3so10780825lfr.7
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z/wdt5zNKCw8d2PzsTbIMQYLHID4kpikr3vtmuETr5s=;
        b=MA0Fdcs5gX4zopdL0TS1wnXuzYzw/8o93Ltic9+ZcGB6BhT/4gXFmAhcw5LojrLFs6
         ZnHU0OP0g7LR+pXuRHH2KMIZ02WnrhFpMx9gFSBGrIbNjthA0Hde4ilgQHtuYG4cGCo1
         DWunl3afOMYgzxZ1bxZe9DipB4q0pdFST7w6GWaI0phSKo9pWgKLK8uZvDS5+IyxYAg0
         6pB9zjR+uNbaEyDOWRBTIHZIgIf24b3ZBOWOUstsA6oIbvrSeVSAlby8Tkteotqdqh07
         4So1f2ttZty3NT0Vj4wNTrgGTfAjwP//+at5FUQN8QD+/Y5eap9Hj9Xk7Vq8W9L8kH3Q
         woag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z/wdt5zNKCw8d2PzsTbIMQYLHID4kpikr3vtmuETr5s=;
        b=yfYe1PkmSv7V77bsspVnf+X91+tmkdy34jVusEWMPdhjUfGcetlrZjNhhdrz9FSxMh
         zHL/g27oS8dqO1MpBj8TjdHm1av1sPJ2n/4h1yn4FmcqMcvctPR45XW0wtZkdvs3RZg6
         sIe5CVS4HnpCbFguAvvwfNv5B+e6qbIVLn7RuVoyIQ0i7F2MmTGATeHA+/rl6kBTQqsJ
         D5UxY0nr+vw/pr84NgD/polLmLehZLFPsgAvXt9RxE1wrg03dgD1kRo5Xu7XjBhJ1G+B
         9uzMMj/7ydpc5xWR87IJ2C0jhFIVexa7pOC7dYV5nfrblrTpuNx969msJUz1DwJkNZ//
         z0Ow==
X-Gm-Message-State: AOAM533LcIV2yBc3c3CBOnqPYEtcS6e8kA5eXjVcaMiMYHNJtn7TeHO6
        KfIm2HtbtlyJoD/6rwRUiJMdsG6HEoJNCt4TbdA=
X-Google-Smtp-Source: ABdhPJzdf0m+Q5EPNbYk7+u/jixkjUTi/oii9s9xTHz9U7IczNqEj2gPDN6cdR4L1DaBJSfQ0vDjAz9/xk7oiJPZaow=
X-Received: by 2002:a05:6512:1041:b0:447:7e08:6489 with SMTP id
 c1-20020a056512104100b004477e086489mr3700232lfb.592.1646934786176; Thu, 10
 Mar 2022 09:53:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <211116.8635nwr055.gmgdl@evledraar.gmail.com>
 <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com>
 <211117.86ee7f8cm4.gmgdl@evledraar.gmail.com> <CANQDOdcKzxM+M7wgxUz831SbpwGWR7gcUC8xLFM14BcCJ+60sA@mail.gmail.com>
 <211201.864k7sbdjt.gmgdl@evledraar.gmail.com> <220310.86lexilo3d.gmgdl@evledraar.gmail.com>
 <CANQDOdcJX9bYAJN4_M5-k_Ssg+kK+CVOsanXr+Xnu7B+nzfqSw@mail.gmail.com> <220310.86r179ki38.gmgdl@evledraar.gmail.com>
In-Reply-To: <220310.86r179ki38.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 10 Mar 2022 09:52:55 -0800
Message-ID: <CANQDOdf1pE+PUv_XqLobGq8Wvan-iH28RhBJFYM-NfxHKBjU+Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] Implement a batched fsync option for core.fsyncObjectFiles
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Patrick Steinhardt <ps@pks.im>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 6:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Mar 09 2022, Neeraj Singh wrote:
>
> > On Wed, Mar 9, 2022 at 3:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >>
> >> Replying to an old-ish E-Mail of mine with some more thought that came
> >> to mind after[1] (another recently resurrected fsync() thread).
> >>
> >> I wonder if there's another twist on the plan outlined in [2] that wou=
ld
> >> be both portable & efficient, i.e. the "slow" POSIX way to write files
> >> A..Z is to open/write/close/fsync each one, so we'll trigger a HW flus=
h
> >> N times.
> >>
> >> And as we've discussed, doing it just on Z will implicitly flush A..Y =
on
> >> common OS's in the wild, which we're taking advantage of here.
> >>
> >> But aside from the rename() dance in[2], what do those OS's do if you
> >> write A..Z, fsync() the "fd" for Z, and then fsync A..Y (or, presumabl=
y
> >> equivalently, in reverse order: Y..A).
> >>
> >> I'd think they'd be smart enough to know that they already implicitly
> >> flushed that data since Z was flushend, and make those fsync()'s a
> >> rather cheap noop.
> >>
> >> But I don't know, hence the question.
> >>
> >> If that's true then perhaps it's a path towards having our cake and
> >> eating it too in some cases?
> >>
> >> I.e. an FS that would flush A..Y if we flush Z would do so quickly and
> >> reliably, whereas a FS that doesn't have such an optimization might be
> >> just as slow for all of A..Y, but at least it'll be safe.
> >>
> >> 1. https://lore.kernel.org/git/220309.867d93lztw.gmgdl@evledraar.gmail=
.com/
> >> 2. https://lore.kernel.org/git/e1747ce00af7ab3170a69955b07d995d5321d6f=
3.1637020263.git.gitgitgadget@gmail.com/
> >
> > The important angle here is that we need some way to indicate to the
> > OS what A..Y is before we fsync on Z.  I.e. the OS will cache any
> > writes in memory until some sync-ish operation is done on *that
> > specific file*.  Syncing just 'Z' with no sync operations on A..Y
> > doesn't indicate that A..Y would get written out.  Apparently the bad
> > old ext3 behavior was similar to what you're proposing where a sync on
> > 'Z' would imply something about independent files.
>
> It's certainly starting to sound like I'm misunderstanding this whole
> thing, but just to clarify again I'm talking about the sort of loops
> mentioned upthread in my [1]. I.e. you have (to copy from that E-Mail):
>
>     bulk_checkin_start_make_cookie():
>     n =3D 10
>     for i in 1..n:
>         write_nth(i, fsync: 0);
>     bulk_checkin_end_commit_cookie();
>
> I.e. we have a "cookie" file in a given dir (where, in this example,
> we'd also write files A..Z). I.e. we write:
>
>     cookie
>     {A..Z}
>     cookie
>
> And then only fsync() on the "cookie" at the end, which "flushes" the
> A..Z updates on some FS's (again, all per my possibly-incorrect
> understanding).
>
> Which is why I proposed that in many/all cases we could do this,
> i.e. just the same without the "cookie" file (which AFAICT isn't needed
> per-se, but was just added to make the API a bit simpler in not needing
> to modify the relevant loops):
>
>     all_fsync =3D bulk_checkin_mode() ? 0 : fsync_turned_on_in_general();
>     end_fsync =3D bulk_checkin_mode() ? 1 : all_fsync;
>     n =3D 10;
>     for i in 1..n:
>         write_nth(i, fsync: (i =3D=3D n) ? end_fsync : all_fsync);
>
> I.e. we don't pay the cost of the fsync() as we're in the loop, but just
> for the last file, which "flushes" the rest.
>
> So far all of that's a paraphrasing of existing exchanges, but what I
> was wondering now in[2] is if we add this to this last example above:
>
>     for i in 1..n-1:
>         fsync_nth(i)
>
> Wouldn't those same OS's that are being clever about deferring the
> syncing of A..Z as a "batch" be clever enough to turn that (re-)syncing
> into a NOOP?
>
> Of course in this case we'd need to keep the fd's open and be clever
> about E[MN]FILE (i.e. "Too many open..."), or do an fsync() every Nth
> for some reasonable Nth, e.g. somewhere in the 2^10..2^12 range.
>
> But *if* this works it seems to me to be something we might be able to
> enable when "core.fsyncObjectFiles" is configured on those systems.
>
> I.e. the implicit assumption with that configuration was that if we sync
> N loose objects and then update and fsync the ref that the FS would
> queue up the ref update after the syncing of the loose objects.
>
> This new "cookie" (or my suggested "fsync last of N") is basically
> making the same assumption, just with the slight twist that some OSs/FSs
> are known to behave like that on a per-subdir basis, no?
>
> > Here's an interesting paper I recently came across that proposes the
> > interface we'd really want, 'syncv':
> > https://citeseerx.ist.psu.edu/viewdoc/download?doi=3D10.1.1.924.1168&re=
p=3Drep1&type=3Dpdf.
>
> 1. https://lore.kernel.org/git/211201.864k7sbdjt.gmgdl@evledraar.gmail.co=
m/
> 2. https://lore.kernel.org/git/220310.86lexilo3d.gmgdl@evledraar.gmail.co=
m/

On the actual FS implementations in the three common OSes I'm familiar with
(macOS, Windows, Linux), each file has its own independent data caching in =
OS
memory.  Fsyncing one of them doesn't necessarily imply writing out
the OS cache for
any other file.  Except, apparently, on ext3 in data=3Dordered mode, but
that FS is no
longer common.  On Linux, we use sync_file_range to get the OS to
write the in-memory
cache to the storage hardware, which is what makes the data
'available' to fsync.

Now, we could consider an implementation where we call sync_file_range
without the
wait flags (i.e. without SYNC_FILE_RANGE_WAIT_BEFORE and
SYNC_FILE_RANGE_WAIT_AFTER). Then we could later fsync every file (or batch=
 of
files), which might be more efficient if the OS coalesces the disk
cache flushes.  I expect
that this method is less likely to give us the desired performance on
common linux FSes,
however.

The macOS and Windows APIs are defined a bit differently from Linux.
In both those OSes,
we're actually calling fsync-equivalent APIs that are defined to write
back all the relevant data and
metadata, just without the storage cache flush.

So to summarize:
1. We need to do write(2) to get the data out of Git and into the OS
filesystem cache.
2. We need some API (macOS-fsync, Windows-NtFlushBuffersFileEx,
Linux-sync_file_range)
   to transfer the data per-file to the storage controller, but
without flushing the storage controller.
3. We need some api (macOS-F_FULLFSYNC, Windows-NtFlushBuffersFile, Linux-f=
sync)
   to push the storage controller cache to durable media. This only
needs to be done once
   at the end to push out the data made available in step (2).


Thanks,
Neeraj
