Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1818C35DF8
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 07:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A1922464
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 07:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghbwH5f9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgBYHb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:31:57 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]:35284 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbgBYHb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 02:31:57 -0500
Received: by mail-qv1-f49.google.com with SMTP id u10so5313876qvi.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 23:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=A94i6Ip9oMUjLIOiBugEp1CGrUzuN+EfbzimPo6r0Wo=;
        b=ghbwH5f9fQ+YfkNIYp+mE3wDzLxIQ/EolO9s7srwwarp0n+aPnD3KrhGhjcFJDaYo6
         +L2CCIN/NvHOqsZyYPWnaQ25PpkliWS9KWLjtA0xM9A6nSPlTAhwGdWiFwz5zeq7sSpc
         YFnS9lAqDT97wANP9MZCjVTOTgBtPboelbow8Po+dUQR1kkgmjTFu85b8gKpMElO65SC
         HOCs0L4B6x8A13L1/WkijNCXIlWll409DrIi/4B+x8HBOkYHBgK2uOR0lDbMV13QSp5L
         DGiYoGx3+bhUN1H14hHSjU8U5atoj72DZIFT9klg4oXmxANsqwuDQmBktuGNJe1KPmRO
         pVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=A94i6Ip9oMUjLIOiBugEp1CGrUzuN+EfbzimPo6r0Wo=;
        b=LA7e3VkjzvaTb2TubNX4eo6b2l9rxXb7dsNBv21qZOy9KKNGekfBGoKYcHJUrZxiWQ
         3aInvCmyr8XBDI0YGtO1YRY+4EAc0U4Ws9KJvVwNrdziqzcFZ9EbH6rsGie+cK/tioDJ
         BDPZ2qX/w42InvWu0ZmnxBwxDktRskQCLkXVqaHobdGYaxwVi157azQ1AtXcnkWqZej2
         gVjaDV5ABsq+AvsYhaxX7SJJlLRZWfIz3xgrVaFAnPz5UJwHKM/4YTDkBtd/cpcHxWQo
         KIbRPdsHPlJKe2yfFB2kaIY6v3t++Z9vOqFg7ruYDA0reiX/PlZvINQPlAw/WbFomjTw
         33WQ==
X-Gm-Message-State: APjAAAXtMsLWWt3c1U12zFFnvEEUjjHxfJFH2us2GhInncbqfvrRTRNf
        Kc6vxOiQ7uEi9OcAXRiMwrVyiJojHYqJiuUZfK8=
X-Google-Smtp-Source: APXvYqzGkxn54tFlbCpz73mlgp2XPVvQv2zEKiK0fdJLtzHnSE/U9NeXWFTbrIHAv7tt0snmXMqDrrKX5jF5yKC1QKc=
X-Received: by 2002:a05:6214:a48:: with SMTP id ee8mr49877363qvb.90.1582615916346;
 Mon, 24 Feb 2020 23:31:56 -0800 (PST)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Tue, 25 Feb 2020 13:00:00 +0530
Message-ID: <CAHk66fuLF3KVHtm_JOCdLJwmd2aETGz1HwWN7nsz9xDO5qne0g@mail.gmail.com>
Subject: Re: [GSoC Patch v3 1/2] lib-log-graph: consolidate test_cmp_graph logic
To:     gitster@pobox.com
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This round looks quite polished.  I'll queue after massaging the log
> message of the first step.
>
> Thanks.

Thank you for your time and reviews. I am pretty excited right now :)
