Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D165C4167E
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 14:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbiCJOVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244955AbiCJOUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:20:09 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A040B153386
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:17:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d10so12366749eje.10
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kVlfZw2Y1Flr4GW5rXpHg68CQwcFQd3KMIL6UHMDVBU=;
        b=bSkmDSgjS7GZDMgPnoyGFemXV47cGsMLPDXyKcGR6f9fFqn3CU3YFzlkW2yVrfAs+h
         k87SY6SioNR/1evXzA+71hHnNJyt8HnacoXtR93cF74H9BV5K/15D371juXoTNZ3vZJ+
         EiOzyUw8w6JnhUFNGWsjjakx2Gbdz9L3F2xS7FP8uh3IZOBbZoW8btPTt/wIPHBWzuyy
         W6TTp1TjsSM9I/w49PIWn0ssP+f05a+RnnrMf0RJHXBZMY2FcxoS26mJ1lP4OBqYZmag
         eLqDl6devSy1lxpMQQ1Zyq1FOhSXY9WFNO9rHpCUWlEEvInEAKNkpF4rEkd1Q6JcC6F4
         MPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kVlfZw2Y1Flr4GW5rXpHg68CQwcFQd3KMIL6UHMDVBU=;
        b=W6jNpeSe0uLl0g/9Pkc+ZvrqJed6QwdUbr0aX4ZNdwnAj5dsDAZ07242X9lxrJ96Li
         oH0qQyp4ByBtFn18eL8AV/TCkIAoax8FJgm33WoeGCWoJALn2oWD4qZpF5iIDNagTP8d
         C0S4oIC9IcFyc1TWlPcY2oEklLvWDP/asbcULyOhn9IPfVK/PVT0nKs0qSpot3yI65Bi
         Jl/dvf3oasb1kiV18MW9Aq7iA1xb20OGR0vd7x49Adh6w8nYQuLJJtAV4bCmmAV7vm4C
         9P7GY9+SNzleGxXITB2yKGAR39OAPgqkUdvUBkNfeKVjs09xVQgDo9d1r7hiyCxHhmwY
         yS5g==
X-Gm-Message-State: AOAM530wG16lSBYlHoHbcbF3U1z9wdSgjwZxXVi3O5I0hRooTG1nHeTo
        L4vTJs4mCq5QmgEGh0S9jy1jGm0dsVJXCA==
X-Google-Smtp-Source: ABdhPJxYDpvhgnrUWnSvr6egzoLOZSZKdF1BbbBmf3DpGziVxJqLykrSMOYVI/vPvgqcD2Y0Sr3xHQ==
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id l8-20020a170906794800b006da64ed178emr4612190ejo.523.1646921837225;
        Thu, 10 Mar 2022 06:17:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a1-20020aa7d901000000b00416217c99bcsm2060959edr.65.2022.03.10.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:17:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSJbP-000WD5-KJ;
        Thu, 10 Mar 2022 15:17:15 +0100
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
Date:   Thu, 10 Mar 2022 15:01:34 +0100
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
 <211116.8635nwr055.gmgdl@evledraar.gmail.com>
 <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com>
 <211117.86ee7f8cm4.gmgdl@evledraar.gmail.com>
 <CANQDOdcKzxM+M7wgxUz831SbpwGWR7gcUC8xLFM14BcCJ+60sA@mail.gmail.com>
 <211201.864k7sbdjt.gmgdl@evledraar.gmail.com>
 <220310.86lexilo3d.gmgdl@evledraar.gmail.com>
 <CANQDOdcJX9bYAJN4_M5-k_Ssg+kK+CVOsanXr+Xnu7B+nzfqSw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CANQDOdcJX9bYAJN4_M5-k_Ssg+kK+CVOsanXr+Xnu7B+nzfqSw@mail.gmail.com>
Message-ID: <220310.86r179ki38.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Neeraj Singh wrote:

> On Wed, Mar 9, 2022 at 3:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> Replying to an old-ish E-Mail of mine with some more thought that came
>> to mind after[1] (another recently resurrected fsync() thread).
>>
>> I wonder if there's another twist on the plan outlined in [2] that would
>> be both portable & efficient, i.e. the "slow" POSIX way to write files
>> A..Z is to open/write/close/fsync each one, so we'll trigger a HW flush
>> N times.
>>
>> And as we've discussed, doing it just on Z will implicitly flush A..Y on
>> common OS's in the wild, which we're taking advantage of here.
>>
>> But aside from the rename() dance in[2], what do those OS's do if you
>> write A..Z, fsync() the "fd" for Z, and then fsync A..Y (or, presumably
>> equivalently, in reverse order: Y..A).
>>
>> I'd think they'd be smart enough to know that they already implicitly
>> flushed that data since Z was flushend, and make those fsync()'s a
>> rather cheap noop.
>>
>> But I don't know, hence the question.
>>
>> If that's true then perhaps it's a path towards having our cake and
>> eating it too in some cases?
>>
>> I.e. an FS that would flush A..Y if we flush Z would do so quickly and
>> reliably, whereas a FS that doesn't have such an optimization might be
>> just as slow for all of A..Y, but at least it'll be safe.
>>
>> 1. https://lore.kernel.org/git/220309.867d93lztw.gmgdl@evledraar.gmail.c=
om/
>> 2. https://lore.kernel.org/git/e1747ce00af7ab3170a69955b07d995d5321d6f3.=
1637020263.git.gitgitgadget@gmail.com/
>
> The important angle here is that we need some way to indicate to the
> OS what A..Y is before we fsync on Z.  I.e. the OS will cache any
> writes in memory until some sync-ish operation is done on *that
> specific file*.  Syncing just 'Z' with no sync operations on A..Y
> doesn't indicate that A..Y would get written out.  Apparently the bad
> old ext3 behavior was similar to what you're proposing where a sync on
> 'Z' would imply something about independent files.

It's certainly starting to sound like I'm misunderstanding this whole
thing, but just to clarify again I'm talking about the sort of loops
mentioned upthread in my [1]. I.e. you have (to copy from that E-Mail):

    bulk_checkin_start_make_cookie():
    n =3D 10
    for i in 1..n:
        write_nth(i, fsync: 0);
    bulk_checkin_end_commit_cookie();

I.e. we have a "cookie" file in a given dir (where, in this example,
we'd also write files A..Z). I.e. we write:

    cookie
    {A..Z}
    cookie

And then only fsync() on the "cookie" at the end, which "flushes" the
A..Z updates on some FS's (again, all per my possibly-incorrect
understanding).

Which is why I proposed that in many/all cases we could do this,
i.e. just the same without the "cookie" file (which AFAICT isn't needed
per-se, but was just added to make the API a bit simpler in not needing
to modify the relevant loops):

    all_fsync =3D bulk_checkin_mode() ? 0 : fsync_turned_on_in_general();
    end_fsync =3D bulk_checkin_mode() ? 1 : all_fsync;
    n =3D 10;
    for i in 1..n:
        write_nth(i, fsync: (i =3D=3D n) ? end_fsync : all_fsync);

I.e. we don't pay the cost of the fsync() as we're in the loop, but just
for the last file, which "flushes" the rest.

So far all of that's a paraphrasing of existing exchanges, but what I
was wondering now in[2] is if we add this to this last example above:

    for i in 1..n-1:
        fsync_nth(i)

Wouldn't those same OS's that are being clever about deferring the
syncing of A..Z as a "batch" be clever enough to turn that (re-)syncing
into a NOOP?

Of course in this case we'd need to keep the fd's open and be clever
about E[MN]FILE (i.e. "Too many open..."), or do an fsync() every Nth
for some reasonable Nth, e.g. somewhere in the 2^10..2^12 range.

But *if* this works it seems to me to be something we might be able to
enable when "core.fsyncObjectFiles" is configured on those systems.

I.e. the implicit assumption with that configuration was that if we sync
N loose objects and then update and fsync the ref that the FS would
queue up the ref update after the syncing of the loose objects.

This new "cookie" (or my suggested "fsync last of N") is basically
making the same assumption, just with the slight twist that some OSs/FSs
are known to behave like that on a per-subdir basis, no?

> Here's an interesting paper I recently came across that proposes the
> interface we'd really want, 'syncv':
> https://citeseerx.ist.psu.edu/viewdoc/download?doi=3D10.1.1.924.1168&rep=
=3Drep1&type=3Dpdf.

1. https://lore.kernel.org/git/211201.864k7sbdjt.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220310.86lexilo3d.gmgdl@evledraar.gmail.com/
