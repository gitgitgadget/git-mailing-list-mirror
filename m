Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6369C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 17:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C91610CD
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 17:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhGKRDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKRDF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 13:03:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E696AC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 10:00:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m17so23334090edc.9
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sJImX7cqaTIDV8f1TBEigRlKxHks/4F1yH5GqAbgf04=;
        b=A1yJujc9GMAE0CrItuO+Pk32ukZxTv/49RU/aWqbKrOyTVxvpD9IKgwgkv26mhZwA4
         kc0LQTFFXYEUEUDILE9tB3wMWYGjNxz9mD+0E0J0KGkc7mgdnDxTrtqAFqvS3f4MNOD2
         JhPnslIZ/JZVWpvql1WeSEBa0/MJBV/DxKM9/6gak1hVgztqT5rDErLEmiYo05GIgiU4
         nRobnbJD6PZgaTRGRTkyvjCRHYM3qhA8DiZy6h8ggoEkcJL3SrnPAsh+83iLnG5zro2o
         M36IWRi9yoC/Ne8M1jUfZiEUA1xnViXJNCq4ZeIvwESZsn9Hfr473Zvnn6Isr0RQ3exa
         GohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sJImX7cqaTIDV8f1TBEigRlKxHks/4F1yH5GqAbgf04=;
        b=BUUneodb1770IJIV3Z2+fGEafUonvZUBy8agOPpaBKmBuqC8QfdEYEMG8nMJYg9iU1
         1slP37cpKj2oXlSpkgmcjV/Xnb0pAJ1S5cSBr2d5qgFo9HSjmyorks77QwTuK0ecVuYJ
         kjTlt6CEOvVeGBWHGCDIMVMsnh896qg/gCedLJKyq6JIh2HaUxihmgzbGNnivSvpBe5r
         OleSqm6Q0Izj4DCXp7NOrdYstkzziDIPp8gMqW75NhxWtEUXYGV7xqCbKILyThjbHQFz
         mHN53sjWuhBmiRfaFKF+K8hiYcw1K1DsjVNwk/txKc4csA7q+2a6Oi5huzPBbNhhQ7L4
         3FHA==
X-Gm-Message-State: AOAM530/NPZietPXaGhy78/Dv2tBSl22lk9+PZOKQEUvblF3MmM5IjiP
        W2fXR0ft1UUd8qKKjpyCjQ05UEP8IwsSWA==
X-Google-Smtp-Source: ABdhPJxZgeGid54J2WWwhoP/Oob1RglaIvAGHCi7iuw+tixHMpkSvCu4Uj+iwPX4/pz3d9lxg1tDZA==
X-Received: by 2002:aa7:c59a:: with SMTP id g26mr1258157edq.272.1626022816275;
        Sun, 11 Jul 2021 10:00:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e17sm5275879ejz.83.2021.07.11.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 10:00:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC] Bump {diff,merge}.renameLimit ?
Date:   Sun, 11 Jul 2021 18:42:49 +0200
References: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
Message-ID: <87a6ms4wgw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 10 2021, Elijah Newren wrote:

> I'm considering bumping {diff,merge}.renameLimit, which control the
> quadratic portion of rename/copy detection.  Should they be bumped?
> If so, moderately higher, or much higher?
>
> I lean towards a moderate bump for diff.renameLimit, and preferably
> more than just a moderate bump for merge.renameLimit.  I have
> calculations for what "moderate" translates to, based on a number of
> assumptions.  But there's several reasons to break with past
> guideposts for how these limits were picked.  See below for various
> arguments in each of the directions.
>
> So...thoughts?

I think the most relevant is something you didn't state: That when this
limit was introduced (well, diff.*, not merge.*) there was no progress
output in git.

We should err entirely on producing consistent and predictable results,
and not change how git works when we it hits some arbitrary limit. To
the extent that this is needed it's sufficient to opt-in to it, i.e. we
do/should show a progress bar, advice() etc. showing why we're doing
this much work, so those users can adjust the limit (or not).
