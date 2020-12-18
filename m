Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA77AC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 20:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7306623B6C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 20:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgLRUrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 15:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgLRUrl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 15:47:41 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCE2C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 12:47:01 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s75so4266183oih.1
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 12:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XdeOIVLefrhGjwQZylmgBC5M9Z9ws3zqrQjMX1Ek5Z8=;
        b=oZN2Lu8ZwV/TVmLJLlVpfD+PyTaNfa9LT1dqZTwWwi2Syi4bg2NuQHb3zqM9WeX2C0
         +N/PhwgKoW9Gl4EtCvJ3mmsdtwmTfqnW+Kxu4PoijGao4fy5RUyxTKRdcewOJrd44qH6
         yLqg/OQZrKQbXCwhfkgwKpaycVwLjpaqH4Z6uPQdCgFy04rtWDWXJ8Ie8DTCDKnvHrt/
         s36n1V4Eym3UZ2I46u9fwDIG2jWm303BljfB6ht2CrUldA/6AqpXlXtd0TKsN7t/BCNR
         NV3zCCj9kSIcE6dme+SLJpVxl5+fne+uznFKsKWksqOVMFk6jV1oSuKjIMoKBqdvDFQb
         QKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XdeOIVLefrhGjwQZylmgBC5M9Z9ws3zqrQjMX1Ek5Z8=;
        b=N/MOyuCpCiCwhpASk+0ygieqJf8oq2ZnmItzjSsdiCqHudCchu0NWxuRRZzv7WQ0L4
         dehSMU4XMJXJPXMoy7qWHPEBFE3arPiFifn5u/tfxosVFYt4uePvNhi4xIUuhIVtCceU
         2c7AEb50NHhCQ2AJbOrjhw9PK21RII0A3k7YRsgOjDVK4HcORZKSp5PagMsqAayEpR0S
         o19it93f4N40t6Uh36+7Gevwo+Ah6MkB8hdTHiM0mMoqIeolVJBdEquVGfyXvOBfB5zc
         5Ofc8mw7jCdhJ+w5YL6+UxWDak2kI4vl74lvQeowZTBeQ4ToqEnadvbRLfU7zz9fJZ/R
         jFnQ==
X-Gm-Message-State: AOAM530J4El12YCZvpCB+G5+jy0gAlfCdUqFtOwx2LufaVqmMaPcu27N
        a0prChHF/YlthWYUQ5VlO+JwTzlgMxMSSg==
X-Google-Smtp-Source: ABdhPJwcSYfrwvexSF1Md8pKX2fmqsD43wiNF4R8K788SimeHl2aftQZ7oTwJ3KGARhirKc1w3PRUA==
X-Received: by 2002:aca:1713:: with SMTP id j19mr4070968oii.165.1608324420846;
        Fri, 18 Dec 2020 12:47:00 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 59sm2107320oti.69.2020.12.18.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 12:47:00 -0800 (PST)
Date:   Fri, 18 Dec 2020 14:46:58 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <5fdd154264baf_130e182082b@natae.notmuch>
In-Reply-To: <5fd8aa6a52e81_190cd7208c8@natae.notmuch>
References: <20201214202647.3340193-1-gitster@pobox.com>
 <5fd85811c3a6_d7c48208aa@natae.notmuch>
 <xmqqmtyf8hfm.fsf@gitster.c.googlers.com>
 <5fd8aa6a52e81_190cd7208c8@natae.notmuch>
Subject: Re: [PATCH v7 0/5] making pull advice not to trigger when unneeded
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Junio C Hamano wrote:

> > "--no-ff --rebase" (in any order) would be a nonsense combination,
> > as it asks "please create an extra merge commit even when the
> > history fast-forwards, but by the way I do not want merge I want
> > rebase" [*1*].  It should error out when the history fast-forwards,
> > I think, and it probably should also error out when the history does
> > not fast-forward, instead of rebasing.
> 
> But we shoud not imply what the user didn't say.
> 
> Yes, "--no-ff --rebase" is obviously nonsense, but that's a
> simplification of setups the user may have, for example:
> 
>   git config pull.ff false
>   git pull --rebase
> 
> Here, I think the user is saying: "please do a rebase, and ignore the
> pull.ff configuration".
> 
> But the other way would be:
> 
>   git config pull.rebase true
>   git pull --no-ff
> 
> Following the same logic, the user is saying: "please do a
> non-fast-forward [merge], and ignore the pull.rebase configuration".
> 
> Either we imply the merge, or we don't.
> 
> I don't think it makes sense for the code to imply the user did say
> --merge, and therefore don't show the advice (or in the future error
> out), but then continue as if the user did say --rebase.

I didn't see a response to this, but after thinking more about, I think
I have a clean solution: just remove all the opt_ff logic altogether.

It's clear --ff doesn't imply a merge, so we shouldn't act as if it was.

The warning should still be displayed.

-- 
Felipe Contreras
