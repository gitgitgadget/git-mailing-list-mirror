Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5622C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiCIXLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbiCIXLD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:11:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F117B527F3
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:10:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dr20so8311728ejc.6
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 15:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2pYZ0CysfAAQ6j5bLPOhD3e521hJkZC1vbL611eMUBI=;
        b=a733uQ4JncCTU40ery2U2fulYsdt1kTYTzh9+nWn32IWtuaOXAlANz5qO05+VSeh7q
         isC8YtkVUP6F4xyIWtMjDH3mzVgbb1ifkRcwrZUu8L0cvmUjJLcZHkRDTMJkGUm+IP94
         +/RUElksBFGLx8Kw8r/chDFwi5rhitmaFih6YqKcGPOjoh5cBwAgE9jRN9Ym+sOekFUx
         DtG2BEmUq28Rw4r5o4EbTzX97ncuWrYjJ0eVN2n41fPQehc9tVXTMZUdWxEhNrKqO3vG
         6fPuDQ5uwueg6eTkkXv+Jq3jS70RoTkQsebBl+tqw0/eyipO/rMYSvowZ8JvZ1jYa8wD
         4wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2pYZ0CysfAAQ6j5bLPOhD3e521hJkZC1vbL611eMUBI=;
        b=ZLsoqoAxvVhBy1IhYsSug3uA61Sm+rP+NsDXMPNdFx51eYxp0dhd/ARwESNkJ33g3x
         HEuivt2m6GMPjNeF6YjZwXZhRqM3orXxOCMEy0XYi8nET2Y0dKS0IWJzY9WQudFEqgz+
         x6BWmhXEabPMo1eWLy2rBMhSInZ682CqChnLd017ZWxnBqyttn2Vt1CJFyKK3K6ueWtF
         nF4Dp/BrmwRSa+fuYH9bySBU+nBV8hRdIMOWaLguhkPWPbTOsjIsMHaJGjZeJChZgI6k
         pZxBQN8UqpJcb6/OqNAMzmaqhbbnDQM9q+mk4nipqA6zEwiBl9hfA620oX0pEd64eUd5
         5EwQ==
X-Gm-Message-State: AOAM530TobooUICa6UFbfMV/2fivTyBPLCQhtUDz2zJUVLwY2MeypGCL
        1sNzubWgljzQU28EB0dn2mY3pfSi/dJBBA==
X-Google-Smtp-Source: ABdhPJwrRJYz0nRL8QYB+IYYP4JaGy/dzxCJomH+hg70E/tW7iZcmWsCsKGVITOu+NUbpP34W79aKw==
X-Received: by 2002:a17:906:6a22:b0:6db:2bf6:fc09 with SMTP id qw34-20020a1709066a2200b006db2bf6fc09mr1869240ejc.752.1646867399712;
        Wed, 09 Mar 2022 15:09:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm1206530ejj.142.2022.03.09.15.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 15:09:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nS5RO-000L0J-8h;
        Thu, 10 Mar 2022 00:09:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
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
Subject: Re: [PATCH v9 0/9] Implement a batched fsync option for
 core.fsyncObjectFiles
Date:   Thu, 10 Mar 2022 00:02:49 +0100
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
 <211116.8635nwr055.gmgdl@evledraar.gmail.com>
 <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com>
 <211117.86ee7f8cm4.gmgdl@evledraar.gmail.com>
 <CANQDOdcKzxM+M7wgxUz831SbpwGWR7gcUC8xLFM14BcCJ+60sA@mail.gmail.com>
 <211201.864k7sbdjt.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <211201.864k7sbdjt.gmgdl@evledraar.gmail.com>
Message-ID: <220310.86lexilo3d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 01 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Nov 17 2021, Neeraj Singh wrote:
>
> [Very late reply, sorry]
>
>> On Tue, Nov 16, 2021 at 11:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>>
>>> On Tue, Nov 16 2021, Neeraj Singh wrote:
>>>
>>> > On Tue, Nov 16, 2021 at 12:10 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
>>> > <avarab@gmail.com> wrote:
>>> >>
>>> >>
>>> >> On Mon, Nov 15 2021, Neeraj K. Singh via GitGitGadget wrote:
>>> >>
>>> >> >  * Per [2], I'm leaving the fsyncObjectFiles configuration as is w=
ith
>>> >> >    'true', 'false', and 'batch'. This makes using old and new vers=
ions of
>>> >> >    git with 'batch' mode a little trickier, but hopefully people w=
ill
>>> >> >    generally be moving forward in versions.
>>> >> >
>>> >> > [1] See
>>> >> > https://lore.kernel.org/git/pull.1067.git.1635287730.gitgitgadget@=
gmail.com/
>>> >> > [2] https://lore.kernel.org/git/xmqqh7cimuxt.fsf@gitster.g/
>>> >>
>>> >> I really think leaving that in-place is just being unnecessarily
>>> >> cavalier. There's a lot of mixed-version environments where git is
>>> >> deployed in, and we almost never break the configuration in this way=
 (I
>>> >> think in the past always by mistake).
>>> >
>>> >> In this case it's easy to avoid it, and coming up with a less narrow
>>> >> config model[1] seems like a good idea in any case to unify the vari=
ous
>>> >> outstanding work in this area.
>>> >>
>>> >> More generally on this series, per the thread ending in [2] I really
>>> >
>>> > My primary goal in all of these changes is to move git-for-windows ov=
er to
>>> > a default of batch fsync so that it can get closer to other platforms
>>> > in performance
>>> > of 'git add' while still retaining the same level of data integrity.
>>> > I'm hoping that
>>> > most end-users are just sticking to defaults here.
>>> >
>>> > I'm happy to change the configuration schema again if there's a
>>> > consensus from the Git
>>> > community that backwards-compatibility of the configuration is
>>> > actually important to someone.
>>> >
>>> > Also, if we're doing a deeper rethink of the fsync configuration (as
>>> > prompted by this work and
>>> > Eric Wong's and Patrick Steinhardts work), do we want to retain a mode
>>> > where we fsync some
>>> > parts of the persistent repo data but not others?  If we add fsyncing
>>> > of the index in addition to the refs,
>>> > I believe we would have covered all of the critical data structures
>>> > that would be needed to find the
>>> > data that a user has added to the repo if they complete a series of
>>> > git commands and then experience
>>> > a system crash.
>>>
>>> Just talking about it is how we'll find consensus, maybe you & Junio
>>> would like to keep it as-is. I don't see why we'd expose this bad edge
>>> case in configuration handling to users when it's entirely avoidable,
>>> and we're still in the design phase.
>>
>> After trying to figure out an implementation, I have a new proposal,
>> which I've shared on the other thread [1].
>>
>> [1] https://lore.kernel.org/git/CANQDOdcdhfGtPg0PxpXQA5gQ4x9VknKDKCCi4HE=
B0Z1xgnjKzg@mail.gmail.com/
>
> This LGTM, or something simpler as Junio points out with his "too
> fine-grained?" comment as a follow-up. I'm honestly quite apathetic
> about what we end up with exactly as long as:
>
>  1. We get the people who are adding these config settings to talk & see =
if they make
>     sense in combination.
>
>  2. We avoid the trap of hard dying on older versions.
>
>>>
>>> >> don't get why we have code like this:
>>> >>
>>> >>         @@ -503,10 +504,12 @@ static void unpack_all(void)
>>> >>                 if (!quiet)
>>> >>                         progress =3D start_progress(_("Unpacking obj=
ects"), nr_objects);
>>> >>                 CALLOC_ARRAY(obj_list, nr_objects);
>>> >>         +       plug_bulk_checkin();
>>> >>                 for (i =3D 0; i < nr_objects; i++) {
>>> >>                         unpack_one(i);
>>> >>                         display_progress(progress, i + 1);
>>> >>                 }
>>> >>         +       unplug_bulk_checkin();
>>> >>                 stop_progress(&progress);
>>> >>
>>> >>                 if (delta_list)
>>> >>
>>> >> As opposed to doing an fsync on the last object we're
>>> >> processing. I.e. why do we need the step of intentionally making the
>>> >> objects unavailable in the tmp-objdir, and creating a "cookie" file =
to
>>> >> sync at the start/end, as opposed to fsyncing on the last file (which
>>> >> we're writing out anyway).
>>> >>
>>> >> 1. https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gma=
il.com/
>>> >> 2. https://lore.kernel.org/git/20211111000349.GA703@neerajsi-x1.loca=
ldomain/
>>> >
>>> > It's important to not expose an object's final name until its contents
>>> > have been fsynced
>>> > to disk. We want to ensure that wherever we crash, we won't have a
>>> > loose object that
>>> > Git may later try to open where the filename doesn't match the content
>>> > hash. I believe it's
>>> > okay for a given OID to be missing, since a later command could
>>> > recreate it, but an object
>>> > with a wrong hash looks like it would persist until we do a git-fsck.
>>>
>>> Yes, we handle that rather badly, as I mentioned in some other threads,
>>> but not doing the fsync on the last object v.s. a "cookie" file right
>>> afterwards seems like a hail-mary at best, no?
>>>
>>
>> I'm not quite grasping what you're saying here. Are you saying that
>> using a dummy
>> file instead of one of the actual objects is less likely to produce
>> the desired outcome
>> on actual filesystem implementations?
>
> [...covered below...]
>
>>> > I thought about figuring out how to sync the last object rather than =
some random
>>> > "cookie" file, but it wasn't clear to me how I'd figure out which
>>> > object is actually last
>>> > from library code in a way that doesn't burden each command with
>>> > somehow figuring
>>> > out its last object and communicating that. The 'cookie' approach
>>> > seems to lead to a cleaner
>>> > interface for callers.
>>>
>>> The above quoted code is looping through nr_objects isn't it? Can't a
>>> "do fsync" be passed down to unpack_one() when we process the last loose
>>> object?
>>
>> Are you proposing that we do something different for unpack_objects
>> versus update_index
>> and git-add?  I was hoping to keep all of the users of the batch fsync
>> functionality equivalent.
>> For the git-add workflow and update-index, we'd need to track the most
>> recent file so that we
>> can go back and fsync it.  I don't believe that syncing the last
>> object composes well with the existing
>> implementation of those commands.
>
> There's probably cases where we need the cookie. I just mean instead of
> the API being (as seen above in the quoted part), pseudocode:
>
>     # A
>     bulk_checkin_start_make_cookie():
>     n =3D 10
>     for i in 1..n:
>         write_nth(i, fsync: 0);
>     bulk_checkin_end_commit_cookie();
>
> To have it be:
>
>     # B
>     bulk_checkin_start(do_cookie: 0);
>     n =3D 10
>     for i in 1..n:
>         write_nth(i, fsync: (i =3D=3D n));
>     bulk_checkin_end();
>
> Or actually, presumably simpler as:
>
>     # C
>     all_fsync =3D bulk_checkin_mode() ? 0 : fsync_turned_on_in_general();
>     end_fsync =3D bulk_checkin_mode() ? 1 : all_fsync;
>     n =3D 10;
>     for i in 1..n:
>         write_nth(i, fsync: (i =3D=3D n) ? end_fsync : all_fsync);
>
> I.e. maybe there are cases where you really do need "A", but we're
> usually (always?) writing out N objects, and we usually know it at the
> same point where you'd want the plug_bulk_checkin/unplug_bulk_checkin,
> so just fsyncing the last object/file/ref/whatever means we don't need
> the whole ceremony of the cookie file.
>
> I don't mind it per-se, but "B" and "C" just seem a lot simpler,
> particulary since as those examples show we'll presumably want to pass
> down a "do fsync?" to these in general, and we even usually have a
> display_progress() in there.
>
> So doesn't just doing "B" or "C" eliminate the need for a cookie
> entirely?
>
> Another advantage of that is that you'll presumably want such tracking
> anyway even for the case of "A".
>
> Because as soon as you have say a batch operation of writing X objects
> and Y refs you'd want to track this anyway. I.e. either only fsync() on
> the ref write (particularly if there's just the one ref), or on the last
> ref, or for each ref and no object syncs. So this (like "C", except for
> the "do_batch" in the "end_fsync" case):
>
>     # D
>     do_batch =3D in_existing_bulk_checkin() ? 1 : 0;
>     all_fsync =3D bulk_checkin_mode() ? 0 : fsync_turned_on_in_general();
>     end_fsync =3D bulk_checkin_mode() ? do_batch : all_fsync;
>     n =3D 10;
>     for i in 1..n:
>         write_nth(i, fsync: (i =3D=3D n) ? end_fsync : all_fsync);
>
> I mean, usually we'd want the "all refs", I'm just thinking of a case
> like "git fast-import" or other known-to-the-user batch operation.
>
> Or, as in the case of my 4bc1fd6e394 (pack-objects: rename .idx files
> into place after .bitmap files, 2021-09-09) we'd want to know that we're
> writing all of say *.bitmap, *.rev where we currently fsync() all of
> them, write *.bitmap, *.rev and *.pack (not sure that one is safe)
> without fsync(), and then only fsync (or that and in-place move) the
> *.idx.

Replying to an old-ish E-Mail of mine with some more thought that came
to mind after[1] (another recently resurrected fsync() thread).

I wonder if there's another twist on the plan outlined in [2] that would
be both portable & efficient, i.e. the "slow" POSIX way to write files
A..Z is to open/write/close/fsync each one, so we'll trigger a HW flush
N times.

And as we've discussed, doing it just on Z will implicitly flush A..Y on
common OS's in the wild, which we're taking advantage of here.

But aside from the rename() dance in[2], what do those OS's do if you
write A..Z, fsync() the "fd" for Z, and then fsync A..Y (or, presumably
equivalently, in reverse order: Y..A).

I'd think they'd be smart enough to know that they already implicitly
flushed that data since Z was flushend, and make those fsync()'s a
rather cheap noop.

But I don't know, hence the question.

If that's true then perhaps it's a path towards having our cake and
eating it too in some cases?

I.e. an FS that would flush A..Y if we flush Z would do so quickly and
reliably, whereas a FS that doesn't have such an optimization might be
just as slow for all of A..Y, but at least it'll be safe.

1. https://lore.kernel.org/git/220309.867d93lztw.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/e1747ce00af7ab3170a69955b07d995d5321d6f3.163=
7020263.git.gitgitgadget@gmail.com/
