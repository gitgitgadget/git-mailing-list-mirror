Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A65C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKDByD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKDByB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:54:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD822BD4
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:54:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f27so9882388eje.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 18:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+PB1Xa/PF7A22bYVo/1D2DbcdAC0KTM+moPPn5ima8=;
        b=YA7ROgXnW3ZmVhFx4TG3wnieg2EQJx1gtc/hzLo8W71QyB++BWa8Y6Y6l7ZUqQBsxf
         dQZlA2Bh+1FgpVfTa/xqwl9wTinOtfEAoxBW/RfJOimHQMrvYNNjh2YSRukbXPQZb3Mx
         j79JVHIeNdb5oGIyN758EnC7DSt0zRFOnrglqrJXATlWnmwWqoLrHfocWt4zGEZ30i4c
         RqcqYnOepDVXWDthKWcrrevLdzmbEZv3pUy4p6r5DlKivR4qToU2v3/zqIdAGq7Z6flQ
         vOprjRre2oUlfVLYLHJDgCVJ5+4okPlleoosGgDyGdZXqqBt4UtA3MPpHtUZhRZJObQb
         cGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+PB1Xa/PF7A22bYVo/1D2DbcdAC0KTM+moPPn5ima8=;
        b=gAjmlY50wXbK7V+k4lAwj+i342FzLxQ93dj0Cx4dDKU0UAjfsP7Rrgaycexut6cr5c
         NqgZz76b5A1V7R1yz848l6IxgsS3GHSH0EDdlBaGNBgqyIZ0QfXdQb0KS/MFow2sTSHK
         v9wXZMYNQlq4HTMYXTa18VkZJ9o/dwGlcR5BPsVVag92SlrlTjcnCDSSCuDVPmP8QiPL
         z2LzGsualpKLRys+A1Pcofb1FkYYcEWS7ev8OG5Z036xqyKkQDuE5JDVlgQZe/j2J/h/
         6D6SjfjI9DDFevC1OOOPVDNrl1/46DoeBNOU9COytilkAdTOPQUEDjrZY/V+ewmP6T93
         KfYA==
X-Gm-Message-State: ACrzQf0KA3+ddNQq1ruThklC210wdtQUblsUDzYTF64kwog3py1Vhbss
        V525PWWVaIOMEDqWOImKvumbAGyXrnblfA==
X-Google-Smtp-Source: AMsMyM55qJuItzQyU0NY+WUrSe06Jkt6GGwkv9xX88UEzhZ3vjOp0y5FBhhB+K0sqA5XieLFP1kG8A==
X-Received: by 2002:a17:907:31c7:b0:740:e3e5:c025 with SMTP id xf7-20020a17090731c700b00740e3e5c025mr32578202ejb.341.1667526838610;
        Thu, 03 Nov 2022 18:53:58 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b007add62dafb7sm1165937ejb.5.2022.11.03.18.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 18:53:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqlu9-00D2N9-1a;
        Fri, 04 Nov 2022 02:53:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid unnecessary builds
Date:   Fri, 04 Nov 2022 02:46:23 +0100
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
Message-ID: <221104.86bkpnzdqi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Whenever a branch is pushed to a repository which has GitHub Actions
> enabled, a bunch of new workflow runs are started.
>
> We sometimes see contributors push multiple branch updates in rapid
> succession, which in conjunction with the impressive time swallowed by
> even just a single CI build frequently leads to many queued-up runs.
>
> This is particularly problematic in the case of Pull Requests where a
> single contributor can easily (inadvertently) prevent timely builds for
> other contributors.

The "timely" being an issue in git/git and/or gitgitgadget where CI time
is a shared resource, but not in a <someuser>/git running CI just for
<someuser>?

> To help with this situation, let's use the `concurrency` feature of
> GitHub workflows, essentially canceling GitHub workflow runs that are
> obsoleted by more recent runs:
> https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency

In my own fork I very much use this concurrency not-cancel-in-progress
intentionally.

I.e. I'll run local tests, but also occasionally push to CI
(particularly when I know I have bad local coverage).

But that's very much an async process, sometimes I'll look at the
(hopefully finished by then) CI in the morning.

E.g. now I have a re-pushed branch where the last tip it was at is still
running CI, but it's waiting just the ASAN job.

Having that breadcrumb trail of "green" CI is very helpful, i.e. push
every hour or so with something WIP, and be able to eventually see when
things went wrong, if they went wrong.

We have CI config for other such stuff, but I think it's probably hard
to use in this case, as this involves cancelling the *other* job, not
cancelling ourselves. So by the time we're past the config stage is when
we might want to cancel.

But doesn't this support the "if" syntax to narrow this down to the
relevant repos where this would help, while leaving those forks where it
isn't an issue to enact their own policy?

