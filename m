Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E03C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF84B61208
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhFNOvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 10:51:13 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:46775 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhFNOvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 10:51:12 -0400
Received: by mail-oi1-f174.google.com with SMTP id c13so14567255oib.13
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R40qPwp7t92hTL9CYVQEv7gwSMvOZfv54j6o48x6Uu8=;
        b=UxIseKe/CNsISbgP19UEijKeJbeG3kecHaTfVheNsZeLtfzIjPDpIH0jRVAwDfX0di
         yqmgmA5SIyfFAhYE0OK9U4xlbbSACwub+n87h2fCXtGBCvIGd1Rvy0CmzmC8H+odcXlg
         kCWeji5b+aU8XSq6XKOPH7MPiZqxHLziovHz+zNbOmxFHfJQ2R1hq5IaKLB3uhpb5qvZ
         2AP+/L6+q++sZL6iWjnCYGZOL66kxiWbRr/oD2ojaZKl2Qsu2S3pyJRFhi+4vMr5xrxI
         dzSm0Xk5iRKKgim683p/5ukmy7FD1R0HpY6Ofl3XDpvk6+wc/94CZZi4A7M4Gyc95KSt
         Hp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R40qPwp7t92hTL9CYVQEv7gwSMvOZfv54j6o48x6Uu8=;
        b=fBxi+QpwieuYN7Qhtsd0WyCVx1pxJbqv/5GRtef7orfQve4SQtOK8A3VEgaSbDILof
         C5Y7/xC0144vLJlIdw8rLDp3Aorc/oRu+reB+bO/rUZuU/MY1gCZOvmU4vJG9tClOufs
         JAsyRauMlE4EiaOzzynVj17SndQjdwksWjcwTjYDeSKjwPKrMzXlmzG9c1ECB3FUCXtv
         hqhoRfoHJnC1OYpl82+I54lgI9neo0D6n98Ml2eBSFcIog9XkqpBIURbN6dFF85kjcqn
         eLD3oeV4aFmGH4WGz4k/hS0SaQWbpQHr2rWfgRFWntUKByPXwbowWEISn83nMOzkrXf6
         9CNQ==
X-Gm-Message-State: AOAM533h5emvUWYbdobgwkfWO1JQ6OmJgoCHjdeiQuILr/31WrHJTYWo
        1rzMcaRwt7GVk8/A5VDCrP0qmw1L9qLJK/FrVro=
X-Google-Smtp-Source: ABdhPJzkKksk0i3VUYmKheFka0R/ZE4WAI1+Ic+tsgVpmeW03431szk/tUeQiHmj4E2p5frrCxqaZSrcIiNXuBwSO28=
X-Received: by 2002:aca:f482:: with SMTP id s124mr21445163oih.167.1623682089655;
 Mon, 14 Jun 2021 07:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
In-Reply-To: <20210613045949.255090-1-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Jun 2021 07:47:58 -0700
Message-ID: <CABPp-BFEc2aQV_kTTiDh3WV5oBwr4tOzO6LOGnMAHudZdXVo6Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] pull: obvious fixes
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 9:59 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> These are obvious fixes that I sent many times in series like [1], but
> for some reason they were never merged.
>
> There's absolutely no reason not to merge these.
>
> [1] https://lore.kernel.org/git/20201218211026.1937168-1-felipe.contreras@gmail.com/

I was really surprised to see the Reviewed-by on patch 1, and did not
remember what review I had done.  Unfortunately, since your new patch
series aren't posted as responses to old ones (see
https://lore.kernel.org/git/CABPp-BEEiPP7AEk4Wexw4_MDHcin2n8xkMowO=OXTn9pNPaG0A@mail.gmail.com/T/#u
for an example of what I mean), and since the cover letter you linked
to didn't reference previous series, there's no trace of where it came
from.  I had to go digging to try to find it.  Any chance you could
tweak your posts in the future to help reviewers follow how things
have evolved?

> Felipe Contreras (3):
>   pull: cleanup autostash check
>   pull: trivial cleanup
>   pull: trivial whitespace style fix
>
>  builtin/pull.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> --
> 2.32.0
