Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9A0C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 14:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiCGO5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiCGO5T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 09:57:19 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7698F9A6
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 06:56:25 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g3so8084950edu.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=QHf+nnxXN8vr+oMEhxzA2jPEd8Nx0AWz8HGiRsaA4e8=;
        b=lvLRjmwkNvgJzIoRI9SBsQcQ/tY21c6yPpnvkCUDaB62dArDqK+ej5uFUPeG65i5A6
         gLeiQhnH4lXHhKfzYHgcdPBWq6MnEhbOmRpNhp7V2UrrGplNjuFlC8RU6txv+LBd2Y6a
         cSld/4EV3uGs/662FAuAKvOu5JP3QWXQUFwjMcO2x8IkyF34kQQ3QuJv1BcRWy6z5lOK
         QZD04DAcqdljvscVyxEv98fh1Vlbq07dadm0sk3XfL1qmIq7YWJIH8QlbVMLos20Cb2Y
         NlEz3nBbLdFJnXySyU56LUDMZTbRs3JC65rCmMct3ubbbYw/Avk0ZoMiKOL7H+oxQYAK
         so3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=QHf+nnxXN8vr+oMEhxzA2jPEd8Nx0AWz8HGiRsaA4e8=;
        b=qrcKnwXH3cmfwujOlXxVhXM9RihIyUHlT9fdUlXAEatqWXbjPun6wWRrWn+q9SyS8q
         KpKSW2Y948k+amyde5nDpRd4dU53dLy+K03Je6SQbIBFUOOu/GNATzzSdrUZ+6CZ1rCM
         IMsHrnMhePcHK+O4S42vOACPT0OmHN3rnH4agIw6F406Y3XsYZhvlb0m1cIlHVqx1zX5
         AzATXwY0B8DVm18G1nr2a/I5ObDrJ4+nb2pxljXfDOIYYA7vRDC9fnzpaz5J7H2a4ESF
         nQEgzdLTzBq+I4Z++NEyVdZCZkxAwroK/474VZEHSvQnv/VCx2mybBn6VGpTp4L3UcPL
         O57g==
X-Gm-Message-State: AOAM530rUUi96NCLhlcu7XhNrxUJYRgQ54T95uEB9W+/fEEu4kiLAQzH
        dvqxUKR4IxIdr4ROFbUIJ1jdO9jwR/OPYg==
X-Google-Smtp-Source: ABdhPJzppdppL24LkXvEKPAr7u9znI+bYcL94JJP7/ZqnKjfhzClqwTufowGPi5MILyRgdGeBFnzSA==
X-Received: by 2002:a50:cccf:0:b0:410:ba4e:65fd with SMTP id b15-20020a50cccf000000b00410ba4e65fdmr11556816edj.31.1646664983497;
        Mon, 07 Mar 2022 06:56:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z24-20020a170906815800b006dab4bd985dsm3859378ejw.107.2022.03.07.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:56:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nREmc-001YDJ-BJ;
        Mon, 07 Mar 2022 15:56:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/11] Partial bundles
Date:   Mon, 07 Mar 2022 15:55:30 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
Message-ID: <220307.86k0d5zu95.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

Just on:

>  Documentation/MyFirstObjectWalk.txt | 44 ++++++---------
>  Documentation/git-index-pack.txt    |  8 +++
>  builtin/pack-objects.c              |  9 +--
>  builtin/rev-list.c                  | 29 +++-------
>  bundle.c                            | 87 ++++++++++++++++++++++++-----
>  bundle.h                            |  3 +
>  list-objects-filter-options.c       |  2 +-
>  list-objects-filter-options.h       |  5 ++
>  list-objects.c                      | 25 +++------
>  list-objects.h                      | 12 +++-
>  pack-bitmap.c                       | 24 ++++----
>  pack-bitmap.h                       |  2 -
>  reachable.c                         |  2 +-
>  revision.c                          | 11 ++++
>  revision.h                          |  4 ++
>  t/t5300-pack-object.sh              |  4 +-
>  t/t6020-bundle-misc.sh              | 48 ++++++++++++++++
>  17 files changed, 215 insertions(+), 104 deletions(-)

This is missing a corresponding change to
Documentation/technical/bundle-format.txt.
