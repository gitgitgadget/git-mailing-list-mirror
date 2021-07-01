Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D946CC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33AF61410
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhGAXP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 19:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGAXP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 19:15:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AB8C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 16:12:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v20so13118407eji.10
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lDuh59hDttF59AfpkExLNSgSUFbMwFA4EFsUyOn6NLg=;
        b=Nur1mDbnQsDQodG2DcQvJv3lDef3yAqtKo4R8zZoKPYNgww3HGBN01Is8IfipzKoBL
         XpX/OSMZcCZjLK/b/pJK+Ap46/pjt5Lw0UJuwxqtEE91EEKwQkNqr2IkTp4O6cAl0y0m
         Ytc0IY1fG9KeNi7ZSuHw99+tnTg7s40ni1p/YgoVYhkrQOZYgwOlt4/uR0iypDdSu7VZ
         jWqeiMFpdx7U/fXMDC5KjfS2UQ4NnqDfpiktpFJiaINHHIRc/7g9LM0a/6vkX5NxXxjr
         9QkU8ft3k32pjCey3hPY/GKxfX6DOhLWNTz4knwtyzE0P0W54huB0dXcdIJa9SKiQfqD
         XFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lDuh59hDttF59AfpkExLNSgSUFbMwFA4EFsUyOn6NLg=;
        b=LPL1VNtYJsPgMAeRgV9g+ltR/c5Rtflmqyq8N2Q4E3KK6+la9Qf+N0LSF4KrgZ0V/4
         zbnXiWs1eC+j9roIDrTZyA5T1onIn7CfGpiuq9llt/6VZW7DqyunLer/NlEDWjdf4qpp
         ypVRCuTM7g1tylD501R0EbsV2xxvke0quIJBiZGjLA8nIomRzg1m1ZkVr+g7CkqSwIvV
         R0IYdd9Jbv1pcLyA3F28ca4MRYU02Zkq5tioQexLQNWc1glJlapYU/ZvdRZZJMIhhaas
         vqwuW0UBOOEMxdlHLjA8lfC7kOUQB6dTHmC6Jo+OA7RR1sipIp57OkrRDoUt3alHcSmb
         tcGw==
X-Gm-Message-State: AOAM532IlMEmRFGoTEEZVFPX1fByqcSZnWpfHScQxPfFvXSSyzUhGG8t
        mV1gwPbJTz08IrAciDVwMnFUbokk56QwHA==
X-Google-Smtp-Source: ABdhPJxhsv3edn/obxZaT1jQETlpOkX38/v3eZsP8FCNvUumoL6mvhUbM+6748FFoPrqzIje7EHorw==
X-Received: by 2002:a17:907:2d0a:: with SMTP id gs10mr2272710ejc.207.1625181173541;
        Thu, 01 Jul 2021 16:12:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n11sm410741ejg.43.2021.07.01.16.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:12:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 25/34] t/perf: avoid copying builtin fsmonitor files
 into test repo
Date:   Fri, 02 Jul 2021 01:11:26 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <a83485fb10f57326a725579f329b73ebf9240ac6.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <a83485fb10f57326a725579f329b73ebf9240ac6.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87eechbpcb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Do not try to copy a fsmonitor--daemon socket from the current
> development directory into the test trash directory.

Okey, the */fsmonitor--daemon* rule covers that...

> When we run the perf suite without an explicit source repo set,
> we copy of the current $GIT_DIR into the test trash directory.
> Unix domain sockets cannot be copied in that manner, so the test
> setup fails.
>
> Additionally, omit any other fsmonitor--daemon temp files inside
> the $GIT_DIR directory.

So is the "any other" also matched by that rule? Not knowing the files
part of this is just phrasing, would be less confusing (if that's true,
and you didn't just forget to add a match for them) as:

    The */fsmonitor--daemon* glob will also match temporary files the
    daemon creates, but that's OK. We'd like to ignore these too.
