Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9503C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 00:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E9A60240
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 00:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhHZAup (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 20:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhHZAuo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 20:50:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C1FC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 17:49:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g13so2723479lfj.12
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j3AO3oPU7oRW1Cz/Q9qzLxjjU4BkjeIHjqlWMobZhjE=;
        b=D+3FXFN8fu0cl0q8uplqBr4CtgpkJiJCgYlr/93jEad2AUxGUjONSB2LN5J90bvyEK
         SUx86pk4rFoubNPurOZclgV57JxCW5vS4lQGwRsEEQfbkGzjrXZr+FbCQHUeCiSWv/nG
         tz9xFLGqQlew6c7m15zV4pexGDHi6Yt79dET+dUEGN9NxzsdlfQBxyJ9YMWgw/seRc82
         jM26pWnsD8W8XW88M370yepuJUYE4SthAYnPDabUKuNnNHDJB07SLjBHCnzhAXSL9fXE
         /BPcrLbtJu+Iljf+5FC048rpqJOtVGBDCiio+qVFVZ6b5RnBdyhRBtX+keXAysf5peh/
         C5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j3AO3oPU7oRW1Cz/Q9qzLxjjU4BkjeIHjqlWMobZhjE=;
        b=C+RQy6tstjNI/ZMUgUG8GkezaPAKA0OMjzCyu1wOo47SwcbgitXlKVSEHx49HB41xm
         F+sHMC3Hp+MvibcYy69CNwWBn27Lv4WuQ5tNNBgQvytdSO3Hlh1Xk3n+7ZurzevIdb9f
         1AEmvCvxy3RFWXYoaR2uOrVVDO+wYf24lcAuroEITGeFwjR9FwrRFgkGbzdCUla13+rs
         7mJuBt2UpNjxkOkm5jM03mp9iEfq8RG9YJAssu8JviS4KzN15FxfN4nGershz9DEswjh
         9V4hln+eOJqovfOh0+AvZB7GmAEhKa28nv+mALepQgAWEzouC7G/T73c6PpUjbRqKro7
         ajyQ==
X-Gm-Message-State: AOAM531NtskV5PJ9WKq/Lmynso1+EHrT+5a9OQvA1nK7qAx/+HEVaw+r
        RVpYLRkEKLsiGSxLZB6YLwviYWRswdq+0KxLS8gxjjl2fpKsbXns
X-Google-Smtp-Source: ABdhPJxPn5SP9INFS0gyYLLLiFCO/0Vy/hjUJ0vhQkICC0iIuQkGzk5pOXxfCgdNofCjpDVidHf/ZlTPrPPWHZoL2yQ=
X-Received: by 2002:a19:6459:: with SMTP id b25mr617167lfj.654.1629938996154;
 Wed, 25 Aug 2021 17:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
 <87mtp5cwpn.fsf@evledraar.gmail.com>
In-Reply-To: <87mtp5cwpn.fsf@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 25 Aug 2021 17:49:45 -0700
Message-ID: <CANQDOdd2FDNXnXLdm2FSmxUTk3oi+mQtiW2rf3YG7MJayrexPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 9:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Aug 25 2021, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > When adding many objects to a repo with core.fsyncObjectFiles set to
> > true, the cost of fsync'ing each object file can become prohibitive.
> >
> > One major source of the cost of fsync is the implied flush of the
> > hardware writeback cache within the disk drive. Fortunately, Windows,
> > MacOS, and Linux each offer mechanisms to write data from the filesyste=
m
> > page cache without initiating a hardware flush.
> >
> > This patch introduces a new 'core.fsyncObjectFiles =3D 2' option that
> > takes advantage of the bulk-checkin infrastructure to batch up hardware
> > flushes.
> >
> > When the new mode is enabled we do the following for new objects:
> >
> > 1. Create a tmp_obj_XXXX file and write the object data to it.
> > 2. Issue a pagecache writeback request and wait for it to complete.
> > 3. Record the tmp name and the final name in the bulk-checkin state for
> >    later name.
> >
> > At the end of the entire transaction we:
> > 1. Issue a fsync against the lock file to flush the hardware writeback
> >    cache, which should by now have processed the tmp file writes.
> > 2. Rename all of the temp files to their final names.
> > 3. When updating the index and/or refs, we will issue another fsync
> >    internal to that operation.
> >
> > On a filesystem with a singular journal that is updated during name
> > operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
> > would expect the fsync to trigger a journal writeout so that this
> > sequence is enough to ensure that the user's data is durable by the tim=
e
> > the git command returns.
> >
> > This change also updates the MacOS code to trigger a real hardware flus=
h
> > via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
> > MacOS there was no guarantee of durability since a simple fsync(2) call
> > does not flush any hardware caches.
>
> Thanks for working on this, good to see fsck issues picked up after some
> on-list pause.
>
> > diff --git a/Documentation/config/core.txt b/Documentation/config/core.=
txt
> > index c04f62a54a1..3b672c2db67 100644
> > --- a/Documentation/config/core.txt
> > +++ b/Documentation/config/core.txt
> > @@ -548,12 +548,17 @@ core.whitespace::
> >    errors. The default tab width is 8. Allowed values are 1 to 63.
> >
> >  core.fsyncObjectFiles::
> > -     This boolean will enable 'fsync()' when writing object files.
> > -+
> > -This is a total waste of time and effort on a filesystem that orders
> > -data writes properly, but can be useful for filesystems that do not us=
e
> > -journalling (traditional UNIX filesystems) or that only journal metada=
ta
> > -and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwriteba=
ck").
> > +     A boolean value or the number '2', indicating the level of durabi=
lity
> > +     applied to object files.
> > ++
> > +This setting controls how much effort Git makes to ensure that data ad=
ded to
> > +the object store are durable in the case of an unclean system shutdown=
. If
> > +'false', Git allows data to remain in file system caches according to =
operating
> > +system policy, whence they may be lost if the system loses power or cr=
ashes. A
> > +value of 'true' instructs Git to force objects to stable storage immed=
iately
> > +when they are added to the object store. The number '2' is an experime=
ntal
> > +value that also preserves durability but tries to perform hardware flu=
shes in a
> > +batch.
>
> Some feedback/thoughts:
>
> 0) Let's not expose "2" to users, but give it some friendly config name
> and just translate this to the enum internally.

Agreed. I'll follow suggestions from here and elsewhere to make this a
human-readable
string. Is "core.fsyncObjectFiles=3Dbatch" acceptable?

>
> 1) Your commit message says "When updating the index and/or refs[...]"
> but we're changing core.fsyncObjectFiles here, I assume that's
> summarizing existing behavior then
That's what I intended. I'll make the patch description more explicit
about that.
In general, this patch is only concerned with loose object files. It's
my assumption
that other parts of the system (like the refs db) need to perform their own=
 data
consistency and must have their own durability.

I do think that long-term, the Git community should think about having
a general transaction
mechanism with redo logging to have a consistent method for achieving
durability.

>
> 2) You say "when adding many [loose] objects to a repo[...]", and the
> test-case is "git stash push", but for e.g. accepting pushes we have
> transfer.unpackLimit.
>
> It would be interesting to see if/how this impacts performance there,
> and also if not that should at least be called out in
> documentation. I.e. users might want to set this differently on servers
> v.s. checkouts.
>
> But also, is this sort of thing something we could mitigate even more in
> commands like "git stash push" by just writing a pack instead of N loose
> objects?
>
> I don't think such questions should preclude changing the fsync
> approach, or offering more options, but they should inform our
> longer-term goals.

Dealing only/mostly in packfiles would be a great approach. I'd hope that
this fsyncing work would mostly be superseded if such a change is rolled ou=
t.
I just read about the geometric repacking stuff, and it looks reminiscent o=
f the
LSM-tree approach to databases.

>
> 3) Re some of the musings about fsync() recently in
> https://lore.kernel.org/git/877dhs20x3.fsf@evledraar.gmail.com/; is this
> method of doing not-quite-an-fsync guaranteed by some OS's / POSIX etc,
> or is it more like the initial approach before core.fsyncObjectFiles,
> i.e. the happy-go-lucky approach described in the "[...]that orders data
> writes properly[...]" documentation you're removing.

I am confident about the validity of the batched approach on Windows when
running on NTFS and ReFS, given my background as a Windows FS developer.
We are unlikely to change any mainstream data consistency behavior of
our filesystems
to be weaker, given the type of errors such changes would cause.

In Windows, we call the FS requirements to support this change
"external metadata consistency",
which states that all metadata operations that could have led to a
state later FSYNCed must be
visible after the fsync.

macOS's fsync documentation indicates that they are likely to
implement the required guarantees.
They specifically say that fsync triggers writeback or data and
metadata, but does not issue a hardware
flush.  Please see the doc at
https://developer.apple.com/library/archive/documentation/System/Conceptual=
/ManPages_iPhoneOS/man2/fsync.2.html.
It is also notable that Apple SSDs have particularly bad performance
for flush operations (we noticed this
when booting Windows through BootCamp as well).

Unfortunately my perusal of the man pages and documentation I could find do=
esn't
give me this level of confidence on typical Linux filesystems. For
instance, the notion of having to
fsync the parent directory in order to render an inode's link findable
eliminates a lot of the
advantage of this change, though we could batch those and would have
to do at most 256.

This thread is somewhat instructive, but inconclusive:
https://lwn.net/ml/linux-fsdevel/1552418820-18102-1-git-send-email-jaya@cs.=
utexas.edu/.
One conclusion from reviewing that thread is that as of then,
sync_file_ranges isn't actually enough
to make a hard guarantee about writeout occurring. See
https://lore.kernel.org/linux-fsdevel/20190319204330.GY26298@dastard/.
My hope is that the Linux FS developers have rectified that shortcoming by =
now.

>
> 4) While that documentation written by Linus long ago is rather
> flippant, I think just removing it and not replacing it with some
> discussion about how this is a trade-off v.s. real-world filesystem
> semantics isn't a good change.

I don't think the replaced documentation applies anymore to an ext4 or xfs
system with delayed allocation. Those filesystems effectively have
data=3Dwriteback
semantics because they don't need data ordering to avoid exposing unwritten
data, and so don't write the data at any particular syscall boundary
or with any particular
ordering.

I think my updated version of the documentation for "=3D false" is
accurate and more helpful
from a user perspective ("up to OS policy when your data becomes durable in
the event of an unclean shutdown").  "=3D true" also has a reasonable
description, though I
might add some verbiage indicating that this setting could be costly.

I'll take a crack at improving the batched mode documentation.

>
> 5) On a similar thought as transfer.unpackLimit in #2, I wonder if this
> fsync() setting shouldn't really be something we should be splitting
> up. I.e. maybe handle batch loose object writes one way, ref updates
> another way etc. I think moving core.fsync* to a setting like what we
> have for fsck.* and <cmd>.fsck.* is probably a better thing to do in the
> longer term.
>
> I.e. being able to do things like:
>
>     fsync.objectFiles =3D none
>     fsync.refFiles =3D cache # or "hardware"
>     receive.fsync.objectFiles =3D hardware
>     receive.fsync.refFiles =3D hardware
>
> Or whatever, i.e. we're using one hammer for all of these now, but I
> suspect most users who care about fsync care about /some/ fsync, not
> everything.
>

I disagree. I believe Git should offer a consolidated config setting
with two overall goals:

1) A consistent high-integrity setting across the entire git
index/object/ref state, primarily
for people using a repo for active development of changes. This should
roughly guarantee
that when a git command that adds data to the repo completes, the data
is durable within git,
including the refs needed to find it.

2) A lower-integrity setting useful for build/CI, maintainers who are
applying lots of patches, etc,
where it is expected that the data is available elsewhere and can be
recovered easily.

> 6) Inline comments below.
>
> > +struct object_rename {
> > +     char *src;
> > +     char *dst;
> > +};
> > +
> > +static struct bulk_rename_state {
> > +     struct object_rename *renames;
> > +     uint32_t alloc_renames;
> > +     uint32_t nr_renames;
> > +} bulk_rename_state;
>
> In a crash of git itself it seems we're going to leave some litter
> behind in the object dir now, and "git gc" won't know how to clean it
> up. I think this is going to want to just use the tmp-objdir.[ch] API,
> which might or might not need to be extended for loose objects / some
> oddities of this use-case.
>

It appears that "git prune" would take care of these files.

> Also, if you have a pair of things like this the string-list API is much
> more pleasing to use than coming up with your own encapsulation.

Thanks, I'll update to use the string-list API.

> >  static struct bulk_checkin_state {
> >       unsigned plugged:1;
> >
> > @@ -21,13 +33,15 @@ static struct bulk_checkin_state {
> >       struct pack_idx_entry **written;
> >       uint32_t alloc_written;
> >       uint32_t nr_written;
> > -} state;
>
>
> > +
> > +             free(state->renames);
> > +             memset(state, 0, sizeof(*state));
>
> So with this and other use of the "state" variable is this part of
> bulk-checkin going to become thread-unsafe, was that already the case?

Yes, this code was already thread-unsafe if we're in the "bulk checkin
plugged" mode and
that hasn't changed. Is it worth fixing this right now? Is there a
preexisting example of code
that uses thread-local-storage inside a library function and then
merges the state later? Bonus
points for only doing the thread-local stuff if alternate threads are
actually active.

> > +static void add_rename_bulk_checkin(struct bulk_rename_state *state,
> > +                                 const char *src, const char *dst)
> > +{
> > +     struct object_rename *rename;
> > +
> > +     ALLOC_GROW(state->renames, state->nr_renames + 1, state->alloc_re=
names);
> > +
> > +     rename =3D &state->renames[state->nr_renames++];
> > +     rename->src =3D xstrdup(src);
> > +     rename->dst =3D xstrdup(dst);
> > +}
>
> All boilerplate duplicating things you'd get with a string-list for free.=
..

Will fix.Thanks.

>
> > +             /*
> > +              * If we have a plugged bulk checkin, we issue a call tha=
t
> > +              * cleans the filesystem page cache but avoids a hardware=
 flush
> > +              * command. Later on we will issue a single hardware flus=
h
> > +              * before renaming files as part of do_sync_and_rename.
> > +              */
>
> So this is the sort of thing I meant by extending Linus's docs, I know
> some FS's work this way, but not all do.
>
> Also there's no guarantee in git that your .git is on one FS, so I think
> even for the FS's you have in mind this might not be an absolute
> guarantee...

This is unfortunately an issue that isn't resolvable within Git. I think th=
ere's
value in supporting batched mode for the common systems and filesystems
that do support the guarantee.  I'd like to be able to set batched mode as =
the
default on Windows eventually.  It also looks like it can be default on mac=
OS.

I think linux might be able to get to the desired semantics for default dis=
tro
filesystems with minimal changes. Perhaps this new mode in Git would provid=
e
them with a motivation to do so.
