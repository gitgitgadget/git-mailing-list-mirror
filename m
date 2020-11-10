Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94173C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214CC2068D
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Km/phAFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgKJPrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:47:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:52487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbgKJPrh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 10:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605023240;
        bh=Z0pY8lWn08U0Xnh9zZx05UsWJjhBcB3cqCmSKUR5/gM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Km/phAFRUBhyDLa4pfm61nq3s/ES7VlGbyA8ZbBiMhF2PgP2K0RrvrCSlGUPMXHAt
         KYCBrUiGF5H4fhuit2HWfoNoCk9mDRdHV1u03WhGMJD1JDhZrHgdH0X2UUsgCirwf+
         Gh0EbDeuqYqlT/x4ieoJ4y3l7l3MgfnyE6IWGCGA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63VY-1kECh60rsG-016Q1g; Tue, 10
 Nov 2020 16:47:20 +0100
Date:   Tue, 10 Nov 2020 16:47:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Daniel Gurney <dgurney99@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
In-Reply-To: <f41271c0-973d-ee3f-9535-d7fbc5b073cf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011101643460.18437@tvgsbejvaqbjf.bet>
References: <20201107234751.10661-1-dgurney99@gmail.com> <20201108095739.23144-1-dgurney99@gmail.com> <20201110003127.GA1268480@coredump.intra.peff.net> <20201110023620.GH6252@camp.crustytoothpaste.net> <xmqqft5h92fm.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2011101500370.18437@tvgsbejvaqbjf.bet> <f41271c0-973d-ee3f-9535-d7fbc5b073cf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DEbKaP6XBa2VnyvcIrUYx+QQGdImgS7wKR1Tli/tZb1tI0xXFDU
 n7zR2+1sfeuR8ssLl+QHtotkQWe9BbU/+cmQW6Y3tjrT64Y8F4sXjHO6k0ddYs/mYQfhXKO
 coZYs3iGumSLH0aVIvEpsvk6dNjRzIuzaGNiHn2TlvA5WK2TsO8S4WocmnYn8f9L/IF33ga
 LSXvbgFilZ0GSXJjnVufw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ozs88wJYxVY=:AV6xKVtmV7UGS23U9mcjU1
 2Gc/qpaF+/nuQTE2woOaZt+v5AV8N4M93vjVPNOYQyR6YlMpIT0PXuxokoH+lBR0npqJzY9oH
 HY91HTO65STPsbgK47U4MCGZkhfjgDlo+R4BePVCqzDgyAFY+G/8x0NcslTtFhoMIeBr7jaHx
 yorSPUFfMyK2XcgHvyYCmYP8UnATO5SYfNblEJVQ/a0J0neURwK/aSl3jFV/9VqEaqCk2eHd5
 qPfx/yMxULW/JRY5KpiCbmqr+PHkp/2FaEmkKklBBLv3abDfBi8Z/PdE39kYLkDx5BJ/qcqSO
 dAmhJjKDjoThshWnkiF6xNx64FohLwh+cZs+A2Zz4ZnHbYi3fXdGfwIaU76V7AUHBeZ0Tlo7S
 FFY/so7OgeV5pwK/3L8o7RT4eLBQRXlwyPKdZadfYbUQAvcDfBCohNkT+Pko57Z+M6ZsqwFQU
 teZOHFQJl9L26ECD9oBEMyob8YtZWD/L8EByw4bQZtn6QvqEt3SRoUdEq1ndYJcRkDTL6GjFA
 +myfnbQ1wNjxh/8l0FyMUMj7Amqmh6N2uOWF9/2kkk6NgIJAg9lGGFu1sBnS6bbugvcfex/Ye
 349k3TUe+PJguYV+PY0k2szxIwZzsd27cTXOFL7lzEDTp8MDY8r2CRUI7xiOJI/HaNi4iZo13
 O0MIumSJOl6pIdG24iMdRD4znT8WDaQgVvnfdWVrTzUqVIrfVvXIUKcpTQk7bC7ZTN9lBr64e
 xjnXQZo2GGawZ6vGXQMSkc/SIlPHYcCXYBAPgS16YFDmMc3YoF2SC8T1BBuiD2f3uep0WTwSY
 gTeIVnCNnG/Tk30OLHTrFtJs3g0BiURyJ0zYR1BkGj5IokDK78qX5hkfJGIbpWT64dFqyuzV3
 HnLTILi9nIqIoPudMXh9W7j/wjU07UDl+NFcXMs8o=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Tue, 10 Nov 2020, Daniel Gurney wrote:

> On 10/11/2020 16:04, Johannes Schindelin wrote:
> > Point in reference:
> > you can build Linux applications in Visual Studio like _right now_ [*1=
*].
> >
> > Ciao,
> > Dscho
> >
> > Footnote *1*: It currently uses GCC, but who says it always will?
> > https://docs.microsoft.com/en-us/cpp/linux/cmake-linux-project
>
> When it comes to building C++ code MSVC uses Microsoft's C++ Standard Li=
brary,
> and one of its stated non-goals[1] is being ported to other systems. I a=
ssume
> the same applies for their C library. Therefore to me a scenario where a
> future version of MSVC would build non-Windows code, let alone for a
> big-endian architecture, seems extremely unlikely.

Well, we know for a fact that at least XBox is a big-endian system and
ther are rumors out there that Visual Studio _might_ be used to build
software for that system.

Of course, I am not suggesting that we should build Git for XBox. But it
seems dangerous to me to make too many assumptions.

> That said, I understand your overall point of view perfectly, and I'm fi=
ne
> with either one of my patches being applied since the end result today i=
s the
> same.

As a maintainer, I am less concerned about the "result today" than I am
about keeping things easy and effortless to maintain. One of your patches
accomplishes that. The other one made it into `next`:
https://github.com/git/git/commit/91a67b86f77

Ciao,
Dscho
