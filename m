Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818B4C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 12:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiAMM2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 07:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiAMM2p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 07:28:45 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB92C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 04:28:45 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id d7so14427724ybo.5
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 04:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MirZ7fkmplO5yCAH0nVUn4C4l01puRYnqX6iexJzqdg=;
        b=SRFEHmIA/IRXZWuUvJM63O8rkp/kXWW3nXCbksTnaNmTceObKwsKoipse7m/p22wyr
         k4xrG8E1quywW6wKs5XIcy5rQJ9dzLJ7IiCh30yd31BEwbPZ/dNfQ+NE9kJMdrttWzQF
         7KXXnL2UagpnpCghfwLJcDNCLuwo9srev5ahkJM3EntQG+SgTw5z4hnbCyziSh7OCyJF
         U5Zs1VWB5NG+MDbKiRSF3AwazUdYLBo2JpwANpAx3AhMbpTmhGpQEfgkWEVu60GEbT19
         ODjsd0BHKPJ5JrA9izWvXyS3RRZt3CWX1FfyCBAdjfxYvZ/yw68haJ1lQt4sv51fZ3Eg
         3bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MirZ7fkmplO5yCAH0nVUn4C4l01puRYnqX6iexJzqdg=;
        b=Knu8GDMzcx29yJxP+OjXW62n1nSuYs7DqusGVMfqLOIjyuFzSONnL4Z97+0z7zmkaV
         ytnXqqzzG/GqqIHUdzyvgaZUAWOCMAZgxs0akZHUIHGYzK6RbEYWkYIWB6tTCDMrIu89
         0ZTGQz4sZuiF0/ZoIRFUdZ/IXQO9tJpBWN39UNQ5TbJTzy5KTAl0wg1QAG5y9mI8Z1YA
         /9cVPOXdHZbaWKGjWX188FTw5SBJdoNGsvtW/98MhkKw4IcHg6mdczvyjdYxps33DN3B
         HvL04R3nmKy2OYcldNqFxwVTxDQiByZEyi2ftWmcwL9+mwM/P5bLmHIrN7wPjJmHhyfQ
         dtRg==
X-Gm-Message-State: AOAM531L6P/3gIX+ERv4sYYlHvrNdPKm+qrhoTOAkfqe8/Ptd+fHfyUR
        fDZkNygEZ/s+Uc3XW0V3Z7R/6ctexLm0F8gnw8M=
X-Google-Smtp-Source: ABdhPJxM02VEECWG7BwE0YmKX8H7pBz8QwNFatm3UKkyMPyM+8JbCev0xBrSeIFbSvU7M4dc1di9ChwdSp5MdSQY2hI=
X-Received: by 2002:a05:6902:1027:: with SMTP id x7mr5782103ybt.427.1642076924228;
 Thu, 13 Jan 2022 04:28:44 -0800 (PST)
MIME-Version: 1.0
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g> <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g> <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
 <3dade45b-494f-663b-264b-06a51ea1cf56@web.de> <xmqq35lsyhbf.fsf@gitster.g>
 <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de> <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
 <421215c1-f6ae-4ec2-b666-2a481056ef79@www.fastmail.com>
In-Reply-To: <421215c1-f6ae-4ec2-b666-2a481056ef79@www.fastmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 13 Jan 2022 13:28:32 +0100
Message-ID: <CAP8UFD3tyBhrOQzg9j4qDAT0Tb8TCTK0=J6ORsiLVuMWn+W9wg@mail.gmail.com>
Subject: Re: git bisect bad @
To:     Ramkumar Ramachandra <r@artagnon.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, "Miriam R." <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 10:32 AM Ramkumar Ramachandra <r@artagnon.com> wrot=
e:
>
> Ren=C3=A9 Scharfe wrote:

> > Reserving 126 and 127 shouldn't cause too much trouble,

I don't think it's a good idea at this point to reserve the 126 and
127 error codes as there might be existing scripts relying on them to
mean "bad".

Perhaps we could introduce a new command line option, for example
--bad-is-only-1, to specify that the only error code considered bad
will be 1. Or perhaps a more general --bad-is=3D<list of ranges>, to be
able to specify all the values and ranges that should be considered
bad.

> > but there's
> > also a way to avoid it: bisect run could checkout a known-good
> > revision first and abort if the script returns non-zero for any
> > reason, including its non-existence.
>
> I can't say I'm overly enthusiastic about this trade-off. I think
> most people would check their bisect scripts against the good
> revision by hand before starting bisect: why introduce one
> redundant step for users like me who tend to bump their heads,
> because they're a bit rusty with machines?

I also don't like introducing a redundant step, unless a special
command line option is introduced for it.

> Again, I don't know if this is a good idea, but if exit codes from
> the shell aren't standardized, surely fork() and exec() would have
> a better spec? So, perhaps remove the little git-bisect.sh and
> rewrite it in C? I'd be up for this task, if we decide that this is a
> better way to go.

There has been a lot of effort, especially by Miriam (added in Cc), to
port git-bisect.sh to C over the years.
