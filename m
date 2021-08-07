Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0209C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 06:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3567610FB
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 06:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhHGGM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhHGGM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 02:12:58 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C24C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 23:12:40 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id q3so2601899vkd.2
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1voMxoQa98ioLP/md+Qqpxzsefa33odabF5rTPnj5qE=;
        b=lpWPUtE+OKJZPJzAdjL8L5d/6BoDM3hrn6y+nlSS3xTyMwErYDjV3FgrnFhKua+x1T
         tKAS4jZxfDMGonIBNanvzl1BOodP76NJLYvAOnQaDZbdOPg9AwJ2qusnA75u7x0zWYCd
         FydAHd0qe/C3OGtzaguI03h58AX0ntjBWJYCtgrFGUyxIK1nqZQyKfvS+6Awo/AVnEJ4
         b7mgyw5nKIV4MAwM2au+mqxcHuWYSBnVWy/MHwN5MvMXuCwxIe0xK9Lsue5qmt6onOSq
         kP/u5rnXChRaB+kfDDrWC1+XS8Lnigi7wDaHrNpXJpvlw6BmNHFkyBB85QQ4SomijHZK
         m9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1voMxoQa98ioLP/md+Qqpxzsefa33odabF5rTPnj5qE=;
        b=UDKQiTiKhpKyU1sPo/opDIEvH4H7wyMLFqLotBzT1zdw++qIwyuRGAL6V17zPz8Hpe
         sSGXlSEp+o8HLNrlUeykO6LQgpUywt61pdZttZbfKWvJ72Tq6Ei8JjssSBBBSl8RLcXw
         6MoBaLspxqO0etVzYeJgrFgUy8ovyZEh3v6yzNPJ//Zw9ElhJ3xQlNABZP1An6BFiSYp
         lTmfYcCEjDX2iBgcmFHStApM7S7C68Ea98WPZH0Nc3QW6x8RgMxfsSEdeH6l+cIZgQdV
         50Rev+b6iOrA2L31Wy/7sz9fILEi7TWdXIPkllGGs2Q4TAh9jq/gye80SPRGawNACtuk
         i5vQ==
X-Gm-Message-State: AOAM531pCypCuyr0PQQsjrusVcWDWkHOqKeRxoOpJtHUVTzEe+o/W9DF
        IfCd2vuq5CRezh3wxn2FbJkdTeL/iAWtKCVGcqI=
X-Google-Smtp-Source: ABdhPJy63p2OGe6qAoQXRu8KXAwdGn5fDVWfQl3Xg2UCaGdJj2HrO9K+g+2UAB0+1L1rXB9gHF71DyXeg8dI3xGcTVg=
X-Received: by 2002:a05:6122:2209:: with SMTP id bb9mr10029980vkb.10.1628316759185;
 Fri, 06 Aug 2021 23:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR8C_gjZ0CE8-nEo7syt=t0MwMGVKw8BL0k_BTpsk2D5Q@mail.gmail.com>
In-Reply-To: <CAMMLpeR8C_gjZ0CE8-nEo7syt=t0MwMGVKw8BL0k_BTpsk2D5Q@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 Aug 2021 23:12:25 -0700
Message-ID: <CAPUEspik6iGd2X5tOCwvo+FNmcoipy1KGvfgNJd2KLu9-XS7Yw@mail.gmail.com>
Subject: Re: Problems with Git's Spanish translation
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, git-l10n@googlegroups.com,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

your last version has over 5K changes and from those almost 10% seem
to be missing from the original, so my guess would be this is indeed
not something that could be reviewed in time for the next release
(currently in rc1) AS-IS.

Before I gave up, I noticed there were indeed some where the original
text was too mangled to be readable, so maybe focus on those first to
make the patch more easy to digest and to get those fixes for the
release.

Some of the other ones might be added on top as independent commits
grouped in common cases (ex: the ones adding/removing spaces, or the
ones where a specific term has been renamed) so the full list is more
manageable IMHO, and might even get enough reviews to be included
sooner than later.

Carlo

PS. for example one of the first changes does ("aplicar stash" ->
"hacer stash") for "stash" which make more sense than the direct
translation "esconder" in this context, especially considering the
command is called "stash" anyway, but that seem more of a personal
preference and definitely could wait, unlike others.  having that (and
similar changes) on its own patch allows for a discussion and
prioritization without holding the more important changes.
