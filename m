Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843AB1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 13:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeDINPn (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 09:15:43 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:41802 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeDINPm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 09:15:42 -0400
Received: by mail-pg0-f53.google.com with SMTP id e2so239596pgv.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZHPLFjBzclCw5E+LQnNl5ANw1DbD8QMZ898YTjLsqvM=;
        b=b6J5oHN0yB6R2PxKEsZvyTi8dPKSNz9MwIM2yaIGyO1TDUmis9SbiK0KCrByvdlm3p
         F0RZEPozuk9OQYqIqEiaDKZDqZ813Xxz6yBdiDM6eVaWsgHE4080fsCXTQ2P1B7Tw7Qt
         FVmaoYMLQe30q+4MJ6/qi95TziYSheVTbhPQn/u0EOVKJgqzgkyz9fG3Akpnuo7A8iei
         kN1copIMukR4WnRQtV4H6/a+76WAqHply4ap1BA29nV+O7fW7CRFny769IvLHEkyLCLe
         +S5Dgabv9jtUI6pnyne85W5JWXTC+9icASguJkP94ZKBNoSvVXUVzho2urhM58nSUWow
         MC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZHPLFjBzclCw5E+LQnNl5ANw1DbD8QMZ898YTjLsqvM=;
        b=jA0m1eQnYT0umYb0i1CjpiiKlxDa753+X4km/kRQNcz4bO3wc4vQgDiiJwNzaIfknO
         K0Cfi0RXfCSZLJ/+oYc6/t9OMuGUJ2jhgxWCIMFa49jn4qNB6VJDuxL7E4oBz3mE1gAZ
         CgpU1hvjrStWKsyzUFfa9gsTth05Y9i2adaJkM1kdvPRiiXzmavWo+woS9sc0c6238Oc
         QLB9C8VYhryGVVb6iBnPxJRs+CMA2mSMaqiNB1EnKnSbj+5xJ7L823vYBE9y9eBt6Ewo
         KCtV1Le75gZUNrtMnvHbhJMobFe8pNLiW7vkuoONlptK3aWHFDEnJwlX5L7RNYqHPKB0
         4gQA==
X-Gm-Message-State: ALQs6tBOaKxbSCyelgqrftPc2OKFH/hCxIcfa7TEqhJRxuvQcjsBOP6c
        VWjSj/0mSeXzr2ztmXnh5Fw=
X-Google-Smtp-Source: AIpwx4+IQXe1FdRjQ5AUQUsci8IzwdXyifHWZeGsM0hvm874nUnsxgC/uInMX3js11TTZl6vlMLqJQ==
X-Received: by 10.167.128.2 with SMTP id j2mr5990701pfi.126.1523279741564;
        Mon, 09 Apr 2018 06:15:41 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id f19sm659188pgv.39.2018.04.09.06.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 06:15:40 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com>
 <20180406192146.GC921@sigill.intra.peff.net>
 <xmqqr2np70dl.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7930c9bf-4f24-2e76-b522-331a2e9ed5d5@gmail.com>
Date:   Mon, 9 Apr 2018 09:15:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2np70dl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/2018 7:18 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> If I were doing it myself, I probably would have folded patches 1 and 3
>> together. They are touching all the same spots, and it would be an error
>> for any case converted in patch 1 to not get converted in patch 3. I'm
>> assuming you caught them all due to Coccinelle, though IMHO it is
>> somewhat overkill here. By folding them together the compiler could tell
>> you which spots you missed.
> Yeah, that approach would probably be a more sensible way to assure
> the safety/correctness of the result to readers better.

I don't understand how folding the patches makes the correctness 
clearer, since the rename (1/4) is checked by the compiler and the 
Coccinelle script (3/4) only works after that rename is complete.

The only thing I can imagine is that it makes smaller patch emails, 
since there is only one large patch instead of two. In this case, I 
prefer to make changes that are easier to check by automation (compiler 
and coccinelle).

However, I will defer to the experts in this regard. If a v3 is 
necessary, then I will fold the commits together.

Thanks,
-Stolee
