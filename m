Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77798C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 21:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbiCVVTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiCVVRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 17:17:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF55641F
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 14:15:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so23201702edu.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=baKhLhQe71b1qlY1xO3T2IWMMf/a718xeNbETXO9/dw=;
        b=ILnPGo6V21viy8v1aaaK4G4Ih5cGvqfVu4/WlkN4ntrevqaFuI7WpmySGsbMs01RxH
         UToDSWnVK7WA3185Uw3MrEhAdPNu2c1oD6hwxccllR0ggF1RGJiPUGD4Af7C8h9AZrmL
         eHuyWKPVWE4Mb4RTeKv20mYFfZTPvmMslqs1rDwnMA0kftAaF7vxxmlHk4lSefpwbgeT
         eY6gO6Ybwr1hq6u+TK2fjFYdcz2qoX6sCxdd7Pbpg1fYaYKR719HQmu//2aOrMzTed4a
         eU2BkbWM2beL3ymD3WY7O3bmMJMBb8lXjxyqv6r5rV5ThvrmBHuK+ZXLKmSZK2YHrsBm
         ugvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=baKhLhQe71b1qlY1xO3T2IWMMf/a718xeNbETXO9/dw=;
        b=WXP6TRyUpIxFf14FAZNIvIZ4x6b+gSsH8UFMSWjsVZ29+gBH2hFOqUawD4gA7mw4IJ
         CUbhonx2+H2BtwBcUmo4byK/dLUN1yo8bOP7Q/8MFKZIyCIBT+3NAL3ixTI1GV0wyUth
         J+TOA1x/AWUYk5oOmF7Uf+tMOlBmbamIlM7Xo6HQWJN6zUorxwv/9SmK+UVXiuSLdCJU
         zwqH6jQ+D1YjGXAPzUr2Sj+n3eprH6VQGAwHR2YSjTBvDUyXZmaAuJxlJbg0p6NmLaLL
         IWCrf7nTVsHS7OVkYeyiUetuGfqw6ta/LPswcdAgAmOhDQUeGYojpyo18z5hWUL+TTN5
         jEVw==
X-Gm-Message-State: AOAM5338xaE9UtS6oTHVrW4vL6q9gov4dnicw1G+FoY8LJi7A9279Nqx
        cyKDwXcWFrcFpUoUBTuLaCM=
X-Google-Smtp-Source: ABdhPJxmGjG5V++fC1QXrLLiC/6ipueg0yEt1tL4yk46+8o8kfMnDywbpCfynlpzdW9Q2+bE3PDimg==
X-Received: by 2002:a05:6402:1941:b0:413:2b80:b245 with SMTP id f1-20020a056402194100b004132b80b245mr31097420edz.252.1647983731891;
        Tue, 22 Mar 2022 14:15:31 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm24-20020a170906c05800b006d58518e55fsm8821997ejb.46.2022.03.22.14.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:15:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWlqk-000I7u-Fp;
        Tue, 22 Mar 2022 22:15:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/5] pack-objects: parse --filter directly into revs.filter
Date:   Tue, 22 Mar 2022 22:15:14 +0100
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com>
Message-ID: <220322.861qytpu31.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 22 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The previous change moved the 'revs' variable into cmd_pack_objects()
> and now we can remote the global filter_options in favor of revs.filter.

grammar: s/remote/remove/
