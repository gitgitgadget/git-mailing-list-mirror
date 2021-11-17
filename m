Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F604C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1150E60F9B
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhKQHbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 02:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhKQHbh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 02:31:37 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED14C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 23:28:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so6533163edd.13
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 23:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VSF3Kl+ajWFRMFrU8uYfz3V6ggZDXjOG9uByXOkt9O8=;
        b=jfq3cyYSDLHcpe3xtCwghvR288/Yi6XtjZ7ZisTp62vPCNK6dYrZHiHD8zpnoMCuaq
         dKFw+yzge0JvyTQLKSfHhZJnbUyZrxpkfXVJdeArrOQO/vtMqp09cAXyvPb4EhmD4Jz9
         WzdIoSidd3VN+TbBx/HiKEYPiEkXp9AUOTsxE/YxVBSpamHnN+BKrFbnO064ZJUgYV4S
         3/LJA0CJlFRLfYgcklmryBPTfxZXjB1gulQ1sFSNxBfsDSWauno3ckjMFulnxU0DDG75
         Y2p9cVRBBWS+l3Ki5wxV7IJWkbIPuirHbM2FyoVjJQIcZae0I9vjol3OFn8ai/eHu8uO
         u2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VSF3Kl+ajWFRMFrU8uYfz3V6ggZDXjOG9uByXOkt9O8=;
        b=nvZx849fVhPGmhVF5IC8jDF5RC63/JFVRgnAyyz4FELcZfEAxadb7imOLXy4vQhLL6
         T2R+HcoUBkZHzI/ZAmfr1Lej6l/bCV8R0xGQSW19gFKhvA1sDVmSEylNmT3WV5X7nITN
         2K5HNAQKGGR8sao7rGTy2JZB3/RM1PUghp+VRt0ZwMp4x74mjsEb70VkxEIY3oeahbbs
         zrlnWT0wuYbzAHfRhoN6hfD7mQfthjZqWeExVgVmERlAAZBu8roAyw1yf9vB2d38FIwp
         P8rBMTRviRNmJN1OjVvA51YgTPDD8VbKdLu9EFFehdryI9aTOf+lFrxDgFC1cISHWM3L
         i06w==
X-Gm-Message-State: AOAM532dbkryWbNuPguCTNkingS3k2r9ibiLYLP6GYurshNL/m2j+/Xl
        YQBNIuUoJclTF2+FJYhjRAFRnlFDXZfX/w==
X-Google-Smtp-Source: ABdhPJz1emzKuJBIV9ch/CiUVJIfX0tx6WNjF5TVElIjxx1OQ46yQUF0Xsg/z/lvi8B0NkOQwm9Cew==
X-Received: by 2002:a17:907:7e8e:: with SMTP id qb14mr18519313ejc.562.1637134117749;
        Tue, 16 Nov 2021 23:28:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h10sm10778635edb.59.2021.11.16.23.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 23:28:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnFMy-0002us-0O;
        Wed, 17 Nov 2021 08:28:36 +0100
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
Date:   Wed, 17 Nov 2021 08:24:49 +0100
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
 <211116.8635nwr055.gmgdl@evledraar.gmail.com>
 <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com>
Message-ID: <211117.86ee7f8cm4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Neeraj Singh wrote:

> On Tue, Nov 16, 2021 at 12:10 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Mon, Nov 15 2021, Neeraj K. Singh via GitGitGadget wrote:
>>
>> >  * Per [2], I'm leaving the fsyncObjectFiles configuration as is with
>> >    'true', 'false', and 'batch'. This makes using old and new versions=
 of
>> >    git with 'batch' mode a little trickier, but hopefully people will
>> >    generally be moving forward in versions.
>> >
>> > [1] See
>> > https://lore.kernel.org/git/pull.1067.git.1635287730.gitgitgadget@gmai=
l.com/
>> > [2] https://lore.kernel.org/git/xmqqh7cimuxt.fsf@gitster.g/
>>
>> I really think leaving that in-place is just being unnecessarily
>> cavalier. There's a lot of mixed-version environments where git is
>> deployed in, and we almost never break the configuration in this way (I
>> think in the past always by mistake).
>
>> In this case it's easy to avoid it, and coming up with a less narrow
>> config model[1] seems like a good idea in any case to unify the various
>> outstanding work in this area.
>>
>> More generally on this series, per the thread ending in [2] I really
>
> My primary goal in all of these changes is to move git-for-windows over to
> a default of batch fsync so that it can get closer to other platforms
> in performance
> of 'git add' while still retaining the same level of data integrity.
> I'm hoping that
> most end-users are just sticking to defaults here.
>
> I'm happy to change the configuration schema again if there's a
> consensus from the Git
> community that backwards-compatibility of the configuration is
> actually important to someone.
>
> Also, if we're doing a deeper rethink of the fsync configuration (as
> prompted by this work and
> Eric Wong's and Patrick Steinhardts work), do we want to retain a mode
> where we fsync some
> parts of the persistent repo data but not others?  If we add fsyncing
> of the index in addition to the refs,
> I believe we would have covered all of the critical data structures
> that would be needed to find the
> data that a user has added to the repo if they complete a series of
> git commands and then experience
> a system crash.

Just talking about it is how we'll find consensus, maybe you & Junio
would like to keep it as-is. I don't see why we'd expose this bad edge
case in configuration handling to users when it's entirely avoidable,
and we're still in the design phase.

>> don't get why we have code like this:
>>
>>         @@ -503,10 +504,12 @@ static void unpack_all(void)
>>                 if (!quiet)
>>                         progress =3D start_progress(_("Unpacking objects=
"), nr_objects);
>>                 CALLOC_ARRAY(obj_list, nr_objects);
>>         +       plug_bulk_checkin();
>>                 for (i =3D 0; i < nr_objects; i++) {
>>                         unpack_one(i);
>>                         display_progress(progress, i + 1);
>>                 }
>>         +       unplug_bulk_checkin();
>>                 stop_progress(&progress);
>>
>>                 if (delta_list)
>>
>> As opposed to doing an fsync on the last object we're
>> processing. I.e. why do we need the step of intentionally making the
>> objects unavailable in the tmp-objdir, and creating a "cookie" file to
>> sync at the start/end, as opposed to fsyncing on the last file (which
>> we're writing out anyway).
>>
>> 1. https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.c=
om/
>> 2. https://lore.kernel.org/git/20211111000349.GA703@neerajsi-x1.localdom=
ain/
>
> It's important to not expose an object's final name until its contents
> have been fsynced
> to disk. We want to ensure that wherever we crash, we won't have a
> loose object that
> Git may later try to open where the filename doesn't match the content
> hash. I believe it's
> okay for a given OID to be missing, since a later command could
> recreate it, but an object
> with a wrong hash looks like it would persist until we do a git-fsck.

Yes, we handle that rather badly, as I mentioned in some other threads,
but not doing the fsync on the last object v.s. a "cookie" file right
afterwards seems like a hail-mary at best, no?

> I thought about figuring out how to sync the last object rather than some=
 random
> "cookie" file, but it wasn't clear to me how I'd figure out which
> object is actually last
> from library code in a way that doesn't burden each command with
> somehow figuring
> out its last object and communicating that. The 'cookie' approach
> seems to lead to a cleaner
> interface for callers.

The above quoted code is looping through nr_objects isn't it? Can't a
"do fsync" be passed down to unpack_one() when we process the last loose
object?
