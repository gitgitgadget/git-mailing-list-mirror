Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670A2ECAAA6
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 16:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbiHZQyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbiHZQyN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 12:54:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1143A3468
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:54:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o4so2154117pjp.4
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=n9Ur+n3sxg04CXOQyaaSdyeME75ha5djfIMe9X+SAH4=;
        b=DgWOVpGAmfapSEwn7dP+v7ItPXCegw/KcJ9DgyZn9wYaEgQEI5s/3NpDODiEi19Czb
         VZtBlECNVf09p4KPfBc1TzbzO6a3wnS6Gzv7jytNWT8nxsLBN3Dlb1jQkV2eWbckJ1Bm
         pVV0Ec1dIhZN+1nWnvNXfkq+jwPwrk0FpQ2rXgBoAnLuYLQsyPIP9aZuT3fhYKqjCQaO
         vPGb3FuuZYC72h5mWDPPYYihO5Jt/xUfDNGTiF6fvEnKnuehDYvptXpYT7vMF4FMgLV5
         5teBgAlmGkUpRrnXEj+iMHOMXump6q3zJnUCq/wpCGrdth/Up/dyV6p/czHFt35G7lot
         7sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=n9Ur+n3sxg04CXOQyaaSdyeME75ha5djfIMe9X+SAH4=;
        b=Vf55URUD6G5m0g8QFLvLj+PsUa9GsA/IlQYEVx9TQlFV1grAG7T7me7rVGcSqQ/jr4
         L37mGguxW8ngwAdJVLDerBkhgDNpIG3VrLOD6ppnlaKCz81/qefdQQjGXGQGbajFa6+A
         QR/KRXTBmzXjrx8ztv1eKI/2zK+MFTAQyOkvcF6RGVk4omDKugxdqKQTDssIa/DHfjMv
         IrmXck8q/6jmoXqOuYmffFnShwtw3wqJNq6RDCT5S6r8GP2k2P6q4u6+P3oEEY3Dwd2U
         DUDO3wAMbtDwu46YAY8Ml0dLb5j9eISF/NPbBk0ti8L0cBeXxNyJJJY5vsykXXq6aZUh
         gDmA==
X-Gm-Message-State: ACgBeo3cyyydYfP7GpGe+PL+zIRF1sfKvvLQHgZXrr63JWR0AoFe9yWW
        rgv2NBHIjrcCDr4awtHX5aU=
X-Google-Smtp-Source: AA6agR4MW2/JLSTzhOlBTOAOF54YsIPdu80sJTQWZgYgNFkfnUDsE23GID96C3P9Kd2USmGRRPmGMw==
X-Received: by 2002:a17:90b:48d0:b0:1fb:3853:b23 with SMTP id li16-20020a17090b48d000b001fb38530b23mr5091784pjb.219.1661532847156;
        Fri, 26 Aug 2022 09:54:07 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902680900b0015e8d4eb26esm1798972plk.184.2022.08.26.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:54:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] range-diff: consistently validate the arguments
References: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
        <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>
        <4cd7f09557c7d0a4802b07d1e8440015e0a50524.1661506770.git.gitgitgadget@gmail.com>
Date:   Fri, 26 Aug 2022 09:54:06 -0700
In-Reply-To: <4cd7f09557c7d0a4802b07d1e8440015e0a50524.1661506770.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 26 Aug 2022
        09:39:29 +0000")
Message-ID: <xmqq8rnbymhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This patch lets `range-diff` validate the arguments not only when
> invoked with one or two arguments, but also in the code path where three
> arguments are handled.
>
> While at it, we now use `usage_msg_opt*()` consistently.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/range-diff.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)

Very nice.  The updated series is worth having if only for this
step.  Very very pleasing.

