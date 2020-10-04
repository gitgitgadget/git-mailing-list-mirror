Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76019C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C252208A9
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SPkeSpiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgJEM3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:29:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:58395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgJEM3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601900970;
        bh=2LuEzT7b5qMV+mogbRE2pL0pf+hIEfO/WWQwgtUgK7g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SPkeSpiqJd1HegCYobWLo3mkhjr+xzicAYhmW9aw27S19aXnbETUo7TDR5ifXUDUm
         BpwJdT7QMqPqGQ1Vwd+szc46Ud4BWAry5v2qwUk+WW4adW50ZdY2lYidUTXZrV3nrK
         QTQdnROVhUrCRNDzsvCnH6KOljIpySFI0W9bwJBg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.214.27]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1kKRoG1fIQ-0055O2; Mon, 05
 Oct 2020 14:29:30 +0200
Date:   Sun, 4 Oct 2020 20:39:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 12/13] reftable: rest of library
In-Reply-To: <xmqqzh548sid.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010042036221.50@tvgsbejvaqbjf.bet>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com> <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <4e38db7f48295c4e6d729880f5f1a63b0f90274e.1601568664.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet>
 <xmqqzh548sid.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YHyTWuS36gHY6XZrsMaYKKI9j95oChLVmarQPyJIuF8E6AWpOpt
 hkS8h2HcKattLYNFSqR8fXrKqM0iJNaItT2VQkLwYUHr0Ea+GHkLk/yMcAxBk/Mg2sTIDfn
 g3p7hMzWAGUz3+kqYPuAd0oMzF7WErNs+Atc2sF3CQnBvtShKVkiTK1nIC1nkaV/oSiPEEf
 Kmdtr0GuiQ5fR3/5d/MWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DTCAkUrWfzk=:XPubpDp8oQz3QUV9HorJLk
 7/QQkNWElC5Mu8WWRnZYtNPtkSWtLZs4949toV/OVa2jVgudxb4SwwMUFePLn3Fg8/wi0EXwj
 GS2D8heH68rwUqYGuQHYq3J9FDuy0k4dotFIuP3lNo/zXtAfBB/HtaIRJeMC+qG3J6/EeBio+
 NDuMi4hSqu/bkG00kvILCLPJKYhn6TZPDCKJv0sC0XRFT7Qd06wH/Qr7kGNuv2ecfCk6oU89p
 wFUGRFjzZhbjkryTMUax8h2P6t8ndwbiX3PJG39Ek8aQltsAIydrHKUInWGYGpv1L5GgBJHTA
 vWNkIrziF5Xf8FfhzmsqaNeYs3T4ISecDpMGDFmHHc6Bu4WZQowvHArDs8gSsb7twMxHHRJEY
 oT1bJXtSfKPG2A3pCACjklHPNryEuFCQRwvgmsMfvMWyDruCX+//QZmSRO06RV2jEHY/+/bHd
 pz3JNHyAVIhtE3HpKeoSHWg6UEd1Ew06MJZViiE1FfQKyLUpoIh7F/8nC9FDKxvmvZ6sp9UeI
 vlZX4nmoISuGJeN1uTZk/eYWIdvwnktpmLsvZpg9JrRdHaxPyqVunuhwAwrvsMCBBgyD+nJ0v
 oJSIRO6zmaa6aJKp9K+6dEX0J5Slt7jFlD5p2ATsg7VxHmvwYxjhPmzkCoDAihdPJxd3E/pct
 zD+J92brQpdZgzZfiu6uqQHqkJ1m2QPt+0uSl+ukKDpJK/JgjY5ndGCXfwhpd9itrl1ZR2xdr
 Yt/2MhaCjBMJ4EXawxnOi7Ny8Fe2y+1iEga+u+1HiFlNXecM5f7gTn0gxbbgPOfU7skTCl9AY
 E3Da6spAUbHDN+DCTeV3oGThvxiUn+nT2zMfYR0bbghSvNbY/oDSNUD3E4BQCf0lDy5i6s5Db
 25u3CvWU2Q8dufIuG73ArTAxINGmmfieOcTX28B9saQ3NJ6Ies/Vc8361SwjpC58xwt5gDSrG
 xiMx0YDX/IqbE8qVw6akaPxGstikfDnkXuiu3WECwbizUxXa1z7EF7I8xs9AkYlajTYtc/ppy
 DwBQvruc6A96C3f0mH2Qb+MT5oHb7SIzGAaGxqWKKpDnxfUtSOUnlpTCtI8H7xuovmPRrWzA+
 7eroSCWLfrEQOiXc/eAqM9kuxW1lgZHLLRRiSO55ATlu/eNt3hfuc9T0LnqP5L6AOUyTPWIro
 FK3s1liRYnhYGap5/Py/fcCBaRMzpp8qxHuZ71iy+n5UphlU98iIWgAB8lJ9zQlzLVMtYge/7
 lXyaTlFPxPf5cgdmkl9oaiGgK+9S78QbEmsQ7Pw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 2 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Subject: [PATCH 3/3] fixup??? reftable: rest of library
> >
> > Avoid using `getopt()`: it might be POSIX, but Git's audience is much
> > larger than POSIX. MSVC, for example, does not support `getopt()`.
>
> Either that, or we could use parse-options().  I do not care either
> way, as this seems to be purely for debugging?

I actually wanted to use `parse_options()`, but due to the way `reftable/`
insists on being completely separate from `libgit.a`, it is not really
trivial, as `#include "parse-options.h"` fails (because
`git-compat-util.h` was not included, and IIRC including _that_ resulted
in more compile errors, at which stage I opted for a more minimal
solution).

So yeah, I would strongly expect `reftable/` to become considerably
simpler once it starts using `libgit.a`'s goodies.

Ciao,
Dscho
