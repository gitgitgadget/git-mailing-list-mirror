Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39156C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDFC206E6
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 13:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IkxOL/Fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZNsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:48:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:44093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgCZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 09:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585230511;
        bh=DBTeRK1AP8NepN00i3XdscxXs6Rd6Wr9dYXKpGw24o4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IkxOL/FoPcoQ30yITQqaoHEVNDTnzBp4cYq5ZNxiwrKkSv/U+PHlQfvSXqq0886Av
         +J0/Z+Famh6ke8bHJg0jMTMe1sHOYxtKiULIOOSR47BQeVV6KPLsks1Ur2I/0Vlkuo
         4hBmbzlXiRNF/joozdufIOZeafd3oA4MGKbh70is=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.82]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M3lYB-1jIHwz3yfz-000xZQ; Thu, 26 Mar 2020 14:48:31 +0100
Date:   Thu, 26 Mar 2020 14:48:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] t/lib-gpg.sh: stop pretending to be a stand-alone
 script
In-Reply-To: <20200326082140.GC2200716@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2003261446160.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com> <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com> <c1811d54190a62e3d35505e2b806c89238b56de8.1585114881.git.gitgitgadget@gmail.com> <20200326082140.GC2200716@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zYlUqlD4vRQvtk/jIMSC01eS5ELRUXxUTZpp1KZjr1PUjHioARv
 rMbu84Yxvb+LqsUoPvlRERsDD7Y36VURI1XX9eArCW1VgpSb9ok0+6hcO+cRdRchMgR9+i2
 02Pm0Up3xayKZ22iZM5+3clXxRSZaMN1PWWgTnk01amQXVkd5fgbdvVNtqQupRoSchRkC4X
 D2179pe8wjPSw8S77hKfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GgjUfLetOoY=:8WnIEueuHyChcLEimMNbBM
 gIVLgC9Fel7qCIFY/FIz/WQgoKxcovCIPIG4tNvMZcbz9xfkMXKHDYZHXjIWu08q7skAZEpeL
 U3KwBWvyHM3bJi9c2O2NRvrdfTwGWcEasovPaKVyqzQJFORhFuuN8FiJemwYFIgeqDKQRARkB
 FSdU5CCkuLvzkHR75oEsU9AJD8xKed0aYtn/Ykhi/Gb5ql00nyTyOjqhKG0Fyt/mvtm5Mxg4e
 oQwDPpRQ+PQP+5aXRMLtJizzfCQF4prjRlgcwYeFB5oKWGD5cPiK9gsudXw7pmJLt8AgOzmeG
 u2gBQZPp7zuHtoNl2g9oqO2/i60B4g0Nr7sqR7LNP7yWcmFJa3cNkud6GTQjFYSwMxNZfG+9K
 VH8mg39AcZxkdbzMTj2iclXg1ZecndXfbZJs78tiPqmqJQtvgyRvZxJLVkMFIZch/eOASxKr4
 VQsQGwRFwTQ03hCxEVjR6BM2nLMmp0WjeweOBodgAvikDonB5OMXRWp0Rrk6YGPspJ0iUndUa
 rAJzKn6Zd7pCxKvdJfYU3Tli7pRyPz49jC97Zs8bBoZN17hKUagY6WKlLJZ68J6B3Qgs0jYQt
 DeCs6KIpSQlaUVT9I+SVEAwfc3VVi5etrCuNthZS3LqOGUOhSa35U8iQvMlg/UVbHiPHMFqvb
 FQayIRTi2h/tZRHMaGtRfX/9ZvuN5DrVMstMYBAqzqx7HbSDRX7eZvqJ/hpI/SX0kAuc+RBaZ
 N7CfUNwIyOqaTALziy/GJ5k8OdSmAVGaAnxsJWKo0oUpGphJJVFbwvH4eLxG0f5EKnYFJB/1x
 Ka+VRgRK2LA7H21HbRHlg7zOOy/clYC2xhNfdk4C3QS8SjFWQIQLYjBkUCrr5dh+c0L3aQ9E2
 l/MAPdP/GF3eyPBBvqxvZFgFDJkybNo89UAuJjO7N67BptdKlvJ0RHUFpjGCQvXkRvgLhCBDo
 C0CFz6cm3uAO4OhywKIujt6R30MCKBueSo4bYTD1UKj2JL/l0O06SbMkWMcdt6zZ000FPfRs+
 rblhSwWw9Jil2obWG0Hmh4EVUrQyvu1cam3v4fl/LnkHrVcz9+SFT1Kk8ruL5YofAVXPNut/P
 uApZ7UJf3oGDNTBqxKQel4gC7NyMXmsbr7+p6pBWTYbJ9ZGcSDCTEG/VmXBjl6miuRi1F/46a
 EvLXTM7qxldbkNFGjYOs4CNpsEPd47dhU6EnPMUV+0CqKqJn7tL6ERr3F9HueyExYJf93UZ1e
 YBfH/0O4YxMqxl09x
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 26 Mar 2020, Jeff King wrote:

> On Wed, Mar 25, 2020 at 05:41:18AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It makes no sense to call `./lib-gpg.sh`. Therefore the hash-bang line
> > is unnecessary.
>
> I wondered if it might be useful to identify the file for editors, etc.
> But "*.sh" is quite sufficient, and we already stripped most of these
> out long ago in b54a31243b (t/lib-*.sh: drop executable bit,
> 2020-03-26).
>
> There's some other related cleanup. I'll prepare a separate series.

I noticed that, but forgot to add a note about this to the commit message.
Sorry. The next iteration of this patch series will have that note.

$ git grep '#! */' t/*.sh | grep -v 't[0-9]'
t/aggregate-results.sh:#!/bin/sh
t/gitweb-lib.sh:#!/usr/bin/perl
t/lib-credential.sh:#!/bin/sh

Thank you for volunteering to clean them up!

Ciao,
Dscho
