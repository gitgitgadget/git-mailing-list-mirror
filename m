Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A3C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 10:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AAE613BE
	for <git@archiver.kernel.org>; Tue,  4 May 2021 10:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhEDKdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 06:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhEDKdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 06:33:51 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECF8C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 03:32:56 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z24so4566098ioj.7
        for <git@vger.kernel.org>; Tue, 04 May 2021 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WlqWSjYk4PxJIFuRp3QhnThDjcuHDwzHdvl+sX1FPhs=;
        b=IDoN579/gVaUE2ReGw+ROSMbEB60h5Hb8DepOlf4grvB6H+Pe2b02GMr9sWIthOFo/
         Z3nSat0/fdK5DTM4zgBPzcIqtEAaH86em7BdDh1+hXf9qkkVJJCF4PmR0CO3uULHZmY+
         RGbp1alHkGG7caT4C4wU1nLuEbjM1MVC01O+gvsPXNefxGwASijuxWbscPmTlWlcNJpH
         DbCrMpJES37GRfXZxJGLUhtA3yrY7r0l0G6cyCvntZRS5MeNNFeBQx34pmnzjRylyHav
         5JNNRdG3ImEr+QwM3IfnmCbE/Cc6L64xtQyyLK55ZEw/+Ac4RgDgxOkLwPaIchO/x9Ej
         QAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WlqWSjYk4PxJIFuRp3QhnThDjcuHDwzHdvl+sX1FPhs=;
        b=SR5LusM1AXlgFjzpZIQ3QL0/OHEBRHprM4hoNWSWuJ2tj3ctCSVsFu5QaFVXU7Cpkv
         KciULw31UUkq5kBtACvok8OZEbDoj6v8hZjqtm7r4c2e7bDjLJmBZ1tIFXsFuodbnvfm
         DMG0GUOWqRwVkhfg/eDWFPqWvG07Cd5HjpI2bburhJoyBdN2GuhzsKHrqzVNv7oWeDEt
         QBpTBOjB8tyckp8hZK1DIS97RSjPlBfziu8f+qoaKDlKNUptLMJ9ikji/nQGCiGGOfzi
         fFZgKL6G01OgEi4AbJRRVSEr6BO6uX9x4OcjdH/ZtDmf6ntHIPf1q3x88iiU4DQla4Tq
         0SKw==
X-Gm-Message-State: AOAM533zbhpTQpL4BeMSRThpLyYb3AzGyUcMdkES5xWM+It1Wyp7cxGo
        9TNHaMWQK6dPmgATDDzj0Bkjx7mGBBSdv4UDZ0ZPshsf4JW3XQ==
X-Google-Smtp-Source: ABdhPJwh2CCdGHDAqvVIHynVEE3jJ/r9GYA18YvVGLpIYvgGNZbtwI2/cFcb+Z7ZuJS2x/K8kp/K/jHcN7/BGWMMS/4=
X-Received: by 2002:a6b:5a19:: with SMTP id o25mr15168847iob.145.1620124375554;
 Tue, 04 May 2021 03:32:55 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?G=C3=A1bor_Farkas?= <gabor.farkas@gmail.com>
Date:   Tue, 4 May 2021 12:32:44 +0200
Message-ID: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
Subject: git switch/restore, still experimental?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,

the "git switch" and "git restore" commands were released two years
ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
BEHAVIOR MAY CHANGE.".

i'd love to use them, but this warning gives me pause, perhaps i
should wait until it stops being experimental, i worry that it might
change in behavior unexpectedly and cause problems for me.

considering that they were released two years ago, could the
experimental-warning be removed now?

thanks,
gabor
