Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C8BC4332F
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 19:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345154AbhLVTRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 14:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345143AbhLVTRk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 14:17:40 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04953C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 11:17:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z29so12474670edl.7
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 11:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOEZ8RubB4Czr1LJF6lHjhZavplhEyGiTWD8kwJGb1w=;
        b=SbLAolxf0o8H1PPVwr9TU7y3Hoh1eS7NyVW/Z1JXAtI0ih73bL6zjk8IHEdsXDHmZB
         eNFROA+thNe6Sc5hGDu5Im02E43iqK1lms/p9osF9OMK2uyOEou/JvlBw8TWQHqm+6ee
         LYA2irFx3SEck4t51cQgyySJIFu1QfdiVPG+Y3w2Ym0GJ/HDzLXLUA8D9UPxr8swkEuf
         NsOySS8tg6pUt/AqfR+hjxiHRvKwtvFmZITJ7+jfL5JFItLKm8eRRIxQtxpOBkX9Mpr8
         fIrJKzRBwRwrj50Yl6qZnlWhcy6xDi1uPHMYkXIpIrmNeZqnZ4/0G8iARaWyK+VWl+yo
         c2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOEZ8RubB4Czr1LJF6lHjhZavplhEyGiTWD8kwJGb1w=;
        b=IWB96SfiD4+Xxfx4UXnDbhf+kgZ7j6HLSgnF2gJK14+ZyVlsKGFQLLAVGyFZpypjzf
         /8DIkEDIwcKvL24iShoBZdXfegcpPweRSiE71txN+1y7/gLnS5PcoPAQlh2iBFe3haTp
         5U0gBhB0djE9dcnOc+8xxgKsjmFIpkaMK4yiXv22AUU9BNMGkh0niPW9YlWR6942IdTp
         K3n1ekbstnF5Hn1UNvBsuVbjzvBX9ZzhO9KxaT+Px0IOr7N2kMiHSwU6Bwoz9gy5ueC1
         ht35YSW4BAPmGkrYhTLZ6LKomxm7fb0XJ4QUV+9IRmDh1dRor1RSceu7HjuIaZn4u/da
         IVrA==
X-Gm-Message-State: AOAM532bQTdEF70hFcjhRVayr0ujg8slSo8jCkMQW/b+jDixDBPQgjfz
        X0310MzV8j5Pm9VlslhXoQT79hsFrzW78aPXBpA=
X-Google-Smtp-Source: ABdhPJxLbrgjVRzZoTMo6bem0lB3ZQgCraDDY8KM6qbNnn1uQ2wUBLZhbAyIaHYAQhTx8MaehV2xI+DbplxrCAJ4aSs=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr2858651ejc.476.1640200658613;
 Wed, 22 Dec 2021 11:17:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com> <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 22 Dec 2021 11:17:27 -0800
Message-ID: <CABPp-BGuoY_R8Cfoa7OfoqqFt4ZuWn9dNyN94vcJb8XJMXOvRA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Sparse index: fetch, pull, ls-files
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 6:20 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is now based on 'master'.
>
> Did you know that 'fetch' and 'pull' read the index? I didn't, or this would
> have been an integration much earlier in the cycle. They read the index to
> look for the .gitmodules file in case there are submodules that need to be
> fetched. Since looking for a file by name is already protected, we only need
> to disable 'command_requires_full_index' and we are done.
>
> The 'ls-files' builtin is useful when debugging the index, and some scripts
> use it, too. We are not changing the default behavior which expands a sparse
> index in order to show all of the cached blobs. Instead, we add a '--sparse'
> option that allows us to see the sparse directory entries upon request.
...
> Updates in v2
> =============
>
>  * Rebased onto latest ld/sparse-index-blame without issue.
>  * Updated the test to use diff-of-diffs instead of a sequence of greps.
>  * Added patches that remove the use of 'test-tool read-cache --table' and
>    its implementation.
>
>
> Updates in v3
> =============
>
>  * Fixed typo in commit message.
>  * Added comments around doing strange things in an ls-files test.
>  * Fixed adjacent typo in a test comment.
>
>
> Updates in v4
> =============
>
>  * Rebased on to 'master' now that ld/sparse-index-blame is merged.
>  * Change testing strategy to check exact output instead of using 'diff -u'.
>  * Updated documentation to state that directories have a trailing slash.

This version looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>
