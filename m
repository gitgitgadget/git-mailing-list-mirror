Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7129C433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 01:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA0220810
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 01:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFnl6SQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgFABd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 21:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFABd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 21:33:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB32C061A0E
        for <git@vger.kernel.org>; Sun, 31 May 2020 18:33:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id o9so6140783ljj.6
        for <git@vger.kernel.org>; Sun, 31 May 2020 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JH9VDtKF5vMIPjMyahGENeIeGpNpEiJ7rWt9Oghx8cM=;
        b=KFnl6SQJpV9+9nTYW5K1E9UIgqa1Ug6NApnpF9Yq8WR5gbs3gHR4u38Z6oFsCGd7U0
         PQG5gEbWGCcb5ywAQrbN49iqkAJgkvkWFOUK/gePkrt7o7jDsPMWBDVg1Cwy25oQYUYo
         BBygG4QmWUUVdS/eHTYR+TIFBPkbVmtJVCQPxEslLkBAvVN1yKTMtLpybO4tKKDXPssg
         tgP5B6xiLHwFcLXmKgDZ7KHNOG75ruZW44iZ1rJlMwYavWZG18HkikK/W8ucNQlvIWM5
         zjdH/kyHvxCqWB76njeX5QCgNWyvT2SM3YixNo71yewrx4nj+LE22b8vRCQjC55z26Wu
         2O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JH9VDtKF5vMIPjMyahGENeIeGpNpEiJ7rWt9Oghx8cM=;
        b=oHySZv5PGWY2n+5QbeMqKFAM2I61JlPYAMs00yv9AtYxf8Hb3wRiTzTO4oEnyV1GsB
         zHVLwsc25r9fFWGlU2PMldpDxf868bwGApQFYMC/7jBZEmc5F9KZh/PULK2xYhVkNrZF
         z1IMoeyiDAmizyBZqSg8lgQB1vqdT/D9x/aC33eLVLa8zU7OfTDe94pu0fsP5YhgeUgO
         9zo9OqzvbYUDHHQ3SJdjw3yhOC2PLk46zkpujauQYZno/9uXO+ZJBJFnnrGEqbPJKkRc
         3PZ73hLlByJpc8IDabnak5WyjGaiyTinhgaY5jODUx14XymFgEZfK4WN078mz8CUfgj3
         sBXg==
X-Gm-Message-State: AOAM531lddYfth+JpdEtCIrs/JWnruewZan1aMmsT2uMgr6dFSdSpzfB
        uQECr9nptkDJWJx5pnEfajUDglvtzkOxYQgojG4=
X-Google-Smtp-Source: ABdhPJwXVLmUp3L1qkZ0mSSlWY31iL4VKhjWfCPy6/288fO/Keyqi0VSBWfzKfaqv5TwSOHICmarfLan0hb5Mup1UDk=
X-Received: by 2002:a2e:8e99:: with SMTP id z25mr9528976ljk.142.1590975235894;
 Sun, 31 May 2020 18:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200502184825.26707-1-wsa@kernel.org> <20200502184825.26707-2-wsa@kernel.org>
In-Reply-To: <20200502184825.26707-2-wsa@kernel.org>
From:   Jonas Fonseca <jonas.fonseca@gmail.com>
Date:   Sun, 31 May 2020 21:33:44 -0400
Message-ID: <CAFuPQ1+3NY1XRwRV6UK0+8u-uwZ0+m6P3OTUGsWCcSz77+otiQ@mail.gmail.com>
Subject: Re: [PATCH RESEND tig 2/2] Drop unneeded '!' in docs
To:     Wolfram Sang <wsa@kernel.org>
Cc:     git <git@vger.kernel.org>,
        Thomas Koutcher <thomas.koutcher@online.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 2, 2020 at 2:48 PM Wolfram Sang <wsa@kernel.org> wrote:
>
> Since commit 99d8d00 ("User-defined commands no longer need to be
> prefixed with '!'"), we don't need it anymore. Also, remove a
> superfluous comment.

Thanks a lot for the two doc improvements!

-- 
Jonas Fonseca
