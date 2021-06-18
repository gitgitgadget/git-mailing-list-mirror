Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6383DC48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 05:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3966461249
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 05:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhFRFIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 01:08:13 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:39609 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhFRFIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 01:08:12 -0400
Received: by mail-ed1-f47.google.com with SMTP id c7so5900183edn.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 22:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7ze78QK/V/mqj1NclqCyK5ZiZTiCjsaqnwGZBeFrcQ=;
        b=dBiGoonEmYhkj2nPaRs9+vLKHdBKISaQZZbGET8jfvBVbK/eCHJjQFSPCU1Ku8ggQV
         yIkglyerP8xKepS4BkcXu7no1L2qMffKlYqmOxNem4ps/TDM3G6SbtAYP5Ek6YNn7X0Q
         /D3YWlgZ82kgKkjHwvHMojHKcEij9bF2PJkmoA49CpEC1IOqo5pHl/H0Un5pjEyMx5IN
         qM8hv46aDZdg1N4R95yiiN/bROCw02a0MpIC095L2XXgekZ0cralyg7bvLoPhmImhNnn
         e8TV4JR9XjXtQoRISK7Ip6fTyVUn/LuBT/d7t6WtzG5iMpVZcWqo7OdG9NUl+QFhbvJi
         QBKA==
X-Gm-Message-State: AOAM531UJm5Idc9vAq7dVUCGAWkooVctPclZq4gh4bE2VWkc18N3vJ6s
        aDxmgKDCyE92p0VU2huHieF0THdxdpNndI1yJ05EUblGfQ8=
X-Google-Smtp-Source: ABdhPJySpG469y4xBS6+4Dy+hBxiHt91PboMsnyjArAaBcQ4yXaCSUwkknVXfM5FVrqg+yLsm7ujvO1Wpkh8ZeCRDDo=
X-Received: by 2002:a05:6402:4395:: with SMTP id o21mr2443813edc.163.1623992762261;
 Thu, 17 Jun 2021 22:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <60cc1749b1c4d_5d12520825@natae.notmuch>
In-Reply-To: <60cc1749b1c4d_5d12520825@natae.notmuch>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 Jun 2021 01:05:51 -0400
Message-ID: <CAPig+cTr2fEYN2y7FyKaspuaCpAq6wNtHgg_8RcrOmvsN5+XaA@mail.gmail.com>
Subject: Re: Only 27% of reviewed-by tags are explicit, and much more
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 11:47 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This prompted me to write a script [6] to programmatically find statistics
> about these trailers. Obviously it isn't perfect (as all software); it
> tries to avoid human fuzziness (like people pasting other patches with
> scissors [-- >8 --], or just straight put pasting the patch [^From: ]), but
> even so there are instances I manually had to skip [7].
>
> Here are the top 20 reviewers over the past 10 years with their
> corresponding explicit over total Reviewed-by count:
>    ...
>   5. Eric Sunshine: 14% (17/116)

Does your script check cover letters? Based upon a quick glance at it,
it doesn't seem to.

Although I've reviewed thousands of patches over the years, I almost
never give my Reviewed-by:; it is an exceedingly rare occurrence.
However, when I do give it, it's almost always in response to the
cover letter (saying "this entire series is reviewed by <me>"), not in
response to individual patches. I've seen other reviewers do so, as
well. So, if your script doesn't take cover letters into account, then
you might want to revise it to do so in order to get a more accurate
picture. In fact, if my memory is correct, some reviewers give their
Reviewed-by: to an entire series in response to one of the patches
rather than to the cover letter, so perhaps you can come up with a
heuristic to identify those cases too.
