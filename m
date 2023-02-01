Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A56C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 17:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBARMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 12:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBARMG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 12:12:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A59EF7
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 09:12:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k13so19173318plg.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 09:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fb+UzPJwed1xRa1Yn6gesK5jm26hYyoStPMkMKxQpVQ=;
        b=GCGQIIapa93ot21xYuhVJx8HalOW/q/f2xx9dBOav4v0kMzGbS//6OiHLsP37Dr5c8
         LCJ4+0ksvUUM4UPrx4/OEwDyZ5fRSnekztpsOJNVrZSmb/AK6iM/Rxt1qw8h/GSvFcGy
         Na1axCA/Bp6oX1L/5nGJBhTZvl4dfRZtGdQrhBUx9y+9npm3MI4X3lFmyZSrGhVKQQJI
         8/t29u1IGQG5Mv7x8DNBoS9Kcn3BKR+Dd4LrB8nQP1dKl6NHzoB44KaI3Z2eG6t49Ttt
         qNuHlH4phnOkgQFpFlqepYy1I6bMn5IwmtR6eTjiq1yb6siDXkMCelhEyj7xdublVHGe
         6YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fb+UzPJwed1xRa1Yn6gesK5jm26hYyoStPMkMKxQpVQ=;
        b=2K1TTiRd8Hi9AM46t3G0wqDM+5k/B86Hg1Lwa0rO2E60eb6t4PV+HijJFdH1wIa7sj
         GteGcjAZSiVNJ2UsljjGYCdF9zi+ScuQY2o3vdNx5rkB5dNA3HU5IzowQVb9V79Pyxk8
         8zgaB1HHPz8UwtGOAFtKaFEtBFr6Xc+ijfK6sEsr1iFEkqecmqV6uL+mYzPbdLkR0lxp
         +BGYWVdDWBbwlEyMHWMgSE9mKgW89DvPsUbvfpX1H4P10u6NDXjNqHdxTecgLB/VkErx
         ahGiWvV0cJCk5sPYVOAAjIk2ZiuQm5mSItG1M6K3iYEKH42xRuNndqF2q2DLaSPGcgI9
         xnnA==
X-Gm-Message-State: AO0yUKVaV+298GGXYJ0MBKaTkDPMsSUG3y1mHLvE1lksk+nHeHkYtAAl
        Wy1VxAmVzIouvKrAl6qwO9Q=
X-Google-Smtp-Source: AK7set/Agx9fJwmveng4VH3DJppBrJFF95gZO/l7QJ5TsbMusgZ9vaR442RBh2VU+aPdj6R6fwfwQg==
X-Received: by 2002:a17:903:32ca:b0:198:adc4:2287 with SMTP id i10-20020a17090332ca00b00198adc42287mr2496544plr.2.1675271522705;
        Wed, 01 Feb 2023 09:12:02 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b0017ec1b1bf9fsm11963775plx.217.2023.02.01.09.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:12:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential: new attribute password_expiry_utc
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
        <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
        <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net>
Date:   Wed, 01 Feb 2023 09:12:01 -0800
In-Reply-To: <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 1 Feb 2023 07:10:44 -0500")
Message-ID: <xmqq8rhh2tum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
>> index f3c89831d4a..338058be7f9 100644
>> --- a/builtin/credential-cache--daemon.c
>> +++ b/builtin/credential-cache--daemon.c
>> @@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
>>  		if (e) {
>>  			fprintf(out, "username=%s\n", e->item.username);
>>  			fprintf(out, "password=%s\n", e->item.password);
>> +			if (e->item.password_expiry_utc != TIME_MAX)
>> +				fprintf(out, "password_expiry_utc=%"PRItime"\n",
>> +					e->item.password_expiry_utc);
>>  		}
>
> Is there a particular reason to use TIME_MAX as the sentinel value here,
> and not just "0"? It's not that big a deal either way, but it's more
> usual in our code base to use "0" if there's no reason not to (and it
> seems like nothing should be expiring in 1970 these days).

This is my fault ;-).  Here, there is no difference between 0 and
TIME_MAX, but elsewhere the code needed

	if (expiry != 0 && expiry < time(NULL))

to see if the entry has expired.  If the sentinel for an entry that
will never expire were TIME_MAX, you do not need the first half of
the expression.

I am OK either way.
