Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFEBC4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 13:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB2C6101D
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 13:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhHHNrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhHHNrL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 09:47:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B1C0613CF
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 06:46:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k2so13538796plk.13
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:subject:in-reply-to:message-id:date
         :mime-version;
        bh=pdIkHN6t29nrMVhUridkU9epHxoFUpaLWyMHBnsUJR4=;
        b=CBbSx0982y43dEDOLpxAL10ta4kVnr863lUTnRJSts19eKFEMtvmXWSw+Ogh5ULx3H
         pJvABSKK27nk2++H8cNG2+Qhl5zmz8j+E9+dhGfIer9bLfSPoR91Vce3VosKhTRngVwo
         ppwwVZd2pVirt8jcgCkow1Sa8LwjnfxfF+BbTtckI9ZMsPCJZ+RMi8ha6jXwBoOu03KB
         ISgEaBSAl2UpWLU7HfZTpIP0h7WYppoprKTOIGgIEnv0DXzb4Wt2cluASBcViXxI9gqT
         jLNT0ujR79GdVVJPa6+5YCe+pnWArYtPPjDeHngNvQd6GlGrt7i5Cx4aLuUftB4JTtdU
         ruEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:message-id:date:mime-version;
        bh=pdIkHN6t29nrMVhUridkU9epHxoFUpaLWyMHBnsUJR4=;
        b=LzH2+yk5jUM95L9YlQYolvAiKoDyPrRrCMydn+2Vy3hBfOdB0zoTlN3qpucQ9pv0Sb
         sjiMyvoCHg0MCifm+nm4yPiHoJAkgninit/BIEEOZ58cfsebUrX9fW5eGD4xx2i6uW3G
         DvXpK4M/WxpJCxtpT3gghlhYgnoD0tp2VadcavHC8SlbYK9yG+kgwK4uZO1W1cpFfO1T
         P7OovNLXQNKiNPn0MK6m7FZxgdji30mhoSnCROEmx4588KUvlBNygiO3D1aVMCcBExA5
         hDr2R9kgWl93d8zi9q42WsCAXOj3Ne48wnoDcer8tZVpunqJD+PLcGgG/pGwA9YibUsj
         t60A==
X-Gm-Message-State: AOAM5300Tf0a4wvLWA8N4Ms6s/6Hkvdto4DiV6deYdIoWjdoUt0LU2oz
        +pwRtsvGmuyeHptN5VUlr4LbKtN2QWLmmA==
X-Google-Smtp-Source: ABdhPJw3IpS2M1SHQE+2CT66tgsaRrEHdsiYOl/PTLlldimVhtQxsOvHxRxoUXAuX/QuEORv/C6AIg==
X-Received: by 2002:a17:903:244d:b029:12c:3c0:f21d with SMTP id l13-20020a170903244db029012c03c0f21dmr2201133pls.65.1628430411121;
        Sun, 08 Aug 2021 06:46:51 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id p190sm17352728pfb.4.2021.08.08.06.46.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 06:46:50 -0700 (PDT)
References: <m2eeb4aw4u.fsf@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC] My Git Dev Blog =?utf-8?Q?=E2=80=93?= Week *12*
In-reply-to: <m2eeb4aw4u.fsf@gmail.com>
Message-ID: <m2czqoaw1k.fsf@gmail.com>
Date:   Sun, 08 Aug 2021 19:16:47 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Correction: This is week 12.
