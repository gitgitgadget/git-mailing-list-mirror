Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9C0C4320A
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5CF6101E
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhHNVth (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 17:49:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:56395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhHNVth (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 17:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628977739;
        bh=1yBUjuNaRh2atXln9K6Fqop3nJjn4NcBYuMwe76YbLs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DTFVEY4R7xjXGHvAypFTM2rDgNtMQaFIF4TZALGSlng7YxZA6fektKv7BhXu78PmA
         J8ltzJmCvMKFIyOA+O/rqxWSR7yoywoqMrs55VnzEBSbZqCdslzBE/HSAd5DAgLjet
         9SGK8nyQpjsf8XhdlNZmcgIyBpcNhzFvAnteEAmw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.179] ([213.196.213.229]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1mu5WB3Ehh-00nvkQ; Sat, 14
 Aug 2021 23:48:58 +0200
Date:   Sat, 14 Aug 2021 23:48:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/3] some small range-diff read_patches() fixes
In-Reply-To: <65b00c6a-ef88-29c3-157b-24ad9f4d8a8c@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108142348390.59@tvgsbejvaqbjf.bet>
References: <YRGwGDvOte/o9vkd@coredump.intra.peff.net> <65b00c6a-ef88-29c3-157b-24ad9f4d8a8c@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qNMv8Nxrifb5Onzfsk3nmhQ9piXcp1OvQyPyf6Nq0SxJ2CVrpf1
 ZYx0t/PehkRnPOfIhqlPoqy/6kEtbYsSlsw3pfcjiqGN1obiDFUJ3HI96h4PQWGWvqPuHcy
 3S4tpmhmNS79AMoq4U7hG35reQifLYTV8Iblzb956t03z3fVvORNbQdfvb2lkiDtz9wJjFB
 ZxuVlBSm7ieMCoFi2EM1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YKV3C/Vc3ow=:zh9HH13paS5GWH7KiAS3xs
 KR6U+7Xt9dOWr2PP7nTZgG8krLr6RV50/Q/CM2LsvN4eA21Ny9kk6lh3abhS1BvjdK6jD7e/A
 6fCLK+rc9tsTMffCTR0OgALWYKIXqx4RxeOV326JmpRAyDSaE8H7SneW27i46LEQ7dTiIdzIN
 QW6WlficMimpx0qGovYv9m5ejsKI04j837SZ1gj58zCNN7hzoYvXc9aqpUvN363gvAxMfdCSl
 mNf/5PLMQvq0fAGwoXTeWYfp5Hv69X0T9QXREg+/o5S2So33hf816UAx0d3zFjaI8bt2tN1WH
 8W1++iLiO3gMkduQo3iQikAzYWP3PJbjXU3kVh/5yYdyDUZLOli1UQAFR51IMmQnuxyuWewx/
 wSEnqhjL8yzBg5skuNcRvdZtezfKJWoA97jkWfIto031JgmGwftg6vnNp7oHqYdWv11Nv2lTg
 aCrAK9yHV8/orjN6P8BNveXNYtN/ao5rYVjkpHG54eU0A/iClrx5BoBJ53zQmKh2IoPxfYyj+
 nQLdeirugwdNw3kML9Kdbd5BD0JoB7JHiltH7TY9aD9DbjjC9iR8W86XltprywdifhTiViRDk
 nK6PxrgoEppKpFoW6pCOSb2c8dT7h0ismB+GLhhVB0UCtVGUy5rFK8hZxwbMBeCx4P+JRnyvi
 aR5VPMQHxQilAuYo6pWzuilmG955En5yNU/f8bhMKDmn7U2PFr2ZdXqtvXa6L8D/lW5CQpV62
 xSG1VwozwA5w9vXALxRBEzhSRFMVD9cs6HMDk/PqItaUX0K5Fi+GTWjbAztRNS/2cpmlxKWYn
 65dsrJsVcua03scWEuokGbayd8hi3y/buUiBVPy9yuoHEDrQ7WVPT7U3+dtgiPC9BpZ3j8Bm3
 T+/MkBg3Jk0d9qsLigi2tBYyUB4bhe2wi0bwqDiLc+Kpw7supIKu5ZLxKOxPvpDybYfc8lvUT
 +xn2QrK9e0BFFXTEwRVMsOH6/TzU8rwNbUX1XS1oDVeXyuudI28YZEvQ6Si22VYM+IuYdW77a
 PDUzmD8hxETZ3QqusuVbkHaO6KCQxAYpKnUrtwo0nx1VhJSnGbnMkaS/4kDSNEvEK58r7V826
 EE33e22kVsWRC1xxIBHvUrYnkQrBeNUlnmhZrSKDxNJxW7+5ph305jPLw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 10 Aug 2021, Derrick Stolee wrote:

> On 8/9/2021 6:45 PM, Jeff King wrote:
> > Amidst all the talk of clang4 in another thread, I noticed that Debian
> > unstable recently shipped a clang-14 package. So I tried it out, and i=
t
> > does find one small cleanup. And then looking at the surrounding code
> > helped me find 2 more. :)
> >
> >   [1/3]: range-diff: drop useless "offset" variable from read_patches(=
)
> >   [2/3]: range-diff: handle unterminated lines in read_patches()
> >   [3/3]: range-diff: use ssize_t for parsed "len" in read_patches()
>
> I gave these a read. The code diffs are obviously correct and the
> explanations are well motivated. Thanks.

Same here. Thanks, both,
Dscho
