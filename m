Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6883C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiCJBRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbiCJBRT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 20:17:19 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E0125591
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:16:19 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id h11so5647624ljb.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 17:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HXKqsT8p8eoApeI8G7EkBAK4eaPav9QVluhkBQ8HRFw=;
        b=jA7I4t+mPGY+mK/dcF7C5ErT4iWpop0M0MCTylbVwuJfl5VvCKQfcQTc4z8+xVOVsx
         yl/XPxpiJZKVXZ2UVO1kvCf0kFBp9zJ3gQZyMhqjpPFdmWCLvYAsawIUiyb3BVygeSnH
         PUyGMmRPJYwc2bQfK3wFnA12ePoIWAVOJx0z1JX7hHemhbXX2V4L++0UH7RObdhFhcNJ
         g7evrCy8nN9ItPsFGWFRTuh/HUL1iNrIxqw+rs2XxL7dVTF+xg371QYYP6t56KhfURLg
         +C7C3ktbJoJ6pp8WTnSzHJhqVnrrJvmbUy1NTFN939JJx+K60WonYuAUiUHAnH9PWNyt
         wu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HXKqsT8p8eoApeI8G7EkBAK4eaPav9QVluhkBQ8HRFw=;
        b=4lrlQ2jqNtZw1vjjaupRIQq8aS0T6U3tomWJu4+YbA8Jfv97uXirsUB5qEZnnnxB7j
         bL8dBINdY+a9li2yZLLW74J8ubHMmq9U3Dyr9L75WTzx+mPOAv7wyPAvjwn/VH/TWpGn
         TZywdpat+CD6STuT6rHfSli6CPJVm089uh33o0vr3ASA8p6YCVGcd9vQm3wgjp0ZRS6O
         c1coqekhuYBKo7j4pmLWwwZZ7uIf2EucM3w6N5tRs/zp6mL0W5v5iPiAf1RtnLNbNaAX
         Bqhr4Xs8fNa+rzxOAoAgRd2/AaJArWXaV65geYQZBWCXPsGS0Hys8nAPcwMUWVnPushD
         zGhQ==
X-Gm-Message-State: AOAM531JthBljXgStsYWVX/y/kiY9INOpLHA8M7miTn3j5lPEBXXBQ+s
        q1nXIQrn1JgPpOEWa+Qql5r9OXJ6ED4kefB26vg=
X-Google-Smtp-Source: ABdhPJz/5uVaQqrV7o16oCKuhq3yJNUQ3Dme3SnqALlS7ahCs2DxcTte/7Crt4pPRtEpjF5UmbjgZC4euj393LU3ink=
X-Received: by 2002:a05:651c:158e:b0:248:1ce:a2a with SMTP id
 h14-20020a05651c158e00b0024801ce0a2amr1423010ljq.172.1646874978069; Wed, 09
 Mar 2022 17:16:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <211116.8635nwr055.gmgdl@evledraar.gmail.com>
 <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com>
 <211117.86ee7f8cm4.gmgdl@evledraar.gmail.com> <CANQDOdcKzxM+M7wgxUz831SbpwGWR7gcUC8xLFM14BcCJ+60sA@mail.gmail.com>
 <211201.864k7sbdjt.gmgdl@evledraar.gmail.com> <220310.86lexilo3d.gmgdl@evledraar.gmail.com>
In-Reply-To: <220310.86lexilo3d.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 9 Mar 2022 17:16:07 -0800
Message-ID: <CANQDOdcJX9bYAJN4_M5-k_Ssg+kK+CVOsanXr+Xnu7B+nzfqSw@mail.gmail.com>
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

On Wed, Mar 9, 2022 at 3:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Replying to an old-ish E-Mail of mine with some more thought that came
> to mind after[1] (another recently resurrected fsync() thread).
>
> I wonder if there's another twist on the plan outlined in [2] that would
> be both portable & efficient, i.e. the "slow" POSIX way to write files
> A..Z is to open/write/close/fsync each one, so we'll trigger a HW flush
> N times.
>
> And as we've discussed, doing it just on Z will implicitly flush A..Y on
> common OS's in the wild, which we're taking advantage of here.
>
> But aside from the rename() dance in[2], what do those OS's do if you
> write A..Z, fsync() the "fd" for Z, and then fsync A..Y (or, presumably
> equivalently, in reverse order: Y..A).
>
> I'd think they'd be smart enough to know that they already implicitly
> flushed that data since Z was flushend, and make those fsync()'s a
> rather cheap noop.
>
> But I don't know, hence the question.
>
> If that's true then perhaps it's a path towards having our cake and
> eating it too in some cases?
>
> I.e. an FS that would flush A..Y if we flush Z would do so quickly and
> reliably, whereas a FS that doesn't have such an optimization might be
> just as slow for all of A..Y, but at least it'll be safe.
>
> 1. https://lore.kernel.org/git/220309.867d93lztw.gmgdl@evledraar.gmail.co=
m/
> 2. https://lore.kernel.org/git/e1747ce00af7ab3170a69955b07d995d5321d6f3.1=
637020263.git.gitgitgadget@gmail.com/

The important angle here is that we need some way to indicate to the
OS what A..Y is before we fsync on Z.  I.e. the OS will cache any
writes in memory until some sync-ish operation is done on *that
specific file*.  Syncing just 'Z' with no sync operations on A..Y
doesn't indicate that A..Y would get written out.  Apparently the bad
old ext3 behavior was similar to what you're proposing where a sync on
'Z' would imply something about independent files.

Here's an interesting paper I recently came across that proposes the
interface we'd really want, 'syncv':
https://citeseerx.ist.psu.edu/viewdoc/download?doi=3D10.1.1.924.1168&rep=3D=
rep1&type=3Dpdf.

Thanks,
Neeraj
