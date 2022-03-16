Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F6C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 07:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349841AbiCPHeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 03:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352638AbiCPHem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 03:34:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B26B1FA55
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 00:33:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s25so2267578lfs.10
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PL/tn7QuRPwy5A/xBKamq2Yxb2lF427HCAYKb3Sv/Vo=;
        b=jEhO5h3/WbcaP8R2RvJ+esCRlffjCAEslKyMKX3z0zTJ3hznQfOyt3aMkRcE4jc1zQ
         ausBrfrTWapG+bu9DJEADbdBv7aMNbBbStjW0FY/u0Y8dZZ4mvjhhL/H1VgNZn8to5aF
         Lg10fdLhiJ5qfK0lgkkLNMC8DCMlyZd9ykjIZ3G/HOt2BTHI9G8XZeDnigkvasmYqCk1
         6RiYOyXRr76ASd8928zGJSz9kasMEo0gHsuWu7EfK9hlTrDqPPWnkVt/2BcufECRJtVc
         dLpT64b8nFGpIQzw4zYONN/5CryqrF0PfOx5h7lcFArqu5Sc+CGmK5RCeZWCixTQqXWU
         dmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PL/tn7QuRPwy5A/xBKamq2Yxb2lF427HCAYKb3Sv/Vo=;
        b=dPAheWDidRBTJnFN3ZSgX52ZAMgf1qntiiO9Fh2/mzrbu81g8OLzbq5p9KxOKAfUoi
         NRra1Z91xHOAoLZLBq96pxKzfnuXp9KszIE/i5aOs7d0sWCG5Qsp1AeJJDOFzLvqGYMj
         LYqpZnzeKtFS17s7wUW95XmbHPUv0SCyb4l0t4+k/I//TQ4x862Abk4+QjWmEBFv/P2P
         WHDqrXCj0FyjGbnDF4WeVFB+voIVR0tVVgKyCUU9v9AW1djEjbjDwZdLCwwM2SIMxlRF
         LBf73FcIF++xDug1Za+Luj7cRUUzyAqZEtIhMqla3mB4+55oa10UIKbzTT2/hk6Dgtr9
         c1PQ==
X-Gm-Message-State: AOAM531LRH06c70GTv/yWfcqPD/JqD+3RAUlzhvtTj4Fc4DDi7jVa3dw
        jEnSh49N4uc1xAzudB8qaJ/uEEjh3mSqaVGVp1A=
X-Google-Smtp-Source: ABdhPJxl4ZmyXx2z7MROpWJ8wgSJXP1nfKBC1+SMkpbEY+C9SHDu4JmaFxTCtrRy7Je97un7RGUt7+NLysz1omqONv8=
X-Received: by 2002:a05:6512:3089:b0:448:bc39:8d26 with SMTP id
 z9-20020a056512308900b00448bc398d26mr310058lfd.241.1647416006620; Wed, 16 Mar
 2022 00:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <a77d02df626ed6dff485e1342ff7affd6999ec44.1647379859.git.gitgitgadget@gmail.com>
 <xmqqbky6bgw0.fsf@gitster.g>
In-Reply-To: <xmqqbky6bgw0.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 16 Mar 2022 00:33:15 -0700
Message-ID: <CANQDOdcak1nV1Pr9cmyk9dgEjHOH8Au92pUMskJipUodzskzqQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 15, 2022 at 10:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Preparation for adding bulk-fsync to the bulk-checkin.c infrastructure.
> >
> > * Rename 'state' variable to 'bulk_checkin_state', since we will later
> >   be adding 'bulk_fsync_objdir'.  This also makes the variable easier to
> >   find in the debugger, since the name is more unique.
> >
> > * Move the 'plugged' data member of 'bulk_checkin_state' into a separate
> >   static variable. Doing this avoids resetting the variable in
> >   finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
> >   seem to unintentionally disable the plugging functionality the first
> >   time a new packfile must be created due to packfile size limits. While
> >   disabling the plugging state only results in suboptimal behavior for
> >   the current code, it would be fatal for the bulk-fsync functionality
> >   later in this patch series.
>
> Sorry, but I am confused.  The bulk-checkin infrastructure is there
> so that we can send many little objects into a single packfile
> instead of creating many little loose object files.  Everything we
> throw at object-file.c::index_stream() will be concatenated into the
> single packfile while we are "plugged" until we get "unplugged".
>

I noticed that you invented bulk-checkin back in 2011, but I don't think your
description matches what the code actually does.  index_bulk_checkin
is only called from index_stream, which is only called from index_fd. index_fd
goes down the index_bulk_checkin path for large files (512MB by default). It
looks like the effect of the 'plug/unplug' code is to allow multiple
large blobs to
go into a single packfile rather than each getting one getting its own separate
packfile.

> My understanding of what you are doing in this series is to still
> create many little loose object files, but avoid the overhead of
> having to fsync them individually.  And I am not sure how well the
> original idea behind the bulk-checkin infrastructure to avoid
> overhead of having to create many loose objects by creating a single
> packfile (and presumably having to fsync at the end, but that is
> just a single .pack file) with your goal of still creating many
> loose object files but synching them more efficiently.
>
> Is it just the new feature is piggybacking on the existing bulk
> checkin infrastructure, even though these two have nothing in
> common?
>

I think my new usage is congruent with the existing API, which seems
to be about combining multiple add operations into a large transaction,
where we can do some cleanup operations once we're finished. In the
preexisting code, the transaction is about adding a bunch of large objects
to a single pack file (while leaving small objects loose), and then completing
the packfile when the adds are finished.

---
On a side note, I've also been thinking about how we could use a packfile
approach as an alternative means to achieve faster addition of many small
objects. It's essentially what you stated above, where we'd send our
little objects
into a pack file. But to avoid frequent repacking overhead, we might
want to reuse
the 'latest' packfile across multiple Git invocations by appending
objects to it, with
an fsync on the file at the end.

We'd need sufficient padding between objects created by different Git
invocations to
ensure that previously synced data doesn't get disturbed by later
operations.  We'd
need to rewrite the pack indexes each time, but that's at least
derived metadata, so it
doesn't need to be fsynced. To make the pack indexes more
incrementally-updatable,
we might want to have the fanout table be checksummed, with
checksummed pointers to
leaf blocks. If we detect corruption during an index lookup, we could
recreate the index
from the packfile.

Essentially the above proposal is to move away from storing loose
objects in the filesystem
and instead to index the data within Git itself.

Thanks,
Neeraj
