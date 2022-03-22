Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9827BC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 09:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiCVJae (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiCVJac (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 05:30:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972915E772
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 02:29:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u26so5333756eda.12
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=U7gXm7FDfP5O8twbT0GAFlBCz0/9+Qgw3yum7UDdDwk=;
        b=qNkJi3yHsjuzrrVUjsCQ0lrNHACPpGc6a4r3V81NqhEVbHe1Dv8xbqArlK0vpsxPTm
         hg+VMW8zS9mrLeyXWbjxkBvl5zUb8qIk+akm/IuuOcHTa5GY9+Wuq/QQx62NPMbNdktE
         GjkX/DqwW+R5OujDwnULWdfn0wweNc2O/W+cDRY3R9nTP0qfds3qrf20sxc+2rEnicWj
         5qKtt3cF89CnnPgCwR9YaNL8rOpjZf+EgK97p2XEVHFbMHEKo0+HsySD4OdR1FIaxA8H
         EsUJGho+K60km2j/0eO7qr0R3Ci/o8EvD2IXTd3kED2cXiKe2fprN23nd701gDR8wTrK
         wu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=U7gXm7FDfP5O8twbT0GAFlBCz0/9+Qgw3yum7UDdDwk=;
        b=x1YOVH7apzxj5qFlIn/D7+SpnF7LhQm5BWLdZ0OlETQqBQMckyu8LbjO4r/5Q50Xiz
         tR+sPYBm3eaOO363GN7JqfjAWZJHEAbjZ2T0BsGBMCr4HIu944KP/UH5jrVZ/fCP4+sS
         lFdc7YhhMRFTqBesgcFpN2MmATwaRfFVg7VuhF4i6TgRWIY/BHzcP0hZ5AKQE6kqBOGx
         y2NkreZr9c2YSvAmZZZcFwjDr4ANiI3YRDTePmcEYLkgRUeMEJrEoZklx4zdL/sycuGB
         LCUeJAsmj6cCE3Jo3IdxcQHpzyPHCQoMr4V8BA1nQOyGMOMOYpAOdQ3WeW5cJ66T+HNx
         lcVQ==
X-Gm-Message-State: AOAM531ckWls74UCMKpOSjrVGTqREHfPEl11icKiHvALh3Z/3IabKThJ
        /93JfK92T6haC6GSaBRfxO9wK7UhKAdjlA==
X-Google-Smtp-Source: ABdhPJzi8U1J3fNgsv58Ro5QVaeSlPvjmgTLMXWjzju9zscYoIs0gJLtCaS15UwB9OS/QHSbKcIJHw==
X-Received: by 2002:aa7:c888:0:b0:419:166a:93e2 with SMTP id p8-20020aa7c888000000b00419166a93e2mr19128683eds.22.1647941342174;
        Tue, 22 Mar 2022 02:29:02 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm7991303ejt.50.2022.03.22.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 02:29:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWap2-000FMb-L5;
        Tue, 22 Mar 2022 10:29:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
Date:   Tue, 22 Mar 2022 09:52:49 +0100
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
 <220321.861qyv9rjr.gmgdl@evledraar.gmail.com>
 <CANQDOdez2u4oTNeETM0zLQr7Xb6XXbEuoxXPhSqGuurwQWbkHA@mail.gmail.com>
 <220321.86zgljnite.gmgdl@evledraar.gmail.com>
 <CANQDOdc+ENfKLxpQ1HZJPgzgK26DRZi2-qNkkn7B6n9qV_B-gg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <CANQDOdc+ENfKLxpQ1HZJPgzgK26DRZi2-qNkkn7B6n9qV_B-gg@mail.gmail.com>
Message-ID: <220322.86mthinxnn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Neeraj Singh wrote:

> On Mon, Mar 21, 2022 at 1:37 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Mon, Mar 21 2022, Neeraj Singh wrote:
>>
>> [Don't have time for a full reply, sorry, just something quick]
>>
>> > On Mon, Mar 21, 2022 at 9:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > [...]
>> >> So, my question is still why the temporary object dir migration part =
of
>> >> this is needed.
>> >>
>> >> We are writing N loose object files, and we write those to temporary
>> >> names already.
>> >>
>> >> AFAIKT we could do all of this by doing the same
>> >> tmp/rename/sync_file_range dance on the main object store.
>> >>
>> >
>> > Why not the main object store? We want to maintain the invariant that =
any
>> > name in the main object store refers to a file that durably has the
>> > correct contents.
>> > If we do sync_file_range and then rename, and then crash, we now have =
a file
>> > in the main object store with some SHA name, whose contents may or may=
 not
>> > match the SHA.  However, if we ensure an fsync happens before the rena=
me,
>> > a crash at any point will leave us either with no file in the main
>> > object store or
>> > with a file that is durable on the disk.
>>
>> Ah, I see.
>>
>> Why does that matter? If the "bulk" mode works as advertised we might
>> have such a corrupt loose or pack file, but we won't have anything
>> referring to it as far as reachability goes.
>>
>> I'm aware that the various code paths that handle OID writing don't deal
>> too well with it in practice to say the least, which one can try with
>> say:
>>
>>     $ echo foo | git hash-object -w --stdin
>>     45b983be36b73c0788dc9cbcb76cbb80fc7bb057
>>     $ echo | sudo tee .git/objects/45/b983be36b73c0788dc9cbcb76cbb80fc7b=
b057
>>
>> I.e. "fsck", "show" etc. will all scream bloddy murder, and re-running
>> that hash-object again even returns successful (we see it's there
>> already, and think it's OK).
>>
>
> I was under the impression that in-practice a corrupt loose-object can cr=
eate
> persistent problems in the repo for future commands, since we might not
> aggressively verify that an existing file with a certain OID really is
> valid when
> adding a new instance of the data with the same OID.

Yes, it can. As the hash-object case shows we don't even check at all.

For "incoming push" we *will* notice, but will just uselessly error
out.

I actually had some patches a while ago to turn off our own home-grown
SHA-1 collision checking.

It had the nice side effect of making it easier to recover from loose
object corruption, since you could (re-)push the corrupted OID as a
PACK, we wouldn't check (and die) on the bad loose object, and since we
take a PACK over LOOSE we'd recover:
https://lore.kernel.org/git/20181028225023.26427-5-avarab@gmail.com/

> If you don't have an fsync barrier before producing the final
> content-addressable
> name, you can't reason about "this operation happened before that operati=
on,"
> so it wouldn't really be valid to say that "we won't have anything
> referring to it as far
> as reachability goes."

That's correct, but we're discussing a feature that *does have* that
fsync barrier. So if we get an error while writing the loose objects
before the "cookie" fsync we'll presumably error out. That'll then be
followed by an fsync() of whatever makes the objects reachable.

> It's entirely possible that you'd have trees pointing to other trees
> or blobs that aren't
> valid, since data writes can be durable in any order. At this point,
> future attempts add
> the same blobs or trees might silently drop the updates.  I'm betting tha=
t's why
> core.fsyncObjectFiles was added in the first place, since someone
> observed severe
> persistent consequences for this form of corruption.

Well, you can see Linus's original rant-as-documentation for why we
added it :) I.e. the original git implementation made some heavy
linux-FS assumption about the order of writes and an fsync() flushing
any previous writes, which wasn't portable.

>> But in any case, I think it would me much easier to both review and
>> reason about this code if these concerns were split up.
>>
>> I.e. things that want no fsync at all (I'd think especially so) might
>> want to have such updates serialized in this manner, and as Junio
>> pointed out making these things inseparable as you've done creates API
>> concerns & fallout that's got nothing to do with what we need for the
>> performance gains of the bulk checkin fsyncing technique,
>> e.g. concurrent "update-index" consumers not being able to assume
>> reported objects exist as soon as they're reported.
>>
>
> I want to explicitly not respond to this concern. I don't believe this
> 100 line patch
> can be usefully split.

Leaving "usefully" aside for a second (since that's subjective), it
clearly "can". I just tried this on top of "seen":

	diff --git a/bulk-checkin.c b/bulk-checkin.c
	index a702e0ff203..9e994c4d6ae 100644
	--- a/bulk-checkin.c
	+++ b/bulk-checkin.c
	@@ -9,15 +9,12 @@
	 #include "pack.h"
	 #include "strbuf.h"
	 #include "string-list.h"
	-#include "tmp-objdir.h"
	 #include "packfile.h"
	 #include "object-store.h"
=09=20
	 static int bulk_checkin_plugged;
	 static int needs_batch_fsync;
=09=20
	-static struct tmp_objdir *bulk_fsync_objdir;
	-
	 static struct bulk_checkin_state {
	 	char *pack_tmp_name;
	 	struct hashfile *f;
	@@ -110,11 +107,6 @@ static void do_batch_fsync(void)
	 		strbuf_release(&temp_path);
	 		needs_batch_fsync =3D 0;
	 	}
	-
	-	if (bulk_fsync_objdir) {
	-		tmp_objdir_migrate(bulk_fsync_objdir);
	-		bulk_fsync_objdir =3D NULL;
	-	}
	 }
=09=20
	 static int already_written(struct bulk_checkin_state *state, struct objec=
t_id *oid)
	@@ -321,7 +313,6 @@ void fsync_loose_object_bulk_checkin(int fd)
	 	 */
	 	if (bulk_checkin_plugged &&
	 	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >=3D 0) {
	-		assert(bulk_fsync_objdir);
	 		if (!needs_batch_fsync)
	 			needs_batch_fsync =3D 1;
	 	} else {
	@@ -343,19 +334,6 @@ int index_bulk_checkin(struct object_id *oid,
	 void plug_bulk_checkin(void)
	 {
	 	assert(!bulk_checkin_plugged);
	-
	-	/*
	-	 * A temporary object directory is used to hold the files
	-	 * while they are not fsynced.
	-	 */
	-	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT)) {
	-		bulk_fsync_objdir =3D tmp_objdir_create("bulk-fsync");
	-		if (!bulk_fsync_objdir)
	-			die(_("Could not create temporary object directory for core.fsyncobjec=
tfiles=3Dbatch"));
	-
	-		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
	-	}
	-
	 	bulk_checkin_plugged =3D 1;
	 }

And then tried running:

    $ GIT_PERF_MAKE_OPTS=3D'CFLAGS=3D-O3' ./run HEAD~ HEAD -- p3900-stash.s=
h=09

And got:
=20=20=20=20
    Test                                              HEAD~              HE=
AD
    -----------------------------------------------------------------------=
---------------------
    3900.2: stash 500 files (object_fsyncing=3Dfalse)   0.56(0.08+0.09)    =
0.60(0.08+0.08) +7.1%
    3900.4: stash 500 files (object_fsyncing=3Dtrue)    14.50(0.07+0.15)   =
17.13(0.10+0.12) +18.1%
    3900.6: stash 500 files (object_fsyncing=3Dbatch)   1.14(0.08+0.11)    =
1.03(0.08+0.10) -9.6%

Now, I really don't trust that perf run to say anything except these
being in the same ballpark, but it's clearly going to be a *bit* faster
since we'll be doing fewer IOps.

As to "usefully" I really do get what you're saying that you only find
these useful when you combine the two because you'd like to have 100%
safety, and that's fair enough.

But since we are going to have a knob to turn off fsyncing entirely, and
we have this "bulk" mode which requires you to carefully reason about
your FS semantics to ascertain safety the performance/safety trade-off
is clearly something that's useful to have tweaks for.

And with "bulk" the concern about leaving behind stray corrupt objects
is entirely orthagonal to corcerns about losing a ref update, which is
the main thing we're worried about.

I also don't see how even if you're arguing that nobody would want one
without the other because everyone who cares about "bulk" cares about
this stray-corrupt-loose-but-no-ref-update case, how it has any business
being tied up in the "bulk" mode as far as the implementation goes.

That's because the same edge case is exposed by
core.fsyncObjectFiles=3Dfalse for those who are assuming the initial
"ordered" semantics.

I.e. if we're saying that before we write the ref we'd like to not
expose the WIP objects in the primary object store because they're not
fsync'd yet, how is that mode different than "bulk" if we crash while
doing that operation (before the eventual fsync()).

So I really think it's much better to split these concerns up.

I think even if you insist on the same end-state it makes the patch
progression much *easier* to reason about. We'd then solve one problem
at a time, and start with a commit where just the semantics that are
unique to "bulk" are implemented, with nothing else conflated with
those.

> [...]
>> Ok, so it's something we could do, but passing down 2-3 functions to
>> object-file.c was a hassle.
>>
>> I tried to hack that up earlier and found that it wasn't *too
>> bad*. I.e. we'd pass some "flags" about our intent, and amend various
>> functions to take "don't close this one" and pass up the fd (or even do
>> that as a global).
>>
>> In any case, having the commit message clearly document what's needed
>> for what & what's essential & just shortcut taken for the convenience of
>> the current implementation would be really useful.
>>
>> Then we can always e.g. change this later to just do the the fsync() on
>> the last of N we write.
>>
>
> I left a comment in the (now very long) commit message that indicates the
> dummy file is there to make the API simpler.

In terms of more understandable progression I also think this series
would be much easier to understand if it converted one caller without
needing the "cookie" where doing so is easy, e.g. the unpack-objects.c
caller where we're processing nr_objects, so we can just pass down a
flag to do the fsync() for i =3D=3D nr_objects.

That'll then clearly show that the whole business of having the global
state on the side is just a replacement for passing down such a flag.
