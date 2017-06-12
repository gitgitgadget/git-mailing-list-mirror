Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072D01F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 18:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbdFLSE3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 14:04:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36308 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdFLSE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 14:04:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id y7so17208137pfd.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=85WTyzirenB7Rk589Yjm+SpDGi2GABII29oPutui5n4=;
        b=e2VBgJpgZaJM2w/g662qx/uzAT1KR86Cj+9enZ2fyDmuN8dX83KuK7KZ7gFeph1Pbu
         BNXKQx51pqTCyQ6eIx6PmYfTAN9i3ED5wTVN8ChR0NOeORcOn5WaQQ2U9rs4sV5NUY5f
         zRGzVic4ZbeuWn5Rw49rjsjB3GUtVWghscmiBjmdNxNK71lIzs26fw0RVfq/zm6VU3aU
         ApWqBj2OxCVAZg5bd1mBtWT/pTErLKv78Dez55zz3kQpiKRVIgZ68zwM4fPz9kFMT57g
         H/zV5gZZnQA0hkq/QGmxxegOOOa0vZyTUtmwmZL5toPPO9BIarTkSJ5XR7zECL4UUCZQ
         FlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=85WTyzirenB7Rk589Yjm+SpDGi2GABII29oPutui5n4=;
        b=tTRftS+M3gI/xqRDYU2Kd9dgtcFgHNqG4Et36GMkSXBD6VOaz871orhTD00Bq8QRLI
         TBzydcLCxxcurpCJ1KbQlKe/rwYbMDW+n6at109twzQifbC3eT8PG8rKeoRzou5Rhdhs
         jxxyW9qW9O5sNkVFFtqdPWtWYoR8nTJXQvkrNj2RHykRXBHtuSAB5DbDwOhGvNVy4VNl
         Q22hAT0tGkak36bIaApIVIgVtm0WtIyr2y75DWsq8pi5MNwgKRphzmq2U3eqS+oX4iyP
         3+MRsT8MqRMyc9mPysUaePCfnezoDTC+soC7d6kIGVlYbV3qBc5clZop9vFX/Ukf8NBM
         1hwQ==
X-Gm-Message-State: AODbwcBtJ5cBMSFnPXJZgY1UvinnOKr2C6Lx6vKoRYPi9qtLD7oMVf3u
        u0J16ty6QkMdSA==
X-Received: by 10.99.218.69 with SMTP id l5mr60133834pgj.88.1497290667609;
        Mon, 12 Jun 2017 11:04:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id b2sm17438722pgc.16.2017.06.12.11.04.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 11:04:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] send-email: Add tocmd option to suppress-cc
References: <6367777092d93a62cc83c444061dde853ba3369e.1495107179.git.viresh.kumar@linaro.org>
        <20170612043313.GE5297@vireshk-i7>
        <xmqq8tkxp4nw.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 12 Jun 2017 11:04:26 -0700
In-Reply-To: <xmqq8tkxp4nw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 12 Jun 2017 09:11:15 -0700")
Message-ID: <xmqqmv9dnkut.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Viresh Kumar <viresh.kumar@linaro.org> writes:
>
>> On 18-05-17, 17:05, Viresh Kumar wrote:
>>> This adds tocmd option to suppress-cc command which already supports
>>> cccmd and others.
>>> 
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>  Documentation/git-send-email.txt | 1 +
>>>  git-send-email.perl              | 8 ++++----
>>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> Ping !!
>
> Pong?
>
> I didn't get the impression that in the discussion that led to your
> patch (or in any response to the patch) we established that it is a
> good idea to change the behaviour of suppress-cc unconditionally
> like this patch does.

I think suppress-cc that suppresses cccmd output is very sensible
(after all, it is about suppressing CC and cccmd is about producing
CC), but I am not convinced that it is a good idea to suppress tocmd
(which is about producing To) via suppress-cc.

Going back to the core part of your change, i.e.

-	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
+	foreach my $entry (qw (tocmd cccmd cc author self sob body bodycc)) {

to think about it a bit more, I notice that all the existing ones
are about CC.  So I am not just not convinced that tocmd belongs to
the same class.  I am inclined to say that it smells quite different
from others.
