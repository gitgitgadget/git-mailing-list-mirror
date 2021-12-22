Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CBC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 17:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhLVRxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 12:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhLVRxy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 12:53:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09022C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 09:53:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so11657329edd.8
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 09:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=w5vWSu6y/Wl12Wmg7ks9KZZ/RgC3Im6+JQFeQnkd5f4=;
        b=kLhVlmSmv6XDTFlsLhXdjCagb3L8yQ2At8HKKtNLkRsmve90lE0v2gUam9zEaWqj4A
         hDSx3VE2fh2oSZg9t/GZcM8F4ekZhvuV4zeU4s7MUd+5Nv7Vz26/kPenxu8Pgqfm9BLG
         NnoKctYQ1ZdyGSaakgvjUXMlLpGMo7BkjDhHp2S2h9HaNvyCRsBai3kGi1UL3bI/Sz+2
         u92xpKUqQ+PjU+7Z36NomZuWxtZgV5crTj07yYEqY5zdOnEIXypz8VX9G6Fej8TZ4nQw
         Q+qyvmWje4DfvyeyG+NMfPg4K0KEBijEfQSURHpFw2D8z1EUvX1rKHvZI/GA52oXFbOE
         ExAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=w5vWSu6y/Wl12Wmg7ks9KZZ/RgC3Im6+JQFeQnkd5f4=;
        b=RD29hMPgrr58XayUNpWZAwWxfW2J9eLvvWJXjb8PPLoeLywEhWohrYT5O5ZbeyB+6R
         4p742PFtEeN7E9ObAx00rQIe3kY886zyrEtzyJ3tO2AZp2q4aBcf8cbo07gCR9oaljD6
         3VWe/ICqCCJ/qZtpHPFbAoHpdALNf5p3mlwHei84NZARyndqrJTS/Su9hSwlcsC9UwAW
         o6qWBDs2I7DyCcQeWsUrjkvNq8fCNY7n3kbflk4BrFe0AFR54GLfMmxCeijumKcWgNmN
         pZv82vfAAvJImRthytfP4StsBXzHWsAeOGIuIrLY/FnXIsqMRvlDz+ktkCmJoXFIUj5N
         hw7Q==
X-Gm-Message-State: AOAM5304jjT0YH4dyTO1nD4HvUUmrW55vGjZcdt7QwZTLJt44+0ABJBJ
        Vs82mwq2S9F6ExDdFl3orKd2PGDnucVhWA==
X-Google-Smtp-Source: ABdhPJz7wjejQsqakjKdG2GGVdU6y9WgrWJpI8yDF+qcwlfJsWS6mh8FQSERqsNOQZCI9qpZOV2Jfw==
X-Received: by 2002:a05:6402:148:: with SMTP id s8mr3855025edu.221.1640195632458;
        Wed, 22 Dec 2021 09:53:52 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s26sm943787eja.152.2021.12.22.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:53:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n05oF-001AdK-0f;
        Wed, 22 Dec 2021 18:53:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
Date:   Wed, 22 Dec 2021 18:44:38 +0100
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2112202324110.347@tvgsbejvaqbjf.bet>
 <211221.86k0fysm0i.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2112221640340.347@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2112221640340.347@tvgsbejvaqbjf.bet>
Message-ID: <211222.865yrgplu9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 22 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 21 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Dec 20 2021, Johannes Schindelin wrote:
>>
>> > On Sat, 18 Dec 2021, Sean Allred wrote:
>> >
>> >> I've got a custom subcommand I'm distributing in my company to integr=
ate
>> >> with our bug-tracker. It's a pretty robust utility and has its own he=
lp
>> >> function, but running `git foo --help` doesn't pass --help to my git-=
foo
>> >> utility. [...]
>> >>
>> >> What's the best way to go about this?
>> >
>> > I think you might need to be a bit more careful than just looking whet=
her
>> > the command in question is a built-in or not. It could be delivered as=
 a
>> > script or executable inside `libexec/git-core`. So maybe check that,
>> > something like this:
>> >
>> > -- snip --
>> > [...]
>> > -- snap --
>> >
>> > Of course, this might break existing users' setups where they ship a G=
it
>> > command together with a manual page.
>> >
>> > A potential remedy against that would be, as you say, a config option.
>> > Maybe defaulting to the manual page if `help.format` is `man`, otherwi=
se
>> > defaulting to passing `--help` to the command.
>>
>> What are the cases that require us to inexpect our --exec-path at
>> runtime, as opposed to having a list of commands we know we put there at
>> "install" time?
>
> It is a simple solution. Why even suggest a complex alternative, I wonder.

You're suggesting the more complex alternative.

We already have a way in that same file to dump both built-ins and other
known commands:

	git --list-cmds=3Dbuiltins
	git --list-cmds=3Dmain

And isn't your is_in_git_exec_path() basically a re-implementation of
what we already get from:

	git --list-cmds=3Dothers

?

Hence my question. I.e. if you don't have git-send-email installed why
would you take your is_in_git_exec_path()? I.e. start treating it as
"others" would be treated. We know it's ours, it's just not installed at
the moment.

But those aren't the same thing, so either you didn't know that we have
this data already, or the difference is important for some reason you
haven't explained.
