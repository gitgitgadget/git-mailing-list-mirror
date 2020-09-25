Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E58C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E985B20717
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 09:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcTsveny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgIYJFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 05:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYJFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 05:05:21 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F8C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 02:05:21 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id o64so704787uao.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=L4/E5fMRbJHBfdrWT1bFNiKqoYDen8UxM72GMftr7qw=;
        b=fcTsvenyF4zxLYTCHDBMHhq8V3uyAv8nn/TibFx3/fqyzkevVhDr9OdFrbyL7HJier
         WuDtBfhtyD2Q8NAdnMOGUHnjcAwZrkxO1ys8PTQknoRL/Zq6FXQMoekX/Qg8E260aZAW
         uziOEiM6HUw1SQtH6HmqtQiKQ9NYYjf3MAu4CeipwpuNi7BGb7MFA7ys8pPw6oyObF2A
         /TEPw3mk8IjKVplwKE2P7iLqb+WfQky6p17SojD64ELGMw4nUvH1udBA/FLDUGrpBwhn
         bBQZFEWr2y66U7wFTznYt43rSGyykYfP07qzhNYfZLVAvVpqGLkkPqyMxXU1T8JZa0Cu
         z5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=L4/E5fMRbJHBfdrWT1bFNiKqoYDen8UxM72GMftr7qw=;
        b=De9YAfq+/ipIlMIurI2bqg0KNKAmS+0sIOQzVKki1iu3OjM93foliwWVc16ncU/rBj
         d4MaUlNe22dOipJiZl1tODUELAxp5OoZxC3vgZJTglmt9+q7ekMw+ilfPdLtsVXNdTqk
         kwf7hkxiC6pCOnfhGcqTVdyPIYpwHHaA8tRsunwiodSp+wgJatB6IMLQUdOejezkF8fW
         UyIURQR2QG6Avhv9yVmYHWjoyPbXKM5jtztLagvNT5vWA0SulVIPVMXo2SB7qOSfGopg
         kzalpBXkTcbW3QHAgTyK/SRt3lF0AyeQ70hYO6qbAu9wUrBEL4GJ3pVLtx+1dqjxqDps
         cKOg==
X-Gm-Message-State: AOAM533LBv4RSgMug0YgCbHD/vLHvvoYFlbJsHllfcMno1LfUPDOyI7i
        Gdm5oZ+NAuOawCKzr4MBn/HL5CYwGgl0ZaRlJhQ=
X-Google-Smtp-Source: ABdhPJxfUq6kaxoIJ/lPKkgQMgAJjpu0wM7BIDyR0CTQNlcTQlLK7zqSztWG/IaHXZfy/FNyyqBlhAyWIo1FLCf/qzA=
X-Received: by 2002:a9f:36ca:: with SMTP id p68mr1706326uap.96.1601024720883;
 Fri, 25 Sep 2020 02:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200924191638.GA2528003@coredump.intra.peff.net>
 <20200924192111.GA2528225@coredump.intra.peff.net> <20200925011348.GA1392312@camp.crustytoothpaste.net>
In-Reply-To: <20200925011348.GA1392312@camp.crustytoothpaste.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 25 Sep 2020 02:05:09 -0700
Message-ID: <CAPUEspjpUeaqCCuBJpQLSTv=C_P4f5h22HoTPm9+9rB7k0NkaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bswap.h: drop unaligned loads
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 24, 2020 at 6:15 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2020-09-24 at 19:21:11, Jeff King wrote:
> >   [stock]
> >   Benchmark #1: t/helper/test-tool sha1 <foo.rand
> >     Time (mean =C2=B1 =CF=83):      6.638 s =C2=B1  0.081 s    [User: 6=
.269 s, System: 0.368 s]
> >     Range (min =E2=80=A6 max):    6.550 s =E2=80=A6  6.841 s    10 runs

slightly offtopic but what generates this nicely formatted output?

> I cannot speak for s390, since I have never owned one

I happen to be lucky enough to have access to one (RHEL 8.2/z15, gcc
8.3.1) and seems (third consecutive run):

stock: user: 7.555s, system: 1.191s
-DNO_UNALIGNED_LOADS: user: 7.561s, system: 1.189s

Carlo
