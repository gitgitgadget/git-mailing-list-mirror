Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC02C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CBC61153
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbhI1IfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbhI1IfB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 04:35:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF00C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:33:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s17so61514759edd.8
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=tMGjSXSnc7/ldxpIQJIPfw2+4cslVzzUPaMQ7pNDerU=;
        b=mB/ASJ8tZX8gGmMcWlgwGEUUg3IDBG6ooGMsHi7otRN/q+WJ25DLjkJCvy5MvNoeck
         pFPVeQAfuScpJ7e2PdU4nA67Ygkr7X9YpeDc9f3C94Jko2mLANJj9uhlmUn250o0LqmK
         qkR6++q4Ze2h7fn4eNzQtwVyqGHf9Iv4SqWi1/BDU4oWiJYia3ywmDR3oCaJiW1QJUnT
         DcMk2LDUzunxNNBHcnKk7TA1e7OOCybEhB/KyH6v0Tn/JaWpt81KSdIbo57ciFK/+gy3
         TJZpWQ77ap+hXutn2+a1kPUdalWtbJ2E/9/qAH3Y0BmEQVrSoijENSfyIX5OxtRW+9Oa
         mNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=tMGjSXSnc7/ldxpIQJIPfw2+4cslVzzUPaMQ7pNDerU=;
        b=WYInyWF0JTKP+tC3cB/1K7yLl9sOPVZqMr+bbqyL0qk0lGri5AYcTX5y5HUx9VIOFw
         S19naM8JDJa0hDGZKs/0hkL9xylFrGK9h6lZpgVCQvOJ/wDbsxGmIhZxhRY4PYM9C6dv
         9rpzy6sX8SSuh/1vli5OwKHWtKAhWTJKMsPTzzx6X3D4Hb/zmceJBqBEFjf4OlCsCD6t
         YZjqEFnly1WTRBbDhQxyjMIyUZRR3a2BKUuRgWSxZcjvTS4fm0CV2jNIGUXCd5VQin5k
         zcUYEg4o17IOdp0/KRs3hnbr+Zd16u/+re9WqNIDTH+am59UaLl2QjEXHLztMZyzTGBd
         mvIQ==
X-Gm-Message-State: AOAM531IV8QxI+0gAUNAmsiVgSWycKGJym53V3M54iIxShCCvFnEo4yw
        2J5ob8/raOv85D+SirxeMgr454Aa2+ED/A==
X-Google-Smtp-Source: ABdhPJypwj+mYWPTpre+m2eGcHzTqWAQXg+8O2hY/kZ2P94KIxB2K9TFrxakYLtGm0DEtLMNaCyJlQ==
X-Received: by 2002:a17:906:7754:: with SMTP id o20mr5507369ejn.475.1632818000466;
        Tue, 28 Sep 2021 01:33:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b2sm11513383edv.73.2021.09.28.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:33:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: sg/test-split-index-fix (was Re: What's cooking in git.git (Sep
 2021, #08; Mon, 27))
Date:   Tue, 28 Sep 2021 10:31:40 +0200
References: <xmqq8rzhmsi7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq8rzhmsi7.fsf@gitster.g>
Message-ID: <875yulxfow.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Junio C Hamano wrote:

> * sg/test-split-index-fix (2021-09-07) 7 commits
>  - read-cache: fix GIT_TEST_SPLIT_INDEX
>  - tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
>  - read-cache: look for shared index files next to the index, too
>  - t1600-index: disable GIT_TEST_SPLIT_INDEX
>  - t1600-index: don't run git commands upstream of a pipe
>  - t1600-index: remove unnecessary redirection
>  - Merge branch 'ds/sparse-index-ignored-files' into sg/test-split-index-fix
>
>  Test updates.
>
>  Will merge to 'next'?

It LGTM. It introduces a "new" memory leak that I re-rolled
ab/sanitize-leak-ci for, but on closer inspection it's a leak that was
there all along, but we didn't see due to the issue the series fixes:
The GIT_TEST_SPLIT_INDEX test mode was broken.
