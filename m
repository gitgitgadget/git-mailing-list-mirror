Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F81C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 01:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A11E20725
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 01:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5DkM6zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgHBBvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 21:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgHBBvt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 21:51:49 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CBC06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 18:51:48 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 125so3570251vsg.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVI3xh9mZmGlrQLlWR3JYsABK544Ns1OehuE8Oub40o=;
        b=I5DkM6zGcbSOEfItsNUNqsegYbylwjxEWy1Z42kZFcGXRxHGvevDEtzY3B4n0SIiz2
         gF06zjQ5rjLMwdo6XsT6sIcxB/ScQYYhBCbCK0A5D2Ofk3llZ17sm6DD8AaNdPYyBqS6
         /r49RocH4kT+TvGhzwfyBlGmvn+S7Or391Hl5GsF7UsBJttMv350Zig4j+z+1ZV5t37s
         QE4/N1mqtig6ClHQAGWYDRBEHEcIXDW7Rx1ACzkuuMD0lrceoqfOwkaHg7bYY7/W9kIY
         GCHjPj27khvuPTVanpTR+7Y26gx0mQwW5MwII2PRFOYN/q8FGjPnAn+Murkjq5yqa6bk
         uQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVI3xh9mZmGlrQLlWR3JYsABK544Ns1OehuE8Oub40o=;
        b=PEeY/Fv5/roZB/UtiMPf7PLGDNzRSGwSKS+nqUR823HIE+42X4np3Moa0ZnxJSZ79A
         GkBAaqy4a4OSo9nL8bZgB0ALilZKR3EaS1O7p9k2+THIhnyK5l/SAfYd6OPfnm9Vpe66
         mE4b0FiqTW3/CK6b4vB/f0KSJeSllrqgRMq4e4cVfisK9CCqdWGL0Qtq7X6BWvxCddLi
         xaNVoEyMOeCru2OLtnNmWsn83DOyDuLSnPmx7BPA18cpTiwNlUmwURb4pEayPHYXavUn
         lpA5CWCn4ezrKEoLJVPp66VQQ0yXfk2Q2V/+UCKQRW+bANWvr+hSJt1+ltsWhvRXVwip
         4Jqw==
X-Gm-Message-State: AOAM531j01k2z2CTbvNV+gMP3/pKHoZfSqQy2BMhFs+VG0Gh2WeVjU3B
        sCtQs+bbiljVuM3wvaJzCWpDWLfElow4OfER13A=
X-Google-Smtp-Source: ABdhPJyZPgkGvbkoGGblldm96pwu667MAv6S2U46kCwFYCytlNTvRQrvJzKZ/wUMyYsaIrxrV5UBJmAVdfJodOgxtMk=
X-Received: by 2002:a67:2cc5:: with SMTP id s188mr5944634vss.209.1596333107966;
 Sat, 01 Aug 2020 18:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.689.git.1596324796918.gitgitgadget@gmail.com> <xmqqv9i128iq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9i128iq.fsf@gitster.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 1 Aug 2020 21:51:35 -0400
Message-ID: <CAOjrSZtbEJ5-tnU497r8jE2PYWhKR1Qu14SZRnqceRnLMSheiQ@mail.gmail.com>
Subject: Re: [PATCH] diff: teach --stat to ignore uninteresting modifications
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> For example, if we further change mode bits of file 'x' (which has a
> whitespace-only changes applied in the test in the previous hunk),
> e.g.
>
>         git update-index --chmod=+x x &&
>         git diff --stat -b --cached >actual
>
> should that be counted as a file with 0-line change that is worth
> reporting, or is it hidden?  I _think_ the new code will do a wrong
> thing here.  That is,
>
>  - If the change truly is only mode bits and one and two have
>    "same_contents", the new code is bypassed, and we'll continue to
>    show "0 lines changed, but the file is worth reporting".
>

This first one is the behavior I was going for, I think it's most reasonable

>  - If the change is whitespace-only change plus mode bits, i.e. one
>    and two do not have "same_contents", the new code triggers and
>    the stat output is suppressed for the path.
>

I just ran some tests on my end, and you're correct here, I'll try to come
up with a reroll that addresses this and adds this as a test condition.

-- 
Matthew Rogers
