Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D46C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 20:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8422022C7E
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 20:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404197AbhAKUXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 15:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389284AbhAKUXn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 15:23:43 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE6C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 12:23:03 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id d203so732426oia.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 12:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpXkOnut7iytBXwQ/GB3UhTM8tqnJzSlLhcKd7jermk=;
        b=EWE0nzmQs9y8muwN98YhACwnvJLUuJuL7P66O1UECk5n9FJUY0Hef4bx5FGcT6/9of
         0nW7Y8i8vR6n8UbWvOD0yp4PuIQ2p4eCno5WM+iZieH0t6LFSmqU8O+dwWodc0aBeayZ
         ODjQykQCKcwDsDMnAcjAwAWpOyf+wCyGHAwHFVpE1AyO1ejlPGMDIoiThdlkVHTVJcvV
         4E+w3+9FKja1JJzUKissOG+kJO07cu/6HHHD0BZD6xiveY+MIZyLefMDv9+1+eM+Qseo
         7CqMypg6Ho6uHuNk74yd90OlSV6AuqZDp6dqxgf/xEq0DZBALdT3t/IFd5772+Bacos4
         FLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpXkOnut7iytBXwQ/GB3UhTM8tqnJzSlLhcKd7jermk=;
        b=dXwGpKwdugbxv8dkUyG10p7twJ2LBEbcYPtjgYnGsZrBQ072qtWajHvD6srzfCVwKS
         PQPcrcEadiadXtvQxmdDFgtaX77ZWJL3KXtbnVJuIAB2sKmWGnaixQ+Y5qYz5aapnLPr
         lnDoVOhVhwumyKhdCWg1yycgzEf1Ml7NOKsaia9V1sNgE8xLpetc5yA3EboZ87Up1iMl
         tb2W84Ee8651tcKQuKHUcFr/a9N+6eLI/jwp/yoFw7x3yKc5u8fMYjmKdnKM+Io+dCjw
         Av+4iDZMVk6zQPRF/klMExVHtZA5QjzcoQy/TRq73jybISAUBaM2a+92cHiu5ouUJHNP
         SoyA==
X-Gm-Message-State: AOAM533FsX0hyE+hqqyhCwtz7Xv2ZWHe3yQve9A4eV1vW/sNa+XR7Rrk
        P1BcvR6BmQhZeNO8M0i3b3KaRGZjood02lj5xw8=
X-Google-Smtp-Source: ABdhPJxFALhf3G+nkpon5tBUP9GOa9esqrTf+tikck8XCzRHixAlROrvGmjJFKmnjRz+YhTnE5+2x2wMPnF8cwjx2ow=
X-Received: by 2002:aca:3145:: with SMTP id x66mr347822oix.29.1610396582602;
 Mon, 11 Jan 2021 12:23:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
 <pull.820.v5.git.1608609498.gitgitgadget@gmail.com> <xmqq1rfijpyf.fsf@gitster.c.googlers.com>
 <CAN8Z4-VQJsXWmJPNg0Fdu98csK7ZQ0yDNzxPqRhsbuw9CUJjnw@mail.gmail.com> <xmqq8s9o5aza.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8s9o5aza.fsf@gitster.c.googlers.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Mon, 11 Jan 2021 20:22:51 +0000
Message-ID: <CAN8Z4-UpQzvQguhEqwCJHVZ_0phOXtGouHFNFNwa8jwSpugxSw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] negative-refspec: fix segfault on : refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Eventually by backporting, but a fix typically goes to the current
> development track first so it would happen after 2.30 is finished, I
> would think.

I wanted to bump this idea - now that it appears that 2.30 is complete
and the new maint branch. Given that this patch makes matching-refspec
unusable in 2.29, would it make sense to backport a fix to the 2.29
release? If that seems risky/unwanted, is there some practice of
documenting known (serious) bugs in past releases?

Thanks
--Nipunn
