Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BFAC432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CF2207DD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDd/Ro60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfKXRk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:40:29 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39995 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKXRk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 12:40:29 -0500
Received: by mail-il1-f193.google.com with SMTP id v17so8131410ilg.7
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKWIE5coy5yo1n32qy4ibNzUNXLBtXywyEK4E+74tnA=;
        b=hDd/Ro60uWVUgeaICFcB1RW5OgrnlpfDys84Nl5RZ/v9qZEOHd1gWYy1g6rx8Emb53
         XNmXvTqq1rEa2lrN1VQBo6GiUy9pCXy5IjrOVKt+RjHzBtTsiqCbBAkV9Nermy37/hwG
         PCcxX5TKjRasoYZHVJDIVkQ7Gi1wl5+68IW3EQ69VsMiX35fRbY5c/9U0+MgWEE5Eafr
         sQuZY9jsCmrrX2DRUCENUKESmCSGT3TXGoXcz0nIpeuy/tglVjDDAB9ZpMxnBDCrMjiJ
         gbnQTk8CeVyNKibzJV0phhDtBelbDeJRHHAddPwRClMKVS5jyN59kgTfWJKJaZ2n+FDk
         BZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKWIE5coy5yo1n32qy4ibNzUNXLBtXywyEK4E+74tnA=;
        b=OkmHdcc1hhYiQOrU0hl9lZ0r1nMGjyz760loiiUdZwbIRaS13tmcxG0JWhSC72s1wW
         ky9E9kJeggiFS5frRCx47UL2kzsh0Clr+3imyLeGVpqa5ka6s9PBSHjuB8zmOb3oHT8t
         IjTU9C7lpFwg1USHzMXsodwKUhQgK2u/6Uc4tkMdiMn6pyDTQNq8h/HOCOrsraOlhJ2m
         BsQUooC+VpzZdBFEmKx5p0sExdDfp6fhPd2MVHXU2RceiUsnHuYTPyDDnhhf+XFiTvVS
         lTmmmzNodfQreNP3CDGHktmw4aWL1hjHGSFXMljbtZI1oI3Z0PgmZI7R02Lk1AdH03Yu
         oFtw==
X-Gm-Message-State: APjAAAWs1Y+/UxN1/tZgMmD8TxB6egGQsvlGS3uMxgu83hFKjsMTlsmb
        PmmNK9iABoeKIeYGxeJnwndXnhDRooh3LXEu5L0=
X-Google-Smtp-Source: APXvYqzJxQ6JPPtde2uhKSFfhVTgHz4uHS6rXUPO+7fiXC7XoxwTkFrabNhHqZCYi3t1VG8D6N7t3RK9FAScW8Q0uew=
X-Received: by 2002:a92:aa48:: with SMTP id j69mr29605378ili.162.1574617227953;
 Sun, 24 Nov 2019 09:40:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.473.git.1574600963.gitgitgadget@gmail.com>
 <177deddcf83c2550c0db536a7a6942ba69a92fa5.1574600963.git.gitgitgadget@gmail.com>
 <20191124170643.GA16907@sigill.intra.peff.net>
In-Reply-To: <20191124170643.GA16907@sigill.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 24 Nov 2019 09:40:15 -0800
Message-ID: <CAPUEspjAjR+QojRbC8dkoj=9adAKEv4StYYiy6hFmbMwQZ7CNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-compat-util.h: drop the `PRIuMAX` definition
To:     Jeff King <peff@peff.net>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 24, 2019 at 9:11 AM Jeff King <peff@peff.net> wrote:
>
> We do sometimes get portability reports more than a year after the
> problem was introduced. But I think this one is pretty safe. PRIuMAX is
> in C99, and we've been picking up other C99-isms without complaint.

I think the problem might come from places where the default compiler
is still not C99 by default (ex: old CentOS) and any other places
using gcc < 5 which is less ancient

Carlo
