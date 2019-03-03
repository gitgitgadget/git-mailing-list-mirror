Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C79B20248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfCCBV3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:21:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46621 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:21:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id i16so1687214wrs.13
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=s+Ro63alDif8PwPfTMU4efpGFMpv9r7CHOZFOegSHRI=;
        b=bITmpfFgMe9n4rZuojSlHHMdsmmDp3oOon35k5PKhJRQkzY+mP6VAcNTaCTjx7kV0v
         GDezimvGP29ZHiJZ7YmRDGKENEatxTDrd3E4IlEeD8vyA8b+bGLea9JmjnGml2rbLc/C
         kGYDZ78TCjZZM4KYbPijEt47VadTY1bcvQbLvTaUyn3zAjQRPkSyEHmYm7vzysBLeL7L
         ZJR9zODIMKB2tWmKxOHXwwFdt78j1V49Bwns3PFEuIByFypVhORVgmJAhkNVUiAW2YMm
         HCXgRSZsF7YbBnh/WA9YAjSSGQYbWuY1k4yN8Nu4jZcmRkVVOe1pGIe5WB2jFhWbnEGi
         lm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=s+Ro63alDif8PwPfTMU4efpGFMpv9r7CHOZFOegSHRI=;
        b=nD9m7KTkD8Wy2tuNFhmiCE0fLx49vQzSahzQuiKDCwrGfedUKMLVV/9JYOArVKBSoG
         MBoHhd/bBqfth7nCcPU9gec3EDap6g+kSjvpPbrVBysJJvNx9H7dlNBhf7w6SpVbzqWG
         NduulTZfVfh/mjQmktpxppEBgiEvaSE8KF3z009X2UQZpMwQUAVvOZxZ8jRqCGCDHfBi
         JPHHdh7QW8bkGMuASmHVtS2Spouew+1MVCAcE9saGYb9YvoWonsQsPeQ29eJZNaFC9wQ
         4POyNaNK12OTOQ+D7obWA/G1lSvZbnzUrVZTGsnQoAwok3kevCKnCCEXbtMLwJ2sa9bP
         5aNw==
X-Gm-Message-State: APjAAAVthyQ1QygK5vT9116L5/iTUggT/ZnFPhG4+x6HOiI64knlWKRL
        HtXviN9tkyxEHDkdJMkDRi8=
X-Google-Smtp-Source: APXvYqy1Jl5ygWOmmXcJESI+i+K0DD9ZFQbDtkZ+HLz8x1zAYWnkemkCPiOusinW98e7ouu6BIYTdw==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr8688205wru.59.1551576087789;
        Sat, 02 Mar 2019 17:21:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t202sm6125832wmt.0.2019.03.02.17.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:21:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
        <20180814223246.GA2379@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1902081024550.41@tvgsbejvaqbjf.bet>
        <20190208195459.GA32556@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903011557430.41@tvgsbejvaqbjf.bet>
        <20190301190042.GF30847@sigill.intra.peff.net>
Date:   Sun, 03 Mar 2019 10:21:26 +0900
Message-ID: <xmqq8sxw69d5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But for git-fetch, our primary purpose is receiving data and writing it
> to disk. We should be checking all of our write()s already, and SIGPIPE
> is just confusing.

Yup, sounds like a very sensible argument.

> So I'd actually be fine with just declaring that certain commands (like
> fetch) just ignore SIGPIPE entirely.

Me too (to me, "actually be fine with" would mean "that's a larger
hammer alternative, which is OK, while the base solution is fine,
too").

Thanks.


