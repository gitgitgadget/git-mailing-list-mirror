Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A601F406
	for <e@80x24.org>; Fri, 11 May 2018 02:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbeEKCQI (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 22:16:08 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:46086 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKCQH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 22:16:07 -0400
Received: by mail-wr0-f182.google.com with SMTP id a12-v6so3743138wrn.13
        for <git@vger.kernel.org>; Thu, 10 May 2018 19:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=L9PsiVmoQmMvT4T1JXf5yoFEgz4OmAKSLQaeivEGdRA=;
        b=PPtqYVWu+rygKWWVo+bphttC10XngRKHivXKQpPooEAWgzF+LCjvI6is3A0xsCU3ts
         VkS/PloicB7FH4EO7t6cdElhHfN0fl9QWR9p8FNbbDW1vxIsuWWyGk24OZySfY/HyIG0
         2DifswuFhkeJmBy6hsMu8c4oGS86hUWBBf2vaKUraL0Wlbgjs9LdrCuRi3J4qHO82rvI
         p01/6DM4shGoLRzGwYwmvr4VIv5Dv7JCkUa/eYrMwkBTPaBlD5EPY/Ui7ZQXJsqKJr7t
         p86TnER/H2oqHM23Pp1lnChSPbU2e5COYBbYZhLw9WHByX9NY+u7wmYhDx4qd5JdSGVZ
         Gs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=L9PsiVmoQmMvT4T1JXf5yoFEgz4OmAKSLQaeivEGdRA=;
        b=erGVVODg07rKSjSnNU/aksy/fPZI/IpMa6jGsPLSznCOW9VnMya+GO8KU2heiTV/UT
         9CQ3EH/G/Pdxavt3vNjddUREfZNH+lhzH5EvjcAIxTDhF0Mt7oGt/Wc5LEuqLvI4gvPv
         650YTsNXrB9T69W5adpnNZupfCGl5n+59fGSuVWPHuIqg0jFZIUhPBYD/0v+aE8S6QHl
         uX4qdjh/Gw4qLX8Es5tRJKA8XrL0NN96WMY2T9+s0pYMkdzhPzZq5Ru/c6VaC8UvRk6U
         OEmBJ2QiAEOdIVROM2bMr6OtWiFvWPaesNpHvffO6U4bbNgfO+tHEixXIcs7RSghqqtj
         61PA==
X-Gm-Message-State: ALKqPwcjoJWj4xLKnP/BkrVwGlpyWyTRDBr8rAY6imGwcDvqA8OppOJ8
        x9v/EuwuNh/fzdutKBdwPL8=
X-Google-Smtp-Source: AB8JxZoYkkWTO5jAgbJwGOfAPZ9tScnYgPnEPPttEWc7Qf415duEiAnUq0uv1b1flqQdqD6yaxppXw==
X-Received: by 2002:adf:82ce:: with SMTP id 72-v6mr3065572wrc.60.1526004966078;
        Thu, 10 May 2018 19:16:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x16-v6sm59498wmc.42.2018.05.10.19.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 19:16:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
        <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
        <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
        <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
Date:   Fri, 11 May 2018 11:16:04 +0900
In-Reply-To: <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 10 May 2018 21:47:56 +0200")
Message-ID: <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> But it somehow feels backwards in spirit to me, as the reason why we
>> use "void *" there in the decoration field is because we expect that
>> we'd have a pointer to some struture most of the time, and we have
>> to occasionally store a small integer there.
>
> Yes, fast-export seems to be the only place that stores an integer as
> a decoration.

With the decoration subsystem that might be the case, but I think
we have other codepaths where "void * .util" field in the structure
is used to store (void *)1, expecting that a normal allocation will
never yield a pointer that is indistinguishable from that value.

> Using struct decorate in fast-export has the benefit of not
> requiring separate allocations for individual entries.  Switching to
> struct hashmap would require individual allocations.  Adding a
> custom clone of decorate with a uint32_t payload would be an option.

As long as we know uint32_t is no wider than uintptr_t, your patch
should be safe, shouldn't it?
