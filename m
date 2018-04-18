Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3441F404
	for <e@80x24.org>; Wed, 18 Apr 2018 00:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeDRANC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 20:13:02 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:42096 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeDRANB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 20:13:01 -0400
Received: by mail-wr0-f180.google.com with SMTP id s18so40012515wrg.9
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t5F/Ppm7QFUbNYOV11AX0SgOBK4OFRv88OFFnDoajqw=;
        b=MeAAM9sioDmzJlPSjPwfB7pxBzYyj3Ajq79mhKDc8OPZUxFN73149nec9of4Y1/UnX
         2XJA3Mcsy/7rIbFzCJI7X3Uv0AeEYAGd9cHuaQ4zw7cK2NluCDGoxFYJ+VtRULxMghcG
         dvxhoS6PbuqvRvDM2hcYxXJwWLSzFd9WsWs4+dowfLf5hpNXeBPLC3iXeKdHo38saACR
         Et3BBESnnzw9O+8YhTmGcGc458WrPUbpUmI5HyEvuCAKoj9HTnWWGByZkeotsSLPj0Fd
         +X7byoH86S5e62J6/7JgXltJYHSFLGH5uRFF7UbH1AewhHC4SIVMJjMkWj8AWt0giAa8
         hYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=t5F/Ppm7QFUbNYOV11AX0SgOBK4OFRv88OFFnDoajqw=;
        b=orpxhU6m9rOlmh9lMRBnDzu9w6RvotG3FUut2Q5Epz8NsnuibOuSALEDn24KEp+mSR
         dIcdErlKSOqdIlDfP9UU+f7xcYsTqw6hJ1dSuN5JMJ+f+MkQi4ADTaZXJyugVg/YAPa7
         +KoLBw74OASCNMsEyxKDbkrjVcMbW7+/0lg39anZvQRWlu4cWni25Nkoniols6hHjCQH
         1uEQWEkcJH9vOYdN0zidfmPIhAnNfpHYo67ehwVRhb+XDEfiAZO6BmtS25YGmtz5rVy6
         9O5pK0FeTMwg53ZhWUWLdGMh5fgXIcT7ghZnzXBYSFmoENxkQ1tFukxLwmtW5zwSCj2m
         aJ5A==
X-Gm-Message-State: ALQs6tCw8uWOCLU3L0Wycvt7PARQ0OS7m9OMnxRVBLblqj+F3EQGD+2z
        NlP2wBD9HYLRAP/ExNKK4je6Red4VzU=
X-Google-Smtp-Source: AIpwx49g+6gLHnPpMHksDcXLmMrdBMme8VvFDaGovE5qKEJf/QFlaz4S0gRvKlfawF8Xz0cXr5cbHw==
X-Received: by 10.223.227.82 with SMTP id n18mr3132725wrj.82.1524010379773;
        Tue, 17 Apr 2018 17:12:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b5sm8111922wrh.67.2018.04.17.17.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 17:12:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
References: <20180416220955.46163-1-sbeller@google.com>
        <20180416220955.46163-3-sbeller@google.com>
        <xmqqbmeiv7c2.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kb+MEJswk9NU3ktr9gAY7XVdCYS-w=e-Qmmp8knSNsHTg@mail.gmail.com>
Date:   Wed, 18 Apr 2018 09:12:58 +0900
In-Reply-To: <CAGZ79kb+MEJswk9NU3ktr9gAY7XVdCYS-w=e-Qmmp8knSNsHTg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 17 Apr 2018 12:31:45 -0700")
Message-ID: <xmqq8t9ll6d1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Apr 16, 2018 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> It seems that this
>>
>> $ git -c color.blame.repeatedlines=cyan blame --heated-lines builtin/blame.c
>>
>> refuses to run.
>>
>> Would it work if the configuration is in .git/config instead, or
>> would it forever disable --heated-lines once somebody choses to use
>> --color-lines feature by default by configuring it in?
>
> That is the unfortunate part of this series, I have not figured out how to
> treat these two options at the same time.


Perhaps I wasn't clear enough, but I did not want to use both at the
same time.  "git blame --color-lines --heated-lines" that errors out
saying these cannot be used at the same time is an acceptable
limitation.

My sole complaint was that just like command line is used to
override (weaker) configs, the wish to use "repeatedlines" painting
by default expressed in the configuration form should be overriden
when there is an explicit command line --heated-lines option that is
incompatible with it.

In this particular case, you might be able to come up with a scheme
where both can be made effective at the same time, but the principle
still stands, and that is the more important lesson I'd like to see
you learn.

Thanks.

