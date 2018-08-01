Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779A91F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389810AbeHARL5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:11:57 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33446 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389476AbeHARL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:11:56 -0400
Received: by mail-io0-f171.google.com with SMTP id z20-v6so16408394iol.0
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EY8hnJABIw01gJIpADi5CANgALHsGnT0vMV0OTBnjtU=;
        b=twlMgAWYQ+8aL8rNF5yTo1yBYPbbAHoWC184IlhipinoQUHlcQ1if0Gh/4GZRMGKR+
         BNafdob15uqO4TEKCLAyUwLbNMYUZhBCeRRouPTcxmw19wzp78IAm/5HDO5oBPK54yQc
         u3nCnlaVmaUnLsNWwPL8stY0aV6/iAop2ow7xd19aY55NJYOTz+icvcgPbuaGhHCabSn
         Jpvm4BNW5ODsEBPfrnzi/ZFS/idX1ixaxZexV5EPaoZ9zEhk3pgInbnBu34Kj/4L+T1V
         +c2gj33szlSRrsYJuQL6RL9gYtPrykso0fEBf2ZXIrIEfv43zfjMCiDdyaf4Q990KgzY
         0uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EY8hnJABIw01gJIpADi5CANgALHsGnT0vMV0OTBnjtU=;
        b=DAR7NPa2QW2NsFho3kw0T+bioZNirE+AVMkCLUMZ5VFdvll6rfl2+Kvyg/njkTMlmy
         C2hG5/UKik/PS7B9OgcYSSh++8MB7FbXEGdNRTOlHTYRuQlDcBqlgcbD+CEFf+ceUO5y
         anoBWO5YB0dcbkhCdeARxDZFVezjZxAggngAbo68rkMJRDL63bQCRSmk3LF0UfmH7/6i
         E1ppBHBxc1kwEopwOn1TWIlAGXPCNfrrbFQLXyBNzpP3HHai1hKq8/FH463eVGSUYHwJ
         OzcUj4gAQZmbqoqL9PX3Eo/IcMeTco9N8A1jCGJiLvdRY08zLGror5XVMdWwN38lLM2t
         42cQ==
X-Gm-Message-State: AOUpUlETe0Eb+vtQhvi6EEs9p+OO49M93AD50B6UekK3B6ZM35Y2SIqb
        3t/HRkxRyQt5OzDf3wcUudjvvc8JRX156LZ+6qs=
X-Google-Smtp-Source: AAOMgpecBGwTUWGYdlpNDV4hujZu9K+z5EOgzFYzCLLbgtOOlygONq33ZiCnv+G010X/ps0oQvHhwx1v607MOIahRIM=
X-Received: by 2002:a5e:d809:: with SMTP id l9-v6mr3502607iok.236.1533137142952;
 Wed, 01 Aug 2018 08:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180729092759.GA14484@sigill.intra.peff.net> <20180730152756.15012-1-pclouds@gmail.com>
 <20180731182344.GA3286@tor.lan>
In-Reply-To: <20180731182344.GA3286@tor.lan>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 Aug 2018 17:25:16 +0200
Message-ID: <CACsJy8CBEFkbgoiTrsmsVy8KzU+KUPD+XN3weTrnUJUMAQn9xg@mail.gmail.com>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 8:23 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
> I wonder if we can tell the users more about the "problems"
> and how to avoid them, or to live with them.
>
> This is more loud thinking:
>
> "The following paths only differ in case\n"
> "One a case-insensitive file system only one at a time can be present\n"
> "You may rename one like this:\n"
> "git checkout <file> && git mv <file> <file>.1\n"

Jeff gave a couple more options [1] to fix or workaround this. I think
the problem is there is no single recommended way to deal with it. If
there is, we can describe in this warning. But listing multiple
options in this warning may be too much (the wall of text could easily
take half a screen).

Or if people agree on _one_ suggestion, I will gladly put it in.

[1] https://public-inbox.org/git/CACsJy8A_uZM7nUmyERNHJMya0EyRQYTV7Dp2ikLzn=
xnbOQU6tw@mail.gmail.com/T/#m60fedd7dc928a4d52eb5919811f84556f391a7b3

> > +                             fprintf(stderr, "\t%s\n", dup.items[i].st=
ring);
>
> Another question:
> Do we need any quote_path() here ?
> (This may be overkill, since typically the repos with conflicting names
> only use ASCII.)

Would be good to show trailing spaces in path names, so yes.
--=20
Duy
