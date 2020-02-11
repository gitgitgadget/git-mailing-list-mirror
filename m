Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375C4C352A4
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 00:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0323720708
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 00:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIKuXSHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBKAaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:30:35 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34499 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgBKAae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 19:30:34 -0500
Received: by mail-ua1-f67.google.com with SMTP id 1so3307934uao.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 16:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0VYRFVqV4gSaAOak0/8QmWISN2K/JKHt6lKehV7D3Q=;
        b=eIKuXSHO1wsyd8jJtVmoVGXaQkb8J6pHTYfnK4O6hKYiV19qOMKS/PCKwvAwerexQR
         W9JJ9kySVjYKiQ5Fp/mE5PjmjPP1a5KZZ6jFdPYm7nytlfEkqPwWkQm122LAhUvTEdR0
         P+vfntN8kQUenzjLKzEYQLZRcNZrLuRfkCZ8EEtW61uA0qGsx7nUwTu9RKXSR7kC02Ja
         9to8AdOh4R5GAauXnA7erNOaQBUNB0EiWxx9fBd84DxXnZZKnBX7sAmAK63RbpeuE3Ii
         jD9XuSn8YpsBxl+pfsc3972AEoLGJYBCAFpIUO4CH/XbFDCIPJq5y2lBQv1BBn16HOM2
         xMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0VYRFVqV4gSaAOak0/8QmWISN2K/JKHt6lKehV7D3Q=;
        b=ObS7jR+A3sebGaVVIS4X9nccm5pVYUU1BTk99Mq3gvBbkapoFYN4yxH0wT7mbVgowI
         5lB9nqtdJelmf3n+wjSYZdpgYW+uWlqR8GdRGW3JnOnNlOks3oDpVHX7MZWW1H+2rCU8
         CBDBOkeajFE6BdJngRrbqnQ8lfnhdwgbZ4RjELSr2t02bZmaiMtLErAFl4D7Rz1LgOGi
         LLQf4o4jUzk9sdKCo3uwqwYMBxjlUoLfQwCONojvmtzpfZ5eFxNxGr5/8u7dSIG0Df9C
         whWVrzSWLoTUgsKNTmJv6/XJzFoW9Zs6PkHxk4cYx4itQi/0qayHqdjVONBUe8zMLmRa
         +oAg==
X-Gm-Message-State: APjAAAXIFr4T/fLL3duHp/58OmOrUyBVg9pU9GhTdQ+glokPxC3B+EtP
        JQ1tcOPIBiy/jyHUO6t0GJM/yeteuX9zGlygMMI=
X-Google-Smtp-Source: APXvYqxuPMf6JCagJvJJWaGTSvfhrG7JOMmXqYc1xUNttTijJqSSiaEc7tRKzMLeY1hoa5sRc3mXLePUKM+DWbzboxk=
X-Received: by 2002:ab0:6341:: with SMTP id f1mr316583uap.74.1581381033917;
 Mon, 10 Feb 2020 16:30:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
 <pull.478.v7.git.1581294660.gitgitgadget@gmail.com> <14b0f278196ab9ab130402c2ef79adb0543655ef.1581294660.git.gitgitgadget@gmail.com>
 <xmqqd0am1fsc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0am1fsc.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Mon, 10 Feb 2020 19:30:22 -0500
Message-ID: <CAOjrSZvm-3qVw4880MeDVk59ToCwp9vMC1zFp-SYaDsFd3Y=8g@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] config: make scope_name non-static and rename it
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> How are you reviewing the patches in your own series before sending
> them out?  This round is better than the previous rounds where we
> didn't have a matching change to the tests so "make test" may not
> have passed in the middle of the series, though...
>

I went through each patch individually using rebase -i and built/tested it.
Although just to save time I only did t1300 and t1308 since I believe those were
the only ones that should be affected.  I can write a script that
would run the whole
test suite overnight for me and make sure the series shakes out okay,
if you'd like.
