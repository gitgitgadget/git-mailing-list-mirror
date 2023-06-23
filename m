Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FDEB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 06:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFWGdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 02:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjFWGdl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 02:33:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165071BCC
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 23:33:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f769c37d26so255589e87.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687502017; x=1690094017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg/3VibzgyY2X2rg39c/7WHqr0AR3fBydp01daepJtE=;
        b=I/urlREA3zg604q2/VwjRZbHox9Y/PVtX2z/dyMy2ALdSvg807qWi536DBLo84buv+
         UWjV5y1NwM7Vj/xQq7Q2d/DFhCDb82qUoCXZnXtN6AHVPkAvqhnXDyGo7Vtq+3BuQGps
         Viim1j9qX/mP3711fJDJOWAZf9QZ5EYIYZNUyiWM8hfEheGtoVk/T+JnTFkpwYCmDWMP
         ujTST7lxTu3Bwr1pYpHbZvIdA5zjsnmqMG5Jea4W+qdtesTpAQKEgzyq7Na0+X8eLEhL
         hM2V6RDYke/XvC5peFWU3uEq+5seRl3b8wkCs4ThkBkrOYNuMiHsvZewJIfgbIxL5Zqd
         Hjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687502017; x=1690094017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg/3VibzgyY2X2rg39c/7WHqr0AR3fBydp01daepJtE=;
        b=lBkibG/wzuF2XFkkM76p1hWnM/iZcdFFNUpG/1FEDGgfyqi1j9+czOuRbk3mUI6z0t
         XGrbd9OKZREOKtQEwX6ZeNQQkTfT0d+eVQDjUhC80Dl/HXEHx7Piokjio4qgQoMJOKPn
         WfH//agDkWyifRfc+hrtfVQm3mXvOrNXa2t2sX3do3xAypr3eYLNBFfjDck9b37Nr3Nc
         yXmnkPVSD01ZufjDbtQFPHE7yadgqQtTxUCF2Y2d7j9S12HDb8eEzE9En+Rz41m4UM29
         pJ5wS6oz3bmsr87jHF1vbmJYxDLcPHHmv+ruQGmtSOkhlxx7YT6j7F7EhNjdnRhuwIbT
         jCIA==
X-Gm-Message-State: AC+VfDz6wS+baKsZWb1pd+jO7VGc1uSEjNxy1LgHj5rGjZI2hRiYD9x3
        P8QlvxBgkZqhWZJmjXue2P4wtJKTI/q9Y4zBdpcJWzguoLm8Og==
X-Google-Smtp-Source: ACHHUZ7OUpf5O4XRaHio5yoZmzPbHQY6NUgBo1Eby0Rfoj3NJLbiVLap3kEGC7/ccam/CTbYT+pcFnu6uuhTGaIhFYU=
X-Received: by 2002:a05:6512:214c:b0:4f9:61a2:3592 with SMTP id
 s12-20020a056512214c00b004f961a23592mr2727545lfr.35.1687502016909; Thu, 22
 Jun 2023 23:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqedm5k7dx.fsf@gitster.g> <20230621085526.GA920315@coredump.intra.peff.net>
 <xmqqttv0hhjv.fsf@gitster.g> <20230621202642.GA1423@coredump.intra.peff.net> <xmqqjzvwfp6f.fsf@gitster.g>
In-Reply-To: <xmqqjzvwfp6f.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 22 Jun 2023 23:33:24 -0700
Message-ID: <CABPp-BEQ0_UfUbdeFetCsvAnpO_=mvmjQk8JS0trKJtCL=uh1A@mail.gmail.com>
Subject: Re: bug in en/header-split-cache-h-part-3, was Re: What's cooking in
 git.git (Jun 2023, #05; Tue, 20)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 3:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Yeah. I guess the real build problem is actually in the merge of split-=
2
> > (it conflicted with a simultaneous topic, hence the fix coming in the
> > merge). So another option to address that here would be to amend the
> > 4bd872e0ed (Merge branch 'en/header-split-cache-h-part-2' into
> > en/header-split-cache-h-part-3, 2023-05-08) to include that fixup.
> >
> > As for the others, I'd consider:
> >
> >   1. (optional) Drop the #ifndef at the very start of the series, befor=
e
> >      we touch anything, with the rationale that it is not doing anythin=
g
> >      and masks errors. I don't _think_ this can ever backfire, because
> >      we unconditionally set DEFAULT_GIT_TEMPLATE_DIR (unlike some other
> >      things like DEFAULT_PAGER, where the Makefile might leave it
> >      unset). But we can also leave this out, or do it as a separate
> >      topic, if we want to minimize changes / risk of screwing something
> >      up.
> >
> >   2. Squash the Makefile fix into the "adopt shared init-db" patch
> >      (currently 0d652b238).
> >
> > And that would leave the result fully bisectable. But if we prefer to
> > keep the history closer to reality, I can prepare the Makefile thing as
> > a patch on top.
>
> I've done the messiest, I guess ;-)
>
>  * revert merge of the part-3 topic and Dscho's cmake fix out of 'next'.
>
>  * rebase part-3 on top of the more recent 'master'.
>
>  * squash in the two hunks (including setup.c change) from you into
>    the "setup: adopt shared init-db & clone code" step.
>
>  * squash in Dscho's cmake fix into "cache.h: remove this
>    no-longer-used header" step.
>
> The result is not in 'next' yet until I hear something from those
> who have been involved in the topic, including Elijah and Dscho.

I did a range-diff to compare my original series to your newly rebased
one, and read through all the differences (including Dscho's and
Peff's suggested changes, as well as the various slight adjustments
due to rebasing).  I also rebuilt every patch in your rebase of the
series to ensure they all build, and ran all tests on a couple of the
patches to verify the pass (I didn't run all tests for each patch,
because I did that for my original series and the differences in the
range-diff suggested I only needed to spot check all the tests).

Anyway, your rebase of en/header-split-cache-h-part-3, including
Dscho's and Peff's changes, all look good to me.

Thanks everyone!
