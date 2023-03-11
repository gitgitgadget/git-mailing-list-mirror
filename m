Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D8C6FD1C
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 20:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCKUEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 15:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKUEX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 15:04:23 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7DBBAE
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 12:04:19 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-17711f56136so9676938fac.12
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 12:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678565058;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=l7vqciDwVb7rw0koVFr8cur8DNbX4WqHahWUZ0XEpO4=;
        b=eyFDHpnNKMyPlRuyOvKfa4lRY+igF5J8qP81XWtdMgAWvik8CseA0MUTt+QaFavqeF
         PWAUuTPNJf1vg/AWV3JU9jpO3H2hPubrnRmnKGoiGG5nGmJu+nfyN/2Qw7dC0UC2sGyt
         2O67cfCowU8Wc82lusVfckMqF0s2mEVGB3eNFJYDMm1Ql2i6eQA/UsCX1V5ku9PBPCDr
         +pOND7IKqqI94uJ3yC5jzSBSxQIYnhu8eYU/5fn+5rh/1EKHlRCxn/RiGbtmfVu7loP8
         i8yDnQCbeKtdX7/qADt0+cJ635AmVrPZk4yePpOT8BhKpffskyI3QiHfmxtOEuCKqj0K
         tvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678565058;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7vqciDwVb7rw0koVFr8cur8DNbX4WqHahWUZ0XEpO4=;
        b=x5YMm61zG+dR9myQmeX4oAIqmwIougCn1UBGAoCGEQS3+BJrMyvskom4fLlc61s4mT
         ngvEwrF+K3s0hmVUu4yHIswkDO7PznBaL+yEYHIAwPyNYdIq9nMPRG+kQtzjOm2P7FeR
         xrsOL9XKJSon2u0y8fpz5C4Dq9hNVI2N/BJP7DwL2lVRUAXVJCAzqc3S69Y1BukCeTXL
         mdU2uFMrcPlbAx1cm754K1hTCvtZczgSPWuMjKUjL0aH9jc9T+EaVEQYUe15vEx19Nyz
         jghyN98EhP9Kc46JR5MHCnqsS/7X6GkMeS+W/TBzEnfXNVN/vLm1ysQyr64YO4yoC+fV
         mwyQ==
X-Gm-Message-State: AO0yUKUkiaE9vdt/10XodeA3QplWnz6+4CIl/yYMn0/LVOsLi41DLgBT
        /tQn19dfM4PQvj7h6GX7Y8A=
X-Google-Smtp-Source: AK7set/AHKD7AcTZ97T+HHjJizsIzZzNfWFhqJ/0iq/gjqCtruaoe5CaDrx9zMAKcdthBcQETMZguQ==
X-Received: by 2002:a05:6870:b699:b0:176:770b:5db with SMTP id cy25-20020a056870b69900b00176770b05dbmr4576609oab.1.1678565058689;
        Sat, 11 Mar 2023 12:04:18 -0800 (PST)
Received: from epic96565.epic.com (097-091-065-227.res.spectrum.com. [97.91.65.227])
        by smtp.gmail.com with ESMTPSA id z13-20020a056870e14d00b00172721f6cd5sm1412453oaa.16.2023.03.11.12.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 12:04:18 -0800 (PST)
References: <20230225052439.27096-1-five231003@gmail.com>
User-agent: mu4e 1.9.22; emacs 28.2
From:   Sean Allred <allred.sean@gmail.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH] index-pack: remove fetch_if_missing=0
Date:   Sat, 11 Mar 2023 14:01:28 -0600
In-reply-to: <20230225052439.27096-1-five231003@gmail.com>
Message-ID: <m0mt4j5a2n.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kousik Sanagavarapu <five231003@gmail.com> writes:

> Hence, use has_object() to check for the existence of an object, which
> has the default behavior of not lazy-fetching in a partial clone.

Any chance this fixes behavior[1] I was seeing where pushing from a
depth=1, treeless clone was fetching content?

[1]: https://lore.kernel.org/git/m0lekp4rjv.fsf@epic96565.epic.com/T/#m83ba30c1bf91106fca61efff6619c491543034e4

--
Sean Allred
