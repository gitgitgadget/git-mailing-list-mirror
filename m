Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C10CC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 16:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351504AbiCUQyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351469AbiCUQxz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 12:53:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D836F182ACB
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 09:52:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dr20so30671789ejc.6
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=30RiNXg6l0dMGB4ABdxYSYI2Ky4Gf0WJuXyapKGtqpI=;
        b=a5vsiFIEEYwYmiOktxxqm/gEiezghGuxcPxW3rnHRgPaGbYQG/aDckZZudmYUEwRBp
         h1nUaTpkbhTrNbYLb4Ik6VT3wAVFme7kJ2jl9CkIR11uSy1s9SLt02GM8//mxT8N1knQ
         y0QQpynH11F11G+lEQH0g+vKMJviFeadC83/tTfaDZoOxKwbuS6kIVNzukfCJcShUY3B
         HNi3ZnGecDhCGi9IWB4cAEFcdBPoVJUy64i4yjT3t+rDxvqsk/NOIQ3abdJw1204Yiks
         JYPt+FJNB2Mq9qJ9jT3TIwsBuUe1Hv3a7koKcjXGnYH9kl5LS+OcSsZwWD8+qcOcAAZA
         SOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=30RiNXg6l0dMGB4ABdxYSYI2Ky4Gf0WJuXyapKGtqpI=;
        b=D8hlJGfykC6q9N5frzrb5eXzAQw1zZaaQXFq0Oafeoe2YvttpKtTHOSJ7MWC5c1FY+
         cUybNgl6E23Zn+vRnbSrsnxjWeTncEUOTDkAK65+YcOIycH0Uw42xd34CJ4UOmpuzqJr
         MTCwfV41DM8xrDGoLqwFKo5qrag6Pi/8ZslOlnpc4s7iuQRwULSQro48x9VthXmE9sbL
         gQ13qxGuSS/v1VbW3Qk7nePHoOPEhty2WxqaQBT14kpRcl28sLmYPE2qY7O07tnaCyLw
         w9/NVp3/GhKoDaGoFky5AImMeU6vZ9ICNAJ/MtlZH79IoG5f/xkKbuZMfvyPN1BokZhM
         JPVA==
X-Gm-Message-State: AOAM5338GQNDRyeaMk5iWPPGbAJiWytVWrCDHAttEkUWchSeGoVbfc8m
        O9nJdwg/xhBjnG/L9jSIzLjVhfpb7bg=
X-Google-Smtp-Source: ABdhPJzlvc3Rtbo8lN70RPDO4Xv5O4yhGp9T4Nw9zR7hRb2B5+2ehyMXtd0vScxkZT0oI3je63ugxA==
X-Received: by 2002:a17:907:7b8b:b0:6da:bad3:88b6 with SMTP id ne11-20020a1709077b8b00b006dabad388b6mr20951535ejc.360.1647881545635;
        Mon, 21 Mar 2022 09:52:25 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hp12-20020a1709073e0c00b006e02924bf20sm896560ejc.117.2022.03.21.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:52:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWLGa-000cvC-39;
        Mon, 21 Mar 2022 17:52:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
Date:   Mon, 21 Mar 2022 16:47:11 +0100
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
Message-ID: <220321.861qyv9rjr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 20 2022, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> One major source of the cost of fsync is the implied flush of the
> hardware writeback cache within the disk drive. This commit introduces
> a new `core.fsyncMethod=3Dbatch` option that batches up hardware flushes.
> It hooks into the bulk-checkin plugging and unplugging functionality,
> takes advantage of tmp-objdir, and uses the writeout-only support code.
>
> When the new mode is enabled, we do the following for each new object:
> 1. Create the object in a tmp-objdir.
> 2. Issue a pagecache writeback request and wait for it to complete.
>
> At the end of the entire transaction when unplugging bulk checkin:
> 1. Issue an fsync against a dummy file to flush the hardware writeback
>    cache, which should by now have seen the tmp-objdir writes.
> 2. Rename all of the tmp-objdir files to their final names.
> 3. When updating the index and/or refs, we assume that Git will issue
>    another fsync internal to that operation. This is not the default
>    today, but the user now has the option of syncing the index and there
>    is a separate patch series to implement syncing of refs.

Re my question in
https://lore.kernel.org/git/220310.86r179ki38.gmgdl@evledraar.gmail.com/
(which you *partially* replied to per my reading, i.e. not the
fsync_nth() question) I still don't get why the tmp-objdir part of this
is needed.

For "git stash" which is one thing sped up by this let's go over what
commands/FS ops we do. I changed the test like this:
=09
	diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
	index 3fc16944e9e..479a495c68c 100755
	--- a/t/t3903-stash.sh
	+++ b/t/t3903-stash.sh
	@@ -1383,7 +1383,7 @@ BATCH_CONFIGURATION=3D'-c core.fsync=3Dloose-object =
-c core.fsyncmethod=3Dbatch'
=09=20
	 test_expect_success 'stash with core.fsyncmethod=3Dbatch' "
	 	test_create_unique_files 2 4 fsync-files &&
	-	git $BATCH_CONFIGURATION stash push -u -- ./fsync-files/ &&
	+	strace -f git $BATCH_CONFIGURATION stash push -u -- ./fsync-files/ &&
	 	rm -f fsynced_files &&
=09=20
	 	# The files were untracked, so use the third parent,
=09
Then we get this output, with my comments, and I snipped some output:
=09=20
	$ ./t3903-stash.sh --run=3D1-4,114 -vixd 2>&1|grep --color -e 89772c935031=
c228ed67890f9 -e .git/stash -e bulk_fsync -e .git/index
	[pid 14703] access(".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/89772c935=
031c228ed67890f953c0a2b5c8316", F_OK) =3D -1 ENOENT (No such file or direct=
ory)
	[pid 14703] access(".git/objects/fb/89772c935031c228ed67890f953c0a2b5c8316=
", F_OK) =3D -1 ENOENT (No such file or directory)
	[pid 14703] link(".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/tmp_obj_bdU=
lzu", ".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/89772c935031c228ed67890=
f953c0a2b5c8316") =3D 0

Here we're creating the tmp_objdir() files. We then sync_file_range()
and close() this.

	[pid 14703] openat(AT_FDCWD, "/home/avar/g/git/t/trash directory.t3903-sta=
sh/.git/objects/tmp_objdir-bulk-fsync-rR3AQI/bulk_fsync_HsDRl7", O_RDWR|O_C=
REAT|O_EXCL, 0600) =3D 9
	[pid 14703] unlink("/home/avar/g/git/t/trash directory.t3903-stash/.git/ob=
jects/tmp_objdir-bulk-fsync-rR3AQI/bulk_fsync_HsDRl7") =3D 0

This is the flushing of the "cookie" in do_batch_fsync().

	[pid 14703] newfstatat(AT_FDCWD, ".git/objects/tmp_objdir-bulk-fsync-rR3AQ=
I/fb/89772c935031c228ed67890f953c0a2b5c8316", {st_mode=3DS_IFREG|0444, st_s=
ize=3D29, ...}, 0) =3D 0
	[pid 14703] link(".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/89772c93503=
1c228ed67890f953c0a2b5c8316", ".git/objects/fb/89772c935031c228ed67890f953c=
0a2b5c8316") =3D 0

Here we're going through the object dir migration with
unplug_bulk_checkin().

	[pid 14703] unlink(".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/89772c935=
031c228ed67890f953c0a2b5c8316") =3D 0
	newfstatat(AT_FDCWD, ".git/objects/fb/89772c935031c228ed67890f953c0a2b5c83=
16", {st_mode=3DS_IFREG|0444, st_size=3D29, ...}, AT_SYMLINK_NOFOLLOW) =3D 0
	[pid 14705] access(".git/objects/tmp_objdir-bulk-fsync-0F7DGy/fb/89772c935=
031c228ed67890f953c0a2b5c8316", F_OK) =3D -1 ENOENT (No such file or direct=
ory)
	[pid 14705] access(".git/objects/fb/89772c935031c228ed67890f953c0a2b5c8316=
", F_OK) =3D 0
	[pid 14705] utimensat(AT_FDCWD, ".git/objects/fb/89772c935031c228ed67890f9=
53c0a2b5c8316", NULL, 0) =3D 0
	[pid 14707] openat(AT_FDCWD, ".git/objects/fb/89772c935031c228ed67890f953c=
0a2b5c8316", O_RDONLY|O_CLOEXEC) =3D 9

We then update the index itself, first a temporary index.stash :

    openat(AT_FDCWD, "/home/avar/g/git/t/trash directory.t3903-stash/.git/i=
ndex.stash.19141.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) =3D 8
    openat(AT_FDCWD, ".git/index.stash.19141", O_RDONLY) =3D 9
    newfstatat(AT_FDCWD, ".git/objects/fb/89772c935031c228ed67890f953c0a2b5=
c8316", {st_mode=3DS_IFREG|0444, st_size=3D29, ...}, AT_SYMLINK_NOFOLLOW) =
=3D 0
    newfstatat(AT_FDCWD, "/home/avar/g/git/t/trash directory.t3903-stash/.g=
it/index.stash.19141.lock", {st_mode=3DS_IFREG|0644, st_size=3D927, ...}, 0=
) =3D 0
    rename("/home/avar/g/git/t/trash directory.t3903-stash/.git/index.stash=
.19141.lock", "/home/avar/g/git/t/trash directory.t3903-stash/.git/index.st=
ash.19141") =3D 0
    unlink(".git/index.stash.19141")        =3D 0

Followed by the same and a later rename of the actual index:

    [pid 19146] rename("/home/avar/g/git/t/trash directory.t3903-stash/.git=
/index.lock", "/home/avar/g/git/t/trash directory.t3903-stash/.git/index") =
=3D 0

So, my question is still why the temporary object dir migration part of
this is needed.

We are writing N loose object files, and we write those to temporary
names already.

AFAIKT we could do all of this by doing the same
tmp/rename/sync_file_range dance on the main object store.

Then instead of the "bulk_fsync" cookie file don't close() the last file
object file we write until we issue the fsync on it.

But maybe this is all needed, I just can't understand from the commit
message why the "bulk checkin" part is being done.

I think since we've been over this a few times without any success it
would really help to have some example of the smallest set of syscalls
to write a file like this safely. I.e. this is doing (pseudocode):

    /* first the bulk path */
    open("bulk/x.tmp");
    write("bulk/x.tmp");
    sync_file_range("bulk/x.tmp");
    close("bulk/x.tmp");
    rename("bulk/x.tmp", "bulk/x");
    open("bulk/y.tmp");
    write("bulk/y.tmp");
    sync_file_range("bulk/y.tmp");
    close("bulk/y.tmp");
    rename("bulk/y.tmp", "bulk/y");
    /* Rename to "real" */
    rename("bulk/x", x");
    rename("bulk/y", y");
    /* sync a cookie */
    fsync("cookie");

And I'm asking why it's not:

    /* Rename to "real" as we go */
    open("x.tmp");
    write("x.tmp");
    sync_file_range("x.tmp");
    close("x.tmp");
    rename("x.tmp", "x");
    last_fd =3D open("y.tmp"); /* don't close() the last one yet */
    write("y.tmp");
    sync_file_range("y.tmp");
    rename("y.tmp", "y");
    /* sync a cookie */
    fsync(last_fd);

Which I guess is two questions:

 A. do we need the cookie, or can we re-use the fd of the last thing we
    write?
 B. Is the bulk indirection needed?

> +		fsync_or_die(fd, "loose object file");

Unrelated nit: this API is producing sentence lego unfriendly to
translators.

Should be made to take an enum or something, so we can emit the relevant
translated message in fsync_or_die(). Imagine getting:

	fsync error on '=E6=97=A5=E6=9C=AC=E8=AA=9E=E3=81=AF=E8=A9=B1=E3=81=9B=E3=
=81=BE=E3=81=9B=E3=82=93'

Which this will do, just the other way around for non-English speakers
using the translation.

(The solution is also not to add _() here, since translators will want
to control the word order.)

> diff --git a/cache.h b/cache.h
> index 3160bc1e489..d1ae51388c9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1040,7 +1040,8 @@ extern int use_fsync;
>=20=20
>  enum fsync_method {
>  	FSYNC_METHOD_FSYNC,
> -	FSYNC_METHOD_WRITEOUT_ONLY
> +	FSYNC_METHOD_WRITEOUT_ONLY,
> +	FSYNC_METHOD_BATCH
>  };
>=20=20
>  extern enum fsync_method fsync_method;
> @@ -1767,6 +1768,11 @@ void fsync_or_die(int fd, const char *);
>  int fsync_component(enum fsync_component component, int fd);
>  void fsync_component_or_die(enum fsync_component component, int fd, cons=
t char *msg);
>=20=20
> +static inline int batch_fsync_enabled(enum fsync_component component)
> +{
> +	return (fsync_components & component) && (fsync_method =3D=3D FSYNC_MET=
HOD_BATCH);
> +}
> +
>  ssize_t read_in_full(int fd, void *buf, size_t count);
>  ssize_t write_in_full(int fd, const void *buf, size_t count);
>  ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
> diff --git a/config.c b/config.c
> index 261ee7436e0..0b28f90de8b 100644
> --- a/config.c
> +++ b/config.c
> @@ -1688,6 +1688,8 @@ static int git_default_core_config(const char *var,=
 const char *value, void *cb)
>  			fsync_method =3D FSYNC_METHOD_FSYNC;
>  		else if (!strcmp(value, "writeout-only"))
>  			fsync_method =3D FSYNC_METHOD_WRITEOUT_ONLY;
> +		else if (!strcmp(value, "batch"))
> +			fsync_method =3D FSYNC_METHOD_BATCH;
>  		else
>  			warning(_("ignoring unknown core.fsyncMethod value '%s'"), value);
>=20=20
> diff --git a/object-file.c b/object-file.c
> index 5258d9ed827..bdb0a38328f 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1895,6 +1895,8 @@ static void close_loose_object(int fd)
>=20=20
>  	if (fsync_object_files > 0)
>  		fsync_or_die(fd, "loose object file");
> +	else if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> +		fsync_loose_object_bulk_checkin(fd);
>  	else
>  		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
>  				       "loose object file");

This is related to the above comments about what minimum set of syscalls
are needed to trigger this "bulk" behavior, but it seems to me that this
whole API is avoiding just passing some new flags down to object-file.c
and friends.

For e.g. update-index that results in e.g. the "plug bulk" not being
aware of HASH_WRITE_OBJECT, so with dry-run writes and the like we'll do
the whole setup/teardown for nothing.

Which is another reason I wondered why this couldn't be a flagged passed
down to the object writing...
