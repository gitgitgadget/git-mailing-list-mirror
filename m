Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013C91F453
	for <e@80x24.org>; Mon, 29 Oct 2018 00:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeJ2JeZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 05:34:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41485 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeJ2JeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 05:34:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so6813048wrw.8
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OQG50LGTCQwP8whhr3M7KLnJCDNm1nl4yoEes0U3tjc=;
        b=Cm26zk+/LtziUxZ5Nu/fGKCCOvK+NqZbwSgXb0yfftV6PtK1PmxeCqU0aZ6FAeCzlY
         75IyJK01YN6rZjwKtgbcPmajMty9zMPQ9EuSCmXPSfIgmFIuA+lnWHyHfaahYSHM1wQG
         2iLborKMJGg7IaHdRV/sTgPjAvIJsOea4CMYjMIgEN3rjgBX6JtWQfTvBhbprQRLvKrf
         18NmjCScNnh/R+RG2bLxbL0Y5apNRow6uvt404gSx8WbjkjJCmW5c6917q2MhLeKOJOp
         oeV6ttlVUC1tlJHwYPpM4auP4tmo7h9Gc4hfkfQqUICrQ9zXykNQAYNMqT2rP7z0J1aT
         k5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OQG50LGTCQwP8whhr3M7KLnJCDNm1nl4yoEes0U3tjc=;
        b=bwnI08hEVL81cbMal1g3Km5H6NeNo7hQrcb7Dcu5iN9nF4+zdWbrfX5ku3DicpJ2sn
         ThMDV1HWLhWz4enDgy4XKjr6nFwU5zoVgyp74gR4WhpAQ4JN/9mOXntE+MjMWZi8Y19E
         7rs9l3hIQb1mObf8MDwqrsIxduBhKg1OHn1qZl0auJG2nS749VEXThqqfUyJfBUDUtNZ
         Ne9TSUt43MyW4Tn2m1wDAYumPmwCKmkDp/hwN9jMVBpkvCwk+Eo+DZaow69nlnVblszg
         1tSs18KgREoZE81/LxyWs7caWP4pqZlGLgZpNVWqonwTx9JahPrAMAaGUX4LHCT4BiNJ
         vWIQ==
X-Gm-Message-State: AGRZ1gKnBZHfT0bnfM7byZDJmq6XteGb9tY/S2/JUDH/YcFyI+WEw5Z2
        qMRnKeCN2rzrUCgwLBDq7uo=
X-Google-Smtp-Source: AJdET5dmdtQrGZadZosuqZCjfXssaYBkhyTbAXDijf/gKmXRVwJKp94qKP1ze6ujLZhm/Po3TjbRtQ==
X-Received: by 2002:adf:80a3:: with SMTP id 32-v6mr13428066wrl.231.1540774085229;
        Sun, 28 Oct 2018 17:48:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k18-v6sm10325119wrp.65.2018.10.28.17.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 17:48:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Jansen\, Geert" <gerardu@amazon.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
        <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
        <87o9bgl9yl.fsf@evledraar.gmail.com>
        <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
        <20181027093300.GA23974@sigill.intra.peff.net>
Date:   Mon, 29 Oct 2018 09:48:02 +0900
In-Reply-To: <20181027093300.GA23974@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 27 Oct 2018 05:33:01 -0400")
Message-ID: <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Of course any cache raises questions of cache invalidation, but I think
> we've already dealt with that for this case. When we use
> OBJECT_INFO_QUICK, that is a sign that we want to make this kind of
> accuracy/speed tradeoff (which does a similar caching thing with
> packfiles).
>
> So putting that all together, could we have something like:

I think this conceptually is a vast improvement relative to
".cloning" optimization.  Obviously this does not have the huge
downside of the other approach that turns the collision detection
completely off.

A real question is how much performance gain, relative to ".cloning"
thing, this approach gives us.  If it gives us 80% or more of the
gain compared to doing no checking, I'd say we have a clear winner.

> That's mostly untested, but it might be enough to run some timing tests
> with. I think if we want to pursue this, we'd want to address the bits I
> mentioned in the comments, and look at unifying this with the loose
> cache from cc817ca3ef (which if I had remembered we added, probably
> would have saved some time writing the above ;) ).

Yup.
