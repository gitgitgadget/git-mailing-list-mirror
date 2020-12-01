Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A23AC83014
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A012151B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikthlshk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404383AbgLATaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404330AbgLATaG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 14:30:06 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78183C0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 11:29:16 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id b190so720794vka.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 11:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QCWZrCQF9uYVfvmFRYGTqDFuyw9bqA5fM0x88uK1/ZQ=;
        b=ikthlshkzgeNvGFhmtDf9eR/ZKQNjt8LH2OWPLRLQDCI+8QU3gi0Iuk+Yei8dIs/Z8
         Zx+x2ZoE82THc8JQ0ATnSQH5EQE9KHYW1Zexgoh23MqCkK77z63Ao5Gv+O1ew/zdY7ji
         DFIM/zxFBBqxnjvTpkvzDc5C+6e5XRNnEYjGeVE378GPsshBrBz5Blp2SkWnl7sWb2I0
         vieedCWJQLUWU4t8j1SH9KYkFMRtjLGNlilcJL/vPGDjH5D1phSrrTLH9qMnMg3LMGVg
         8ZBEK23dlMBwLKvFLJpVT617j3F4czuQc7o9tP5qJstkcKvcgl0amai/qD7zZk5sY9IV
         Rqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QCWZrCQF9uYVfvmFRYGTqDFuyw9bqA5fM0x88uK1/ZQ=;
        b=OFG8GFkAIQeRCvynuXAFa9rzXT/OdJA6UM9AjxqJZVmp6Ec3wWGy34u/10H6eWI8Au
         ocNICfNbosHPYv92HY9Dh2BzpbW0xkT7BU0dppUa6gMx6G46OZ4PlzfCjmH2f2eVFIc6
         2vM2I/nHFjFUlju8wXYCuBKwS4Qa1K5zRLh/eBcOd/743gh1l18s4JS8YGb0ll9vcPZR
         mnH+0+UuzTxfLmcgMu4AlHDwOLVpFqXjbCEnD2cWLGGgaLadsP98NjS16DVl+znKIdQR
         TCFiykoircE1YMEHIIwDEcf/RgkhCYVjzZfe49qBWxsgfTuMo84Xi1LMKcsYjUM0pZou
         vQug==
X-Gm-Message-State: AOAM530Ak8DodkUYRd6VQJUt/CelvB2adJeT0khfP2qIXRE3ATfPyc0Q
        sz1fe5HKl05wJaE8lpY5RuC2tW//BLmVBCBf1s0=
X-Google-Smtp-Source: ABdhPJwultNq+WLa7Gdx+G3sUq6Rqu49sr2LqR5ilLWt4jZOIpO8Abhka4ChyJiu6UIvuqO+KC3wWFffo5axVVy7XP4=
X-Received: by 2002:a1f:5587:: with SMTP id j129mr4321891vkb.0.1606850955788;
 Tue, 01 Dec 2020 11:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20201201121051.186050-1-stepnem@gmail.com>
In-Reply-To: <20201201121051.186050-1-stepnem@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 1 Dec 2020 20:29:03 +0100
Message-ID: <CAN0heSpj7hkpy_wXk5hDa0v21a6sMw8RhqsHQBrUf5Up1xwguA@mail.gmail.com>
Subject: Re: [PATCH] config.txt: fix a typo (backslash != backquote)
To:     =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 1 Dec 2020 at 13:12, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmai=
l.com> wrote:
>  A line that defines a value can be continued to the next line by
> -ending it with a `\`; the backquote and the end-of-line are
> +ending it with a `\`; the backslash and the end-of-line are
>  stripped.  Leading whitespaces after 'name =3D', the remainder of the

Heh. The backslash is put inside backquotes for rendering as monospace,
so I can see how that happened. This change makes sense to me.

Martin
