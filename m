Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AFBC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 08:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F51160F0F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 08:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhGZHVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 03:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbhGZHVG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 03:21:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F422C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 01:01:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gt31so14948348ejc.12
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpvNkWAxLnBPgcpBYANVqGwVt9ujb0r0pk4fxRS6KY8=;
        b=egOInLwbBg4IsEmVYV8sw/YUwAaaedB4rM3Uj52AFZe/6Hll1wt9zMCjEElBUP5tNm
         G1WybJb08dNtFfZZgd2Fl2tgcTM3UJUTj2f05AfJRgSUnKVv5gu0eE6IeO9pvPaNCDRX
         pV0CJJHyDn+loLv9tHC+jCbTh/ToG1LChxABSIbJrbCINRN96+GwhUHPprFlplaflpKz
         GtgtpfzyoupBvFhzB1qg1yQ0pCLF3CLS7KkYzaj7w+HjqOs0UfakNYZ9/Xs3hHH0XMJq
         0WNIJI7yM9AVD+9Y0NTG+34TDJeKlQTm5UBoH/rC5NQbx07ibyxZlggsnxokAU+FhzY1
         OQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpvNkWAxLnBPgcpBYANVqGwVt9ujb0r0pk4fxRS6KY8=;
        b=t1Syg0JpMF3lE5u3lYNG6JVQxH+yUWAcvysjNGKTJxfjvFCVlmNd0tN9065YiAjSsT
         r/WZFAfKNnERQIuK4O9fkB8aYJAwUMNm51yW1n15J1LqKEHe/xPtaAWraSEfG8IpTk5l
         +M02/MDpIqfuLWk3qT92MeJC6V3e11JPLrNTL+UBDA/6gSL5TISc5io57juxrv88ZkV5
         yZ40zeO/Uw1RAwSMghMoMS37Ky0SGqufk12KHbODdKlDcAseUgrGNIDhkjfX4hbK5ZKa
         cLZN79GLayN5MppaLQJrZXn9brOTx5+CLoLYPcD8ThrA4BgJqEj1Pa/B9hUj+zMwY2cm
         udgQ==
X-Gm-Message-State: AOAM5327ECVr9jNIXXycjdPiIHy1jodzLb0tFn0h2nVh2gqzu9zTxy/z
        C54V5mujPaX3D0MDllj96bprxvygEQqQv0/4P/g=
X-Google-Smtp-Source: ABdhPJzthAyWYOHOtwgIa3QRy1tuvBxtWiO/7mklzorQUTPwigq53mRfbGC0hjLw5c650jo+0JgdCUkU9v6YIhVwHU8=
X-Received: by 2002:a17:907:762d:: with SMTP id jy13mr15747059ejc.211.1627286493282;
 Mon, 26 Jul 2021 01:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <CABPp-BG0a0OM7s7cmO8yCeyA5TOCD_yOSJJepQE8MFEHct4EQA@mail.gmail.com>
In-Reply-To: <CABPp-BG0a0OM7s7cmO8yCeyA5TOCD_yOSJJepQE8MFEHct4EQA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Jul 2021 10:01:22 +0200
Message-ID: <CAP8UFD1h7b0GkZWzuXfatFVVvXHvEWs=V63poUT4ovoM-extUA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Fix all leaks in tests t0002-t0099: Part 2
To:     Elijah Newren <newren@gmail.com>
Cc:     Andrzej Hunt <andrzej@ahunt.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 11:54 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Sun, Jun 20, 2021 at 8:14 AM <andrzej@ahunt.org> wrote:
> >
> > From: Andrzej Hunt <andrzej@ahunt.org>
> >
> > This series plugs more of the leaks that were found while running
> > t0002-t0099 with LSAN.
> >
> > See also the first series (already merged) at [1]. I'm currently
> > expecting at least another 2 series before t0002-t0099 run leak free.
> > I'm not being particularly systematic about the order of patches -
> > although I am trying to send out "real" (if mostly small) leaks first,
> > before sending out the more boring patches that add free()/UNLEAK() to
> > cmd_* and direct helpers thereof.
>
> I've read over the series.  It provides some good clear fixes.  I
> noted on patches 2, 6, and 12 that a some greps suggested that leaks
> similar to the ones being fixed likely also affect other places of the
> codebase.  Those other places don't need to be fixed as part of this
> series, but they might be good items for #leftoverbits or GSoC early
> tasks (cc: Christian in case he wants to record those somewhere).

Yeah, thanks for letting me know!
