Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2379C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 11:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiB1LEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiB1LEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 06:04:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D11EC40
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:03:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id p4so1917088edi.1
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvFPU7umBnw2xpQxIK8NQBLryS+qNJuPPBKIPT4jj2w=;
        b=nx8eIu6jBubPYTjfNWJq9NASyuNx6WU+wh4YkGLeEVQpYzp99VWczMqzTtGWa2huJQ
         5S0NQQFmuLUsz4iKZwrfGlhI4yA57E/752CjBlWNGyHarR7/5gTFT+N8mU8cDq93Oxm6
         6EOf/VpfC7dRLx6g6HhtI1UZVJGhXGGob29Fef2qQv/bsKRGHlWMB1Jprdc9XQfMed5y
         SD7sKWNITi7bYiulDQKwxSol29d2z9s7340h2tIQJUGjqpFHaY9Yu1meXJBPGvvjlJQn
         G9ZPoIZvEeXPF2AcZsKkN5SgbcqbQyffh7ZY5dIC0IZ/o310r/AkGV7dQNw3pOSzCcfN
         qByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvFPU7umBnw2xpQxIK8NQBLryS+qNJuPPBKIPT4jj2w=;
        b=y1CcrMtcluXXEAipxvUvAq9J9A9JjN7kLfrh7VhKbd0FQaggM/VCs07oqmwQVZjTHz
         7FZuDxOYjh4KqwG/HY2Me8hpG6sEOkDIKjcLcP5R6mpJKHxjTZEnEYCIvCipf8nuLiWU
         hk/v6aXWDrxzmMnExloVGCycL994wmJz+OJpPBYoRI655QTXVrCYyy6XmSEL8NghEIQv
         Fobk3e4L/stmgL9ibK3HIkyqPAFGg3ObTpx6vMdcmdCTz7auW4d0rvzC4HWU35pMdUWN
         R7IF7wRyleMZEVJg7T/PXehlgkH3QeMgZk9jyeSAj6MnMy6MULPTTvim/HTu4YZgoOjW
         kw2w==
X-Gm-Message-State: AOAM531xPhuKFgzB2poFMsA+zwRjFHHJo4oZaKcq/TZcWpcaI97UwiNC
        r9N0A2B+iIhPM6Rlt81gg0WRWi/4pO13g7Hcxmc=
X-Google-Smtp-Source: ABdhPJzgkINgijoavKhzeeViNCH/oE2zB+acs282Hh1xN371GS5TzhAZx153lo/0lWlSrjMqXJCkQvIT0xe1n9GMR2k=
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id
 f9-20020a056402354900b00412b31c5509mr19204740edd.224.1646046214035; Mon, 28
 Feb 2022 03:03:34 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local> <742c7455-8f74-ac03-350a-7c3851f2b792@gmail.com>
In-Reply-To: <742c7455-8f74-ac03-350a-7c3851f2b792@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 28 Feb 2022 12:03:15 +0100
Message-ID: <CAP8UFD1bEjg20Twn0pjVqxmgCU7Nhzkg16O2t6gacSsqCYfXng@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 26, 2022 at 9:30 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> Thanks for adding the ideas to the SoC-2022-Ideas[1] list! I noticed that
> you're the only one mentioned as mentor for the idea there. It's usually
> good to have at least 2 mentors per project. Is anyone else interested
> in co-mentoring with Taylor for the idea?

If no one else wants to co-mentor with Taylor, I am happy with it.
