Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28574C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 20:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjBNUWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 15:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjBNUWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 15:22:49 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41E7233EA
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 12:22:47 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id e75so8146519ybh.13
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DGiWkKTZdbYSrEbPiBD2y6i4Hfs+BomzubX5S7evRr0=;
        b=i40CXm/kUZKPliPThCzvEZLb/2Tkn/q7j2+MOIk9ihF034L4XcpBItOMNBLvRpHnhY
         GcVFFqgJfe1qbn01FdcFQOacfaovLKkrCi5V+oc3OLjuPBBmRQ182n4mQwnEMmasHbZh
         EqthTpwOsu5NnBDZSnpVzCJlVf8rmlQcCo4FTqoJcEI0gA8Q1B4tCClNZZDTdcdu2dbH
         eWjDUmnO7cePffdP8F7+YXqIIyxH5RZWnOnRP0XHgUYKSjmsCbtev6P3AkTAfeALrkPm
         ztKcLi727QrQ5Rr9B5Hdz5kXgS0xs+264bnNmay6Vl02qGluYvoPBpWaBnXdFJtnyjzA
         tNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGiWkKTZdbYSrEbPiBD2y6i4Hfs+BomzubX5S7evRr0=;
        b=fYizPaIuBbx9VPEUkSlR5UbEJjtrMxOfKQZA9dnlw3HPes54yBLL+0s53png76sGXu
         wHYNn+W1NrrtAfcOKsj8gajy9xyq0LLi1kiXtCZQNVsvzjt8BS7oCM2SScGiJzBYQ+Ex
         eEFX9SJAEfbn2tgUvV+L5IeR5JAOFnAQgaZDPu8E77CUtc8BVsbIzAiRQOrCz6kr3+CQ
         NhhNbipIqMJZG+2Cp/DObslSAek9aJMV9PX4BYpV7JSq2H63NIvdBQHd+mlDj/I1voTb
         OQmJxx3vvt/zmdOeUO+6jRdnUNv94+F+nEz84UyLgbkNc+B3vF8VPdUni1kcxcG+omMu
         j6cQ==
X-Gm-Message-State: AO0yUKUWkcxIR04swUjIj8Ytl5RJQJjTtzJVbdipWu4fUh4A50Ts4PUE
        2V5PXmp9IA9aELC5FYUsZSPdaZTWoepYUy39/iC0JXUtovGrJVpP
X-Google-Smtp-Source: AK7set/h/5GUD6MZiqPtV66E2WL8bVFdr4fJsYCwwRw2WxYmMVswntK2qdn3xoaZtX4snx0WK7B4RAFvfyNAnSw6wgs=
X-Received: by 2002:a5b:cc7:0:b0:80f:294e:f945 with SMTP id
 e7-20020a5b0cc7000000b0080f294ef945mr372293ybr.92.1676406166826; Tue, 14 Feb
 2023 12:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
 <20230213182134.2173280-3-calvinwan@google.com> <xmqqedqtbbf4.fsf@gitster.g>
In-Reply-To: <xmqqedqtbbf4.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 14 Feb 2023 12:22:35 -0800
Message-ID: <CAFySSZAYNtatNKnRuG8ZNeSr+KAU04JRMUdLe+W+eeNtzW+r=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] t4041, t4060: modernize test style
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > -test_create_repo sm1 &&
> > -add_file . foo >/dev/null
> > -
> > -head1=$(add_file sm1 foo1 foo2)
> > -fullhead1=$(cd sm1; git rev-parse --verify HEAD)
> > +test_expect_success 'setup' '
> > +     test_create_repo sm1 &&
> > +     add_file . foo >/dev/null &&
>
> Now this is inside test_expect_success, redirection to /dev/null is
> unnecessary.

ack.

>
> > +     head1=$(add_file sm1 foo1 foo2) &&
> > +     fullhead1=$(cd sm1 && git rev-parse --verify HEAD)
> > +'
>
> Or "fullhead1=$(git -C sm1 rev-parse ...)".
>
> Both of the above can be ignored if we are trying to be a strict
> rewrite of the original, but moving code inside test_expect_success
> block is a large enough change that there may not be much point in
> avoiding such an obvious modernization "while at it".

I agree, will fix.

>
> > -rm sm2
> > -mv sm2-bak sm2
> > -
> >  test_expect_success 'setup nested submodule' '
> > +     rm sm2 &&
> > +     mv sm2-bak sm2 &&
>
> To me, this looks more like something test_when_finished in the test
> that wanted not to have sm2 (i.e. "deleted submodule with .git file")
> should have done as part of its own clean-up.
>
> There certainly can be two schools of thought when it comes to how to
> arrange the precondition of subsequent tests.  More modern tests tend
> to clean after themselves by reverting the damage they made to the
> environment inside test_when_finished in themselves.  This one, as
> the posted patch does, goes to the other extreme and forces the
> subsequent test to undo the damage done by the previous ones.
>
> The latter approach has two major downsides.  It would not work if
> the tester wants to skip an earlier step, or if an earlier step
> failed to cause the expected damage this step wants to undo.  The
> correctness of "what we should see as sm2 here must be in sm2-bak
> because we know an earlier step should have moved it there" can
> easily be broken.  It also makes it harder to update the earlier
> step to cause different damage to the environment---the "undoing the
> damage done by the previous step(s)" done as early parts of this
> step also needs to be updated.
>
> Whichever approach we pick to use in each script, it would be better
> to stick to one philosophy, and if we can make each step revert the
> damage it caused when it is done, that would be nice.
>
> > -mv sm2-bak sm2
> > +test_expect_success 'submodule cleanup' '
> > +     mv sm2-bak sm2
> > +'
> >
> >  test_done
>
> Likewise.

ack. Swapping to test_when_finished
