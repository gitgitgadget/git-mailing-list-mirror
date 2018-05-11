Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F8F1F406
	for <e@80x24.org>; Fri, 11 May 2018 04:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeEKEtr (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 00:49:47 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35941 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKEtq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 00:49:46 -0400
Received: by mail-wm0-f43.google.com with SMTP id n10-v6so816426wmc.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 21:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=c/kpxQPwuOUJxJIlmM7w2dQvnJEqxCZwKIPvBqM1W6I=;
        b=KJXHKvgK0v/a4PobuFaR/FQ6EeI3bThHYWrGm6WquggjFOSkuuO8UnLC5aLA2kdGYU
         ph6Dq79wJHuzcUKyYnr5pwQOshGZMig0Wfg6Bp9292SwE3o/h7oYqhIIVMKx3jeyV8Re
         bzuwvpoP+H0yi6rZzrO9hnVvAI3301Ej06OadP9D2KJP1UjImBB2TMx1oxL8wcsXmNCn
         Qbi5RqFYP200vBLkyF4Hthgg+Qf8VpX7mkS99tqtlDkKXyL5CiYWJHdsPiIIcBqlK7N5
         1fWSjrUycL9EgnCcY5g5UFQYG9EhVyshRRBx3REDiEjWJWVyJAj3HOupSUOvTp+LhIV6
         8Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=c/kpxQPwuOUJxJIlmM7w2dQvnJEqxCZwKIPvBqM1W6I=;
        b=Nqs8uTJfiLz00PDXyiLUIyouxW6rjlTvtRPa5XMdagCTfuvhTmdPjuxfvbiVd3LD0m
         AQX/dwT4Z1M+y9x50V3WIVF52Bvjt2ba6h9wsw4/WqJesMm9/RTtcsoPZfd3f+mTtnIG
         N2ZRov2dnc674MxHtr7e837afpkjKT39c5ho0Py2FO0jPo+Sd1cL9TSoidPvo9A9D3hT
         nCWf+7LENYjAEyfW5w58c6JbBjVL22nqSD2BbLH1s/XDKnxDK5F+eJoEDlSb9vV7pFJ8
         9l8iHzAGfB2FLt6k0J3/iyxczr8WhyUz0Dh3c83Aym6Os+4VwHp5yBfD4vHKSi1yRT0t
         nI6Q==
X-Gm-Message-State: ALKqPweS9L8ZBiWypLD7bL11NvlJKbIF2zBLEwYUcS0E5PWsztTtyXQM
        /97FeAwQ3GKgpIIyNWZR8G0=
X-Google-Smtp-Source: AB8JxZoy87Bemk9E02fDP0W5g7qVZtjYHK6cYsmVFY/S4dhW0w2sOAlW9bCs9P8ooeg5l2KKi5DdaA==
X-Received: by 2002:a1c:6ce:: with SMTP id 197-v6mr755855wmg.141.1526014185336;
        Thu, 10 May 2018 21:49:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 131-v6sm1216276wms.34.2018.05.10.21.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 21:49:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
        <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
        <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
        <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
        <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 11 May 2018 13:49:42 +0900
In-Reply-To: <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 11 May 2018 11:16:04 +0900")
Message-ID: <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> René Scharfe <l.s.r@web.de> writes:
>
>>> But it somehow feels backwards in spirit to me, as the reason why we
>>> use "void *" there in the decoration field is because we expect that
>>> we'd have a pointer to some struture most of the time, and we have
>>> to occasionally store a small integer there.
>>
>> Yes, fast-export seems to be the only place that stores an integer as
>> a decoration.
>
> With the decoration subsystem that might be the case, but I think
> we have other codepaths where "void * .util" field in the structure
> is used to store (void *)1, expecting that a normal allocation will
> never yield a pointer that is indistinguishable from that value.

I was looking at a different topic and noticed that bisect.c uses
commit->util (which is of type "void *") to always store an int (it
never stores a pointer and there is no mixing).  This one is equally
unportable as fast-export after your fix.

