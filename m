Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245CAC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FAB20663
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H0rt9b8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbgFWVHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:07:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:43695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391397AbgFWVHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592946450;
        bh=NGVM1F/lYYWDEYfEGSdUVOv389dsyAnjTygiIbXduYg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H0rt9b8hFauOU/zZA8I8fmKEZpjqNTN0ck9i3aFp1QUvViSEt1f574MsscJgYpEuC
         b4jad9572bY2yAb8WjCfPX21qhyS8iCfDFvvWRz0qw9ERFYgHMkYMSzFu8zUF3N9QM
         LAQq4x/RuvMgaBJH8QfJ52XN9SKeXRa5BXzW8NJ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1j72g93YoO-00jFBo; Tue, 23
 Jun 2020 23:07:29 +0200
Date:   Tue, 23 Jun 2020 23:07:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 12/12] testsvn: respect `init.defaultBranch`
In-Reply-To: <20200616135121.GJ666057@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006232305160.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <e09f857f06857fedc46b91bc918486f34dde8b02.1592225416.git.gitgitgadget@gmail.com> <20200616135121.GJ666057@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uUelMmodrsV8ZzxdeN7NXodGtZYnowBv1Ya3Su9ugtlUswmvrbm
 UBjB7OTjD13tqv650Iy37Wi56KQWchf01GY+xmHc/jDAmu47ZbndKwOLQ8u6T6iri694GUK
 Zw/vgo/cUYGB538fXFatHD0q+j0bP6u96Qwyfh0Pwa3Dtl0YkOxv1e0AXhA5E9R5fJC9tQ3
 6zqIx7gnn/1mxhaqv2lVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ka/uw8uARjQ=:S+EQ7THiBmtC1FS8XrBHal
 phOy4rSqA91+XkiTKgAi7unhjEgIC3NFGx6VXXl14gs5HEY68ylqmgQVfUohlVeaRU9DSvHJ/
 4VBhvwf2Zw/0JrwOYaoxUCGUZuyoBhwTTu/NK4EcULEbuUEdcdAWjS3cWx2lhSR8nybENQMSI
 VXrNi455cuvbXKZL5koY6ROJabnKnh+VVRktQ+XEnL5JlnMmQGl+sILfj6qHF9np9inYimXLs
 rmMO5p6jDWJDJ2EIrUS441/Ditf2vhvMC+NbWHZ5u0bxAquP4w6iMf1ZL/QjxCGX0nifJqiko
 gCmXrWpk6E2GUFeBgXZlXmdkeZj8UvmczKjdVSEPW/dIzfC1xGl5KIMHoPnQIMhPlnR0eojnC
 HuNSCnr+ln26k1m5wnRxwCF3sLbICU2gMmyZq5dOtnAKswLdnJ8D000TnxFmBJB4t47g60Ttf
 mwP8+hnPcQNh9bA/OKf7/8mKeHB0wvEmofQ94dyINEX8vNfjm3IAj6nfKpmVn0cHoin4tIM5q
 K7qO8f9oP+tk5u1BcHIhhtLReXnHYCMRBchumG6Q9FCwnzVhjH+6gWEm0JZxSB7usE0qilLXr
 ZYRfvs4maqjbIFQ3Tm3Vr1a6AAVYF2zxhBxQq6z2FuiKkOfx8ft02+29koiydbTkIKhds/yat
 4S+zclhiKZTO+DVBa02XGRZEwqyDPiOTieBdNfrEoqaIOILVFjw3l+cGTF7+iJ07KKf1I9q+Z
 WYYpt22N2GaW769ziUb9jkQcMZVqYaSMR8cPYPsPfhLaxF+rGVDpToOU9udrb4jBS61rNAvnc
 EMTOimY3oKVvfjkciXqQ+FBDS5vzPjVPrbPMC+PZtiFtRhrKmr0QOvUBR9OXeArJjuwlSjtHI
 vY4fZN2rlJeqcLIfLYMtZnGHhx+rcE2qZGveYPMFOQFRJY/Rq3YG7lFKredRsbM+Uf8jbrxcF
 AhR8m7ZK3Nn1/bu/VW27G/ZsJpgUejas3IwRXsfddTkmt46lW7WiPQEQDetkKjU9gIDPU0n5E
 u0zXb4P5pBJyfRsdxlBx8CiJlSNliSnH/wWmWlHr4X8rC66jDc2DbkzHjiBkIgUlIGtCieAV9
 IbWsyYi8y615WAEUjcEo9X/g4eP4BX/qnQ3BB4ZLy5+NKDD4g1VaW6On/n7g5HzI8visNy8hW
 l8+U/XDsPFLnLWJ5zKBORp+R+vHex7vCv+qni4VeJN93+RSnrsunUYVTQ82zw5U5N/d0g5eab
 ZdzWOiatdQbJV3vzq
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Jun 2020, Jeff King wrote:

> On Mon, Jun 15, 2020 at 12:50:16PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The default name of the main branch in new repositories can now be
> > configured. The `testsvn` remote helper translates the remote Subversi=
on
> > repository's branch name `trunk` to the hard-coded name `master`.
> > Clearly, the intention was to make the name align with Git's detaults.
>
> s/detaults/defaults/ :)

:-)

Will fix.

> I'd agree that moving this to Git's default name makes sense.

Okay.

> Though my overall preference is still to delete this whole testsvn thing
> entirely (I have some other pending tree-wide changes that are being
> held up by it, too). After getting "would you mind holding off until..."
> from Jonathan in [1], I've been waiting almost 2 years. Maybe now is the
> time?

I wouldn't mind dropping `testsvn`, seeing as there are fewer and fewer
users of `git svn` (and even those are unlikely to switch to `testsvn`,
should that ever become production-ready).

Having said that, this is an orthogonal issue to the purpose of this patch
series. And I would really like to get this patch series into a shape that
can be merged down to `next` soon.

Thank you,
Dscho

>
> -Peff
>
> [1] https://lore.kernel.org/git/20180818052605.GA241538@aiede.svl.corp.g=
oogle.com/
>
