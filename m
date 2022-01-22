Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C495C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 09:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiAVJHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 04:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiAVJHK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 04:07:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EBCC06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 01:07:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id i1so1206831pla.0
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 01:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rooden-ee.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=vu+eUjiFYrDPLZc8bJOtihvS8csmlX91nS4GUmaalO8=;
        b=LgLFaGeeOcCAQSAnZNGC9HYyHsnrWTXqnQQVcOMGlNUieLf0MnuH6EL6XM7w1QSBql
         fYFlARcYP/jTx+qCuz4Wu/ijbN++Zobm/QnmhYzlkj7TpIZ6kWtd289iATUzIzwnzTXf
         tUNwVLeSG3jup8sqLF+4xJjcCTT61UD6tu7godhbpfYd/NrSQ4Jpi2U4NBJUkE8zLSwT
         cxcdwXMiC+e5qe4Yte9xytHwbynxZeOa31gkgYkDmk5oGn+HFfYF3uWLo5mBnJNnhM1Q
         Pcsaj4374ZBn6FJo4qvZb6OV36IwsnuEboQfcEJnyRKBubmLYx1IulNVayxLXgMZrDFd
         /fCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=vu+eUjiFYrDPLZc8bJOtihvS8csmlX91nS4GUmaalO8=;
        b=b8ZMqfmmckj4C/8v1X5lv132Gx+f3kxmrko5kLa+J3WKpi1qWgLsL/bfzinBY5y36E
         50ICDy1L1xKrfmdt8awUpQ9FmKi1qym2QymY29Mffv2U8TsqvJXrs15NxLxXaHdNuQ+j
         5qXcnPkXpyky2CKd16yv8YNDj9yCYBkVC/6bNeQlMCxv/3gTCCX8guV8rEeOOpgdAqOo
         A2PWaUka0cnTnUwPevi/fVKFZvtCjPX7u9x1QifMC8APHsUHAbk30Y/Pdq3rQDoLgFYC
         BusUz7aDOCyO1ER+yspxwtx1TtDNYayNZ1aHW2bpb9+ea+6nqLehrlehUq5I6suifX9L
         TG7A==
X-Gm-Message-State: AOAM531ssEfdBo/pvJRo5j9M89QsjPHxp001Jalub5La7GdgyVx/A6ZA
        XfSyb1UBtKXMUTOfd1dYp8DSgqVC1S42XM74HVyggRcH/5M=
X-Google-Smtp-Source: ABdhPJxA4Yn5VNuCbkSM0StpvBpwH5UJO0DZeCoBijx9TgDqCiohRlCiiEBnzBg3YBLI1yVLAPEy6yjb0X40BIKtIH0=
X-Received: by 2002:a17:90b:1bc3:: with SMTP id oa3mr4403216pjb.131.1642842429461;
 Sat, 22 Jan 2022 01:07:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHqym3xs_M7BvvFDq2pHM-+DgK_nJcBakVEBL-GiNwnCRzMwWA@mail.gmail.com>
 <xmqqv8yceldw.fsf@gitster.g>
In-Reply-To: <xmqqv8yceldw.fsf@gitster.g>
From:   Lauri Rooden <lauri@rooden.ee>
Date:   Sat, 22 Jan 2022 11:06:58 +0200
Message-ID: <CAHqym3zW1U5ovFYCzhZesorR5EcF6TS8mUuMmSwUNPiUZX=N5A@mail.gmail.com>
Subject: Re: Strange checkout with GIT_WORK_TREE
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Brian and Junio for the extensive explanation!

Now all makes sense and the new (for me) "git worktree" feature seems promising.

I wanted to have $GIT_COPY without .git folder but a .git file does
not bother me.

Previously I have checkouted one file this way and then it seemed to work,
confusion raised when I tried to switsh to full repo checkout.
