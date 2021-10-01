Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE88C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E9D61A56
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 12:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354235AbhJAMNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 08:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbhJAMNd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 08:13:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1C7C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 05:11:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bd28so33890463edb.9
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qRakEEfNnncM3KvBNZEyRgAK6wygbIcuTJvnbHSMXO4=;
        b=dw9c2DDr65+hE7cONrvQLXS+Gi6HSivemjdIUzNQnEZARFO5seWPZgVso18zs/8U/C
         70kRR6tcVkymlkDl+6EuvmXKzhoUgE5AVH1VAoSQ6KuMs159GCmRw/0NqjA8VLyErsrh
         txGO8383eW86h7T6rplIj49lXcQkMV+eqm5ErC03yjItzYg7+cbpgqT6GDMn7qEs/XWB
         pNOM0d9khfejhtsetkXYxWwfyxH1gpxrtTWqyDMc5QBR5O9gpxxhGFUOgLihaIMU1Ffo
         HnzLEPUOBAimwOYgJU8ugjLMWCPuZSYNgj68CKgMTb7ct2xVl2lkR70htkh19sRFHU/o
         vZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qRakEEfNnncM3KvBNZEyRgAK6wygbIcuTJvnbHSMXO4=;
        b=Ew12rqBm8hYtwRQO86S9wTFN4mKqPzWFbfI7eN/VRE/XjvMxBuk3y8wCKGJFxyoKDx
         +YJRyM7GCqssiAZeacO6vO1/ImUi7C+IuSMKPSKmhNcKp7co7jIKPHD0xLy+uGQLGz+g
         RMzV4SFDnxBse+12o3BCGNUO/RZmcPKWDWlPDbFrgWbnejZLl5fzJCsvjTvuQOq39/oG
         zdPYXFj5zHt0fdM/WLCWwz3b36JX7jAE2WslGnwQmcfhwSYF5+/4U+6WJePAGD1Kbm5Y
         nQw4PATfw/bf0+V0IPZLMhMGaVzMbpWCxJ6eDpf6NNp7AhVTZP7PQrtw8U1/+nUV6tIC
         Z8Gw==
X-Gm-Message-State: AOAM530kJbYdH/TVTsJWKWENrGKJkrU93qX09TGoc3N0bl9r7hURLBhE
        T1w1bxjZfZHe3SlqIk95QAIBWD08snxQ8g==
X-Google-Smtp-Source: ABdhPJxvBIh0/p5+lCedUmr4YDAFdve910Hg9Rgsv6qOht7QTr2u/Hzp+XPkcgo5kKZZnUtRo2W03g==
X-Received: by 2002:a17:907:105a:: with SMTP id oy26mr841559ejb.565.1633090306659;
        Fri, 01 Oct 2021 05:11:46 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d14sm298051ejd.92.2021.10.01.05.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 05:11:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/fsck-unexpected-type
Date:   Fri, 01 Oct 2021 14:08:31 +0200
References: <xmqqh7e18soj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqh7e18soj.fsf@gitster.g>
Message-ID: <87y27dq70e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Junio C Hamano wrote:

[Forgot to adjust the subject for
https://lore.kernel.org/git/8735plrlql.fsf@evledraar.gmail.com/]

> * ab/fsck-unexpected-type (2021-09-30) 17 commits
>  - fsck: report invalid object type-path combinations
>  - fsck: don't hard die on invalid object types
>  - object-file.c: stop dying in parse_loose_header()
>  - object-file.c: return ULHR_TOO_LONG on "header too long"
>  - object-file.c: use "enum" return type for unpack_loose_header()
>  - object-file.c: simplify unpack_loose_short_header()
>  - object-file.c: make parse_loose_header_extended() public
>  - object-file.c: return -1, not "status" from unpack_loose_header()
>  - object-file.c: don't set "typep" when returning non-zero
>  - cat-file tests: test for current --allow-unknown-type behavior
>  - cat-file tests: add corrupt loose object test
>  - cat-file tests: test for missing/bogus object with -t, -s and -p
>  - cat-file tests: move bogus_* variable declarations earlier
>  - fsck tests: test for garbage appended to a loose object
>  - fsck tests: test current hash/type mismatch behavior
>  - fsck tests: refactor one test to use a sub-repo
>  - fsck tests: add test for fsck-ing an unknown type
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.
>
>  Will merge to 'next'?

I re-rolled a v10 that hopefully gets rid of the last bugs in the recent
updates:
https://lore.kernel.org/git/cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com/;
I think it should be ready.
