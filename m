Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A66C34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 04:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AAB24654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 04:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCTK37y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSEee (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:34:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46810 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgBSEee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 23:34:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id z26so16223043lfg.13
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 20:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxkyBx03p8DLrnXmiamn3qXjxTGH3kVzCzW0V30Lcvc=;
        b=MCTK37y233p+kyNQ1j65VP8t75Ff38VA6o96ENtwJjpVFtrrPIUeGxGcdg4AUBqYGY
         PCPF/vRhJlDD1vydmila6eYs0j3zrR6eGq63WrH6vcQhL+iz//c/9jO7w1u99l4sULV1
         I4JnNV7M6ij5p4yemLfzh4yHQ/M53SqRiag+ku9CQ9s/19hvXFbZ1mFiE1hByUwEXokz
         HAqofjbjEcnoI6nsI7oB0T/zjkprDctrZxh8QLwL4eujjAfHWawl1mZn5DM4qdfjXhY1
         yedHMpkxyAlzrXMqfRnxVyjZKrYheHvzbYsQV29re60kprLoOn4WBgLH/8BYkASWrkvs
         4JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxkyBx03p8DLrnXmiamn3qXjxTGH3kVzCzW0V30Lcvc=;
        b=hNbDwuq1fjnPCnljvAu65b/1LAVanj3rB93zd3M/+gi0lAy8WZ2NgBqRGlNXsOSLBQ
         yZFml1ZW7h+0Mldrz3S3dG2zBbyF8QAAaWICEZbvfM9gYqzOlPYXd1n5tpc82rf1ZfkM
         kwk8M4zKVX5goA9EiW2V/tqGhxAsZejH21nhkVr2idcSSNx4t1TrSr0cA+0HzGHs4qsy
         7qtpgSbPFXpVlET+TAUcYuKJ3AxMJt0JKuOYnz/OtN4uqAvxJ0UkbQy41HTsda5p61Ug
         5CPltdnDip1JCVJ6casbOR6OBSwGBK1FK0rDiscrlI5NGtsxIU/0UeeV4OuxhhNAj6Wg
         ve6w==
X-Gm-Message-State: APjAAAV2jI66hCuPWMCSh3WVWGW3Xmd3sxnuE8nLv1tSkns742rep4T6
        JfuTyhLeiLyXDsC/TEuxgoPRTmZX3ML6DGGtZuY=
X-Google-Smtp-Source: APXvYqx0eHLmhWTlDPZfgimuK/36LUCc95NAwBn6NHGOEyq8eqFWzeQvIOIezwjDW4XtwhDaRr2dSNhXf4zQcSh8T+w=
X-Received: by 2002:ac2:5e9b:: with SMTP id b27mr12556175lfq.184.1582086870901;
 Tue, 18 Feb 2020 20:34:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHk66fskrfcJ0YFDhfimVBTJZB4um7r=GdQuM8heJdZtF8D7UQ@mail.gmail.com>
 <xmqq36b7k4i6.fsf@gitster-ct.c.googlers.com> <CALH1-Xr3HVZzDn2-9EvmdiBWmxWQ-zfExM2LNJyR1wR+dgxRSQ@mail.gmail.com>
 <xmqqv9o3gthb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9o3gthb.fsf@gitster-ct.c.googlers.com>
From:   Robear Selwans <rwagih.rw@gmail.com>
Date:   Wed, 19 Feb 2020 06:34:19 +0200
Message-ID: <CALH1-XoXdpAxYj7r1ouc-v4KrVuYDocBFFC++7eFiRwdHFxmUA@mail.gmail.com>
Subject: Re: [GSoC][RFC][PATCH 2/2] STRBUF_INIT_CONST: Adapting strbuf_* functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Pratik Karki <predatoramigo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 5:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Yes, but the case that matters to _your_ use is sb->alloc == 0.  You
> do not want to let a broken strbuf (presumably broken by changes
> other than your own) to pass, when you can detect it.  And for that,
> paying attention to sb->len _might_ make sense, but then the check
> won't be
>
>         if (sb->alloc < sb->len)
>                 make it mutable;
>
> you'd rather be writing something like
>
>         if (!sb->alloc)
>                 make it mutable;
>         else if (sb->alloc < sb->len)
>                 BUG("somebody fed a corrupt strbuf to me");

Ooh so what you meant, is that corrupt `strbuf`s need to be
anticipated even if they
don't make much sense. Smart.
