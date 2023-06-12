Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06774C88CB2
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 17:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjFLRNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjFLRNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 13:13:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE4188
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:13:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3c0c47675so14092265ad.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686589990; x=1689181990;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDZNcDHQajkmrgSpvd1Cyx5iP/GobBfMRUFfb9wSyOE=;
        b=UjspWfB/9DjaiA41K6JdHc2Yfhhv8TNVxe5bp10SDrreT4hdlfEnOQEc6wMupYi1BR
         xkp5S9kKeqyz+3UG+p+VapL2uKjX752xF90jHdOrpReM8iFwfNqtPzaKY/PTSZWc98V3
         naQT3LTUNTqlB0y9w7z7Ox1+v+Wlpwm8W8q2I7RZlr+x2m7GslMF4fb4oqzReYQxItql
         RDoGkuVLoBBb0syMtayi+5yQyz7x2pVu/UxZsZoxkTXtzWMIwxKeTGe0lyv7Di8Gr4rJ
         JCjmEeYclhQuOX3u1vZGDmK6rhi3Ir4nQUFaYs2pkVePlVWBYXljP25l6DMw8rx/HNTf
         9niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589990; x=1689181990;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IDZNcDHQajkmrgSpvd1Cyx5iP/GobBfMRUFfb9wSyOE=;
        b=iH/SV4yz7eDuZ23Z41GH4hHB6a5hUbmUvTcvH49mIGcjJBQNkwkYlqy7PLTmyxcMFt
         R36iu9M13djeICN04ZeWcPVC+0+i2ofJP9fXRJNTie0fuErFuSdK5WQBjTav2GYX+/YF
         HM+hiavivnZyiaVVkdDp5IgNf6CvileH3mQJSj/YQh0uWH1R2DffhuyDItKIqfl+mO/Q
         sBaIoxDEJfcAK/hcfKTE1nL79dw7Z6leVI4Nhf4HmVeXNR2DnDA35/0IFZD0505PdJ3U
         2vxYKygWjMowzmvXHY4YP6tV6vQ5xEF2IXmvAof7XUWLzIwrGSZ4yeovD8oOVEfTK0DJ
         wqpg==
X-Gm-Message-State: AC+VfDya46hy/3QMy/gvA4nmaRfmoeyj4U6IUKw0RSgkD1QeVkyM/H1f
        kJO3jQiWedbtCL2DOBoAli4=
X-Google-Smtp-Source: ACHHUZ4qGUI5hms8kBIslZv9wKwp2BMJy2xzoauIzedeeN+YqLjBEC3LkJgv05gnKQM9MxRL7aJIXQ==
X-Received: by 2002:a17:902:b218:b0:1b3:a41e:8dce with SMTP id t24-20020a170902b21800b001b3a41e8dcemr6511144plr.64.1686589989764;
        Mon, 12 Jun 2023 10:13:09 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001b3d756a6f4sm1707335plg.13.2023.06.12.10.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:13:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [Patch v2 2/2] add: test use of brackets when color is disabled
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
        <pull.1541.v2.git.1686061219078.gitgitgadget@gmail.com>
        <281431b8-af40-9de9-f4b4-c596c5dbb3af@github.com>
        <2143c98e-238b-8edc-a16c-be448a8b56e8@gmail.com>
Date:   Mon, 12 Jun 2023 10:13:09 -0700
In-Reply-To: <2143c98e-238b-8edc-a16c-be448a8b56e8@gmail.com> (Phillip Wood's
        message of "Wed, 7 Jun 2023 16:31:12 +0100")
Message-ID: <xmqqh6rcbo4a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for adding this, the patch looks good. Strictly speaking you
> don't need the "g" at the end of the sed expression as it only ever
> matches a single instance within each line but that's not worth
> worrying about.

Yeah, as the pattern is anchored at the left edge, "g" would cause
no harm in this case, but the intention is "we have one extra bar at
the left end to protect runs of spaces, and we want to strip that
single bar" and it makes it clear not to write "g" there for that
reason.

Good eyes.  Thanks.
