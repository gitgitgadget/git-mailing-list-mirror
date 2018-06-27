Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F7D1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 19:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934570AbeF0TYD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 15:24:03 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40413 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934027AbeF0TYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 15:24:02 -0400
Received: by mail-wm0-f52.google.com with SMTP id z13-v6so6633779wma.5
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uniTmOsQ4g+nuZn/zvJwybXBTdFCaI3UrpSwb4sR00k=;
        b=WxYmLHE/N9s6nVzRid9MAmVyuKEkT3Lcf+0VQ1YIqLwURwfsSF2ONNYMDMM5q6HfY0
         Uho+sRpoEqNl0hBDucYasiygUYvPjkuvI6WGgie1udpK5IaWIBKyZ9yKk5iEvrLLRJhO
         f8ywedhx8oi//NO4aHTLBKxCWKkm+U126iBOI4A+Fsh75/ffRti+BGD6UMi11Sl1O7Ij
         cRHMXNWLUN4hKCJdA151jIQeSdNe8XuvO3zfwEgrFctiZB6PrCtxtB67rq6IX9pXUUrU
         iHqAMGJUyKcMv7AF3syu+H/xJV8gPhBZOMrWP/UbNvik3iRydxpekGRbQTJG1IKTX2cw
         ny8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uniTmOsQ4g+nuZn/zvJwybXBTdFCaI3UrpSwb4sR00k=;
        b=LO0ttz4tbTSor05QjnwAs+UYQ2w8LqLZ0ouSpSF/o1RoaYp/57paWXZOGUFSF6rned
         z6yZId+sAP1sGzYq87//BU3CY6eXSI24pyNmPgBf9fGoHHL3Og15OHPePnyPPzBe8DUU
         hvhm0lBexh+B9WnUjuYRFjlJkbMc4iHc5SkRo09b5Mr0w4a5RFb64SfAPVeuQa26Y8uO
         qw5+/JK8g8vGCjqofGLujXsoQsjlJzXGoWnGIUo+iuWQw0FbNNJZIJhuH07GdDDhYVZB
         2U60WxF3KlgAS9dtxnX5N7kDEKEbJJUdOKjftbJ5aq3Yh5eYn+aSQ2/gHXA0QhYUJxLU
         hN/Q==
X-Gm-Message-State: APt69E1EshG1koVfUX1DPDjPYbfVfHVV2F/Ye1JkHTVW8yAX26T3rdQZ
        ppgZKOKPV2r08N6Jg2JcPcs=
X-Google-Smtp-Source: AAOMgpeB2wYk8nhUrpE3XLojYnRmXP/6jafgbkmo5qkpSOIsCIZz5gtVBGgwM8B657vZC9SPsYeVhQ==
X-Received: by 2002:a1c:46c2:: with SMTP id t185-v6mr5752626wma.56.1530127440899;
        Wed, 27 Jun 2018 12:24:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u15-v6sm9502473wma.37.2018.06.27.12.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:24:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] t3418: add testcase showing problems with rebase -i and strategy options
References: <20180607050845.19779-1-newren@gmail.com>
        <20180627073623.31725-1-newren@gmail.com>
        <20180627073623.31725-2-newren@gmail.com>
        <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com>
        <CABPp-BFkjF5z6axqW-v=zPq9U9sOQGpUKK+WvLknkkGzX-F4rA@mail.gmail.com>
        <xmqqh8logofg.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEYbC0C+bczQuNTcC_jxVM59czh7HTpqi9dv09fvCjMrA@mail.gmail.com>
Date:   Wed, 27 Jun 2018 12:23:59 -0700
In-Reply-To: <CABPp-BEYbC0C+bczQuNTcC_jxVM59czh7HTpqi9dv09fvCjMrA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 27 Jun 2018 10:27:56 -0700")
Message-ID: <xmqqmuvgdods.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Seems reasonable.  Since these tests were essentially copies of other
> tests within the same file, just for rebase -i instead of -m, should I
> also add another patch to the series fixing up the rebase -m testcase
> to also replace the subshell with a single-shot environment
> assignment?

I personally would think it would be best to leave that to a later
day, and take your v3 that properly &&-chains these two assignments.

It may be a good clean-up, but is an overkill if done as a
preparatory clean-up in the context of these two small fixes.

