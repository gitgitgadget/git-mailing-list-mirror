Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B75C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 10:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiK2KjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 05:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiK2KjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 05:39:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B56B1B798
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 02:39:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v8so19197334edi.3
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vAyqlcusCf5yTZcMFOudb90o5dybuVMV2Abelim+4UM=;
        b=bxlFSfVSusKF00lHtshLyJU6xXCDQoF45zZKz/YzVRgP8+FTGQyrPMRqWON3+mbP0b
         mDrrynA2uTJJxf6ngYEaPcC7w5x62B2eRRPL5vUfjUSiYoUKg944gjnYr0p+MtSeEm6G
         BhwgC+axlfbRbBELVhurQ3U3ZRzM2aD2BB87E4Ib6FOppzkqDsghkdKKNQirSisiljeL
         G02Jj0IvNPIRkU+Y3F9tj3jKp2/4ma8HjePkt0NSZqZA3W54CyYTJVjSScENQ81xC81c
         MeH9QyYXDvL7/m44Dgws+n+eIqm70cjCX5wP1zzbSjpjbadusQoQ0aFhspsW7xfgHsFr
         0OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAyqlcusCf5yTZcMFOudb90o5dybuVMV2Abelim+4UM=;
        b=zNX9RwTj/WArbVeb/Y4oXiBk33ep5ffdksw58Dp7Vxu3ux6/uJGIsoj2yEJKfwpLYQ
         HCwFoPhp390Has1AwwnhRTEXOEuLjxwvFj0VOWV0BbpwytTS21p5MFcokCrqAxb1ZxuO
         a+n0mmS6G6QQyNfqFtHT9GfKlVHOFsLcTv7UpacJ7bQS2qiUqWkWZnlRlqzlet+r3KC8
         EOHxJtGNfhd9cep1/KQz3SwUfgzs4JJpl/bEJeopOrNYr9hbI0SjmFYFqtHfWgTiaTQj
         YfMucwEmTRke+SFrcx4BZebg0tzoY4DmNFtYya8UnCSLbyCpE2WVw4jiGBvkKEVyYa3m
         51kQ==
X-Gm-Message-State: ANoB5pkw6bHpvtcQnWUbJuErVVojtfnxhNSQyViaB9F0qzWkuZqxd3qH
        pADO/8f59cgAziJmOjYZ37A=
X-Google-Smtp-Source: AA0mqf5zZFltQMpZfTen3N5GwRrsGbDImpt9MWM9LOJ8CswjRWNfrIc+EKjy3xvPYWfcZpIBVNx76A==
X-Received: by 2002:a05:6402:e9c:b0:458:d064:a8c2 with SMTP id h28-20020a0564020e9c00b00458d064a8c2mr51441335eda.346.1669718353368;
        Tue, 29 Nov 2022 02:39:13 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kx12-20020a170907774c00b0078c1e174e11sm5947021ejc.136.2022.11.29.02.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 02:39:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozy1A-001N36-19;
        Tue, 29 Nov 2022 11:39:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Date:   Tue, 29 Nov 2022 11:25:12 +0100
References: <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de>
        <xmqqv8mz5ras.fsf@gitster.g>
        <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
        <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
        <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
        <221128.865yezkule.gmgdl@evledraar.gmail.com>
        <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
        <2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de>
        <221128.86o7sqkjcj.gmgdl@evledraar.gmail.com>
        <0b86ae8b-5523-3857-cdba-12275f727cde@web.de>
        <Y4VfrsYwWkestQ05@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y4VfrsYwWkestQ05@coredump.intra.peff.net>
Message-ID: <221129.86bkoqjb8v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Jeff King wrote:

> On Mon, Nov 28, 2022 at 10:57:02PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> >> diff --git a/revision.c b/revision.c
>> >> index 439e34a7c5..6a51ef9418 100644
>> >> --- a/revision.c
>> >> +++ b/revision.c
>> >> @@ -3055,6 +3055,7 @@ void release_revisions(struct rev_info *revs)
>> >>  	release_revisions_mailmap(revs->mailmap);
>> >>  	free_grep_patterns(&revs->grep_filter);
>> >>  	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
>> >> +	FREE_AND_NULL(revs->diffopt.parseopts);
>> >>  	diff_free(&revs->pruning);
>> >>  	reflog_walk_info_release(revs->reflog_info);
>> >>  	release_revisions_topo_walk_info(revs->topo_walk_info);
>> >
>> > At this point I'm unclear on what & why this is needed? I.e. once we
>> > narrowly fix the >1 "--filter" options what still fails?
>>=20
>> As I wrote: A call to an initialization function followed by a call to a
>> cleanup function and nothing else shouldn't leak.  There are examples of
>> repo_init_revisions()+release_revisions() without setup_revisions() or
>> diff_setup_done() beyond pack-objects.  I mentioned prune, but there are
>> more, e.g. in sequencer.c.
>
> I tend to agree with you; an init+release combo should release all
> memory. We _can_ work around it in the caller here, but I think we are
> better to correct the root cause.
>
> I do think what =C3=86var is saying is: once we have fixed the bug, why a=
re
> more changes needed? I.e., why would we get rid of the lazy-init. IMHO
> the answer is that the lazy-init is a more complex pattern, and requires
> more boilerplate code (which can lead to more bugs, as we saw). So once
> the bug is fixed, this is purely about cleanup/simplification (if one
> ignores the C-standard issues), but I tend to think it is one worth
> doing.
>
> (Apologies to =C3=86var if I'm mis-stating your position).

My position isn't that it isn't worth doing, but that we can clearly
proceed in smaller steps here, and changing one thing at a time is
better.

So far in this thread we've had, in relation to 3/3 (and I may have lost
track of some points made):

1. It's fixing the bug where you provide --filter N times
2. It's refactoring the "lazy init" to "non-lazy init"
3. It's refactoring the code to avoid relying on the J.5.7 extension in C99.
4. Due to #2 we run into more leaks
5. A dozen or so test files fail due to #2. Are we digressing to fix the
   root cause of the leak(s), or un-marking those tests as passing
   leak-free & losing test coverage?

As
https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
shows we can do #1 as a stand-alone change.

I'm not saying the rest of this isn't worth pursuing, except to point
out in
https://lore.kernel.org/git/221128.86zgcbl0pe.gmgdl@evledraar.gmail.com/
that #2 can be split off from #3.
