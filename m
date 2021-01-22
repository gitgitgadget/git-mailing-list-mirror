Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16EBC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4EB23AA1
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbhAVWpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbhAVWoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 17:44:46 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD4C0613D6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 14:44:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c2so8074213edr.11
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 14:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSB5+hdRI2P9TOjhDokzof6x3JUIE61mwTNvH4XDfMs=;
        b=tOq5phgtPJQ3x2NYI0k6EpnZzi5Ta1pzsbqbK5RyeOV53sc9AHBhBfqtX1btuSc2Y+
         /LT8KJPOBk4J+im3+mS0Idw9cy93kg/4XYmtsU5srj+pUyadKZ2k4gzNFItpkshoaov4
         iFO03omRyku/+QNBRmFjkmCNxtPLp3l5WvAcHfZjjf456rz9XUe5DEp2krNaVvTZjyAl
         W0ubWG+6ensvaT9O1X4Yb9JmQIuBjyhcxuAKpnN/jPU3nIcdpB30vwpfVcxrk7u00bYS
         aD7f/F4glX5ASB2asC5PdErKkcxO4oHMHxdj24Cxl5yRfo/fFSZKYH+swobqn+scetlm
         IUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSB5+hdRI2P9TOjhDokzof6x3JUIE61mwTNvH4XDfMs=;
        b=kmJ/LS4x+YS7wUwdesvciv4QJDQN8e9Yjryh1FNlDpq3nIE85QNqZVlClvUDhfi/Wf
         2ZNltffVybaGTPPwA4ac/4k7iZBVwtSIncmzauafAsoyvnKxiAjLZzrkFFKR+4UK7+Uy
         KW05hyx2YhJ2vSpqUIQD2tbao3qE1mSgiO+RpLmhbjoWe9F1eHV+32o+hIPrfrwQOXzf
         0SPY16KmickdDTbUWWP1EMCp8/5oO1D181yuG09cocQCId6mayjEqPRUBKJkM3cUF9mt
         eb82E1sz8qYM6gj85L4I6WWz+s9sDZRao7fhHzrVy3IwtuHqq1JOS18zKAYQ1foe9/2l
         J/Tw==
X-Gm-Message-State: AOAM531YODBxiCSYxB9Bx0JUIg5NQG2PjO8zxMYuoO7VFPHS1NnplGCn
        v23ZAMwUrXsCLuK6uzp6+bG4uaOleL45xT/55s4=
X-Google-Smtp-Source: ABdhPJygfFiSYho/Vn6nokbbzY+Wb0EXIJey3v1koKfqI5IEbUYlPpcTooKRr2VcvYQBJrMZhZB4ZZDUE6b7R4tuD80=
X-Received: by 2002:aa7:d306:: with SMTP id p6mr5037219edq.351.1611355444401;
 Fri, 22 Jan 2021 14:44:04 -0800 (PST)
MIME-Version: 1.0
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
 <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com> <xmqqpn1w95dj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn1w95dj.fsf@gitster.c.googlers.com>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Fri, 22 Jan 2021 12:43:53 -1000
Message-ID: <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
Subject: Re: Can git change?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        "Patricia B. C." <pati.camsky@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 9:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> *1* subtree merging of gitk and git-gui, for an example, and having
>     an octopus merge in the history is another.

This is probably quite off topic for the thread, but I'm curious why
you think it was a bad idea to have octopus merges in git.git's
history (there seem to be 37 of them).
