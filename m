Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95084C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 17:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjDRRxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjDRRxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 13:53:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C7146E1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:53:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8ad872ea5so23328841fa.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681840401; x=1684432401;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8bLXIYCULAHAV3CsQCzhSK2YTeGYatAP0E5t7d7IUQk=;
        b=qjKA4E1X24QzQ0XACxJYq+nO3imxUAazv8nDxdHiPQAdsGiR5+Q2ZSeZaCX1hvQ2K8
         Tft222dBehuK6sTbOBb0LIl7w4Zm/ZezXgSDbFqRfxCFrx+kxNc4eRw09yFPKHNbnXZs
         AX6HB58gqJuOfnbudiqzMISqzOu9emjBqtTKmvjzVwhFZQyyvhpvLRcQbtGKgkXmfJhy
         RkaQmlZwrm/NE+HJq4lHZRR2/eWpj+KY5kv66LHzvlRt5k0GodedW31fWJFSYIrbwsS7
         u7j0V+NBLTsAUVpGDATdjN8jMhFzEBdzaXk6+KDFlEeDesDZBp7A9x96OtCwyx1iQDT8
         KhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840401; x=1684432401;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bLXIYCULAHAV3CsQCzhSK2YTeGYatAP0E5t7d7IUQk=;
        b=cOxJ5W1M/KVS7Pv0s67fnyK5uXQHWmb96gtDvGxRdJ9u6pTZGCG8L0Yp63Jw6H1ssJ
         jJf3DD0l/7TvvQhnqmytyWs5qTI02ztH8/+13InAfG+S8djMQKPtXbTliCJp2zwbpx4c
         Kz09Ek92s6Yl5cGrp1nl49UUM6HNGhrFeWH6xxXRyUend+d9xr7P6uXW9gZ35g3l1k9u
         RlYSLJIoH26rkbuAJuhCDMXfj6H549Ks9SAdXNocalBhZ0+mRto3JZueR5zWp5IaVrI4
         UUpWU0YsDEqkwUIqtpCY9m2dkeHd7AL1YNMsGAetQuXp7BQhhDUXgF4m3wqzaR1AsSRr
         l0mQ==
X-Gm-Message-State: AAQBX9cWsyCOTS70xc3N70XAh6HXLa1KpsGIgt4Ge8WjlUfVbApOFB7x
        IHDxtdyCYuaoZzayLW5ztlO4e0y/FYSDCMWp
X-Google-Smtp-Source: AKy350YM0aO+F5gA9YiO6OJzRZKcPgvrjN41IDmzitNDqqsA/Dsdwbo9NM58QG1+AOtdVrUGgDkn5w==
X-Received: by 2002:ac2:47eb:0:b0:4eb:29b0:1ca3 with SMTP id b11-20020ac247eb000000b004eb29b01ca3mr2374535lfp.6.1681840400954;
        Tue, 18 Apr 2023 10:53:20 -0700 (PDT)
Received: from [10.8.18.63] ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id s12-20020ac25fac000000b004e81fdac4a1sm2433705lfe.278.2023.04.18.10.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:53:20 -0700 (PDT)
Message-ID: <e2cdb2f3-2cd1-c7fc-be9e-c518f17fc175@gmail.com>
Date:   Tue, 18 Apr 2023 19:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/3] git config tests for "'git config ignores pairs
 ..."
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230414081352.810296-1-rybak.a.v@gmail.com>
 <20230418175034.982433-1-rybak.a.v@gmail.com>
Content-Language: en-US
In-Reply-To: <20230418175034.982433-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/04/2023 19:50, Andrei Rybak wrote:
> v1 cover letter:
>    https://lore.kernel.org/git/20230414081352.810296-1-rybak.a.v@gmail.com/
> 
> While preparing v2, I've realized that I've failed to click "Reply All" when
> writing my previous email in this subthread.  I apologize.
>    https://lore.kernel.org/git/CACayv=jL4t3cUVS=xXQ3fLxF26vDXRJ3khs2y4UjzBw947JVkw@mail.gmail.com/
> 
> Changes since v2:

Sorry, I meant to say "since v1" here.

>    - Rewritten commit message for patch 2.
>    - New RFC patch 3.
> 
> Andrei Rybak (3):
>    t1300: drop duplicate test
>    t1300: check stderr for "ignores pairs" tests
>    t1300: add tests for missing keys
> 
>   t/t1300-config.sh | 30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)
> 

