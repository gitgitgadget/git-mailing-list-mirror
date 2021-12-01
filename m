Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940ADC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 20:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbhLAUds (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 15:33:48 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:45936 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhLAUdp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 15:33:45 -0500
Received: by mail-pj1-f51.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so2670445pjb.4
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 12:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ma8YUj53Yh7rIEt/Sa3Is/m90Tpntt32rlrmLlOrWng=;
        b=uzP1QHAswxUJHEquxdRZWBNyjMsXerEn14QN1MntE9Rb0KI52uVy6b0b+wQkErd1r5
         Qe/Zj70d8p9/cpEGJ91mHIZw2nBvQ7Mr7ZzI4YFi5v3h9Tj3qtTZ6lJoyBaabWeiCiuM
         2mb2mZ6JU883YCNGZDj/nY5YkydFdiKxzN34bFCiBaIBFDruHImvpEHIZnumiWSuS6d8
         TULLF2q7BFSO5rcpn4Ury9eqz192VgKAEYIhRbUH7z3BV3WuJwXG+xo/SCalzdbzAX0k
         Mb+hszPcS9UOiBfpVbhqEdlU2/7hbJyruBThVrXrOctVzSI8hpXQb4DpY4g6MOfPnzwn
         +3Jg==
X-Gm-Message-State: AOAM531b3xg472nwt2LvvJ7x7yeB6npiQAZZY1UAekdv/EggN1Snvcod
        F4dUXHwwepgT8455hRc+CBO3HJYTs/PunGlzh3Y=
X-Google-Smtp-Source: ABdhPJxYyhW+abXA7r/kdVqwRem8ylkwt43MF6ZOTJjy7fLtHH+B2Su5lL1DL6rnClry0XjftmAad78vIC3brdYpFRM=
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr635197pjq.104.1638390623604;
 Wed, 01 Dec 2021 12:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20211201053214.2902-1-sunshine@sunshineco.com> <YafQMTsU2+vLNalY@coredump.intra.peff.net>
In-Reply-To: <YafQMTsU2+vLNalY@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 15:30:12 -0500
Message-ID: <CAPig+cS3Ymnfeob0UREvpvR0w7uKA7WnVqMn+ZNYOjx35x1p-Q@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document which output goes to stdout
 vs. stderr
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 2:42 PM Jeff King <peff@peff.net> wrote:
> On Wed, Dec 01, 2021 at 12:32:14AM -0500, Eric Sunshine wrote:
> > It has long been practice in this project for a command to emit its
> > primary output to stdout so that it can be captured to a file or sent
> > down a pipe, and to emit "chatty" messages (such as those reporting
> > progress) to stderr so that they don't interfere with the primary
> > output. However, this idiomatic Unix practice is not necessarily
> > universally understood and may be at odds with other schools of thought,
> > such as the somewhat common one that only error messages should go to
> > stderr, and all other messages to stdout. Let's help newcomers by
> > documenting how stdout and stderr are used on this project.
>
> I agree with everything you wrote here and below, which I think captures
> what we want to communicate to folks adding new messages or commands.
>
> I am not quite sure _everyone_ would agree with "this idiomatic Unix
> practice" above. It does seem to be a matter of taste (it is just that
> what you wrote very much agrees with my taste :) ). And "idiomatic Unix
> practice" is probably not to be chatty at all, but I think that has been
> changing over the years.
>
> So I'm not sure if your commit message is being nicely assertive about
> its taste, or is being uncharitable to people who may have different
> tastes (but again, IMHO we should pick a direction and this seems like
> the best one to me). :)

Thanks for the feedback. I'll tone down the commit message when I
reroll to make the patch text spell out "Git command" explicitly so
that it's less likely to mislead the reader (as it misled Fabian) into
thinking the new guideline applies to all output, including test
output.
