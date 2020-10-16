Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7410BC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B6820866
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqe4mWr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408163AbgJPNyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407440AbgJPNyW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 09:54:22 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300E6C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:54:21 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u17so2522949oie.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oCYqgs9/rsi+YY0hkuTr6nm2nYT7NEi6zMC/b51f04c=;
        b=Qqe4mWr5HSZiJTfBeUFiOtfxEfI1ePWPFgi1PldXrGzYi2YSmvxDKU4V96AkP9qzAw
         iJarIt+OLFyC/YxPVNh/8sI2X6zVJu5ENp+UMZ1T1c0+50Af4FTa4GJiF0ya+gPLMyGw
         0havlbhc6NlZaAM2GCldVuoZgDDCik7+HTBrlv8mkSiIbRksnnNYis5EZk9HTYFgSrRh
         IWUIqGRE1PpS+4laotm2WwkIG2nLCvQl0u319Y1pal0n3jgecaANlezV48qo/2qj8ntt
         ECCu8NRFngBXPHj7P1oUQQowYLS4Ck0/A2ltall7NNPNfdAHMwdHFzj8T1duy69lfZyy
         QpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oCYqgs9/rsi+YY0hkuTr6nm2nYT7NEi6zMC/b51f04c=;
        b=A8jYzxEI4m2mhzNuRzp0kROhMGyTPqtXWc7Q5Rkd24BNFYzwFNSzKTMUz8vW6dmw45
         a4gUa1+M3wSWHqYS3yTS5KAo7b8xtaebb5x9RwW55H0/U0ulN912M/C4nC0DS4fx+VtA
         A9fph7L3HhvxcHdweOmppNUSoMC6DFijOVo79V/Q7Apmvc+VHP982DdzVqb4ALoF3tzQ
         VMhnwIlt/ry8lwom7+GVWBLSuuD2FdBV1boQ0ZGf578QU84tFH4Is2f16YtUeXTtjy3O
         2iRWnm3B8ckkQsTm23avQtKJhjvHZdKU/uojtvFgVv94z0k/4JgkPQV/dw/9vnJufyfV
         pnWQ==
X-Gm-Message-State: AOAM532kViykIoLSfEV07ba223Xt9zBA3Qaacp4LF6+HWzuO0c37T4pr
        odeRfYSN1Hwkg3saeng56uaxzoMEjCoXyYhYpniiMt4kp3Wi8g==
X-Google-Smtp-Source: ABdhPJyhzPuLwNsBebwgTA81c5oiVB2MMb6X44fzgGDOPMpseUgE2CKh6YfEhCY/d71/Igv8qwEQo7WS4vH0ZS4qFYM=
X-Received: by 2002:a05:6808:246:: with SMTP id m6mr2396315oie.151.1602856460268;
 Fri, 16 Oct 2020 06:54:20 -0700 (PDT)
MIME-Version: 1.0
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Fri, 16 Oct 2020 14:54:06 +0100
Message-ID: <CAN8Z4-Up+rbmxStTXpO32LruT_ysSy8NpK-0ca_oUhqree5MaQ@mail.gmail.com>
Subject: global config for default clone filter
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi friends,

What do you think of the feature idea for making a default `--filter`
configurable via global `.gitconfig` configuration. If I know that the
servers I typically access support partial clone,
and I'd like to do partial clones by default - it might be nice to
make that default filter
configuration something I can place in my ~/.gitconfig.

Thanks
--Nipunn
