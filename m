Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A1BC433E9
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 03:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B6564FD6
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 03:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhBFDTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:19:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:43071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231756AbhBFDPH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 22:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612581211;
        bh=otsIJp2LL5xeueUc+qRKDIyKk4wlREceSaTYMUQRD7s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eBf5EF7HiaWSsBctbLCVzWMqZVcelmdh6yUdqA+EEzPRovNQ/VzY9t6ZUUglxGR7z
         Q1E/tGn4LBES6zk9wN4/7g8SBdDdDVPUOx7pEUGhCeQeaJcUszvoBsNkUf4/UFmytC
         QiV8/DM2DQnm4M2Mov4CKNfbJMvOoK/erDquIQNY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1m1mPG2wwH-015bNG; Sat, 06
 Feb 2021 01:39:31 +0100
Date:   Sat, 6 Feb 2021 01:39:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
In-Reply-To: <xmqqim7gx41d.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102060137440.29765@tvgsbejvaqbjf.bet>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <pull.841.v2.git.1611339373.gitgitgadget@gmail.com> <2c2744333ecf5662d4198bdddeee80ff4adf6acd.1611339373.git.gitgitgadget@gmail.com> <xmqqv9bo7lwd.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2101270342140.57@tvgsbejvaqbjf.bet> <xmqqa6sty55k.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2101281636400.54@tvgsbejvaqbjf.bet> <xmqqim7gx41d.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YjVynADB9BDFcufh4ZRtSkk115dPIcxeVWENHM354GbaJeOtErM
 +eKvUbRPda33kD903X1CKc9vm/HRKu1e5p7sBVXIkv5TwRy44GXA75dM8fgCL8uRtTesrWA
 KSBLugvUZKwaKgpucfrk3yG9Ca5y0Z7WIgyhoLCw0Ag3g7Pr2l4VdqvmBalPptgFi3mJzzC
 BtNLh5FVIfLjAgux8AHeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WA3wX/hJtnw=:FXMC+D9Y13qBXQNyhga6Eo
 s8vMb7zHvT0Zrp2petFPXCR/E+HnahZCASLbRu5XMGJhXYJRsP7hunqI7v+b5nDYxnA4K+Io5
 JptTWYH4MtMM/jOUZSTL3n8Ep5j8Vcxq57r8O2o5AyzbKqqrSvZpapCP0Z1iWHIVibRs8b+mX
 lKhdSlX505NsNg6FuWrwFSGNTjUofVSTwabDjm/qs6Oz6bZF6CfRplhSgJ/PtWtgMTjFQjlSU
 sT2Z3jVgSxqthOl2FFUd+6Myg7quCm9g6A+mVetaooEtkGritqg6Odc19ORvWz/uNBwSOpfiy
 AX8lN9cQrpcxLkjdZe27MVvX0liaTXY7mTE29l1YVpCh8pUn+o+t9IywViNdEOLBjhNy0mphP
 B7gnlmyPn6H5UJqrOZmNV9kSHYzQjCda1cZEmoW6yYUSo20ivIO5vKZ+1sNbqaQ3ARMRz1bgQ
 jatN0X90wfbeH76rWgdjN0npCWg+g219YP5kDXcxOvtdgfCS05jIGqu2OMlpkLFoDViEjMJm/
 7ZnhqRn2jWGcqfOAK9FUW4zePqAP9Hcj3i3hMMM14EUTEDN+4vxANo0hvhA9rg4P8EeD4qat8
 EIhWmGAiyJZeV5DhojDUtCsAuCzVv2BGhnXsk/K70paMqCa102ZeqTOB+QlQKNvNoP3nGtsQF
 p+YRYp72wMysmJ9EkTHJXOd7m8QWNCuslnqayK4b9+f86G1XhQKkF9hS3/av1TPJKwXh5by75
 QpU/kW4sHZVtW1NFAo5mfeQUCmalfaSd78U3fq1+iguDKXTPEkq82rtCG7zWJMrNA8gjJt2RX
 zylqicWYnUFkf4ZZfSTpt1xeLnIG3egMUhOp3f69a6ClLlqYin9f5PhOqszFXk76iAVaWBha7
 XBPQESvSsSu4RiuJeaJnQAzAuDrnrpzORqm1KM0OM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Jan 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Worse than the `die()` is probably the allocated memory; IIRC there is=
 no
> > way to release the memory allocated by `setup_revisions()` unless one
> > performs a revwalk.
>
> Hmph, do you mean the singleton instances of "struct object" and
> those specific types that contain it?

I am concerned when I see what `add_rev_cmdline()` does, for example.

Ciao,
Dscho
