Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF0020248
	for <e@80x24.org>; Tue, 12 Mar 2019 15:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfCLPhG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 11:37:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46022 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfCLPhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 11:37:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id h99so2203500wrh.12
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 08:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9ByxbsXPUKpn+vCgvcnf0t6zluuhDm+qk/JgBrGFT8=;
        b=jxI44qlV+tHCc94Dft7tI/DqlT5gez3XRTl6dM8XGsfPJnpNpgHoclC5KkrUhYeTg0
         A6VHta0jfNyXwhBn6Jh7MmQgXHKfYNx+7vWLVAQVejOoSI30t8GFYdM8P3hnKkxCv0BS
         s2kvHXVx3Q65bxFF31WJ36/es9SGnMsRi3HMjJwwRF0kWIAFlwlsNLEuRA2sKzF5xLzr
         EolcAI594jpiCmyFAfVqntOPbdE8elklwbK7vomBRp4tP7TEH2hsSkXa8EzZHGRQKSwy
         sakdrg0IfRqD/0LdLmjp5jh0ENfayHHB+T6L/g/rEHYAk0w/n5qncFn0PONMnd1YCaOn
         3y9A==
X-Gm-Message-State: APjAAAU1pWaUlEHwRdNCKhn9Qzdof7RT3i19sOCa4x9wufZTUgCqkTAP
        leOvzNJBMN5FWXrA4fEkvMvLjkYiShBSFHuk6hAePw==
X-Google-Smtp-Source: APXvYqwG61M6NkfFxLGb+gcog00yLDQsc5Xm8KFkJ5NyiDyBBo9yOco4ucIGWnY1NoZ9cLGEOPo220x7xdQZ4lJiD2w=
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr23923128wrg.217.1552405021189;
 Tue, 12 Mar 2019 08:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com> <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
In-Reply-To: <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Mar 2019 11:36:50 -0400
Message-ID: <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 8:19 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Mar 12, 2019 at 3:51 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > I tend to agree with this but that's probably because I don't really use
> > checkout -B. I'm not sure if it's widely used or not. I do find checkout
> > -b convenient though.
>
> Yeah I think both -b and -B are about convenience.
>
> But I would not mind dropping -C for now, if people think it's not
> that useful. We can bring it back in incremental updates if we realize
> we miss it so much. I'll keep it unless somebody says something.

It's not much of a datapoint, but I do use "git checkout -B" (and
therefore would use "git switch -C") periodically (in addition to
-b/-c, which I use all the time). And, convenience is important,
especially considering that "git switch" is already more painful in
some ways than "git checkout", due to having to trigger and spell out
certain things explicitly (such as detaching).

> PS. The same probably goes for --orphan too. Wait and see if people
> complain, then we know how they actually use it.

Again, not much of a datapoint, but I do use --orphan periodically.
The idea of "fixing" the behavior so that --orphan starts with a clean
slate is certainly appealing (since it matches how I've used orphan
branches in each case).
