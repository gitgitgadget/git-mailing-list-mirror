Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3553020248
	for <e@80x24.org>; Mon,  8 Apr 2019 06:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDHGo3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 02:44:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46868 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfDHGo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 02:44:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so14809133wrw.13
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zMPDuxf42PHGdatjJBJL3hxPGoG9g5LuEkeEoKOiSB0=;
        b=bJ/JH5I40tyEVAhWkkCkOMXbXYzb8C/ApQYZyjzBQqQ1wrmWLY8x1S6SXKs27P8PVy
         V8PXWHNPshHn410HC08BOq98J/yub6phM6HnyulCC7JYqEIvm5E+du1m1bQTuepqDUZ5
         pR4hX1oHRGKGrIMK3SyW8OOKBjoEXKfrvL6s27PSUhgGTECkk9ofIC/l3DHjP2zcTZO5
         MCjDoyi0/CCFwUK7c0LeeTtnMWzAlIhrpY6w6JlqHLEpS+vRSpkE9dZv51dahYHy+z8x
         xV7txPspde5UFHGEZhyRXjdZR8p1y+ezpk9LGUcKgzp7DQVQsQp24XqcLbz3lganwsms
         3WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zMPDuxf42PHGdatjJBJL3hxPGoG9g5LuEkeEoKOiSB0=;
        b=VuWLou4zYuACQH6mWrFlfm+seYoiWSHpl9gw8oFPPq6T24m38sKw19u5qHQMB4yk1J
         o1h7xbPxd4590ZXPk/zXpoWESHP4jH+VYtnUAe3OxvGbCnSXiN6cqqPNKNF7diWjVNU8
         Gb7096KDki3wrKKQb5YLSSklYcg8ACMsMKtTWF8jBYuoOhOVctxWE5sJVoC78VxHSC9U
         bdhqLuEc+9OIt/ngo05WIOjfdKlv5iyJMWaFXyj+Rrw8R4Y628ctV7d2Zwb3IdW7eGjZ
         CY6uIXTpuDmijsLpV3cjaTQUex/EW3GyEGrKeL8qnS4DMMJ66emeNo0Ew8nNp5WCeKgX
         Kg7A==
X-Gm-Message-State: APjAAAWYS6guQBL0/y6nwGAicLTC3WE8ww6xog93iDvcEURxPj4oHSGU
        8Ned9/ChfYh2ZuhdCkiiyCU=
X-Google-Smtp-Source: APXvYqxgkmDDtWJ40MptwFxEnJLLMQJ/sN9wpn+uqiJONxjEO4ZFl9Z3BaCvS3znIbKVA9TMvdKMmA==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr17520952wrl.26.1554705866682;
        Sun, 07 Apr 2019 23:44:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w11sm87191934wre.15.2019.04.07.23.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 23:44:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
References: <cover.1554435033.git.me@ttaylorr.com>
        <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
        <20190405105033.GT32732@szeder.dev>
        <20190405182412.GC2284@sigill.intra.peff.net>
        <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
Date:   Mon, 08 Apr 2019 15:44:25 +0900
In-Reply-To: <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 5 Apr 2019 15:25:43 -0400")
Message-ID: <xmqqbm1h9et2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Apr 5, 2019 at 2:24 PM Jeff King <peff@peff.net> wrote:
>> On Fri, Apr 05, 2019 at 12:50:33PM +0200, SZEDER Gábor wrote:
>> > > +   git cat-file commit $commit |
>> > > +           perl -lpe "/^author/ && print q(parent $blob)" \
>> > > +           >broken-commit &&
>>
>> > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
>> > dependency?
>>
>> Heh, this was actually the subject of much discussion before the patches
>> hit the list. If you can write such a one-liner that is both readable
>> and portable, please share it. I got disgusted with sed and suggested
>> this perl.
>
> Trivial and portable 'sed' equivalent:
>
> git cat-file commit $commit | sed "/^author/ { h; s/.*/parent $blob/; G; }"

Looks good.  I had a bit of head scratching moment when I saw that
"perl -lpe" one-liner; this sed expression may not be crystal clear
to those who are not used to, but it is not so bad, either.
