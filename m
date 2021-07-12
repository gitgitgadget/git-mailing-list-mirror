Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C755AC07E9A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23FC60FF3
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhGLQy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhGLQyy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:54:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C2C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:52:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ee25so10826994edb.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=glC8BarDKOjzTd4EKbrVjXsyvlOaYUoX7JvHFz4YDE0=;
        b=MBXeobJg+P7Ag0FUFE+8ev5KvA/0wdpKJdovdMEUr7y3rV8wn1zh3Vp2DMwFMocoj6
         uMSob+o2BkC3iIRCrgF2oZ6TMcrY2R0wkJil4hB8SLKYO/Uuyaxr8Bn84vw4jHopWhW+
         t9pRhiGX/Yu9F+h9aq5jT37M8Tss6s5DL6+hfS/yKWSEwXZLTs/ZDY7pwx5H33FxbjZ3
         6X35CaZ3GYVCC45XPwH/Gmjd+hRGkKpJ/Nn8PYxQ1mCIKqOYgyYWJkwLYodKQwS+ixyi
         gcVAi/4QExkbTC4S69HHA0/xNXC/PMFWaETiakrl3kA0gG7okNruPnAn4kCsIGhnKkrD
         bJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=glC8BarDKOjzTd4EKbrVjXsyvlOaYUoX7JvHFz4YDE0=;
        b=pzUrwaU7dOWRrxLOPcr+nq2s8trZguuGeo9KaiEndgETY07YbkA8s+rug92b71F0TJ
         JKEh5y3rSNgxDQgXt/45oboLNodOsMP6fg+u/t6Ceh3N6tkuddX3Hyyj8KDyGG/T9+Kb
         mdhsRVT4VJfu7S/jDmAIvwmKqP/J2LeTKQlsmK3kCK7w6xCs6JFQZTZiRe8DUaTi29BE
         2vRl591Nj7Qz08rAahbzbfTGLX322kAYatuJfquijspoDwEnqNLUXzMcOm9QKF/Zhw77
         osuxVXgQ8GFMDYfCU8oylsgyJeNuwyDRLI/wHRtcv2PmqCYBEFgeWizjepa28reo+mv+
         MdcA==
X-Gm-Message-State: AOAM533QhZA4NbrkEkN/cF6JcxWX85Dbv9oAwCYnIg3z5QytvZqlFmEx
        R+9n8R5CXZMW21bz7OBidKywDdLMyyaiRX+E
X-Google-Smtp-Source: ABdhPJyNwx9oiDWjmRORkUtLif3ExWTVEVL3lSerbGmRpO3jNOXauLVY2MpAFTcEGGEMkTkjShWUDw==
X-Received: by 2002:aa7:c5c3:: with SMTP id h3mr2976069eds.376.1626108724292;
        Mon, 12 Jul 2021 09:52:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l18sm3836317eds.72.2021.07.12.09.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:52:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC] Bump {diff,merge}.renameLimit ?
Date:   Mon, 12 Jul 2021 18:48:50 +0200
References: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
 <87a6ms4wgw.fsf@evledraar.gmail.com>
 <CABPp-BGE+8spsq9HZ6KNwWk_hYy5pj5vjJ8NQQuQiUN7qz7GCA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CABPp-BGE+8spsq9HZ6KNwWk_hYy5pj5vjJ8NQQuQiUN7qz7GCA@mail.gmail.com>
Message-ID: <871r834gqz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 12 2021, Elijah Newren wrote:

> Hi =C3=86var,
>
> Thanks for reading and commenting.  You certainly brought a new angle
> to the question...
>
> On Sun, Jul 11, 2021 at 10:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Sat, Jul 10 2021, Elijah Newren wrote:
>>
>> > I'm considering bumping {diff,merge}.renameLimit, which control the
>> > quadratic portion of rename/copy detection.  Should they be bumped?
>> > If so, moderately higher, or much higher?
>> >
>> > I lean towards a moderate bump for diff.renameLimit, and preferably
>> > more than just a moderate bump for merge.renameLimit.  I have
>> > calculations for what "moderate" translates to, based on a number of
>> > assumptions.  But there's several reasons to break with past
>> > guideposts for how these limits were picked.  See below for various
>> > arguments in each of the directions.
>> >
>> > So...thoughts?
>>
>> I think the most relevant is something you didn't state: That when this
>> limit was introduced (well, diff.*, not merge.*) there was no progress
>> output in git.
>
> I am convinced that good progress output is very important.  I've
> submitted multiple patches for progress output specifically for rename
> detection[1]
>
> However, I am not convinced that the lack of progress output in git
> when this limit was introduced is the most relevant thing.  If it
> were, then the lively thread when Peff posted his past series to both
> introduce the progress output for rename detection and simultaneously
> bump the limits probably would have spurred comments about not needing
> both[2].

I see I had a dead-end reply in that thread in 2011 (didn't spot the
progress patch there).

...

>> We should err entirely on producing consistent and predictable results,
>> and not change how git works when we it hits some arbitrary limit. To
>> the extent that this is needed it's sufficient to opt-in to it, i.e. we
>> do/should show a progress bar, advice() etc. showing why we're doing
>> this much work, so those users can adjust the limit (or not).

> So I've read and re-read your response multiple times, but I am still
> not sure what you're advocating for.  I think you're either advocating
> for rename detection to be turned off by default, or for a new
> "unlimited" mode to be introduced and be the default (maybe even
> redefining what the value of "0" means in order to implement this),
> but I can't tell which.  Could you clarify?

I'm advocating for an "unlimited" default as long as we have
progress/advice or whatever other output would direct users for whom
it's very slow to tweaking the setting (or not).

Anyway, yes some may disagree with this stance. I'm not saying it's
demonstrably obvious that we should have "unlimited".

I do think that it's much better if git behaves that way, i.e. that we
don't have arbitrary limits that completely change behavior once they're
tripped.

Better to spend more CPU, and if it's too slow for someone they can
tweak the limits.

> [1] In particular:
>    d6861d0258df (progress: fix progress meters when dealing with lots
> of work, 2017-11-13)
>    9268cf4a2ef6 (sequencer: show rename progress during cherry picks,
> 2017-11-13)
>    81c4bf02964e (diffcore-rename: reduce jumpiness in progress
> counters, 2020-12-11)
>
> [2] See https://lore.kernel.org/git/20110219101936.GB20577@sigill.intra.p=
eff.net/

