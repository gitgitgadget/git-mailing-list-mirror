Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A6C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602A7610C9
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhJVV3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 17:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJVV3V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 17:29:21 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77291C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 14:27:03 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id f3so10243109uap.6
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 14:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95GdQ4J6D9EkCQ2zJmOKm6CRJqvvewccBEuNoeuMcaw=;
        b=TqA9Qw3yZaD3cNJeSQ308m4/MFDLTrVoI4QN3yBryZdKoEWv5EPKscoRPqVuUWzjql
         DnbsxEk8ojImavZkFtl8LnYmth2AnjqcPnVYifBeSB6irRTrz8bIfyVJVBOb8U9VyP6c
         jenwe6UyldQnYDzcGLOmLjydiLEivXnsZ/rYjkxeE8mDjf/LpUFxQgpofkMeVygEPgUo
         /zPF1nm8daoFqO6edgaUkdHA0FdTsZL5odryQg5AunjeIuza6jYWHItchBZEBgJfEO3J
         gm2StwIHk4nDUCDIEcnq7sHONSU0w4vDKR/gFf2Lt78NNtD+MGlcxdbx9cIDUjbfrR/3
         pSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95GdQ4J6D9EkCQ2zJmOKm6CRJqvvewccBEuNoeuMcaw=;
        b=CqBJU4o0Pev5dZfjOJE4Gx7Jrs+i8Pqt/jDwuacD/p3X5IwQEPr6qxQo81GqHpmFlJ
         JG3ARc9FbhMx/0AHc1bI+haJF3/fm+Zxnfcn8sasovpJNqVciP+igPfAfxKnpne36HzF
         unLzB9JeP5+6E04akBZSfrodhCR1VZ54LhPnMr7naEWz3h3S+vhH6zFoRSCr+suLp0/T
         M+z72VCHUr7a6AIyqZWQPlVXgEQjyHr5zJTsi73S2ddXtJVN6FMaE2zYd5mhqsu5ViAn
         nuDmQvKCYxts/vmDkV1pGBZIo7KU2estpcj7aOU9bY3mCVvSlQbu2bRDW8BY/WoXd+sI
         LO3Q==
X-Gm-Message-State: AOAM532GYDmWoAL2uhrTBPaKJoUNZMyTdJWlR358V4fHZOpCPkTSJAiW
        gnxWeFK77wue9Ns/DMywxOicPcnXZnr+VDqQNrg=
X-Google-Smtp-Source: ABdhPJxvdpWzn8nVYPEa7+lCaruZCt4E4h9zs6FRE/iV1vWawaiYhouX7okKRj9lyLbKq/zAWS7yHV5yFt66bPBxgNA=
X-Received: by 2002:a67:f5c3:: with SMTP id t3mr3038536vso.14.1634938022574;
 Fri, 22 Oct 2021 14:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAN2Gq0de1tpiLNcQqoZmgAu=kuOXxEmAtziWM7OJtGPGhLneYQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2110221723430.62@tvgsbejvaqbjf.bet> <YXMTuMGWQD4Swwt4@coredump.intra.peff.net>
In-Reply-To: <YXMTuMGWQD4Swwt4@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 22 Oct 2021 14:26:51 -0700
Message-ID: <CAPUEspiLA2=SWNmyEnfb9rUomO=OUMLUu1vLKoszLqRNcm6yfA@mail.gmail.com>
Subject: Re: Error in 'git clone' via SSH in v2.33.0 (related to commit ae1a7ee)
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philipp Eib <philipp.w.eib@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 12:41 PM Jeff King <peff@peff.net> wrote:
> My understanding is that GfW just ships with openssh, but I wonder if it
> could somehow behave differently here because of some platform-specific
> issue. Another question is whether there might be any other programs in
> use (an alternate version of ssh, or something wrapping ssh, etc).

It also allows using the native Windows openssh port which seems to be
the one used in this case per the comments in GitHub.

Carlo
