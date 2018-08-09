Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E331F405
	for <e@80x24.org>; Thu,  9 Aug 2018 00:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeHIDDW (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 23:03:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53835 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIDDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 23:03:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so4548697wmh.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 17:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ORJaBG7EQzWq5eftkvd5YuyOCTwtgHbSgnaG2aKQRMo=;
        b=hSgn7/qD0jRXcgDssPGt2Qt9js4/gTZQEa1FVWKgnnNg7Ash9fKRkZis0Lvgkkfu4e
         Yt3Xc3rWUJw4CSAZC9sw58WYu8YEqxWzCIXMMUXCyt+4gt2pJ27WRMycoMKCrgQ0y5qt
         Agn2amAqwXO9Z1mquoidCU7xDiZmKlPY54PRZ2wlVmXZwhfuOtATLv5KOxmc0lAIFaIB
         pN5mOEYzvC0OR4HXUhw/+2KMh/URf0bXXs/XPr5wtQxxqI9Mym/E1nTI1pgjqZS5Ui4C
         e8fl4azwZJTmfmMdCrxY1z4yJa3tWAW6eikpKYUODmZudsSyPWIxC4WhOTf5YNZ/2OES
         WxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ORJaBG7EQzWq5eftkvd5YuyOCTwtgHbSgnaG2aKQRMo=;
        b=JlGXCnvX/K2LKEJ5aLTvlpeUS8Yv7mhpXxfpjx7KbAUr+UYsVqpQ07ofxt4OQGfZJE
         AI7gZv9MoG5kmYVcWOoBCkH0pRDRsnaUGOMxNzQ/oe6bxcTBt/kp2o1D02XSVCVC0HRp
         AvsIS9vQlL4Xf7V8NF/tbOi3jvxUoCw7PaWlnJAyXKVnXaLmAxs6xlQp1h00iN3VjITH
         Mvap2HmpqQpYkUfaKtB5sReCMVuI2hJ3op1DeEtCc0DOuF6Xy/Z7VQCg1dAG7f62rycp
         aaHfbPQBvJOlOpvRJxCJM0CB58n50lS7PShNmWguPsYaLIsdDdnmeHLWHjajM//lY6TO
         5fnA==
X-Gm-Message-State: AOUpUlGZ592udPqY4M3JtiEZifi7zM3m7ynOAT8ablcGrzXm5uSq0vde
        pKY/p8kJbJ4eBX7VvUKGmoY=
X-Google-Smtp-Source: AA+uWPx9VPPp1Bpe2QXjNrsrFdGMIarav2U3yzFaBR8ekSqIt0O7EHbV/QpectXxAYUJcjVJz5mkyw==
X-Received: by 2002:a1c:c7c1:: with SMTP id x184-v6mr137588wmf.134.1533775273695;
        Wed, 08 Aug 2018 17:41:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y128-v6sm9447550wmy.26.2018.08.08.17.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 17:41:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, git@vger.kernel.org, pawelparuzel95@gmail.com,
        sandals@crustytoothpaste.net, Elijah Newren <newren@gmail.com>,
        tboegi@web.de
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive filesystems
References: <20180730152756.15012-1-pclouds@gmail.com>
        <20180807190110.16216-1-pclouds@gmail.com>
        <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
        <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
        <20180808223139.GA3902@sigill.intra.peff.net>
Date:   Wed, 08 Aug 2018 17:41:10 -0700
In-Reply-To: <20180808223139.GA3902@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 8 Aug 2018 18:31:39 -0400")
Message-ID: <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we really want to avoid doing that normalization ourselves if we
> can. There are just too many filesystem-specific rules.

Exactly; not having to learn these rules is the major (if not whole)
point of the "let checkout notice the collision and then deal with
it" approach.  Let's not forget that.

> If we have an equivalence-class hashmap and feed it inodes (or again,
> some system equivalent) as the keys, we should get buckets of
> collisions.

I guess one way to get "some system equivalent" that can be used as
the last resort, when there absolutely is no inum equivalent, is to
rehash the working tree file that shouldn't be there when we detect
a collision.

If we found that there is something when we tried to write out
"Foo.txt", if we open "Foo.txt" on the working tree and hash-object
it, we should find the matching blob somewhere in the index _before_
"Foo.txt".  On a case-insensitive filesytem, it may well be
"foo.txt", but we do not even have to know "foo.txt" and "Foo.txt"
only differ in case.

Of course, that's really the last resort, as it would be costly, but
this is something that only need to happen on the "unusual" case in
the error codepath, so...
