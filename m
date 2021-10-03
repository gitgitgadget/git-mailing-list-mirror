Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2209C433EF
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 14:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACDC611F0
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 14:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhJCOfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCOfW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 10:35:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240EC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 07:33:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r1so13633255qta.12
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6YWr5OgG1yt5YcgkGO4pb3u6tgp5qZBLbqSTu6fLFU=;
        b=Nh+b3YcQitKHcq3opMzLgy5IezthPpCwah08Xq59V8xc+UQpL5R8Nn/D06h/EwRYNJ
         yucyd3hs8vAlzy6l+XC/NKHZFybs5yHTxkk7HFR744HD/fQuvRV0HDdm/Yi9qM+maQdK
         HRHc+MyeqI8Seh87FkpdNkCrrxB9xjT2+yk+pydYh/dBZg0N6kIOcJhB0M2KTIPcRZHc
         3/AoBUuEkEmNy7VBL4xqnwhspo99bXmMEIY+NzfyrylNDDUXTbMLbQG/7jTweqqQfC4r
         eGPU2imk8AhbVoI+/NCdQb0tKeY6I4CI3XIkrGvvAWYqeO6Mve2jpjyb28LnrQNS97FX
         x6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6YWr5OgG1yt5YcgkGO4pb3u6tgp5qZBLbqSTu6fLFU=;
        b=4oor61jPfjexF2UkMixhwqoDcI76DZ0XQ4/rd58FUrkw753gAJ4JzJE6+kiIMfhZwx
         DKK9GHZz1HZ+K26uXJVk83kcmhNW8swHSW/xb9NfHWNYr4Jtuz2TbvOufq7C4wbAfoCM
         1NkZl8VknbEZCF9feEUALIsXoExXEPkbX585LbrkhbamxrpY01S1A6pAyDda56jEhsSA
         gNztmAjpJtlwo7Kyz+UckMsSytP7jluGR9FYs9otRwrwo7R/kMBJs3wYlu1WLEp1su8l
         7HNMTJ6HZvhUBt8xrdV0OXPN2rmCOMx5PeIUBO0eNjaqDSZwmRtycfvXkbCBXqD6p2D+
         YCvw==
X-Gm-Message-State: AOAM531f2GSxSLO4OpS2yPPQkI8btS2ynSffNQu2Ne0Jf/eCq2VOrtBg
        eb9HHk0303Qqs80VlklFBOX+08+W4y86hKaG1+r7tDc7GW8=
X-Google-Smtp-Source: ABdhPJz3hqYTM6ZE4fFA1MLjYkbm5fQTjAuXNzPCUXllCaSfntAzeIlHGywTYZKFh2arTyOJyg2ZU9NRs3ZSCyehMYY=
X-Received: by 2002:ac8:5348:: with SMTP id d8mr8714173qto.15.1633271613732;
 Sun, 03 Oct 2021 07:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com> <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com> <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
 <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
In-Reply-To: <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
From:   Sashank Bandi <bandi.rao999@gmail.com>
Date:   Sun, 3 Oct 2021 20:03:23 +0530
Message-ID: <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey!
Is there any way to reach Pratyush Yadav ?
This thread has been stale for days.

On Tue, Sep 28, 2021 at 8:51 AM Sashank Bandi <bandi.rao999@gmail.com> wrote:
>
> On Mon, Sep 27, 2021 at 11:39 PM David Aguilar <davvid@gmail.com> wrote:
> > Have you tried git cola? [1]
> Yes, I did try it.
>
> > Git GUI is useful because it's built in, but from a usability
> > perspective cola has many advantages.
> But it is just too much for my very light usage. I want something
> light and embedded in Git for Windows itself.
>
> > .. and beyond these rather small differences, git cola even has image
> > diffs[2]. That alone is a killer feature.
> It is a really great feature. But it isn't useful for me in my projects.
>
> I have looked at tortoise Git, Git Cola, lazygit and some others too
> but Git GUI seems perfect for my usage, except dark mode.
