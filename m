Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51968C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3152C60E09
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhHMUtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhHMUtC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 16:49:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0432BC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 13:48:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h11so17386451ljo.12
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JTlc/zr1+iV37VX2ARlaKNvdZb47eJ+4kG8pbQcJT8=;
        b=HCk770WfFQy7TgY9Ymp0BLWy9epw+aREMn86nZ53FxfjAah+X7osjQlsKY2g2dkRrK
         hF6mEohXtJnpXSmyFlvC6KX4oG3MM34zi6CFEwSRXSR9RT1d93thVYu6v5997gOh0inx
         1OgcTgB/ilyfetLFVizVBs+mvToD/H9IbL68DYI8RvsaAq5RGA4msHq2rdOdyNMkJ66S
         94htzFyhIkLYvFJpi+BlmAOc0KUJkyV8pZvMk5dWNIVZL+21IMzMHtSyzQ20bWVBBgde
         wSmasq4naIUx/CrDL/hdLkwZs1qV9WdltOSnHtJYfXCmBFOsnrP0N0i7taoM7PpvW9ge
         XqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JTlc/zr1+iV37VX2ARlaKNvdZb47eJ+4kG8pbQcJT8=;
        b=srF07vAVQytHHVcvNzJhAVb1XYi8g34hyL9iJ0ppGU0CWx/gahOk8lnlicA0kk5Z5h
         UVzIX9ttxCkgahza3Krm4uJQf2otSMYP06EtcSjk5KDCYV1Fxw6FT7xeyoZzOUV+JS+Q
         rpw2DmwxaZUT3/i5UGDJ80WNA8P47cSdvPeOzvolTSngJ+sQRrpqU14W60E6r0PH3IzO
         MU7sQTcx3MaxhxncDuX59k+/zKoXBFJboOdUT8O7iRrKxvqYS2kuah8Gnjb8EXOyo+RS
         jPQoHfLZUjU2pFJUnZU8U8l1RXr03DEE71NnSiT+wDpBgeM3rPhdom2ZM9pEhcXkey1G
         2QPg==
X-Gm-Message-State: AOAM532oj/V6ZGIH2WmF73/RsQwCQ4wADt8pwmi/f/e0S5JzedOg9TQt
        tQxnRXEwQ1X3qiPcG6V+WbsukkFywD2DvMVSkev5sun3UbUGFw==
X-Google-Smtp-Source: ABdhPJwqVuRD1SvwjaTKpjyCnDLgu+5yNvWfSUnlLdL0dTHRky9hbCbD6R9LajSmRdJVI8BURRD5dVzLX5q0alh8TgE=
X-Received: by 2002:a2e:a587:: with SMTP id m7mr3125770ljp.493.1628887713172;
 Fri, 13 Aug 2021 13:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
 <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com> <xmqqeeaz70ph.fsf@gitster.g>
 <YRW0pGXXWnY7C470@google.com> <xmqqpmuiynbs.fsf@gitster.g>
 <YRbU0uBxqinQ1EnE@google.com> <xmqqv949uly9.fsf@gitster.g> <YRbYWR+X8vSq8CYe@google.com>
In-Reply-To: <YRbYWR+X8vSq8CYe@google.com>
From:   Mahi Kolla <mahikolla@google.com>
Date:   Fri, 13 Aug 2021 13:48:21 -0700
Message-ID: <CAN3QUFY5vxb2s0f+5xyt4UQbXwWqqDrOxXz9p0mtQ3qyDfJ0zw@mail.gmail.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Mahi mentioned wanting to rework her commit to use a config besides
> 'feature.experimental' for this same behavior, so hopefully we will see
> that change come through soon - but today is also the last day of her
> internship, so we may not be so lucky.
>

This change is pretty much good to go! I implemented it under
`submodule.stickyRecursiveClone`. The commit is actually in the PR.
Just wanted to hear more from you guys before submitting :)
