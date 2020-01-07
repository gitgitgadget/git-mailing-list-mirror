Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DE6C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C3E20656
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PIDkUv+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgAGSsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:48:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:33467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgAGSsW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 13:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578422895;
        bh=Ja4gi4lR8KFvE9v4bND87wBsLMUNCiR+N/2cKpfBoaU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PIDkUv+ssTQX4n2lhQK5z+Sg2rqiklkVO1JnkIv4z4bJGPHQFtzQm0ND5s9y6hc2k
         1z1J3vzNAy+M8hIlwxWZ4PQovY2iGLKLE2SKd9b1EfUaCiRGrgQkqlEwUKT0YYHasC
         Fko6M8WNRdxp3KoUW5Hz882n/pxnXxw0TkYjak1M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1jfldO2mXJ-00rEPc; Tue, 07
 Jan 2020 19:48:15 +0100
Date:   Tue, 7 Jan 2020 19:48:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Liam Huang via GitGitGadget <gitgitgadget@gmail.com>,
        Liam Huang <liamhuang0205@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/1] Update imap-send.c, fix incompatibilities with
 OpenSSL 1.1.x
In-Reply-To: <xmqqv9pn5hgl.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001071944250.46@tvgsbejvaqbjf.bet>
References: <pull.516.git.1578391376.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2001071313580.46@tvgsbejvaqbjf.bet> <xmqqv9pn5hgl.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pg2HEGcUX1HkfBSzzR2jo8NTVpYQP7Sdc7W93lhv2JWekAUWJei
 21zvVOIiO93rMtDKIDXI6cHE/e1HvyJP5paWjYi1iEFBP7IvWIsDtRCEbvf8eTM4FkJi3Kw
 nH25S30WFfJz3/0lFZHYiMhb6wyeSNx8tGmR0Oz1UeamioYWxDD2Qmp2TKOo2X820G22QPp
 TXtzL14swSBPoXL/UB+JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GuSxNzV4pjM=:I6lEX0BLPJS9b2PkzCLaPM
 ng+D0ZnPWvbGfbiMG2jkkWY5p4E2R45W2AL1BMw8oWjINFQUNAh3UgHzTsdQd1MVsSFI6sUk+
 R1Nkj4Re7aRXtJpJWBWK/YUaCsfIFLHwLhlZGfMmdeB6QVpJ0vhDYeVKKEEFapqBiY3EDtTUW
 op639XjNl0aNyeIl0jNRuPkheEeeVPcOG5Y9CPqSwU3/63nV7zxlAlRHZ/30wU46A29fE72mz
 1Inh4TkjcVYczGOz4RL+GwlSt7Hku4En04RQqfPn9fGYWxGrS0xIyIO8tQHPfSF15udsXlUTL
 ah6A/KefEVFWBdX6m/D0+kILVMKveQSDPPX4aL1ZwJRLeWHlBCLKbMl6+44CasvL5N3H7+bcr
 D0MnQaCIq7F+sZiwxd4fdZFhRiBdoUAmeJOyIlGFe1YMUl3l5Varw+D6Pw8HzUBInarziDTHS
 mm32Ndrn/AJhUO08L35xo02mT/+7L7PCNNC4fAM8Sf8VbwBaUKkyY1bvWfjRUQ/5ZtZXa3Kf3
 KEL/lnuNdza8+rafKN7q1zT9LAPk0/vkp5JfhEKC960dStc3XF8r3p1GFgk+wnvyBVdGP9sEW
 pLhDqJZS7vUlEnqnxO3JXJCrBrkUy7uPzpLhyDPZ13MoVdFbMvcS8FkvDXLSbDiJsTVYQFfPx
 RtYs9Ow5eHUB95E/MDsZMrTEsqanyCbdv3ajpWEuVMc8nZgRvmpM7y+cGQbf6EDkZaaAB9RZF
 3IAEo7k26GMMzaXLji8YTIVk/8AwWFBYGzUPk0qMaaQDvDnxZzQzxbb7JnZQuDGQUKxVloXky
 cXpQ1JQC3YGKAUK64OvTGXyK0HbAw4XjC63v9msei+gz6PQ0bqOCYQ1yxolLs+09h0ChluRpx
 6NIsRWL+lzTzh/hUpnCZG7R3q5iZsVHtezoJve5NeHH/ZUtIZtMyGoDdHMR/jcbEu7PmxcI0b
 kX7tK0Ubf+QniEOAclEzDTEPGZd4kcVvnKZefaQFiFQyV5G9e6lvpQVBgaCwH6b5VUsSMhfbB
 TuyeLeYLDRljC6zlw6VONhUp+lDzXuHgo/8GjIzLjrszOse0/mZgDfPgEchFVCtOG9PekZ5ed
 4f2rsffbbjm4SnU3BYZ5n1E74GXz/XTkdl/k/29fAp/VxGJj23WMViJFpMFRYmFQwHG+piIwh
 AYQkYwrbRJMu7QMUd00kXPTXHrvgnsxSdenTv2BEh6MOIsbywl1wWJkIs+xULAibo6rrcUmgi
 r5Ydtk6syueLOUDsSCwywXpZ8zxutnBzdr0jmyXnjX81bu3uaPvlb2a9pwRA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Jan 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Liam,
> >
> > On Tue, 7 Jan 2020, Liam Huang via GitGitGadget wrote:
> >
> >> Some APIs have been changed since OpenSSL 1.1.0, so fix incompatibili=
ties
> >> with OpenSSL 1.1.x.
> >
> > In your PR, the "Checks" tab shows that this breaks the build for all
> > non-32-bit Linux builds and for Windows. Here is an excerpt of the fai=
led
> > `linux-clang` build:
> > -- snip --
> > ...
> > Could you fix those compile errors, please?
> >
> > While at it, please also fix your author email: it should match your
> > _real_ email address, i.e. "liamhuang0205@gmail.com", not
> > "Liam0205@users.noreply.github.com".
>
> Also, please do *not* CC iterations of a patch to me that hasn't
> seen a concensus that it is a good idea on the list yet, unless
> you know I am the area expert and am interested in seeing it.

I am afraid that I do not know of any means to teach GitGitGadget to make
that call whether it has seen a consensus.

And I fear that you are asking me to punt back that decision to
contributors, i.e. put a lot of the burden of knowing how Git
contributions are expected to progress _away_ from GitGitGadget. It is,
however, the explicit mission of GitGitGadget to _take that responsibility
of knowing all these things and not err at any step along the way *from*
the contributors_.

Of course, I can teach GitGitGadget to not Cc: you. Like, always. Not sure
that you would like that any better because you would not even be Cc:ed
once consensus was reached. So I'm not sure that I want to put in that
work for something you will equally hate in the end.

Or do you have any splendid ideas how this could be made easy on you _and_
on contributors (and for bonus points, _also_ on me)?

Ciao,
Dscho
