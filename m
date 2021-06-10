Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF1C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F7A613DE
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFJNV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:21:56 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45927 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhFJNV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:21:56 -0400
Received: by mail-oi1-f174.google.com with SMTP id w127so2053154oig.12
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zI4UZHyU+9gDDXteUg+oP0cGkszaS+Zqfohm0c4ywrQ=;
        b=PzMYzWiJmE/fzF8OalYPUfdTrVsNIHe8v1DPmtN80kIifDjlytMmJgeKwvlphYBFpM
         ZV1xKICDa8C3LDkMrLNd16mjQE6Fw3q0I1AHMulEDIsTqOuoTSpytDh3T5uRJyTrrH2y
         Qw94NDbbSVD3lSgE6t2Y1wNKWcfKX2CFMU8pUn2xmYO42ScCdFvG0S1oVnyhIRzkwLyc
         ymxSu+uy+r3JT1AyZ601DR9IsNUMDv/LK2WTxO2LF+Pi7n4GPFf2Tl+F91YmvCcc85lS
         NBdmCgfpIzI3b9F4lOR88y8RHY4nRjdNOp2Dn+X20uktfDPEocmU5p1NArdUdUW6tKEs
         jy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zI4UZHyU+9gDDXteUg+oP0cGkszaS+Zqfohm0c4ywrQ=;
        b=maLOBeaqW3Hpy3/ID/DdOVOp2+2gpq8ekrTbsrjvflW4Gd71dWfslDUtzGxn/gyUW/
         44IaXzfglmXvqpXRzN1UVeoG+lBTQxHbpfRLYtQr6O/lPazi6YOQZxXVF09/1OsuocDn
         fBMdkM7Fg9sxgsJsMH3DVwUDt6gINUDw8v4hU9QfgNGDZ7zpID5CPULDACDQAzF9gblx
         xVwEwFfoRm/pr4RjZ9gvnNs0JRjA3l8ll6Dip389LpOooVHxgk05AJ61R16Z2ADDMMGo
         799NPisN9NBediKSawsCryw3wROMxlWGvGD5+yeG58BPVgjnxbXi5KeIaB/6Gu1zs3OS
         cFYg==
X-Gm-Message-State: AOAM531wrTVfTxVJ16m09YhIU8WZBzFsrF5vfqs8Kb9aETz7k7C0uKIR
        EpngDcmkObwTtd08X+5v4zI=
X-Google-Smtp-Source: ABdhPJzt1dBWBmSiOcgG6vwSSVSlaMy1J3xYVktSyfWVmjbABnzGsN09FGCCIPZO8jgoFpKEAlBUGw==
X-Received: by 2002:aca:30d1:: with SMTP id w200mr3435036oiw.16.1623331139764;
        Thu, 10 Jun 2021 06:18:59 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l10sm601265otj.17.2021.06.10.06.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:18:59 -0700 (PDT)
Date:   Thu, 10 Jun 2021 08:18:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c211423f46f_b25b1208de@natae.notmuch>
In-Reply-To: <YMHE5xuxN90HJepT@danh.dev>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMHE5xuxN90HJepT@danh.dev>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-06-10 08:41:21+0200, Johannes Sixt <j6t@kdbg.org> wrote:
> > Am 09.06.21 um 21:28 schrieb Felipe Contreras:
> > > Virtually everyone is using it, and it's one of the first things we=

> > > teach newcomers in order to resolve conflicts efficiently.
> > > =

> > > Let's make it the default.
> > =

> > I tested diff3 style the VERY FIRST TIME the other day and was greate=
d
> > with the below. Needless to say that this change is a no-go from my P=
OV.
> =

> I agree, despite using 3-way merging (with external tools) to resolve c=
onflicts.
> =

> I prefer the current conflict style, aka no-diff3 conflict style.

Defaults are not for you, they are for the majority of users.

-- =

Felipe Contreras=
