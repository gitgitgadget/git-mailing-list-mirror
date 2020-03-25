Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF1C2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5318206F8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OqnU2A9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgCYSYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:24:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:50521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgCYSYL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 14:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585160644;
        bh=lPR8o37M74uf7fDBZq4iDGBfQMqSVvJvj503rmqOOAA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OqnU2A9VpnzBEXsYkWlNdocQ5DmNLiFaMp0zkFcXk0zPE+jZ3N1+d7sXpz0c219OO
         qJ8NdMFVZWMvacVJqKbvwAVtYCNxmTBMBganIURn8t/iuJ6pe6faFwioqhYwS5enlO
         ASm0ORHsX8qYfP5tvZRqVFa/Xwa5lX1nlQOL3cBI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.37]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6UZl-1jAK0h47Gz-006uB5; Wed, 25 Mar 2020 19:24:04 +0100
Date:   Wed, 25 Mar 2020 19:23:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
In-Reply-To: <xmqqtv2dz5mf.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003251923340.46@tvgsbejvaqbjf.bet>
References: <cover.1584838148.git.congdanhqx@gmail.com> <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com> <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet> <20200323150449.GC11801@danh.dev> <xmqq8sjq4wyf.fsf@gitster.c.googlers.com>
 <20200324034025.GE11801@danh.dev> <nycvar.QRO.7.76.6.2003242328380.46@tvgsbejvaqbjf.bet> <xmqqtv2dz5mf.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QXtpz59UWM3ySEwy3vTOuRZ0FfTqrGVibKOR0M0BWOQdxFdUApo
 nVfH600BkIKH2Hw9S0yTVZ/vHGVxmxBZxX+TciNDTX7T+g2QigQ9u0CRSUMkb7JJ8gG9ZlQ
 9z50FDUdlCXM94DE3CscsmFbHOKxyjCQt/tpravjgZtZ2X5Dt3yREZHhpP8jS6bllBeE3PP
 Dzc1LOL2RP4ZvHt9JvLjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B6zGbMVWvBE=:6VlOysw7mNG86yYuSz+pIA
 QbK4OtyznBs+f2K182FwpL9Re6foLWPSml73DRdw6QGVta9NS6sMNa0RrK83hLAKMHldPAu64
 ZbN6lFaEPkrl1FZpZKfgE/FkwmalhwhwzXASs2eFfbPd+LsWHNSIevqej5K6TEfUBq3hUatQa
 XGyP02reViOCoS7w/hFSXOFY9XgPDcSKmm3i5cGwU3ruPXr5W5sddx3RRUS5UfqZImnHcQPcH
 wkKDTq7m8dhbi4vERalOalYvdpNqSUv9oZOxuxG4g3ZoLx03CEqRCq2/7xY9m6uKAZETYzrU6
 3xlE40rchblhaJ9vawgz5EvkCK7ztI84zOs4bg0VtdyWrIpmJyqQY4nubODu+kiNupmxEkUsi
 mODe8iIx+toSTJ7abf5iMLizaaFapdkSwkEbrbXU49CrFkeUn+6JUkjFhMsnYCmg4E50GF7b3
 sseCGlhK8Ey3kiJJe9w+MNygdwyU9L39ynw+tCMjvcH1zy+VuXoHCHOC9yujqxEbgykdzfiyn
 sW2JSExnEdJgxelQm/LcvCykUz2xh6ScdkThe/Jlo9Hm8GR86UuaSOCPo+BcoVrgh1de+L+oK
 mxOHZIS18Y7gRVWkPiigBn2AH/7TEYdXqWmHeW5ZlVWknMZkTqH7OrIuNG6oK8XZizkH3tgRR
 PrIuQyBDpJ+TkOftoXjwwBQXaG+0/wtQO40Ljr0SWVEy3I1iNLCvgczvMCMng83nbRgkzDihl
 ceWj5fLVHffLzZ7XpHE38z0XLjNTYuOOHm1FtLXYoIA5FY+LiUbfo8S5gWTWj/fRPNyjn0GQW
 gOb936e4aAdUIf27NLYdAG19OPhxHn2uUs7s8ngRQ+etvYb+Tt7gldkuzpgdTCqEu510a37ME
 yiIAHJxwt1Bna99iAMBmf2+XWssylgF6J5D3L6hwFkXIqqFO9qrHzWK4aoGPY9zKCjyyVfDoW
 d9I0xv496Ng9yKPy5EYT/k8XE60zYtA8vUcFaSALh9jZutYtWCWeub9lCNrWvtGs3eszyfHlN
 vP5N80udD/7SDfXDBi8XR+Iri9P819VsjSKKnrHqtwKWd2Ca6fN5CEwzc6rUbpzTEv7fdWiwr
 NoqvE2I6cJ6wvYlBquvSCC0ygPgKBjjClMtJCMNHONuwlVKl2OUdIrmgMGjB2tIu65iXhxM8Y
 cvAAAAGiO9mw6/lFmj3D/K9eEsO33kPxQ0eNzei24cB5YkDUh0P4Sr9ppBf0O5ldvTBTFetEK
 p99sddK72HRUwmGvn
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Mar 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > With this explanation, I totally agree that your patch is better than
> > mine.
>
> Meaning that we'd have a fallback checker that understands "diff -u"
> output, because the presense of "diff -u" cannot be relied upon and
> we'd need to keep the original that understands "diff -c" anyway?
>
> If that is what you meant, I am 100% fine with that.

Yes, that's what I meant. Thanks for clearing this up!

Ciao,
Dscho
