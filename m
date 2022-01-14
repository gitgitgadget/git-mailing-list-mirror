Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ACCC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiANIEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 03:04:25 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48645 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232067AbiANIEY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Jan 2022 03:04:24 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E22B75C00AF;
        Fri, 14 Jan 2022 03:04:23 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Fri, 14 Jan 2022 03:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=jlbL6
        ToZyzB4yDAoqDPOmrEqGFlj6FpsmDPrrVuVYhs=; b=Onf3mGuXh+3qBT7i16O8M
        nd1tVu4g8ZU8GgqUW1flfp8jmKcIiNyFFtwTYWYor2tm0itLZoqoC2PiAQlJGfxz
        dM8SSlzWRlxO6HTubkUB2zEbF9h7Qa2XWj3v0HlRdlzrpbF6wYSIaYKdQFSRehpg
        2Kx/AdMpG0ehvguTTRqH8H29a337hPOf0HeECZ7YUni2qOKPXRLOFywaChzUl6QJ
        Ds84ff1C2yE9NEUKeom+UXugJ98fThWiMlcxlGYxfqYG2zOWn8qmgHKche2z5YI4
        s7K6X+suU9do3p1aO6UzJKLBusHHzLh2vJ20/b0KaZy2PqBI1leumJaiQj8F4uBp
        Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=jlbL6ToZyzB4yDAoqDPOmrEqGFlj6FpsmDPrrVuVY
        hs=; b=R8AOTFeAV81N8wLMlProgtwil9RzKV+xdyzLpaeTX5EI0ZqhK2KQuMStd
        uUIafxmPIpBQnL6x4uzsTaSOK4YDjkIxHeih9OdXzcriLz9A04wG7ktTVL3cbOxI
        uCFd2QBl4Wu2xfT7qyABNKslLkRJxJHGJs8GmSTC5eZ1i7Wm84oF9H+oSv92obcw
        mWr1ZaJtnDfd2aI6VbXWohGlIh0ie6e3aSwLEkgjv9QwY4qVQWsxbIS8JDATfHLd
        qzxfzJrpwvmVt/2CodvuXNmeG0KIduvmjzRYpuJ9ZPWh9vG8FAkCELvJ/N7YK7hW
        SnydbOcuJJUG/QQkZFmXPHtG21WsQ==
X-ME-Sender: <xms:hy7hYUbgFfrJIk2KgxPR5t1zPIndmHnjbbfdYmnlpfPsWInAvNre8Q>
    <xme:hy7hYfZ9Td-yB1aFHkPGk5TCfBaBBGzx0hneJSXcJLZJ5ZICcu1nKZ5j9WFEH32fu
    FXP-mS93sTPwC2sdCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdeggdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftfgr
    mhhkuhhmrghrucftrghmrggthhgrnhgurhgrfdcuoehrsegrrhhtrghgnhhonhdrtghomh
    eqnecuggftrfgrthhtvghrnhepkeevueekieduleekgfelteduheffkeegveffheeljeeg
    keevteeiteekvedvvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprhesrghrthgrghhnohhnrdgtohhm
X-ME-Proxy: <xmx:hy7hYe_9UR3L3etKgqivCN6dH2s27wmZXsOlTJ--sTd_aVN8r4BVow>
    <xmx:hy7hYepERcXXqDfuCqGg2HMpL1Qs2Q6ZzyjE0oc8RKxCqanVmeSgeg>
    <xmx:hy7hYfpXZOowAozBcVz4nFbtqLil_1uNvRWt08BGgGyjOkVirgDGfA>
    <xmx:hy7hYW2qgEOhcpJHGCpp9lQi8BaLcPk-zUbVSY6kEEibMf-TaEPoDw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A91B01EE007B; Fri, 14 Jan 2022 03:04:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <e90803fb-00a1-4575-9a8b-8f7fed7f5e6a@www.fastmail.com>
In-Reply-To: <88899d16-5e3e-2bb2-07e9-59f7607c91a8@web.de>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g>
 <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
 <3dade45b-494f-663b-264b-06a51ea1cf56@web.de> <xmqq35lsyhbf.fsf@gitster.g>
 <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
 <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
 <421215c1-f6ae-4ec2-b666-2a481056ef79@www.fastmail.com>
 <CAP8UFD3tyBhrOQzg9j4qDAT0Tb8TCTK0=J6ORsiLVuMWn+W9wg@mail.gmail.com>
 <8bc73981-589e-20e5-247b-2f74e166ae1a@web.de>
 <925ef53d-c8b2-4ef4-acee-490900e8a3b7@www.fastmail.com>
 <88899d16-5e3e-2bb2-07e9-59f7607c91a8@web.de>
Date:   Fri, 14 Jan 2022 09:04:03 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Christian Couder" <christian.couder@gmail.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Git List" <git@vger.kernel.org>, "Miriam R." <mirucam@gmail.com>
Subject: Re: git bisect bad @
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe wrote:
> Using the shell allows the bisect run command to be any shell command,
> not just some script.  E.g. you could bisect a build failure with just
> "git bisect run make".  Quite useful.

Ah, that's quite useful, yes. The problem of improving user experience w=
ith bisect is getting more and more hairy. May I suggest something tract=
able, albeit not too elegant, and certainly not perfect, in view of impr=
oving user experience in common use cases?

1. If argv[0] of the supplied command is found in $PATH, check it for ex=
ecutable permissions. Otherwise, error out. It's highly unlikely that th=
e user meant a shell builtin, which would supersede the executable in $P=
ATH.
2. If argv[0] is found in the current directory, prompt for "Did you mea=
n ... [Y/n]?"
3. If checking on merge-base fails, improve the error message with "Perh=
aps your bisect script is broken?" and reset bisect automatically.

Warm regards,
Ram
