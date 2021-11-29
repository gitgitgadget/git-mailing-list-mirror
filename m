Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017F8C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 15:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345848AbhK2Pn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 10:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhK2Pl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 10:41:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3430C061378
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 05:47:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l16so36927022wrp.11
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 05:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=a7xVxaSKbNsjzuSwN5fyloGeIqpz3rEQ+19KjEd5qOI=;
        b=WO3VcXOtDaAGQ1k+5lmjeMfeKj3FVfFYTktQYUayfqd6iZer5+LpTmHdFAdwoYSiiF
         +W7aw746hNEUhFkNn9P34SKySS1YGSjkYU1ZIuj4KzxduPf1XHZRBaDg834vS33qMqsk
         0NRe7p0BHpsDbBHHUwjpkas7XRIbG7zLyLUpVhoPc09TQyhBVJb6Z7kbBteKbAXIvYV7
         I8TPKGhRc7GIzleFjjiKzVq6FAUEq4cXPKaiuSw6DDkET6L1bpyvo0RPtAIEvld8unkd
         N4WsXm8ck6cz9m3AuJzRnxubXRiIrBdORl4qLJGi43P+sZvHw92vaCvH0LyYxxzC0iXn
         FOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=a7xVxaSKbNsjzuSwN5fyloGeIqpz3rEQ+19KjEd5qOI=;
        b=StvdyYPlUEoDi45nYE3UObCtSzdMI2qUDhD5EIpefcJiQ3h2KYaU1pFPhx/NIy0daT
         vZ7BYOhx5yuEFnExD+n8Tp9hEgxnfMjwtQpyOGspN2sw0qrwXDXAxA8LoC3UVzEIh8HI
         g0N6EKcnmbO6yQJDtkfS0Yqh7mgW74O4boHsV4+5n8ecinvJnqoYnUjSeTFtkKgQaS1q
         J6nrX481pcz9UJcXQh4qS1Bm+3CzGc+ruNDRAY1e1rmv7uUAbwE+GAh1E0WGyjpFFDVu
         XjaI8JZ9uNyH4/8weByQNZY02ioIKvUV1AFj9T7FXc9y3JxdpozRQ7DsOSCpHkfZfJwe
         jdXg==
X-Gm-Message-State: AOAM530SHqO3VecT4+hmvKBIjnvvkx9enLbinqkWVZ2zL/yZrsBZLkVI
        hXDBYrrh+BWqs5tC3IptacN2xhKiop4=
X-Google-Smtp-Source: ABdhPJzZ5tZP7j13TXy8qXTbY/24PGx6i3aKHD0JpnR1B/HsNvKvPnP9VqHuSSgZ+XPgcjLYDznJzg==
X-Received: by 2002:adf:e8d1:: with SMTP id k17mr33654625wrn.465.1638193667361;
        Mon, 29 Nov 2021 05:47:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm13911495wro.33.2021.11.29.05.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:47:46 -0800 (PST)
Message-Id: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 13:47:44 +0000
Subject: [PATCH 0/2] Set GIT_TRACE2_EVENT_NESTING in test-lib.sh
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com,
        me@ttaylorr.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported by Ævar [1] and diagnosed by Peff in a reply, the default
GIT_TRACE2_EVENT_NESTING is set so low that tests that look for trace2
events can start failing due to an added trace2 region. This can even be
subtle, including the fact that the progress API adds trace2 regions when in
use (which can depend on the verbose output of a test script).

Thanks, -Stolee

Derrick Stolee (2):
  test-lib.sh: set GIT_TRACE2_EVENT_NESTING
  t/t*: remove custom GIT_TRACE2_EVENT_NESTING

 t/t1092-sparse-checkout-compatibility.sh | 6 +++---
 t/t4216-log-bloom.sh                     | 2 --
 t/t5310-pack-bitmaps.sh                  | 2 +-
 t/t5705-session-id-in-capabilities.sh    | 2 --
 t/t7519-status-fsmonitor.sh              | 2 +-
 t/test-lib.sh                            | 7 +++++++
 6 files changed, 12 insertions(+), 9 deletions(-)


base-commit: 35151cf0720460a897cde9b8039af364743240e7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1085%2Fderrickstolee%2Ftrace2-depth-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1085/derrickstolee/trace2-depth-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1085
-- 
gitgitgadget
