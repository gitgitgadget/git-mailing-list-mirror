Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16A1C433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 07:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E90C60EE0
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 07:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbhIRHEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 03:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbhIRHEx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 03:04:53 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B1C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 00:03:30 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id f24so7520914uav.8
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYBstQGa0zzjBeBtH7e5172TkYyNjcRwNDfTGqDaEVg=;
        b=Q3Wc2wmn3cd0CgarwRl+g9M8JHWdi9QQ0qWVCCJChNjqizWk0sscYHJ+Zuj2EFtOK6
         ex7nUceQNEFOZ8fVQ5begIF+1IoSY/F7/U8EiVKcvzDku7rXKEfmMCYCTbIrXizDu1+/
         hdg1cqurAZvxLSqNcsjAGxLzU3frQsAb2vhr3E7F0pMJCVE5Tab7M3yFJE2ALqtdte0E
         dMRQBMQBoU3R9KJAlplh1RNIh6AZY3Rikc0tJ+l6ggkq/OAy+DJFNAZOVwWc5Eg+R5o6
         xozkt03XhDI8dMvZ6C0f+wtsY/j7wOZ1kaSbiseA8oHEu1lCc3gNvFSRCy4OX1jUH8tJ
         HYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYBstQGa0zzjBeBtH7e5172TkYyNjcRwNDfTGqDaEVg=;
        b=T5VfglKIuDaa8aM9zi5yn3405mqVJeDq6R/yaRK8JJQGowOP7J0/CfVzqWGeMPYSWe
         EQy1W43PrqUj42myZMaLjH2YeGGgsRfkQiXt1UukXR+0irSgx4nuKhnAmUi3s06yxIB+
         anOVGRwjV+DzeaXG2t6UjVeTW/kiKB10V3+ZwNf/0ApER2+Q0rhlYg3pB4Z2SI4ttCxz
         cV7wA++eVO8XnSJZRf7G4SAXJ4pkSpiRJTnveKMaFt79sa6nlYruLU4F5CSgCG2AnaMu
         cJjpAoUDSF0bRKXtjVyvik/a912f9jIsSTLhlz5iDsHb3G6kgFvmkQxoKoceayS/Syp3
         41yw==
X-Gm-Message-State: AOAM533WTIwshOHdZ7ooCPPTewaxZkOYKhVJ+ufMK5o8NYdXMRLXx+v7
        jajc1jQhEoW34fyQbrVNknJjFnD0X8598b9hEnA=
X-Google-Smtp-Source: ABdhPJzh4GRpZVMlcPQmNZdz7wWesFTrB63USzeh1W3y4313M5Goz/TNAJU30QKL4QVcTTi1+Fb4T+u7o2ORK49xskE=
X-Received: by 2002:ab0:3d13:: with SMTP id f19mr7566847uax.140.1631948609203;
 Sat, 18 Sep 2021 00:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <7de207828caa9e50906f39b955e39e9de2c1768f.1631738177.git.gitgitgadget@gmail.com>
 <xmqq5yv1wnuc.fsf@gitster.g> <93ebf97b-1282-8f39-6894-90e0ea2dc851@jeffhostetler.com>
In-Reply-To: <93ebf97b-1282-8f39-6894-90e0ea2dc851@jeffhostetler.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 18 Sep 2021 00:03:18 -0700
Message-ID: <CAPUEspioONCavBOhn6S4qkZ8tUk0ssuL3-JZG9RvUbJAHd10Pg@mail.gmail.com>
Subject: Re: [PATCH 3/7] simple-ipc: move definition of ipc_active_state
 outside of ifdef
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 11:39 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> Maybe.  I'll make a note to ask @dscho when he gets back from vacation.

I am actually more worried about GGG introducing a typo in my flawless
commit message.

Carlo
