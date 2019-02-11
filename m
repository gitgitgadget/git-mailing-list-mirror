Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC33211B5
	for <e@80x24.org>; Mon, 11 Feb 2019 17:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfBKRO0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 12:14:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40032 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbfBKRO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 12:14:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id q21so18098675wmc.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 09:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=E3FusTXm/rWbWP0JlYtdIPyzP+/cmDkow/XgepxKKVU=;
        b=WCod+m9G9bYpzj86aP7fERNgFWY7SSyaGCmIXwahfE83f63LFci6mXzzdFKDxivB3z
         scmI88GdnRgGWKTghWSxGwuR2IU++G0BBsjs6a82LYJVm95QuCK5meD5csIeFFssOzcD
         wkaiouXqd8WvKZxFG3UlA082HU8S8lleYodezpLU9dyORt70OYmqwkLYHUUp3CuYWes0
         QAvCqOg5pvmTtwq5YPh2oC+ycEIR9T8tCMeExgWa/kiRVzCv7u97z6pbOZMH31GIZ1Wc
         LgagzIUCmWcXgDtCQCSgggKt/YQ396qvZW7moRUboKv0C8F8mIkvue7OB5azjf0CyGnF
         xtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=E3FusTXm/rWbWP0JlYtdIPyzP+/cmDkow/XgepxKKVU=;
        b=ok+3A2Vw4s5yKqDT1Kvt4b1XLK7UBGhETDY85E2L0tS+UKeWm9jiHFvaHEQOIm/ay7
         j63zMENCPYMQez0hvog+M1R6ExkF7TcaMPoWIQf2hSY3dIX86yT94E9vEgS1cUTE004T
         PlWWuxp6vk0ZVvmkA4hcMAYK/YHpMGjJuQlDk/FVAYHsuewGyqTNRB5lIGB1WGKgbt1H
         V8UZie0d3B9gHFGWqNSYjog7TDDSqnQgOEZh6hEzsayjeSj2wgi66EMKdJabYSiFkTgV
         XRnB6/tt0bpUgmwBOQMXXUNH9N1c6crdxaIYj8gwi1blKQHoza0b7PkZ7cOtIIzU6jA4
         AdIg==
X-Gm-Message-State: AHQUAuayp/ldpOFtk4+HaZBA9bZYIo1N3arK2KYGEm/PkPMrqomSVzS4
        8kC6mYAvJu8878yAi2g2pJ0=
X-Google-Smtp-Source: AHgI3IZCvAoutXNrupRp1tHFn3EkiFWBf0iDX7NQ2DK/hTyh8b+vJyeWyOJNk8OrP23t9YLze40hOw==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr411682wma.32.1549905263613;
        Mon, 11 Feb 2019 09:14:23 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n2sm3949722wrq.58.2019.02.11.09.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 09:14:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, larsxschneider@gmail.com,
        Rich Felker <dalias@libc.org>, Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] utf8: handle systems that don't write BOM for UTF-16
References: <20190209145732.GA14229@alpha>
        <20190209200802.277139-1-sandals@crustytoothpaste.net>
        <20190210080413.u56vr3fgoejjzjfm@tb-raspi4>
        <20190210185523.GB28510@genre.crustytoothpaste.net>
Date:   Mon, 11 Feb 2019 09:14:22 -0800
In-Reply-To: <20190210185523.GB28510@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 10 Feb 2019 18:55:24 +0000")
Message-ID: <xmqqk1i6i6xd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sun, Feb 10, 2019 at 08:04:13AM +0000, Torsten Bögershausen wrote:
>
>> I think we agree that Git will write UTF-16 always as big endian with BOM,
>> following the tradition of iconv/libiconv.
>> If yes, we can reduce the lines of code/#idefs somewhat, have the knob always on,
>> and reduce the maintenance burden a little bit, giving a simpler patch.
>
> No, I don't think it will. libiconv will always write big-endian, but
> glibc has a separate iconv implementation which writes the native
> endianness. (I believe FreeBSD's does the same thing as glibc's.) I
> think it's useful for us to know that we can handle UTF-16 using the
> system behavior where possible, since that's what the system is going to
> produce.
>
>> What do you think ?
>
> While I like the simplicity of the approach, as I mentioned above, and I
> did consider this originally, I'd rather test the behavior of the system
> we're operating on, provided it's suitable for our needs.

I see both sides of the argument, and each has its merit.

Let's go with the "follow the platform" and make sure the decision
is documented somewhere in the resulting code.

Thanks, all.
