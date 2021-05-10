Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF4C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 04:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2BA613CD
	for <git@archiver.kernel.org>; Mon, 10 May 2021 04:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhEJETo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 00:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhEJETo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 00:19:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6167C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 21:18:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h4so15060827wrt.12
        for <git@vger.kernel.org>; Sun, 09 May 2021 21:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=a+d88wl/YBTUB9ucZcd7ASYCnEo9o13zvTVquRf1Dmc=;
        b=SZomle/fULDqvwLcFCFs/XEECguHFCAqSiCKGQbcVw5N+7C8WeZ3+4CEnGUE8Ry+pz
         hajP3f2NZQHKcZ3Jb4dbroZKPXSxOzvxfG1qiYq9D7OOOpvd62eJwZYLfAhf5z1ecq7h
         d9uvNCej3Ra83qiur2O+TW8f1rReOclPKYVlFwSr/Z1Ta/NK24oFOsHBwzRRZqZEThxO
         1J7mkqb3xBkx4+HbjHe669NaHg0P0xfHcUFwpQokgeEz8kQUYylvpLxdg4ohgfW73uQ3
         MIFlxfBUP+4pBYdjyoCEdNb7mxPXhl5g7wdW51OriBuKLyc0qBGxBbzHnrl1j8T2wsR9
         31QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a+d88wl/YBTUB9ucZcd7ASYCnEo9o13zvTVquRf1Dmc=;
        b=FbRz7TwMfjnIUwrLQkStCxKDxmtmnZSo4VM2uKQDLek6qK7dsgqYn5hReso7u6sIVO
         gS/eJI6WACljxfDN7RVqCMCx4gGZJZ54hXZUHEdl7uZhP4RZ+FdmTzEy5YDKphnf1yQv
         sEh5WjqF3WRwiXsxgr3W2fyIhYM34P3Kd8vkKz3vkWipvv7V3jKOJIo73ZZkvnncyVWU
         wXI3tbnHhDw8TjaNAdEjwntMjHXdOTA9XZa1S9uTXMQpUhgJziFtBfBRLYKH/FCfRSBz
         LOk7GBiWNPg/1UOnc8qdfgD1lPUUCUwNZnCIy7TpNZ163eeNoI1hIuTZkhCA20/RBJOU
         orQw==
X-Gm-Message-State: AOAM531NMVDiVgQ+8BkPui8nwRq/gX27ohTKq1ha7yFn3h1qP0auW/98
        IdiYizjC98Sr1lA1MUXrIYq2Spk8LAyqwgsh
X-Google-Smtp-Source: ABdhPJz/zuWcv9OdswEH4WiFrazttPFOt5GT/0iSNVduKJ2U8b2PAQdvVyJ0beEjT7/9l1Oz9DIGzw==
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr27932558wrn.191.1620620317530;
        Sun, 09 May 2021 21:18:37 -0700 (PDT)
Received: from Inspiron (2a01cb04010c420084a8e8ad2e2ee957.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:84a8:e8ad:2e2e:e957])
        by smtp.gmail.com with ESMTPSA id j18sm16762379wmq.27.2021.05.09.21.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:18:37 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 1/8] compat/terminal: let prompt accept input from pipe
In-Reply-To: <YJTH+sTP/O5Nxtp9@coredump.intra.peff.net>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <20210506165102.123739-2-firminmartin24@gmail.com>
 <xmqqr1ijwi0i.fsf@gitster.g> <YJTH+sTP/O5Nxtp9@coredump.intra.peff.net>
Date:   Mon, 10 May 2021 06:18:36 +0200
Message-ID: <875yzrgr1f.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

Hi Peff,

> On Fri, May 07, 2021 at 08:37:49AM +0900, Junio C Hamano wrote:
>
>> Firmin Martin <firminmartin24@gmail.com> writes:
>> 
>> > Currently, git_prompt ignores input coming from anywhere other than
>> > terminal (pipe, redirection etc.) meaning that standard prompt
>> > auto-answering methods would have no effect:
>> >
>> >         echo 'Y' | git ...
>> >         yes 'Y' | git ...
>> >         git ... <input.txt
>> >
>> > It also prevents git subcommands using git_prompt to be tested using
>> > such methods.
>> 
>> For testing, wouldn't lib-terminal.sh be usable for your purpose?
>> If not, what is the reason why it is insufficient?  Can we fix that
>> instead?
>
> That doesn't work, because it insists on reading from /dev/tty and not
> the pty that lib-terminal will set up as stdin. But...
>
>> Allowing prompter to read from pipe has a big downside in the
>> production code: you cannot pipe data into our command, and let it
>> ask interactive questions from the end user by opening /dev/tty.
>
> Right. The main purpose of the function was to let git-remote-https,
> whose stdin is connected to git-fetch, get a password from the user.
> Reading from stdin would break things badly there[1].
>
> Looking at the second patch, the motivation here seems to be to use
> git_prompt() for another run-of-the-mill prompt. But the right answer
> is: don't do that. In fact, we recently-ish removed a similar case in
> 97387c8bdd (am: read interactive input from stdin, 2019-05-20) that was
> likewise causing problems with the test suite.

I actually inspired myself from the two occurrences of git_prompt in
builtin/bisect--helper.c introduced in 09535f056b (bisect--helper:
reimplement `bisect_autostart` shell function in C, 2020-09-24).
Not sure if they should also be converted to a simple fgets.
I will do that in the v2 of this series if the prompt is still proven useful.

>
> I think we might consider renaming git_prompt(), or adding an
> explanatory comment above it.

I would be happy to do that. A comment along the line of 97387c8bdd (am:
read interactive input from stdin, 2019-05-20) and a "CAUTION: don't use
it for regular prompt" would suffice ?

>
> -Peff
>
> [1] Sadly I don't think our test suite could notice the breakage
>     introduced by this function. It uses the askpass feature to avoid
>     triggering this code at all, because of course we can not reliably
>     read from /dev/tty in the script. But with just this patch applied,
>     and no credential helpers defined, trying "git ls-remote
>     https://github.com/you/some-private-repo" shows the problem: you get
>     prompted, but it never reads your input.

Many thanks for your comments,

Firmin
