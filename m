Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7BDC433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B656C21D7F
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EXFXucfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbgJNR1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbgJNR1v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:27:51 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92DC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:27:49 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id r10so77012ilm.11
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tPeEDv/E2btwalxnB8KeXORkPsZLSeWDx+0VCAxvdK8=;
        b=EXFXucfXSX/l/89SLGfGyMeJNBvnWcPkOa1tVgx5VyL199N6Y2HBSzZ0L1tyqwePwu
         eG3VRuhZuqI1yZ0jI0/qtAjm7iapv/2+RDMeK4ZWeYX9lTT0C36PMZRwS8M/HitB7tn9
         wETan1L3t6W9i1oItc3oFLDJfEpFmPa1fV+u6WLLvfgq510kEbwMAsw6ip/jfCKH9x5n
         Qj6WGL7lH+1f9Ey4oG/XiFBDiA79Dd4O021R1MgKfvJN29xvEtm1nZivI+C9Qr3BL+kJ
         wPLbvUHSG2lvAT0Thh/FKpeS3mt5Jkv6EzT7MaZPqZfo/+191CmvDgmQfpOHPk2YtExe
         1dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tPeEDv/E2btwalxnB8KeXORkPsZLSeWDx+0VCAxvdK8=;
        b=EhfIuyY6t5uig1g/E9ZH7pZthTNeRPc7TJ9bRPgNqJePLpXx/41+L0Jnbm6h+GM6F/
         Tg92ccIirdj5ARMZ6gDCaYtg6h+aTtaX/6KS21NLe5xlUY0rk+XPoqXffm3DyKTW71ET
         QXhq4BmNwL/EQERooDQ0ccacgTbnS38SpN+BM2p3yuuRcABUgvs4De6dDw1I5Ys/lWNt
         /Zb1nI8LkxQyyTDt3vc+AQsZe/myhUirOHnv64RX0PdiPeVz3YTEAKa6fuQv2HunFpsC
         mOKe5Oa4MlZOZ2vepTCoIQVpD5ueniUnZr9VlTnWHC+iQJI+5jugZXGQtA3DAJj97D3a
         n0sw==
X-Gm-Message-State: AOAM5318r715wopkLHa1aymYYPw6jdzkSAMvW4sq7UhrT2HdfOGqNW/+
        K6jp8xCEn3etTRRM0Wn6chAg+5oddh+SYRl8
X-Google-Smtp-Source: ABdhPJxs1P2Aov7sAh5sNSUVIBWeECH5OHaUQbvYHLfXHgqKzMY949HXPTmp/16sAXJ11UnvYaWksw==
X-Received: by 2002:a05:6e02:dea:: with SMTP id m10mr186359ilj.208.1602696469048;
        Wed, 14 Oct 2020 10:27:49 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:547d:7aac:e654:2f06])
        by smtp.gmail.com with ESMTPSA id r2sm17475ile.1.2020.10.14.10.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 10:27:48 -0700 (PDT)
Date:   Wed, 14 Oct 2020 13:27:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Partial clone fails with file:/// URI
Message-ID: <20201014172746.GB2044338@nand.local>
References: <CAN8Z4-XgctFZxZoTWRpD1V9NFr34ObzG2dxUoAfuJ4NOsBDdtg@mail.gmail.com>
 <20201014165607.GA2044338@nand.local>
 <CAN8Z4-XGbb_z3vmJYATONmBkxBcfxwyC-_4XEOkP0sxsdT9wxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN8Z4-XGbb_z3vmJYATONmBkxBcfxwyC-_4XEOkP0sxsdT9wxw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 06:04:18PM +0100, Nipunn Koorapati wrote:
> Hi,
>
> I've been building git from source and directly using the executable. Roughly
> ```
> cd git
> make
> cd ..
> git/git clone --filter=blob:none file://$(pwd)/git a_clone_of_git
> ```
>
> This is what I was missing:
> git config uploadpack.allowanysha1inwant true
>
> If this is not set, then the checkout fails w/ a
>
> fatal: protocol error: bad pack header
>
> Perhaps the error message and/or docs could be improved here to
> something with more detail than "bad pack header"?
> Not seeing anything to suggest this in the docs
> https://git-scm.com/docs/partial-clone

Ah. OK; I feel much better knowing what the difference between our two
setups is. This is a long-standing issue (I remember seeing it when I
was experimenting with partial clones several releases ago) so I'm glad
that we _don't_ have to treat this as a regression in 2.29.

> Thanks for the prompt response. Appreciated!
> --Nipunn

Thanks,
Taylor
