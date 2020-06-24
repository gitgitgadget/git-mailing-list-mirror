Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C18C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD722073E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="wRsw6+dF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgFXWxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgFXWxM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 18:53:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D2C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 15:53:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so4355458ljb.12
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5G0jBqCsl7kCDhGVbrwnqe2B5CbxzLNQgf37aP55N0=;
        b=wRsw6+dFhrOq8rSxqdpm39R3cRYcJTEvjwdS44aE9LAHzXebC9Bw4+rnqr/n84cM6w
         zug6irgIAs25j1w0S3VipzAhxJDMbFLYgdgB8sFq3igjFQBEA3kmCXJYmtNI1bFcoRFo
         WFPUimBmrM5K7/i2HmEZGpxIH6q1Hm28DJ4q//NbS4mW3g1kQT6cQdmq1o9kvicc2+DP
         x6vNJzfMUSPDIsqAGQTWF8dNdbYiS/bOcOZv0vSWU6XDkSvCvge3yTD62OaGskRJPMnB
         jB2Owse5l15XVhg59QgDPzltUdiFxPX9JbzLBrLtCVzgiyVBITw/8GUW5bxXFoTBZcgG
         hYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5G0jBqCsl7kCDhGVbrwnqe2B5CbxzLNQgf37aP55N0=;
        b=Cw/JbyerRK4/Oj6EOFMy6hJQKaM1jQG/JUVWhdkcy0PjtLHYhZHoEz4jEd5WDk0zA4
         8QXlqtiNVO6HE89GI+qaAtPomotRM8sOcMO6PmoJl7GcC+yAURJGZXrl+sMRTlChpCHE
         UJNlJyyVSogfSv5X+bEI0Ym1u/N58HBWlOL3CJ1Cj2SL/pL159EqW/kkULu5txbH0REQ
         db5of7TVgarq1K0ZgPXNed5Sa06AcbD7KhqDr3QqKYCmpA2D8JazcQLqIDPoXPKFOb68
         ywP4ous7x3kOS2ORlbmX7ZUjPsHOx3veikO91V9vXt/xKg5fv08pm0vNETx8r13ZdUG4
         9ckQ==
X-Gm-Message-State: AOAM530bhWBalhRmao2YhxxhVp9224KA9YaCxpH/8QBq8yMiDak3wthP
        R18Nid7c/Uhz8AeQQ1KKpFK14mU+Rb8YIGrsKzjM+jB9Teo=
X-Google-Smtp-Source: ABdhPJxdZj+G+nnIewI2wrkjfJd/K4G+6wVQr0XEQQRyAdVivU/l+uGbbnqjt8wpkFljXDURioXToXe9VTBIuUPloO4=
X-Received: by 2002:a05:651c:8c:: with SMTP id 12mr6185537ljq.107.1593039189776;
 Wed, 24 Jun 2020 15:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5zh=BG29O0Z-M7R26Lgd=RHECMV2+qByF+vU6PmrEn_Q@mail.gmail.com>
In-Reply-To: <CAHd-oW5zh=BG29O0Z-M7R26Lgd=RHECMV2+qByF+vU6PmrEn_Q@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 24 Jun 2020 19:52:58 -0300
Message-ID: <CAHd-oW5jCWeWDcMhLU2Zf96uTtxLehVsM+StDC8LZga282cDjw@mail.gmail.com>
Subject: Re: [RFC] Thread safety in some low-level functions
To:     git <git@vger.kernel.org>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 24, 2020 at 7:29 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> - Regarding, oid_to_hex(), a patch from 2010 [1] proposed a solution
> using thread-local storage and pthread_once(). But as Hannes pointed
> out in this other thread [2] , implementing a Windows equivalence for
> pthread_once() could be tricky and voluminous. Since this thread dates
> from 7 years ago, I was wondering if we would be able to implement it
> nowadays with InitOnceExecuteOnce() [3].

I forgot to link it before, but here is a commit in libav.git which
emulates pthread_once():
https://git.libav.org/?p=libav.git;a=commitdiff;h=b22693b06d1e5d73454a65c203b4d31c1ca5b69a

The patch is not so big, and if we consider only Vista+, it seems very
straightforward. I'm not very familiar with Windows, though, and I'm
not sure if this solution would work for us.
