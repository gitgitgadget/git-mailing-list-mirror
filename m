Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECFAC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 20:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867F3611CA
	for <git@archiver.kernel.org>; Mon, 31 May 2021 20:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhEaU7Y convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 31 May 2021 16:59:24 -0400
Received: from kautler.net ([85.214.242.4]:59305 "EHLO kautler.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhEaU7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 16:59:24 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178])
        by h1362875.stratoserver.net with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <Bjoern@kautler.net>)
        id 1lnoyl-0003Kk-10
        for git@vger.kernel.org; Mon, 31 May 2021 22:57:43 +0200
Received: by mail-yb1-f178.google.com with SMTP id n133so9489599ybf.6
        for <git@vger.kernel.org>; Mon, 31 May 2021 13:57:42 -0700 (PDT)
X-Gm-Message-State: AOAM531Y+TFYp//MyLfqVvfQ6Y4vkSaT3ZsN0Ok51niACMLOpb8UQuz4
        diYqYWTaC0sGKI4FK2So6ISmwJmNTQ1TpC9+Tls=
X-Google-Smtp-Source: ABdhPJyOksjRVq9HH5FAKY7ebQ737ZQAV2Vhr+f5mhKtNYHMVELRr+Wsjutg+2koxQeZReEkhRoCaJkAbVK0emPNHUw=
X-Received: by 2002:a25:db09:: with SMTP id g9mr33422589ybf.261.1622494656529;
 Mon, 31 May 2021 13:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKChYSqgGRfBh68oj=Gt7q4uyS7D879aQZQiZ1RsyqaDToV+0g@mail.gmail.com>
 <07edafe5-d0a2-4a2c-12a2-28c163f6fdda@gmail.com> <YLRoAIBExd+dAe0C@sleipnir.acausal.realm>
 <CAKChYSrQ3u3yH0+8Fwj-84cnAFGvuSEPHx+5Mcy8Ys4sXcN14A@mail.gmail.com>
 <CAKChYSpGJ8WHsYRgYL9M8rr7Dp_SLrUuRsTONqNO3CTnX2DQ_Q@mail.gmail.com>
 <00a401d7565d$f20fd4b0$d62f7e10$@nexbridge.com> <CAKChYSpjOZa2F_mE_7--htzaQ1V4zWgYi8Wm4GHOiYnWoAiswA@mail.gmail.com>
In-Reply-To: <CAKChYSpjOZa2F_mE_7--htzaQ1V4zWgYi8Wm4GHOiYnWoAiswA@mail.gmail.com>
From:   =?UTF-8?Q?Bj=C3=B6rn_Kautler?= <Bjoern@kautler.net>
Date:   Mon, 31 May 2021 22:57:25 +0200
X-Gmail-Original-Message-ID: <CAKChYSq__2dgCWVqKt1LeBs9vg8xSj2FnikDqNdgsevfz565zg@mail.gmail.com>
Message-ID: <CAKChYSq__2dgCWVqKt1LeBs9vg8xSj2FnikDqNdgsevfz565zg@mail.gmail.com>
Subject: Re: Bug when cloning a repository with a default branch called HEAD
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        asymptosis <asymptosis@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't get me wrong, I neither want that nor intended this result.
This happened in the test suite of git-spindle which does commands
similar to what I showed as reproducer now and I just wondered what is
happening.

Imho a simple push should not be able to produce an unusable state and
I think this was not the case in the past as the tests used to work.
But this could also be caused by changes in the used fixture repo.


Am Mo., 31. Mai 2021 um 22:52 Uhr schrieb Björn Kautler <Bjoern@kautler.net>:
>
> Don't get me wrong, I neither want that nor intended this result.
> This happened in the test suite of git-spindle which does commands similar to what I showed as reproducer now and I just wondered what is happening.
>
> Imho a simple push should not be able to produce an unusable state and I think this was not the case in the past as the tests used to work. But this could also be caused by changes in the used fixture repo.
>
> Randall S. Becker <rsbecker@nexbridge.com> schrieb am Mo., 31. Mai 2021, 22:46:
>>
>> >-----Original Message-----
>> >From: <Bjoern@kautler.net>
>> On May 31, 2021 4:38 PM, Björn Kautler wrote:
>> >Subject: Re: Bug when cloning a repository with a default branch called HEAD
>> >It happens the same no matter whether on Windows or Linux.
>> >I now also have a reproduction recipe on how to get into that state.
>> >- Create the `whelk` repository with standard settings, nothing for default branch or anything is necessary
>> >- Execute this: git clone https://github.com/seveas/whelk.git
>> >whelk-src && git -C whelk-src remote add gitlab git@gitlab.com:<your
>> >namespace>/whelk.git && git -C whelk-src push gitlab
>> >refs/remotes/origin/*:refs/heads/* && git clone git@gitlab.com:git-spindle-test-vampire-1/whelk.git && git -C whelk fetch
>>
>> According to GitHub, the default branch for this repo is "main" not "HEAD". AFAIK, HEAD is a reserved ref in git and I don't think this would or should work.
>>
>> Just saying.
>> Randall
>>
