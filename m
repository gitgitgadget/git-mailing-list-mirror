Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7657AC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516F0613C2
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhGAXmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 19:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhGAXmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 19:42:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1AC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 16:39:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x12so10784331eds.5
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HzluqdWpItRMIjHFJMPtcjLh7OzxnlYEpq+FZFkJ7kc=;
        b=K7clrBP/NtcvI8UrCoa1Qx/8DsREoQa8JnURZK00NaU/pJBwoJMX++YYr+6if5Qsae
         bR+42tVE/0RZJyVI/Ra8xpCA7zjo2kWk18boFjxrRwHjro8BOVVCYgOPhqI6o9ZNeZWp
         crFiO1WSOQEBLNJFd8iv6TWSDMpCuOhi6WZAlBXj6gnNHflJaX54rnkotq20TrRIVydI
         jOv09agdf1daFDIZ6rNPE4/EvUxPPZco4WY7q0r85CB+XU3Y+KLM/I/WSf4PwMy6fzxJ
         53ZPCc6uCs9Oe8Z2B/xuMJMFbqJjWgvKcEPvibPIvPQSCeEisTKlLQEw0WmISzjv/TXH
         IkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HzluqdWpItRMIjHFJMPtcjLh7OzxnlYEpq+FZFkJ7kc=;
        b=E9rMWtRs+fwt0zlRBttyzcEmzvuBUtLH69wfHx+/HDV7ukTeTBUegM2zoIb8rjHYNw
         qnOtttHX9GzdNZ3OQH0h7V1FLLDSwHOHvkCsaQCN3Ms/H5A3ViCTKdgFE47TysGw0ptP
         /FLelDdP4k3lH/dnlZc+ARWDQA+GrzJyIA/WSNB8BHuCPXEhTzSOwSR554qux5xYq+p3
         aJNfxuPcWOz577NQ9vqMCq+9rT+it+U1ue80mWLaABuUuAaykg6oiM0rQaATTssDSFm9
         H+h0CXAvdWjgsUrYjEbbe1oiQiDYC7c74hrORMnEuMIwjzB8iCC9sbMiNh+IB9yX4JwW
         Wcag==
X-Gm-Message-State: AOAM532RJEXyViOJlu89qeBI0c0bhXXR7fMZ5eEgWL4LjtCU8lNM71hU
        H8qxYCpH3oMPtaj+HPFytVQ8c84aGwItKg==
X-Google-Smtp-Source: ABdhPJwLS/FAu9x2s/D4qNblHHo5noZUqpnIw8f9jp7QrgrIAYXrsil1pQNcc7FtcleYgMxWXTdnfw==
X-Received: by 2002:a05:6402:5154:: with SMTP id n20mr3006644edd.8.1625182769682;
        Thu, 01 Jul 2021 16:39:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b25sm546889edv.9.2021.07.01.16.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:39:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 34/34] t7527: test FS event reporing on MacOS WRT
 case and Unicode
Date:   Fri, 02 Jul 2021 01:39:09 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <627e27fe60bb543902fdcc4b2179c620403d9c38.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <627e27fe60bb543902fdcc4b2179c620403d9c38.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <875yxtbo3z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:


> +	[ -d test_apfs/.git ] &&
> +	[ -d test_apfs/.GIT ] &&

Better as "test_path_is_dir".
