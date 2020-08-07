Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9225C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8105D2177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6Sko/Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHGWRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGWRC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 18:17:02 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C63C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 15:17:02 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id i20so694318vkk.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnYHsW8cyjvxYYBzAJX7y8Sy9kGOjG+iEw/rXLw99IA=;
        b=A6Sko/Nrg0Xqtvums8yp9i2P5XKqc4xEc7LCop8HqzWxTRiJ4cdQOBUCcVXq5bijpo
         j/rvSit7dcc79NGOCzmIye08Z2iqRBxgOXDrt9RokANhbS9iH+YRzSshJAnQ9dyfJ8Q5
         BD+a15+C0CzM1f7PcuWHxN6st/Nbjag3V7V8N4BaksJbau464qJJx7dTr451RxswZiUI
         d2+BMR7AFMSD1dLltmr3yE0KdejJoGVARDCf0Vf0zlEp649tmOd2Kfw14Cj7QYY4uUY+
         dGVp3K96p0LFfJQ//14KY4UJVd8mjSGr2nm1H+bixzAScSrkAcJJ4mT2VizTAeaRSAoz
         72eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnYHsW8cyjvxYYBzAJX7y8Sy9kGOjG+iEw/rXLw99IA=;
        b=MnH5bfjRIqvrYwp7CH54tLjFQiRJ/l0bdxx4gPFd5NbQ6pE9InBr97/SwT1Wg6tMyV
         T7x4AlCRJlc7T3VPXc6zBsPLmBdnhcOsAp75PqbiDWXSvTWwREz233yIbYj8NUmijqPs
         l5zzc+vyQqVGBCvQvbenQjsjPlxwUdxyYdyvJx9zjFESas5xwhL/Dk1QE0Onf7bMDyRe
         gBld5sMpjWyvAclsflZNl4EUlkI3qAV7vWQgKWEOj0RnDq65RJCAyqVr3B7uUq7tyClE
         7Pi+olvBgHXfnU2nLzPy/33aWzfvhpiEk1ohWYWJajeM4OmZJoZqVsLJ39FCXtKD5X7t
         D7xw==
X-Gm-Message-State: AOAM533MBHzRjHh+2HQdHoQy2k2OzrB30n/EmznzQY866BkrgEMzhiFx
        fLFWeUpT26yReVK0MeVtELBOD5Hl9ueUZ6my/9Y=
X-Google-Smtp-Source: ABdhPJwMKB6vZhoOSG5evZo0mUpMhw5Cu+GvVIE2cQkraJNL1A0h/i0NldeaKDnPiDZpk9ynPs6m0iqmqBslfG+HR4c=
X-Received: by 2002:a1f:320b:: with SMTP id y11mr13037251vky.57.1596838621207;
 Fri, 07 Aug 2020 15:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.695.git.1596728921.gitgitgadget@gmail.com> <2b9deb6d6a23e53bec75e109f2e3ef9217420425.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <2b9deb6d6a23e53bec75e109f2e3ef9217420425.1596728921.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 8 Aug 2020 00:16:48 +0200
Message-ID: <CAN0heSqZ=nQzHiuLVCYcNfm34DO=4aSpsNPL4scyTV=vK1ssOQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] maintenance: create basic maintenance runner
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, sluongng@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Aug 2020 at 19:57, Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> +DESCRIPTION
> +-----------
> +Run tasks to optimize Git repository data, speeding up other Git commands
> +and reducing storage requirements for the repository.
> ++

This "+" and the one below render literally so you would want to drop
them. (You're not in any kind of "list" here, so no need for a "list
continuation".)

> +Git commands that add repository data, such as `git add` or `git fetch`,
> +are optimized for a responsive user experience. These commands do not take
> +time to optimize the Git data, since such optimizations scale with the full
> +size of the repository while these user commands each perform a relatively
> +small action.
> ++
> +The `git maintenance` command provides flexibility for how to optimize the
> +Git repository.

Martin
