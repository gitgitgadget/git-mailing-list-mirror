Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A1C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAF261107
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhFPOaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhFPOaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 10:30:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8814BC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:28:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k7so4206439ejv.12
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ECnXhWWILFcDNOg3mnEJlmioC0KwuvWoRjgduJjsCtU=;
        b=XSbx9XrssGZXpiyQAMAq+dGALJqXZzKbB3IxtkIhDIDOt82FS+XcOeC5cUs24U67qj
         RG9Ez+6lxqTjaxat/e+QdfRsdjosnKnMGGo5dESFTdKCbS5wTfOS6NgF0moY+nBxmHHc
         Rpdtf7DABfMhDnNU+n3ELXIMh58PAdu+LlUQNk20in2I5PiNg8J+0zoEHdfzOnlm+ZVd
         YVXj8Pm1Aaae3F1dHey/jotbbYoqgb/cFKWAlop/X1tR40PXJiiOkOco2d5aH2OrCYvt
         o24PFZ+VfiQwymibKpwulSJDui5MTkx++XKlEM9oA0VnCGV5Zu0WD95t2yL+u9Ok9hki
         NFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ECnXhWWILFcDNOg3mnEJlmioC0KwuvWoRjgduJjsCtU=;
        b=gH3iANJuA8Ch/7h4v+7kQHqPU99cmjVoufdQYdcCdJpppNg84G9kNXU3qHVOyV+zhn
         4nKMdqQnaq+4QLgOoYEZ4Etsb1KQnCbxn/3gHLVoNoTmn3zlll8HlozrfAPBb7OkFRwy
         KM29M6cU4fBAzLCB2dSqDBualyKF1fdMWyxXLSSIIb2jf2Spb5qEDMVYMJvSLI7U5ytP
         1xhbA1YTz6PYutAVxDsAkDmhojFTxzrFY/fzKNxLEubrMDcGhqu1hMV2lnrinniWRNmF
         tOZbC3YJqsn41Qs0RsJ3lSxtbIJluCPE7xF/uPhFzkWblToIHZ1tj9Nx2JnSt10WmAil
         +0/A==
X-Gm-Message-State: AOAM530FlJiT0OmkW3jNmSBn2iSBmfPj7FgHwj7xwpVWOCUmUZZXx7Fz
        rcZSIJdFQfF/ZgP7BCQ7BCA=
X-Google-Smtp-Source: ABdhPJwlWqRo7vm8eA+Qb9xjepn5S7TL1LJlfVymKfl03/cufpsFZfNJ9MnqAEZ/3NOPEiwlDh00pw==
X-Received: by 2002:a17:906:e253:: with SMTP id gq19mr95654ejb.138.1623853694083;
        Wed, 16 Jun 2021 07:28:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g11sm1944013eds.24.2021.06.16.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:28:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 00/10] diff --color-moved[-ws] speedups
Date:   Wed, 16 Jun 2021 16:24:48 +0200
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <pull.981.git.1623675888.gitgitgadget@gmail.com>
Message-ID: <87eed1yjcz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 14 2021, Phillip Wood via GitGitGadget wrote:

> The current implementation of diff --color-moved-ws=allow-indentation-change
> is considerably slower that the implementation of diff --color-moved which
> is in turn slower than a regular diff. This patch series starts with a
> couple of bug fixes and then reworks the implementation of diff
> --color-moved and diff --color-moved-ws=allow-indentation-change to speed
> them up on large diffs. The time to run git diff --color-moved
> --no-color-moved-ws v2.28.0 v2.29.0 is reduced by 33% and the time to run
> git diff --color-moved --color-moved-ws=allow-indentation-change v2.28.0
> v2.29.0 is reduced by 88%. There is a small slowdown for commit sized diffs
> with --color-moved - the time to run git log -p --color-moved
> --no-color-moved-ws --no-merges -n1000 v2.29.0 is increased by 2% on recent
> processors. On older processors these patches reduce the running time in all
> cases that I've tested. In general the larger the diff the larger the speed
> up. As an extreme example the time to run diff --color-moved
> --color-moved-ws=allow-indentation-change v2.25.0 v2.30.0 goes down from 8
> minutes to 6 seconds.
>
> Phillip Wood (10):
>   diff --color-moved=zerba: fix alternate coloring
>   diff --color-moved: avoid false short line matches and bad zerba
>     coloring
>   diff: simplify allow-indentation-change delta calculation
>   diff --color-moved-ws=allow-indentation-change: simplify and optimize
>   diff --color-moved: call comparison function directly
>   diff --color-moved: unify moved block growth functions
>   diff --color-moved: shrink potential moved blocks as we go
>   diff --color-moved: stop clearing potential moved blocks
>   diff --color-moved-ws=allow-indentation-change: improve hash lookups
>   diff --color-moved: intern strings

Nice to see these land after the earlier on-list reference to them.

I skimmed these mostly, and am not familiar with this code, but didn't
see any glaring things missing. There was one existing oddity with
assigning a 0 to an "enum diff_symbol", don't we want
DIFF_SYMBOL_BINARY_DIFF_HEADER? In any case, it's just a line you touch
in 02/10, and pre-dates these changes.

One thing I would very much like to see here is a conversion of the
existing ad-hoc benchmarks you note in commit messages to something that
lives in t/perf/, it really helps future maintenance of perf-sensitive
code to be able to re-run those, and I for one find the output much
easier to read than whatever tool you're using to produce your
benchmarks.
