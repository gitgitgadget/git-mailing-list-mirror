Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C925C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 03:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E9B604DC
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 03:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbhI1DXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 23:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbhI1DXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 23:23:20 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4EAC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 20:21:41 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id et16so3318434qvb.10
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 20:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nSSBux2QXf/jDU3OJ7hTgZTR+eyTN0AQKNsfZX4IpM=;
        b=BgfvMuluSIjg06qLaFx7wFJEjDrOOb8apPNKv7EH0fcFAQNvl9tsAKViIJxeAD3617
         UU9MpB4ZpeHXNIQO6UyQabStwPcKN7pUwJ7f90DVr1ScoQu6w1FWmMkVAS7VS8FbJlog
         ElSNIVgtmHN4vQvYfqe/d2qoGOrA3j8JC7/mfvor73r1RnTLDJ71a7GmBR9JfkXfSbRI
         pkkF+UAfiDP/25vXsyxSvtwfXKIP3iDNsJzlEN2pJS7Inl+m37Pjnm/BCd+tnF/M66r3
         g6EBeA3qyd23ezYH0RkM03vH4Td3AtJZ0ob7Q4A/ZU+8Z4BIql/32vYsrhKjDarSVyau
         jCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nSSBux2QXf/jDU3OJ7hTgZTR+eyTN0AQKNsfZX4IpM=;
        b=nRYtd9l2o+JRvVBYYMrq5glan7dPxb8RJIbi+gX9seMCMxHTHb9nZ7DBg3rlgI9Mqd
         iTd6pQ+vwTYPCdKR35hv1vFep/xAxz1dAN8OK7QYngx0A5bOzR+G4X4hmW/znugIckCZ
         nrh3dZOR5crrvphejiGG7nkuHd17YJBz9cpU3F7Y8GL5oDN8shFqZBxroqGaB7eezlEm
         tkHVaI3NUwQ0Q+ZC3ZZP4XqI9RtI8g4CluUmW1zTgsJIeJp5iP/UEbdw97v5GvoBO/wA
         2+maVKq8J5xxYItIrhW0l/kQ8n2zYz/f62pJ62vHJO2i2p8jcCkrtAg36vvEa0Cjkw3f
         sXqA==
X-Gm-Message-State: AOAM533x6TTFaUEGKUj21ecU7LNCy5f3dW4U2NUbXYE23iy6nbgf+5mq
        WBKUlHmVs7ocBh3UUijgP24aO/kT3Son24cg13SCy1NPqHyXXkaj
X-Google-Smtp-Source: ABdhPJzNY1kDN4Tp7lr707qanlPhHLfyxziSGz6fPF7t/8e8TIBvl0FxFxmjt1U2POrd0nfwFz7sDi9+1eNMqiAVuWg=
X-Received: by 2002:ad4:5643:: with SMTP id bl3mr3231582qvb.54.1632799300296;
 Mon, 27 Sep 2021 20:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com> <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com> <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
In-Reply-To: <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
From:   Sashank Bandi <bandi.rao999@gmail.com>
Date:   Tue, 28 Sep 2021 08:51:30 +0530
Message-ID: <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
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

On Mon, Sep 27, 2021 at 11:39 PM David Aguilar <davvid@gmail.com> wrote:
> Have you tried git cola? [1]
Yes, I did try it.

> Git GUI is useful because it's built in, but from a usability
> perspective cola has many advantages.
But it is just too much for my very light usage. I want something
light and embedded in Git for Windows itself.

> .. and beyond these rather small differences, git cola even has image
> diffs[2]. That alone is a killer feature.
It is a really great feature. But it isn't useful for me in my projects.

I have looked at tortoise Git, Git Cola, lazygit and some others too
but Git GUI seems perfect for my usage, except dark mode.
