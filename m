Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021EA1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeKUGJ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:09:59 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35941 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeKUGJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:09:59 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so5407234itj.1
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2Zk85Et6fy6rIII9Fnfc8pM1xg2pJBJ202jk9vX+F8=;
        b=jNVwbGbCdFZPCCBz8R6hF/bL0Iiofz8H2lQjmftSLFn6364XtC5HbA3378riIfPUuy
         K3liGcJxt3sXDRJtCJCE1PXwLijhHjpp7TGWeitSBRAuXYvFrJazCa9LYzKsjW575TiF
         zakV4Bg2Xvy7f4mDFkQsVAy4S49wM9ciA2gfrsUhlI/x4In8TEXYZb+dWCcihwoQxot3
         EXbbDBMtN7gQmfFdxkiuwMnuz1RChhxS53Ell0iHO+JQYQbFCvx0q87jYsEkY62cX1Xs
         hbmPr3t8qjwOepTzd1HSECIzSBUWfnyYQI4Gimq+26uQBGp/GrRqM3iXJAtXtk+Ac1Bm
         WVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2Zk85Et6fy6rIII9Fnfc8pM1xg2pJBJ202jk9vX+F8=;
        b=eszAu8Ztbzqe8gA2GIMZuGMzN947zGDUgQ7Jo57gHbBR+HOjhw12oOGZYngA+GbLJ6
         I87L8lrh2HlPU8lIOXJ2FdWXRlgR/YehatVyPhmAoQZQ3DQpETVNZ493gopb23c/8R2/
         D0raJzg9pYXO0fxAiMS6RhURYC0w9kuTx62TpHoLKVqly0bKHzKM+FcJJjrShj+Ayhh7
         8GLNTrr52zRNszBIisg+z79aV16vHrhOpK0RmssHKCY3w+cEwZtHf09KYski66m72H4b
         yzbHV1jd5KgQvnftCaUjVqcUAPnw4kzkNHIW0uiz0mn3kOBliuuySROQ9wcrF2btEZC3
         HaRQ==
X-Gm-Message-State: AA+aEWZMwTw+RJD1p5Ql5oTcBnDR187YpLyi9UkFkjD3cX5mME99XRW1
        Wycvn/sHWKXwnvlFJNj0f8vyVidtzFLO+TdHFGdHHQ==
X-Google-Smtp-Source: AFSGD/Ujdl2VueRKWA9a0FhHxOgzNQK6wTHoltwoZT0LzDLbGavPKA96Z1bqlV0bWLPLdHUDQA9BYCskLjJDp5v0i44=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr3259864ith.123.1542742752237;
 Tue, 20 Nov 2018 11:39:12 -0800 (PST)
MIME-Version: 1.0
References: <xmqq36rwcwtu.fsf@gitster-ct.c.googlers.com> <20181120162853.22441-1-pclouds@gmail.com>
 <CAPUEsphujJmC8R8acXFDgexeA61JYS8Fcv7Tog+Jt+bZhHrCDQ@mail.gmail.com>
In-Reply-To: <CAPUEsphujJmC8R8acXFDgexeA61JYS8Fcv7Tog+Jt+bZhHrCDQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 20 Nov 2018 20:38:45 +0100
Message-ID: <CACsJy8CzH1Xxd_Nus9EJEvcjrxKMvAyQZJGVb+ShMk7GFhdiXg@mail.gmail.com>
Subject: Re: [PATCH] clone: fix colliding file detection on APFS
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 8:35 PM Carlo Arenas <carenas@gmail.com> wrote:
> IMHO it would be ideal if test would be enabled/validated for windows
> (native, not only cygwin) as it might even work without the override
> and if we are to see conflicts, that is probably where most users with
> file insensitive filesystems might be found

Yes but I can't test on Windows so I will not enable the test until I
got a report that it's working there.
-- 
Duy
