Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2384FC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 10:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0615661039
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 10:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhJLKW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhJLKW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 06:22:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69EC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 03:20:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r18so79279536edv.12
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=plqNTUg3dEzsIXnLcQP57+XGT3ZWOSrvkWaTD60x5QM=;
        b=W8VVI0Ih4pnAv4vmbnLQENc1lk00GIfnPiU54X98411KBZ6piXr1Svv2w0+SNEZaZe
         Qvvr6uoKm3h9gZXagLgbr9b7E/FYl/cGhToPLuXm7furjC2gU+ZWAiibAWGWaQf5CpdI
         1TQObsSIpe9hFMsAWk6WQLwsTfoGVN/H0+ohtaB6N/25Suq8XM3ng2jcnk6j5YItDtMH
         KDnSI5RvWB6r7gmb2Vaax/1zKN3yOMflyiGEZjXBG4fwat9bClzh0R5jsLHxsBhlGA8e
         OYCiQ51fbIOdPZ+BWtDYNB1C8X3ONKRBenTg/GgbIjelVJs3O7vXH0YZcDpxwvGBEU0Z
         WsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=plqNTUg3dEzsIXnLcQP57+XGT3ZWOSrvkWaTD60x5QM=;
        b=PBbZ5MN5kE9CI5LYm7868SCHPY/kLCYCj8e/8JmM34hXMiCKbH7kIs1mlT4F3U9GAZ
         xXbwMwxLTzZR6URo4/gxeI6YhstQ00cqbjoE7ZmgfhvbdA4ycxCL6reL7W0JJzPqZ6+H
         8p//pSJ6IIn+KHMsdEhBS9+FAjhKzxfsjhJ7bnah2zqDvkUUEPBjYZ7i9ruOyu5ZZPzT
         eKEBbmDs2qSbXzers5D4M3cm+Nwp+yGI8H91aozxm2K7u8JZhtRD/YBDWEwBoxWki4WU
         rmI+SGJ5bQHQwzqbpWQkvMQ8/xqa+iGNy8/b+Fgl6U2I9Q4VFgplw2d8oYcyyonIx/ct
         UWIQ==
X-Gm-Message-State: AOAM531sTXvpQZqZFjxYN4hgEpaXX3NV886kv5OVCgpsKpQWSX2pFRf2
        iVecyySRseVu5MQgRpZnbpA=
X-Google-Smtp-Source: ABdhPJxwFU2hpHEIxnXvU6RF452lG1UewQ/tiM9+6CQw0EzZyQs/NI9mSh+/3o/El39eaCIeiDwOnA==
X-Received: by 2002:a17:906:1290:: with SMTP id k16mr33453803ejb.566.1634034055723;
        Tue, 12 Oct 2021 03:20:55 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id os19sm2292691ejb.16.2021.10.12.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 03:20:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [External Mail]Re: why git is so slow for a tiny git push?
Date:   Tue, 12 Oct 2021 12:06:04 +0200
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
 <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
Message-ID: <87pmsak0hl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12 2021, Jeff King wrote:

> On Tue, Oct 12, 2021 at 08:04:44AM +0000, =E7=A8=8B=E6=B4=8B wrote:
>
>> I have bitmap indeed because my master server also serves as download se=
rver.
>> However I'm using git 2.17.0, and I didn't set repack.writeBitmaps
>
> On that version and without the config, then perhaps you (or somebody)
> passed "-b" to git-repack.
>
>> But why bitmaps can cause push to be slow? Do you mean that if
>> writeBitmaps is true, every push will regenerate bitmap file? If
>> that's what you mean, what I see is the only bitmap file in my repo
>> didn't change across time (the modify time is one month ago, long
>> before I run the experiment)
>
> No, it is not regenerating the on-disk bitmaps. But when deciding the
> set of objects to send, pack-objects will generate an internal bitmap
> which is the set difference of objects reachable from the pushed refs,
> minus objects reachable from the refs the other the other side told us
> they had.
>
> It uses the on-disk bitmaps as much as possible, but there may be
> commits not covered by bitmaps (either because they were pushed since
> the last repack which built bitmaps, or simply because it's too
> expensive to put a bitmap on every commit, so we sprinkle them
> throughout the commit history). In those cases we have to traverse parts
> of the object graph by walking commits and opening up trees. This can be
> expensive, and is where your time is going.
>
> Reachability bitmaps _usually_ make things faster, but they have some
> cases where they make things worse (especially if you have a ton of
> refs, or haven't repacked recently).
>
> If bitmaps are causing a problem for your push, they are likely to be
> causing problems for fetches, too. But if you want to keep them to serve
> fetches, but not use them for push, you should be able to do:
>
>   git -c pack.usebitmaps=3Dfalse push

For the last on-list discussion to (probably the same) problem, which in
turn references an even earlier one:
https://lore.kernel.org/git/878s6nfq54.fsf@evledraar.gmail.com/

I don't remember if my own report from mid-2019 said so or contradicts
this (and I didn't re-read the thread), but FWIW I *vaguely* recall that
the case I ran into *might* have had to do with a user running into this
on a shared "staging" server.

I.e. one where users logged in as their own user, cd'd to a shared git
repo they got a lock on, and ran fetch/push/deploy commands. One user
had a pack.useBitmaps=3Dtrue or equivalent in their config (or had
manually run such a repack), so there were some very old stale bitmaps
around.

This was also a setup with a gc.bigPackThreshold configured, which now
that I think about it might have made it much worse, i.e. we'd keep that
*.bitmap on the "big pack" around forever.

But more generally with these side-indexes it seems to me that the code
involved might not be considering these sorts of edge cases, i.e. my
understanding from you above is that if we have bitmaps anywhere we'll
try to in-memory use them for all the objects in play? Or that otherwise
having "partial" bitmaps leads to pathological behavior.

tl;dr: We can't assume that a config of "I like to write side-index
A/B/C/... when I repack" means that the repo is in that state *now*, but
it seems that we do.
