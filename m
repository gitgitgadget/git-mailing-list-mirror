Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C364C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 18:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiJYSwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiJYSwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 14:52:02 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94278C34EC
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:51:59 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r3so15830226yba.5
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bnZLyx/yTIY7bE7SqqFMRvJ8upFxYoP1MUSxPPiHtm8=;
        b=a1+RNYpO/T3bjbIZEBsffUEwBni+uZ2pwqRTdK3Sm9orTCdATBAT766Jc7F+89yP15
         l8q2oHkXV/25oX0YTtyiI6u+chqR639rD4Ws2dM0PwM3QInLwbAbTYaALg2wV+epwMGn
         vtlOp8L4ZuxIOPBbZl2hR4ptldyadlrC/TGTkpC7hqSSJJGHfJ5NIQTCDb6c96VNy2eh
         yutoZLmVdrMG8GvZBD5bcNkAPr5BW90eyWnWRSYjQ9osk3oaBtFvbS1EWv+T1izEGx1o
         xxxjNLOjOln1uB+OA/o44sqIT4abfc9ORQzzMFoMHYQw0LtSHBtE4nWoDgfYGIZ0uv7D
         gC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnZLyx/yTIY7bE7SqqFMRvJ8upFxYoP1MUSxPPiHtm8=;
        b=fSNNviJ8LXDJzD3ThaZKpfHVpxETkjO+pZVqXba0IxoCa0J5lymXTiJ+8hNz5e0FPR
         HaAuOj3dE6EKSyNyyDo1PyyCdl7DjeYx4mn6HKLwW3eDr+1ECMFDVsYzzzWbi+PWXqKp
         tql6YFuJPnH5PCGZhUkMW73Q38d3P4xQKUNpXQ67nPefPa8uF07HWh4DdHuyM+RS8+gK
         dtMBo4lhLkjarraG5DXOHEhq8KHMbzBkQA9obbQvrACA6vuihVbLgvOBhpEb6TZNa2eX
         qW/nPSlWBmDLwjNWKi8kNVBFsRTW4hNCHxPFmkB9xpk7VzShljm0MJ9nuWYQqmpIQksv
         QIRw==
X-Gm-Message-State: ACrzQf1CZfIwXlEzdzOVOv18PlPq+1ycexNueqo+tbi15BMYetwvBoSg
        0CJ2Xez/9wPNsnDAB1oMzvC0t9buhHh8/zR0cKTa0g==
X-Google-Smtp-Source: AMsMyM4hBdVoYi6mYi49X+1VuWgTAXV6jXbd4AsaX82+QGwsoqx1EfoxE+WNecczDfWaEtMzxK3H/aZoPwFGJ/fY3OI=
X-Received: by 2002:a5b:7c5:0:b0:6c1:12dc:3f94 with SMTP id
 t5-20020a5b07c5000000b006c112dc3f94mr36152897ybq.640.1666723918746; Tue, 25
 Oct 2022 11:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221020232532.1128326-2-calvinwan@google.com>
 <xmqq4jvxpw46.fsf@gitster.g> <CAFySSZABaWSKw_OxyPEU=C_iLOmPa=pPahWaeta=JaAf2q_GEg@mail.gmail.com>
 <xmqqilk9rqkb.fsf@gitster.g>
In-Reply-To: <xmqqilk9rqkb.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 25 Oct 2022 11:51:47 -0700
Message-ID: <CAFySSZADNEAnZ5S+hM44207XBedaN-FozUHU5MeS+8eTyLrhqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] run-command: add pipe_output_fn to run_processes_parallel_opts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2022 at 12:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> >> In my review of one of the previous rounds, I asked which part of
> >> this functionality fits the name "pipe", and I do not think I got a
> >> satisfactory answer.  And after re-reading the patch in this round,
> >> with the in-header comments, it still is not clear to me.
> >>
> >> It looks more like sending the duplicate of the normal output to a
> >> side channel, somewhat like the "tee" utility, but I am not sure if
> >> that is the intended way to be used.
> >>
> >
> > In this case, I was hoping "pipe" would refer to the redirection of
> > output from the child processes to a separate custom function, but
> > I can see that duplication != redirection. Maybe something like
> > "parse_child_output" or "parse_output" would make sense, however,
> > I didn't want to imply with that name that the only functionality is to
> > parse output. Besides that, I don't really have any other ideas of
> > what I can name it...
>
> Yeah, parsing is not to the point.  Sending a copy of output to
> elsewhere is, so redirect is a better word than parse.  And piping
> is not the only form of redirection, either.  If duplication is
> really the point, then either giving it a name with a word that
> signals "duplication" would make more sense.  "send_copy_fn"?  I am
> not good at naming.
>
> As a name that is not end-user facing, it is tempting to assume that
> the readers have basic knowledge of Unix concepts and call it
> "tee_fn", but it would be way too cryptic to uninitiated, so I would
> not recommend it.
>
> Hmm...

Throwing some more ideas out there:
split_duplicate_fn
duplicate_output_fn
dup_output_fn

As you mention, it's not end-user facing so we should pick a name
that's close enough (and any confusion can always be resolved by
comments)
