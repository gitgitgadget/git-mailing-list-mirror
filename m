Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA52720A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 03:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeLNDbj (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 22:31:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35380 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLNDbj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 22:31:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so4408489wmh.0
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 19:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tgwe0Ho3zzcDb20wTvqkfI7zgL03g2UaptmqTUT9seQ=;
        b=LmcaMRQveyAHVW/dLJIPAdMhhCGqBzppO4GU7Dc1dhdCp2I/2IpD9PJGhADLadaE8b
         aPYOqobtx7d6C2U+TMwyhOuhBh8gP1SFs3fqmey8DXg9NQ8oIhnTE97qfLNYuCOVXN0l
         dZXrXHBbqnqUM/XThdNbNlKKWBtCDeCuJSAV69/tmS6v6rrLmjprRtqbV8NUf1wtDWR5
         Hc+u0E+FVsgQ5Tnn9LJKALmc56ud+I/ljhsjPWM3ZLEqqDzqBVwAYwXV30/H49DUXPnr
         0Eof/waK6HSp1u8UE3mctlTol6E3DtPSR4EONXzuour91UnnacentLZomS0q56PxZCzD
         xH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tgwe0Ho3zzcDb20wTvqkfI7zgL03g2UaptmqTUT9seQ=;
        b=SvuDINWPeh6TpjoUVxvtO2v7h2E18y0LG+hzai/P7ARDxZ4z+I34SgkrPx2UFlUgSf
         rk1oyrNADjvCbAABZcOFOfyNbc7OWIxn7mJo+XqRzm/RXg67XbsvTPNOfGwC79NmmfAR
         VKStUSe2wsiF26psalQW+/YeCBLksVRo5Osz/cdz7QgLSTvbYsp1C5jEYPXztm/cuvJ5
         ZXCjvPrUcFn1Ggv410DGeCLRjDcDzc222RSElOwisB4xbED8mK5tc4Wqwe4f7zTxxhOm
         J1RT6NLp4cnY7wYNIj7SsoS+GGVxUALQ119TtLH7i5ubkvXNGluVhJyL4p4MaMvqEtgA
         U8qw==
X-Gm-Message-State: AA+aEWZf1iPT9uP3n8rhjCQxa3/h5npPP2B5+2i5QwpwM/iNhx3LCzZb
        GZv8CZyDm/hfjj30cDX3hZw=
X-Google-Smtp-Source: AFSGD/UCicTT8RK9gJE4dZ7sLcKdvWKqmFci4tF6JJ9xAJKlKH39yx+TV0Sxp8X42UeuBStns2usmw==
X-Received: by 2002:a1c:4855:: with SMTP id v82mr1700609wma.15.1544758296928;
        Thu, 13 Dec 2018 19:31:36 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j202sm6268500wmf.15.2018.12.13.19.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 19:31:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>, gitgitgadget@gmail.com,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
References: <pull.100.git.gitgitgadget@gmail.com>
        <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
        <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
        <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
        <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
Date:   Fri, 14 Dec 2018 12:31:35 +0900
In-Reply-To: <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 13 Dec 2018 21:43:11 +0100")
Message-ID: <xmqqefakdbs8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> If you make "head" work like "HEAD", then it should work for _all_
> commands, not just worktree, and "MASTER" should match
> "refs/heads/master" and so on. I don't think it's as simple as
> changing strcmp to strcasecmp. You would need to make ref management
> case-insensitive (and make sure if still is case-sensitive if
> configured so). I don't think anybody has managed that.

And it is unclear why anybody would even want to do so.

Thanks for a doze of sanity.
