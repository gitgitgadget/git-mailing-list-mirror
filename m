Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7FEC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE94C61BE5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhKQHJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 02:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhKQHJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 02:09:37 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F3C061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 23:06:39 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m27so4554031lfj.12
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 23:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AWI8d/LUUstZX1s3EsZV3hRqMg42ITwGcfgRoaNRRsc=;
        b=niZ9oYuazDQSWGiTPzTEMKGj5ECyrdvrD08WvyZpIxmDYETUb+3yo9FFkZ8mkqatxB
         mGy3B4/btozNfWp/Dxj+9zRT+Kdkbj8R+NptvoB1I+bW48BWtnz25NLQiKb6xUxB+3ZW
         YC2KXDwDa/dnAqKB71ZOugTXFesynQQRn+ZpVljA6Ise/D3KnA90hPjOEJY9m5TTDLF4
         WJvMauwMBvoUGdwVyXGur2+8R3j+EUp6IzxDbRBtFLAUkBveYldmfeubHd1KsHCDnWnK
         uHB71XmRyRLPYQSFvwOD82Jd/3zajE+slR/tvnP3jA0LRhgHywV0qQj0lF3dnMkRBDNS
         v6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AWI8d/LUUstZX1s3EsZV3hRqMg42ITwGcfgRoaNRRsc=;
        b=FkT0sRXe55rAkHoR+haBZjvRTeouHhoOSR6sxKgKFUZ9YZj+O3L8pHKR3qGyha0CiR
         3TUN5F0CnFUEqOOPRYo7NDOi6mK7WycqTMqHiLb/lnJb5OZPEqy3s49vPlCyNwadpWiq
         jJemb6IGYw09MqCB7z9D1RjqO6PJrpJwnasesDBObV9bAXj0OP0Eas/80xfo25/YA9yX
         dSx0Otbm1SwXMRRzoMKegi//1p6c0boAjAwRXjZv+FrZ/vaMslHCFVlVq7qJgiYS5wKP
         9ACQQPYpb86z1sLjM/dnfgx0drcagjsZsVwGql94EZ7Z0Qdq7R8UG/InXTLNgrEfj1C4
         stfQ==
X-Gm-Message-State: AOAM533EckMVQfSP2NfkU7iTLWddwCHzSCpJmEmRmzuLx/EvIL9HlJ1z
        CsM2/gDiqwOalW4d2B421aHUmBGufjqaoud2EZU=
X-Google-Smtp-Source: ABdhPJyM4UpMvulqdDn2KNA76SBEm6KTBcKeKec+zFqVCNpsaXMizr1urFH9mygRoUSqTQFeEEnzocckio8lGq+4XT0=
X-Received: by 2002:a05:6512:3682:: with SMTP id d2mr13363227lfs.442.1637132797319;
 Tue, 16 Nov 2021 23:06:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <211116.8635nwr055.gmgdl@evledraar.gmail.com>
In-Reply-To: <211116.8635nwr055.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 16 Nov 2021 23:06:25 -0800
Message-ID: <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com>
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

On Tue, Nov 16, 2021 at 12:10 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Nov 15 2021, Neeraj K. Singh via GitGitGadget wrote:
>
> >  * Per [2], I'm leaving the fsyncObjectFiles configuration as is with
> >    'true', 'false', and 'batch'. This makes using old and new versions =
of
> >    git with 'batch' mode a little trickier, but hopefully people will
> >    generally be moving forward in versions.
> >
> > [1] See
> > https://lore.kernel.org/git/pull.1067.git.1635287730.gitgitgadget@gmail=
.com/
> > [2] https://lore.kernel.org/git/xmqqh7cimuxt.fsf@gitster.g/
>
> I really think leaving that in-place is just being unnecessarily
> cavalier. There's a lot of mixed-version environments where git is
> deployed in, and we almost never break the configuration in this way (I
> think in the past always by mistake).

> In this case it's easy to avoid it, and coming up with a less narrow
> config model[1] seems like a good idea in any case to unify the various
> outstanding work in this area.
>
> More generally on this series, per the thread ending in [2] I really

My primary goal in all of these changes is to move git-for-windows over to
a default of batch fsync so that it can get closer to other platforms
in performance
of 'git add' while still retaining the same level of data integrity.
I'm hoping that
most end-users are just sticking to defaults here.

I'm happy to change the configuration schema again if there's a
consensus from the Git
community that backwards-compatibility of the configuration is
actually important to someone.

Also, if we're doing a deeper rethink of the fsync configuration (as
prompted by this work and
Eric Wong's and Patrick Steinhardts work), do we want to retain a mode
where we fsync some
parts of the persistent repo data but not others?  If we add fsyncing
of the index in addition to the refs,
I believe we would have covered all of the critical data structures
that would be needed to find the
data that a user has added to the repo if they complete a series of
git commands and then experience
a system crash.

> don't get why we have code like this:
>
>         @@ -503,10 +504,12 @@ static void unpack_all(void)
>                 if (!quiet)
>                         progress =3D start_progress(_("Unpacking objects"=
), nr_objects);
>                 CALLOC_ARRAY(obj_list, nr_objects);
>         +       plug_bulk_checkin();
>                 for (i =3D 0; i < nr_objects; i++) {
>                         unpack_one(i);
>                         display_progress(progress, i + 1);
>                 }
>         +       unplug_bulk_checkin();
>                 stop_progress(&progress);
>
>                 if (delta_list)
>
> As opposed to doing an fsync on the last object we're
> processing. I.e. why do we need the step of intentionally making the
> objects unavailable in the tmp-objdir, and creating a "cookie" file to
> sync at the start/end, as opposed to fsyncing on the last file (which
> we're writing out anyway).
>
> 1. https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.co=
m/
> 2. https://lore.kernel.org/git/20211111000349.GA703@neerajsi-x1.localdoma=
in/

It's important to not expose an object's final name until its contents
have been fsynced
to disk. We want to ensure that wherever we crash, we won't have a
loose object that
Git may later try to open where the filename doesn't match the content
hash. I believe it's
okay for a given OID to be missing, since a later command could
recreate it, but an object
with a wrong hash looks like it would persist until we do a git-fsck.

I thought about figuring out how to sync the last object rather than some r=
andom
"cookie" file, but it wasn't clear to me how I'd figure out which
object is actually last
from library code in a way that doesn't burden each command with
somehow figuring
out its last object and communicating that. The 'cookie' approach
seems to lead to a cleaner
interface for callers.

Thanks,
Neeraj
