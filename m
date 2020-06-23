Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65966C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C198204EA
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hviJ0djS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391608AbgFWVL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:11:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:52517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391324AbgFWVLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592946670;
        bh=FS2e+w/5FnxZJCn6PdrG2lYboJZt7g1kqSrSoByIUmE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hviJ0djS9rJXnnWudQziz+GGjrr6DsKRBfSNfZk1YwtNJVGglRQk45YUXQ8xvxKnc
         4hP2Jj8vgOI69jC/GlDkI++GrvBrJMn3NlaKro/s6wgYyhcPzWgSGypb5VQVgysBxP
         tM3/2f6n+z7pzA56NhLXuZm4oqnk0mRROTv0Vapc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1jFK7k1gWc-00b22m; Tue, 23
 Jun 2020 23:11:10 +0200
Date:   Tue, 23 Jun 2020 23:11:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
In-Reply-To: <xmqqtuz9tq30.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006232309190.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
 <xmqqy2os2u55.fsf@gitster.c.googlers.com> <405521ec-aed7-ff76-5b48-70e9d11018e6@kdbg.org> <xmqqv9jvylt7.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006131645380.56@tvgsbejvaqbjf.bet> <xmqqeeqiztpq.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2006141053170.56@tvgsbejvaqbjf.bet> <xmqqtuz9tq30.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Cykg14y1wjcvNvxpOLZfBuWRDC18zqaKkcjuBHxZ/YTo4zN6DF9
 MCgtQ8lJtDkIdSLPh5r+XEytpusTx2ejEkccKtGZ+mrspqNh5//Q0Yxy/yB8fLgzIS4SlEN
 B7Ft9xsyRE1cKcyefOWq74+FCzNFfv2GG66hd1eSh+QSGiABcozx8Bxdlt3JgZBCXI+X9XN
 yQazz1+t8FnYUQV/NeuzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Mo0wZ+NVnQ=:tWThySiBLAHEra7uCCKpBn
 HaZ/6wiFoNDrJOl6OspVO7p54gjWmm72y6eEf7dOtv/rwWGMSQTM2/lVNuSJWCrQviea9XKvo
 JVSAF/qGosxFMm6Aoh1aCfc/EUkxJQdJxOXxjl5VjOLsd5DETva8zKS34PuQg0LvhrjKLBkxg
 z9u2+VjFSJk9WyYwNDaMWi52WOo8+Yz7pzXrD0K0kJEq5LS6gaynUhMDTmXygmcE5kIXrwyDE
 7DmBWbIRtiW9r+QJRJkT6v9PbQNHDUnVkiSmDdoxs7Q97HIXif6CYlLC+LM7fPQus4AeHRCg+
 bfHFShwtUkfChN8/TDIe/J7f3v4t4PFXWkoAzi+6xsnZJhK+0cpXB48d9Fo7eBFcipBXb4gOL
 8O8c09Xn4awSxwjcotswiakfxABqdOfPrxFUP0eh0bg7UoWIZTfxNx3U3MG4xEJenqx/Uig9G
 4KrgkOSyGrdFaPtyW/yFG7DhgdQizKwUE0seFNmujAb3CGeDyB0N7ZG1M6+UQROppAlbug0Zb
 kLc2ACqFC204GdSmmBnlk4X8sOsCfCjKc/nzXJua71re7HpAmb3hrIv4UmBko3O2zUPZiEl0l
 mVgRiu9gdvGlEPO5nUSnKO7a9erqjbj8GxaxQgJ9V/K/H1fl3jk8lOYf0xtI8lZV7uc4R7JGR
 /7jGJSxlzN0qK3tbRDHVpJX2JEiz//Ahnk+r+9d8XE9u5terlrBj1u8LoHTu+5O/LjYdrqOPx
 RMHKgqQ+MbBfCKMI4Kz21WVeSDOJvMuXGVgub2V2Ty1bNhKY1JBZxw+IF4W3SCiqoDC2+khKU
 ah5geberxcippNtuG4m5uB+nRLxYd6FKeWOvG/kLhX3JQnKbEKVm7KEgO3ccbDDmA1f5hdYiz
 lDYRtbIfIFY3LDJ4BihP+J/HSViftpV7HYBVuP1o033xPUnShBr3oh1CqVHYbx76fX3ztttkl
 ewIlPz1PC3iHFGZ4ifKgXqroZB/AOhW8Bf5WCkVowI8xM2XfC7pIc3r5sheuubH8wUgXft4JZ
 BLgs/Q3LQDyjqDjv8iDfOQ2On79flKySgS+HpItpx86qzHiDylKI4HVQqy5hqsLfnhO3zrQMz
 LwIlNWttyTl9qUap4Q+wVs7MVp4ovaRrY5lKGHwXeAEuRt+3TgEXNxfubHrkguUaqESpdpt43
 z2PTx3UZRqez0orh/o4ftoy1t4dvPlnMUZoJNxG5GxzwzPI0m+a0flp1p3EnCkRa+bdHd0K6a
 ad5/5y/SKqnzZIszC
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 17 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Yes, the trouble with `maint` did cross my mind, but I try not to
> > "overfit" to git/git. :-)
>
> I do not think it is overfitting; if the solution cannot even
> support the originating project well, there is something wrong.
>
> Most likely, I'd be tempted to rename it myself away from any name
> that is too similar to 'maint'; perhaps to 'stable' (or 'devo', h/t
> tla ;-).

You could also use `next` instead of `master`, which would make intuitive
sense because the commits that make it into that branch are slated to be
part of the next major Git version.

And a relatively obvious name for the current `next` might be `cooking`.

I refrained from proposing this earlier, thinking that this would be too
disruptive, but since `pu` was renamed to `seen`...

:-)

Ciao,
Dscho
