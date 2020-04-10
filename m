Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3EC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFFD20A8B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fIWYDx4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJODa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:03:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:45787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgDJODa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 10:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586527406;
        bh=WPN8laQohtVfwVj3b2Td6Lw+GeI8FCS2A//SvdK6eEg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fIWYDx4L/q1RSmE8/7gqL6Rh2AjhlpBnPhcTsF2MXzYtlEIAHOUZ1U8scI9c1KWG8
         eBwQhQf7U2xWzzbsrH4uKFf/72u+vIgeB0BxDqR1I4e6nc9Qqt48ZNpdjd38vX/HfB
         fQZ+46QmMQR8UuhWlotJAl3snFM/t/5WqSwxQIPs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M3lc9-1jNjbB0hgh-000vcK; Fri, 10 Apr 2020 16:03:26 +0200
Date:   Fri, 10 Apr 2020 16:03:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH] clean: explicitly `fflush` stdout
In-Reply-To: <20200408201454.GB2270445@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2004101602330.46@tvgsbejvaqbjf.bet>
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com> <20200408201454.GB2270445@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VEyceC8ilFa9QlUi6w3Xqxwt3u6VJvcj5jqssGbMRCvN00zs343
 fC8+id4Xhd46EDWoPXfDXWrJCtJ0WyXpnoCGPoiLBYpffzGVh/Iv1iRgvNAty4DPl+KtFOb
 pUvEIp1BInPBWXRqPd9X+Nupd667xjQE6SwbP6SUJ+DrLhUMb18ufMqSuSwC9g86byCjnq1
 PT5AWq2YMLxgpKov5l0Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HUOTujCJZYE=:R9PenFkTV2cO1gUkyKfTYm
 VRn9SkhZMW+GSQW9X356WJcaAIzGvpWoR+yCpvx73tAHEpeNd8M4qUzE+PaCzWTayL3mxNaS/
 EEUNSOlzMijRrpNhjFbECSFfzRY0x/LcsTvc1XAOZbs8ZtgEr/hqtaXIvOXXGQ4d4qwFsrb2Q
 StF8WN0hVHIw5CcYtduyhSOV/Qb9Q5KOjRaGYVMNU8IU5o0OrgkSiG+Ii8+qgfxtmbopeCFgd
 BRAjm3dn0MCu1+kILN5GHjgS9OzUobw2ZYKu+icvp7GU+3+ASP8p5mJiGY+t6ZLS9EM+5pmyi
 MdGc2X1Y8UK3lRAPyQuCAHNAX8NsUdSmVC8AAD1L8IOOtuitqDvqg/BKCF+6KA1hvXGxfqgib
 jh18pNfatOCC/q+kOFdjRiJWolkqG7GlAmpXnTLcec0NJm84ThRgsTQwtaj8GNlEdrBtJtjua
 GlRi0EVEDTppwJlpWm+NZ5gVGVIdU6vG9JB9S5Ex7Kf6hriY+CCMct4sFZbm9HPieCBd98m/x
 pVGEVZ9TQlloSaekWQChO3ftGZR3QEKX6GBU9zMJds/JTnBXPCZmSq92RP+DwGN8lIBb4zb8C
 05b7t/UJrldLFRJje+n4krLV+oA0oXoWawE47Uhum9DrpexrsrYklLKcmNFkyPPHAuCeDFhuv
 0xBgYDEnUdSFiag05INGP+jaohaXLWp161cmqWBBgFZxxN8KKCMtHrYOuHspaAsA/cv82ZFfH
 OtyWqCJOhiIeAsEjC3LQEz0FYFY4MVt6ym8u6w0XOYyUZxQsy10hc3OOKqcTP0eL4l0nGIGp9
 YODF/YMLpQ0datOrgW7W65A5M5f9EmCcQ6NEsADzgOUl/g1u+3tgV6nzYYB49ab+/Usylz/Fq
 q2IWYiYlza7NkZEvOLHjTWyajsFrzlbJT7VOY8lXw0fB+1OqlKxEVlUucF5MCVBt9ILHR/6+g
 leOxnrPWnkNXK5EWfAOD0XUbMPh7xit7d7WTpXoVQEcawUTHlRgCr6qAjuo2qlyJ6/+Ch8urE
 +krKaWvYYjHCmUxkWMPfnVz16ctjcQf6XtZLPwhCJtjHr5QevDS3TV/ispN6qrxri4y8lIMnn
 iOIfZFEWWizgpF8ow6WXdKPCwH60vydg+l6nrZArIJ+jLzP4P/YEtmW9gX23bAcvP3NsGRfA/
 WbSdUIgyaJuQhveb+3nlPjCv91EzzTffZLG7N3ju/usY6AFG45l6CR9/bDD2cyLMuPxc0ufbj
 m6eAhRJ+YpuCLsNWC
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 8 Apr 2020, Jeff King wrote:

> On Wed, Apr 08, 2020 at 07:33:00PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: =3D?UTF-8?q?=3DEB=3DA7=3D88=3DEB=3D88=3D84=3DEC=3D97=3D98?=3D <n=
alla@hamal.uberspace.de>
> >
> > For performance reasons `stdout` is buffered by default. That leads to
> > problems if after printing to `stdout` a read on `stdin` is performed.
>
> This first paragraph left me scratching my head. It's only a problem for
> interactive uses, right? Would:
>
>   This can lead to problems for interactive commands which write a
>   prompt to `stdout` and then read user input on `stdin`. If the prompt
>   is left in the buffer, the user will not realize the program is
>   waiting for their input.
>
> make sense?

Thank you, yes, that makes sense.

Based on another suggestion of yours, I did refactor the code a bit more
and already sent out the result as v2.

Thank you,
Dscho

>
> > For that reason interactive commands like `git clean -i` do not functi=
on
> > properly anymore if the `stdout` is not flushed by `fflush(stdout)` be=
fore
> > trying to read from `stdin`.
>
> I'm not sure I understand this "anymore". Did the buffering change at
> some point, introducing a regression?
>
> > So let's precede all reads on `stdin` in `git clean -i` by flushing
> > `stdout`.
>
> This (and the patch) make sense to me. It might be worth factoring out a
> "read input from user" function and putting the flush there, but with
> only three affected call sites, I'm OK with it either way.
>
> >     This is yet another patch that was funneled through a Git for Wind=
ows
> >     PR. It has served us well for almost five years now, and it is bey=
ond
> >     time that it find its final home in core Git.
>
> Agreed. I guess it didn't affect people on other platforms much because
> stdout to a terminal is generally line-buffered on POSIX systems. But
> it's better not to rely on that, plus it could create confusion if
> somebody tried to manipulate the interactive operation through a pipe
> (e.g., driving it from a GUI or something).
>
> -Peff
>
