Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A2C4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 00:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE4561057
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 00:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhHHAbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 20:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhHHAbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 20:31:09 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5892C061760
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 17:30:51 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id t29so7793214vsr.5
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 17:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4mMTJw5nuyyWKgB+Sy4HossKv2Kj2jLpaXdH7qYMqM=;
        b=pcoVYfEVd8O7+H1sFF184xo1n/RkelE5/agmTljxSrpdrFM0DUHNqkKkY3/8Ci10W+
         Ep0xHzZcbL2EjaqMsua7NtREDNt8aimPi9lXaJ0cm5rpZFQFU26qDEzvtN40BuC1GwJt
         EP5BQUOJyrKpBGO0DoSztOqy4Aa6NGgpVYhbUKpB40R6qoxYeav3bNpCMGbFuVKHhqxe
         DzSUHVQKXR+2LPTnZaTDj1aW3yGo9f1JOArA5Q3vTIEPkeN6y68NCH3ZDqK+fZpcuZW3
         geyNNLfAcz9QgOYHNELTtszkRM3HDN7vqD3YvlE+HO/34EhvH0ohIfI5Hj3T0nJGRdfs
         bBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4mMTJw5nuyyWKgB+Sy4HossKv2Kj2jLpaXdH7qYMqM=;
        b=SC+icHMoh/ezno6uA0Sep+BqJ/ARi5vn6DKiiY5EHZ1VKr8+qYk2UlxlvJrM8EOv7s
         fXFkf6+1zWDRWTpj7zk3y8Jw8F3PoyhPD7fZEV89p3hkRLjVNTs2kjm0Y8kWkmb8G8Pg
         TIVnNpz1hdO9IRjzrcEBgnaR+wIRliSlGI0RYh1gFW6qTblVFlaZwO9xF14y51gF/tCL
         8yhc3Ld4cu59hn3XXDCVly4TFKUVhWh5QXkxbW8Pnkxa5sNWLgZCFakFo/PKdZ2XzigA
         ikDMyoCqplTswhDtJ2V8FpUeXLAt2SxQLuOUP0dbLpcmpt7jRYdMXqMQ0MFQ86OVV4/L
         QFxg==
X-Gm-Message-State: AOAM533Ypi4Kao/ETPmrWS/bXVT2DfB24bd7gYpcPX4bSu9Le+loJq17
        /6ZccmYW5PPSNgWRr6wOd4fKdA3y0AG9KsID3PysmI88Hfo=
X-Google-Smtp-Source: ABdhPJyTfeyFtt5gNcE6KaQUtnmgskpNI3O2WbWb6C5/9Ghm1La61w/Mo5uxQdXdmhQurjcI2QlDLqMSGt5UDpA/n2I=
X-Received: by 2002:a67:2684:: with SMTP id m126mr13253501vsm.42.1628382650658;
 Sat, 07 Aug 2021 17:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net> <20210806205235.988761-1-gitster@pobox.com>
 <87bl6aypke.fsf@evledraar.gmail.com> <YQ3suvJfspzRNPL9@coredump.intra.peff.net>
 <875ywiyn4y.fsf@evledraar.gmail.com> <YQ6VJW0AwkouDnDe@coredump.intra.peff.net>
 <8735rlz5r2.fsf@evledraar.gmail.com> <YQ6bTm6DxeJLhmeA@coredump.intra.peff.net>
In-Reply-To: <YQ6bTm6DxeJLhmeA@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 7 Aug 2021 17:30:39 -0700
Message-ID: <CAPUEsph1ZqE9KtT7ooJEa=jURq+=cG78MXwPxahb7f0YXYHL7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] detect-compiler: clang updates
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 7, 2021 at 7:40 AM Jeff King <peff@peff.net> wrote:
> The distinction does not matter for our script (where we only care about
> "clang4" and up). I guess the most relevant test would be to get XCode
> 8.x and see what it says. I expect it to claim "clang 8.1.0" or similar,
> but actually be clang-3. And therefore not support
> -Wtautological-constant-out-of-range-compare.

uses Xcode 7.3 (based on clang 3.8) and either does support that flag
or ignores it silently

  https://www.travis-ci.com/github/carenas/git/builds/234772346

the same was observed with Xcode 8

both error later and fail to build because of a valid (but harmless)
-Wformat-extra-args warning that doesn't trigger in later versions

Carlo
