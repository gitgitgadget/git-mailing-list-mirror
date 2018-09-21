Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7AC1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390551AbeIUVsq (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:48:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45065 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390281AbeIUVsq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:48:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so13349661wrb.12
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wR1/9APSPX+wLqQWwHcj/oIU9f9xVl7+RP+3h5rqFKw=;
        b=K7Ye4EUGBWFyuGNRJYZVtDunDKbbi4fk2nzhY/dvsvGPxAe69f021m0ZIwLIZnCvhW
         LjKi1pbhbJgSJuTwF0BmRrz41JGZH0GgICLpQkCGYiicFQsQf9Ns2by2eI2ndvessuw1
         wi4leBYaDRu6Ra6uiG/rDkrNaQJktsNsolUUaJ+gIGw9MhEOBUGMQ+ME6CMMbCkwTxCW
         0B5NJJNqdHV51zob0g1bTpK79n8o07VjjQcYFEpy2kMrmVTqTqpyIbZtnP2NCLQ4ka+Z
         LktCotz8BC6tXLNRIJIMS7j+JTa/OwRYncEYmfvsqo2zo64NhUIBgbOobcCQVNx+52HG
         Lj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wR1/9APSPX+wLqQWwHcj/oIU9f9xVl7+RP+3h5rqFKw=;
        b=bZ4D9ZFU8l4SeSAlR00b1yY8h+29LT6LFEQ37dDiS2xv/JLezOtd0F92cKSW/hb/0v
         t2hrmkS04C0bVjTQoNBBrfpoiL9Ljkjl8zdjlNp3bYf2oog6a4WTMkItMs8C39aLP1sT
         L5zPwPR5Er2TzyZkfSIbxq+eoRPpmruhaWUBw3zOs+nMqCNeVqLLoc7BL7o+qMxLTYCR
         V8Lv+T97yN9bhxWxnooI2Kq8xKzpOOXetWtWrx+d5YXzVg0DkWEAnZRRJ7IkA33yv0LW
         aTwyrthKmy4cEWJ5YwwG7MbHIWyloTmM/yyiTjfz9w1poyO9UTCa56G8HYrpXcFFh2gP
         ibbQ==
X-Gm-Message-State: APzg51D1ZSA/eff1sxNSrhW5NhIXbPGVvI/Kk84Ni9v1xVfq7qZt1reV
        T+oIa5Nd9ShORq1cNqj5c1M=
X-Google-Smtp-Source: ANB0Vda+HE5xa/g6iTcZ9IpOer0cfcdz5GJ47+YDQA6Q/yGJ4JgdZ34rNB+KJcE5J6yDpqRM95NUvw==
X-Received: by 2002:a5d:62c2:: with SMTP id o2-v6mr13465074wrv.83.1537545553827;
        Fri, 21 Sep 2018 08:59:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f6-v6sm20366717wrr.68.2018.09.21.08.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 08:59:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH v4 1/3] Add support for nested aliases
References: <20180905085427.4099-1-timschumi@gmx.de>
        <20180907224430.23859-1-timschumi@gmx.de>
        <CACsJy8BnHgaphwy3beCCquFjU=SZebR2GvDCkFgh1_snxDBTRQ@mail.gmail.com>
        <aede75a5-d2ba-5a95-434d-aa70f7270fd7@gmx.de>
        <xmqqva7487a2.fsf@gitster-ct.c.googlers.com>
        <9f7aa1f1-2493-42f3-19b7-cfa2efadbb14@gmx.de>
Date:   Fri, 21 Sep 2018 08:59:12 -0700
In-Reply-To: <9f7aa1f1-2493-42f3-19b7-cfa2efadbb14@gmx.de> (Tim Schumacher's
        message of "Fri, 21 Sep 2018 14:45:56 +0200")
Message-ID: <xmqqa7oayh7z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Schumacher <timschumi@gmx.de> writes:

> it is located at the top of the while() loop. Giving an example is nice, but wouldn't
> it be better to say something like the following?
>
> 	/*
> 	 * Check if av[0] is a command before seeing if it is an
> 	 * alias to avoid taking over existing commands
> 	 */

If we have more concrete and constructive things to explain why we
choose to forbid it, that may be worth saying, but I agree that it
does not add much value to this comment to declare that an attempt
to take over existing commands is "insane".

Thanks.
