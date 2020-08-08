Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21EC433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 08:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0618F2075D
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 08:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgTLg8LZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgHHIs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgHHIsz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 04:48:55 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E8C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 01:48:55 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u15so1072459uau.10
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPDRb8zGbVm1JcOe67r9EyEaJovIdXQW6Gg+QeGL55M=;
        b=mgTLg8LZh+8xC8vCFpv7Z8yRF8g8T2oCk58yQzzUrCMBDJ6PVCPYb7Sni9jo1I6M0A
         9fSmn8pbW9mrqjEG3q1bANTMWtZCL9Te/F06I/mkBNl+wcWZ0cMQFMverRlSAx6fYdaC
         r8Jw9ihD7TXRLozsQWMoNYfC+l6VB/Js6KfCr04YQv+eRHvbor9JBYMkNjf5auMEiWON
         /mgj/NBxCPI1Ej5ivAoUeE2lrQuMP68yJlRqMBDaR0p3k7MgXmAopAzUGtjD4RD1Pkqu
         dn1gPGLac9sCsC+yTz1+hisaX96+r/pGKEE+fR3Pqt3JgXTblaWJ4QPjXuklgp1vccZy
         b8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPDRb8zGbVm1JcOe67r9EyEaJovIdXQW6Gg+QeGL55M=;
        b=aKEwmBAixBpv42D0wjL2tN+V1+Rk5CCNrn+Pw0AuXSaHnxBzDIlCPTEjzK7bwSkN7W
         BawOuupePxx1gH1UQgLZcfH2QqnQPlcYuJAjZi5o5GqDFEAe66HZ/GLkKvAYoaNOpRnb
         9TxpRPT7gKQU4mpy6mJgeckB6LDdoigEjgskoip1NUBHMJD9mE4dUxlD8DNdacpdcS0e
         KgoONxUOrGXIY5dx1jFdd4JSKGGtOT87/S4+yB2NvV5G9gV7FGtBGi/vaI0QHaRQXsE3
         eIZCtL6bnAumbPi9Va58+D4xG41buSgd/lJzQ7Ot2zREgJaDMrMo+qk1BIGsg6zQJw8O
         m8Eg==
X-Gm-Message-State: AOAM530+ShDzb7MhuqAvqp0ffnalbap3XuwiLIF8hyQwnAsnBPQz4u9G
        fvpRnirs3TyCs6mqIuuyx5s5qd5L2MpuMp+VK/kgdR1wIlI=
X-Google-Smtp-Source: ABdhPJzzLkWKCKYk443Zhr/l2zjdTtAfkebghzS8/6Edd98b6fjJoZ0fJoJJD/a+DmBDZu0I2FZhOsZnDHMPMkELZSg=
X-Received: by 2002:ab0:7458:: with SMTP id p24mr9444838uaq.112.1596876532297;
 Sat, 08 Aug 2020 01:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200806060119.74587-1-ray@ameretat.dev> <20200808075323.36041-1-ray@ameretat.dev>
In-Reply-To: <20200808075323.36041-1-ray@ameretat.dev>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 8 Aug 2020 10:48:40 +0200
Message-ID: <CAN0heSoVs+ApvanSOGZJeOvy5DNEMrMAZ41BKUkchmfVE2kTjg@mail.gmail.com>
Subject: Re: [PATCH 1/1] diff-lib: use worktree mode in diffs from i-t-a entries
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 8 Aug 2020 at 09:55, Raymond E. Pasco <ray@ameretat.dev> wrote:
>
> When creating "new file" diffs against i-t-a index entries, diff-lib
> erroneously used the mode of the cache entry rather than the mode of the
> file in the worktree. This changes run_diff_files() to correctly use the
> mode of the worktree file in this case.

Good catch!

Describing the current state of affairs and using imperative mode, it
could be something like:

  When creating "new file" diffs against i-t-a index entries, diff-lib
  erroneously uses the mode of the cache entry rather than the mode of
  the file in the worktree. Change run_diff_files() to correctly use the
  mode of the worktree file in this case.

More importantly:

I can confirm that the bug is there before your patch and that your
patch fixes it. Could you add a test in this patch so we can trust that
this stays fixed?

Martin
