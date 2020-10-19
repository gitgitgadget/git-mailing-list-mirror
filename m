Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1500FC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 23:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADC52240C
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 23:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI4PKr53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJSXC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 19:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgJSXC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 19:02:26 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ABAC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 16:02:26 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l85so1897025oih.10
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejAoGujEqKUGpIHQprqLYQ3pGfZ6zA67Fey1vRGpNDk=;
        b=HI4PKr53I2xHSeOgdXSSQAMz8tSPY9TLmgGyP7MGGCOuCC1X/uk3551yHDTo3XYmsR
         oGLpHwPys8GwwckIq0lfbVBzaG/chWjrA2XD5STmwAFEth0TF96k/tirOVXI6SRII/aA
         fQpyiABGEkixNNG2w4Y8JyS+A23uEsqOJux0bSFFdySq/6IQ56++8S4JlgGmu0AFAATl
         apIlvpQdaupoDhDdLClBWk4e2GmaQhrEs2ydWtJ+7Znr06Oef5sDL8la5aJF4fuyiySv
         xyxfGAGSrdpy7aL1dej0HggHYv9wBVUtTK1PUkD4XeUvkyJLzVfscfT+DhLjFyfgL9Mj
         40RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejAoGujEqKUGpIHQprqLYQ3pGfZ6zA67Fey1vRGpNDk=;
        b=LIgR0os0doUsC5r+PRrsdw+swLpQ6T2j245aVeyjl2qTaYOynzSEs1IjvOKQp7fIFf
         ZG+kaU8DXPS9tEAaQMdVV9jG5sNXyPToZUypHmijtjYhU0t3OHGSXDlPVKkvCISlbFtT
         ZOvPbjdm/mhjmxY7nmqxsutsoqbw3p/TQP5WGZCJ7zlgAxwvt8edIKUS7yscEG0lhqF4
         SXuwWPkjSksUQkfeLaB5L3TbTQnYeoUAwonNXwfAnZzijre1YG410yaCyepDpJShwN+b
         llVAWE3ke2OuTniaq2w00TuqRXbo5xqvuItoTy/Bd/OKXv5jBsfQaG7V0PnTHWeKwqAm
         QlDQ==
X-Gm-Message-State: AOAM53205O+EWoSbuitv742YK7DSU1BCOfwX94Z4A7ioLCmRP9Hp9XGE
        PgxvJonKBGHA/CqwrW5BrH46drXzSv0s25YvGXv5ajkocJSzTQ==
X-Google-Smtp-Source: ABdhPJzrHh8rpwbov/nTaXFyawsholL65lMIRmTxEn91tx2CpWI9HYB1MJ9GCjkeXG/Jf0Y5Clq3yYmePgDM1tywZgI=
X-Received: by 2002:aca:ec0d:: with SMTP id k13mr74261oih.93.1603148546004;
 Mon, 19 Oct 2020 16:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <pull.756.v3.git.1603147657.gitgitgadget@gmail.com> <d392a523f239f92f1b47ec1a96885f69fdc6d8b4.1603147657.git.gitgitgadget@gmail.com>
In-Reply-To: <d392a523f239f92f1b47ec1a96885f69fdc6d8b4.1603147657.git.gitgitgadget@gmail.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Tue, 20 Oct 2020 00:02:15 +0100
Message-ID: <CAN8Z4-UaVgU59uqyWvwG-+U5TKyhGn800gaayCpzM3kukTYBSQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] p7519-fsmonitor: add a git add benchmark
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually found a 25% improvement here on git add with this patch series
