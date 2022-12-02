Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2D2C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 03:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiLBDZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiLBDZA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 22:25:00 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C94D9B09
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 19:24:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h28so3722545pfq.9
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 19:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cyQVKnojVx5YXzQmI816EsFqM1SuKzRoc3Mvt9XwwYw=;
        b=oaHLHHTfzIOzEFHH+fDJY7czUgtUZFiah/jlyAWpF1OOQjzsXe0bv0P5hUM75NOrs7
         6WauNO8Lz29QoDtEdAgdsO8D1BRepYVf2Lb3qTCoIccHUNcxJ8DypzpyWuNOToH1Qu9M
         0ouip1eNXM8lz1ocHvBZciuf3doeb8ddLK9RFRtI/BS13vdnaYwLDXilZCbGLLkOndlA
         oPb5eDo8oc3gSP0F/1AubkmvHrPCMskc1OPT6YQLwdPkVFqtYB30z1RcZEfZolr4EHy4
         XWqb7r5JWIMo0fWpl2I9ewZp70p278h8MbREJPblr8qNkGmaMv/D5wuMmZQSVKkTizCu
         B0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyQVKnojVx5YXzQmI816EsFqM1SuKzRoc3Mvt9XwwYw=;
        b=yqaXLpRZwI464uU3JhGp/RXuASDugV7+yBTw1OnppQF1DYax90/MhyYBQ39sW/teOa
         8I6NAVS2kifpImp5x6bjYO8xT5AaJ6OTV6i9cQGwa8cmIZ0r45OKdHvO7FV3yQr7FHih
         pxU3KfpOoWzw+mJRDmKJCWrI/GvxYmLkjfpCxTS0pIpwTj+D3LuUoINMJ1RSB90o++F3
         NfJSb+l8Uhm35+3s4TCPaz5KmtBJ0sUBgPf2/PlDYb6VYp/abtgo6yfKfibRMUl+Nmw5
         MS1uFL7/ps5OOZFKvZBfnf3UFxTlAAAePi2cm5ujwlLqBq1h4InWLndeWyCPuflK/99x
         GrFQ==
X-Gm-Message-State: ANoB5pkI+vtNlzI0CymHBhXFZJHGdc3BOfNjQDKVaFm5dQpQaot7wnum
        v/KqVaW+ZkSC7+cGq/zeBe++G2b1SFzejQ==
X-Google-Smtp-Source: AA0mqf4rA8VDjyVP730C0Vai+tDP/2aW4dRPWcjKcnWsL1vEdycsACHSkyWwcZUuz0CaakiujT7f7w==
X-Received: by 2002:a62:6083:0:b0:56d:3180:c7fc with SMTP id u125-20020a626083000000b0056d3180c7fcmr52817894pfb.41.1669951498615;
        Thu, 01 Dec 2022 19:24:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b001899007a721sm4342305pll.193.2022.12.01.19.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:24:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 1/8] log tests: don't use "exit 1" outside a sub-shell
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
        <patch-v2-1.8-7c9f8d2830f-20221202T000227Z-avarab@gmail.com>
        <CAPig+cQK8BRU0u0g+jAkyJaqSamYBynJ6s00_6H2beb6gXaRDA@mail.gmail.com>
Date:   Fri, 02 Dec 2022 12:24:57 +0900
Message-ID: <xmqqbkompjw6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>>         for r in $revs
>>         do
>>                 git show -s --pretty=oneline "$r" >raw &&
>> -               cat raw | lf_to_nul || exit 1
>> +               cat raw | lf_to_nul || return 1
>>         done >expect &&
>
> Using `return 1` here is "obviously correct" since this code is not
> inside a subshell.

While it is safe and correct, I wonder if test_expect_success can be
made a bit smarter by somehow capturing what happens inside its
body.  We of course cannot just wrap everything inside a subshell,
as we do want to allow the test body to affect the shell environment
it is running in with its side effects.
