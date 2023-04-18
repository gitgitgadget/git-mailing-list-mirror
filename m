Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CFC77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 05:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDRF6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDRF6a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 01:58:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11694682
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 22:58:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l15so4451027ljq.8
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 22:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681797504; x=1684389504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HSuZy/+OkVpf9QFc98Yn9Q5UvVZttk2Z2d4DyHYHgs=;
        b=H/baKH5bNYAMubL7Bf3vSx43TJw0Q4o3l19irUn4dH30dOHjHbDx0QVW5kHafHxnMb
         HlMHiXO6FwBhCQGv5CtpX4xQqEemcquxZlnTKtNSi27FonWq9kdSw5hsfqO1Rl0S6b9u
         seujHl/ZIs6/5sEXgZlnhYU/oNCxEkhKhtYZgA0S2AXPOIy1SQsM3JvZmnNoU3xGk2Kq
         4eImsh+Gyd9jkHGrEq1sa9PLiiWvo0JiKahmyOqRiXdCmvf9W6k1sL8aSNGIUP4Fafd8
         d36KEBg0Cgci5iNRlOj/IPXlv2MTXUQVVEqQxYUVPzZMvT3rNbSN7U1cKoPUAa5tzVqb
         rrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681797504; x=1684389504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HSuZy/+OkVpf9QFc98Yn9Q5UvVZttk2Z2d4DyHYHgs=;
        b=lru/tzdqqUXW9Vlqa7XCLZJwcgKMnIxBr+AA0G4pGkwASF5mOh/F5I5Bl1IyThlQzB
         I6QpPNiQCDAf+KAvSau9S0klHYMaIowEyhGhpToOGipI4egRX0gAFJeK1rAk+x4uE92H
         VM5/xZp2SoWt62ECjveendOQ/exEbJif0fPNcAYJizOAqoC6aiDVhx09JA+94xLfsdWn
         2KjpGaRDPGE1prGcJxAmhwdb8VIoFQSApTtESuHhqMFluHuw/hbU1Ev9KyBZUTZ2qY16
         SlCR/bMLNABwAnnegUkzYTpxZggrG7iC/aGYhuDgApYVOk9MRZ8Y5x7NVtwm2aHHt5e1
         Pi6A==
X-Gm-Message-State: AAQBX9e23gOIllRQ1l8Rhr8mUvCwm8trgPe4zAiGjXpXPPEsB5w+jAd9
        LuvpPj6tdfihmR62xRGwv0EBtEmu3daGU11y6QQhTT37
X-Google-Smtp-Source: AKy350acQBFYIVvhOZuEcut93dwtpIKHYPcsTL5XMS4QIhgzyaW4MpcrZGaGN63t8joon940GkZ41fAfDVTNnMtMzBQ=
X-Received: by 2002:a05:651c:22a:b0:2a7:a52b:123e with SMTP id
 z10-20020a05651c022a00b002a7a52b123emr441950ljn.1.1681797503832; Mon, 17 Apr
 2023 22:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com> <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <xmqqy1mqo6kv.fsf@gitster.g>
In-Reply-To: <xmqqy1mqo6kv.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Apr 2023 22:58:11 -0700
Message-ID: <CABPp-BEXfFWZ-0u4N1gU4L8o89FdJgBj_MaufzP7yGyi4GCSow@mail.gmail.com>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 8:45=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> For instance, can users pass multiple ranges?
> >
> > There's no such thing as multiple ranges for most commands (see
> > f302c1e4aa0 ("revisions(7): clarify that most commands take a single
> > revision range", 2021-05-18))
> >
> > However, users should absolutely be allowed to specify something like
> >
> >   $ git replay --onto new-base master..my-topic some-base..other-topic
> >
> > which is one revision range, and I'd expect replay to take commits in
> > the history of either my-topic or other-topic, which are not in the
> > history of either master or some-base, and replay them.
>
> It is one revision range "^master ^some-base my-topic other-topic"
> if we let traditional revision parser to work on them, and in many
> topologies, it would mean something unexpected for users who thought
> that the user gave two ranges.  E.g. some-base may be an ancestor of
> master, in which case commits in the "some-base..master" range is
> not included in the result.  Or some-base may be able to reach
> my-topic, in which case no commits from master..my-topic range
> appears in the result, etc.
>
> But should we be forever limited by the "A..B is always equivalent
> to ^A B"?
>
> Shouldn't replaying master..my-topic and some-base..other-topic,
> when some-base is an ancestor of master, replay two overlapping
> range, possibly recreating some commits twice (when some-base falls
> in between master..my-topic, for example), if the user is willing to
> accept the consequences?
>
> We can still keep the "so called 'range' is just commits that are
> reachable from a positive end and are not reachable from any
> negative end, and by definition there is no such thing as multiple
> ranges" as an option for advanced users and trigger the semantics
> when one negative end is written explicitly with ^A notation, but in
> applications like cherry-pick where it is convenient to work on
> multiple ranges, we may want to extend our worldview to allow A..B
> C..D (especially when these two are distinct ranges---imagine the
> case where B is an ancestor of C) to mean "we have two ranges, and
> we mean the union of the commits in these two ranges".

Ooh, interesting.

That could also be of use in rebase-like operations (i.e. it'd serve
as a way for the user to rebase while dropping the commits between B
and C).

One thing to be careful about is that I think we would also need
parent rewriting or some other hint that B was an ancestor of C for
this to correctly work.  Otherwise, this construction would just be
mistaken for separate branches that are both being replayed.  That may
even matter for the cherry-pick case, since cherry-picking merge
commits is part of the intended scope, preventing us from just
assuming a fully linear range of commits to handle.

> We'd need to design carefully what should happen for trickier cases
> like A..B C (does it mean the traditional "a single range of commits
> that are reachable from either B or C, but never reachable from A",
> or does it mean "the union of commits A..B that are reachable from B
> but not from A and commits C that are reachable from C all the way
> down to root"?), though.

Yes, and in things like "^D A..B C", we'd have to not only worry about
whether A limits C, but also whether ^D limits A..B.

Thanks for the interesting food for thought.
