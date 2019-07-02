Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7E91F461
	for <e@80x24.org>; Tue,  2 Jul 2019 11:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfGBLht (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 07:37:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43579 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfGBLhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 07:37:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so17996065qto.10
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yX2mFb6DPGKgQrM9PxQqIq0uHfm7z6P/C1pV6QAmKQM=;
        b=o9jZ/uVxWs568DWPPvoOQ5I6czidO/lsOkoGNeP8/9MAouS0QxdkR1xGZV4Bz+IsQz
         8hmWMqugdQFomNmU39wzqVZVVwnlCX0M8Q7eEb9kKBo/6/CX/F+fc52pET9aSeumgmFl
         W13PkDijRTB8OgDIayBVcKYWuPa8xppLxjeRkYUzbtD7Zm/OIuFLeqeplUD6pgzuLzaq
         5izEbdStZ83Ulmcn3lBcVx/pwuBKv0wcGZLjnoMJ+PMSFN6rpvshDDzDydjQB+dhJZxR
         32Qwh/9po6v8ax1Z6jH+fubRSg+a+1JAl1WMRT+5qVafnhLHRq+hwUl6iVcVtQzO8X+K
         WZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yX2mFb6DPGKgQrM9PxQqIq0uHfm7z6P/C1pV6QAmKQM=;
        b=HOKHbjQ7J4x/nhlBGPqvm2C8zNVcaooq7avcaSWBqt4wryn6J2zeY0J69oOzYmnIee
         iOK1X1zF5jt8FTI7DaSZm9wkRHcMHncFIaqU45Z4N9Zx8jfL4QXqKZxPq2vBUgwL6FSg
         1WxoIsZdkfOsLo+3Xf/q++CeTAlVFlxuZjzzvMVz0XLbVwGaWWbmI8YaB911xsANEjRR
         jFyo977Philc4lU/zYEN8sVzWGkEcMrWmyptxpJdFWRXp8fN4J0+1z7qWlgxK4bbkO3v
         MAJUDHFQEauTztirc49wI2hx0hs0Hc+G91kuIYosM58OzeuldgtpAeYlJUqXL+Z8Mt/E
         ZYGA==
X-Gm-Message-State: APjAAAVQD1nsd5+CY5m3bFMjlk2ney1zU1FnA5fV7dolhjFHyuvOycjv
        dOls5f1PySMdPiHlpNFr5+zqw/suwNE=
X-Google-Smtp-Source: APXvYqy24iYet1H+y/ED/aj3vtvf72Bd/s1Jil5u/6L5MjkxmpguxtepVgMqyqoxaOQkQXB7AlR59w==
X-Received: by 2002:ac8:2d08:: with SMTP id n8mr24537592qta.383.1562067466196;
        Tue, 02 Jul 2019 04:37:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:858c:78f0:58f6:666c? ([2001:4898:a800:1010:36c2:78f0:58f6:666c])
        by smtp.gmail.com with ESMTPSA id n18sm5205264qtr.28.2019.07.02.04.37.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 04:37:45 -0700 (PDT)
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>, git@vger.kernel.org
References: <20190630051816.8814-1-eantoranz@gmail.com>
 <20190630065358.GB31264@sigill.intra.peff.net>
 <xmqq36jp7gd8.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2cece7ff-49af-0cae-7cb8-7cc1821be1ca@gmail.com>
Date:   Tue, 2 Jul 2019 07:37:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqq36jp7gd8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/1/2019 2:35 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>>> First, we create a (temporary) merge commit of both branches (M3)
>>>
>>> ------------
>>> 	R1---R2---R3---R4---R5---R6---R7---M3
>>> 	 \         \              \       /
>>> 	  F1---F2---M1---F3---F4---M2---F5
>>> ------------
>>>
>>> At this point, all differences between M3 and R7 are the changes related to the
>>> feature branch, so we can run git reset --soft from M3 to R7 to put all those
>>> differeces in index, and then we create single revision that is both
>>> squashed/rebased for our feature branch.
>>
>> So if I understand correctly, our goal is:
>>
>>   R1--R2--...--R7--R8
>>
>> where R8 has the same tree as M3?
>>
>> Wouldn't doing "git merge --squash" do the same thing?
> 
> Yup, from Edmundo's description, I agree that they are equivalent,
> modulo the merge direction.

[snip]

> If M3 merge is always easier to manage than incremental stepwise
> rebase of the topic, then doing the "git merge --reverse-squash"
> would be a saner interface and also conceptually simpler.

I agree that this would be a better way to expose this behavior,
and likely the implementation could be very clean.

Thanks,
-Stolee
 

