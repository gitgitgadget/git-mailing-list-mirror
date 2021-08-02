Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDFAC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B20C610A8
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhHBJfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhHBJe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 05:34:58 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353FCC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 02:34:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cf5so12046657edb.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=iPusLUyFLtKIfYo7pBRu2rjKNc+cWcZc4RFskGBWYCI=;
        b=bqPRCI3Ta70GWlHTCqKcbxzBW1UwrOttUwR/8EanrSUnJTJcakLToE4kqvaeFV9vMc
         H7c+5fz3BjEWsbYY6fDZCQ9+6sKv/yKZUouvOJRI79wIZBC60i08Nuckf7ocfzII2w0H
         qDumkyTZZ8RVuZArRuPr2Bc7NvP7q0Cg1krv5dMEfFY+8wSN5WV/++mQaKdyU8WMHVOX
         3hkXpCm8x9cMltXe6BmpvC8Zuo29qLaUDYzwQVNS4lQX/UeN2XuKAwzfFzn7qzBnvjpH
         AGTXVtG4OK8rOXqRgrnNUKb9cq5iogEa7iLqE8gOrkTttXTRnKSSdjUe0qYtXRrr8kD5
         HSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=iPusLUyFLtKIfYo7pBRu2rjKNc+cWcZc4RFskGBWYCI=;
        b=qlBmuPAfrQLk6rzkeGekOAUzfGJczpCyy5G8c33bbu7JFuaLlzHxQY7a51YsZS6fsl
         DIgbBRk7z/2PyKhmFI2C59tIbQ8MrJmNkOEDE5YqexmIAIJQVeQ0NmnHFa7Zs9uhzfmH
         ulgpka0orR8Dik7f8WjTfFLmGDfS/OQyWFitl8Gyzqp2o27Fg2w2INdg4jq9vzFgS8sh
         i7T014q4dwdv0iddruZ2ionsEtTge6c1NoYdVXLNZYImsjNJzLHRf55xECGe8e06SEed
         rFEycQdGpOBe72nN5PmApT+4afhDKPWzJYUbEOpuSvLDnXN1Rwogzo1mJlYrq/KyRntb
         AfLA==
X-Gm-Message-State: AOAM5300psx4Tq1pIFlHYR8NVy9ES4rqJR2UX/WAyl2SzjKJkMBw0mVe
        e8lwQGenpDblj5Z07Wirl6A=
X-Google-Smtp-Source: ABdhPJxPeuL3eOL8fthL1HSe4RPdeW3yPt4cOAdecybXov0PfEjf1yBxfpojjXeEgYKYBRevTbAxfA==
X-Received: by 2002:a05:6402:6cf:: with SMTP id n15mr18033815edy.362.1627896887789;
        Mon, 02 Aug 2021 02:34:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g3sm4275945ejp.2.2021.08.02.02.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 02:34:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 1/2] tr2: make process info collection platform-generic
Date:   Mon, 02 Aug 2021 11:34:17 +0200
References: <20210722012707.205776-1-emilyshaffer@google.com>
 <20210722012707.205776-2-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210722012707.205776-2-emilyshaffer@google.com>
Message-ID: <87tuk8p4uh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 21 2021, Emily Shaffer wrote:

> +/*
> + * Stub. See sample implementations in compat/linux/procinfo.c and
> + * compat/win32/trace2_win32_process_info.c.
> + */

Both of those don't exist until 2/2, so that comment should be squashed
into that change shouldn't it?
