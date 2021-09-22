Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC323C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 01:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F6761159
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 01:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhIVBY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 21:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhIVBY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 21:24:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92926C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 18:23:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y28so5389546lfb.0
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nEstNFMljTHUecRi2kGA84lRK7EcZ1AzbiWA7H8eKbk=;
        b=moh0xauJKbLIgpM3hSPreFP4b9NbLBXXzdf0EUlS0lN1V5YRVqQcbC8WAj0AL/lw9n
         AHhDcmgGIwVFeGgMZc5apwYqjRfTNM+jwHIpDZHma1/eOBUNNPNI/Cfv0oidXi+HKvka
         C2xbhURtBPQg3iovN4R70IUXXbE3FbOxptcY6JtF13U/u8s3YC0Gwa4TMixjpajvo7kF
         Hs6ggwe+vn6omIlEHq88bdimu4l1qGyW9dU8zJ9oipnexdIa+X4WYxRfQ1WaMw7InaGt
         zJaKUe0GjXKdETDRe0KbpAAnjGsWXnFEnYHhPqIp67Musz9eeMWxpUsfSUR8yt5EEtd2
         bJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nEstNFMljTHUecRi2kGA84lRK7EcZ1AzbiWA7H8eKbk=;
        b=nfktKXUfu9wH41agVrIvavSkb5egSjKk/d6A1oJLG+Pj5ARPU4xoZTlWI8bBsgfp8s
         r47g9WLdR/Hlap2UEqe9t6MxDoinBUHl0p7SSoXYAbb8XbLHZykAL2+7L4DGQKgO+Q3D
         8ERfOjniGJbgucFpw3mULpgwwOrtAxQ07QqIZ5VSm1FToXCExIEeO+Zxl6Mfj3g1VbL+
         KgtCBkgpoImAt4eiKqr2fEsK0/Pty2tlKb3qiFHBo9GQXWP+QahBX2BMcX27MOeDeWMo
         FVmJNupuAyeurgbxFEHNB1r5/u1n/O2hReJyv2BYojf1GijYFn4vEinN5mNkXiutQaBr
         5I0w==
X-Gm-Message-State: AOAM530VhZlw54o9kStN7IY0fawYlXGCQfjGIChOwaKkcHz8BS0gRKrz
        vUbOs/pPdAL49pw5iRhLlhSdO+64xNBRz9aR5gg=
X-Google-Smtp-Source: ABdhPJx6rsE8lFvc0hVaXNpKsr7ryegmJ+UCRNCwglJSJrkveyAUmYU86s6bEd42ZnOCi4g6F5M1rhz6kAL9P6yN6ik=
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr18026626lfe.241.1632273803290;
 Tue, 21 Sep 2021 18:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com> <12cad737635663ed596e52f89f0f4f22f58bfe38.1632176111.git.gitgitgadget@gmail.com>
 <87mto58pkc.fsf@evledraar.gmail.com>
In-Reply-To: <87mto58pkc.fsf@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 21 Sep 2021 18:23:12 -0700
Message-ID: <CANQDOdc1bNwDYhJ8ck2cwUfKmr3064uBHFDACphW+cGZRd-6EQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] core.fsyncobjectfiles: batched disk flushes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 4:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:
>
> > When the new mode is enabled we do the following for new objects:
> >
> > 1. Create a tmp_obj_XXXX file and write the object data to it.
> > 2. Issue a pagecache writeback request and wait for it to complete.
> > 3. Record the tmp name and the final name in the bulk-checkin state for
> >    later rename.
> >
> > At the end of the entire transaction we:
> > 1. Issue a fsync against the lock file to flush the hardware writeback
> >    cache, which should by now have processed the tmp file writes.
> > 2. Rename all of the temp files to their final names.
> > 3. When updating the index and/or refs, we assume that Git will issue
> >    another fsync internal to that operation.
>
> Perhaps note too that:
>
> 4. For loose objects, refs etc. we may or may not create directories,
>    and most certainly will be updating metadata on the immediate
>    directory containing the file, but none of that's fsync()'d.
>
> > On a filesystem with a singular journal that is updated during name
> > operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
> > would expect the fsync to trigger a journal writeout so that this
> > sequence is enough to ensure that the user's data is durable by the tim=
e
> > the git command returns.
> >
> > This change also updates the macOS code to trigger a real hardware flus=
h
> > via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
> > macOS there was no guarantee of durability since a simple fsync(2) call
> > does not flush any hardware caches.
>
> There's no discussion of whether this is or isn't known to also work
> some Linux FS's, and for these OS's where this does work is this only
> for the object files themselves, or does metadata also "ride along"?
>

I unfortunately can't examine Linux kernel source code and the details
of metadata
consistency behavior across files is not something that anyone in that
group wants
to pin down. As far as I can tell, the only thing that's really
guaranteed is fsyncing
every single file you write down and its parent directory if you're
creating a new file
(which we always are).  As came up in conversation with Christoph
Hellwig elsewhere
on thread, Linux doesn't have any set of syscalls to make batch mode
safe.  It does look
like XFS would be safe if sync_file_ranges actually promised to wait
for all pagecache
writeback definitively, since it would do a "log force" to push all
the dirty metadata to
disk when we do our final fsync.

I really didn't want to say something definitive about what Linux can
or will do, since I'm
not in a position to really know or influence them.  Christoph did say
that he would be
interested in contributing a variant to this patch that would be
definitively safe on filesystems
that honor syncfs.

> > _Performance numbers_:
> >
> > Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
> > Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
> > Windows - Same host as Linux, a preview version of Windows 11.
> >         This number is from a patch later in the series.
> >
> > Adding 500 files to the repo with 'git add' Times reported in seconds.
> >
> > core.fsyncObjectFiles | Linux | Mac   | Windows
> > ----------------------|-------|-------|--------
> >                 false | 0.06  |  0.35 | 0.61
> >                 true  | 1.88  | 11.18 | 2.47
> >                 batch | 0.15  |  0.41 | 1.53
>
> Per my https://lore.kernel.org/git/87mtp5cwpn.fsf@evledraar.gmail.com
> and 6/6 in this series we've got perf tests for add/stash, but it would
> be really interesting to see how this is impacted by
> transfer.unpackLimit in cases where we may be writing packs or loose
> objects.

I'm having trouble understanding how unpackLimit is related to 'git stash'
or 'git add'. From code inspection, it doesn't look like we're using
those settings
for adding objects except from across a transport.

Are you proposing that we have a similar setting for adding objects
via 'add' using
a packfile?  I think that would be a good goal, but it might be a bit
tricky since we've
likely done a lot of the work to buffer the input objects in order to
compute their OIDs,
before we know how many objects there are to add. If the policy were
to "always add to
a packfile", it would be easier.

>
> > [...]
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
> > +     A value indicating the level of effort Git will expend in
> > +     trying to make objects added to the repo durable in the event
> > +     of an unclean system shutdown. This setting currently only
> > +     controls the object store, so updates to any refs or the
> > +     index may not be equally durable.
>
> All these mentions of "object" should really clarify that it's "loose
> objects", i.e. we always fsync pack files.
>
> > +* `false` allows data to remain in file system caches according to
> > +  operating system policy, whence it may be lost if the system loses p=
ower
> > +  or crashes.
>
> As noted in point #4 of
> https://lore.kernel.org/git/87mtp5cwpn.fsf@evledraar.gmail.com/ while
> this direction is overall an improvement over the previously flippant
> docs, they at least alluded to the context that the assumption behind
> "false" is that you don't really care about loose objects, you care
> about loose objects *and* the ref update or whatever.
>
> As I think (this is from memory) we've covered already this may have
> been all based on some old ext3 assumption, but it's probably worth
> summarizing that here, i.e. if you've got an FS with global ordered
> operations you can probably skip this, but probably not etc.
>
> > +* `true` triggers a data integrity flush for each object added to the
> > +  object store. This is the safest setting that is likely to ensure du=
rability
> > +  across all operating systems and file systems that honor the 'fsync'=
 system
> > +  call. However, this setting comes with a significant performance cos=
t on
> > +  common hardware.
>
> This is really overpromising things by omitting the fact that eve if
> we're getting this feature you've hacked up right, we're still not
> fsyncing dir entries etc (also noted above).
>
> So something that describes the narrow scope here, along with "loose
> objects" etc....
>
> > +* `batch` enables an experimental mode that uses interfaces available =
in some
> > +  operating systems to write object data with a minimal set of FLUSH C=
ACHE
> > +  (or equivalent) commands sent to the storage controller. If the oper=
ating
> > +  system interfaces are not available, this mode behaves the same as `=
true`.
> > +  This mode is expected to be safe on macOS for repos stored on HFS+ o=
r APFS
> > +  filesystems and on Windows for repos stored on NTFS or ReFS.
>
> Again, even if it's called "core.fsyncObjectFiles" if we're going to say
> "safe" we really need to say safe in what sense. Having written and
> fsync()'d the file is helping nobody if the metadata never arrives....
>

My concern with your feedback here is that this is user-facing documentatio=
n.
I'd assume that people who are not intimately familiar with both their
filesystem
and Git's internals would just be completely mystified by a long commentary=
 on
the specifics in the Config documentation. I think over time Git should foc=
us on
making this setting really guarantee durability in a meaningful way
across the entire
repository.

> > +static void do_sync_and_rename(struct string_list *fsync_state, struct=
 lock_file *lock_file)
> > +{
> > +     if (fsync_state->nr) {
>
> I think less indentation here would be nice:
>
>     if (!fsync_state->nr)
>         return;
>     /* rest of unindented body */
>

Will fix.

> Or better yet do this check in unplug_bulk_checkin(), then here:
>
>     fsync_or_die();
>     for_each_string_list_item() { ...}
>     string_list_clear(....);
>
>

I'd prefer to put it in the callee for reasons of
separation-of-concerns.  I don't want
to have the caller and callee partially implement the contract. The
compiler should
do a good enough job, since it's only one caller and will probably get
totally inilined.

> > +             struct string_list_item *rename;
> > +
> > +             /*
> > +              * Issue a full hardware flush against the lock file to e=
nsure
> > +              * that all objects are durable before any renames occur.
> > +              * The code in fsync_and_close_loose_object_bulk_checkin =
has
> > +              * already ensured that writeout has occurred, but it has=
 not
> > +              * flushed any writeback cache in the storage hardware.
> > +              */
> > +             fsync_or_die(get_lock_file_fd(lock_file), get_lock_file_p=
ath(lock_file));
> > +
> > +             for_each_string_list_item(rename, fsync_state) {
> > +                     const char *src =3D rename->string;
> > +                     const char *dst =3D rename->util;
> > +
> > +                     if (finalize_object_file(src, dst))
> > +                             die_errno(_("could not rename '%s' to '%s=
'"), src, dst);
> > +             }
> > +
> > +             string_list_clear(fsync_state, 1);
> > +     }
> > +}
> > +
> >  static int already_written(struct bulk_checkin_state *state, struct ob=
ject_id *oid)
> >  {
> >       int i;
> > @@ -256,6 +286,53 @@ static int deflate_to_pack(struct bulk_checkin_sta=
te *state,
> >       return 0;
> >  }
> >
> > +static void add_rename_bulk_checkin(struct string_list *fsync_state,
> > +                                 const char *src, const char *dst)
> > +{
> > +     string_list_insert(fsync_state, src)->util =3D xstrdup(dst);
> > +}
>
> Just has one caller, why not just inline the string_list_insert()
> call...
>

I thought about doing that before.  I'll do it.

> > +int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpf=
ile,
> > +                                           const char *filename, time_=
t mtime)
> > +{
> > +     int do_finalize =3D 1;
> > +     int ret =3D 0;
> > +
> > +     if (fsync_object_files !=3D FSYNC_OBJECT_FILES_OFF) {
>
> Let's do postive enum comparisons, and with switch() statements, so the
> compiler helps us to see if we've covered them all.
>

Ok, will switch to switch.

> > +             /*
> > +              * If we have a plugged bulk checkin, we issue a call tha=
t
> > +              * cleans the filesystem page cache but avoids a hardware=
 flush
> > +              * command. Later on we will issue a single hardware flus=
h
> > +              * before renaming files as part of do_sync_and_rename.
> > +              */
> > +             if (bulk_checkin_plugged &&
> > +                 fsync_object_files =3D=3D FSYNC_OBJECT_FILES_BATCH &&
> > +                 git_fsync(fd, FSYNC_WRITEOUT_ONLY) >=3D 0) {
> > +                     add_rename_bulk_checkin(&bulk_fsync_state, tmpfil=
e, filename);
> > +                     do_finalize =3D 0;
> > +
> > +             } else {
> > +                     fsync_or_die(fd, "loose object file");
> > +             }
> > +     }
>
> So nothing ever explicitly checks FSYNC_OBJECT_FILES_ON...?
>

Yeah, I did it this way to avoid any code duplication, but I can change to
a switch if it doesn't require too much repetition.

> > -extern int fsync_object_files;
> > +enum FSYNC_OBJECT_FILES_MODE {
> > +    FSYNC_OBJECT_FILES_OFF,
> > +    FSYNC_OBJECT_FILES_ON,
> > +    FSYNC_OBJECT_FILES_BATCH
> > +};
>
> Style: We don't use ALL_CAPS for type names in this codebase, just the
> enum labels themselves....
>
> > +extern enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
>
> ...to the point where I had to rub my eyes to see what was going on here
> ... :)
>

Sorry, Windows Developer :). Will fix.


> > -             fsync_object_files =3D git_config_bool(var, value);
> > +             if (value && !strcmp(value, "batch"))
> > +                     fsync_object_files =3D FSYNC_OBJECT_FILES_BATCH;
> > +             else if (git_config_bool(var, value))
> > +                     fsync_object_files =3D FSYNC_OBJECT_FILES_ON;
> > +             else
> > +                     fsync_object_files =3D FSYNC_OBJECT_FILES_OFF;
>
> Since the point of this setting is safety, let's explicitly check
> true/false here, use git_config_maybe_bool(), and perhaps issue a
> warning on unknown values, but maybe that would get too verbose...
>
> If we have a future "supersafe" mode, it'll get mapped to "false" on
> older versions of git, probably not a good idea...
>

 I took Junio's suggestion verbatim.  I'll try a warning if the value
exists, and is not 'batch' or <maybe bool>.


Thanks for looking at my changes so thoroughly!
-Neeraj
