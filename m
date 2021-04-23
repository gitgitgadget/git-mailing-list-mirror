Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D09C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6141C613B0
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhDWUYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:24:14 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:34577 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhDWUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 16:24:06 -0400
Received: by mail-ej1-f54.google.com with SMTP id x12so54874592ejc.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGHsMoFC0Av3ZC943icf/OF2IYQgyJsKUbRokl/dP2k=;
        b=jq3nhTxNuz7jlJ066xsVJCW0hkUZ6FY9QQje5Z9dRaDCtEeOqpeihtz7qp6bxDr70j
         6EilqpJ/T7Lf0vSUDnMhTV5ZfV4k/N2ZV9rd5wGrneGYApEuucXNrJ+286o6AMuBIgmA
         Sxr6tHTbXoR0udObGb5Dj3baJpq4mo3ixxc4FUz5wjU7L8xbYoo03rpQBNZ/swirUvDr
         Imyb3uXEqFco3H8AhkPMT1p1mWoQH90KqQvFFVirYwdvHRuZEP/mGGvjcQZ6VVRrm7U6
         Y7zCj3vQO7ZhBIjFgeHtSJa1eXJg5ZHp77m3IlwfQ30Kiq6xiDnkOoEjssMCRMFMznzX
         2M8A==
X-Gm-Message-State: AOAM532QcpVpPEABV9LdHTymLWN4k3bVJ4+DppuSJa4xTE1nVT39HztB
        zDP1slCxBvalNqRDdMgA18VSP+jYttfM6Hk8mLivIAG6N+bHtA==
X-Google-Smtp-Source: ABdhPJxyfISKDgargTGN1UPy7NBY+WUhidooWU0U+XE73Qk8qYtd5rMgUiLepklHE6LxlS1LwPLyFtaBML+o4yLgj+k=
X-Received: by 2002:a17:906:6d41:: with SMTP id a1mr6197734ejt.482.1619209409201;
 Fri, 23 Apr 2021 13:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-13-lukeshu@lukeshu.com>
In-Reply-To: <20210423194230.1388945-13-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Apr 2021 16:23:18 -0400
Message-ID: <CAPig+cQLP1XFnMFWOp4Zj-Ku8M-aqgE5DmpgEy=UWLqpBBW8Ng@mail.gmail.com>
Subject: Re: [PATCH 12/30] subtree: don't have loose code outside of a function
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 3:43 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> Shove all of the loose code inside of a main() function.
>
> "Ignore space change" is probably helpful when viewing this diff.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>

What is the purpose of this change? Does some subsequent commit depend
upon this or is it just a personal preference? The commit message
explains the "what" of the change but not the "why".
