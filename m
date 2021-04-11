Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9184C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A79061025
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhDKUip (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKUip (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 16:38:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1E2C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 13:38:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u20so12798570lja.13
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZGBJywLTPoP8U5Hu9FryfudN+vM49BSAicxhRrWp9qY=;
        b=MtxUEHOyrAxh7fkvA8ZMWIqzb5hzurjCvOo5IBNECyvjmD/L8nRGrmNJfDwNy+MtL7
         N8YsleNAofSYlQkmPu6pHa51LCJwyL/qdsc6oXbtvLLQw1hW452+xgkmjpuFnOHHi7de
         RrgzRvUIF754HIQ/VyQLVBpItPnKIo6Iik549brHFOS2WxiW57aEqq6OnK5Z3mrdABbS
         BiAV/e5++Q3FUqrB58OhVsAegZHTYQlGYOBWN1JQ0tOU4G4XeYv1HdiCOfFNQB4KHpn2
         3XzKEZBx1iD35WwnROiHNT89BzEOprSPINHr2JQ9DGaORp/LEflLdHyjg1LM/ZmkOHcM
         SHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ZGBJywLTPoP8U5Hu9FryfudN+vM49BSAicxhRrWp9qY=;
        b=CHHnx5M9avstysZOollcDipH/TDLm9kGisDir3TsuEoNwyZ2mssb2OQhbIXHdxiYou
         cQBwIu6zglepr4jlTDE6eOombY1yHiXFbl/xI/HXAVP/goC8YD4M1G/E82O/GjeFCR+D
         8/UHaCLXE/ROXn7zkRKLOIcwFrjiQA4t/6XR6lcZ8MDxrcYTBz9SJ/hCHEdcoqbhbZAd
         o8inX2ITkSdag6Awu7LLUHA9a82aVOpwEYgXXTdKO8QdyITVVsngt7QFv70jGm1vHG/3
         7sGUorwFAq+44LGgdjZvz7YV/yGSA/sILPb+QipKEkdmUNE1MzUdpYH8x/YmaLYMzL6F
         S1bQ==
X-Gm-Message-State: AOAM5302CIcxdEs2neN9TMTmhcQ/Vrs96aj74CJqJE+8dzHM9MfjXEM9
        jfpyXelQH6XmQiRbHr+G6IplfiV2lFg=
X-Google-Smtp-Source: ABdhPJyXCdclzOPrBOrQh51VEzWxNN1RqySmZvKO86U2p5QWumZ074PQe5j6/aHajv12rHjFMHGLmg==
X-Received: by 2002:a2e:b051:: with SMTP id d17mr15720683ljl.255.1618173499391;
        Sun, 11 Apr 2021 13:38:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f8sm2149016ljn.1.2021.04.11.13.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 13:38:18 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 0/5] git log: configurable default format for merge
 diffs
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210410171657.20159-1-sorganov@gmail.com>
        <xmqqsg3whka6.fsf@gitster.g> <87wnt84s0h.fsf@osv.gnss.ru>
        <xmqqo8ekhcfy.fsf@gitster.g>
Date:   Sun, 11 Apr 2021 23:38:17 +0300
In-Reply-To: <xmqqo8ekhcfy.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        11 Apr 2021 12:02:25 -0700")
Message-ID: <87sg3w4kw6.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> 2. We have descriptive long name for every other option, and it'd be an
>> exception if we'd have none for --diff-merges=m. In fact, it's
>> --diff-merges=m that could have been removed, but it'd break resemblance
>> with --cc and -c that both do have their --diff-merges=cc and
>> --diff-merges=c counterparts.
>
> Hmph, a devil's advocate in me suspects that it may just be arguing
> why user-configurable 'default' is a bad idea, though.

What feels bad about it? Is there something inherently wrong with an
ability to configure a default and then request that default to be
applied, using command-line option?

-- Sergey Organov
