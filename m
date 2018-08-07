Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F2CF208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 17:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbeHGTzl (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 15:55:41 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46881 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388943AbeHGTzl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 15:55:41 -0400
Received: by mail-ua0-f193.google.com with SMTP id u11-v6so16991550uan.13
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xDym8IGudwmPhlPM13P5wo6iHdK1azMmDObN7RMP/EQ=;
        b=R3sJslLnanu9Z/XZYfDr6YUj+QIiIqxiT1+kyPOerUmp7APqUuzCNVjH0oRMn2vyy5
         tm70o1a0sp2LfjiNpnzdyhCjDO25LbiO8NwOREGThAYp/e7i2VkxKGMC+hsDCd05I+XW
         kE4CtbGdOrMqrr4NEzLg9nnmsQK7Zf3x3D75BfvjqZGK01ZJmFhZP9TX2TdJPKJszEKp
         Rg8BXvRBFE+3X3ZUcmuEAnP2GyZHmu0MDVoRUyYXCSuJOWYTE0wIMmysPGrouJud7//j
         A2mYbBtWFnrPrxPUxXFamqNQFSdi6ltVQILmlja1DrHUU4g6SVwYjfMvdvwetqorhiEn
         /iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDym8IGudwmPhlPM13P5wo6iHdK1azMmDObN7RMP/EQ=;
        b=n+Ee4LDGnzt5ImLKTAQh/xxeh2DDTDibECeyJ4V/18AQXDwmv8n4cUlJL8t8r0BWIA
         ip7DK5zORaZmmeAL+MG8BLauIncy6/9fGDpRixy8IE7nvMg4s7kEMPQS4HIigVuIuQpQ
         Fk0R1vQGcB22bztIZXj8Yrsxz+sZJO/r14g/HKBxh42SJiierNYGV4XYYIZemvPAH4pa
         wuWC9wkXuXXva2cybXaT8mkOvUtZZqsqjgAFIN1+OvEg6ZDA7bsSS08aCM1JA53D7bRZ
         XGrcpWG5SdL9IgwBdRyNTkSa7zY36RpSZ0nBEURIcunYtwQmXQSxjeW9H9/qg1B/cyLf
         6vKw==
X-Gm-Message-State: AOUpUlFh1ED555LrZKrUhO1AG4Z9x32GsVIKAOuFQOO7mjbkpsX1KDxf
        tCbTgM+caD/6zqDWhnlcN88kaupnOtAz7HwMYqs=
X-Google-Smtp-Source: AAOMgpfgzElH1ng1rwK9jYf2uSLdM9pd2jDnD3D9Vj03mQ/FfUQsN0/3FiZ3Z5RTKo0+z4wVoe1GokNkQmCg7bfsbi8=
X-Received: by 2002:a9f:3666:: with SMTP id s35-v6mr14768028uad.94.1533663616564;
 Tue, 07 Aug 2018 10:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180806152524.27516-1-newren@gmail.com> <20180807164905.3859-1-newren@gmail.com>
 <20180807164905.3859-2-newren@gmail.com> <xmqqo9eekrv0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9eekrv0.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Aug 2018 10:40:05 -0700
Message-ID: <CABPp-BGB5dD6UYUzRq2pDSan-2CV7=8xmZKCa0tv7nzY2Mb-aA@mail.gmail.com>
Subject: Re: [PATCHv3 1/5] t7406: simplify by using diff --name-only instead
 of diff --raw
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 10:29 AM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > We can get rid of some quoted tabs and make a few tests slightly easier
> > to read and edit by just asking for the names of the files modified,
> > since that's all these tests were interested in anyway.
>
> Technically the quoted tab was making sure that we do not mistake
> "subsubmodule" (if existed) as "submodule" we seek, so a faithful
> replacement would be to find "^submodule", and "^submodule$" would
> be an improvement.  But we do not have paths with confusing names in
> these tests, so we can leave it as-is, I guess.

I knew someone would find additional issues.  I'll add the anchors if
any other issues come up in review for the series.

> I think 0/5 should fix the real bug you are deliberately keeping in
> this patch, from the point of view of organization.

You mean 5/5?  And yeah, it was just a temporary thing for
organizational purposes.
