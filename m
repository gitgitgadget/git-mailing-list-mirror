Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBB6C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 00:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhLRAQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:16:06 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:52042 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhLRAQF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 19:16:05 -0500
Date:   Sat, 18 Dec 2021 00:15:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639786562;
        bh=OGQSyspD9yZqmsM/8U3uGu2Yi6jVRngpA7fLM0Ac/K4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=pGy6U7uH4dyeGcdBUM6jrpWpu+tDlJb8z8bhIKu0+n/3ypYW7WQIuqMaeMmFXxhyV
         3YOEltHlMK73WcomDhP4FPiN7sm7vcRnlAymxWAH2eZNW55p4CZipuGxwk3yvQ2sa/
         HphGOk9qDiAtIgmJe4j6upfIHjdsTNiuRUqWGtEitSxpQxbqfkiQprPBYGdPqVGAIR
         ws28Qm1NL3SYGZeGm0IuBbrf6AkEZ15fctRdOcH197GgK7hygiqNAFMEUrbRLa0+5S
         zkbhmc02OV5gesqwE+9sM+dWaLpmPJnpqCN+SsS+7MwZC60zBs4u0UXVB32jXpFhRr
         UaenXjHMpCE2A==
To:     Martin Fick <mfick@codeaurora.org>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim@protonmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim@protonmail.com>
Subject: Re: Fw: Curiosity
Message-ID: <1X3gQ48NK5aBDHcpYMlxESRjqubcCBKJUQu2K0dBOnTyvsXCXXoGDBg2Ff4KarK6WsZnzN3HgqHGOlCKKdF-wtZQ5tHsoAcfit2CTXMWqh4=@protonmail.com>
In-Reply-To: <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com> <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com> <xmqq8rwl91yf.fsf@gitster.g> <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net> <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com> <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I suspect that for most algorithms and their implementations, this would
>
> not result in repeatable "recompressed" results. Thus the checked-out
>
> files might be different every time you checked them out. :(

How or why?

Sincere question.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

Em quinta-feira, 16 de dezembro de 2021 =C3=A0s 18:33, Martin Fick <mfick@c=
odeaurora.org> escreveu:

> On 2021-12-16 14:20, Jo=C3=A3o Victor Bonfim wrote:
>
> > > To expand on this, if what you're storing is already compressed, like
> > >
> > > Ogg Vorbis files or PNGs, like are found in that repository, then
> > >
> > > generally they will not delta well. This is also true of things like
> > >
> > > Microsoft Office or OpenOffice documents, because they're essentially
> > >
> > > Zip files.
> > >
> > > The delta algorithm looks for similarities between files to compress
> > >
> > > them. If a file is already compressed using something like Deflate,
> > >
> > > used in PNGs and Zip files, then even very similar files will
> > >
> > > generally
> > >
> > > look very different, so deltification will generally be ineffective.
>
> ...
>
> > Maybe I am thinking too outside the box, but wouldn't it be quite more
> >
> > effective for git to identify compressed files, specially on edge cases
> >
> > where the compression doesn't have a good chemistry with delta
> >
> > compression,
> >
> > decompress them for repo storage while also storing the compression
> >
> > algorithm as some metadata tag (like a text string or an ID code
> >
> > decided
> >
> > beforehand), and, when creating the work mirrors, return the
> >
> > compression
> >
> > to its default state before checkout?
>
> I suspect that for most algorithms and their implementations, this would
>
> not result in repeatable "recompressed" results. Thus the checked-out
>
> files might be different every time you checked them out. :(
>
> -Martin
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------
>
> The Qualcomm Innovation Center, Inc. is a member of Code
>
> Aurora Forum, hosted by The Linux Foundation
