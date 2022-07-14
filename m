Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52853CCA485
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 10:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbiGNKPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 06:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbiGNKPB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 06:15:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB6E15815
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 03:15:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sz17so2522554ejc.9
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=m+vmtZrC78QMsOHlihqaZOdKtcANrVbrOM4o9oouReI=;
        b=FY8SWIlH4lpbHElQpPDIzBLysMt1P64VKbiR3S3z8ftDnsQakiaihBqkSRKlxaDy0x
         28KfWQ+uCOgcwNo/s9K904DPc0B29zORRedsisZBV1oOTpYIMO9PD2QeAZemAy0Tj2Gv
         8f7qCurvlqi6lO24g5i3bcf/hCalA5ms4VIAyvijpdJ3c2/fsi9CyCNK5dO4Ufm+AXkt
         tTEUPNawTyoXFBSTViSlnDvKrboCyT1cIM5kEnyv9tOOxi20snW/E13NbRU5ugBcpBuV
         zX5RJGZTsDdt1mcDoplnr7Hhubu1Se8RCCGrsdhm7Q1AQsSrOC8S9vBieJszfGa59D+g
         xdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=m+vmtZrC78QMsOHlihqaZOdKtcANrVbrOM4o9oouReI=;
        b=UnLSAlVy8SY3YlAhFi7VQ/GlY7WOwzg/R52jl5dSGtafjBTNBXfUF73hbO0NPstGR/
         OcKLD6gxg/+2Gz1/FH+YuuJkf2tq6jt4hXpT+eQnlJA1ElTYCb2q1bFDmDu3Bwd4iwBm
         Ql03rKPWmhJYr2lpL/oYrfN8YwIzCl7IHfcTTxW7MAMH1rCoMH7zoRWC8geHBf9dhQwI
         Pl+abFTm7XuzigfF3tdY5ryYbniAl4TkSGROUN9XmWapT5u7nUCmo2+Y8Q4tAfpEDzaL
         Nz+96uJvVdxvkBOSpH7N0v8J2zPwo7SEWj6MYYyGBR9HA09mI63Y3V/1+HgKxP2Z/yJy
         nKtA==
X-Gm-Message-State: AJIora8PmHgnJ2aDOFWpwo7rQbCCL2reQEjT7zYts/mseCmz58rIXX6+
        5hIuu/Sw0OuRcB236tL3OLGEBsjM6Hh6mg==
X-Google-Smtp-Source: AGRyM1uioO3BCvA9og5yZSb+VYvHYCSx0xy1U6s2t9cj9dZMISDh2+5z1j/hubE02Eh077DdjHXhPQ==
X-Received: by 2002:a17:907:7781:b0:6fe:4398:47b3 with SMTP id ky1-20020a170907778100b006fe439847b3mr7972953ejc.513.1657793698850;
        Thu, 14 Jul 2022 03:14:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709060a1700b0072b2378027csm526053ejf.26.2022.07.14.03.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:14:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBvs1-002CJS-G0;
        Thu, 14 Jul 2022 12:14:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Antonio =?utf-8?Q?Caba=C3=B1as?= Zurita 
        <antoniozurita99@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Create Remote Repository from local
Date:   Thu, 14 Jul 2022 12:11:01 +0200
References: <CADxQiQZR2pM4F3vizq_HyM6xeZMRHstNHPk2rXuux7LgqWkUfg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CADxQiQZR2pM4F3vizq_HyM6xeZMRHstNHPk2rXuux7LgqWkUfg@mail.gmail.com>
Message-ID: <220714.8635f42e72.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 14 2022, Antonio Caba=C3=B1as Zurita wrote:

> Hi,
>
> I'm setting up a git server, but I've run into a little problem.
>
> It is possible to generate a remote repository on the server from a
> local repository, or for this it must be created on the remote
> (server), regardless of whether it is by cloning or by remote add.
>
> Assuming that I am in a newly created local repository I have tried:
>
> Do a git remote add ssh://git@git/<location>
>
> And I have not previously created a repository in location(on the
> server side), it returns an error that it is not a known repository in
> the destination.

The default local git client + server setup does not automatically
create repos on the remote, do you mean that you'd like to "git init"
locally, then just have a "git remote add" on your own server create it?

That *is* possible, and I've worked with a server seup like that, it
just used a git-shell(1) replacement to intercept the "git upload-pack"
command, i.e. you'll get a /path/to/repo.git" argument, which you can
just intercept and "git init" that repo on the server, then serve the
normal "git-upload-pack" on that newly created repo.

Using that method you can:

	# locally
	git init r &&
	echo hi >r/file &&
	git -C r add file &&
	git -C r commit file &&
	git -C r push <some server url> master:master

Or whatever, and have it work.

But I don't know (and didn't test) how that works with "git remote add",
i.e. if the remote addition will expect a remote branch in some sensble
state on the remote.

So I could see how you'd get into a chicken & egg problem there,
i.e. you'd want to find the remote state, but your repo hasn't been
created yet...
