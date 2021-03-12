Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D49C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967D864FE0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhCLJAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhCLJAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 04:00:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2137AC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:00:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id dm8so6857510edb.2
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=c7lBXlwlBYZItX3KChLWtbni41xF0P2Q3lkAoXtpBKo=;
        b=fwwky9HCZhqCIhIXDGj5igV+KArpo93D8+/8qkRUo7MJOaf6mm/0sdVzLPuQKHcSLL
         07fMsCl37UCwZnGoDbo1qjJQsuzFsKXXmXiYhPlDOcIUBz5f8DTuMEq5oQDyKXQUtlyH
         /GZyx/hOm9vWTLFMWSWpTn059No49heL6CwJSr4rRwFALgVc+6xyNPesQFVtH+88u5Nj
         C536luDYAkmD/hmHVHtxQxdbQnVeLsyXVqafjOVX0uL6wekkQBQcOh0iDwQdTT15RWs0
         4o6DwsRKv5ms30E1RUCZZ6VoeUR3K6te4L/jTlcv/sL/Jsh8q6ckpCQ9KtjNeCZ7s57E
         aVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=c7lBXlwlBYZItX3KChLWtbni41xF0P2Q3lkAoXtpBKo=;
        b=M1B6sO2ESwtZO96MNN7+ytLWFSoSv6+rHgI0SLMYSTMBgyD+m9eY4PDAGNK54mNGrK
         afMcjpUdNEpikbn/E3sP5yiTboY3OS/BRe7hz+kgLRbhxGyAkkbwzyr7L5ZnJckiHMrl
         0ocWD1OR4I4PJG+CisKX7+HK7tp/LK+lGy8heUFvO9Nvj/qkSRd1cCwGXr4HfPAJQJL0
         inomUtSsJLAuRGpGt/d6JIGFi6dom+2TSz+lCbMOJTfBdMO3cWLPbKXERGUTztvt5JrY
         kgarUFQM2JD6x2RXDgcARTfvOTMonWKhI5IwwZjE36Xn/ziKNdfOe2ZAmCD3DjKfp60Q
         qPiw==
X-Gm-Message-State: AOAM533fDNzz+5LHIfXBhglsq4DcFD9lFaoCifL6ds93JEDVKYTAxCwt
        D7jgTbegOn131/6zoNAJExCHhbmINKoV1Q==
X-Google-Smtp-Source: ABdhPJys8HAgBvUWfHdF9walj5fux52/i4G9f4o4SPzdkJS+DXAX0jJiO/6fF3rVUxk1Eoou3U1VzA==
X-Received: by 2002:aa7:c450:: with SMTP id n16mr12532089edr.16.1615539620759;
        Fri, 12 Mar 2021 01:00:20 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g20sm2512143edb.7.2021.03.12.01.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:00:20 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 10/37] hook: support passing stdin to hooks
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-11-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-11-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 10:00:19 +0100
Message-ID: <877dmchhlo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> On the frontend, this is supported by asking for a file path, rather
> than by reading stdin. Reading directly from stdin would involve caching
> the entire stdin (to memory or to disk) and reading it back from the
> beginning to each hook. We'd want to support cases like insufficient
> memory or storage for the file. While this may prove useful later, for
> now the path of least resistance is to just ask the user to make this
> interim file themselves.

We need to worry about cases where we wouldn't have enough memory to
buffer the stdin, but still need to then do repo operations on the input
from such a file, presumably some giant pre-receive update or something.

Seems unlikely, and the convenience of having stdin just work by just
allocating that seems appealing, but let's read on to the rest of the
series...
