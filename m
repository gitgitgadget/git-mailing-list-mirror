Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8FDC433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 09:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B38764DE5
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 09:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBVJOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 04:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBVJN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 04:13:28 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C37C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 01:12:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 201so3093895pfw.5
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 01:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iLpw9q31TuOCD2K9+MxKgnX2T2+/KoIZXQLwtsvYdrk=;
        b=vXbHkmRM2z4iL1KkwbGEBky1Y//aq6XjFtlSXoMwVZFKnGCAe5QzZrIN8IzKB1ohx0
         H8b6+Xy4okWUsEHzzFMPbblzFmoKOr4j4Ng788BjPUTdKP3Kb710MMPodWjcGIGnKpFG
         3sDdRB0K9tpEpuwdvT08FH2XPUUG0db9JclgjSMPlXEZMDTasSIOZMWDr1LUY79rgWXi
         8GM+Bl8FO73Ei5YCG3pwXrAqu4JJTIueD2Bu0zwdw/RR5jFr/G+LS98dxViWT2WvT1SJ
         orGm+CjcuPiivGFu/8bwRLCmI+pbqo6D2vs0jprLxkfN6fiCg7D98vHy/Qb3Of0dCuz3
         KjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iLpw9q31TuOCD2K9+MxKgnX2T2+/KoIZXQLwtsvYdrk=;
        b=QEybMCI+xdCHGJUahU6Z3taMY+CLPTiCX3xsznUKPgXEM1sJyBvl8X1NqNkAG1bZpg
         80lKP2w/j/XzVMQR31Lyd8rF1GxxPRn6z1In8PI9Xw0GEhUcAvjQrMgCGtRtHsWm7A/J
         RJoxTBGibT5PR/Ng2GMJ7TTedaJNWqA7FTqNufXaotQUk+mZBo8q55qSeIYArCZ98zsU
         NX/HYsNmlwpCp+wCNBUN+xvKbhgPtWQjjWtLnERSrbPR2imli0PFX3Je6PeEp4LrwAOq
         FB67KJxMnTGeDhoPk9jVdApaaOjwzldC6imhenQS8KSOhDOqScNBYXN5xPZIKQ5mPUbj
         Ilpw==
X-Gm-Message-State: AOAM530mo1tyXbWLNEKY/6hlUAbycvP8UjuDI0p4+uMAJefb65IHLB++
        CabCmWt2SSA5Kv1nHyjjAU9K8mKG4BO0CBnWQpmEuhkR7QvxSQ==
X-Google-Smtp-Source: ABdhPJzoCAtSUYOmkaTwt7sasANA1AWe24/L4E7ujJmXzFW913w1SuZHtW+XPBuvwi56vx4p/F+RyBF6ZrsHokyz4ZU=
X-Received: by 2002:a63:d506:: with SMTP id c6mr19061849pgg.77.1613985166818;
 Mon, 22 Feb 2021 01:12:46 -0800 (PST)
MIME-Version: 1.0
From:   Yaron Wittenstein <yaron.wittenstein@gmail.com>
Date:   Mon, 22 Feb 2021 11:12:11 +0200
Message-ID: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
Subject: [QUESTION] Tracking HEAD changes?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Is there any possible way to track changes to HEAD using hooks?

Being able to listen using hooks to events such as pre-head-checkout
and post-head-checkout would be the best option (from my perspective).

To my knowledge, the only possible way to do that today is by adding a
file watch over the refs directory.

Thank you!
    Yaron
