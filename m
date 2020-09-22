Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69BBC4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 15:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF505214F1
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 15:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9OGkcSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIVP3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVP3p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 11:29:45 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC7AC0613CF
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 08:29:45 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id y25so4243439oog.4
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBE7WDbcWJTNTTx0Wg/6tGn9p7Bz4uLWaMEIW5nG/s0=;
        b=u9OGkcSt3CL++1yOfoMsDms6p+u86inJu1cH9Mv034Zu/nxPwEHUpVGJLydWzqXAR1
         EnhBM9gpCBPtGSbnsrSaVJwL8bNSjMAFrjt5uFUJ5hO5g4bnSsQhhEmhEnlNGW+1P3pT
         EKr3mkC8msxHIP/MW8zxWuI1+6eHAX02o6rb4DLSS5ol7LO6TYs1OYf+R2Uw2KMrgo/0
         xu7Je4biI9bleM3GD8b1mH0UMdO1WCeInbfrgmQz/e8Qzb63vqTDjns3eSxH3XzRUznb
         OUgaapfjC6/pcja+7BGwq8NjGfc0SjQYTz4ncqJVo3EhBuvCFxdJnuatYJ0pn2KoZbT6
         gxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBE7WDbcWJTNTTx0Wg/6tGn9p7Bz4uLWaMEIW5nG/s0=;
        b=H98gzfuFLymdS5swlFk3dTQnYoIohe5YAF9PBhu6VUUTAEE51HdzR/zLPlc0FW5INi
         HucIaiWD2TMK5/uwIe+s230ElQKhKEQ2dl1kkmnbKiZUxkHgdHLbhFeRDJZNdNpFsVcb
         iRaDlEolExsmev462/+OeUU7mkh8xYhZOci/5CV6RQ8bKz1BjJcE3w1GL3qjUf/spVP0
         FQQOfSfhQ47R8mVGxMY8f51vv/vHpvy8RJKSdRBHSupeUjZFw1dOrdxi8I/UX60hwdkj
         KV8Xmbwlm+5Se2rxVyucj/6DU8qsKzBj1qTNSBGRb89NL1ZxupDdipyKjH6fkolfYdRx
         c8AA==
X-Gm-Message-State: AOAM533Td/LjDTqzXT/pK54A8etvFpBygPRuAHWOmmfEiuVsN4TM/CJl
        gdMuaV3yy7rykX51MgKQbBnnC+f3EVJjQKSOyzs=
X-Google-Smtp-Source: ABdhPJyZ51cwPD4Q2GRn5By0dCRfUkjKtjfquAcj112O7Fk+69cxXOXADoJWNAuwk20Gd414qSWLVEkJoNRurmPu2yc=
X-Received: by 2002:a4a:d109:: with SMTP id k9mr3381471oor.32.1600788584467;
 Tue, 22 Sep 2020 08:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD32jLuyq4izahdMwaYmKp2mTmHHTxQD68PqjA46Pc32xw@mail.gmail.com>
In-Reply-To: <CAP8UFD32jLuyq4izahdMwaYmKp2mTmHHTxQD68PqjA46Pc32xw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Sep 2020 08:29:33 -0700
Message-ID: <CABPp-BFG-rqozqTr3W6XsnAzfOFSYBFETkT3DNpiqSaust8SNw@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 67
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ethan Rahn <erahn@arista.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git-inclusion-summit@googlegroups.com,
        Carmen Andoh <candoh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 22, 2020 at 5:26 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi everyone!
>
> A draft of a new Git Rev News edition is available here:
>
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-67.md
>
...
> I would like to talk about Git Contributors' Inclusion Summit that
> happened earlier this month, but I am not sure if the notes have
> already been shared with everyone on the mailing list. Any information
> about this would be very appreciated.

+1, that'd be awesome.  It was held at a time that didn't match my
schedule, and I've been periodically checking
https://code.googlesource.com/git/summit/2020/+/main/index.md and
waiting for the promised recap ("Bookmark this page to check back for
a recap on the initial September event") to materialize.

Thanks,
Elijah
