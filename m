Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C828B1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJLGBd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:01:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43679 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeJLGBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:01:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so9736837eds.10
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8ORR2xoHNf7/2sIXVTVEfdU3kOHTHc++FgGodSvmzw=;
        b=n0zdtkuVysEZmtyISmC21zutFxNc/tj1CNh85ECWpUZkF51tDcErNWWnsjnGOMjmRZ
         zq3tAjJ0nDIuLmqvqMvbayS6SVUBOa45s/hDqEQDCG17cl2CCqt923aqWMKZaVGufkx3
         yB+tVBAb8xwsYxHP1+x3MI6HO62K6OUSKSE9LeS8b6vTv5Ogscl65Cto8ZVJyusV1P88
         17jqyDt9F/y/RByIEv0BJpBgWprDJBVIILGwmh0F1UHCMEh/cNt/wDj2VsvmbloF5lkc
         dJvSl+Dch8NcbjkavpGu0ZHujXys84w69Q7lIpI4sBvpRUKe6b3h4Z86hMC1EqfQltpJ
         wfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8ORR2xoHNf7/2sIXVTVEfdU3kOHTHc++FgGodSvmzw=;
        b=RbvhvL8h3AzEPUJdP/N6VQ4AzyYPIcgYPva/tFHg0ek3g/G+lh4gyTXtPrVjt9Z4KD
         tlARn5Hz7sCPp1YzlKa0HQAibDLxVoPfxr2ls/NEvqbsKDPn0Cq9iz6Ze1Y38Hm53Fbr
         kPr3CVJ6cDnnzcdy0ohNE4j6j+Bs2jydp4sjEXDswvkbHvD9GoPKD8r+4kRNbEPB4KUC
         LiB5Ub0Mv6jB3VLaHBPgs052ERLChgvl/7GSJ5HoX4eluzkVD6paDo3Y75qeg86Sq42G
         T3spCB6LAQH5Z22YCXzEkohyC4S6/CgyxHfrpCnYXTk95G0JloEigUaqgQEIozbUz//9
         WZ8Q==
X-Gm-Message-State: ABuFfogyeOTZmnwizhLIHgBTAO/w26yfvP5yGAsgs/HHyDB41uhVoxIC
        gY/Prmf0mkD3jYPDCz6Dw2usPdadSzGu2LdYUUf8CO7uqh4=
X-Google-Smtp-Source: ACcGV63oslHsjpFOKwQU84amlrZey0mLOJmQ0EQfRGZ2Xl4UksJ6wDEnY5+dAMvacGHZC+9HK2hF9lrVrrUdiRb3ZzE=
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr4420076eji.67.1539297132113;
 Thu, 11 Oct 2018 15:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.25.v2.git.gitgitgadget@gmail.com> <pull.25.v3.git.gitgitgadget@gmail.com>
 <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
In-Reply-To: <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 Oct 2018 15:32:01 -0700
Message-ID: <CAGZ79kYttgMUeQk7fvXGk2+SF10PS8yqsgNH47HBQLfNqShpMQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] revision.c: refactor basic topo-order logic
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
[...]
> For the test above, I specifically selected a path that is changed
> frequently, including by merge commits. A less-frequently-changed
> path (such as 'README') has similar end-to-end time since we need
> to walk the same number of commits (before determining we do not
> have 100 hits). However, get get the benefit that the output is

"get get"
